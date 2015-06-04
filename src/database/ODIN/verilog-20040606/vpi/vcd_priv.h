#ifndef __vcd_priv_H
#define __vcd_priv_H
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
#ident "$Id: vcd_priv.h,v 1.2 2003/02/13 18:13:28 steve Exp $"
#endif

struct vcd_names_s;
extern struct stringheap_s name_heap;

struct vcd_names_list_s {
      struct vcd_names_s *vcd_names_list;
      const char **vcd_names_sorted;
      int listed_names, sorted_names;
};

extern void vcd_names_add(struct vcd_names_list_s*tab, const char *name);

extern const char *vcd_names_search(struct vcd_names_list_s*tab,
				    const char *key);

extern void vcd_names_sort(struct vcd_names_list_s*tab);


extern const char*find_nexus_ident(int nex);
extern void       set_nexus_ident(int nex, const char *id);

/*
 * $Log: vcd_priv.h,v $
 * Revision 1.2  2003/02/13 18:13:28  steve
 *  Make lxt use stringheap to perm-allocate strings.
 *
 * Revision 1.1  2003/02/11 05:21:33  steve
 *  Support dump of vpiRealVar objects.
 *
 */
#endif
