#!/bin/bash

# Path to build your kernel
  k=~/kernel/eliteshamu
# Directory for the any kernel updater
  t=$k/packages
# Date to add to zip
  today=$(date +"%m_%d_%Y")

# Clean old builds
   echo "Clean"
     rm -rf $k/out
#     make clean

# Setup the build
 cd $k/arch/arm/configs/BBKconfigs
    for c in *
      do
        cd $k
# Setup output directory
    mkdir -p "out/$c"
    mkdir -p "out/$c/system/lib/modules/"
    cp -R "$t/system" out/$c
    cp -R "$t/META-INF" out/$c
#    mkdir -p "out/$c/system/lib/modules/pronto"

  m=$k/out/$c/system/lib/modules
  z=$c-$today

TOOLCHAIN=/home/forrest/kernel/linaro-4.9.3/bin/arm-cortex_a15-linux-gnueabihf-
export ARCH=arm
export SUBARCH=arm

# make mrproper
#make CROSS_COMPILE=$TOOLCHAIN -j`grep 'processor' /proc/cpuinfo | wc -l` mrproper
 
# remove backup files
find ./ -name '*~' | xargs rm
# rm compile.log

# make kernel
make 'shamu_defconfig'
make -j`grep 'processor' /proc/cpuinfo | wc -l` CROSS_COMPILE=$TOOLCHAIN #>> compile.log 2>&1 || exit -1

# Grab modules & zImage
   echo ""
   echo "<<>><<>>  Collecting modules and zimage <<>><<>>"
   echo ""
   #cp $k/drivers/staging/prima/wlan.ko out/$c/system/lib/modules/pronto/wlan.ko
   for mo in $(find . -name "*.ko"); do
		cp "${mo}" $m
   done
# Collect imgs
   ./splitbootimg boot.img
   cp $k/arch/arm/boot/zImage-dtb $k
   ./bootimg
   cp $k/boot.img out/$c/boot.img

# Clean up
   rm -rf $k/boot.img-dtb
   rm -rf $k/boot.img-kernel
   rm -rf $k/boot.img-ramdisk.gz
   rm -rf $k/zImage-dtb
   
# Build Zip
 clear
   echo "Creating $z.zip"
     cd $k/out/$c/
       7z a -tzip -mx5 "$z.zip"
         mv $z.zip $k/out/$z.zip
# cp $k/out/$z.zip $db/$z.zip
#           rm -rf $k/out/$c
# Line below for debugging purposes,  uncomment to stop script after each config is run
#read this
      done
