/*
 * Copyright (c) 2001 Stephen Williams (steve@icarus.com)
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
#ident "$Id: logic.cc,v 1.12 2002/09/06 04:56:29 steve Exp $"
#endif

# include  "logic.h"
# include  "compile.h"
# include  "bufif.h"
# include  "npmos.h"
# include  "statistics.h"
# include  <string.h>
# include  <assert.h>
# include  <stdlib.h>
#ifdef HAVE_MALLOC_H
# include  <malloc.h>
#endif


/*
 *   Implementation of the table functor, which provides logic with up
 *   to 4 inputs.
 */

table_functor_s::table_functor_s(truth_t t, unsigned str0, unsigned str1) 
: table(t) 
{
      count_functors_table += 1;
      assert(str0 <= 7);
      assert(str1 <= 7);
      odrive0 = str0;
      odrive1 = str1;
}

table_functor_s::~table_functor_s() 
{}

void table_functor_s::set(vvp_ipoint_t ptr, bool push, unsigned v, unsigned)
{
	/* Load the new value into the standard ival vector. */
      put(ptr, v);

	/* Locate the new output value in the table. */
      unsigned char val = table[ival >> 2];
      val >>= 2 * (ival&0x03);
      val &= 0x03;

	/* Send the output. Do *not* push the value, because logic
	   devices in Verilog are supposed to suppress 0-time
	   pulses. If we were to push the value, The gate on this
	   device's output would receive every change that happened,
	   thus allowing full transport propagation, instead of the
	   proper ballistic propagation. */
      put_oval(val, false);
}

/*
 * The parser calls this function to create a logic functor. I allocate a
 * functor, and map the name to the vvp_ipoint_t address for the
 * functor. Also resolve the inputs to the functor.
 */

void compile_functor(char*label, char*type,
		     vvp_delay_t delay, unsigned ostr0, unsigned ostr1,
		     unsigned argc, struct symb_s*argv)
{
      functor_t obj;

      if (strcmp(type, "OR") == 0) {
	    obj = new table_functor_s(ft_OR, ostr0, ostr1);

      } else if (strcmp(type, "AND") == 0) {
	    obj = new table_functor_s(ft_AND, ostr0, ostr1);

      } else if (strcmp(type, "BUF") == 0) {
	    obj = new table_functor_s(ft_BUF, ostr0, ostr1);

      } else if (strcmp(type, "BUFIF0") == 0) {
	    obj = new vvp_bufif_s(true,false, ostr0, ostr1);

      } else if (strcmp(type, "BUFIF1") == 0) {
	    obj = new vvp_bufif_s(false,false, ostr0, ostr1);

      } else if (strcmp(type, "BUFZ") == 0) {
	    obj = new table_functor_s(ft_BUFZ, ostr0, ostr1);

      } else if (strcmp(type, "PMOS") == 0) {
	    obj = new vvp_pmos_s;

      } else if (strcmp(type, "NMOS") == 0) {
	    obj= new vvp_nmos_s;

      } else if (strcmp(type, "RPMOS") == 0) {
	    obj = new vvp_rpmos_s;

      } else if (strcmp(type, "RNMOS") == 0) {
	    obj = new vvp_rnmos_s;

      } else if (strcmp(type, "MUXX") == 0) {
	    obj = new table_functor_s(ft_MUXX);

      } else if (strcmp(type, "MUXZ") == 0) {
	    obj = new table_functor_s(ft_MUXZ);

      } else if (strcmp(type, "EEQ") == 0) {
	    obj = new table_functor_s(ft_EEQ);

      } else if (strcmp(type, "NAND") == 0) {
	    obj = new table_functor_s(ft_NAND, ostr0, ostr1);

      } else if (strcmp(type, "NOR") == 0) {
	    obj = new table_functor_s(ft_NOR, ostr0, ostr1);

      } else if (strcmp(type, "NOT") == 0) {
	    obj = new table_functor_s(ft_NOT, ostr0, ostr1);

      } else if (strcmp(type, "NOTIF0") == 0) {
	    obj = new vvp_bufif_s(true,true, ostr0, ostr1);

      } else if (strcmp(type, "NOTIF1") == 0) {
	    obj = new vvp_bufif_s(false,true, ostr0, ostr1);

      } else if (strcmp(type, "XNOR") == 0) {
	    obj = new table_functor_s(ft_XNOR, ostr0, ostr1);

      } else if (strcmp(type, "XOR") == 0) {
	    obj = new table_functor_s(ft_XOR, ostr0, ostr1);

      } else {
	    yyerror("invalid functor type.");
	    free(type);
	    free(argv);
	    free(label);
	    return;
      }

      free(type);

      assert(argc <= 4);
      vvp_ipoint_t fdx = functor_allocate(1);
      functor_define(fdx, obj);
      define_functor_symbol(label, fdx);
      free(label);

      obj->delay = delay;

      inputs_connect(fdx, argc, argv);
      free(argv);
}


/*
 * $Log: logic.cc,v $
 * Revision 1.12  2002/09/06 04:56:29  steve
 *  Add support for %v is the display system task.
 *  Change the encoding of H and L outputs from
 *  the bufif devices so that they are logic x.
 *
 * Revision 1.11  2002/08/29 03:04:01  steve
 *  Generate x out for x select on wide muxes.
 *
 * Revision 1.10  2002/08/12 01:35:08  steve
 *  conditional ident string using autoconfig.
 *
 * Revision 1.9  2002/07/05 20:08:44  steve
 *  Count different types of functors.
 *
 * Revision 1.8  2002/03/17 05:48:49  steve
 *  Do not push values through logic gates.
 *
 * Revision 1.7  2002/01/12 04:02:16  steve
 *  Support the BUFZ logic device.
 *
 * Revision 1.6  2001/12/14 06:03:17  steve
 *  Arrange bufif to support notif as well.
 *
 * Revision 1.5  2001/12/14 02:04:49  steve
 *  Support strength syntax on functors.
 *
 * Revision 1.4  2001/12/06 03:31:24  steve
 *  Support functor delays for gates and UDP devices.
 *  (Stephan Boettcher)
 *
 * Revision 1.3  2001/11/16 04:22:27  steve
 *  include stdlib.h for portability.
 *
 * Revision 1.2  2001/11/07 03:34:42  steve
 *  Use functor pointers where vvp_ipoint_t is unneeded.
 *
 * Revision 1.1  2001/11/06 03:07:22  steve
 *  Code rearrange. (Stephan Boettcher)
 *
 */

