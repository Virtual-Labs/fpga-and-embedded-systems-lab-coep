/*
 * Copyright (c) 2002 Stephen Williams (steve@icarus.com)
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
#ident "$Id: vpip_bin.cc,v 1.2 2002/08/12 01:35:09 steve Exp $"
#endif

# include  "config.h"
# include  "vpi_priv.h"
# include  <stdio.h>
# include  <string.h>
# include  <limits.h>
# include  <stdlib.h>
#ifdef HAVE_MALLOC_H
# include  <malloc.h>
#endif
# include  <assert.h>

void vpip_bin_str_to_bits(unsigned char*bits, unsigned nbits,
			  const char*buf, bool signed_flag)
{
      const char*ebuf = buf + strlen(buf);
      unsigned char last = 0x00;
      unsigned pos = 0;

      for (unsigned idx = 0 ;  idx < (nbits+3)/4 ;  idx += 1)
	    bits[idx] = 0;

      while (ebuf > buf) {
	    unsigned val;

	    if (nbits == 0)
		  break;

	    ebuf -= 1;
	    switch (*ebuf) {
		case '0': val = 0x00; break;
		case '1': val = 0x01; break;
		case 'x':
		case 'X': val = 0x02; break;
		case 'z':
		case 'Z': val = 0x03; break;
		default:  val = 0x00; break;
	    }

	    last = val;
	    switch (pos) {
		case 0:
		  bits[0] = val;
		  pos = 1;
		  break;
		case 1:
		  bits[0] |= val << 2;
		  pos = 2;
		  break;
		case 2:
		  bits[0] |= val << 4;
		  pos = 3;
		  break;
		case 3:
		  bits[0] |= val << 6;
		  bits += 1;
		  pos = 0;
	    }

	    nbits -= 1;
      }

	/* Calculate the pad value based on the top bit and the signed
	   flag. We may sign extend or zero extend. */
      switch (last) {
	  case 0:
	    last = 0x00;
	    break;
	  case 1:
	    last = signed_flag? 0x01 : 0x00;
	    break;
	  case 2:
	    last = 0x02;
	    break;
	  case 3:
	    last = 0x03;
	    break;
      }

      while (nbits > 0) switch (pos) {
	  case 0:
	    bits[0] = last;
	    nbits -= 1;
	    pos = 1;
	    break;
	  case 1:
	    bits[0] |= last << 2;
	    nbits -= 1;
	    pos = 2;
	    break;
	  case 2:
	    bits[0] |= last << 4;
	    bits -= 1;
	    pos = 3;
	  case 3:
	    bits[0] |= last << 6;
	    nbits -= 1;
	    bits += 1;
	    pos = 0;
      }

}

/*
 * $Log: vpip_bin.cc,v $
 * Revision 1.2  2002/08/12 01:35:09  steve
 *  conditional ident string using autoconfig.
 *
 * Revision 1.1  2002/05/11 04:39:35  steve
 *  Set and get memory words by string value.
 *
 */

