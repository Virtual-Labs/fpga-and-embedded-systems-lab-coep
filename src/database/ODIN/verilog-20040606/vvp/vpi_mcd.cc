/*
 * Copyright (c) 2000 Stephen G. Tell <steve@telltronics.org>
 *
 *    This source code is free software; you can redistribute it
 *    and/or modify it in source code form under the terms of the GNU
 *    General Public License as published by the Free Software
 *    Foundation; either version 2 of the License, or (at your option)
 *    any later version.
 *
 *    This program is distributed in the hope that it will be useful,
 *    but WITHOUT ANY WARRANTY; without even the implied warranty of
 *    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *    GNU General Public License for more details.
 *
 *    You should have received a copy of the GNU General Public License
 *    along with this program; if not, write to the Free Software
 *    Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA
 */
#ifdef HAVE_CVS_IDENT
#ident "$Id: vpi_mcd.cc,v 1.11 2003/07/21 01:20:59 steve Exp $"
#endif

# include  "vpi_priv.h"
# include  <assert.h>
# include  <stdarg.h>
# include  <stdio.h>
# include  <stdlib.h>
# include  <string.h>

extern FILE* vpi_trace;

/*
 * This table keeps track of the MCD files. Note that there may be
 * only 31 such files, and mcd bit0 (32'h00_00_00_01) is the special
 * standard output file, which may be replicated to a logfile
 * depending on flags to the command line.
 */

/*
 * MCD/FD manipulation macros
 */
#define IS_MCD(mcd)	!((mcd)>>31&1)
#define FD_IDX(fd)	((fd)&~(1U<<31))
#define FD_MAX		32

struct mcd_entry {
	FILE *fp;
	char *filename;
};
static struct mcd_entry mcd_table[31];
static struct mcd_entry fd_table[FD_MAX];

static FILE* logfile;

/* Initialize mcd portion of vpi.  Must be called before
 * any vpi_mcd routines can be used.
 */
void vpi_mcd_init(FILE *log)
{
	mcd_table[0].fp = stdout;
	mcd_table[0].filename = "stdout";

	fd_table[0].fp = stdin;
	fd_table[0].filename = "stdin";
	fd_table[1].fp = stdout;
	fd_table[1].filename = "stdout";
	fd_table[2].fp = stderr;
	fd_table[2].filename = "stderr";

	logfile = log;
}

/*
 * close one or more channels.  we silently refuse to close the preopened ones.
 */
extern "C" PLI_UINT32 vpi_mcd_close(PLI_UINT32 mcd)
{
	int rc = 0;

	if (IS_MCD(mcd)) {
		for(int i = 1; i < 31; i++) {
			if(((mcd>>i) & 1) && mcd_table[i].fp) {
				if(fclose(mcd_table[i].fp)) rc |= 1<<i;	
				free(mcd_table[i].filename);
				mcd_table[i].fp = NULL;
				mcd_table[i].filename = NULL;
			} else {
				rc |= 1<<i;
			}
		}
	} else {
		unsigned idx = FD_IDX(mcd);
		if (idx > 2 && idx < FD_MAX && fd_table[idx].fp) {
			rc = fclose(fd_table[idx].fp);
			free(fd_table[idx].filename);
			fd_table[idx].fp = NULL;
			fd_table[idx].filename = NULL;
		}
	}
	return rc;
}

extern "C" char *vpi_mcd_name(PLI_UINT32 mcd)
{
	if (IS_MCD(mcd)) {
		for(int i = 0; i < 31; i++) {
			if((mcd>>i) & 1)
				return mcd_table[i].filename;
		}
	} else {
		unsigned idx = FD_IDX(mcd);
		if (idx < FD_MAX)
			return fd_table[idx].filename;
	}
	return NULL;
}

extern "C" PLI_UINT32 vpi_mcd_open(char *name)
{
	int i;

	for(i = 0; i < 31; i++) {
		if(mcd_table[i].filename == NULL)
			goto got_entry;
	}
	return 0;  /* too many open mcd's */

got_entry:
	mcd_table[i].fp = fopen(name, "w");
	if(mcd_table[i].fp == NULL)
		return 0;
	mcd_table[i].filename = strdup(name);

	if (vpi_trace) {
	      fprintf(vpi_trace, "vpi_mcd_open(%s) --> 0x%08x\n",
		      name, 1 << i);
	}

	return 1<<i;
}

extern "C" PLI_INT32
vpi_mcd_vprintf(PLI_UINT32 mcd, const char*fmt, va_list ap)
{
      char buffer[4096];
      int rc = 0;

      if (!IS_MCD(mcd)) return 0;

      if (vpi_trace) {
	    fprintf(vpi_trace, "vpi_mcd_vprintf(0x%08x, %s, ...);\n",
		    mcd, fmt);
      }

      rc = vsnprintf(buffer, sizeof buffer, fmt, ap);

      for(int i = 0; i < 31; i++) {
	    if((mcd>>i) & 1) {
		  if(mcd_table[i].fp) {
			  // echo to logfile
			if (i == 0 && logfile)
			      fputs(buffer, logfile);
			fputs(buffer, mcd_table[i].fp);
		  } else {
			rc = EOF;
		  }
	    }
      }

      return rc;
}

extern "C" PLI_INT32 vpi_mcd_printf(PLI_UINT32 mcd, const char *fmt, ...)
{
      va_list ap;
      va_start(ap, fmt);
      int r = vpi_mcd_vprintf(mcd,fmt,ap);
      va_end(ap);
      return r;
}

extern "C" PLI_INT32 vpi_mcd_flush(PLI_UINT32 mcd)
{
	int rc = 0;

	if (IS_MCD(mcd)) {
		for(int i = 0; i < 31; i++) {
			if((mcd>>i) & 1) {
				if (i == 0 && logfile) fflush(logfile);
				if (fflush(mcd_table[i].fp)) rc |= 1<<i;
			}
		}
	} else {
		unsigned idx = FD_IDX(mcd);
		if (idx < FD_MAX) rc = fflush(fd_table[idx].fp);
	}
	return rc;
}

/*
 * MCD/FD Extensions
 */
extern "C" PLI_INT32 vpi_fopen(const char*name, const char*mode)
{
	unsigned i;
	for(i = 0; i < FD_MAX; i++) {
		if(fd_table[i].filename == NULL)
			goto got_entry;
	}
	return 0;  /* too many open fd's */

got_entry:
	fd_table[i].fp = fopen(name, mode);
	if(fd_table[i].fp == NULL)
		return 0;
	fd_table[i].filename = strdup(name);
	return ((1U<<31)|i);
}

extern "C" FILE *vpi_get_file(PLI_INT32 fd)
{
	// Only deal with FD's
	if (IS_MCD(fd)) return NULL;

	// Only know about FD_MAX indicies
	if (FD_IDX(fd) >= FD_MAX) return NULL;

	return fd_table[FD_IDX(fd)].fp;
}

/*
 * $Log: vpi_mcd.cc,v $
 * Revision 1.11  2003/07/21 01:20:59  steve
 *  vpi_mcd_vprintf can only scan the va_list once.
 *
 * Revision 1.10  2003/05/23 04:04:02  steve
 *  Add vpi_fopen and vpi_get_file.
 *
 * Revision 1.9  2003/05/15 16:51:09  steve
 *  Arrange for mcd id=00_00_00_01 to go to stdout
 *  as well as a user specified log file, set log
 *  file to buffer lines.
 *
 *  Add vpi_flush function, and clear up some cunfused
 *  return codes from other vpi functions.
 *
 *  Adjust $display and vcd/lxt messages to use the
 *  standard output/log file.
 *
 * Revision 1.8  2002/08/12 01:35:09  steve
 *  conditional ident string using autoconfig.
 *
 * Revision 1.7  2002/08/11 23:47:05  steve
 *  Add missing Log and Ident strings.
 *
 */
