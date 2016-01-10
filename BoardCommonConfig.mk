COMMON_FOLDER := device/lge/u2-common

PRODUCT_VENDOR_KERNEL_HEADERS := $(COMMON_FOLDER)/kernel-headers
TARGET_SPECIFIC_HEADER_PATH := $(COMMON_FOLDER)/include

# inherit from the proprietary version
-include vendor/lge/u2-common/BoardConfigVendor.mk

-include hardware/ti/omap4/BoardConfigCommon.mk

TARGET_NO_BOOTLOADER := true
TARGET_BOARD_OMAP_CPU := 4430
TARGET_BOOTLOADER_BOARD_NAME := u2
TARGET_ARCH_VARIANT_CPU := $(TARGET_CPU_VARIANT)
TARGET_ARCH_VARIANT_FPU := neon
ARCH_ARM_HAVE_TLS_REGISTER := true
NEEDS_ARM_ERRATA_754319_754320 := true
BOARD_GLOBAL_CFLAGS += -DNEEDS_ARM_ERRATA_754319_754320

# Kernel
BOARD_KERNEL_CMDLINE :=
BOARD_KERNEL_BASE := 0x80000000
BOARD_KERNEL_PAGESIZE := 2048

# Recovery
BOARD_HAS_NO_SELECT_BUTTON := true
TARGET_RECOVERY_FSTAB = device/lge/u2-common/fstab.u2
RECOVERY_FSTAB_VERSION = 2
BOARD_UMS_LUNFILE := "/sys/devices/virtual/android_usb/android0/f_mass_storage/lun/file"
TARGET_OTA_ASSERT_DEVICE := p760,p765,p768,p769,u2

# EGL
BOARD_EGL_CFG := device/lge/u2-common/egl.cfg
TARGET_RUNNING_WITHOUT_SYNC_FRAMEWORK := true
TARGET_USES_OPENGLES_FOR_SCREEN_CAPTURE := true
USE_OPENGL_RENDERER := true

# Wifi related defines
BOARD_WPA_SUPPLICANT_DRIVER := NL80211
WPA_SUPPLICANT_VERSION := VER_0_8_X
BOARD_WPA_SUPPLICANT_PRIVATE_LIB := lib_driver_cmd_bcmdhd
BOARD_HOSTAPD_DRIVER := NL80211
BOARD_HOSTAPD_PRIVATE_LIB := lib_driver_cmd_bcmdhd
BOARD_WLAN_DEVICE := bcmdhd
WIFI_DRIVER_FW_PATH_PARAM := "/sys/module/bcmdhd/parameters/firmware_path"
WIFI_DRIVER_FW_PATH_STA := "/system/etc/firmware/fw_bcmdhd.bin"
WIFI_DRIVER_FW_PATH_P2P := "/system/etc/firmware/fw_bcmdhd_p2p.bin"
WIFI_DRIVER_FW_PATH_AP := "/system/etc/firmware/fw_bcmdhd_apsta.bin"
BOARD_LEGACY_NL80211_STA_EVENTS := true
WIFI_BAND := 802_11_ABGN

# Bluetooth
BOARD_HAVE_BLUETOOTH := true
BOARD_HAVE_BLUETOOTH_BCM := true
BOARD_BLUEDROID_VENDOR_CONF := device/lge/u2-common/configs/vnd_u2.txt

# HWComposer
BOARD_USE_SYSFS_VSYNC_NOTIFICATION := true

# FS
TARGET_USERIMAGES_USE_EXT4 := true
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 1033686220
BOARD_USERDATAIMAGE_PARTITION_SIZE := 2469606195
BOARD_FLASH_BLOCK_SIZE := 131072
BOARD_HAS_NO_MISC_PARTITION := true

BOARD_HAS_VIBRATOR_IMPLEMENTATION := ../../device/lge/u2-common/vibrator.c

# Camera
USE_CAMERA_STUB := false

# External SGX Module
SGX_MODULES:
	make clean -C hardware/ti/omap4/pvr-source/eurasiacon/build/linux2/omap4430_android
	cp $(TARGET_KERNEL_SOURCE)/drivers/video/omap2/omapfb/omapfb.h $(KERNEL_OUT)/drivers/video/omap2/omapfb/omapfb.h
	make -j8 -C hardware/ti/omap4/pvr-source/eurasiacon/build/linux2/omap4430_android ARCH=arm KERNEL_CROSS_COMPILE=arm-eabi- CROSS_COMPILE=arm-eabi- KERNELDIR=$(KERNEL_OUT) TARGET_PRODUCT="blaze_tablet" BUILD=release TARGET_SGX=540 PLATFORM_VERSION=4.0
	mv $(KERNEL_OUT)/../../target/kbuild/pvrsrvkm_sgx540_120.ko $(KERNEL_MODULES_OUT)
	$(ARM_EABI_TOOLCHAIN)/arm-eabi-strip --strip-unneeded $(KERNEL_MODULES_OUT)/pvrsrvkm_sgx540_120.ko

TARGET_KERNEL_MODULES += SGX_MODULES

## Radio fixes
BOARD_RIL_CLASS := ../../../device/lge/u2-common/ril/

# Charger
BOARD_CUSTOM_GRAPHICS := ../../../device/lge/u2-common/recovery-gfx.c
BOARD_CHARGER_ENABLE_SUSPEND := true

# Override healthd HAL to use charge_counter for 1%
BOARD_HAL_STATIC_LIBRARIES := libhealthd.omap4

# SELinux
BOARD_SEPOLICY_DIRS := \
    device/lge/u2-common/selinux

BOARD_SEPOLICY_UNION := \
    file_contexts \
    pvrsrvinit.te \
    device.te \
    domain.te

# CMHW
BOARD_HARDWARE_CLASS := device/lge/u2-common/cmhw/
