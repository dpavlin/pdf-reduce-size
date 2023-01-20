#!/bin/sh -e

for=screen

if [ -z "$1" ] ; then

echo "Usage: $0 file.pdf [screen]"

cat << _FOR_OPTIONS_
# screen   low-resolution "Screen Optimized" 96 dpi
# ebook    medium-resolution "eBook"         150 dpi
# printer  output "Print Optimized"          300 dpi
# prepress output "Prepress Optimized"
# default
# kindle - special conversion to grayscale, 150 dpi
_FOR_OPTIONS_

exit 1

fi

test ! -z "$2" && for=$2
to=`echo $1 | sed "s/\.pdf/-$for.pdf/i"`

test "$for" = "kindle" && for="ebook 
	-sColorConversionStrategy=Gray -dProcessColorModel=/DeviceGray

	-dAutoFilterColorImages=false -dColorImageFilter=/DCTEncode

	-dDownsampleColorImages=true -dColorImageDownsampleType=/Average 
	-dColorImageDownsampleThreshold=1.5 -dColorImageResolution=150
"

time gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/$for \
	-dNOPAUSE -dQUIET -dBATCH -sOutputFile=/tmp/$to $1 \
&& ls -al $1 /tmp/$to

