#ifndef __schedule_H
#define __schedule_H
/*
 * Copyright (c) 2001-2003 Stephen Williams (steve@icarus.com)
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
#ident "$Id: schedule.h,v 1.16 2003/09/09 00:56:45 steve Exp $"
#endif

# include  "vthread.h"
# include  "pointers.h"

/*
 * This causes a thread to be scheduled for execution. The schedule
 * puts the event into the event queue after any existing events for a
 * given time step. The delay is a relative time.
 *
 * If the delay is zero, the push_flag can be used to force the event
 * to the front of the queue. %fork uses this to get the thread
 * execution ahead of non-blocking assignments.
 */
extern void schedule_vthread(vthread_t thr, vvp_time64_t delay,
			     bool push_flag =false);

/*
 * Create an assignment event. The val passed here will be assigned to
 * the specified input when the delay times out.
 */
extern void schedule_assign(vvp_ipoint_t fun, unsigned char val,
			    vvp_time64_t delay);


/*
 * Create a generic event. This supports scheduled events that are not
 * any of the specific types above. The vvp_get_event_t points to a
 * function to be executed when the scheduler gets to the event. It is
 * up to the user to allocate/free the vvp_get_event_s object. The
 * object is never referenced by the scheduler after the run method is
 * called.
 */

typedef struct vvp_gen_event_s *vvp_gen_event_t;

extern void schedule_generic(vvp_gen_event_t obj, unsigned char val,
			     vvp_time64_t delay, bool sync_flag);

struct vvp_gen_event_s
{
      void (*run)(vvp_gen_event_t obj, unsigned char val);
};

/*
 * This runs the simulator. It runs until all the functors run out or
 * the simulation is otherwise finished.
 */
extern void schedule_simulate(void);

/*
 * Get the current absolute simulation time. This is not used
 * internally by the scheduler (which uses time differences instead)
 * but is used for printouts and stuff.
 */
extern vvp_time64_t schedule_simtime(void);

/*
 * This function is the equivalent of the $finish system task. It
 * tells the simulator that simulation is done, the current thread
 * should be stopped, all remaining events abandoned and the
 * schedule_simulate() function will return.
 *
 * The schedule_finished() function will return true if the
 * schedule_finish() function has been called.
 */
extern void schedule_finish(int rc);
extern void schedule_stop(int rc);
extern bool schedule_finished(void);
extern bool schedule_stopped(void);

/*
 * The scheduler calls this function to process stop events. When this
 * function returns, the simulation resumes.
 */
extern void stop_handler(int rc);

/*
 * These are event counters for the sake of performance measurements.
 */
extern unsigned long count_assign_events;
extern unsigned long count_gen_events;
extern unsigned long count_prop_events;
extern unsigned long count_thread_events;
extern unsigned long count_event_pool;

/*
 * $Log: schedule.h,v $
 * Revision 1.16  2003/09/09 00:56:45  steve
 *  Reimpelement scheduler to divide nonblocking assign queue out.
 *
 * Revision 1.15  2003/02/22 02:52:06  steve
 *  Check for stopped flag in certain strategic points.
 *
 * Revision 1.14  2003/02/21 03:40:35  steve
 *  Add vpiStop and interactive mode.
 *
 * Revision 1.13  2003/02/09 23:33:26  steve
 *  Spelling fixes.
 *
 * Revision 1.12  2003/01/06 23:57:26  steve
 *  Schedule wait lists of threads as a single event,
 *  to save on events. Also, improve efficiency of
 *  event_s allocation. Add some event statistics to
 *  get an idea where performance is really going.
 *
 * Revision 1.11  2002/08/12 01:35:08  steve
 *  conditional ident string using autoconfig.
 *
 * Revision 1.10  2002/05/12 23:44:41  steve
 *  task calls and forks push the thread event in the queue.
 */
#endif
