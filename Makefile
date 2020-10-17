target=Test
CROSS_COMPILE=arm-none-eabi-

CC=$(CROSS_COMPILE)gcc
AS=$(CROSS_COMPILE)as
LD=$(CROSS_COMPILE)ld
OBJCOPY=$(CROSS_COMPILE)objcopy
AR=
NM=
RM=rm -rf 
BUILD_DIR=build
inc=StandFirmwareLib/STM32F10x_StdPeriph_Driver/inc/ \
	-IStandFirmwareLib/CMSIS/CM3/DeviceSupport/ST/STM32F10x/  \
	-IStandFirmwareLib/CMSIS/CM3/CoreSupport/
LIBSPEC=-L
HEX=build/$(target).hex
OBJS=\
	build/main.o \
	startup_stm32f10x_hd.o
ld_script=STM32F103VEHx_FLASH.ld
CFLAGS=-Wall -c -g -mthumb -mcpu=cortex-m3
startup=startup/startup_stm32f10x_hd.s

all:
	$(CC)  $(CFLAGS) -I$(inc)   $(startup)   -o $(BUILD_DIR)/startup_stm32f10x_hd.o
	$(CC)  $(CFLAGS) -I$(inc)   User/main.c  -o $(BUILD_DIR)/main.o
	$(LD)  $(BUILD_DIR)/*.o -static -T $(ld_script) -o $(BUILD_DIR)/$(target).elf
hex:
	$(OBJCOPY) -O ihex $(BUILD_DIR)/$(target).elf $(HEX)	
clean:
	$(RM) build/*.o build/*.elf

update:
	openocd -f openocd.cfg -c init -c halt -c "program  $(BUILD_DIR)/$(target).hex verify  reset exit"

reset:
	openocd -f openocd.cfg -c init -c halt -c reset -c shutdown
.PHONY: all