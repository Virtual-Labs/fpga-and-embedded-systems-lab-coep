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
#ident "$Id: vpip_format.c,v 1.1 2003/04/20 02:49:07 steve Exp $"
#endif

# include  <vpi_user.h>
# include  <assert.h>

static const char str_char1_table[256] = {
      ".HS1M222" "W3333333" /* 00 0F */ "L4444444" "44444444" /* 10 1F */
      "P5555555" "55555555" /* 20 2F */ "55555555" "55555555" /* 30 3F */
      "S6666666" "66666666" /* 40 4F */ "66666666" "66666666" /* 50 5F */
      "66666666" "66666666" /* 60 6F */ "66666666" "66666666" /* 70 7F */
      "S7777777" "77777777" /* 80 8F */ "77777777" "77777777" /* 90 9F */
      "77777777" "77777777" /* A0 AF */ "77777777" "77777777" /* B0 BF */
      "77777777" "77777777" /* C0 CF */ "77777777" "77777777" /* D0 DF */
      "77777777" "77777777" /* E0 EF */ "77777777" "77777777" /* F0 FF */ };

static const char str_char2_table[256] = {
      ".im0e010" "e0102010" /* 00 0F */ "a0102010" "30102010" /* 10 1F */
      "u0102010" "30102010" /* 20 2F */ "40102010" "30102010" /* 30 3F */
      "t0102010" "30102010" /* 40 4F */ "40102010" "30102010" /* 50 5F */
      "50102010" "30102010" /* 60 6F */ "40102010" "30102010" /* 70 7F */
      "u0102010" "30102010" /* 80 8F */ "40102010" "30102010" /* 90 9F */
      "50102010" "30102010" /* A0 AF */ "40102010" "30102010" /* B0 BF */
      "60102010" "30102010" /* C0 CF */ "40102010" "30102010" /* D0 DF */
      "50102010" "30102010" /* E0 EF */ "40102010" "30102010" /* F0 FF */ };


void vpip_format_strength(char*str, s_vpi_value*value)
{
      str[0] = '.';
      str[1] = '.';
      str[2] = '.';
      str[3] = 0;

      assert(value->format == vpiStrengthVal);

      switch (value->value.strength[0].logic) {
	  case vpi0:
	    str[0] = str_char1_table[value->value.strength[0].s0];
	    str[1] = str_char2_table[value->value.strength[0].s0];
	    str[2] = '0';
	    break;
	  case vpi1:
	    str[0] = str_char1_table[value->value.strength[0].s1];
	    str[1] = str_char2_table[value->value.strength[0].s1];
	    str[2] = '1';
	    break;
	  case vpiX:
	    if (value->value.strength[0].s0 == 1) {
		  str[0] = str_char1_table[value->value.strength[0].s1];
		  str[1] = str_char2_table[value->value.strength[0].s1];
		  str[2] = 'H';
	    } else if (value->value.strength[0].s1 == 1) {
		  str[0] = str_char1_table[value->value.strength[0].s0];
		  str[1] = str_char2_table[value->value.strength[0].s0];
		  str[2] = 'L';
	    } else if (value->value.strength[0].s1 ==
		       value->value.strength[0].s0) {
		  str[0] = str_char1_table[value->value.strength[0].s0];
		  str[1] = str_char2_table[value->value.strength[0].s0];
		  str[2] = 'X';
	    } else {
		  int ss;

		  str[0] = '0';
		  ss = value->value.strength[0].s0;
		  while (ss > 1) {
			str[0] += 1;
			ss >>= 1;
		  }
		  str[1] = '0';
		  ss = value->value.strength[0].s1;
		  while (ss > 1) {
			str[1] += 1;
			ss >>= 1;
		  }
		  str[2] = 'X';
	    }
	    break;
	  case vpiZ:
	    str[0] = 'H';
	    str[1] = 'i';
	    str[2] = 'Z';
	    break;
	  default:
	    assert(0);
      }
}

/*
 * $Log: vpip_format.c,v $
 * Revision 1.1  2003/04/20 02:49:07  steve
 *  acc_fetch_value support for %v format.
 *
 */

