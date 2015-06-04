/*
 * Copyright (c) 1998-2004 Stephen Williams (steve@icarus.com)
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
#ident "$Id: elaborate.cc,v 1.302 2004/05/31 23:34:37 steve Exp $"
#endif

# include "config.h"

/*
 * Elaboration takes as input a complete parse tree and the name of a
 * root module, and generates as output the elaborated design. This
 * elaborated design is presented as a Module, which does not
 * reference any other modules. It is entirely self contained.
 */

# include  <typeinfo>
# include  <sstream>
# include  <list>
# include  "pform.h"
# include  "PEvent.h"
# include  "netlist.h"
# include  "netmisc.h"
# include  "util.h"
# include  "parse_api.h"
# include  "compiler.h"


static Link::strength_t drive_type(PGate::strength_t drv)
{
      switch (drv) {
	  case PGate::HIGHZ:
	    return Link::HIGHZ;
	  case PGate::WEAK:
	    return Link::WEAK;
	  case PGate::PULL:
	    return Link::PULL;
	  case PGate::STRONG:
	    return Link::STRONG;
	  case PGate::SUPPLY:
	    return Link::SUPPLY;
	  default:
	    assert(0);
      }
      return Link::STRONG;
}


void PGate::elaborate(Design*des, NetScope*scope) const
{
      cerr << "internal error: what kind of gate? " <<
	    typeid(*this).name() << endl;
}

/*
 * Elaborate the continuous assign. (This is *not* the procedural
 * assign.) Elaborate the lvalue and rvalue, and do the assignment.
 */
void PGAssign::elaborate(Design*des, NetScope*scope) const
{
      assert(scope);

      unsigned long rise_time, fall_time, decay_time;
      eval_delays(des, scope, rise_time, fall_time, decay_time);

      Link::strength_t drive0 = drive_type(strength0());
      Link::strength_t drive1 = drive_type(strength1());

      assert(pin(0));
      assert(pin(1));

	/* Elaborate the l-value. */
      NetNet*lval = pin(0)->elaborate_lnet(des, scope);
      if (lval == 0) {
	    des->errors += 1;
	    return;
      }


	/* Handle the special case that the rval is simply an
	   identifier. Get the rval as a NetNet, then use NetBUFZ
	   objects to connect it to the l-value. This is necessary to
	   direct drivers. This is how I attach strengths to the
	   assignment operation. */
      if (const PEIdent*id = dynamic_cast<const PEIdent*>(pin(1))) {
	    NetNet*rid = id->elaborate_net(des, scope, lval->pin_count(),
					   0, 0, 0, Link::STRONG,
					   Link::STRONG);
	    if (rid == 0) {
		  des->errors += 1;
		  return;
	    }

	    assert(rid);


	      /* If the right hand net is the same type as the left
		 side net (i.e., WIRE/WIRE) then it is enough to just
		 connect them together. Otherwise, put a bufz between
		 them to carry strengths from the rval.

		 While we are at it, handle the case where the r-value
		 is not as wide as the l-value by padding with a
		 constant-0. */

	    unsigned cnt = lval->pin_count();
	    if (rid->pin_count() < cnt)
		  cnt = rid->pin_count();

	    bool need_driver_flag = false;

	      /* If the device is linked to itself, a driver is
		 needed. Should I print a warning here? */
	    for (unsigned idx = 0 ;  idx < cnt ;  idx += 1) {
		  if (lval->pin(idx) .is_linked (rid->pin(idx))) {
			need_driver_flag = true;
			break;
		  }
	    }

	      /* If the nets are different type (i.e., reg vs. tri) then
		 a driver is needed. */
	    if (rid->type() != lval->type())
		  need_driver_flag = true;

	      /* If there is a delay, then I need a driver to carry
		 it. */
	    if (rise_time || fall_time || decay_time)
		  need_driver_flag = true;

	      /* If there is a strength to be carried, then I need a
		 driver to carry that strength. */
	    for (unsigned idx = 0 ;  idx < cnt ;  idx += 1) {
		  if (rid->pin(idx).drive0() != drive0) {
			need_driver_flag = true;
			break;
		  }
		  if (rid->pin(idx).drive1() != drive1) {
			need_driver_flag = true;
			break;
		  }
	    }

	    if (! need_driver_flag) {
		    /* Don't need a driver, presumably because the
		       r-value already has the needed drivers. Just
		       hook things up. If the r-value is too narrow
		       for the l-value, then sign extend it or zero
		       extend it, whichever makes sense. */
		  unsigned idx;
		  for (idx = 0 ;  idx < cnt; idx += 1)
			connect(lval->pin(idx), rid->pin(idx));

		  if (cnt < lval->pin_count()) {
			if (lval->get_signed() && rid->get_signed()) {
			      for (idx = cnt
					 ;  idx < lval->pin_count()
					 ;  idx += 1)
				    connect(lval->pin(idx), rid->pin(cnt-1));

			} else {
			      verinum tmpv (0UL, lval->pin_count()-cnt);
			      NetConst*tmp = new NetConst(scope,
				                      scope->local_symbol(),
						      tmpv);
			      des->add_node(tmp);
			      for (idx = cnt
					 ;  idx < lval->pin_count()
					 ; idx += 1)
				    connect(lval->pin(idx), tmp->pin(idx-cnt));
			}
		  }

	    } else {
		    /* Do need a driver. Use BUFZ objects to carry the
		       strength and delays. */
		  unsigned idx;
		  for (idx = 0 ; idx < cnt ;  idx += 1) {
			NetBUFZ*dev = new NetBUFZ(scope,scope->local_symbol());
			connect(lval->pin(idx), dev->pin(0));
			connect(rid->pin(idx), dev->pin(1));
			dev->rise_time(rise_time);
			dev->fall_time(fall_time);
			dev->decay_time(decay_time);
			dev->pin(0).drive0(drive0);
			dev->pin(0).drive1(drive1);
			des->add_node(dev);
		  }

		  if (cnt < lval->pin_count()) {
			if (lval->get_signed() && rid->get_signed()) {
			      for (idx = cnt
					 ;  idx < lval->pin_count()
					 ;  idx += 1)
				    connect(lval->pin(idx), lval->pin(cnt-1));

			} else {
			      NetConst*dev = new NetConst(scope,
					      scope->local_symbol(),
					      verinum::V0);
			
			      des->add_node(dev);
			      dev->pin(0).drive0(drive0);
			      dev->pin(0).drive1(drive1);
			      for (idx = cnt
					 ;  idx < lval->pin_count()
					 ; idx += 1)
				    connect(lval->pin(idx), dev->pin(0));
			}
		  }
	    }

	    return;
      }

	/* Elaborate the r-value. Account for the initial decays,
	   which are going to be attached to the last gate before the
	   generated NetNet. */
      NetNet*rval = pin(1)->elaborate_net(des, scope,
					  lval->pin_count(),
					  rise_time, fall_time, decay_time,
					  drive0, drive1);
      if (rval == 0) {
	    cerr << get_line() << ": error: Unable to elaborate r-value: "
		 << *pin(1) << endl;
	    des->errors += 1;
	    return;
      }

      assert(lval && rval);


	/* If the r-value insists on being smaller then the l-value
	   (perhaps it is explicitly sized) the pad it out to be the
	   right width so that something is connected to all the bits
	   of the l-value. */
      if (lval->pin_count() > rval->pin_count())
	    rval = pad_to_width(des, rval, lval->pin_count());

      for (unsigned idx = 0 ;  idx < lval->pin_count() ;  idx += 1)
	    connect(lval->pin(idx), rval->pin(idx));

      if (lval->local_flag())
	    delete lval;

}

/*
 * Elaborate a Builtin gate. These normally get translated into
 * NetLogic nodes that reflect the particular logic function.
 */
void PGBuiltin::elaborate(Design*des, NetScope*scope) const
{
      unsigned count = 1;
      long low = 0, high = 0;
      string name = string(get_name());

      if (name == "")
	    name = scope->local_symbol();

	/* If the Verilog source has a range specification for the
	   gates, then I am expected to make more then one
	   gate. Figure out how many are desired. */
      if (msb_) {
	    NetExpr*msb_exp = elab_and_eval(des, scope, msb_);
	    NetExpr*lsb_exp = elab_and_eval(des, scope, lsb_);

	    NetEConst*msb_con = dynamic_cast<NetEConst*>(msb_exp);
	    NetEConst*lsb_con = dynamic_cast<NetEConst*>(lsb_exp);

	    if (msb_con == 0) {
		  cerr << get_line() << ": error: Unable to evaluate "
			"expression " << *msb_ << endl;
		  des->errors += 1;
		  return;
	    }

	    if (lsb_con == 0) {
		  cerr << get_line() << ": error: Unable to evaluate "
			"expression " << *lsb_ << endl;
		  des->errors += 1;
		  return;
	    }

	    verinum msb = msb_con->value();
	    verinum lsb = lsb_con->value();

	    delete msb_exp;
	    delete lsb_exp;

	    if (msb.as_long() > lsb.as_long())
		  count = msb.as_long() - lsb.as_long() + 1;
	    else
		  count = lsb.as_long() - msb.as_long() + 1;

	    low = lsb.as_long();
	    high = msb.as_long();
      }


	/* Allocate all the netlist nodes for the gates. */
      NetLogic**cur = new NetLogic*[count];
      assert(cur);

	/* Calculate the gate delays from the delay expressions
	   given in the source. For logic gates, the decay time
	   is meaningless because it can never go to high
	   impedance. However, the bufif devices can generate
	   'bz output, so we will pretend that anything can.

	   If only one delay value expression is given (i.e., #5
	   nand(foo,...)) then rise, fall and decay times are
	   all the same value. If two values are given, rise and
	   fall times are use, and the decay time is the minimum
	   of the rise and fall times. Finally, if all three
	   values are given, they are taken as specified. */

      unsigned long rise_time, fall_time, decay_time;
      eval_delays(des, scope, rise_time, fall_time, decay_time);

      struct attrib_list_t*attrib_list = 0;
      unsigned attrib_list_n = 0;
      attrib_list = evaluate_attributes(attributes, attrib_list_n,
					des, scope);

	/* Now make as many gates as the bit count dictates. Give each
	   a unique name, and set the delay times. */

      for (unsigned idx = 0 ;  idx < count ;  idx += 1) {
	    ostringstream tmp;
	    unsigned index;
	    if (low < high)
		  index = low + idx;
	    else
		  index = low - idx;

	    tmp << name << "<" << index << ">";
	    perm_string inm = lex_strings.make(tmp.str());

	    switch (type()) {
		case AND:
		  cur[idx] = new NetLogic(scope, inm, pin_count(),
					  NetLogic::AND);
		  break;
		case BUF:
		  cur[idx] = new NetLogic(scope, inm, pin_count(),
					  NetLogic::BUF);
		  break;
		case BUFIF0:
		  cur[idx] = new NetLogic(scope, inm, pin_count(),
					  NetLogic::BUFIF0);
		  break;
		case BUFIF1:
		  cur[idx] = new NetLogic(scope, inm, pin_count(),
					  NetLogic::BUFIF1);
		  break;
		case NAND:
		  cur[idx] = new NetLogic(scope, inm, pin_count(),
					  NetLogic::NAND);
		  break;
		case NMOS:
		  cur[idx] = new NetLogic(scope, inm, pin_count(),
					  NetLogic::NMOS);
		  break;
		case NOR:
		  cur[idx] = new NetLogic(scope, inm, pin_count(),
					  NetLogic::NOR);
		  break;
		case NOT:
		  cur[idx] = new NetLogic(scope, inm, pin_count(),
					  NetLogic::NOT);
		  break;
		case NOTIF0:
		  cur[idx] = new NetLogic(scope, inm, pin_count(),
					  NetLogic::NOTIF0);
		  break;
		case NOTIF1:
		  cur[idx] = new NetLogic(scope, inm, pin_count(),
					  NetLogic::NOTIF1);
		  break;
		case OR:
		  cur[idx] = new NetLogic(scope, inm, pin_count(),
					  NetLogic::OR);
		  break;
		case RNMOS:
		  cur[idx] = new NetLogic(scope, inm, pin_count(),
					  NetLogic::RNMOS);
		  break;
		case RPMOS:
		  cur[idx] = new NetLogic(scope, inm, pin_count(),
					  NetLogic::RPMOS);
		  break;
		case PMOS:
		  cur[idx] = new NetLogic(scope, inm, pin_count(),
					  NetLogic::PMOS);
		  break;
		case PULLDOWN:
		  cur[idx] = new NetLogic(scope, inm, pin_count(),
					  NetLogic::PULLDOWN);
		  break;
		case PULLUP:
		  cur[idx] = new NetLogic(scope, inm, pin_count(),
					  NetLogic::PULLUP);
		  break;
		case XNOR:
		  cur[idx] = new NetLogic(scope, inm, pin_count(),
					  NetLogic::XNOR);
		  break;
		case XOR:
		  cur[idx] = new NetLogic(scope, inm, pin_count(),
					  NetLogic::XOR);
		  break;
		default:
		  cerr << get_line() << ": internal error: unhandled "
			"gate type." << endl;
		  des->errors += 1;
		  return;
	    }

	    for (unsigned adx = 0 ;  adx < attrib_list_n ;  adx += 1)
		  cur[idx]->attribute(attrib_list[adx].key,
				      attrib_list[adx].val);

	    cur[idx]->rise_time(rise_time);
	    cur[idx]->fall_time(fall_time);
	    cur[idx]->decay_time(decay_time);

	    cur[idx]->pin(0).drive0(drive_type(strength0()));
	    cur[idx]->pin(0).drive1(drive_type(strength1()));

	    des->add_node(cur[idx]);
      }


      delete[]attrib_list;

	/* The gates have all been allocated, this loop runs through
	   the parameters and attaches the ports of the objects. */

      for (unsigned idx = 0 ;  idx < pin_count() ;  idx += 1) {
	    const PExpr*ex = pin(idx);
	    NetNet*sig = (idx == 0)
		  ? ex->elaborate_lnet(des, scope, true)
		  : ex->elaborate_net(des, scope, 0, 0, 0, 0);
	    if (sig == 0)
		  continue;

	    assert(sig);

	    if (sig->pin_count() == 1)
		  for (unsigned gdx = 0 ;  gdx < count ;  gdx += 1)
			connect(cur[gdx]->pin(idx), sig->pin(0));

	    else if (sig->pin_count() == count)
		  for (unsigned gdx = 0 ;  gdx < count ;  gdx += 1)
			connect(cur[gdx]->pin(idx), sig->pin(gdx));

	    else {
		  cerr << get_line() << ": error: Gate count of " <<
			count << " does not match net width of " <<
			sig->pin_count() << " at pin " << idx << "."
		       << endl;
		  des->errors += 1;
	    }

	    if (NetSubnet*tmp = dynamic_cast<NetSubnet*>(sig))
		  delete tmp;
      }
}

/*
 * Instantiate a module by recursively elaborating it. Set the path of
 * the recursive elaboration so that signal names get properly
 * set. Connect the ports of the instantiated module to the signals of
 * the parameters. This is done with BUFZ gates so that they look just
 * like continuous assignment connections.
 */
void PGModule::elaborate_mod_(Design*des, Module*rmod, NetScope*scope) const
{
	// Missing module instance names have already been rejected.
      assert(get_name() != 0);

      if (msb_) {
	    cerr << get_line() << ": sorry: Module instantiation arrays "
		  "are not yet supported." << endl;
	    des->errors += 1;
	    return;
      }

      assert(scope);

	// I know a priori that the elaborate_scope created the scope
	// already, so just look it up as a child of the current scope.
      NetScope*my_scope = scope->child(get_name());
      assert(my_scope);

	// This is the array of pin expressions, shuffled to match the
	// order of the declaration. If the source instantiation uses
	// bind by order, this is the same as the source
	// list. Otherwise, the source list is rearranged by name
	// binding into this list.
      svector<PExpr*>pins (rmod->port_count());

	// Detect binding by name. If I am binding by name, then make
	// up a pins array that reflects the positions of the named
	// ports. If this is simply positional binding in the first
	// place, then get the binding from the base class.
      if (pins_) {
	    unsigned nexp = rmod->port_count();

	      // Scan the bindings, matching them with port names.
	    for (unsigned idx = 0 ;  idx < npins_ ;  idx += 1) {

		    // Given a binding, look at the module port names
		    // for the position that matches the binding name.
		  unsigned pidx = rmod->find_port(pins_[idx].name);

		    // If the port name doesn't exist, the find_port
		    // method will return the port count. Detect that
		    // as an error.
		  if (pidx == nexp) {
			cerr << get_line() << ": error: port ``" <<
			      pins_[idx].name << "'' is not a port of "
			     << get_name() << "." << endl;
			des->errors += 1;
			continue;
		  }

		    // If I already bound something to this port, then
		    // the (*exp) array will already have a pointer
		    // value where I want to place this expression.
		  if (pins[pidx]) {
			cerr << get_line() << ": error: port ``" <<
			      pins_[idx].name << "'' already bound." <<
			      endl;
			des->errors += 1;
			continue;
		  }

		    // OK, do the binding by placing the expression in
		    // the right place.
		  pins[pidx] = pins_[idx].parm;
	    }


      } else if (pin_count() == 0) {

	      /* Handle the special case that no ports are
		 connected. It is possible that this is an empty
		 connect-by-name list, so we'll allow it and assume
		 that is the case. */

	    for (unsigned idx = 0 ;  idx < rmod->port_count() ;  idx += 1)
		  pins[idx] = 0;

      } else {

	      /* Otherwise, this is a positional list of fort
		 connections. In this case, the port count must be
		 right. Check that is is, the get the pin list. */

	    if (pin_count() != rmod->port_count()) {
		  cerr << get_line() << ": error: Wrong number "
			"of ports. Expecting " << rmod->port_count() <<
			", got " << pin_count() << "."
		       << endl;
		  des->errors += 1;
		  return;
	    }

	      // No named bindings, just use the positional list I
	      // already have.
	    assert(pin_count() == rmod->port_count());
	    pins = get_pins();
      }

	// Elaborate this instance of the module. The recursive
	// elaboration causes the module to generate a netlist with
	// the ports represented by NetNet objects. I will find them
	// later.
      rmod->elaborate(des, my_scope);

	// Now connect the ports of the newly elaborated designs to
	// the expressions that are the instantiation parameters. Scan
	// the pins, elaborate the expressions attached to them, and
	// bind them to the port of the elaborated module.

	// This can get rather complicated because the port can be
	// unconnected (meaning an empty parameter is passed) connected
	// to a concatenation, or connected to an internally
	// unconnected port.

      for (unsigned idx = 0 ;  idx < pins.count() ;  idx += 1) {

	      // Skip unconnected module ports. This happens when a
	      // null parameter is passed in.

	    if (pins[idx] == 0) {

		    // While we're here, look to see if this
		    // unconnected (from the outside) port is an
		    // input. If so, consider printing a port binding
		    // warning.
		  if (warn_portbinding) {
			svector<PEIdent*> mport = rmod->get_port(idx);
			if (mport.count() == 0)
			      continue;

			NetNet*tmp = des->find_signal(my_scope,
						      mport[0]->path());
			assert(tmp);

			if (tmp->port_type() == NetNet::PINPUT) {
			      cerr << get_line() << ": warning: "
				   << "Instantiating module "
				   << rmod->mod_name()
				   << " with dangling input port "
				   << rmod->ports[idx]->name
				   << "." << endl;
			}
		  }

		  continue;
	    }



	      // Inside the module, the port is zero or more signals
	      // that were already elaborated. List all those signals
	      // and the NetNet equivalents.
	    svector<PEIdent*> mport = rmod->get_port(idx);
	    svector<NetNet*>prts (mport.count());

	      // Count the internal pins of the port.
	    unsigned prts_pin_count = 0;
	    for (unsigned ldx = 0 ;  ldx < mport.count() ;  ldx += 1) {
		  PEIdent*pport = mport[ldx];
		  assert(pport);
		  prts[ldx] = pport->elaborate_port(des, my_scope);
		  if (prts[ldx] == 0)
			continue;

		  assert(prts[ldx]);
		  prts_pin_count += prts[ldx]->pin_count();
	    }

	      // If I find that the port in unconnected inside the
	      // module, then there is nothing to connect. Skip the
	      // parameter.
	    if (prts_pin_count == 0) {
		  continue;
	    }

	      // Elaborate the expression that connects to the module
	      // port. sig is the thing outside the module that
	      // connects to the port.

	    NetNet*sig;
	    if ((prts.count() >= 1)
		&& (prts[0]->port_type() != NetNet::PINPUT)) {

		  sig = pins[idx]->elaborate_lnet(des, scope, true);
		  if (sig == 0) {
			cerr << pins[idx]->get_line() << ": error: "
			     << "Output port expression must support "
			     << "continuous assignment." << endl;
			cerr << pins[idx]->get_line() << ":      : "
			     << "Port of " << rmod->mod_name()
			     << " is " << rmod->ports[idx]->name << endl;
			des->errors += 1;
			continue;
		  }

	    } else {
		  sig = pins[idx]->elaborate_net(des, scope,
						    prts_pin_count,
						    0, 0, 0);
		  if (sig == 0) {
			cerr << pins[idx]->get_line()
			     << ": internal error: Port expression "
			     << "too complicated for elaboration." << endl;
			continue;
		  }
	    }

	    assert(sig);

#ifndef NDEBUG
	    if ((prts.count() >= 1)
		&& (prts[0]->port_type() != NetNet::PINPUT)) {
		  assert(sig->type() != NetNet::REG);
	    }
#endif

	      // Check that the parts have matching pin counts. If
	      // not, they are different widths. Note that idx is 0
	      // based, but users count parameter positions from 1.
	    if (prts_pin_count != sig->pin_count()) {
		  cerr << get_line() << ": warning: Port " << (idx+1)
		       << " (" << rmod->ports[idx]->name << ") of "
		       << type_ << " expects " << prts_pin_count <<
			" bits, got " << sig->pin_count() << "." << endl;

		  if (prts_pin_count > sig->pin_count()) {
			cerr << get_line() << ":        : Leaving "
			     << (prts_pin_count-sig->pin_count())
			     << " high bits of the port unconnected."
			     << endl;
		  } else {
			cerr << get_line() << ":        : Leaving "
			     << (sig->pin_count()-prts_pin_count)
			     << " high bits of the expression dangling."
			     << endl;
		  }
	    }

	      // Connect the sig expression that is the context of the
	      // module instance to the ports of the elaborated module.

	      // The prts_pin_count variable is the total width of the
	      // port and is the maximum number of connections to
	      // make. sig is the elaborated expression that connects
	      // to that port. If sig has too few pins, then reduce
	      // the number of connections to make.

	      // Connect this many of the port pins. If the expression
	      // is too small, the reduce the number of connects.
	    unsigned ccount = prts_pin_count;
	    if (sig->pin_count() < ccount)
		  ccount = sig->pin_count();

	      // Now scan the concatenation that makes up the port,
	      // connecting pins until we run out of port pins or sig
	      // pins.

	    unsigned spin = 0;
	    for (unsigned ldx = prts.count() ;  ldx > 0 ;  ldx -= 1) {
		  unsigned cnt = prts[ldx-1]->pin_count();
		  if (cnt > ccount)
			cnt = ccount;
		  for (unsigned p = 0 ;  p < cnt ;  p += 1) {
			connect(sig->pin(spin), prts[ldx-1]->pin(p));
			ccount -= 1;
			spin += 1;
		  }
		  if (ccount == 0)
			break;
	    }


	    if (NetSubnet*tmp = dynamic_cast<NetSubnet*>(sig))
		  delete tmp;
      }
}

/*
 * From a UDP definition in the source, make a NetUDP
 * object. Elaborate the pin expressions as netlists, then connect
 * those networks to the pins.
 */

void PGModule::elaborate_udp_(Design*des, PUdp*udp, NetScope*scope) const
{

      perm_string my_name = get_name();
      if (my_name == 0)
	    my_name = scope->local_symbol();

	/* When the parser notices delay expressions in front of a
	   module or primitive, it interprets them as parameter
	   overrides. Correct that misconception here. */
      unsigned long rise_time = 0, fall_time = 0, decay_time = 0;
      if (overrides_) {
	    PDelays tmp_del;
	    tmp_del.set_delays(overrides_, false);
	    tmp_del.eval_delays(des, scope, rise_time, fall_time, decay_time);
      }


      assert(udp);
      NetUDP*net = new NetUDP(scope, my_name, udp->ports.count(), udp);
      net->rise_time(rise_time);
      net->fall_time(fall_time);
      net->decay_time(decay_time);

      struct attrib_list_t*attrib_list = 0;
      unsigned attrib_list_n = 0;
      attrib_list = evaluate_attributes(attributes, attrib_list_n,
					des, scope);

      for (unsigned adx = 0 ;  adx < attrib_list_n ;  adx += 1)
	    net->attribute(attrib_list[adx].key, attrib_list[adx].val);

      delete[]attrib_list;


	// This is the array of pin expressions, shuffled to match the
	// order of the declaration. If the source instantiation uses
	// bind by order, this is the same as the source
	// list. Otherwise, the source list is rearranged by name
	// binding into this list.
      svector<PExpr*>pins;

	// Detect binding by name. If I am binding by name, then make
	// up a pins array that reflects the positions of the named
	// ports. If this is simply positional binding in the first
	// place, then get the binding from the base class.
      if (pins_) {
	    unsigned nexp = udp->ports.count();
	    pins = svector<PExpr*>(nexp);

	      // Scan the bindings, matching them with port names.
	    for (unsigned idx = 0 ;  idx < npins_ ;  idx += 1) {

		    // Given a binding, look at the module port names
		    // for the position that matches the binding name.
		  unsigned pidx = udp->find_port(pins_[idx].name);

		    // If the port name doesn't exist, the find_port
		    // method will return the port count. Detect that
		    // as an error.
		  if (pidx == nexp) {
			cerr << get_line() << ": error: port ``" <<
			      pins_[idx].name << "'' is not a port of "
			     << get_name() << "." << endl;
			des->errors += 1;
			continue;
		  }

		    // If I already bound something to this port, then
		    // the (*exp) array will already have a pointer
		    // value where I want to place this expression.
		  if (pins[pidx]) {
			cerr << get_line() << ": error: port ``" <<
			      pins_[idx].name << "'' already bound." <<
			      endl;
			des->errors += 1;
			continue;
		  }

		    // OK, do the binding by placing the expression in
		    // the right place.
		  pins[pidx] = pins_[idx].parm;
	    }

      } else {

	      /* Otherwise, this is a positional list of port
		 connections. In this case, the port count must be
		 right. Check that is is, the get the pin list. */

	    if (pin_count() != udp->ports.count()) {
		  cerr << get_line() << ": error: Wrong number "
			"of ports. Expecting " << udp->ports.count() <<
			", got " << pin_count() << "."
		       << endl;
		  des->errors += 1;
		  return;
	    }

	      // No named bindings, just use the positional list I
	      // already have.
	    assert(pin_count() == udp->ports.count());
	    pins = get_pins();
      }


	/* Handle the output port of the primitive special. It is an
	   output port (the only output port) so must be passed an
	   l-value net. */
      if (pins[0] == 0) {
	    cerr << get_line() << ": warning: output port unconnected."
		 << endl;

      } else {
	    NetNet*sig = pins[0]->elaborate_lnet(des, scope, true);
	    if (sig == 0) {
		  cerr << get_line() << ": error: "
		       << "Output port expression is not valid." << endl;
		  cerr << get_line() << ":      : Output "
		       << "port of " << udp->name_
		       << " is " << udp->ports[0] << "." << endl;
		  des->errors += 1;
	    } else {
		  connect(sig->pin(0), net->pin(0));
	    }
      }

	/* Run through the pins, making netlists for the pin
	   expressions and connecting them to the pin in question. All
	   of this is independent of the nature of the UDP. */
      for (unsigned idx = 1 ;  idx < net->pin_count() ;  idx += 1) {
	    if (pins[idx] == 0)
		  continue;

	    NetNet*sig = pins[idx]->elaborate_net(des, scope, 1, 0, 0, 0);
	    if (sig == 0) {
		  cerr << "internal error: Expression too complicated "
			"for elaboration:" << pins[idx] << endl;
		  continue;
	    }

	    connect(sig->pin(0), net->pin(idx));

	      // Delete excess holding signal.
	    if (NetSubnet*tmp = dynamic_cast<NetSubnet*>(sig))
		  delete tmp;
      }
      
	// All done. Add the object to the design.
      des->add_node(net);
}


bool PGModule::elaborate_sig(Design*des, NetScope*scope) const
{
	// Look for the module type
      map<perm_string,Module*>::const_iterator mod = pform_modules.find(type_);
      if (mod != pform_modules.end())
	    return elaborate_sig_mod_(des, scope, (*mod).second);

      return true;
}


void PGModule::elaborate(Design*des, NetScope*scope) const
{
	// Look for the module type
      map<perm_string,Module*>::const_iterator mod = pform_modules.find(type_);
      if (mod != pform_modules.end()) {
	    elaborate_mod_(des, (*mod).second, scope);
	    return;
      }

	// Try a primitive type
      map<perm_string,PUdp*>::const_iterator udp = pform_primitives.find(type_);
      if (udp != pform_primitives.end()) {
	    assert((*udp).second);
	    elaborate_udp_(des, (*udp).second, scope);
	    return;
      }

      cerr << get_line() << ": internal error: Unknown module type: " <<
	    type_ << endl;
}

void PGModule::elaborate_scope(Design*des, NetScope*sc) const
{
	// Look for the module type
      map<perm_string,Module*>::const_iterator mod = pform_modules.find(type_);
      if (mod != pform_modules.end()) {
	    elaborate_scope_mod_(des, (*mod).second, sc);
	    return;
      }

	// Try a primitive type
      map<perm_string,PUdp*>::const_iterator udp = pform_primitives.find(type_);
      if (udp != pform_primitives.end())
	    return;

	// Not a module or primitive that I know about yet, so try to
	// load a library module file (which parses some new Verilog
	// code) and try again.
      if (load_module(type_)) {

	      // Try again to find the module type
	    mod = pform_modules.find(type_);
	    if (mod != pform_modules.end()) {
		  elaborate_scope_mod_(des, (*mod).second, sc);
		  return;
	    }

	      // Try again to find a primitive type
	    udp = pform_primitives.find(type_);
	    if (udp != pform_primitives.end())
		  return;
      }


	// Not a module or primitive that I know about or can find by
	// any means, so give up.
      cerr << get_line() << ": error: Unknown module type: " << type_ << endl;
      missing_modules[type_] += 1;
      des->errors += 1;
}


NetProc* Statement::elaborate(Design*des, NetScope*) const
{
      cerr << get_line() << ": internal error: elaborate: "
	    "What kind of statement? " << typeid(*this).name() << endl;
      NetProc*cur = new NetProc;
      des->errors += 1;
      return cur;
}


NetAssign_* PAssign_::elaborate_lval(Design*des, NetScope*scope) const
{
      assert(lval_);
      return lval_->elaborate_lval(des, scope);
}

/*
 * This function elaborates delay expressions. This is a little
 * different from normal elaboration because the result may need to be
 * scaled.
 */
static NetExpr*elaborate_delay_expr(PExpr*expr, Design*des, NetScope*scope)
{
      NetExpr*dex = elab_and_eval(des, scope, expr);

	/* If the delay expression is a real constant or vector
	   constant, then evaluate it, scale it to the local time
	   units, and return an adjusted NetEConst. */

      if (NetECReal*tmp = dynamic_cast<NetECReal*>(dex)) {
	    verireal fn = tmp->value();

	    int shift = scope->time_unit() - des->get_precision();
	    long delay = fn.as_long(shift);
	    if (delay < 0)
		  delay = 0;

	    delete tmp;
	    return new NetEConst(verinum(delay));
      }


      if (NetEConst*tmp = dynamic_cast<NetEConst*>(dex)) {
	    verinum fn = tmp->value();

	    unsigned long delay =
		  des->scale_to_precision(fn.as_ulong(), scope);

	    delete tmp;
	    return new NetEConst(verinum(delay));
      }


	/* The expression is not constant, so generate an expanded
	   expression that includes the necessary scale shifts, and
	   return that expression. */
      int shift = scope->time_unit() - des->get_precision();
      if (shift > 0) {
	    unsigned long scale = 1;
	    while (shift > 0) {
		  scale *= 10;
		  shift -= 1;
	    }

	    NetExpr*scal_val = new NetEConst(verinum(scale));
	    dex = new NetEBMult('*', dex, scal_val);
      }

      if (shift < 0) {
	    unsigned long scale = 1;
	    while (shift < 0) {
		  scale *= 10;
		  shift += 1;
	    }

	    NetExpr*scal_val = new NetEConst(verinum(scale));
	    dex = new NetEBDiv('/', dex, scal_val);
      }

      return dex;
}

NetProc* PAssign::elaborate(Design*des, NetScope*scope) const
{
      assert(scope);

	/* elaborate the lval. This detects any part selects and mux
	   expressions that might exist. */
      NetAssign_*lv = elaborate_lval(des, scope);
      if (lv == 0) return 0;

	/* If there is an internal delay expression, elaborate it. */
      NetExpr*delay = 0;
      if (delay_ != 0)
	    delay = elaborate_delay_expr(delay_, des, scope);


	/* Elaborate the r-value expression, then try to evaluate it. */

      assert(rval());
      NetExpr*rv = elab_and_eval(des, scope, rval());
      if (rv == 0) return 0;
      assert(rv);


	/* Rewrite delayed assignments as assignments that are
	   delayed. For example, a = #<d> b; becomes:

	     begin
	        tmp = b;
		#<d> a = tmp;
	     end

	   If the delay is an event delay, then the transform is
	   similar, with the event delay replacing the time delay. It
	   is an event delay if the event_ member has a value.

	   This rewriting of the expression allows me to not bother to
	   actually and literally represent the delayed assign in the
	   netlist. The compound statement is exactly equivalent. */

      if (delay || event_) {
	    unsigned wid = lv->lwidth();

	    rv->set_width(wid);
	    rv = pad_to_width(rv, wid);

	    if (wid > rv->expr_width()) {
		  cerr << get_line() << ": error: Unable to match "
			"expression width of " << rv->expr_width() <<
			" to l-value width of " << wid << "." << endl;
		    //XXXX delete rv;
		  return 0;
	    }

	    NetNet*tmp = new NetNet(scope, scope->local_symbol(),
				    NetNet::REG, wid);
	    tmp->set_line(*this);

	    NetESignal*sig = new NetESignal(tmp);

	      /* Generate an assignment of the l-value to the temporary... */
	    string n = scope->local_hsymbol();
	    NetAssign_*lvt = new NetAssign_(tmp);

	    NetAssign*a1 = new NetAssign(lvt, rv);
	    a1->set_line(*this);

	      /* Generate an assignment of the temporary to the r-value... */
	    NetAssign*a2 = new NetAssign(lv, sig);
	    a2->set_line(*this);

	      /* Generate the delay statement with the final
		 assignment attached to it. If this is an event delay,
		 elaborate the PEventStatement. Otherwise, create the
		 right NetPDelay object. */
	    NetProc*st;
	    if (event_) {
		  st = event_->elaborate_st(des, scope, a2);
		  if (st == 0) {
			cerr << event_->get_line() << ": error: "
			      "unable to elaborate event expression."
			     << endl;
			des->errors += 1;
			return 0;
		  }
		  assert(st);

	    } else {
		  NetPDelay*de = new NetPDelay(delay, a2);
		  st = de;
	    }

	      /* And build up the complex statement. */
	    NetBlock*bl = new NetBlock(NetBlock::SEQU, 0);
	    bl->append(a1);
	    bl->append(st);

	    return bl;
      }

	/* Based on the specific type of the l-value, do cleanup
	   processing on the r-value. */
      if (lv->var()) {

      } else if (rv->expr_type() == NetExpr::ET_REAL) {

	      // The r-value is a real. Casting will happen in the
	      // code generator, so leave it.

      } else {
	    unsigned wid = count_lval_width(lv);
	    rv->set_width(wid);
	    rv = pad_to_width(rv, wid);
	    assert(rv->expr_width() >= wid);
      }

      NetAssign*cur = new NetAssign(lv, rv);
      cur->set_line(*this);

      return cur;
}

/*
 */
NetProc* PAssignNB::elaborate(Design*des, NetScope*scope) const
{
      assert(scope);

	/* Elaborate the l-value. */
      NetAssign_*lv = elaborate_lval(des, scope);
      if (lv == 0) return 0;

      assert(rval());

	/* Elaborate and precalculate the r-value. */
      NetExpr*rv = elab_and_eval(des, scope, rval());
      if (rv == 0)
	    return 0;


      { unsigned wid = count_lval_width(lv);
        rv->set_width(wid);
	rv = pad_to_width(rv, wid);
      }

      NetExpr*delay = 0;
      if (delay_ != 0)
	    delay = elaborate_delay_expr(delay_, des, scope);

	/* All done with this node. Mark its line number and check it in. */
      NetAssignNB*cur = new NetAssignNB(lv, rv);
      cur->set_delay(delay);
      cur->set_line(*this);
      return cur;
}


/*
 * This is the elaboration method for a begin-end block. Try to
 * elaborate the entire block, even if it fails somewhere. This way I
 * get all the error messages out of it. Then, if I detected a failure
 * then pass the failure up.
 */
NetProc* PBlock::elaborate(Design*des, NetScope*scope) const
{
      assert(scope);

      NetBlock::Type type = (bl_type_==PBlock::BL_PAR)
	    ? NetBlock::PARA
	    : NetBlock::SEQU;

      NetScope*nscope = 0;
      if (name_.str() != 0) {
	    nscope = scope->child(name_);
	    if (nscope == 0) {
		  cerr << get_line() << ": internal error: "
			"unable to find block scope " << scope->name()
		       << "<" << name_ << ">" << endl;
		  des->errors += 1;
		  return 0;
	    }

	    assert(nscope);

      }

      NetBlock*cur = new NetBlock(type, nscope);
      bool fail_flag = false;

      if (nscope == 0)
	    nscope = scope;

	// Handle the special case that the block contains only one
	// statement. There is no need to keep the block node. Also,
	// don't elide named blocks, because they might be referenced
	// elsewhere.
      if ((list_.count() == 1) && (name_.str() == 0)) {
	    assert(list_[0]);
	    NetProc*tmp = list_[0]->elaborate(des, nscope);
	    return tmp;
      }

      for (unsigned idx = 0 ;  idx < list_.count() ;  idx += 1) {
	    assert(list_[idx]);
	    NetProc*tmp = list_[idx]->elaborate(des, nscope);
	    if (tmp == 0) {
		  fail_flag = true;
		  continue;
	    }

	      // If the result turns out to be a noop, then skip it.
	    if (NetBlock*tbl = dynamic_cast<NetBlock*>(tmp))
		  if (tbl->proc_first() == 0) {
			delete tbl;
			continue;
		  }

	    cur->append(tmp);
      }

      if (fail_flag) {
	    delete cur;
	    cur = 0;
      }

      return cur;
}

/*
 * Elaborate a case statement.
 */
NetProc* PCase::elaborate(Design*des, NetScope*scope) const
{
      assert(scope);

      NetExpr*expr = elab_and_eval(des, scope, expr_);
      if (expr == 0) {
	    cerr << get_line() << ": error: Unable to elaborate this case"
		  " expression." << endl;
	    return 0;
      }

	/* Count the items in the case statement. Note that there may
	   be some cases that have multiple guards. Count each as a
	   separate item. */
      unsigned icount = 0;
      for (unsigned idx = 0 ;  idx < items_->count() ;  idx += 1) {
	    PCase::Item*cur = (*items_)[idx];

	    if (cur->expr.count() == 0)
		  icount += 1;
	    else
		  icount += cur->expr.count();
      }

      NetCase*res = new NetCase(type_, expr, icount);
      res->set_line(*this);

	/* Iterate over all the case items (guard/statement pairs)
	   elaborating them. If the guard has no expression, then this
	   is a "default" cause. Otherwise, the guard has one or more
	   expressions, and each guard is a case. */
      unsigned inum = 0;
      for (unsigned idx = 0 ;  idx < items_->count() ;  idx += 1) {

	    assert(inum < icount);
	    PCase::Item*cur = (*items_)[idx];

	    if (cur->expr.count() == 0) {
		    /* If there are no expressions, then this is the
		       default case. */
		  NetProc*st = 0;
		  if (cur->stat)
			st = cur->stat->elaborate(des, scope);

		  res->set_case(inum, 0, st);
		  inum += 1;

	    } else for (unsigned e = 0; e < cur->expr.count(); e += 1) {

		    /* If there are one or more expressions, then
		       iterate over the guard expressions, elaborating
		       a separate case for each. (Yes, the statement
		       will be elaborated again for each.) */
		  NetExpr*gu = 0;
		  NetProc*st = 0;
		  assert(cur->expr[e]);
		  gu = elab_and_eval(des, scope, cur->expr[e]);

		  if (cur->stat)
			st = cur->stat->elaborate(des, scope);

		  res->set_case(inum, gu, st);
		  inum += 1;
	    }
      }

      return res;
}

NetProc* PCondit::elaborate(Design*des, NetScope*scope) const
{
      assert(scope);

	// Elaborate and try to evaluate the conditional expression.
      NetExpr*expr = elab_and_eval(des, scope, expr_);
      if (expr == 0) {
	    cerr << get_line() << ": error: Unable to elaborate"
		  " condition expression." << endl;
	    des->errors += 1;
	    return 0;
      }

	// If the condition of the conditional statement is constant,
	// then look at the value and elaborate either the if statement
	// or the else statement. I don't need both. If there is no
	// else_ statement, the use an empty block as a noop.
      if (NetEConst*ce = dynamic_cast<NetEConst*>(expr)) {
	    verinum val = ce->value();
	    delete expr;
	    if (val[0] == verinum::V1)
		  return if_->elaborate(des, scope);
	    else if (else_)
		  return else_->elaborate(des, scope);
	    else
		  return new NetBlock(NetBlock::SEQU, 0);
      }

	// If the condition expression is more then 1 bits, then
	// generate a comparison operator to get the result down to
	// one bit. Turn <e> into <e> != 0;

      if (expr->expr_width() < 1) {
	    cerr << get_line() << ": internal error: "
		  "incomprehensible expression width (0)." << endl;
	    return 0;
      }

      if (expr->expr_width() > 1) {
	    assert(expr->expr_width() > 1);
	    verinum zero (verinum::V0, expr->expr_width());
	    NetEConst*ezero = new NetEConst(zero);
	    ezero->set_width(expr->expr_width());
	    NetEBComp*cmp = new NetEBComp('n', expr, ezero);
	    expr = cmp;
      }

	// Well, I actually need to generate code to handle the
	// conditional, so elaborate.
      NetProc*i = if_? if_->elaborate(des, scope) : 0;
      NetProc*e = else_? else_->elaborate(des, scope) : 0;

	// Detect the special cases that the if or else statements are
	// empty blocks. If this is the case, remove the blocks as
	// null statements.
      if (NetBlock*tmp = dynamic_cast<NetBlock*>(i)) {
	    if (tmp->proc_first() == 0) {
		  delete i;
		  i = 0;
	    }
      }

      if (NetBlock*tmp = dynamic_cast<NetBlock*>(e)) {
	    if (tmp->proc_first() == 0) {
		  delete e;
		  e = 0;
	    }
      }

      NetCondit*res = new NetCondit(expr, i, e);
      res->set_line(*this);
      return res;
}

NetProc* PCallTask::elaborate(Design*des, NetScope*scope) const
{
      if (path_.peek_name(0)[0] == '$')
	    return elaborate_sys(des, scope);
      else
	    return elaborate_usr(des, scope);
}

/*
 * A call to a system task involves elaborating all the parameters,
 * then passing the list to the NetSTask object.
 *XXXX
 * There is a single special case in the call to a system
 * task. Normally, an expression cannot take an unindexed
 * memory. However, it is possible to take a system task parameter a
 * memory if the expression is trivial.
 */
NetProc* PCallTask::elaborate_sys(Design*des, NetScope*scope) const
{
      assert(scope);

      unsigned parm_count = nparms();

	/* Catch the special case that the system task has no
	   parameters. The "()" string will be parsed as a single
	   empty parameter, when we really mean no parameters at all. */
      if ((nparms() == 1) && (parm(0) == 0))
	    parm_count = 0;

      svector<NetExpr*>eparms (parm_count);

      for (unsigned idx = 0 ;  idx < parm_count ;  idx += 1) {
	    PExpr*ex = parm(idx);
	    eparms[idx] = ex? ex->elaborate_expr(des, scope, true) : 0;

	      /* Attempt to pre-evaluate the parameters. It may be
		 possible to at least partially reduce the
		 expression. */
	    if (eparms[idx] && !dynamic_cast<NetEConst*>(eparms[idx])) {
		  NetExpr*tmp = eparms[idx]->eval_tree();
		  if (tmp != 0) {
			delete eparms[idx];
			eparms[idx] = tmp;
		  }
	    }
      }

      NetSTask*cur = new NetSTask(path_.peek_name(0), eparms);
      return cur;
}

/*
 * A call to a user defined task is different from a call to a system
 * task because a user task in a netlist has no parameters: the
 * assignments are done by the calling thread. For example:
 *
 *  task foo;
 *    input a;
 *    output b;
 *    [...]
 *  endtask;
 *
 *  [...] foo(x, y);
 *
 * is really:
 *
 *  task foo;
 *    reg a;
 *    reg b;
 *    [...]
 *  endtask;
 *
 *  [...]
 *  begin
 *    a = x;
 *    foo;
 *    y = b;
 *  end
 */
NetProc* PCallTask::elaborate_usr(Design*des, NetScope*scope) const
{
      assert(scope);

      NetScope*task = des->find_task(scope, path_);
      if (task == 0) {
	    cerr << get_line() << ": error: Enable of unknown task "
		 << "``" << path_ << "''." << endl;
	    des->errors += 1;
	    return 0;
      }

      assert(task);
      assert(task->type() == NetScope::TASK);
      NetTaskDef*def = task->task_def();
      if (def == 0) {
	    cerr << get_line() << ": internal error: task " << path_
		 << " doesn't have a definition in " << scope->name()
		 << "." << endl;
	    des->errors += 1;
	    return 0;
      }
      assert(def);

      if (nparms() != def->port_count()) {
	    cerr << get_line() << ": error: Port count mismatch in call to ``"
		 << path_ << "''." << endl;
	    des->errors += 1;
	    return 0;
      }

      NetUTask*cur;

	/* Handle tasks with no parameters specially. There is no need
	   to make a sequential block to hold the generated code. */
      if (nparms() == 0) {
	    cur = new NetUTask(task);
	    return cur;
      }

      NetBlock*block = new NetBlock(NetBlock::SEQU, 0);


	/* Detect the case where the definition of the task is known
	   empty. In this case, we need not bother with calls to the
	   task, all the assignments, etc. Just return a no-op. */

      if (const NetBlock*tp = dynamic_cast<const NetBlock*>(def->proc())) {
	    if (tp->proc_first() == 0)
		  return block;
      }

	/* Generate assignment statement statements for the input and
	   INOUT ports of the task. These are managed by writing
	   assignments with the task port the l-value and the passed
	   expression the r-value. We know by definition that the port
	   is a reg type, so this elaboration is pretty obvious. */

      for (unsigned idx = 0 ;  idx < nparms() ;  idx += 1) {

	    NetNet*port = def->port(idx);
	    assert(port->port_type() != NetNet::NOT_A_PORT);
	    if (port->port_type() == NetNet::POUTPUT)
		  continue;

	    NetExpr*rv = elab_and_eval(des, scope, parms_[idx]);
	    NetAssign_*lv = new NetAssign_(port);
	    NetAssign*pr = new NetAssign(lv, rv);
	    block->append(pr);
      }

	/* Generate the task call proper... */
      cur = new NetUTask(task);
      block->append(cur);


	/* Generate assignment statements for the output and INOUT
	   ports of the task. The l-value in this case is the
	   expression passed as a parameter, and the r-value is the
	   port to be copied out.

	   We know by definition that the r-value of this copy-out is
	   the port, which is a reg. The l-value, however, may be any
	   expression that can be a target to a procedural
	   assignment, including a memory word. */

      for (unsigned idx = 0 ;  idx < nparms() ;  idx += 1) {

	    NetNet*port = def->port(idx);

	      /* Skip input ports. */
	    assert(port->port_type() != NetNet::NOT_A_PORT);
	    if (port->port_type() == NetNet::PINPUT)
		  continue;


	      /* Elaborate an l-value version of the port expression
		 for output and inout ports. If the expression does
		 not exist then quietly skip it, but if the expression
		 is not a valid l-value print an error message. Note
		 that the elaborate_lval method already printed a
		 detailed message. */
	    NetAssign_*lv;
	    if (parms_[idx]) {
		  lv = parms_[idx]->elaborate_lval(des, scope);
		  if (lv == 0) {
			cerr << parms_[idx]->get_line() << ": error: "
			     << "I give up on task port " << (idx+1)
			     << " expression: " << *parms_[idx] << endl;
		  }
	    } else {
		  lv = 0;
	    }

	    if (lv == 0)
		  continue;

	    NetESignal*sig = new NetESignal(port);

	      /* Generate the assignment statement. */
	    NetAssign*ass = new NetAssign(lv, sig);

	    block->append(ass);
      }

      return block;
}

NetCAssign* PCAssign::elaborate(Design*des, NetScope*scope) const
{
      assert(scope);

      NetNet*lval = lval_->elaborate_anet(des, scope);
      if (lval == 0)
	    return 0;

      NetNet*rval = expr_->elaborate_net(des, scope, lval->pin_count(),
					 0, 0, 0);
      if (rval == 0)
	    return 0;

      if (rval->pin_count() < lval->pin_count())
	    rval = pad_to_width(des, rval, lval->pin_count());

      NetCAssign* dev = new NetCAssign(scope, scope->local_symbol(), lval);
      dev->set_line(*this);
      des->add_node(dev);

      for (unsigned idx = 0 ;  idx < dev->pin_count() ;  idx += 1)
	    connect(dev->pin(idx), rval->pin(idx));

      return dev;
}

NetDeassign* PDeassign::elaborate(Design*des, NetScope*scope) const
{
      assert(scope);

      NetNet*lval = lval_->elaborate_anet(des, scope);
      if (lval == 0)
	    return 0;

      NetDeassign*dev = new NetDeassign(lval);
      dev->set_line( *this );
      return dev;
}

/*
 * Elaborate the delay statement (of the form #<expr> <statement>) as a
 * NetPDelay object. If the expression is constant, evaluate it now
 * and make a constant delay. If not, then pass an elaborated
 * expression to the constructor of NetPDelay so that the code
 * generator knows to evaluate the expression at run time.
 */
NetProc* PDelayStatement::elaborate(Design*des, NetScope*scope) const
{
      assert(scope);

	/* This call evaluates the delay expression to a NetEConst, if
	   possible. This includes transforming NetECReal values to
	   integers, and applying the proper scaling. */
      NetExpr*dex = elaborate_delay_expr(delay_, des, scope);

      if (NetEConst*tmp = dynamic_cast<NetEConst*>(dex)) {
	    if (statement_)
		  return new NetPDelay(tmp->value().as_ulong(),
				       statement_->elaborate(des, scope));
	    else
		  return new NetPDelay(tmp->value().as_ulong(), 0);

	    delete dex;

      } else {
	    if (statement_)
		  return new NetPDelay(dex, statement_->elaborate(des, scope));
	    else
		  return new NetPDelay(dex, 0);
      }

}

/*
 * The disable statement is not yet supported.
 */
NetProc* PDisable::elaborate(Design*des, NetScope*scope) const
{
      assert(scope);

      NetScope*target = des->find_scope(scope, scope_);
      if (target == 0) {
	    cerr << get_line() << ": error: Cannot find scope "
		 << scope_ << " in " << scope->name() << endl;
	    des->errors += 1;
	    return 0;
      }

      switch (target->type()) {
	  case NetScope::FUNC:
	    cerr << get_line() << ": error: Cannot disable functions." << endl;
	    des->errors += 1;
	    return 0;

	  case NetScope::MODULE:
	    cerr << get_line() << ": error: Cannot disable modules." << endl;
	    des->errors += 1;
	    return 0;

	  default:
	    break;
      }

      NetDisable*obj = new NetDisable(target);
      obj->set_line(*this);
      return obj;
}

/*
 * An event statement is an event delay of some sort, attached to a
 * statement. Some Verilog examples are:
 *
 *      @(posedge CLK) $display("clock rise");
 *      @event_1 $display("event triggered.");
 *      @(data or negedge clk) $display("data or clock fall.");
 *
 * The elaborated netlist uses the NetEvent, NetEvWait and NetEvProbe
 * classes. The NetEvWait class represents the part of the netlist
 * that is executed by behavioral code. The process starts waiting on
 * the NetEvent when it executes the NetEvWait step. Net NetEvProbe
 * and NetEvTrig are structural and behavioral equivalents that
 * trigger the event, and awakens any processes blocking in the
 * associated wait.
 *
 * The basic data structure is:
 *
 *       NetEvWait ---/--->  NetEvent  <----\---- NetEvProbe
 *        ...         |                     |         ...
 *       NetEvWait ---+                     +---- NetEvProbe
 *                                          |         ...
 *                                          +---- NetEvTrig
 *
 * That is, many NetEvWait statements may wait on a single NetEvent
 * object, and Many NetEvProbe objects may trigger the NetEvent
 * object. The many NetEvWait objects pointing to the NetEvent object
 * reflects the possibility of different places in the code blocking
 * on the same named event, like so:
 *
 *         event foo;
 *           [...]
 *         always begin @foo <statement1>; @foo <statement2> end
 *
 * This tends to not happen with signal edges. The multiple probes
 * pointing to the same event reflect the possibility of many
 * expressions in the same blocking statement, like so:
 *
 *         wire reset, clk;
 *           [...]
 *         always @(reset or posedge clk) <stmt>;
 *
 * Conjunctions like this cause a NetEvent object be created to
 * represent the overall conjunction, and NetEvProbe objects for each
 * event expression.
 *
 * If the NetEvent object represents a named event from the source,
 * then there are NetEvTrig objects that represent the trigger
 * statements instead of the NetEvProbe objects representing signals.
 * For example:
 *
 *         event foo;
 *         always @foo <stmt>;
 *         initial begin
 *                [...]
 *            -> foo;
 *                [...]
 *            -> foo;
 *                [...]
 *         end
 *
 * Each trigger statement in the source generates a separate NetEvTrig
 * object in the netlist. Those trigger objects are elaborated
 * elsewhere.
 *
 * Additional complications arise when named events show up in
 * conjunctions. An example of such a case is:
 *
 *         event foo;
 *         wire bar;
 *         always @(foo or posedge bar) <stmt>;
 *
 * Since there is by definition a NetEvent object for the foo object,
 * this is handled by allowing the NetEvWait object to point to
 * multiple NetEvent objects. All the NetEvProbe based objects are
 * collected and pointed as the synthetic NetEvent object, and all the
 * named events are added into the list of NetEvent object that the
 * NetEvWait object can refer to.
 */

NetProc* PEventStatement::elaborate_st(Design*des, NetScope*scope,
				       NetProc*enet) const
{
      assert(scope);

	/* Create a single NetEvent and NetEvWait. Then, create a
	   NetEvProbe for each conjunctive event in the event
	   list. The NetEvProbe objects all refer back to the NetEvent
	   object. */

      NetEvent*ev = new NetEvent(scope->local_symbol());
      ev->set_line(*this);
      unsigned expr_count = 0;

      NetEvWait*wa = new NetEvWait(enet);
      wa->set_line(*this);

	/* If there are no expressions, this is a signal that it is an
	   @* statement. Generate an expression to use. */

      if (expr_.count() == 0) {
	    assert(enet);
	    NexusSet*nset = enet->nex_input();
	    if (nset == 0) {
		  cerr << get_line() << ": internal error: No NexusSet"
		       << " from statement." << endl;
		  enet->dump(cerr, 6);
		  des->errors += 1;
		  return enet;
	    }

	    if (nset->count() == 0) {
		  cerr << get_line() << ": warning: No inputs to statement."
		       << " Ignoring @*." << endl;
		  return enet;
	    }

	    NetEvProbe*pr = new NetEvProbe(scope, scope->local_symbol(),
					   ev, NetEvProbe::ANYEDGE,
					   nset->count());
	    for (unsigned idx = 0 ;  idx < nset->count() ;  idx += 1)
		  connect(nset[0][idx], pr->pin(idx));

	    delete nset;
	    des->add_node(pr);

	    expr_count = 1;

      } else for (unsigned idx = 0 ;  idx < expr_.count() ;  idx += 1) {

	    assert(expr_[idx]->expr());

	      /* If the expression is an identifier that matches a
		 named event, then handle this case all at once at
		 skip the rest of the expression handling. */

	    if (PEIdent*id = dynamic_cast<PEIdent*>(expr_[idx]->expr())) {
		  NetNet*       sig = 0;
		  NetMemory*    mem = 0;
		  NetVariable*  var = 0;
		  const NetExpr*par = 0;
		  NetEvent*     eve = 0;

		  NetScope*found_in = symbol_search(des, scope, id->path(),
						    sig, mem, var, par, eve);

		  if (found_in && eve) {
			wa->add_event(eve);
			continue;
		  }
	    }


	      /* So now we have a normal event expression. Elaborate
		 the sub-expression as a net and decide how to handle
		 the edge. */

	    bool save_flag = error_implicit;
	    error_implicit = true;
	    NetNet*expr = expr_[idx]->expr()->elaborate_net(des, scope,
							    0, 0, 0, 0);
	    error_implicit = save_flag;
	    if (expr == 0) {
		  expr_[idx]->dump(cerr);
		  cerr << endl;
		  des->errors += 1;
		  continue;
	    }
	    assert(expr);

	    unsigned pins = (expr_[idx]->type() == PEEvent::ANYEDGE)
		  ? expr->pin_count() : 1;

	    NetEvProbe*pr;
	    switch (expr_[idx]->type()) {
		case PEEvent::POSEDGE:
		  pr = new NetEvProbe(scope, scope->local_symbol(), ev,
				      NetEvProbe::POSEDGE, pins);
		  break;

		case PEEvent::NEGEDGE:
		  pr = new NetEvProbe(scope, scope->local_symbol(), ev,
				      NetEvProbe::NEGEDGE, pins);
		  break;

		case PEEvent::ANYEDGE:
		  pr = new NetEvProbe(scope, scope->local_symbol(), ev,
				      NetEvProbe::ANYEDGE, pins);
		  break;

		default:
		  assert(0);
	    }

	    for (unsigned p = 0 ;  p < pr->pin_count() ; p += 1)
		  connect(pr->pin(p), expr->pin(p));

	    des->add_node(pr);
	    expr_count += 1;
      }

	/* If there was at least one conjunction that was an
	   expression (and not a named event) then add this
	   event. Otherwise, we didn't use it so delete it. */
      if (expr_count > 0) {
	    scope->add_event(ev);
	    wa->add_event(ev);
	      /* NOTE: This event that I am adding to the wait may be
		 a duplicate of another event somewhere else. However,
		 I don't know that until all the modules are hooked
		 up, so it is best to leave find_similar_event to
		 after elaboration. */
      } else {
	    delete ev;
      }

      return wa;
}

/*
 * This is the special case of the event statement, the wait
 * statement. This is elaborated into a slightly more complicated
 * statement that uses non-wait statements:
 *
 *     wait (<expr>)  <statement>
 *
 * becomes
 *
 *     begin
 *         while (1 !== <expr>)
 *           @(<expr inputs>) <noop>;
 *         <statement>;
 *     end
 */
NetProc* PEventStatement::elaborate_wait(Design*des, NetScope*scope,
					 NetProc*enet) const
{
      assert(scope);
      assert(expr_.count() == 1);

      const PExpr *pe = expr_[0]->expr();

	/* Elaborate wait expression. Don't eval yet, we will do that
	   shortly, after we apply a reduction or. */
      NetExpr*expr = pe->elaborate_expr(des, scope);
      if (expr == 0) {
	    cerr << get_line() << ": error: Unable to elaborate"
		  " wait condition expression." << endl;
	    des->errors += 1;
	    return 0;
      }

	// If the condition expression is more then 1 bits, then
	// generate a reduction operator to get the result down to
	// one bit. In other words, Turn <e> into |<e>;

      if (expr->expr_width() < 1) {
	    cerr << get_line() << ": internal error: "
		  "incomprehensible wait expression width (0)." << endl;
	    return 0;
      }

      if (expr->expr_width() > 1) {
	    assert(expr->expr_width() > 1);
	    NetEUReduce*cmp = new NetEUReduce('|', expr);
	    expr = cmp;
      }

	/* Detect the unusual case that the wait expression is
	   constant. Constant true is OK (it becomes transparent) but
	   constant false is almost certainly not what is intended. */
      assert(expr->expr_width() == 1);
      if (NetEConst*ce = dynamic_cast<NetEConst*>(expr)) {
	    verinum val = ce->value();
	    assert(val.len() == 1);

	      /* Constant true -- wait(1) <s1> reduces to <s1>. */
	    if (val[0] == verinum::V1) {
		  delete expr;
		  assert(enet);
		  return enet;
	    }

	      /* Otherwise, false. wait(0) blocks permanently. */

	    cerr << get_line() << ": warning: wait expression is "
		 << "constant false." << endl;
	    cerr << get_line() << ":        : The statement will "
		 << "block permanently." << endl;

	      /* Create an event wait and an otherwise unreferenced
		 event variable to force a perpetual wait. */
	    NetEvent*wait_event = new NetEvent(scope->local_symbol());
	    scope->add_event(wait_event);

	    NetEvWait*wait = new NetEvWait(0);
	    wait->add_event(wait_event);
	    wait->set_line(*this);

	    delete expr;
	    delete enet;
	    return wait;
      }

	/* Invert the sense of the test with an exclusive NOR. In
	   other words, if this adjusted expression returns TRUE, then
	   wait. */
      assert(expr->expr_width() == 1);
      expr = new NetEBComp('N', expr, new NetEConst(verinum(verinum::V1)));
      NetExpr*tmp = expr->eval_tree();
      if (tmp) {
	    delete expr;
	    expr = tmp;
      }

      NetEvent*wait_event = new NetEvent(scope->local_symbol());
      scope->add_event(wait_event);

      NetEvWait*wait = new NetEvWait(0 /* noop */);
      wait->add_event(wait_event);
      wait->set_line(*this);

      NexusSet*wait_set = expr->nex_input();
      if (wait_set == 0) {
	    cerr << get_line() << ": internal error: No NexusSet"
		 << " from wait expression." << endl;
	    des->errors += 1;
	    return 0;
      }

      if (wait_set->count() == 0) {
	    cerr << get_line() << ": internal error: Empty NexusSet"
		 << " from wait expression." << endl;
	    des->errors += 1;
	    return 0;
      }

      NetEvProbe*wait_pr = new NetEvProbe(scope, scope->local_symbol(),
					  wait_event, NetEvProbe::ANYEDGE,
					  wait_set->count());
      for (unsigned idx = 0; idx < wait_set->count() ;  idx += 1)
	    connect(wait_set[0][idx], wait_pr->pin(idx));

      delete wait_set;
      des->add_node(wait_pr);

      NetWhile*loop = new NetWhile(expr, wait);
      loop->set_line(*this);

	/* If there is no real substatement (i.e., "wait (foo) ;") then
	   we are done. */
      if (enet == 0)
	    return loop;

	/* Create a sequential block to combine the wait loop and the
	   delayed statement. */
      NetBlock*block = new NetBlock(NetBlock::SEQU, 0);
      block->append(loop);
      block->append(enet);
      block->set_line(*this);

      return block;
}


NetProc* PEventStatement::elaborate(Design*des, NetScope*scope) const
{
      NetProc*enet = 0;
      if (statement_) {
	    enet = statement_->elaborate(des, scope);
	    if (enet == 0)
		  return 0;
      }

      if ((expr_.count() == 1) && (expr_[0]->type() == PEEvent::POSITIVE))
	    return elaborate_wait(des, scope, enet);

      return elaborate_st(des, scope, enet);
}

/*
 * Forever statements are represented directly in the netlist. It is
 * theoretically possible to use a while structure with a constant
 * expression to represent the loop, but why complicate the code
 * generators so?
 */
NetProc* PForever::elaborate(Design*des, NetScope*scope) const
{
      NetProc*stat = statement_->elaborate(des, scope);
      if (stat == 0) return 0;

      NetForever*proc = new NetForever(stat);
      return proc;
}

NetProc* PForce::elaborate(Design*des, NetScope*scope) const
{
      assert(scope);

      NetNet*lval = lval_->elaborate_net(des, scope, 0, 0, 0, 0);
      if (lval == 0)
	    return 0;

      NetNet*rval = expr_->elaborate_net(des, scope, lval->pin_count(),
					 0, 0, 0);
      if (rval == 0)
	    return 0;

      if (rval->pin_count() < lval->pin_count())
	    rval = pad_to_width(des, rval, lval->pin_count());

      NetForce* dev = new NetForce(scope, scope->local_symbol(), lval);
      des->add_node(dev);

      for (unsigned idx = 0 ;  idx < dev->pin_count() ;  idx += 1)
	    connect(dev->pin(idx), rval->pin(idx));

      return dev;
}

/*
 * elaborate the for loop as the equivalent while loop. This eases the
 * task for the target code generator. The structure is:
 *
 *     begin : top
 *       name1_ = expr1_;
 *       while (cond_) begin : body
 *          statement_;
 *          name2_ = expr2_;
 *       end
 *     end
 */
NetProc* PForStatement::elaborate(Design*des, NetScope*scope) const
{
      NetExpr*etmp;
      assert(scope);

      const PEIdent*id1 = dynamic_cast<const PEIdent*>(name1_);
      assert(id1);
      const PEIdent*id2 = dynamic_cast<const PEIdent*>(name2_);
      assert(id2);

      NetBlock*top = new NetBlock(NetBlock::SEQU, 0);
      top->set_line(*this);

	/* make the expression, and later the initial assignment to
	   the condition variable. The statement in the for loop is
	   very specifically an assignment. */
      NetNet*sig = des->find_signal(scope, id1->path());
      if (sig == 0) {
	    cerr << id1->get_line() << ": register ``" << id1->path()
		 << "'' unknown in this context." << endl;
	    des->errors += 1;
	    return 0;
      }
      assert(sig);
      NetAssign_*lv = new NetAssign_(sig);

	/* Make the r-value of the initial assignment, and size it
	   properly. Then use it to build the assignment statement. */
      etmp = expr1_->elaborate_expr(des, scope);
      etmp->set_width(lv->lwidth());

      NetAssign*init = new NetAssign(lv, etmp);
      init->set_line(*this);

      top->append(init);

      NetBlock*body = new NetBlock(NetBlock::SEQU, 0);
      body->set_line(*this);

	/* Elaborate the statement that is contained in the for
	   loop. If there is an error, this will return 0 and I should
	   skip the append. No need to worry, the error has been
	   reported so it's OK that the netlist is bogus. */
      NetProc*tmp = statement_->elaborate(des, scope);
      if (tmp)
	    body->append(tmp);


	/* Elaborate the increment assignment statement at the end of
	   the for loop. This is also a very specific assignment
	   statement. Put this into the "body" block. */
      sig = des->find_signal(scope, id2->path());
      assert(sig);
      lv = new NetAssign_(sig);

	/* Make the rvalue of the increment expression, and size it
	   for the lvalue. */
      etmp = expr2_->elaborate_expr(des, scope);
      etmp->set_width(lv->lwidth());
      NetAssign*step = new NetAssign(lv, etmp);
      step->set_line(*this);

      body->append(step);


	/* Elaborate the condition expression. Try to evaluate it too,
	   in case it is a constant. This is an interesting case
	   worthy of a warning. */
      NetExpr*ce = elab_and_eval(des, scope, cond_);
      if (ce == 0) {
	    delete top;
	    return 0;
      }

      if (dynamic_cast<NetEConst*>(ce)) {
	    cerr << get_line() << ": warning: condition expression "
		  "of for-loop is constant." << endl;
      }


	/* All done, build up the loop. */

      NetWhile*loop = new NetWhile(ce, body);
      loop->set_line(*this);
      top->append(loop);
      return top;
}

/*
 * (See the PTask::elaborate methods for basic common stuff.)
 *
 * The return value of a function is represented as a reg variable
 * within the scope of the function that has the name of the
 * function. So for example with the function:
 *
 *    function [7:0] incr;
 *      input [7:0] in1;
 *      incr = in1 + 1;
 *    endfunction
 *
 * The scope of the function is <parent>.incr and there is a reg
 * variable <parent>.incr.incr. The elaborate_1 method is called with
 * the scope of the function, so the return reg is easily located.
 *
 * The function parameters are all inputs, except for the synthetic
 * output parameter that is the return value. The return value goes
 * into port 0, and the parameters are all the remaining ports.
 */

void PFunction::elaborate(Design*des, NetScope*scope) const
{
      NetFuncDef*def = scope->func_def();
      if (def == 0) {
	    cerr << get_line() << ": internal error: "
		 << "No function definition for function "
		 << scope->name() << endl;
	    return;
      }

      assert(def);

      NetProc*st = statement_->elaborate(des, scope);
      if (st == 0) {
	    cerr << statement_->get_line() << ": error: Unable to elaborate "
		  "statement in function " << def->name() << "." << endl;
	    des->errors += 1;
	    return;
      }

      def->set_proc(st);
}

NetProc* PRelease::elaborate(Design*des, NetScope*scope) const
{
      assert(scope);

      NetNet*lval = lval_->elaborate_net(des, scope, 0, 0, 0, 0);
      if (lval == 0)
	    return 0;

      NetRelease*dev = new NetRelease(lval);
      dev->set_line( *this );
      return dev;
}

NetProc* PRepeat::elaborate(Design*des, NetScope*scope) const
{
      assert(scope);

      NetExpr*expr = elab_and_eval(des, scope, expr_);
      if (expr == 0) {
	    cerr << get_line() << ": Unable to elaborate"
		  " repeat expression." << endl;
	    des->errors += 1;
	    return 0;
      }

      NetProc*stat = statement_->elaborate(des, scope);
      if (stat == 0) return 0;

	// If the expression is a constant, handle certain special
	// iteration counts.
      if (NetEConst*ce = dynamic_cast<NetEConst*>(expr)) {
	    verinum val = ce->value();
	    switch (val.as_ulong()) {
		case 0:
		  delete expr;
		  delete stat;
		  return new NetBlock(NetBlock::SEQU, 0);
		case 1:
		  delete expr;
		  return stat;
		default:
		  break;
	    }
      }

      NetRepeat*proc = new NetRepeat(expr, stat);
      return proc;
}

/*
 * A task definition is elaborated by elaborating the statement that
 * it contains, and connecting its ports to NetNet objects. The
 * netlist doesn't really need the array of parameters once elaboration
 * is complete, but this is the best place to store them.
 *
 * The first elaboration pass finds the reg objects that match the
 * port names, and creates the NetTaskDef object. The port names are
 * in the form task.port.
 *
 *      task foo;
 *        output blah;
 *        begin <body> end
 *      endtask
 *
 * So in the foo example, the PWire objects that represent the ports
 * of the task will include a foo.blah for the blah port. This port is
 * bound to a NetNet object by looking up the name. All of this is
 * handled by the PTask::elaborate_sig method and the results stashed
 * in the created NetTaskDef attached to the scope.
 *
 * Elaboration pass 2 for the task definition causes the statement of
 * the task to be elaborated and attached to the NetTaskDef object
 * created in pass 1.
 *
 * NOTE: I am not sure why I bothered to prepend the task name to the
 * port name when making the port list. It is not really useful, but
 * that is what I did in pform_make_task_ports, so there it is.
 */

void PTask::elaborate(Design*des, NetScope*task) const
{
      NetTaskDef*def = task->task_def();
      assert(def);

      NetProc*st;
      if (statement_ == 0) {
	    st = new NetBlock(NetBlock::SEQU, 0);

      } else {

	    st = statement_->elaborate(des, task);
	    if (st == 0) {
		  cerr << statement_->get_line() << ": Unable to elaborate "
			"statement in task " << task->name()
		       << " at " << get_line() << "." << endl;
		  return;
	    }
      }

      def->set_proc(st);
}

NetProc* PTrigger::elaborate(Design*des, NetScope*scope) const
{
      assert(scope);

      NetNet*       sig = 0;
      NetMemory*    mem = 0;
      NetVariable*  var = 0;
      const NetExpr*par = 0;
      NetEvent*     eve = 0;

      NetScope*found_in = symbol_search(des, scope, event_,
					sig, mem, var, par, eve);

      if (found_in == 0) {
	    cerr << get_line() << ": error: event <" << event_ << ">"
		 << " not found." << endl;
	    des->errors += 1;
	    return 0;
      }

      if (eve == 0) {
	    cerr << get_line() << ": error:  <" << event_ << ">"
		 << " is not a named event." << endl;
	    des->errors += 1;
	    return 0;
      }

      NetEvTrig*trig = new NetEvTrig(eve);
      trig->set_line(*this);
      return trig;
}

/*
 * The while loop is fairly directly represented in the netlist.
 */
NetProc* PWhile::elaborate(Design*des, NetScope*scope) const
{
      NetWhile*loop = new NetWhile(elab_and_eval(des, scope, cond_),
				   statement_->elaborate(des, scope));
      return loop;
}

/*
 * When a module is instantiated, it creates the scope then uses this
 * method to elaborate the contents of the module.
 */
bool Module::elaborate(Design*des, NetScope*scope) const
{
      bool result_flag = true;


	// Elaborate functions.
      typedef map<perm_string,PFunction*>::const_iterator mfunc_it_t;
      for (mfunc_it_t cur = funcs_.begin()
		 ; cur != funcs_.end() ;  cur ++) {

	    NetScope*fscope = scope->child((*cur).first);
	    assert(fscope);
	    (*cur).second->elaborate(des, fscope);
      }

	// Elaborate the task definitions. This is done before the
	// behaviors so that task calls may reference these, and after
	// the signals so that the tasks can reference them.
      typedef map<perm_string,PTask*>::const_iterator mtask_it_t;
      for (mtask_it_t cur = tasks_.begin()
		 ; cur != tasks_.end() ;  cur ++) {

	    NetScope*tscope = scope->child((*cur).first);
	    assert(tscope);
	    (*cur).second->elaborate(des, tscope);
      }

	// Get all the gates of the module and elaborate them by
	// connecting them to the signals. The gate may be simple or
	// complex.
      const list<PGate*>&gl = get_gates();

      for (list<PGate*>::const_iterator gt = gl.begin()
		 ; gt != gl.end()
		 ; gt ++ ) {

	    (*gt)->elaborate(des, scope);
      }

	// Elaborate the behaviors, making processes out of them. This
	// involves scanning the PProcess* list, creating a NetProcTop
	// for each process.
      const list<PProcess*>&sl = get_behaviors();

      for (list<PProcess*>::const_iterator st = sl.begin()
		 ; st != sl.end()
		 ; st ++ ) {

	    NetProc*cur = (*st)->statement()->elaborate(des, scope);
	    if (cur == 0) {
		  result_flag = false;
		  continue;
	    }

	    NetProcTop*top=NULL;
	    switch ((*st)->type()) {
		case PProcess::PR_INITIAL:
		  top = new NetProcTop(scope, NetProcTop::KINITIAL, cur);
		  break;
		case PProcess::PR_ALWAYS:
		  top = new NetProcTop(scope, NetProcTop::KALWAYS, cur);
		  break;
	    }
	    assert(top);

	      // Evaluate the attributes for this process, if there
	      // are any. These attributes are to be attached to the
	      // NetProcTop object.
	    struct attrib_list_t*attrib_list = 0;
	    unsigned attrib_list_n = 0;
	    attrib_list = evaluate_attributes((*st)->attributes,
					      attrib_list_n,
					      des, scope);

	    for (unsigned adx = 0 ;  adx < attrib_list_n ;  adx += 1)
		  top->attribute(attrib_list[adx].key,
				 attrib_list[adx].val);

	    delete[]attrib_list;

	    top->set_line(*(*st));
	    des->add_process(top);

	      /* Detect the special case that this is a combinational
		 always block. We want to attach an _ivl_schedule_push
		 attribute to this process so that it starts up and
		 gets into its wait statement before non-combinational
		 code is executed. */
	    do {
		  if (top->type() != NetProcTop::KALWAYS)
			break;

		  NetEvWait*st = dynamic_cast<NetEvWait*>(top->statement());
		  if (st == 0)
			break;

		  if (st->nevents() != 1)
			break;

		  NetEvent*ev = st->event(0);

		  if (ev->nprobe() == 0)
			break;

		  bool anyedge_test = true;
		  for (unsigned idx = 0 ;  anyedge_test && (idx<ev->nprobe())
			     ; idx += 1) {
			const NetEvProbe*pr = ev->probe(idx);
			if (pr->edge() != NetEvProbe::ANYEDGE)
			      anyedge_test = false;
		  }

		  if (! anyedge_test)
			break;

		  top->attribute(perm_string::literal("_ivl_schedule_push"),
				 verinum(1));
	    } while (0);

      }

      return result_flag;
}

struct root_elem {
      Module *mod;
      NetScope *scope;
};

Design* elaborate(list<perm_string>roots)
{
      svector<root_elem*> root_elems(roots.size());
      bool rc = true;
      unsigned i = 0;

	// This is the output design. I fill it in as I scan the root
	// module and elaborate what I find.
      Design*des = new Design;

      for (list<perm_string>::const_iterator root = roots.begin()
		 ; root != roots.end()
		 ; root++) {

	      // Look for the root module in the list.
	    map<perm_string,Module*>::const_iterator mod = pform_modules.find(*root);
	    if (mod == pform_modules.end()) {
		  cerr << "error: Unable to find the root module \""
		       << (*root) << "\" in the Verilog source." << endl; 
		  cerr << "     : Perhaps ``-s " << (*root)
		       << "'' is incorrect?" << endl;
		  des->errors++;
		  continue;
	    }

	    Module *rmod = (*mod).second;
	    
	    // Make the root scope, then scan the pform looking for scopes
	    // and parameters. 
	    NetScope*scope = des->make_root_scope(*root);
	    scope->time_unit(rmod->time_unit);
	    scope->time_precision(rmod->time_precision);
	    des->set_precision(rmod->time_precision);
	    if (! rmod->elaborate_scope(des, scope)) {
		  delete des;
		  return 0;
	    }

	    struct root_elem *r = new struct root_elem;
	    r->mod = rmod;
	    r->scope = scope;
	    root_elems[i++] = r;
      }

	// Errors already? Probably missing root modules. Just give up
	// now and return nothing.
      if (des->errors > 0)
	    return des;

	// This method recurses through the scopes, looking for
	// defparam assignments to apply to the parameters in the
	// various scopes. This needs to be done after all the scopes
	// and basic parameters are taken care of because the defparam
	// can assign to a parameter declared *after* it.
      des->run_defparams();


	// At this point, all parameter overrides are done. Scan the
	// scopes and evaluate the parameters all the way down to
	// constants.
      des->evaluate_parameters();

	// With the parameters evaluated down to constants, we have
	// what we need to elaborate signals and memories. This pass
	// creates all the NetNet and NetMemory objects for declared
	// objects.
      for (i = 0; i < root_elems.count(); i++) {
	    Module *rmod = root_elems[i]->mod;
	    NetScope *scope = root_elems[i]->scope;

	    if (! rmod->elaborate_sig(des, scope)) {
		  delete des;
		  return 0;
	    }
      }

	// Now that the structure and parameters are taken care of,
	// run through the pform again and generate the full netlist.
      for (i = 0; i < root_elems.count(); i++) {
	    Module *rmod = root_elems[i]->mod;
	    NetScope *scope = root_elems[i]->scope;

	    rc &= rmod->elaborate(des, scope);
      }


      if (rc == false) {
	    delete des;
	    des = 0;
      }

      return des;
}


/*
 * $Log: elaborate.cc,v $
 * Revision 1.302  2004/05/31 23:34:37  steve
 *  Rewire/generalize parsing an elaboration of
 *  function return values to allow for better
 *  speed and more type support.
 *
 * Revision 1.301  2004/05/25 03:42:58  steve
 *  Handle wait with constant-false expression.
 *
 * Revision 1.300  2004/03/08 00:47:44  steve
 *  primitive ports can bind bi name.
 *
 * Revision 1.299  2004/03/08 00:10:29  steve
 *  Verilog2001 new style port declartions for primitives.
 *
 * Revision 1.298  2004/03/07 20:04:10  steve
 *  MOre thorough use of elab_and_eval function.
 *
 * Revision 1.297  2004/02/20 18:53:34  steve
 *  Addtrbute keys are perm_strings.
 *
 * Revision 1.296  2004/02/18 17:11:55  steve
 *  Use perm_strings for named langiage items.
 *
 * Revision 1.295  2004/01/21 04:35:03  steve
 *  Get rid of useless warning.
 *
 * Revision 1.294  2004/01/13 03:42:49  steve
 *  Handle wide expressions in wait condition.
 *
 * Revision 1.293  2003/10/26 04:49:51  steve
 *  Attach line number information to for loop parts.
 *
 * Revision 1.292  2003/09/25 00:25:14  steve
 *  Summary list of missing modules.
 *
 * Revision 1.291  2003/09/20 06:08:53  steve
 *  Evaluate nb-assign r-values using elab_and_eval.
 *
 * Revision 1.290  2003/09/20 06:00:37  steve
 *  Evaluate gate array index constants using elab_and_eval.
 *
 * Revision 1.289  2003/09/20 01:05:35  steve
 *  Obsolete find_symbol and find_event from the Design class.
 *
 * Revision 1.288  2003/09/13 01:01:51  steve
 *  Spelling fixes.
 *
 * Revision 1.287  2003/09/04 20:28:05  steve
 *  Support time0 resolution of combinational threads.
 *
 * Revision 1.286  2003/08/28 04:11:17  steve
 *  Spelling patch.
 *
 * Revision 1.285  2003/08/05 03:01:58  steve
 *  Primitive outputs have same limitations as continuous assignment.
 *
 * Revision 1.284  2003/07/02 04:19:16  steve
 *  Elide empty begin-end in conditionals.
 *
 * Revision 1.283  2003/06/21 01:21:43  steve
 *  Harmless fixup of warnings.
 *
 * Revision 1.282  2003/06/13 19:10:20  steve
 *  Handle assign of real to vector.
 *
 * Revision 1.281  2003/05/19 02:50:58  steve
 *  Implement the wait statement behaviorally instead of as nets.
 *
 * Revision 1.280  2003/05/04 20:04:08  steve
 *  Fix truncation of signed constant in constant addition.
 *
 * Revision 1.279  2003/04/24 05:25:55  steve
 *  Include port name in port assignment error message.
 */

