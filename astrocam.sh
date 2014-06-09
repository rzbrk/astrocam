#!/bin/bash

# Settings
shutter=2
aperture=3.5
iso=400
n_images=2
dark="yes"
n_darks=2

cam="/usr/bin/gphoto2 --port usb "

# Say hello
echo "-=/ ASTROCAM \=-"
echo ""

# Get some device information
batt=`$cam --get-config batterylevel | grep Current | awk '{print $2}'`
model=`$cam --get-config cameramodel | grep Current | sed -e 's/Current: //'`

echo "Camera Model: $model"
echo "Battery: $batt"
echo ""
echo "Configure camera ..."

# First, disable auto power off
$cam --set-config-value autopoweroff=0

# Comfigure iso, shutter speed and aperture
$cam --set-config-value iso=$iso
$cam --set-config-value shutterspeed=$shutter
$cam --set-config-value aperture=$aperture

# Read in description
echo ""
echo -n "Description: "
read descr

# Create directory and change to it 
dir=`date +%Y-%m-%d-%H%M%S`
dir="$dir $descr"
mkdir "$dir"
cd "$dir"

echo ""
echo -n "Press any key to start ..."
read go

# Perform images
$cam --capture-image-and-download -I 1 -F $n_images

# Perform dark images
if [ "$dark" == "yes"  ]; then
    echo ""
    echo -n "Cover lens for dark images and press any key to continue ..."
    read go
    mkdir darks
    cd darks
    $cam --capture-image-and-download --filename=dark-%03n.%C -I 1 -F $n_darks
    echo "Calculate dark master (in background) ..."
    convert *.jpg -evaluate-sequence mean dark_master.jpg &
fi

echo "Finished!"

exit 0
