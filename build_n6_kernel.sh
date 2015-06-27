#!/bin/bash

# Path to build your kernel
  k=~/kernel/eliteshamu
# Directory for the any kernel updater
  t=$k/packageslp
  u=$k/packagesm
# Date to add to zip
  today=$(date +"%m_%d_%Y")

# Clean old builds
   echo "Clean"
     rm -rf $k/out
#     make clean

# Setup the build
 cd $k/arch/arm/configs/BBKconfigsLP
    for c in *
      do
        cd $k
# Setup output directory
    mkdir -p "out/$c"
    cp -R "$t/system" out/$c
    cp -R "$t/META-INF" out/$c
    cp -R "$t/patch" out/$c
    cp -R "$t/ramdisk" out/$c
    cp -R "$t/tools" out/$c
    cp -R "$t/anykernel.sh" out/$c

  y=$c-$today

TOOLCHAIN=/home/forrest/kernel/arm-eabi-6.0/bin/arm-eabi-
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

# Grab zImage-dtb
   echo ""
   echo "<<>><<>>  Collecting zImage-dtb <<>><<>>"
   echo ""
   cp $k/arch/arm/boot/zImage-dtb out/$c/zImage-dtb
   done
   
# Create M package directory
 cd $k/arch/arm/configs/BBKconfigsM
    for d in *
      do
        cd $k
    mkdir -p "out/$d"
    cp -R "$u/system" out/$d
    cp -R "$u/META-INF" out/$d
    cp -R "$u/patch" out/$d
    cp -R "$u/ramdisk" out/$d
    cp -R "$u/tools" out/$d
    cp -R "$u/anykernel.sh" out/$d
    
    z=$d-$today
    
    cp $k/arch/arm/boot/zImage-dtb out/$d/zImage-dtb
 done
 
# Build Zip
 clear
   echo "Creating $z.zip"
     cd $k/out/$c/
       7z a -tzip -mx5 "$y.zip"
         mv $y.zip $k/out/$y.zip
     cd $k/out/$d/
       7z a -tzip -mx5 "$z.zip"
         mv $z.zip $k/out/$z.zip
# cp $k/out/$z.zip $db/$z.zip
#           rm -rf $k/out/$c
# Line below for debugging purposes,  uncomment to stop script after each config is run
#read this
