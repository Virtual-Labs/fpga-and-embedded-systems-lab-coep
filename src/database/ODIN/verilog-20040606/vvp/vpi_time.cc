/*
 * Copyright (c) 2001-2002 Stephen Williams (steve@icarus.com)
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
#ident "$Id: vpi_time.cc,v 1.15 2003/03/14 18:01:00 steve Exp $"
#endif

# include  "config.h"
# include  "vpi_priv.h"
# include  "schedule.h"
# include  <stdio.h>
# include  <math.h>
# include  <assert.h>

/*
 * The $time system function is supported in VPI contexts (i.e. an
 * argument to a system task/function) as a vpiSysFuncCall object. The
 * $display function divines that this is a function call and uses a
 * vpi_get_value to get the value.
 */

/*
 * vpi_time_precision is the precision of the simulation clock. It is
 * set by the :vpi_time_precision directive in the vvp source file.
 */
static int vpi_time_precision = 0;

static struct __vpiSystemTime global_simtime;

void vpip_time_to_timestruct(struct t_vpi_time*ts, vvp_time64_t ti)
{
      ts->low  = ti & 0xFFFFFFFF;
      ts->high = (ti >> 32) & 0xFFFFFFFF;
}

vvp_time64_t vpip_timestruct_to_time(const struct t_vpi_time*ts)
{
      vvp_time64_t ti = ts->high;
      ti <<= 32;
      ti += ts->low & 0xffffffff;
      return ti;
}


static int timevar_time_get(int code, vpiHandle ref)
{
      switch (code) {
          case vpiSize:
	    return 64;

          case vpiSigned:
	    return 0;

	  case vpiFuncType:
	    return vpiTimeFunc;

	  default:
	    fprintf(stderr, "Code: %d\n", code);
	    assert(0);
	    return 0;
      }
}

static char* timevar_time_get_str(int code, vpiHandle ref)
{
      switch (code) {
	  case vpiName:
	    return "$time";
	  default:
	    fprintf(stderr, "Code: %d\n", code);
	    assert(0);
	    return 0;
      }
}

static char* timevar_realtime_get_str(int code, vpiHandle ref)
{
      switch (code) {
	  case vpiName:
	    return "$realtime";
	  default:
	    fprintf(stderr, "Code: %d\n", code);
	    assert(0);
	    return 0;
      }
}

static int timevar_realtime_get(int code, vpiHandle ref)
{
      switch (code) {
          case vpiSize:
	    return 64;

          case vpiSigned:
	    return 0;

	  case vpiFuncType:
	    return vpiRealFunc;

	  default:
	    fprintf(stderr, "Code: %d\n", code);
	    assert(0);
	    return 0;
      }
}

static vpiHandle timevar_handle(int code, vpiHandle ref)
{
      struct __vpiSystemTime*rfp
	    = reinterpret_cast<struct __vpiSystemTime*>(ref);

      switch (code) {
	  case vpiScope:
	    return &rfp->scope->base;
	  default:
	    return 0;
      }
}


static void timevar_get_value(vpiHandle ref, s_vpi_value*vp)
{
	/* Keep a persistent structure for passing time values back to
	   the caller. */
      static struct t_vpi_time time_value;

      struct __vpiSystemTime*rfp
	    = reinterpret_cast<struct __vpiSystemTime*>(ref);
      unsigned long num_bits;
      vvp_time64_t x, simtime = schedule_simtime();
      int units = rfp->scope? rfp->scope->time_units : vpi_time_precision;

      char*rbuf = need_result_buf(128, RBUF_VAL);

	/* Calculate the divisor needed to scale the simulation time
	   (in time_precision units) to time units of the scope. */
      vvp_time64_t divisor = 1;
      while (units > vpi_time_precision) {
	    divisor *= 10;
	    units -= 1;
      }

	/* Scale the simtime, and use the modulus to round up if
	   appropriate. */
      vvp_time64_t simtime_fraction = simtime % divisor;
      simtime /= divisor;

      if ((divisor >= 10) && (simtime_fraction >= (divisor/2)))
	    simtime += 1;

      switch (vp->format) {
	  case vpiObjTypeVal:
	      /* The default format is vpiTimeVal. */
	    vp->format = vpiTimeVal;
	  case vpiTimeVal:
	    vp->value.time = &time_value;
	    vp->value.time->type = vpiSimTime;
	    vpip_time_to_timestruct(vp->value.time, simtime);
	    break;

	  case vpiRealVal:
	      /* Oops, in this case I want a double power of 10 to do
		 the scaling, instead of the integer scaling done
		 everywhere else. */
	    units = rfp->scope? rfp->scope->time_units : vpi_time_precision;
	    vp->value.real = pow(10, vpi_time_precision - units);
	    vp->value.real *= schedule_simtime();
	    break;

	  case vpiBinStrVal: 
	    x = simtime;
	    num_bits = 8 * sizeof(vvp_time64_t);

	    rbuf[num_bits] = 0;
	    for (unsigned i = 1; i <= num_bits; i++) {
	      rbuf[num_bits-i] = x  & 1 ? '1' : '0';
	      x = x >> 1;
	    }

	    vp->value.str = rbuf;
	    break;

	  case vpiDecStrVal:
	    sprintf(rbuf, "%" TIME_FMT "u", simtime);
	    vp->value.str = rbuf;
	    break;

	  case vpiOctStrVal:
	    sprintf(rbuf, "%" TIME_FMT "o", simtime);
	    vp->value.str = rbuf;
	    break;

	  case vpiHexStrVal:
	    sprintf(rbuf, "%" TIME_FMT "x", simtime);
	    vp->value.str = rbuf;
	    break;

	  default:
	    fprintf(stderr, "vpi_time: unknown format: %d\n", vp->format);
	    assert(0);
      }
}

static const struct __vpirt vpip_system_time_rt = {
      vpiSysFuncCall,
      timevar_time_get,
      timevar_time_get_str,
      timevar_get_value,
      0,
      timevar_handle,
      0
};

static const struct __vpirt vpip_system_realtime_rt = {
      vpiSysFuncCall,
      timevar_realtime_get,
      timevar_realtime_get_str,
      timevar_get_value,
      0,
      timevar_handle,
      0
};

/*
 * Create a handle to represent a call to $time/$stime/$simtime. The
 * $time and $stime system functions return a value scaled to a scope,
 * and the $simtime returns the unscaled time.
 */
vpiHandle vpip_sim_time(struct __vpiScope*scope)
{
      if (scope) {
	    scope->scoped_time.base.vpi_type = &vpip_system_time_rt;
	    scope->scoped_time.scope = scope;
	    return &scope->scoped_time.base;
      } else {
	    global_simtime.base.vpi_type = &vpip_system_time_rt;
	    global_simtime.scope = 0;
	    return &global_simtime.base;
      }
}

vpiHandle vpip_sim_realtime(struct __vpiScope*scope)
{
      scope->scoped_realtime.base.vpi_type = &vpip_system_realtime_rt;
      scope->scoped_realtime.scope = scope;
      return &scope->scoped_realtime.base;
}

int vpip_get_time_precision(void)
{
      return vpi_time_precision;
}

void vpip_set_time_precision(int pre)
{
      vpi_time_precision = pre;
}


/*
 * $Log: vpi_time.cc,v $
 * Revision 1.15  2003/03/14 18:01:00  steve
 *  Refix vpiRealVal scaling of time.
 *
 * Revision 1.14  2003/03/13 20:31:41  steve
 *  Warnings about long long time.
 *
 * Revision 1.13  2003/03/13 04:59:21  steve
 *  Use rbufs instead of static buffers.
 *
 * Revision 1.12  2003/02/03 01:09:20  steve
 *  Allow $display of $simtime.
 *
 * Revision 1.11  2003/02/02 02:14:14  steve
 *  Proper rounding of scaled integer time.
 *
 * Revision 1.10  2003/02/01 05:50:04  steve
 *  Make $time and $realtime available to $display uniquely.
 *
 * Revision 1.9  2002/12/21 00:55:58  steve
 *  The $time system task returns the integer time
 *  scaled to the local units. Change the internal
 *  implementation of vpiSystemTime the $time functions
 *  to properly account for this. Also add $simtime
 *  to get the simulation time.
 *
 * Revision 1.8  2002/08/12 01:35:09  steve
 *  conditional ident string using autoconfig.
 *
 * Revision 1.7  2002/04/20 04:33:23  steve
 *  Support specified times in cbReadOnlySync, and
 *  add support for cbReadWriteSync.
 *  Keep simulation time in a 64bit number.
 *
 * Revision 1.6  2002/01/15 03:06:29  steve
 *  Support vpiSize and vpiSigned for time objects.
 *
 * Revision 1.5  2001/10/15 02:55:03  steve
 *  sign warning.
 *
 * Revision 1.4  2001/08/16 03:29:31  steve
 *  Support various other string formats for time.
 *
 * Revision 1.3  2001/06/30 23:03:17  steve
 *  support fast programming by only writing the bits
 *  that are listed in the input file.
 *
 * Revision 1.2  2001/04/03 03:46:14  steve
 *  VPI access time as a decimal string, and
 *  stub vpi access to the scopes.
 *
 * Revision 1.1  2001/03/31 19:00:44  steve
 *  Add VPI support for the simulation time.
 *
 */

