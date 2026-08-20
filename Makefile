TARGET_BOOT = boot
TARGET_APPLI = appli

BUILD_DIR_BOOT = build_boot
BUILD_DIR_APPLI = build_appli

CC = arm-none-eabi-gcc
AS = arm-none-eabi-gcc -x assembler-with-cpp
CP = arm-none-eabi-objcopy
SZ = arm-none-eabi-size

MCU = -mcpu=cortex-m7 -mthumb -mfpu=fpv5-d16 -mfloat-abi=hard

# Boot defines
C_DEFS_BOOT = \
-DCORE_CM7 \
-DUSE_HAL_DRIVER \
-DSTM32H7R3xx

# Appli defines
C_DEFS_APPLI = \
-DCORE_CM7 \
-DUSE_HAL_DRIVER \
-DSTM32H7R3xx \
-DUSBPD_PORT_COUNT=1 \
-DUSBPDCORE_LIB_SINK \
-D_SNK

C_INCLUDES_COMMON = \
-IUCPD_ProjectV1/Drivers/STM32H7RSxx_HAL_Driver/Inc \
-IUCPD_ProjectV1/Drivers/STM32H7RSxx_HAL_Driver/Inc/Legacy \
-IUCPD_ProjectV1/Drivers/CMSIS/Device/ST/STM32H7RSxx/Include \
-IUCPD_ProjectV1/Drivers/CMSIS/Include

C_INCLUDES_BOOT = \
-IUCPD_ProjectV1/Boot/Core/Inc \
$(C_INCLUDES_COMMON)

C_INCLUDES_APPLI = \
-IUCPD_ProjectV1/Appli/Core/Inc \
-IUCPD_ProjectV1/Appli/USBPD/App \
-IUCPD_ProjectV1/Appli/USBPD/Target \
-IUCPD_ProjectV1/Appli/USB_DEVICE/App \
-IUCPD_ProjectV1/Appli/USB_DEVICE/Target \
-IUCPD_ProjectV1/Middlewares/ST/STM32_USB_Device_Library/Core/Inc \
-IUCPD_ProjectV1/Middlewares/ST/STM32_USB_Device_Library/Class/CDC/Inc \
-IUCPD_ProjectV1/Middlewares/ST/STM32_USBPD_Library/Core/inc \
-IUCPD_ProjectV1/Middlewares/ST/STM32_USBPD_Library/Devices/STM32H7RSXX/inc \
$(C_INCLUDES_COMMON)

OPT = -O2 -g -Wall -fdata-sections -ffunction-sections

CFLAGS_COMMON = $(MCU) $(OPT) -std=gnu11
ASFLAGS = $(MCU) $(OPT)

LDFLAGS_BOOT = $(MCU) -specs=nano.specs -T UCPD_ProjectV1/Boot/STM32H7R3Z8JX_FLASH.ld -Wl,-Map=$(BUILD_DIR_BOOT)/$(TARGET_BOOT).map,--cref -Wl,--gc-sections
LDFLAGS_APPLI = $(MCU) -specs=nano.specs -T UCPD_ProjectV1/Appli/STM32H7R3Z8JX_ROMxspi1.ld -Wl,-Map=$(BUILD_DIR_APPLI)/$(TARGET_APPLI).map,--cref -Wl,--gc-sections -LUCPD_ProjectV1/Middlewares/ST/STM32_USBPD_Library/Core/lib -lUSBPDCORE_PD3_CONFIG_MIN_CM7_wc32

# Common HAL Driver sources
HAL_SRCS = \
UCPD_ProjectV1/Drivers/STM32H7RSxx_HAL_Driver/Src/stm32h7rsxx_hal.c \
UCPD_ProjectV1/Drivers/STM32H7RSxx_HAL_Driver/Src/stm32h7rsxx_hal_cortex.c \
UCPD_ProjectV1/Drivers/STM32H7RSxx_HAL_Driver/Src/stm32h7rsxx_hal_dma.c \
UCPD_ProjectV1/Drivers/STM32H7RSxx_HAL_Driver/Src/stm32h7rsxx_hal_dma_ex.c \
UCPD_ProjectV1/Drivers/STM32H7RSxx_HAL_Driver/Src/stm32h7rsxx_hal_exti.c \
UCPD_ProjectV1/Drivers/STM32H7RSxx_HAL_Driver/Src/stm32h7rsxx_hal_flash.c \
UCPD_ProjectV1/Drivers/STM32H7RSxx_HAL_Driver/Src/stm32h7rsxx_hal_flash_ex.c \
UCPD_ProjectV1/Drivers/STM32H7RSxx_HAL_Driver/Src/stm32h7rsxx_hal_gpio.c \
UCPD_ProjectV1/Drivers/STM32H7RSxx_HAL_Driver/Src/stm32h7rsxx_hal_pwr.c \
UCPD_ProjectV1/Drivers/STM32H7RSxx_HAL_Driver/Src/stm32h7rsxx_hal_pwr_ex.c \
UCPD_ProjectV1/Drivers/STM32H7RSxx_HAL_Driver/Src/stm32h7rsxx_hal_rcc.c \
UCPD_ProjectV1/Drivers/STM32H7RSxx_HAL_Driver/Src/stm32h7rsxx_hal_rcc_ex.c \
UCPD_ProjectV1/Drivers/STM32H7RSxx_HAL_Driver/Src/stm32h7rsxx_hal_ucpd.c \
UCPD_ProjectV1/Drivers/STM32H7RSxx_HAL_Driver/Src/stm32h7rsxx_hal_xspi.c \
UCPD_ProjectV1/Drivers/STM32H7RSxx_HAL_Driver/Src/stm32h7rsxx_hal_pcd.c \
UCPD_ProjectV1/Drivers/STM32H7RSxx_HAL_Driver/Src/stm32h7rsxx_hal_pcd_ex.c \
UCPD_ProjectV1/Drivers/STM32H7RSxx_HAL_Driver/Src/stm32h7rsxx_ll_usb.c \
UCPD_ProjectV1/Drivers/STM32H7RSxx_HAL_Driver/Src/stm32h7rsxx_ll_ucpd.c \
UCPD_ProjectV1/Drivers/STM32H7RSxx_HAL_Driver/Src/stm32h7rsxx_ll_dma.c

# Boot sources
BOOT_C_SRCS = \
UCPD_ProjectV1/Boot/Core/Src/main.c \
UCPD_ProjectV1/Boot/Core/Src/gpio.c \
UCPD_ProjectV1/Boot/Core/Src/gpdma.c \
UCPD_ProjectV1/Boot/Core/Src/xspi.c \
UCPD_ProjectV1/Boot/Core/Src/stm32h7rsxx_it.c \
UCPD_ProjectV1/Boot/Core/Src/stm32h7rsxx_hal_msp.c \
UCPD_ProjectV1/Boot/Core/Src/system_stm32h7rsxx.c \
UCPD_ProjectV1/Boot/Core/Src/sysmem.c \
UCPD_ProjectV1/Boot/Core/Src/syscalls.c \
$(HAL_SRCS)

BOOT_ASM_SRCS = \
UCPD_ProjectV1/Boot/Core/Startup/startup_stm32h7r3z8jx.s

# Appli sources
APPLI_C_SRCS = \
UCPD_ProjectV1/Appli/Core/Src/main.c \
UCPD_ProjectV1/Appli/Core/Src/gpio.c \
UCPD_ProjectV1/Appli/Core/Src/gpdma.c \
UCPD_ProjectV1/Appli/Core/Src/ucpd.c \
UCPD_ProjectV1/Appli/Core/Src/stm32h7rsxx_it.c \
UCPD_ProjectV1/Appli/Core/Src/stm32h7rsxx_hal_msp.c \
UCPD_ProjectV1/Appli/Core/Src/system_stm32h7rsxx.c \
UCPD_ProjectV1/Appli/Core/Src/sysmem.c \
UCPD_ProjectV1/Appli/Core/Src/syscalls.c \
UCPD_ProjectV1/Appli/USBPD/App/usbpd.c \
UCPD_ProjectV1/Appli/USBPD/App/usbpd_dpm_core.c \
UCPD_ProjectV1/Appli/USBPD/App/usbpd_pwr_if.c \
UCPD_ProjectV1/Appli/USBPD/Target/usbpd_dpm_user.c \
UCPD_ProjectV1/Appli/USBPD/Target/usbpd_pwr_user.c \
UCPD_ProjectV1/Appli/USBPD/Target/usbpd_vdm_user.c \
UCPD_ProjectV1/Appli/USB_DEVICE/App/usb_device.c \
UCPD_ProjectV1/Appli/USB_DEVICE/App/usbd_cdc_if.c \
UCPD_ProjectV1/Appli/USB_DEVICE/App/usbd_desc.c \
UCPD_ProjectV1/Appli/USB_DEVICE/Target/usbd_conf.c \
UCPD_ProjectV1/Middlewares/ST/STM32_USB_Device_Library/Core/Src/usbd_core.c \
UCPD_ProjectV1/Middlewares/ST/STM32_USB_Device_Library/Core/Src/usbd_ctlreq.c \
UCPD_ProjectV1/Middlewares/ST/STM32_USB_Device_Library/Core/Src/usbd_ioreq.c \
UCPD_ProjectV1/Middlewares/ST/STM32_USB_Device_Library/Class/CDC/Src/usbd_cdc.c \
UCPD_ProjectV1/Middlewares/ST/STM32_USBPD_Library/Devices/STM32H7RSXX/src/usbpd_phy.c \
UCPD_ProjectV1/Middlewares/ST/STM32_USBPD_Library/Devices/STM32H7RSXX/src/usbpd_phy_hw_if.c \
UCPD_ProjectV1/Middlewares/ST/STM32_USBPD_Library/Devices/STM32H7RSXX/src/usbpd_cad_hw_if.c \
UCPD_ProjectV1/Middlewares/ST/STM32_USBPD_Library/Devices/STM32H7RSXX/src/usbpd_hw.c \
UCPD_ProjectV1/Middlewares/ST/STM32_USBPD_Library/Devices/STM32H7RSXX/src/usbpd_pwr_hw_if.c \
UCPD_ProjectV1/Middlewares/ST/STM32_USBPD_Library/Devices/STM32H7RSXX/src/usbpd_timersserver.c \
$(HAL_SRCS)

APPLI_ASM_SRCS = \
UCPD_ProjectV1/Appli/Core/Startup/startup_stm32h7r3z8jx.s

# Objects
BOOT_OBJS = $(addprefix $(BUILD_DIR_BOOT)/, $(BOOT_C_SRCS:.c=.o) $(BOOT_ASM_SRCS:.s=.o))
APPLI_OBJS = $(addprefix $(BUILD_DIR_APPLI)/, $(APPLI_C_SRCS:.c=.o) $(APPLI_ASM_SRCS:.s=.o))

all: boot appli

boot: $(BUILD_DIR_BOOT)/$(TARGET_BOOT).elf

appli: $(BUILD_DIR_APPLI)/$(TARGET_APPLI).elf

$(BUILD_DIR_BOOT)/%.o: %.c
	@mkdir -p $(dir $@)
	$(CC) -c $(CFLAGS_COMMON) $(C_DEFS_BOOT) $(C_INCLUDES_BOOT) $< -o $@

$(BUILD_DIR_BOOT)/%.o: %.s
	@mkdir -p $(dir $@)
	$(AS) -c $(ASFLAGS) $< -o $@

$(BUILD_DIR_BOOT)/$(TARGET_BOOT).elf: $(BOOT_OBJS)
	$(CC) $(BOOT_OBJS) $(LDFLAGS_BOOT) -o $@
	$(SZ) $@

$(BUILD_DIR_APPLI)/%.o: %.c
	@mkdir -p $(dir $@)
	$(CC) -c $(CFLAGS_COMMON) $(C_DEFS_APPLI) $(C_INCLUDES_APPLI) $< -o $@

$(BUILD_DIR_APPLI)/%.o: %.s
	@mkdir -p $(dir $@)
	$(AS) -c $(ASFLAGS) $< -o $@

$(BUILD_DIR_APPLI)/$(TARGET_APPLI).elf: $(APPLI_OBJS)
	$(CC) $(APPLI_OBJS) $(LDFLAGS_APPLI) -o $@
	$(SZ) $@

clean:
	rm -rf $(BUILD_DIR_BOOT) $(BUILD_DIR_APPLI)

.PHONY: all boot appli clean
