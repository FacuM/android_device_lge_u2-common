LOCAL_PATH := $(call my-dir)

MKBOOTIMG_BIN := out/host/linux-x86/bin/mkbootimg
BUMP := $(LOCAL_PATH)/bump/bump.py

$(INSTALLED_RECOVERYIMAGE_TARGET): $(MKBOOTIMG) \
		$(recovery_ramdisk) \
		$(recovery_kernel)
	@echo ----- Making recovery image ------
	$(MKBOOTIMG_BIN) --kernel $(PRODUCT_OUT)/kernel --ramdisk $(recovery_ramdisk) --base $(BOARD_KERNEL_BASE) --pagesize $(BOARD_KERNEL_PAGESIZE) $(BOARD_MKBOOTIMG_ARGS) --output $@
	@echo ----- Made recovery image -------- $@
	$(hide) $(BUMP) $@ $@
	$(hide) $(call assert-max-image-size,$@,$(BOARD_RECOVERYIMAGE_PARTITION_SIZE),raw)

$(INSTALLED_BOOTIMAGE_TARGET): $(MKBOOTIMG) $(INTERNAL_BOOTIMAGE_FILES)
	$(call pretty,"Target boot image: $@")
	$(MKBOOTIMG) $(INTERNAL_BOOTIMAGE_ARGS) --output $@
	#$(hide) $(MKBOOTIMG) $(INTERNAL_BOOTIMAGE_ARGS) --output $@
	$(hide) $(call assert-max-image-size,$@,$(BOARD_BOOTIMAGE_PARTITION_SIZE),raw)
	@echo -e ${CL_CYN}"Made boot image: $@"${CL_RST}
	$(hide) $(BUMP) $@ $@
