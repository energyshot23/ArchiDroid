#!/system/bin/sh

#============================================================#
# init.post_boot.sh script created for Android Revolution HD #
# by mike1986                                                #
# Do not try to remove this file from the system!            #
#============================================================#

    log -p i -t ARHD "Applying Android Revolution HD Tweaks"

### Mount /system partition as RW first, remount as RO at the end of the script.
    sysrw

### Kernel tweaks for MSN7x30 devices (HTC Desire HD, HTC Inspire 4G, HTC Incredible S)
    target=`getprop ro.board.platform`
    case "$target" in "msm7x30")
        echo "conservative" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
        echo "300000" > /sys/devices/system/cpu/cpu0/cpufreq/conservative/sampling_rate
        echo "90" > /sys/devices/system/cpu/cpu0/cpufreq/conservative/up_threshold
        echo "ondemand" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
        echo "20000" > /sys/devices/system/cpu/cpu0/cpufreq/ondemand/sampling_rate
        echo "1" > /sys/devices/system/cpu/cpufreq/ondemand/io_is_busy
        echo "10" > /sys/devices/system/cpu/cpufreq/ondemand/sampling_down_factor
        echo "60" > /sys/devices/system/cpu/cpu0/cpufreq/ondemand/up_threshold
        echo "30" > /sys/devices/system/cpu/cpufreq/ondemand/down_differential
        echo "vr" > /sys/block/mmcblk0/queue/scheduler
        echo "vr" > /sys/block/mmcblk1/queue/scheduler
        log -p i -t ARHD "Kernel tweaks for MSN7x30 devices applied"
    ;;
    esac

### Kernel tweaks for MSN8660 devices (HTC Sensation, HTC Sensation 4G, HTC Sensation XE, HTC Evo 3D CDMA, HTC Amaze 4G)
    target=`getprop ro.board.platform`
    case "$target" in "msm8660")
        echo "conservative" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
        echo "conservative" > /sys/devices/system/cpu/cpu1/cpufreq/scaling_governor
        echo "300000" > /sys/devices/system/cpu/cpufreq/conservative/sampling_rate
        chgrp root /sys/devices/system/cpu/cpufreq/conservative/sampling_rate
        chmod 666 /sys/devices/system/cpu/cpufreq/conservative/sampling_rate
        echo "90" > /sys/devices/system/cpu/cpufreq/conservative/up_threshold
        echo "ondemand" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
        echo "ondemand" > /sys/devices/system/cpu/cpu1/cpufreq/scaling_governor
        echo "20000" > /sys/devices/system/cpu/cpufreq/ondemand/sampling_rate
        chgrp root /sys/devices/system/cpu/cpufreq/ondemand/sampling_rate
        chmod 666 /sys/devices/system/cpu/cpufreq/ondemand/sampling_rate
        echo "60" > /sys/devices/system/cpu/cpufreq/ondemand/up_threshold
        echo "1" > /sys/devices/system/cpu/cpufreq/ondemand/io_is_busy
        echo "10" > /sys/devices/system/cpu/cpufreq/ondemand/sampling_down_factor
        echo "30" > /sys/devices/system/cpu/cpufreq/ondemand/down_differential
        echo "384000" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
        echo "384000" > /sys/devices/system/cpu/cpu1/cpufreq/scaling_min_freq
        chgrp root /sys/devices/system/cpu/cpu0/online
        chgrp root /sys/devices/system/cpu/cpu1/online
        echo "deadline" > /sys/block/mmcblk0/queue/scheduler
        echo "deadline" > /sys/block/mmcblk1/queue/scheduler
        log -p i -t ARHD "Kernel tweaks for MSN8660 devices applied"

    # Tweak IntelliDemand governor by faux123 (kernel must support this governor!)
        if [`grep -q intellidemand /sys/devices/system/cpu/cpu0/cpufreq/scaling_available_governors`] ; then
            log -i -t ARHD "Configuring intellidemand governor"
            echo "intellidemand" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
            echo "intellidemand" > /sys/devices/system/cpu/cpu1/cpufreq/scaling_governor
            echo "20000" > /sys/devices/system/cpu/cpufreq/intellidemand/sampling_rate
            chgrp root /sys/devices/system/cpu/cpufreq/intellidemand/sampling_rate
            chmod 666 /sys/devices/system/cpu/cpufreq/intellidemand/sampling_rate
            echo "60" > /sys/devices/system/cpu/cpufreq/intellidemand/up_threshold
            log -p i -t ARHD "Intellidemand governor configured"
        fi

    # Enable ZRAM compressed memory (kernel must support ZRAM feature!)
        if [ -e /sys/block/zram0/disksize ] ; then
            log -p i -t ARHD "Enabling compressed RAM functionality (ZRAM)"
            echo $((120*1024*1024)) > /sys/block/zram0/disksize
            busybox mkswap /dev/block/zram0
            busybox swapon /dev/block/zram0
            log -p i -t ARHD "Compressed RAM functionality (ZRAM) enabled"
        fi
    ;;
    esac

### Kernel tweaks for nVidia Tegra 2 devices (Asus Eee Pad Transformer)
    target=`getprop ro.product.device`
    case "$target" in "TF101")
        echo "216000" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
        echo "216000" > /sys/devices/system/cpu/cpu1/cpufreq/scaling_min_freq
        echo "1000000" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
        echo "1000000" > /sys/devices/system/cpu/cpu1/cpufreq/scaling_max_freq
        echo "interactive" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
        echo "interactive" > /sys/devices/system/cpu/cpu1/cpufreq/scaling_governor
        echo "60" > /sys/devices/system/cpu/cpufreq/interactive/go_maxspeed_load
        echo "40000" > /sys/devices/system/cpu/cpufreq/interactive/min_sample_time
        echo "deadline" > /sys/block/mmcblk0/queue/scheduler
        echo "deadline" > /sys/block/mmcblk1/queue/scheduler
        log -p i -t ARHD "Kernel tweaks for Asus Eee Pad Transformer applied"
    ;;
    esac

### Kernel tweaks for TI OMAP 4460 devices (Samsung Galaxy Nexus GSM, Samsung Galaxy Nexus LTE)
    target=`getprop ro.board.platform`
    case "$target" in "omap4")
        echo "interactive" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
        echo "interactive" > /sys/devices/system/cpu/cpu1/cpufreq/scaling_governor
        echo "20000" > /sys/devices/system/cpu/cpufreq/interactive/timer_rate
        echo "40000" > /sys/devices/system/cpu/cpufreq/interactive/min_sample_time
        echo "920000" > /sys/devices/system/cpu/cpufreq/interactive/hispeed_freq
        echo "60" > /sys/devices/system/cpu/cpufreq/interactive/go_hispeed_load
        echo "deadline" > /sys/block/mmcblk0/queue/scheduler
        log -p i -t ARHD "Kernel tweaks for TI OMAP 4460 devices applied"
    ;;
    esac

### Kernel tweaks for nVidia Tegra 3 AP35 devices (HTC One X)
    target=`getprop ro.product.device`
    case "$target" in "endeavoru")
        # Governors settings are hardcoded, blame HTC!
        if [ -e /system/etc/ondemand ] ; then
         log -p i -t ARHD "Configuring ondemand governor"
        chgrp root /system/etc/ondemand
        chmod 664 /system/etc/ondemand
        /system/xbin/busybox nohup /system/bin/sh /system/etc/ondemand 2>&1 >/dev/null &
        log -p i -t ARHD "Ondemand governor configured"
        fi
        echo "noop" > /sys/block/mmcblk0/queue/scheduler
        log -p i -t ARHD "Kernel tweaks for HTC One X applied"
    ;;
    esac

### Kernel tweaks for nVidia Tegra 3 AP37 devices (HTC One X+)
    target=`getprop ro.product.device`
    case "$target" in "enrc2b")
        # Governors settings are hardcoded, blame HTC!
        if [ -e /system/etc/ondemand ] ; then
         log -p i -t ARHD "Configuring ondemand governor"
        chgrp root /system/etc/ondemand
        chmod 664 /system/etc/ondemand
        /system/xbin/busybox nohup /system/bin/sh /system/etc/ondemand 2>&1 >/dev/null &
        log -p i -t ARHD "Ondemand governor configured"
        fi
        echo "noop" > /sys/block/mmcblk0/queue/scheduler
        log -p i -t ARHD "Kernel tweaks for HTC One X+ applied"
    ;;
    esac

### Kernel tweaks for Exynos 4 Quad devices (Samsung Galaxy S3, Samsung Galaxy Note 2, Samsung Galaxy Note 10.1)
    target=`getprop ro.product.board`
    case "$target" in "smdk4x12")
        echo "pegasusq" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
        echo "pegasusq" > /sys/devices/system/cpu/cpu1/cpufreq/scaling_governor
        echo "pegasusq" > /sys/devices/system/cpu/cpu2/cpufreq/scaling_governor
        echo "pegasusq" > /sys/devices/system/cpu/cpu3/cpufreq/scaling_governor
        echo "60" > /sys/devices/system/cpu/cpufreq/pegasusq/up_threshold
        echo "20000" > /sys/devices/system/cpu/cpufreq/pegasusq/sampling_rate
        echo "10000" > /sys/devices/system/cpu/cpufreq/pegasusq/sampling_rate_min
        echo "10" > /sys/devices/system/cpu/cpufreq/pegasusq/sampling_down_factor
        echo "30" > /sys/devices/system/cpu/cpufreq/pegasusq/down_differential
        log -p i -t ARHD "Kernel tweaks for Exynos 4 Quad devices applied"
    ;;
    esac

### Kernel tweaks for Snapdragon 600 (MSM8960) devices (HTC One)
    target=`getprop ro.product.device`
    case "$target" in "m7")
        echo 90 > /sys/devices/system/cpu/cpufreq/ondemand/up_threshold
        echo 50000 > /sys/devices/system/cpu/cpufreq/ondemand/sampling_rate
        echo 1 > /sys/devices/system/cpu/cpufreq/ondemand/io_is_busy
        echo 4 > /sys/devices/system/cpu/cpufreq/ondemand/sampling_down_factor
        echo 10 > /sys/devices/system/cpu/cpufreq/ondemand/down_differential
        echo 70 > /sys/devices/system/cpu/cpufreq/ondemand/up_threshold_multi_core
        echo 3 > /sys/devices/system/cpu/cpufreq/ondemand/down_differential_multi_core
        echo 918000 > /sys/devices/system/cpu/cpufreq/ondemand/optimal_freq
        echo 918000 > /sys/devices/system/cpu/cpufreq/ondemand/sync_freq
        echo 80 > /sys/devices/system/cpu/cpufreq/ondemand/up_threshold_any_cpu_load
        echo 384000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
        echo 384000 > /sys/devices/system/cpu/cpu1/cpufreq/scaling_min_freq
        echo 384000 > /sys/devices/system/cpu/cpu2/cpufreq/scaling_min_freq
        echo 384000 > /sys/devices/system/cpu/cpu3/cpufreq/scaling_min_freq
        echo 4096 > /proc/sys/vm/min_free_kbytes
        echo "16 16" > /proc/sys/vm/lowmem_reserve_ratio
        chown system /sys/devices/system/cpu/cpufreq/ondemand/io_is_busy
        chown system /sys/devices/system/cpu/cpufreq/ondemand/sampling_rate
        chown system /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
        chown system /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
        chown system /sys/devices/system/cpu/cpu1/cpufreq/scaling_max_freq
        chown system /sys/devices/system/cpu/cpu1/cpufreq/scaling_min_freq
        chown system /sys/devices/system/cpu/cpu2/cpufreq/scaling_max_freq
        chown system /sys/devices/system/cpu/cpu2/cpufreq/scaling_min_freq
        chown system /sys/devices/system/cpu/cpu3/cpufreq/scaling_max_freq
        chown system /sys/devices/system/cpu/cpu3/cpufreq/scaling_min_freq
        chown root.system /sys/devices/system/cpu/mfreq
        chmod 220 /sys/devices/system/cpu/mfreq
        chown root.system /sys/devices/system/cpu/cpu1/online
        chown root.system /sys/devices/system/cpu/cpu2/online
        chown root.system /sys/devices/system/cpu/cpu3/online
        chmod 664 /sys/devices/system/cpu/cpu1/online
        chmod 664 /sys/devices/system/cpu/cpu2/online
        chmod 664 /sys/devices/system/cpu/cpu3/online
        start adaptive
            # Load wp_mod.ko module to disable system partition RW protection
            insmod /system/lib/modules/wp_mod.ko
        log -p i -t ARHD "Kernel tweaks for HTC One applied"
    ;;
    esac

### build.prop tweaks for HTC devices
    target=`getprop ro.product.manufacturer`
    case "$target" in "HTC")
        # Disable HTC Checkin Service
        setprop ro.config.htc.nocheckin=1
        # Turn off sending device crash log data to HTC
        setprop profiler.force_disable_err_rpt=1
    ;;
    esac

### Global tweaks
    target=`getprop ro.ident`
    case "$target" in "Android_Revolution_HD")
        echo "0" > /proc/sys/kernel/panic_on_oops

    # Virtual Memory tweaks
        echo "0" > /proc/sys/vm/panic_on_oom
        echo "0" > /proc/sys/vm/oom_kill_allocating_task

    # Increase readahead buffers on eMMC devices
        echo "256" > /sys/block/mmcblk0/bdi/read_ahead_kb
        echo "256" > /sys/block/mmcblk1/bdi/read_ahead_kb

    # Execute /system/etc/init.d scripts on boot
        chgrp -R 2000 /system/etc/init.d
        chmod -R 777 /system/etc/init.d
        /system/xbin/busybox run-parts /system/etc/init.d
        log -p i -t ARHD "init.d support activated"

    # Something for Quadrant users
        mount -o rw -t tmpfs tmpfs /data/data/com.aurorasoftworks.quadrant.ui.standard
        mount -o rw -t tmpfs tmpfs /data/data/com.aurorasoftworks.quadrant.ui.advanced
    ;;
    esac

### Mount /system partition back as RO for security reasons, we finished here.
    sysro

    log -p i -t ARHD "Your system is now tweaked with Android Revolution HD Tweaks"

# End of the init.post_boot.sh script

