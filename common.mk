$(call inherit-product, $(SRC_TARGET_DIR)/product/languages_full.mk)

$(call inherit-product, device/common/gps/gps_eu.mk)

$(call inherit-product, hardware/ti/omap4/omap4.mk)

$(call inherit-product, build/target/product/full.mk)

DEVICE_PACKAGE_OVERLAYS += $(LOCAL_PATH)/overlay

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/recovery/postrecoveryboot.sh:recovery/root/sbin/postrecoveryboot.sh

# Scripts and confs
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/init.u2.usb.rc:root/init.u2.usb.rc \
    $(LOCAL_PATH)/init.u2.rc:root/init.u2.rc \
    $(LOCAL_PATH)/ueventd.u2.rc:root/ueventd.u2.rc \
    $(LOCAL_PATH)/fstab.u2:root/fstab.u2 

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/touch_dev.idc:system/usr/idc/touch_dev.idc \
    $(LOCAL_PATH)/configs/touch_dev.kl:system/usr/keylayout/touch_dev.kl \
    $(LOCAL_PATH)/configs/omap4-keypad.kl:system/usr/keylayout/omap4-keypad.kl

# stagefright confs
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/media_profiles.xml:system/etc/media_profiles.xml \
    $(LOCAL_PATH)/configs/media_codecs.xml:system/etc/media_codecs.xml \
    $(LOCAL_PATH)/audio/audio_policy.conf:system/etc/audio_policy.conf \
    frameworks/av/media/libstagefright/data/media_codecs_google_audio.xml:system/etc/media_codecs_google_audio.xml \
    frameworks/av/media/libstagefright/data/media_codecs_google_telephony.xml:system/etc/media_codecs_google_telephony.xml \
    frameworks/av/media/libstagefright/data/media_codecs_google_video.xml:system/etc/media_codecs_google_video.xml 

# wifi nvram calibration
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/bcmdhd.cal:system/etc/wifi/bcmdhd.cal

# RIL stuffs
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/ipc_channels.config:system/etc/ipc_channels.config

# Permission files
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/handheld_core_hardware.xml:system/etc/permissions/handheld_core_hardware.xml \
    frameworks/native/data/etc/android.hardware.camera.flash-autofocus.xml:system/etc/permissions/android.hardware.camera.flash-autofocus.xml \
    frameworks/native/data/etc/android.hardware.camera.front.xml:system/etc/permissions/android.hardware.camera.front.xml \
    frameworks/native/data/etc/android.hardware.camera.xml:system/etc/permissions/android.hardware.camera.xml \
    frameworks/native/data/etc/android.hardware.telephony.gsm.xml:system/etc/permissions/android.hardware.telephony.gsm.xml \
    frameworks/native/data/etc/android.hardware.wifi.xml:system/etc/permissions/android.hardware.wifi.xml \
    frameworks/native/data/etc/android.hardware.wifi.direct.xml:system/etc/permissions/android.hardware.wifi.direct.xml \
    frameworks/native/data/etc/android.hardware.location.gps.xml:system/etc/permissions/android.hardware.location.gps.xml \
    frameworks/native/data/etc/android.hardware.sensor.accelerometer.xml:system/etc/permissions/android.hardware.sensor.accelerometer.xml \
    frameworks/native/data/etc/android.hardware.sensor.gyroscope.xml:system/etc/permissions/android.hardware.sensor.gyroscope.xml \
    frameworks/native/data/etc/android.hardware.sensor.proximity.xml:system/etc/permissions/android.hardware.sensor.proximity.xml \
    frameworks/native/data/etc/android.hardware.sensor.compass.xml:system/etc/permissions/android.hardware.sensor.compass.xml \
    frameworks/native/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml \
    frameworks/native/data/etc/android.hardware.touchscreen.multitouch.jazzhand.xml:system/etc/permissions/android.hardware.touchscreen.multitouch.jazzhand.xml \
    frameworks/native/data/etc/android.hardware.usb.accessory.xml:system/etc/permissions/android.hardware.usb.accessory.xml \
    frameworks/native/data/etc/android.hardware.bluetooth.xml:system/etc/permissions/android.hardware.bluetooth.xml \
    frameworks/native/data/etc/android.hardware.bluetooth_le.xml:system/etc/permissions/android.hardware.bluetooth_le.xml

# GPS
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/gps_brcm_conf.xml:system/etc/gps_brcm_conf.xml \
    $(LOCAL_PATH)/configs/SuplRootCert:system/etc/SuplRootCert \
    $(LOCAL_PATH)/configs/lge.cer:system/etc/cert/lge.cer

# high-density artwork where available
PRODUCT_AAPT_CONFIG := normal hdpi
PRODUCT_AAPT_PREF_CONFIG := hdpi

PRODUCT_PACKAGES += \
    lights.omap4 \
    libaudioutils \
    audio.a2dp.default \
    audio_policy.default \
    audio.primary.u2 \
    audio.hdmi.u2 \
    audio.usb.default \
    audio.r_submix.default \
    power.u2 \

# Screen-off governor
PRODUCT_PACKAGES += \
    virtuous_oc
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/virtuous_oc/virtuous_oc.conf:system/etc/virtuous_oc/virtuous_oc.conf

# Camera
PRODUCT_PACKAGES += \
    Snap \
    camera.omap4  

# RIL symbols
PRODUCT_PACKAGES += \
    liblge

# OMAP4 OMX
PRODUCT_PACKAGES += \
    libmm_osal \
    gralloc.omap4.so

PRODUCT_PACKAGES += \
    wifimac \
    libnetcmdiface

PRODUCT_PACKAGES += \
    libipcutils \
    libipc \
    libnotify \
    syslink_trace_daemon.out \
    librcm \
    libsysmgr \
    syslink_daemon.out \
    dmm_daemontest.out \
    event_listener.out \
    interm3.out \
    gateMPApp.out \
    heapBufMPApp.out \
    heapMemMPApp.out \
    listMPApp.out \
    messageQApp.out \
    nameServerApp.out \
    sharedRegionApp.out \
    memmgrserver.out \
    notifyping.out \
    ducati_load.out \
    procMgrApp.out \
    slpmresources.out \
    slpmtransport.out \
    utilsApp.out \
    libd2cmap \
    libomap_mm_library_jni \
    libtimemmgr

PRODUCT_PACKAGES += \
    libskiahwdec \
    libskiahwenc

# IPv6 tethering
PRODUCT_PACKAGES += \
    ebtables \
    ethertypes

# Charger mode
PRODUCT_PACKAGES += \
    charger \
    charger_res_images
	
# RIL
PRODUCT_PROPERTY_OVERRIDES += \
    rild.libpath=/system/lib/lge-ril.so \
    ro.telephony.ril_class=U2RIL \
    ro.telephony.call_ring.delay=0 \
    media.aac_51_output_enabled=true 

PRODUCT_PROPERTY_OVERRIDES += \
	wifi.interface=wlan0 \
        wlan.chip.vendor=brcm

# Build prop
PRODUCT_PROPERTY_OVERRIDES += \
    ro.bq.gpu_to_cpu_unsupported=1 \
    ro.sf.lcd_density=240 \
    ro.opengles.version=131072 \
    ro.com.google.clientidbase=android-lge \
    ro.com.google.clientidbase.ms=android-lge \
    ro.com.google.clientidbase.gmm=android-lge \
    ro.com.google.clientidbase.yt=android-lge \
    ro.com.google.clientidbase.am=android-lge \
    omap.audio.mic.main=AMic0 \
    omap.audio.mic.sub=AMic1 \
    omap.audio.power=PingPong \
    ro.build.target_country=EU \
    ro.build.target_operator=OPEN \
    ro.ksm.default=1 \
    debug.sf.swaprect=1 \
    ro.secure=0 \
    qemu.hw.mainkeys=1 \
    debug.hwui.render_dirty_regions=false \
    ro.bt.bdaddr_path=/sys/devices/platform/bd_address/bdaddr_if \
    ro.hwui.disable_scissor_opt=true \
    ro.HOME_APP_ADJ=1 

# Newer camera API isn't supported.
PRODUCT_PROPERTY_OVERRIDES += \
    camera2.portability.force_api=1

ADDITIONAL_BUILD_PROPERTIES += \
	dalvik.vm.dex2oat-flags=--no-watch-dog 
        
#Save battery
PRODUCT_PROPERTY_OVERRIDES += \
	wifi.supplicant_scan_interval=180 \
	pm.sleep_mode=1 \
	windowsmgr.max_events_per_sec=60 \
	ro.ril.disable.power.collapse=0
	
#Disable blackscreen issue after a call
PRODUCT_PROPERTY_OVERRIDES += \
	ro.lge.proximity.delay=25 \
	mot.proximity.delay=25

# General
PRODUCT_PROPERTY_OVERRIDES += \
        com.ti.omap_enhancement=true 

# OpenglES
PRODUCT_PROPERTY_OVERRIDES += \
    ro.opengles.version=131072
	
PRODUCT_PACKAGES += \
	libwpa_client \
	hostapd \
	dhcpcd.conf \
	wpa_supplicant \
	wpa_supplicant.conf

# Signal Tweaks
PRODUCT_PROPERTY_OVERRIDES += \
	ro.ril.hsxpa=2 \
	ro.ril.gprsclass=12 \
	ro.ril.hep=1 \
	ro.ril.enable.dtm=1 \
	ro.ril.hsdpa.category=10 \
	ro.ril.enable.a53=1 \
	ro.ril.enable.3g.prefix=1 \
	ro.ril.htcmaskw1.bitmask=4294967295 \
	ro.ril.htcmaskw1=14449 \
	ro.ril.hsupa.category=5
	
# NetSpeed Tweaks
PRODUCT_PROPERTY_OVERRIDES += \
	net.tcp.buffersize.default=4096,87380,256960,4096,16384,256960 \
	net.tcp.buffersize.wifi=4096,87380,256960,4096,16384,256960 \
	net.tcp.buffersize.umts=4096,87380,256960,4096,16384,256960 \
	net.tcp.buffersize.gprs=4096,87380,256960,4096,16384,256960 \
	net.tcp.buffersize.edge=4096,87380,256960,4096,16384,256960

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/fs/system/bin/fstrim:system/bin/fstrim \
    $(LOCAL_PATH)/fs/system/framework/com.android.location.provider.jar:system/framework/com.android.location.provider.jar \
    $(LOCAL_PATH)/fs/system/etc/permissions/android.hardware.location.gps.xml:system/etc/permissions/android.hardware.location.gps.xml \
    $(LOCAL_PATH)/fs/system/etc/permissions/com.android.location.provider.xml:system/etc/permissions/com.android.location.provider.xml \
    $(LOCAL_PATH)/fs/system/etc/init.d/99lmk:system/etc/init.d/99lmk 

$(call inherit-product, frameworks/native/build/phone-xhdpi-1024-dalvik-heap.mk)
$(call inherit-product-if-exists, hardware/broadcom/wlan/bcmdhd/firmware/bcm4330/device-bcm.mk)
$(call inherit-product, vendor/lge/u2/u2-vendor.mk)
