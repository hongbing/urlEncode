#!/bin/sh
#参考：http://www.shelldorado.com/scripts/cmds/urlencode.txt

value=$1
urlEncode(){
  encoded_str=`echo "$*" | awk '
    BEGIN {
	split ("1 2 3 4 5 6 7 8 9 A B C D E F", hextab, " ")
	hextab [0] = 0
	for ( i=1; i<=255; ++i ) ord [ sprintf ("%c", i) "" ] = i + 0
    }
    {
	encoded = ""
	for ( i=1; i<=length ($0); ++i ) {
	    c = substr ($0, i, 1)
	    if ( c ~ /[a-zA-Z0-9.-]/ ) {
		encoded = encoded c		# safe character
	    } else if ( c == " " ) {
		encoded = encoded "+"	# special handling
	    } else {
		# unsafe character, encode it as a two-digit hex-number
		lo = ord [c] % 16
		hi = int (ord [c] / 16);
		encoded = encoded "%" hextab [hi] hextab [lo]
	    }
	}
	    print encoded
    }
' `
}

urlEncode $value
echo $encoded_str
