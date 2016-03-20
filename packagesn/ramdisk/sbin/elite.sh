#!/system/bin/sh

ELITE_CONF="/data/data/elite/elite.conf"
ELITE_LOGFILE="/data/local/tmp/elite.log"

if [ -f $ELITE_LOGFILE ]; then
  mv $ELITE_LOGFILE $ELITE_LOGFILE.2;
fi

echo $(date) >> $ELITE_LOGFILE

#Set Prevent min freq from being changed by MPD
MINUP="`grep allow_minup $ELITE_CONF | cut -d '=' -f2`"
  echo $MINUP > /sys/module/cpufreq/parameters/allow_minup
  echo allow_minup $MINUP >> $ELITE_LOGFILE;
  
#Set Sweep2wake
FULLFM="`grep full_fm $ELITE_CONF | cut -d '=' -f2`"
  echo $FULLFM > /sys/module/msm_thermal/parameters/full_fm
  echo full_fm $FULLFM >> $ELITE_LOGFILE;
  
#Set Sweep2wake
S2W="`grep sweep2wake $ELITE_CONF | cut -d '=' -f2`"
  echo $S2W > /sys/android_touch/sweep2wake
  echo Sweep2wake $S2W >> $ELITE_LOGFILE;

#Set Doubletap2wake
DT2W="`grep doubletap2wake $ELITE_CONF | cut -d '=' -f2`"
  echo $DT2W > /sys/android_touch/doubletap2wake
  echo Doubletap2wake $DT2W >> $ELITE_LOGFILE;

#Set Sweep2sleep
S2S="`grep sweep2sleep $ELITE_CONF | cut -d '=' -f2`"
  echo $S2S > /sys/android_touch/sweep2sleep
  echo sweep2sleep $S2S >> $ELITE_LOGFILE;

#Set Wake vibration strength
VIB_STRENGTH="`grep vib_strength $ELITE_CONF | cut -d '=' -f2`"
  echo $VIB_STRENGTH > /sys/android_touch/vib_strength
  echo VIB_STRENGTH $VIB_STRENGTH >> $ELITE_LOGFILE;

#Set Camera launch gesture
CAMGESTURE="`grep cam_gesture $ELITE_CONF | cut -d '=' -f2`"
  echo $CAMGESTURE > /sys/android_touch/camera_gesture
  echo CAMGESTURE $CAMGESTURE >> $ELITE_LOGFILE;
  
#io scheduler settings
SCHEDULER="`grep scheduler $ELITE_CONF | cut -d '=' -f2`"
  echo $SCHEDULER > /sys/block/mmcblk0/queue/scheduler;
  echo SCHEDULER $SCHEDULER >> $ELITE_LOGFILE;
  
#Readahead settings
READAHEAD=`grep read_ahead_kb $ELITE_CONF | cut -d '=' -f2`
  echo $READAHEAD > /sys/block/mmcblk0/queue/read_ahead_kb
  echo READAHEAD $READAHEAD >> $ELITE_LOGFILE;


#Set FASTCHARGE
FASTCHG=`grep force_fast_charge $ELITE_CONF | cut -d '=' -f2`
  echo $FASTCHG > /sys/kernel/fast_charge/force_fast_charge
  echo FASTCHG $FASTCHG >> $ELITE_LOGFILE;

#Set ZEN Decision
ZENENABLE=`grep zenenabled $ELITE_CONF | cut -d '=' -f2`
  echo $ZENENABLE > /sys/kernel/zen_decision/enabled
  echo ZENENABLE $ZENENABLE >> $ELITE_LOGFILE;
ZENWAITTIME=`grep wake_wait_time $ELITE_CONF | cut -d '=' -f2`
  echo $ZENWAITTIME > /sys/kernel/zen_decision/wake_wait_time
  echo ZENWAITTIME $ZENWAITTIME >> $ELITE_LOGFILE;

#Set Wakelocks
WLRX=`grep wlrx_divide $ELITE_CONF | cut -d '=' -f2`
 echo $WLRX > /sys/module/bcmdhd/parameters/wlrx_divide
 echo WLRX $WLRX >> $ELITE_LOGFILE;
WLCTRL=`grep wlctrl_divide $ELITE_CONF | cut -d '=' -f2`
 echo $WLCTRL > /sys/module/bcmdhd/parameters/wlctrl_divide
 echo WLCTRL $WLCTRL >> $ELITE_LOGFILE;
HCIDIVIDE=`grep wl_divide $ELITE_CONF | cut -d '=' -f2`
 echo $HCIDIVIDE > /sys/module/xhci_hcd/parameters/wl_divide
 echo HCIDIVIDE $HCIDIVIDE >> $ELITE_LOGFILE;
SMBWL=`grep use_wlock $ELITE_CONF | cut -d '=' -f2`
 echo $SMBWL > /sys/module/smb135x_charger/parameters/use_wlock
 echo SMBWL $SMBWL >> $ELITE_LOGFILE;

  cp /data/local/tmp/elite.log /sdcard/elite.log

exit 0
