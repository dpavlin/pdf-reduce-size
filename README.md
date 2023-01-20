# Reduce PDF size

My experiments trying to reduce size of scanned pdf
with 100+ pages (which breaks graphicsmagick convert).

## converting to black and white version

```
./pdf-to-bilevel.pl file.pdf
```

## conversion using ghostscript

This will resize your pdf into fixed dpi and in my expirience
is less useful than converting it to black and white, especially
on poor scans

```
Usage: ./pdf-optimize.sh file.pdf [screen]
# screen   low-resolution "Screen Optimized" 96 dpi
# ebook    medium-resolution "eBook"         150 dpi
# printer  output "Print Optimized"          300 dpi
# prepress output "Prepress Optimized"
# default
# kindle - special conversion to grayscale, 150 dpi
```
