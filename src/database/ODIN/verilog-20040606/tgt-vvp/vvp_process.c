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
#ident "$Id: vvp_process.c,v 1.92 2004/05/19 03:25:42 steve Exp $"
#endif

# include  "vvp_priv.h"
# include  <string.h>
# include  <assert.h>
#ifdef HAVE_MALLOC_H
# include  <malloc.h>
#endif
# include  <stdlib.h>

static int show_statement(ivl_statement_t net, ivl_scope_t sscope);

unsigned local_count = 0;
unsigned thread_count = 0;

static unsigned transient_id = 0;

/*
 * This file includes the code needed to generate VVP code for
 * processes. Scopes are already declared, we generate here the
 * executable code for the processes.
 */

unsigned bitchar_to_idx(char bit)
{
      switch (bit) {
	  case '0':
	    return 0;
	  case '1':
	    return 1;
	  case 'x':
	    return 2;
	  case 'z':
	    return 3;
	  default:
	    assert(0);
	    return 0;
      }
}

/*
 * These functions handle the blocking assignment. Use the %set
 * instruction to perform the actual assignment, and calculate any
 * lvalues and rvalues that need calculating.
 *
 * The set_to_lvariable function takes a particular nexus and generates
 * the %set statements to assign the value.
 *
 * The show_stmt_assign function looks at the assign statement, scans
 * the l-values, and matches bits of the r-value with the correct
 * nexus.
 */

static void set_to_lvariable(ivl_lval_t lval, unsigned idx,
			     unsigned bit, unsigned wid)
{
      ivl_signal_t sig  = ivl_lval_sig(lval);
      unsigned part_off = ivl_lval_part_off(lval);

      if (ivl_lval_mux(lval)) {
	    assert(wid == 1);
	    if ((ivl_signal_pins(sig)-1) <= 0xffffU) {
		  fprintf(vvp_out, "    %%set/x0 V_%s, %u, %u;\n",
			  vvp_signal_label(sig), bit, ivl_signal_pins(sig)-1);
	    } else {
		    /* If the target bound is too big for the %set/x0
		       instruction, then use the %set/x0/x instruction
		       instead. */
		  fprintf(vvp_out, "    %%ix/load 3, %u;\n",
			  ivl_signal_pins(sig)-1);
		  fprintf(vvp_out, "    %%set/x0/x V_%s, %u, 3;\n",
			  vvp_signal_label(sig), bit);
	    }
			  
      } else if (wid == 1) {
	    fprintf(vvp_out, "    %%set V_%s[%u], %u;\n",
		    vvp_signal_label(sig), idx+part_off, bit);

      } else {
	    fprintf(vvp_out, "    %%set/v V_%s[%u], %u, %u;\n",
		    vvp_signal_label(sig), idx+part_off, bit, wid);

      }
}

static void set_to_memory(ivl_memory_t mem, unsigned idx, unsigned bit)
{
      if (idx)
	    fprintf(vvp_out, "    %%ix/add 3, 1;\n");
      fprintf(vvp_out, "    %%set/m M_%s, %u;\n",
	      vvp_memory_label(mem), bit);
}

/*
 * This generates an assign to a single bit of an lvalue variable. If
 * the bit is a part select, then index the label to set the right
 * bit. If there is an lvalue mux, then use the indexed assign to make
 * a calculated assign.
 */
static void assign_to_lvariable(ivl_lval_t lval, unsigned idx,
				unsigned bit, unsigned delay,
				int delay_in_index_flag)
{
      ivl_signal_t sig = ivl_lval_sig(lval);
      unsigned part_off = ivl_lval_part_off(lval);

      char *delay_suffix = delay_in_index_flag? "/d" : "";

      if (ivl_lval_mux(lval))
	    fprintf(vvp_out, "    %%assign/x0%s V_%s, %u, %u;\n",
		    delay_suffix, vvp_signal_label(sig), delay, bit);
      else
	    fprintf(vvp_out, "    %%assign%s V_%s[%u], %u, %u;\n",
		    delay_suffix, vvp_signal_label(sig),
		    idx+part_off, delay, bit);
}

static void assign_to_lvector(ivl_lval_t lval, unsigned idx,
			      unsigned bit, unsigned delay, unsigned width)
{
      ivl_signal_t sig = ivl_lval_sig(lval);
      unsigned part_off = ivl_lval_part_off(lval);
      assert(ivl_lval_mux(lval) == 0);

      fprintf(vvp_out, "    %%ix/load 0, %u;\n", width);
      fprintf(vvp_out, "    %%assign/v0 V_%s[%u], %u, %u;\n",
	      vvp_signal_label(sig), part_off+idx, delay, bit);

}

static void assign_to_memory(ivl_memory_t mem, unsigned idx, 
			     unsigned bit, unsigned delay)
{
      if (idx)
	    fprintf(vvp_out, "    %%ix/add 3, 1;\n");
      fprintf(vvp_out, "    %%assign/m M_%s, %u, %u;\n",
	      vvp_memory_label(mem), delay, bit);
}

/*
 * This function, in addition to setting the value into index 0, sets
 * bit 4 to 1 if the value is unknown.
 */
static void calculate_into_x0(ivl_expr_t expr)
{
      struct vector_info vec = draw_eval_expr(expr, 0);
      fprintf(vvp_out, "    %%ix/get 0, %u, %u;\n", vec.base, vec.wid);
      clr_vector(vec);
}

static void calculate_into_x1(ivl_expr_t expr)
{
      struct vector_info vec = draw_eval_expr(expr, 0);
      fprintf(vvp_out, "    %%ix/get 1, %u, %u;\n", vec.base, vec.wid);
      clr_vector(vec);
}

/*
 * This is a private function to generate %set code for the
 * statement. At this point, the r-value is evaluated and stored in
 * the res vector, I just need to generate the %set statements for the
 * l-values of the assignment.
 */
static void set_vec_to_lval(ivl_statement_t net, struct vector_info res)
{
      ivl_lval_t lval;
      ivl_memory_t mem;

      unsigned wid = res.wid;
      unsigned lidx;
      unsigned cur_rbit = 0;

      for (lidx = 0 ;  lidx < ivl_stmt_lvals(net) ;  lidx += 1) {
	    unsigned skip_set = transient_id++;
	    unsigned skip_set_flag = 0;
	    unsigned idx;
	    unsigned bit_limit = wid - cur_rbit;
	    lval = ivl_stmt_lval(net, lidx);

	      /* If there is a mux for the lval, calculate the
		 value and write it into index0. */
	    if (ivl_lval_mux(lval)) {
		  calculate_into_x0(ivl_lval_mux(lval));
		  fprintf(vvp_out, "    %%jmp/1 t_%u, 4;\n", skip_set);
		  skip_set_flag = 1;
	    }

	    mem = ivl_lval_mem(lval);
	    if (mem) {
		  draw_memory_index_expr(mem, ivl_lval_idx(lval));
		  fprintf(vvp_out, "    %%jmp/1 t_%u, 4;\n", skip_set);
		  skip_set_flag = 1;
	    }

	    if (bit_limit > ivl_lval_pins(lval))
		  bit_limit = ivl_lval_pins(lval);

	    if (mem) {
		  for (idx = 0 ;  idx < bit_limit ;  idx += 1) {
			unsigned bidx = res.base < 4
			      ? res.base
			      : (res.base+cur_rbit);
			set_to_memory(mem, idx, bidx);
			cur_rbit += 1;
		  }

		  for (idx = bit_limit;  idx < ivl_lval_pins(lval); idx += 1)
			set_to_memory(mem, idx, 0);

	    } else {

		  unsigned bidx = res.base < 4
			? res.base
			: (res.base+cur_rbit);
		  set_to_lvariable(lval, 0, bidx, bit_limit);
		  cur_rbit += bit_limit;

		  if (bit_limit < ivl_lval_pins(lval)) {
			unsigned cnt = ivl_lval_pins(lval) - bit_limit;
			set_to_lvariable(lval, bit_limit, 0, cnt);
		  }
	    }


	    if (skip_set_flag) {
		  fprintf(vvp_out, "t_%u ;\n", skip_set);
		  clear_expression_lookaside();
	    }
      }
}

static int show_stmt_assign_vector(ivl_statement_t net)
{
      ivl_lval_t lval;
      ivl_expr_t rval = ivl_stmt_rval(net);
      ivl_memory_t mem;

	/* Handle the special case that the expression is a real
	   value. Evaluate the real expression, then convert the
	   result to a vector. Then store that vector into the
	   l-value. */
      if (ivl_expr_value(rval) == IVL_VT_REAL) {
	    int word = draw_eval_real(rval);
	      /* This is the accumulated with of the l-value of the
		 assignment. */
	    unsigned wid = ivl_stmt_lwidth(net);

	    struct vector_info vec;

	    vec.base = allocate_vector(wid);
	    vec.wid = wid;

	    fprintf(vvp_out, "    %%cvt/vr %u, %d, %u;\n",
		    vec.base, word, vec.wid);

	    clr_word(word);

	    set_vec_to_lval(net, vec);

	    clr_vector(vec);
	    return 0;
      }

	/* Handle the special case that the r-value is a constant. We
	   can generate the %set statement directly, without any worry
	   about generating code to evaluate the r-value expressions. */

      if (ivl_expr_type(rval) == IVL_EX_NUMBER) {
	    unsigned lidx;
	    const char*bits = ivl_expr_bits(rval);
	    unsigned wid = ivl_expr_width(rval);
	    unsigned cur_rbit = 0;

	    for (lidx = 0 ;  lidx < ivl_stmt_lvals(net) ;  lidx += 1) {
		  unsigned skip_set = transient_id++;
		  unsigned skip_set_flag = 0;
		  unsigned idx;
		  unsigned bit_limit = wid - cur_rbit;
		  lval = ivl_stmt_lval(net, lidx);

		    /* If there is a mux for the lval, calculate the
		       value and write it into index0. */
		  if (ivl_lval_mux(lval)) {
			calculate_into_x0(ivl_lval_mux(lval));
			  /* Generate code to skip around the set
			     if the index has X values. */
			fprintf(vvp_out, "    %%jmp/1 t_%u, 4;\n", skip_set);
			skip_set_flag = 1;
		  }

		  mem = ivl_lval_mem(lval);
		  if (mem) {
			draw_memory_index_expr(mem, ivl_lval_idx(lval));
			  /* Generate code to skip around the set
			     if the index has X values. */
			fprintf(vvp_out, "    %%jmp/1 t_%u, 4;\n", skip_set);
			skip_set_flag = 1;
		  }

		  if (bit_limit > ivl_lval_pins(lval))
			bit_limit = ivl_lval_pins(lval);

		  if (mem) {
			for (idx = 0 ;  idx < bit_limit ;  idx += 1) {
			      set_to_memory(mem, idx,
					    bitchar_to_idx(bits[cur_rbit]));

			      cur_rbit += 1;
			}

			for (idx = bit_limit
				   ; idx < ivl_lval_pins(lval) ; idx += 1)
			      set_to_memory(mem, idx, 0);


		  } else {
			idx = 0;
			while (idx < bit_limit) {
			      unsigned cnt = 1;
			      while (((idx + cnt) < bit_limit)
				     && (bits[cur_rbit] == bits[cur_rbit+cnt]))
				    cnt += 1;

			      set_to_lvariable(lval, idx,
					       bitchar_to_idx(bits[cur_rbit]),
					       cnt);

			      cur_rbit += cnt;
			      idx += cnt;
			}


			if (bit_limit < ivl_lval_pins(lval)) {
			      unsigned cnt = ivl_lval_pins(lval) - bit_limit;
			      set_to_lvariable(lval, bit_limit, 0, cnt);
			}
		  }

		  if (skip_set_flag) {
			fprintf(vvp_out, "t_%u ;\n", skip_set);
			clear_expression_lookaside();
		  }
	    }

	    return 0;
      }

      { struct vector_info res = draw_eval_expr(rval, 0);
        set_vec_to_lval(net, res);
	if (res.base > 3)
	      clr_vector(res);
      }


      return 0;
}

static int show_stmt_assign_real(ivl_statement_t net)
{
      int res;
      ivl_lval_t lval;
      ivl_variable_t var;

      res = draw_eval_real(ivl_stmt_rval(net));
      clr_word(res);

      assert(ivl_stmt_lvals(net) == 1);
      lval = ivl_stmt_lval(net, 0);
      var = ivl_lval_var(lval);
      assert(var != 0);

      fprintf(vvp_out, "    %%set/wr W_%s, %d;\n",
	      vvp_word_label(var), res);

      return 0;
}

static int show_stmt_assign(ivl_statement_t net)
{
      ivl_lval_t lval;
      ivl_variable_t var;

      lval = ivl_stmt_lval(net, 0);

      if ( (var = ivl_lval_var(lval)) != 0 ) {
	    switch (ivl_variable_type(var)) {
		case IVL_VT_VOID:
		  assert(0);
		  return 1;

		case IVL_VT_VECTOR:
		    /* Can't happen. */
		  assert(0);
		  return 1;

		case IVL_VT_REAL:
		  return show_stmt_assign_real(net);

	    }

      } else {
	    return show_stmt_assign_vector(net);
      }

      return 0;
}

/*
 * This function handles the case of non-blocking assign to word
 * variables such as real, i.e:
 *
 *     read foo;
 *     foo <= 1.0;
 *
 * In this case we know (by Verilog syntax) that there is only exactly
 * 1 l-value, the target identifier, so it should be relatively easy.
 */
static int show_stmt_assign_nb_var(ivl_statement_t net)
{
      ivl_lval_t lval;
      ivl_variable_t var;
      ivl_expr_t rval = ivl_stmt_rval(net);
      ivl_expr_t del  = ivl_stmt_delay_expr(net);

      int word;
      unsigned long delay;

	/* Must be exactly 1 l-value. */
      assert(ivl_stmt_lvals(net) == 1);

      delay = 0;
      if (del && (ivl_expr_type(del) == IVL_EX_ULONG)) {
	    delay = ivl_expr_uvalue(del);
	    del = 0;
      }

	/* XXXX For now, presume delays are constant. */
      assert(del == 0);

	/* Evaluate the r-value */
      word = draw_eval_real(rval);

      lval = ivl_stmt_lval(net, 0);
      var = ivl_lval_var(lval);
      assert(var != 0);

      fprintf(vvp_out, "    %%assign/wr W_%s, %lu, %u;\n",
	      vvp_word_label(var), delay, word);

      return 0;
}

static int show_stmt_assign_nb(ivl_statement_t net)
{
      ivl_lval_t lval;
      ivl_expr_t rval = ivl_stmt_rval(net);
      ivl_expr_t del  = ivl_stmt_delay_expr(net);
      ivl_memory_t mem;

      unsigned long delay = 0;

	/* Catch the case we are assigning to a real/word
	   l-value. Handle that elsewhere. */
      if (ivl_lval_var(ivl_stmt_lval(net, 0))) {
	    return show_stmt_assign_nb_var(net);
      }

      if (del && (ivl_expr_type(del) == IVL_EX_ULONG)) {
	    delay = ivl_expr_uvalue(del);
	    del = 0;
      }

	/* Handle the special case that the r-value is a constant. We
	   can generate the %set statement directly, without any worry
	   about generating code to evaluate the r-value expressions. */

      if (ivl_expr_type(rval) == IVL_EX_NUMBER) {
	    unsigned lidx;
	    const char*bits = ivl_expr_bits(rval);
	    unsigned wid = ivl_expr_width(rval);
	    unsigned cur_rbit = 0;

	    if (del != 0)
		  calculate_into_x1(del);

	    for (lidx = 0 ;  lidx < ivl_stmt_lvals(net) ;  lidx += 1) {
		  unsigned skip_set = transient_id++;
		  unsigned skip_set_flag = 0;
		  unsigned idx;
		  unsigned bit_limit = wid - cur_rbit;
		  lval = ivl_stmt_lval(net, lidx);

		    /* If there is a mux for the lval, calculate the
		       value and write it into index0. */
		  if (ivl_lval_mux(lval)) {
			calculate_into_x0(ivl_lval_mux(lval));
			fprintf(vvp_out, "    %%jmp/1 t_%u, 4;\n", skip_set);
			skip_set_flag = 1;
		  }

		  mem = ivl_lval_mem(lval);
		  if (mem) {
			draw_memory_index_expr(mem, ivl_lval_idx(lval));
			fprintf(vvp_out, "    %%jmp/1 t_%u, 4;\n", skip_set);
			skip_set_flag = 1;
		  }

		  if (bit_limit > ivl_lval_pins(lval))
			bit_limit = ivl_lval_pins(lval);

		  if (mem) {
			for (idx = 0 ;  idx < bit_limit ;  idx += 1) {
			      assign_to_memory(mem, idx, 
					       bitchar_to_idx(bits[cur_rbit]),
					       delay);
			      cur_rbit += 1;
			}

			for (idx = bit_limit
				   ; idx < ivl_lval_pins(lval)
				   ; idx += 1) {
			      assign_to_memory(mem, idx, 0, delay);
			}

		  } else if ((del == 0) && (bit_limit > 2)) {

			  /* We have a vector, but no runtime
			     calculated delays, to try to use vector
			     assign instructions. */
			idx = 0;
			while (idx < bit_limit) {
			      unsigned wid = 0;

			      do {
				    wid += 1;
				    if ((idx + wid) == bit_limit)
					  break;

			      } while (bits[cur_rbit] == bits[cur_rbit+wid]);

			      switch (wid) {
				  case 1:
				    assign_to_lvariable(lval, idx,
					       bitchar_to_idx(bits[cur_rbit]),
					       delay, 0);
				    break;
				  case 2:
				    assign_to_lvariable(lval, idx,
					       bitchar_to_idx(bits[cur_rbit]),
					       delay, 0);
				    assign_to_lvariable(lval, idx+1,
					       bitchar_to_idx(bits[cur_rbit]),
					       delay, 0);
				    break;
				  default:
				    assign_to_lvector(lval, idx,
					      bitchar_to_idx(bits[cur_rbit]),
					      delay, wid);
				    break;
			      }

			      idx += wid;
			      cur_rbit += wid;
			}

			if (bit_limit < ivl_lval_pins(lval)) {
			      unsigned wid = ivl_lval_pins(lval) - bit_limit;
			      assign_to_lvector(lval, bit_limit,
						0, delay, wid);
			}

		  } else {
			for (idx = 0 ;  idx < bit_limit ;  idx += 1) {
			      if (del != 0)
				    assign_to_lvariable(lval, idx,
					       bitchar_to_idx(bits[cur_rbit]),
					       1, 1);
			      else
				    assign_to_lvariable(lval, idx,
					       bitchar_to_idx(bits[cur_rbit]),
					       delay, 0);
			      cur_rbit += 1;
			}

			for (idx = bit_limit
				   ; idx < ivl_lval_pins(lval)
				   ; idx += 1) {
			      if (del != 0)
				    assign_to_lvariable(lval, idx, 0,
							1, 1);
			      else
				    assign_to_lvariable(lval, idx, 0,
							delay, 0);
			}
		  }

		  if (skip_set_flag) {
			fprintf(vvp_out, "t_%u ;\n", skip_set);
			clear_expression_lookaside();
		  }
	    }
	    return 0;
      }


      { struct vector_info res = draw_eval_expr(rval, 0);
        unsigned wid = res.wid;
	unsigned lidx;
	unsigned cur_rbit = 0;

	if (del != 0)
	      calculate_into_x1(del);

	for (lidx = 0 ;  lidx < ivl_stmt_lvals(net) ;  lidx += 1) {
	      unsigned skip_set = transient_id++;
	      unsigned skip_set_flag = 0;
	      unsigned idx;
	      unsigned bit_limit = wid - cur_rbit;
	      lval = ivl_stmt_lval(net, lidx);

		/* If there is a mux for the lval, calculate the
		   value and write it into index0. */
	      if (ivl_lval_mux(lval)) {
		    calculate_into_x0(ivl_lval_mux(lval));
		    fprintf(vvp_out, "    %%jmp/1 t_%u, 4;\n", skip_set);
		    skip_set_flag = 1;
	      }

	      mem = ivl_lval_mem(lval);
	      if (mem) {
		    draw_memory_index_expr(mem, ivl_lval_idx(lval));
		    fprintf(vvp_out, "    %%jmp/1 t_%u, 4;\n", skip_set);
		    skip_set_flag = 1;
	      }

	      if (bit_limit > ivl_lval_pins(lval))
		    bit_limit = ivl_lval_pins(lval);

	      if ((bit_limit > 2) && (mem == 0) && (del == 0)) {

		    unsigned bidx = res.base < 4
			  ? res.base
			  : (res.base+cur_rbit);
		    assign_to_lvector(lval, 0, bidx, delay, bit_limit);
		    cur_rbit += bit_limit;

	      } else {
		    for (idx = 0 ;  idx < bit_limit ;  idx += 1) {
			  unsigned bidx = res.base < 4
				? res.base
				: (res.base+cur_rbit);
			  if (mem)
				assign_to_memory(mem, idx, bidx, delay);
			  else if (del != 0)
				assign_to_lvariable(lval, idx, bidx,
						    1, 1);
			  else
				assign_to_lvariable(lval, idx, bidx,
						    delay, 0);

			  cur_rbit += 1;
		    }
	      }

	      for (idx = bit_limit; idx < ivl_lval_pins(lval); idx += 1)
			  if (mem)
				assign_to_memory(mem, idx, 0, delay);
			  else if (del != 0)
				assign_to_lvariable(lval, idx, 0, 1, 1);
			  else
				assign_to_lvariable(lval, idx, 0, delay, 0);


	      if (skip_set_flag) {
		    fprintf(vvp_out, "t_%u ;\n", skip_set);
		    clear_expression_lookaside();
	      }
	}

	if (res.base > 3)
	      clr_vector(res);
      }

      return 0;
}

static int show_stmt_block(ivl_statement_t net, ivl_scope_t sscope)
{
      int rc = 0;
      unsigned idx;
      unsigned cnt = ivl_stmt_block_count(net);

      for (idx = 0 ;  idx < cnt ;  idx += 1) {
	    rc += show_statement(ivl_stmt_block_stmt(net, idx), sscope);
      }

      return rc;
}

/*
 * This draws an invocation of a named block. This is a little
 * different because a subscope is created. We do that by creating
 * a thread to deal with this.
 */
static int show_stmt_block_named(ivl_statement_t net, ivl_scope_t scope)
{
      int rc;
      int out_id, sub_id;
      ivl_scope_t subscope = ivl_stmt_block_scope(net);

      out_id = transient_id++;
      sub_id = transient_id++;

      fprintf(vvp_out, "    %%fork t_%u, S_%p;\n",
	      sub_id, subscope);
      fprintf(vvp_out, "    %%jmp t_%u;\n", out_id);
      fprintf(vvp_out, "t_%u ;\n", sub_id);

      rc = show_stmt_block(net, subscope);
      fprintf(vvp_out, "    %%end;\n");

      fprintf(vvp_out, "t_%u %%join;\n", out_id);
      clear_expression_lookaside();

      return rc;
}


static int show_stmt_case(ivl_statement_t net, ivl_scope_t sscope)
{
      ivl_expr_t exp = ivl_stmt_cond_expr(net);
      struct vector_info cond = draw_eval_expr(exp, 0);
      unsigned count = ivl_stmt_case_count(net);

      unsigned local_base = local_count;

      unsigned idx, default_case;

      local_count += count + 1;

	/* First draw the branch table.  All the non-default cases
	   generate a branch out of here, to the code that implements
	   the case. The default will fall through all the tests. */
      default_case = count;

      for (idx = 0 ;  idx < count ;  idx += 1) {
	    ivl_expr_t cex = ivl_stmt_case_expr(net, idx);
	    struct vector_info cvec;

	    if (cex == 0) {
		  default_case = idx;
		  continue;
	    }

	      /* Is the guard expression something I can pass to a
		 %cmpi/u instruction? If so, use that instead. */

	    if ((ivl_statement_type(net) == IVL_ST_CASE)
		&& (ivl_expr_type(cex) == IVL_EX_NUMBER)
		&& (! number_is_unknown(cex))
		&& number_is_immediate(cex, 16)) {

		  unsigned long imm = get_number_immediate(cex);

		  fprintf(vvp_out, "    %%cmpi/u %u, %lu, %u;\n",
			  cond.base, imm, cond.wid);
		  fprintf(vvp_out, "    %%jmp/1 T_%d.%d, 6;\n",
			  thread_count, local_base+idx);

		  continue;
	    }

	      /* Oh well, do this case the hard way. */

	    cvec = draw_eval_expr_wid(cex, cond.wid, 0);
	    assert(cvec.wid == cond.wid);

	    switch (ivl_statement_type(net)) {

		case IVL_ST_CASE:
		  fprintf(vvp_out, "    %%cmp/u %u, %u, %u;\n",
			  cond.base, cvec.base, cond.wid);
		  fprintf(vvp_out, "    %%jmp/1 T_%d.%d, 6;\n",
			  thread_count, local_base+idx);
		  break;

		case IVL_ST_CASEX:
		  fprintf(vvp_out, "    %%cmp/x %u, %u, %u;\n",
			  cond.base, cvec.base, cond.wid);
		  fprintf(vvp_out, "    %%jmp/1 T_%d.%d, 4;\n",
			  thread_count, local_base+idx);
		  break;

		case IVL_ST_CASEZ:
		  fprintf(vvp_out, "    %%cmp/z %u, %u, %u;\n",
			  cond.base, cvec.base, cond.wid);
		  fprintf(vvp_out, "    %%jmp/1 T_%d.%d, 4;\n",
			  thread_count, local_base+idx);
		  break;

		default:
		  assert(0);
	    }
	    
	      /* Done with the case expression */
	    clr_vector(cvec);
      }

	/* Done with the condition expression */
      clr_vector(cond);

	/* Emit code for the default case. */
      if (default_case < count) {
	    ivl_statement_t cst = ivl_stmt_case_stmt(net, default_case);
	    show_statement(cst, sscope);
      }

	/* Jump to the out of the case. */
      fprintf(vvp_out, "    %%jmp T_%d.%d;\n", thread_count,
	      local_base+count);

      for (idx = 0 ;  idx < count ;  idx += 1) {
	    ivl_statement_t cst = ivl_stmt_case_stmt(net, idx);

	    if (idx == default_case)
		  continue;

	    fprintf(vvp_out, "T_%d.%d ;\n", thread_count, local_base+idx);
	    clear_expression_lookaside();
	    show_statement(cst, sscope);

	    fprintf(vvp_out, "    %%jmp T_%d.%d;\n", thread_count,
		    local_base+count);

      }


	/* The out of the case. */
      fprintf(vvp_out, "T_%d.%d ;\n",  thread_count, local_base+count);
      clear_expression_lookaside();

      return 0;
}

static int show_stmt_case_r(ivl_statement_t net, ivl_scope_t sscope)
{
      ivl_expr_t exp = ivl_stmt_cond_expr(net);
      int cond = draw_eval_real(exp);
      unsigned count = ivl_stmt_case_count(net);

      unsigned local_base = local_count;

      unsigned idx, default_case;

      local_count += count + 1;


	/* First draw the branch table.  All the non-default cases
	   generate a branch out of here, to the code that implements
	   the case. The default will fall through all the tests. */
      default_case = count;

      for (idx = 0 ;  idx < count ;  idx += 1) {
	    ivl_expr_t cex = ivl_stmt_case_expr(net, idx);
	    int cvec;

	    if (cex == 0) {
		  default_case = idx;
		  continue;
	    }

	    cvec = draw_eval_real(cex);

	    fprintf(vvp_out, "    %%cmp/wr %d, %d;\n", cond, cvec);
	    fprintf(vvp_out, "    %%jmp/1 T_%d.%d, 4;\n",
		    thread_count, local_base+idx);

	      /* Done with the guard expression value. */
	    clr_word(cvec);
      }

	/* Done with the case expression. */
      clr_word(cond);

	/* Emit code for the case default. The above jump table will
	   fall through to this statement. */
      if (default_case < count) {
	    ivl_statement_t cst = ivl_stmt_case_stmt(net, default_case);
	    show_statement(cst, sscope);
      }

	/* Jump to the out of the case. */
      fprintf(vvp_out, "    %%jmp T_%d.%d;\n", thread_count,
	      local_base+count);

      for (idx = 0 ;  idx < count ;  idx += 1) {
	    ivl_statement_t cst = ivl_stmt_case_stmt(net, idx);

	    if (idx == default_case)
		  continue;

	    fprintf(vvp_out, "T_%d.%d ;\n", thread_count, local_base+idx);
	    clear_expression_lookaside();
	    show_statement(cst, sscope);

	    fprintf(vvp_out, "    %%jmp T_%d.%d;\n", thread_count,
		    local_base+count);

      }


	/* The out of the case. */
      fprintf(vvp_out, "T_%d.%d ;\n",  thread_count, local_base+count);

      return 0;
}

static int show_stmt_cassign(ivl_statement_t net)
{
      ivl_lval_t lval;
      ivl_signal_t lsig;
      unsigned idx;
      char*tmp_label;

      assert(ivl_stmt_lvals(net) == 1);
      lval = ivl_stmt_lval(net, 0);

      lsig = ivl_lval_sig(lval);
      assert(lsig != 0);
      assert(ivl_lval_mux(lval) == 0);
      assert(ivl_signal_pins(lsig) == ivl_stmt_nexus_count(net));
      assert(ivl_lval_part_off(lval) == 0);

      tmp_label = strdup(vvp_signal_label(lsig));
      for (idx = 0 ;  idx < ivl_stmt_nexus_count(net) ;  idx += 1) {
	    fprintf(vvp_out, "    %%cassign V_%s[%u], %s;\n",
		    tmp_label, idx,
		    draw_net_input(ivl_stmt_nexus(net, idx)));
      }
      free(tmp_label);

      return 0;
}

static int show_stmt_deassign(ivl_statement_t net)
{
      ivl_lval_t lval;
      ivl_signal_t lsig;
      unsigned idx;

      assert(ivl_stmt_lvals(net) == 1);
      lval = ivl_stmt_lval(net, 0);

      lsig = ivl_lval_sig(lval);
      assert(lsig != 0);
      assert(ivl_lval_mux(lval) == 0);
      assert(ivl_lval_part_off(lval) == 0);

      for (idx = 0 ;  idx < ivl_lval_pins(lval) ; idx += 1) {
	    fprintf(vvp_out, "    %%deassign V_%s[%u], 1;\n",
		    vvp_signal_label(lsig), idx);
      }
      return 0;
}

static int show_stmt_condit(ivl_statement_t net, ivl_scope_t sscope)
{
      int rc = 0;
      unsigned lab_false, lab_out;
      ivl_expr_t exp = ivl_stmt_cond_expr(net);
      struct vector_info cond = draw_eval_expr(exp, STUFF_OK_XZ|STUFF_OK_47);

      assert(cond.wid == 1);

      lab_false = local_count++;
      lab_out = local_count++;

      fprintf(vvp_out, "    %%jmp/0xz  T_%d.%d, %u;\n",
	      thread_count, lab_false, cond.base);

	/* Done with the condition expression. */
      if (cond.base >= 8)
	    clr_vector(cond);

      if (ivl_stmt_cond_true(net))
	    rc += show_statement(ivl_stmt_cond_true(net), sscope);


      if (ivl_stmt_cond_false(net)) {
	    fprintf(vvp_out, "    %%jmp T_%d.%d;\n", thread_count, lab_out);
	    fprintf(vvp_out, "T_%d.%u ;\n", thread_count, lab_false);
	    clear_expression_lookaside();

	    rc += show_statement(ivl_stmt_cond_false(net), sscope);

	    fprintf(vvp_out, "T_%d.%u ;\n", thread_count, lab_out);
	    clear_expression_lookaside();

      } else {
	    fprintf(vvp_out, "T_%d.%u ;\n", thread_count, lab_false);
	    clear_expression_lookaside();
      }

      return rc;
}

/*
 * The delay statement is easy. Simply write a ``%delay <n>''
 * instruction to delay the thread, then draw the included statement.
 * The delay statement comes from verilog code like this:
 *
 *        ...
 *        #<delay> <stmt>;
 */
static int show_stmt_delay(ivl_statement_t net, ivl_scope_t sscope)
{
      int rc = 0;
      unsigned long delay = ivl_stmt_delay_val(net);
      ivl_statement_t stmt = ivl_stmt_sub_stmt(net);

      fprintf(vvp_out, "    %%delay %lu;\n", delay);
	/* Lots of things can happen during a delay. */
      clear_expression_lookaside();

      rc += show_statement(stmt, sscope);

      return rc;
}

/*
 * The delayx statement is slightly more complex in that it is
 * necessary to calculate the delay first. Load the calculated delay
 * into and index register and use the %delayx instruction to do the
 * actual delay.
 */
static int show_stmt_delayx(ivl_statement_t net, ivl_scope_t sscope)
{
      int rc = 0;
      ivl_expr_t exp = ivl_stmt_delay_expr(net);
      ivl_statement_t stmt = ivl_stmt_sub_stmt(net);

      switch (ivl_expr_value(exp)) {

	  case IVL_VT_VECTOR: {
		struct vector_info del = draw_eval_expr(exp, 0);
		fprintf(vvp_out, "    %%ix/get 0, %u, %u;\n",
			del.base, del.wid);
		clr_vector(del);
		break;
	  }

	  case IVL_VT_REAL: {
		int word = draw_eval_real(exp);
		fprintf(vvp_out, "    %%cvt/ir 0, %d;\n", word);
		clr_word(word);
		break;
	  }

	  default:
	    assert(0);
      }

      fprintf(vvp_out, "    %%delayx 0;\n");
	/* Lots of things can happen during a delay. */
      clear_expression_lookaside();

      rc += show_statement(stmt, sscope);
      return rc;
}

static int show_stmt_disable(ivl_statement_t net, ivl_scope_t sscope)
{
      int rc = 0;

      ivl_scope_t target = ivl_stmt_call(net);
      fprintf(vvp_out, "    %%disable S_%p;\n", target);

      return rc;
}

static int show_stmt_force(ivl_statement_t net)
{
      ivl_lval_t lval;
      ivl_signal_t lsig;
      unsigned idx;
      static unsigned force_functor_label = 0;
      char*tmp_label;

      assert(ivl_stmt_lvals(net) == 1);
      lval = ivl_stmt_lval(net, 0);

      lsig = ivl_lval_sig(lval);
      assert(lsig != 0);
      assert(ivl_lval_mux(lval) == 0);
      assert(ivl_lval_part_off(lval) == 0);

      force_functor_label += 1;
      tmp_label = strdup(vvp_signal_label(lsig));
      for (idx = 0 ;  idx < ivl_lval_pins(lval) ; idx += 1) {
	    fprintf(vvp_out, "f_%u.%u .force V_%s[%u], %s;\n",
		    force_functor_label, idx,
		    tmp_label, idx,
		    draw_net_input(ivl_stmt_nexus(net, idx)));
      } 
      free(tmp_label);

      for (idx = 0 ;  idx < ivl_lval_pins(lval) ; idx += 1) {
	    fprintf(vvp_out, "    %%force f_%u.%u, 1;\n",
		    force_functor_label, idx);
      }
      return 0;
}

static int show_stmt_forever(ivl_statement_t net, ivl_scope_t sscope)
{
      int rc = 0;
      ivl_statement_t stmt = ivl_stmt_sub_stmt(net);
      unsigned lab_top = local_count++;

      fprintf(vvp_out, "T_%u.%u ;\n", thread_count, lab_top);
      rc += show_statement(stmt, sscope);
      fprintf(vvp_out, "    %%jmp T_%u.%u;\n", thread_count, lab_top);

      return rc;
}

static int show_stmt_fork(ivl_statement_t net, ivl_scope_t sscope)
{
      unsigned idx;
      int rc = 0;
      unsigned cnt = ivl_stmt_block_count(net);
      ivl_scope_t scope = ivl_stmt_block_scope(net);

      unsigned out = transient_id++;
      unsigned id_base = transient_id;

	/* cnt is the number of sub-threads. If the fork-join has no
	   name, then we can put one of the sub-threads in the current
	   thread, so decrement the count by one. */
      if (scope == 0) {
	    cnt -= 1;
	    scope = sscope;
      }

      transient_id += cnt;

	/* If no subscope use provided */
      if (!scope) scope = sscope;

	/* Draw a fork statement for all but one of the threads of the
	   fork/join. Send the threads off to a bit of code where they
	   are implemented. */
      for (idx = 0 ;  idx < cnt ;  idx += 1) {
	    fprintf(vvp_out, "    %%fork t_%u, S_%p;\n",
		    id_base+idx, scope);
      }

	/* If we are putting one sub-thread into the current thread,
	   then draw its code here. */
      if (ivl_stmt_block_scope(net) == 0)
	    rc += show_statement(ivl_stmt_block_stmt(net, cnt), scope);


	/* Generate enough joins to collect all the sub-threads. */
      for (idx = 0 ;  idx < cnt ;  idx += 1) {
	    fprintf(vvp_out, "    %%join;\n");
      }
      fprintf(vvp_out, "    %%jmp t_%u;\n", out);

	/* Generate the sub-threads themselves. */
      for (idx = 0 ;  idx < cnt ;  idx += 1) {
	    fprintf(vvp_out, "t_%u ;\n", id_base+idx);
	    clear_expression_lookaside();
	    rc += show_statement(ivl_stmt_block_stmt(net, idx), scope);
	    fprintf(vvp_out, "    %%end;\n");
      }

	/* This is the label for the out. Use this to branch around
	   the implementations of all the child threads. */
      clear_expression_lookaside();
      fprintf(vvp_out, "t_%u ;\n", out);

      return rc;
}

/*
 * noop statements are implemented by doing nothing.
 */
static int show_stmt_noop(ivl_statement_t net)
{
      return 0;
}

static int show_stmt_release(ivl_statement_t net)
{
      ivl_lval_t lval;
      ivl_signal_t lsig;
      unsigned idx;

	/* If there are no l-vals (the target signal has been elided)
	   then turn the release into a no-op. In other words, we are
	   done before we start. */
      if (ivl_stmt_lvals(net) == 0)
	    return 0;

      assert(ivl_stmt_lvals(net) == 1);
      lval = ivl_stmt_lval(net, 0);

      lsig = ivl_lval_sig(lval);
      assert(lsig != 0);
      assert(ivl_lval_mux(lval) == 0);
      assert(ivl_lval_part_off(lval) == 0);

	/* On release, reg variables hold the value that was forced on
	   to them. */
      for (idx = 0 ;  idx < ivl_lval_pins(lval) ; idx += 1) {
	    if (ivl_signal_type(lsig) == IVL_SIT_REG) {
		  fprintf(vvp_out, "    %%load 4, V_%s[%u];\n",
			  vvp_signal_label(lsig), idx);
		  fprintf(vvp_out, "    %%set V_%s[%u], 4;\n",
			  vvp_signal_label(lsig), idx);
	    }
	    fprintf(vvp_out, "    %%release V_%s[%u];\n",
		    vvp_signal_label(lsig), idx);
      }

      return 0;
}

static int show_stmt_repeat(ivl_statement_t net, ivl_scope_t sscope)
{
      int rc = 0;
      unsigned lab_top = local_count++, lab_out = local_count++;
      ivl_expr_t exp = ivl_stmt_cond_expr(net);
      struct vector_info cnt = draw_eval_expr(exp, 0);

	/* Test that 0 < expr */
      fprintf(vvp_out, "T_%u.%u %%cmp/u 0, %u, %u;\n", thread_count,
	      lab_top, cnt.base, cnt.wid);
      clear_expression_lookaside();
      fprintf(vvp_out, "    %%jmp/0xz T_%u.%u, 5;\n", thread_count, lab_out);
	/* This adds -1 (all ones in 2's complement) to the count. */
      fprintf(vvp_out, "    %%add %u, 1, %u;\n", cnt.base, cnt.wid);

      rc += show_statement(ivl_stmt_sub_stmt(net), sscope);

      fprintf(vvp_out, "    %%jmp T_%u.%u;\n", thread_count, lab_top);
      fprintf(vvp_out, "T_%u.%u ;\n", thread_count, lab_out);
      clear_expression_lookaside();

      clr_vector(cnt);

      return rc;
}

static int show_stmt_trigger(ivl_statement_t net)
{
      ivl_event_t ev = ivl_stmt_events(net, 0);
      assert(ev);
      fprintf(vvp_out, "    %%set E_%p, 0;\n", ev);
      return 0;
}

static int show_stmt_utask(ivl_statement_t net)
{
      ivl_scope_t task = ivl_stmt_call(net);

      fprintf(vvp_out, "    %%fork TD_%s",
	      vvp_mangle_id(ivl_scope_name(task)));
      fprintf(vvp_out, ", S_%p;\n", task);
      fprintf(vvp_out, "    %%join;\n");
      clear_expression_lookaside();
      return 0;
}

static int show_stmt_wait(ivl_statement_t net, ivl_scope_t sscope)
{
      if (ivl_stmt_nevent(net) == 1) {
	    ivl_event_t ev = ivl_stmt_events(net, 0);
	    fprintf(vvp_out, "    %%wait E_%p;\n", ev);

      } else {
	    unsigned idx;
	    static unsigned int cascade_counter = 0;
	    ivl_event_t ev = ivl_stmt_events(net, 0);
	    fprintf(vvp_out, "Ewait_%u .event/or E_%p", cascade_counter, ev);

	    for (idx = 1 ;  idx < ivl_stmt_nevent(net) ;  idx += 1) {
		  ev = ivl_stmt_events(net, idx);
		  fprintf(vvp_out, ", E_%p", ev);
	    }
	    fprintf(vvp_out, ";\n    %%wait Ewait_%u;\n", cascade_counter);
	    cascade_counter += 1;
      }
	/* Always clear the expression lookaside after a
	   %wait. Anything can happen while the thread is waiting. */
      clear_expression_lookaside();

      return show_statement(ivl_stmt_sub_stmt(net), sscope);
}

static struct vector_info reduction_or(struct vector_info cvec)
{
      struct vector_info result;

      switch (cvec.base) {
	  case 0:
	    result.base = 0;
	    result.wid = 1;
	    break;
	  case 1:
	    result.base = 1;
	    result.wid = 1;
	    break;
	  case 2:
	  case 3:
	    result.base = 0;
	    result.wid = 1;
	    break;
	  default:
	    clr_vector(cvec);
	    result.base = allocate_vector(1);
	    result.wid = 1;
	    fprintf(vvp_out, "    %%or/r %u, %u, %u;\n", result.base,
		    cvec.base, cvec.wid);
	    break;
      }

      return result;
}

static int show_stmt_while(ivl_statement_t net, ivl_scope_t sscope)
{
      int rc = 0;
      struct vector_info cvec;

      unsigned top_label = local_count++;
      unsigned out_label = local_count++;

	/* Start the loop. The top of the loop starts a basic block
	   because it can be entered from above or from the bottom of
	   the loop. */
      fprintf(vvp_out, "T_%d.%d ;\n", thread_count, top_label);
      clear_expression_lookaside();

	/* Draw the evaluation of the condition expression, and test
	   the result. If the expression evaluates to false, then
	   branch to the out label. */
      cvec = draw_eval_expr(ivl_stmt_cond_expr(net), STUFF_OK_XZ|STUFF_OK_47);
      if (cvec.wid > 1)
	    cvec = reduction_or(cvec);

      fprintf(vvp_out, "    %%jmp/0xz T_%d.%d, %u;\n",
	      thread_count, out_label, cvec.base);
      if (cvec.base >= 8)
	    clr_vector(cvec);

	/* Draw the body of the loop. */
      rc += show_statement(ivl_stmt_sub_stmt(net), sscope);

	/* This is the bottom of the loop. branch to the top where the
	   test is repeased, and also draw the out label. */
      fprintf(vvp_out, "    %%jmp T_%d.%d;\n", thread_count, top_label);
      fprintf(vvp_out, "T_%d.%d ;\n", thread_count, out_label);
      clear_expression_lookaside();
      return rc;
}

static int show_system_task_call(ivl_statement_t net)
{
      unsigned parm_count = ivl_stmt_parm_count(net);
      
      if (parm_count == 0) {
	    fprintf(vvp_out, "    %%vpi_call \"%s\";\n", ivl_stmt_name(net));
	    clear_expression_lookaside();
	    return 0;
      }

      draw_vpi_task_call(net);

	/* VPI calls can manipulate anything, so clear the expression
	   lookahead table after the call. */
      clear_expression_lookaside();

      return 0;
}

/*
 * This function draws a statement as vvp assembly. It basically
 * switches on the statement type and draws code based on the type and
 * further specifics.
 */
static int show_statement(ivl_statement_t net, ivl_scope_t sscope)
{
      const ivl_statement_type_t code = ivl_statement_type(net);
      int rc = 0;

      switch (code) {

	  case IVL_ST_ASSIGN:
	    rc += show_stmt_assign(net);
	    break;

	  case IVL_ST_ASSIGN_NB:
	    rc += show_stmt_assign_nb(net);
	    break;

	  case IVL_ST_BLOCK:
	    if (ivl_stmt_block_scope(net))
		  rc += show_stmt_block_named(net, sscope);
	    else
		  rc += show_stmt_block(net, sscope);
	    break;

	  case IVL_ST_CASE:
	  case IVL_ST_CASEX:
	  case IVL_ST_CASEZ:
	    rc += show_stmt_case(net, sscope);
	    break;

	  case IVL_ST_CASER:
	    rc += show_stmt_case_r(net, sscope);
	    break;

	  case IVL_ST_CASSIGN:
	    rc += show_stmt_cassign(net);
	    break;

	  case IVL_ST_CONDIT:
	    rc += show_stmt_condit(net, sscope);
	    break;

	  case IVL_ST_DEASSIGN:
	    rc += show_stmt_deassign(net);
	    break;

	  case IVL_ST_DELAY:
	    rc += show_stmt_delay(net, sscope);
	    break;

	  case IVL_ST_DELAYX:
	    rc += show_stmt_delayx(net, sscope);
	    break;

	  case IVL_ST_DISABLE:
	    rc += show_stmt_disable(net, sscope);
	    break;

	  case IVL_ST_FORCE:
	    rc += show_stmt_force(net);
	    break;

	  case IVL_ST_FOREVER:
	    rc += show_stmt_forever(net, sscope);
	    break;

	  case IVL_ST_FORK:
	    rc += show_stmt_fork(net, sscope);
	    break;

	  case IVL_ST_NOOP:
	    rc += show_stmt_noop(net);
	    break;

	  case IVL_ST_RELEASE:
	    rc += show_stmt_release(net);
	    break;

	  case IVL_ST_REPEAT:
	    rc += show_stmt_repeat(net, sscope);
	    break;

	  case IVL_ST_STASK:
	    rc += show_system_task_call(net);
	    break;

	  case IVL_ST_TRIGGER:
	    rc += show_stmt_trigger(net);
	    break;

	  case IVL_ST_UTASK:
	    rc += show_stmt_utask(net);
	    break;

	  case IVL_ST_WAIT:
	    rc += show_stmt_wait(net, sscope);
	    break;

	  case IVL_ST_WHILE:
	    rc += show_stmt_while(net, sscope);
	    break;

	  default:
	    fprintf(stderr, "vvp.tgt: Unable to draw statement type %u\n",
		    code);
	    rc += 1;
	    break;
      }

      return rc;
}


/*
 * The process as a whole is surrounded by this code. We generate a
 * start label that the .thread statement can use, and we generate
 * code to terminate the thread.
 */

int draw_process(ivl_process_t net, void*x)
{
      int rc = 0;
      unsigned idx;
      ivl_scope_t scope = ivl_process_scope(net);
      ivl_statement_t stmt = ivl_process_stmt(net);

      int push_flag = 0;

      for (idx = 0 ;  idx < ivl_process_attr_cnt(net) ;  idx += 1) {

	    ivl_attribute_t attr = ivl_process_attr_val(net, idx);

	    if (strcmp(attr->key, "_ivl_schedule_push") == 0) {

		  push_flag = 1;

	    } else if (strcmp(attr->key, "ivl_combinational") == 0) {

		  push_flag = 1;

	    }
      }

      local_count = 0;
      fprintf(vvp_out, "    .scope S_%p;\n", scope);

	/* Generate the entry label. Just give the thread a number so
	   that we ar certain the label is unique. */
      fprintf(vvp_out, "T_%d ;\n", thread_count);
      clear_expression_lookaside();

	/* Draw the contents of the thread. */
      rc += show_statement(stmt, scope);


	/* Terminate the thread with either an %end instruction (initial
	   statements) or a %jmp back to the beginning of the thread. */

      switch (ivl_process_type(net)) {

	  case IVL_PR_INITIAL:
	    fprintf(vvp_out, "    %%end;\n");
	    break;

	  case IVL_PR_ALWAYS:
	    fprintf(vvp_out, "    %%jmp T_%d;\n", thread_count);
	    break;
      }

	/* Now write out the .thread directive that tells vvp where
	   the thread starts. */

      if (push_flag) {
	    fprintf(vvp_out, "    .thread T_%d, $push;\n", thread_count);
      } else {
	    fprintf(vvp_out, "    .thread T_%d;\n", thread_count);
      }

      thread_count += 1;
      return rc;
}

int draw_task_definition(ivl_scope_t scope)
{
      int rc = 0;
      ivl_statement_t def = ivl_scope_def(scope);

      fprintf(vvp_out, "TD_%s ;\n", vvp_mangle_id(ivl_scope_name(scope)));
      clear_expression_lookaside();

      assert(def);
      rc += show_statement(def, scope);

      fprintf(vvp_out, "    %%end;\n");

      thread_count += 1;
      return rc;
}

int draw_func_definition(ivl_scope_t scope)
{
      int rc = 0;
      ivl_statement_t def = ivl_scope_def(scope);

      fprintf(vvp_out, "TD_%s ;\n", vvp_mangle_id(ivl_scope_name(scope)));
      clear_expression_lookaside();

      assert(def);
      rc += show_statement(def, scope);

      fprintf(vvp_out, "    %%end;\n");

      thread_count += 1;
      return rc;
}

/*
 * $Log: vvp_process.c,v $
 * Revision 1.92  2004/05/19 03:25:42  steve
 *  Generate code for nb assign to reals.
 *
 * Revision 1.91  2003/12/03 02:46:24  steve
 *  Add support for wait on list of named events.
 *
 * Revision 1.90  2003/10/25 02:07:57  steve
 *  vvp_signal_label does not return a unique string.
 *
 * Revision 1.89  2003/09/04 20:28:06  steve
 *  Support time0 resolution of combinational threads.
 *
 * Revision 1.88  2003/07/29 05:12:10  steve
 *  All the threads of a named fork go into sub-scope.
 *
 * Revision 1.87  2003/05/26 04:45:37  steve
 *  Use set/x0/x if the target vector is too wide for set/x0.
 *
 * Revision 1.86  2003/05/17 04:38:19  steve
 *  Account for nested fork scopes in disable.
 *
 * Revision 1.85  2003/05/14 05:26:41  steve
 *  Support real expressions in case statements.
 *
 * Revision 1.84  2003/03/25 02:15:48  steve
 *  Use hash code for scope labels.
 *
 * Revision 1.83  2003/03/15 04:45:18  steve
 *  Allow real-valued vpi functions to have arguments.
 *
 * Revision 1.82  2003/03/06 01:17:46  steve
 *  Use number for event labels.
 */

