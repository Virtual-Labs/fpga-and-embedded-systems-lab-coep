#!/bin/sh
#
#    This source code is free software; you can redistribute it
#    and/or modify it in source code form under the terms of the GNU
#    Library General Public License as published by the Free Software
#    Foundation; either version 2 of the License, or (at your option)
#    any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU Library General Public License for more details.
#
#    You should have received a copy of the GNU Library General Public
#    License along with this program; if not, write to the Free
#    Software Foundation, Inc.,
#    59 Temple Place - Suite 330
#    Boston, MA 02111-1307, USA
#
#ident "$Id: iverilog-vpi.sh,v 1.14 2004/05/20 00:40:34 steve Exp $"

# These are the variables used for compiling files
CC=gcc
CXX=gcc
CFLAGS="@PIC@ -O -I@INCLUDEDIR@"

# These are used for linking...
LD=gcc
LDFLAGS32="@SHARED@ -L@LIBDIR@"
LDFLAGS64="@SHARED@ -L@LIBDIR64@"
LDFLAGS="$LDFLAGS64"
LDLIBS="-lveriuser -lvpi"

INSTDIR64="@VPIDIR1@"
INSTDIR32="@VPIDIR2@"
if test x$INSTDIR32 = x
then
    INSTDIR32=$INSTDIR64
fi

INSTDIR="$INSTDIR64"

CCSRC=
CXSRC=
OBJ=
LIB=
OUT=
INCOPT=

# --
# parse the command line switches. This collects the source files
# and precompiled object files, and maybe user libraries. As we are
# going, guess an output file name.
for parm
do
    case $parm
    in

    *.c) CCSRC="$CCSRC $parm"
         if [ x$OUT = x ]; then
	    OUT=`basename $parm .c`
	 fi
	 ;;

    *.cc) CXSRC="$CXSRC $parm"
         if [ x$OUT = x ]; then
	    OUT=`basename $parm .cc`
	 fi
	 ;;

    *.o) OBJ="$OBJ $parm"
         if [ x$OUT = x ]; then
	    OUT=`basename $parm .o`
	 fi
	 ;;

    --name=*)
	 OUT=`echo $parm | cut -b8-`
	 ;;

    -l*) LIB="$LIB $parm"
	 ;;

    -I*) INCOPT="$INCOPT $parm"
	 echo "$parm"
	 ;;

    -m32) LDFLAGS="-m32 $LDFLAGS32"
	  CFLAGS="-m32 $CFLAGS"
	  INSTDIR="$INSTDIR32"
	  ;;

    --cflags)
	 echo "$CFLAGS"
	 exit;
	 ;;

    --ldflags)
	 echo "$LDFLAGS"
	 exit;
	 ;;

    --ldlibs)
	 echo "$LDLIBS"
	 exit;
	 ;;

    --install-dir)
	 echo "@LIBDIR@/ivl/$INSTDIR"
	 exit
	 ;;
    esac

done

if [ x$OUT = x ]; then
    echo "Usage: $0 [src and obj files]..." 1>&2
    exit 0
fi

# Put the .vpi on the result file.
OUT=$OUT".vpi"

compile_errors=0

# Compile all the source files into object files
for src in $CCSRC
do
    base=`basename $src .c`
    obj=$base".o"

    echo "Compiling $src..."
    $CC -c -o $obj $CFLAGS $INCOPT $src || compile_errors=`expr $compile_errors + 1`
    OBJ="$OBJ $obj"
done

for src in $CXSRC
do
    base=`basename $src .cc`
    obj=$base".o"

    echo "Compiling $src..."
    $CXX -c -o $obj $CFLAGS $INCOPT $src || compile_errors=`expr $compile_errors + 1`
    OBJ="$OBJ $obj"
done

if test $compile_errors -gt 0
then
    echo "Some ($compile_errors) files failed to compile."
    exit $compile_errors
fi

echo "Making $OUT from $OBJ..."
exec $LD -o $OUT $LDFLAGS $OBJ $LIB $LDLIBS
