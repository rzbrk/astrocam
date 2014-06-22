# astrocam

Bash script to perform astrophotography with digital cameras supported by 
gphoto2 (http://gphoto.sourceforge.net/). So far, it has only been tested 
with Canon EOS 400D.

This script uses gphoto2 to remote control a digital camera over USB. You 
are able to define shutter speed, aperture and the number of images to be 
taken. All these definitions are done via a parameter file. Capturing of the 
defined number of images are then done without attendance.

If requested, the script can also perform dark image takes with the same 
settings as the images before. The script then asks you to cover the lens 
for the dark images. To use this feature, set dark="yes" in the parameter 
file and define the number of dark images, e.g. n_darks=10.

## Prerequisites

This skript needs gphoto2 and ImageMagick.

## Invokation

astrocam <parameter file>


