DEVICE_FOLDER := device/motorola/vanquish

## (2) Also get non-open-source specific aspects if available
$(call inherit-product-if-exists, vendor/motorola/vanquish/vanquish-vendor.mk)

## overlays
DEVICE_PACKAGE_OVERLAYS += device/motorola/vanquish/overlay/aosp

# Device uses high-density artwork where available
PRODUCT_AAPT_CONFIG := normal hdpi xhdpi
PRODUCT_AAPT_PREF_CONFIG := xhdpi

# IDC
PRODUCT_COPY_FILES += $(DEVICE_FOLDER)/idc/melfas-ts.idc:system/usr/idc/melfas-ts.idc

# Media config
PRODUCT_COPY_FILES += \
    $(DEVICE_FOLDER)/media_profiles.xml:system/etc/media_profiles.xml

# Camera
PRODUCT_PACKAGES += \
	camera.vanquish

# Radio and Telephony
PRODUCT_PROPERTY_OVERRIDES += \
    DEVICE_PROVISIONED=1 \
    ro.cdma.subscribe_on_ruim_ready=true \
    persist.radio.no_wait_for_card=1

# copy all kernel modules under the "modules" directory to system/lib/modules
#PRODUCT_COPY_FILES += $(shell \
#    find device/motorola/vanquish/modules -name '*.ko' \
#    | sed -r 's/^\/?(.*\/)([^/ ]+)$$/\1\2:system\/lib\/modules\/\2/' \
#    | tr '\n' ' ')

#ifeq ($(TARGET_PREBUILT_KERNEL),)
#LOCAL_KERNEL := device/motorola/vanquish/kernel
#else
#LOCAL_KERNEL := $(TARGET_PREBUILT_KERNEL)
#endif

#PRODUCT_COPY_FILES += \
#    $(LOCAL_KERNEL):kernel

# Inherit from msm8960-common
$(call inherit-product, device/motorola/msm8960-common/msm8960-common.mk)
# Inherit cdma specific stuff
$(call inherit-product-if-exists, vendor/motorola/msm8960-common/msm8960-common-vendor.mk)
# ICS camera blobs
$(call inherit-product-if-exists, vendor/motorola/vanquish/vanquish_jb_camera.mk)
$(call inherit-product-if-exists, vendor/motorola/vanquish/vanquish_42_gps.mk)
