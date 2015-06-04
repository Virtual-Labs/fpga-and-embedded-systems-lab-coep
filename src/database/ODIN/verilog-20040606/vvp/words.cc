/*
 * Copyright (c) 2003 Stephen Williams (steve@icarus.com)
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
#ident "$Id: words.cc,v 1.2 2003/02/11 05:20:45 steve Exp $"
#endif

# include  "compile.h"
# include  "vpi_priv.h"
# include  <stdio.h>
# include  <stdlib.h>
# include  <string.h>
#ifdef HAVE_MALLOC_H
# include  <malloc.h>
#endif
# include  <assert.h>


void compile_word(char*label, char*type, char*name)
{
      assert(strcmp(type, "real") == 0);
      free(type);

      vpiHandle obj = vpip_make_real_var(name);
      free(name);

      compile_vpi_symbol(label, obj);
      free(label);

      vpip_attach_to_current_scope(obj);
}

/*
 * $Log: words.cc,v $
 * Revision 1.2  2003/02/11 05:20:45  steve
 *  Include vpiRealVar objects in vpiVariables scan.
 *
 * Revision 1.1  2003/01/25 23:48:06  steve
 *  Add thread word array, and add the instructions,
 *  %add/wr, %cmp/wr, %load/wr, %mul/wr and %set/wr.
 *
 */

