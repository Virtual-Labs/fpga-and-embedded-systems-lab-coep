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
#ident "$Id: net_nex_input.cc,v 1.11 2003/10/26 04:50:46 steve Exp $"
#endif

# include "config.h"

# include <iostream>

# include  <cassert>
# include  <typeinfo>
# include  "netlist.h"
# include  "netmisc.h"

NexusSet* NetExpr::nex_input()
{
      cerr << get_line()
	   << ": internal error: nex_input not implemented: "
	   << *this << endl;
      return 0;
}

NexusSet* NetProc::nex_input()
{
      cerr << get_line()
	   << ": internal error: NetProc::nex_input not implemented"
	   << endl;
      return 0;
}

NexusSet* NetEBinary::nex_input()
{
      NexusSet*result = left_->nex_input();
      NexusSet*tmp = right_->nex_input();
      result->add(*tmp);
      delete tmp;
      return result;
}

NexusSet* NetEBitSel::nex_input()
{
      NexusSet*result = sig_->nex_input();
      NexusSet*tmp = idx_->nex_input();
      result->add(*tmp);
      delete tmp;
      return result;
}

NexusSet* NetEConcat::nex_input()
{
      NexusSet*result = parms_[0]->nex_input();
      for (unsigned idx = 1 ;  idx < parms_.count() ;  idx += 1) {
	    NexusSet*tmp = parms_[idx]->nex_input();
	    result->add(*tmp);
	    delete tmp;
      }
      return result;
}

/*
 * A constant has not inputs, so always return an empty set.
 */
NexusSet* NetEConst::nex_input()
{
      return new NexusSet;
}

NexusSet* NetECReal::nex_input()
{
      return new NexusSet;
}

NexusSet* NetEMemory::nex_input()
{
      NexusSet*result = idx_->nex_input();
      return result;
}

/*
 * A parameter by definition has no inputs. It represents a constant
 * value, even if that value is a constant expression.
 */
NexusSet* NetEParam::nex_input()
{
      return new NexusSet;
}

NexusSet* NetEEvent::nex_input()
{
      return new NexusSet;
}

NexusSet* NetEScope::nex_input()
{
      return new NexusSet;
}

NexusSet* NetESelect::nex_input()
{
      NexusSet*result = base_? base_->nex_input() : new NexusSet();
      NexusSet*tmp = expr_->nex_input();
      result->add(*tmp);
      delete tmp;
      return result;
}

NexusSet* NetESFunc::nex_input()
{
      if (nparms_ == 0)
	    return new NexusSet;

      NexusSet*result = parms_[0]->nex_input();
      for (unsigned idx = 1 ;  idx < nparms_ ;  idx += 1) {
	    NexusSet*tmp = parms_[idx]->nex_input();
	    result->add(*tmp);
	    delete tmp;
      }
      return result;
}

NexusSet* NetESignal::nex_input()
{
      NexusSet*result = new NexusSet;
      for (unsigned idx = 0 ;  idx < net_->pin_count() ;  idx += 1)
	    result->add(net_->pin(idx).nexus());

      return result;
}

NexusSet* NetETernary::nex_input()
{
      NexusSet*tmp;
      NexusSet*result = cond_->nex_input();

      tmp = true_val_->nex_input();
      result->add(*tmp);
      delete tmp;

      tmp = false_val_->nex_input();
      result->add(*tmp);
      delete tmp;

      return result;
}

NexusSet* NetEUFunc::nex_input()
{
      NexusSet*result = new NexusSet;
      for (unsigned idx = 0 ;  idx < parms_.count() ;  idx += 1) {
	    NexusSet*tmp = parms_[idx]->nex_input();
	    result->add(*tmp);
	    delete tmp;
      }

      return result;
}

NexusSet* NetEUnary::nex_input()
{
      return expr_->nex_input();
}

NexusSet* NetEVariable::nex_input()
{
      return new NexusSet;
}

NexusSet* NetAssignBase::nex_input()
{
      NexusSet*result = rval_->nex_input();
      return result;
}

/*
 * The nex_input of a begin/end block is the NexusSet of bits that the
 * block reads from outside the block. That means it is the union of
 * the nex_input for all the substatements.
 *
 * The input set for a sequential set is not exactly the union of the
 * input sets because there is the possibility of intermediate values,
 * that don't deserve to be in the input set. To wit:
 *
 *      begin
 *         t = a + b;
 *         c = ~t;
 *      end
 *
 * In this example, "t" should not be in the input set because it is
 * used by the sequence as a temporary value.
 */
NexusSet* NetBlock::nex_input()
{
      if (last_ == 0)
	    return new NexusSet;

      if (type_ == PARA) {
	    cerr << get_line() << ": internal error: Sorry, "
		 << "I don't know how to synthesize fork/join blocks."
		 << endl;
	    return 0;
      }

      NetProc*cur = last_->next_;
	/* This is the accumulated input set. */
      NexusSet*result = new NexusSet;
	/* This is an accumulated output set. */
      NexusSet*prev = new NexusSet;

      do {
	      /* Get the inputs for the current statement. */
	    NexusSet*tmp = cur->nex_input();

	      /* Remove from the input set those bits that are outputs
		 from previous statements. They aren't really inputs
		 to the block, just internal intermediate values. */
	    tmp->rem(*prev);

	      /* Add the corrected set to the accumulated input set. */
	    result->add(*tmp);
	    delete tmp;

	      /* Add the current outputs to the accumulated output
		 set, for processing of later statements. */
	    cur->nex_output(*prev);

	    cur = cur->next_;
      } while (cur != last_->next_);

      return result;
}

/*
 * The inputs to a case statement are the inputs to the expression,
 * the inputs to all the guards, and the inputs to all the guarded
 * statements.
 */
NexusSet* NetCase::nex_input()
{
      NexusSet*result = expr_->nex_input();
      if (result == 0)
	    return 0;

      for (unsigned idx = 0 ;  idx < nitems_ ;  idx += 1) {

	      /* Skip cases that have empty statements. */
	    if (items_[idx].statement == 0)
		  continue;

	    NexusSet*tmp = items_[idx].statement->nex_input();
	    assert(tmp);
	    result->add(*tmp);
	    delete tmp;

	      /* Usually, this is the guard expression. The default
		 case is special and is identified by a null
		 guard. The default guard obviously has no input. */
	    if (items_[idx].guard) {
		  tmp = items_[idx].guard->nex_input();
		  assert(tmp);
		  result->add(*tmp);
		  delete tmp;
	    }
      }

      return result;
}

NexusSet* NetCAssign::nex_input()
{
      cerr << get_line() << ": internal warning: NetCAssign::nex_input()"
	   << " not implemented." << endl;
      return new NexusSet;
}

NexusSet* NetCondit::nex_input()
{
      NexusSet*result = expr_->nex_input();
      if (if_ != 0) {
	    NexusSet*tmp = if_->nex_input();
	    result->add(*tmp);
	    delete tmp;
      }

      if (else_ != 0) {
	    NexusSet*tmp = else_->nex_input();
	    result->add(*tmp);
	    delete tmp;
      }

      return result;
}

NexusSet* NetForce::nex_input()
{
      cerr << get_line() << ": internal warning: NetForce::nex_input()"
	   << " not implemented." << endl;
      return new NexusSet;
}

NexusSet* NetForever::nex_input()
{
      NexusSet*result = statement_->nex_input();
      return result;
}

/*
 * The NetPDelay statement is a statement of the form
 *
 *   #<expr> <statement>
 *
 * The nex_input set is the input set of the <statement>. Do *not*
 * include the input set of the <expr> because it does not affect the
 * result.
 */
NexusSet* NetPDelay::nex_input()
{
      NexusSet*result = statement_->nex_input();
      return result;
}

NexusSet* NetRepeat::nex_input()
{
      NexusSet*result = statement_->nex_input();
      NexusSet*tmp = expr_->nex_input();
      result->add(*tmp);
      delete tmp;
      return result;
}

NexusSet* NetSTask::nex_input()
{
      if (parms_.count() == 0)
	    return new NexusSet;

      NexusSet*result = parms_[0]->nex_input();
      for (unsigned idx = 1 ;  idx < parms_.count() ;  idx += 1) {
	    NexusSet*tmp = parms_[idx]->nex_input();
	    result->add(*tmp);
	    delete tmp;
      }

      return result;
}

/*
 * The NetUTask represents a call to a user defined task. There are no
 * parameters to consider, because the compiler already removed them
 * and converted them to blocking assignments.
 */
NexusSet* NetUTask::nex_input()
{
      return new NexusSet;
}

NexusSet* NetWhile::nex_input()
{
      NexusSet*result = proc_->nex_input();
      NexusSet*tmp = cond_->nex_input();
      result->add(*tmp);
      delete tmp;
      return result;
}

/*
 * $Log: net_nex_input.cc,v $
 * Revision 1.11  2003/10/26 04:50:46  steve
 *  Case with empty statements has no inputs.
 *
 * Revision 1.10  2003/07/26 03:34:42  steve
 *  Start handling pad of expressions in code generators.
 *
 * Revision 1.9  2003/04/22 04:48:29  steve
 *  Support event names as expressions elements.
 *
 * Revision 1.8  2003/01/26 21:15:58  steve
 *  Rework expression parsing and elaboration to
 *  accommodate real/realtime values and expressions.
 *
 * Revision 1.7  2002/11/16 05:45:41  steve
 *  Handle default: case in net_inputs for NetCase.
 *
 * Revision 1.6  2002/08/18 22:07:16  steve
 *  Detect temporaries in sequential block synthesis.
 *
 * Revision 1.5  2002/08/12 01:34:59  steve
 *  conditional ident string using autoconfig.
 *
 * Revision 1.4  2002/07/14 23:47:58  steve
 *  Infinite loop in nex_input of NetBlock objects.
 *
 * Revision 1.3  2002/06/05 03:44:25  steve
 *  Add support for memory words in l-value of
 *  non-blocking assignments, and remove the special
 *  NetAssignMem_ and NetAssignMemNB classes.
 *
 * Revision 1.2  2002/04/21 17:43:12  steve
 *  implement nex_input for behavioral statements.
 *
 * Revision 1.1  2002/04/21 04:59:08  steve
 *  Add support for conbinational events by finding
 *  the inputs to expressions and some statements.
 *  Get case and assignment statements working.
 *
 */

