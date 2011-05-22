#!/bin/sh -x

for=screen

cat << _FOR_OPTIONS_
# screen   low-resolution "Screen Optimized"
# ebook    medium-resolution "eBook"
# printer  output "Print Optimized"
# prepress output "Prepress Optimized"
# default
_FOR_OPTIONS_

test ! -z "$2" && for=$2
to=`echo $1 | sed "s/\.pdf/-$for.pdf/i"`

test "$for" == "kindle" && for="ebook 
	-sColorConversionStrategy=Gray -dProcessColorModel=/DeviceGray

	-dAutoFilterColorImages=false -dColorImageFilter=/DCTEncode

	-dDownsampleColorImages=true -dColorImageDownsampleType=/Average 
	-dColorImageDownsampleThreshold=1.5 -dColorImageResolution=150
"

time gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/$for \
	-dNOPAUSE -dQUIET -dBATCH -sOutputFile=/tmp/$to $1 \
&& ls -al $1 /tmp/$to

