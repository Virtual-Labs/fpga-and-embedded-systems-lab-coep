/*
 * Copyright (c) 2002-2003 Stephen Williams (steve@icarus.com)
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
#ident "$Id: vpi_event.cc,v 1.9 2003/05/04 20:43:36 steve Exp $"
#endif

# include  "vpi_priv.h"
# include  "functor.h"
# include  <stdio.h>
#ifdef HAVE_MALLOC_H
# include  <malloc.h>
#endif
# include  <stdlib.h>
# include  <string.h>
# include  <assert.h>

static char* named_event_str(int code, vpiHandle ref)
{
      assert((ref->vpi_type->type_code==vpiNamedEvent));

      struct __vpiNamedEvent*obj = (struct __vpiNamedEvent*)ref;

      char *bn = vpi_get_str(vpiFullName, &obj->scope->base);
      const char *nm = obj->name;

      char *rbuf = need_result_buf(strlen(bn) + strlen(nm) + 1, RBUF_STR);

      switch (code) {

	  case vpiFullName:
	    sprintf(rbuf, "%s.%s", bn, nm);
	    return rbuf;

	  case vpiName:
	    strcpy(rbuf, nm);
	    return rbuf;

      }

      return 0;
}

static vpiHandle named_event_get_handle(int code, vpiHandle ref)
{
      assert((ref->vpi_type->type_code==vpiNamedEvent));

      struct __vpiNamedEvent*obj = (struct __vpiNamedEvent*)ref;

      switch (code) {

	  case vpiScope:
	    return &obj->scope->base;
      }

      return 0;
}

static const struct __vpirt vpip_named_event_rt = {
      vpiNamedEvent,

      0,
      named_event_str,
      0,
      0,

      named_event_get_handle,
      0,
      0,

      0
};

vpiHandle vpip_make_named_event(const char*name, vvp_ipoint_t funct)
{
      struct __vpiNamedEvent*obj = (struct __vpiNamedEvent*)
	    malloc(sizeof(struct __vpiNamedEvent));

      obj->base.vpi_type = &vpip_named_event_rt;
      obj->name = vpip_name_string(name);
      obj->scope = vpip_peek_current_scope();
      obj->funct = funct;
      obj->callbacks = 0;

      return &obj->base;
}

/*
 * This function runs the callbacks for a named event. All the
 * callbacks are listed in the callback member of the event handle,
 * this function scans that list.
 *
 * This also handles the case where the callback has been removed. The
 * vpi_remove_cb doesn't actually remove any callbacks, it marks them
 * as cancelled by clearing the cb_rtn function. This function reaps
 * those marked handles when it scans the list.
 */
void vpip_run_named_event_callbacks(vpiHandle ref)
{
      assert((ref->vpi_type->type_code==vpiNamedEvent));

      struct __vpiNamedEvent*obj = (struct __vpiNamedEvent*)ref;

      struct __vpiCallback*next = obj->callbacks;
      struct __vpiCallback*prev = 0;
      while (next) {
	    struct __vpiCallback*cur = next;
	    next = cur->next;

	    if (cur->cb_data.cb_rtn != 0) {
		  callback_execute(cur);
		  prev = cur;

	    } else if (prev == 0) {
		  obj->callbacks = next;
		  cur->next = 0;
		  vpi_free_object(&cur->base);

	    } else {
		  assert(prev->next == cur);
		  prev->next = next;
		  cur->next = 0;
		  vpi_free_object(&cur->base);
	    }
      }
}

/*
 * $Log: vpi_event.cc,v $
 * Revision 1.9  2003/05/04 20:43:36  steve
 *  Event callbacks support vpi_remove_cb.
 *
 * Revision 1.8  2003/04/23 03:09:25  steve
 *  VPI Access to named events.
 *
 * Revision 1.7  2003/03/06 04:32:00  steve
 *  Use hashed name strings for identifiers.
 *
 * Revision 1.6  2003/02/02 01:40:24  steve
 *  Five vpi_free_object a default behavior.
 *
 * Revision 1.5  2002/08/12 01:35:08  steve
 *  conditional ident string using autoconfig.
 *
 * Revision 1.4  2002/07/12 18:23:30  steve
 *  Use result buf for event and scope names.
 *
 * Revision 1.3  2002/07/05 17:14:15  steve
 *  Names of vpi objects allocated as vpip_strings.
 *
 * Revision 1.2  2002/05/19 05:18:16  steve
 *  Add callbacks for vpiNamedEvent objects.
 *
 * Revision 1.1  2002/05/18 02:34:11  steve
 *  Add vpi support for named events.
 *
 *  Add vpi_mode_flag to track the mode of the
 *  vpi engine. This is for error checking.
 *
 */

