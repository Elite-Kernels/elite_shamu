#!/system/bin/sh

chmod 666 /sys/block/mmcblk0/queue/scheduler
chmod 666 /sys/block/mmcblk0/queue/read_ahead_kb
chmod 666 /sys/android_touch/wake_gestures
chmod 666 /sys/android_touch/sweep2wake
chmod 666 /sys/android_touch/doubletap2wake
chmod 666 /sys/android_touch/sweep2sleep
chmod 666 /sys/android_touch/vib_strength
chmod 444 /dev/erandom
chmod 444 /dev/frandom

# Prevent min freq from being changed by MPD
#echo N > /sys/module/cpufreq/parameters/allow_minup

# Prevent Thermal from changing max freq
#echo N > /sys/module/msm_thermal/parameters/full_fm

#Set Wake Gestures - dont change
 #disable = 0
 #enable = 1
  echo 0 > /sys/android_touch/wake_gestures

#Set Sweep2wake
#Notes
#disable = 0
#sweep right = 1
#sweep left = 2
#sweep up = 4
#sweep down = 8
#Choose a number for the option or,
#Add them together, to enable sweep2wake in every direction:
#echo 15 > /sys/android_touch/sweep2wake
  echo 0 > /sys/android_touch/sweep2wake

#Set Doubletap2wake
 #disable = 0
 #enable = 1
  echo 1 > /sys/android_touch/doubletap2wake

#Set Sweep2sleep
 #disable = 0
 #sweep right = 1
 #sweep left = 2
 #sweep left or right = 3
  echo 2 > /sys/android_touch/sweep2sleep

#Set Wake Gesture Vibrate strength
#range 0-20
 echo 20 > /sys/android_touch/vib_strength

#Set FASTCHARGE
 #disable = 0
 #enable = 1
  echo 0 > /sys/kernel/fast_charge/force_fast_charge

#Set IO read ahead
echo "deadline" > /sys/block/mmcblk0/queue/scheduler
echo "1536" > /sys/block/mmcblk0/queue/read_ahead_kb

#Set CPU Min Frequencies
echo 300000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
echo 300000 > /sys/devices/system/cpu/cpu1/cpufreq/scaling_min_freq
echo 300000 > /sys/devices/system/cpu/cpu2/cpufreq/scaling_min_freq
echo 300000 > /sys/devices/system/cpu/cpu3/cpufreq/scaling_min_freq

#Set CPU Max Frequencies
echo 2649600 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
echo 2649600 > /sys/devices/system/cpu/cpu1/cpufreq/scaling_max_freq
echo 2649600 > /sys/devices/system/cpu/cpu2/cpufreq/scaling_max_freq
echo 2649600 > /sys/devices/system/cpu/cpu3/cpufreq/scaling_max_freq

#Enable Zen Decision
# stop mpdecision
echo 0 > /sys/kernel/zen_decision/enabled
echo 500 > /sys/kernel/zen_decision/wake_wait_time

# Set Wakelocks
 # echo 0 > /sys/module/bcmdhd/parameters/wlrx_divide
 echo 8 > /sys/module/bcmdhd/parameters/wlrx_divide
 # echo 0 > /sys/module/bcmdhd/parameters/wlctrl_divide
 echo 8 > /sys/module/bcmdhd/parameters/wlctrl_divide
 # echo 0 > /sys/module/xhci_hcd/parameters/wl_divide
 echo 0 > /sys/module/xhci_hcd/parameters/wl_divide
 echo 0 > /sys/module/smb135x_charger/parameters/use_wlock

#Key press during suspend for long press functions
# 0 to disable - 1 to enable
 echo 0 > /sys/module/input_core/parameters/disable_release_keys

chmod 644 /sys/block/mmcblk0/queue/scheduler
chmod 644 /sys/block/mmcblk0/queue/read_ahead_kb
chmod 644 /sys/android_touch/wake_gestures
chmod 644 /sys/android_touch/sweep2wake
chmod 644 /sys/android_touch/doubletap2wake
chmod 644 /sys/android_touch/sweep2sleep
chmod 644 /sys/android_touch/vib_strength

exit 0
