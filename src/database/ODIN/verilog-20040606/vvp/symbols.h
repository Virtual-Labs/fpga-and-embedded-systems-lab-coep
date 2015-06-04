#ifndef __symbols_H
#define __symbols_H
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
#ident "$Id: symbols.h,v 1.4 2002/08/12 01:35:08 steve Exp $"
#endif

/*
 * The symbol_table_t is intended as a means to hold and quickly index
 * large symbol tables with small symbol values. That is, the value
 * should fit in a 32bit unsigned integer (not even necessarily a
 * pointer.)
 *
 * The key is an unstructured ASCII string, terminated by a
 * null. Items added to the table are not removed, unless the entire
 * table is deleted.
 *
 * The compiler uses symbol tables to help match up operands to
 * referenced objects in the source. The compiler knows by the context
 * that the symbol appears what kind of thing is referenced, and so
 * what symbol table to look in.
 */

# include  "config.h"

/*
 * This is the basic type of a symbol table. It is opaque. Don't even
 * try to look inside. The actual implementation is given in the
 * symbols.cc source file.
 */
typedef struct symbol_table_s *symbol_table_t;

typedef struct symbol_value_s {
      union {
	    unsigned long num;
	    void*ptr;
      };
} symbol_value_t;

/*
 * Create a new symbol table or release an existing one. A new symbol
 * table has no keys and no values. As a symbol table is built up, it
 * consumes more and more memory. When the table is no longer needed,
 * the delete_symbol_table method will delete the table, including all
 * the space for the keys.
 */
extern symbol_table_t new_symbol_table(void);
extern void delete_symbol_table(symbol_table_t tbl);

/*
 * This method locates the value in the symbol table and sets its
 * value. If the key doesn't yet exist, create it.
 */
void sym_set_value(symbol_table_t tbl, const char*key, symbol_value_t val);

/*
 * This method locates the value in the symbol table and returns
 * it. If the value does not exist, create it, initialize it with
 * zero and return the zero value.
 */
symbol_value_t sym_get_value(symbol_table_t tbl, const char*key);

/*
 * $Log: symbols.h,v $
 * Revision 1.4  2002/08/12 01:35:08  steve
 *  conditional ident string using autoconfig.
 *
 * Revision 1.3  2001/05/09 04:23:19  steve
 *  Now that the interactive debugger exists,
 *  there is no use for the output dump.
 *
 * Revision 1.2  2001/03/18 00:37:55  steve
 *  Add support for vpi scopes.
 *
 * Revision 1.1  2001/03/11 00:29:39  steve
 *  Add the vvp engine to cvs.
 *
 */
#endif
