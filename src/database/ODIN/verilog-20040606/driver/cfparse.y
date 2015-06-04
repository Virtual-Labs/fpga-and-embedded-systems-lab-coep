%{
/*
 * Copyright (c) 20001 Stephen Williams (steve@icarus.com)
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
#ident "$Id: cfparse.y,v 1.10 2003/09/26 21:25:58 steve Exp $"
#endif


# include  "globals.h"
# include  "cfparse_misc.h"
# include  <ctype.h>
# include  <stdlib.h>
# include  <string.h>


/*
 * This flag is set to 0, 1 or 2 if file names are to be translated to
 * uppercase(1) or lowercase(2).
 */
static int setcase_filename_flag = 0;
static void translate_file_name(char*text)
{
      switch (setcase_filename_flag) {
	  case 0:
	    break;
	  case 1:
	    while (*text) {
		  *text = toupper(*text);
		  text += 1;
	    }
	    break;
	  case 2:
	    while (*text) {
		  *text = tolower(*text);
		  text += 1;
	    }
	    break;
      }
}

%}

%union {
      char*text;
};

%token TOK_Da TOK_Dv TOK_Dy
%token TOK_DEFINE TOK_INCDIR TOK_LIBDIR TOK_LIBDIR_NOCASE TOK_LIBEXT
%token <text> TOK_PLUSARG TOK_PLUSWORD TOK_STRING

%%

start
	:
	| item_list
	;

item_list
	: item_list item
	| item
	;

item
  /* Absent any other matching, a token string is taken to be the name
     of a source file. Add the file to the file list. */

	: TOK_STRING
		{ char*tmp = substitutions($1);
		  translate_file_name(tmp);
		  process_file_name(tmp);
		  free($1);
		  free(tmp);
		}

  /* The -a flag is completely ignored. */

        | TOK_Da { }

  /* The -v <libfile> flag is ignored, and the <libfile> is processed
     as an ordinary source file. */

        | TOK_Dv TOK_STRING
		{ char*tmp = substitutions($2);
		  translate_file_name(tmp);
		  process_file_name(tmp);
		  fprintf(stderr, "%s:%u: Ignoring -v in front of %s\n",
			  @1.text, @1.first_line, $2);
		  free($2);
		  free(tmp);
		}

  /* This rule matches "-y <path>" sequences. This does the same thing
     as -y on the command line, so add the path to the library
     directory list. */

        | TOK_Dy TOK_STRING
		{ char*tmp = substitutions($2);
		  process_library_switch(tmp);
		  free($2);
		  free(tmp);
		}

        | TOK_LIBDIR TOK_PLUSARG
		{ char*tmp = substitutions($2);
		  process_library_switch(tmp);
		  free($2);
		  free(tmp);
		}

        | TOK_LIBDIR_NOCASE TOK_PLUSARG
		{ char*tmp = substitutions($2);
		  process_library_nocase_switch(tmp);
		  free($2);
		  free(tmp);
		}

	| TOK_DEFINE TOK_PLUSARG
		{ process_define($2);
		  free($2);
		}

  /* The +incdir token introduces a list of +<path> arguments that are
     the include directories to search. */

	| TOK_INCDIR inc_args

  /* The +libext token introduces a list of +<ext> arguments that
     become individual -Y flags to ivl. */

	| TOK_LIBEXT libext_args

  /* The +<word> tokens that are not otherwise matched, are
     ignored. The skip_args rule arranges for all the argument words
     to be consumed. */

	| TOK_PLUSWORD skip_args
		{ fprintf(stderr, "%s:%u: Ignoring %s\n",
			  @1.text, @1.first_line, $1);
		  free($1);
		}
	| TOK_PLUSWORD
		{ if (strcmp($1, "+toupper-filenames") == 0) {
		        setcase_filename_flag = 1;
		  } else if (strcmp($1, "+tolower-filenames") == 0) {
			setcase_filename_flag = 2;
		  } else {
			fprintf(stderr, "%s:%u: Ignoring %s\n",
				@1.text, @1.first_line, $1);
		  }
		  free($1);
		}
	;

  /* inc_args are +incdir+ arguments in order. */
inc_args
	: inc_args inc_arg
	| inc_arg
	;

inc_arg : TOK_PLUSARG
		{ char*tmp = substitutions($1);
		  process_include_dir(tmp);
		  free($1);
		  free(tmp);
		}
	;

  /* inc_args are +incdir+ arguments in order. */
libext_args
	: libext_args libext_arg
	| libext_arg
	;

libext_arg : TOK_PLUSARG
		{ process_library2_switch($1);
		  free($1);
		}
	;

  /* skip_args are arguments to a +word flag that is not otherwise
     parsed. This rule matches them and releases the strings, so that
     they can be safely ignored. */
skip_args
	: skip_args skip_arg
	| skip_arg
	;

skip_arg : TOK_PLUSARG
		{ free($1);
		}
	;

%%

int yyerror(const char*msg)
{
	return 0;
}
