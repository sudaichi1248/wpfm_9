#
# Generated Makefile - do not edit!
#
# Edit the Makefile in the project folder instead (../Makefile). Each target
# has a -pre and a -post target defined where you can add customized code.
#
# This makefile implements configuration specific macros and targets.


# Include project Makefile
ifeq "${IGNORE_LOCAL}" "TRUE"
# do not include local makefile. User is passing all local related variables already
else
include Makefile
# Include makefile containing local settings
ifeq "$(wildcard nbproject/Makefile-local-atsamd21g18a_default.mk)" "nbproject/Makefile-local-atsamd21g18a_default.mk"
include nbproject/Makefile-local-atsamd21g18a_default.mk
endif
endif

# Environment
MKDIR=gnumkdir -p
RM=rm -f 
MV=mv 
CP=cp 

# Macros
CND_CONF=atsamd21g18a_default
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
IMAGE_TYPE=debug
OUTPUT_SUFFIX=elf
DEBUGGABLE_SUFFIX=elf
FINAL_IMAGE=${DISTDIR}/DLC00.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}
else
IMAGE_TYPE=production
OUTPUT_SUFFIX=hex
DEBUGGABLE_SUFFIX=elf
FINAL_IMAGE=${DISTDIR}/DLC00.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}
endif

ifeq ($(COMPARE_BUILD), true)
COMPARISON_BUILD=-mafrlcsj
else
COMPARISON_BUILD=
endif

ifdef SUB_IMAGE_ADDRESS

else
SUB_IMAGE_ADDRESS_COMMAND=
endif

# Object Directory
OBJECTDIR=build/${CND_CONF}/${IMAGE_TYPE}

# Distribution Directory
DISTDIR=dist/${CND_CONF}/${IMAGE_TYPE}

# Source Files Quoted if spaced
SOURCEFILES_QUOTED_IF_SPACED=../src/config/atsamd21g18a_default/driver/usb/usbfsv1/src/drv_usbfsv1.c ../src/config/atsamd21g18a_default/driver/usb/usbfsv1/src/drv_usbfsv1_device.c ../src/config/atsamd21g18a_default/peripheral/adc/plib_adc.c ../src/config/atsamd21g18a_default/peripheral/clock/plib_clock.c ../src/config/atsamd21g18a_default/peripheral/eic/plib_eic.c ../src/config/atsamd21g18a_default/peripheral/evsys/plib_evsys.c ../src/config/atsamd21g18a_default/peripheral/nvic/plib_nvic.c ../src/config/atsamd21g18a_default/peripheral/nvmctrl/plib_nvmctrl.c ../src/config/atsamd21g18a_default/peripheral/pm/plib_pm.c ../src/config/atsamd21g18a_default/peripheral/port/plib_port.c ../src/config/atsamd21g18a_default/peripheral/sercom/i2c_master/plib_sercom3_i2c_master.c ../src/config/atsamd21g18a_default/peripheral/sercom/spi_master/plib_sercom1_spi_master.c ../src/config/atsamd21g18a_default/peripheral/sercom/usart/plib_sercom0_usart.c ../src/config/atsamd21g18a_default/peripheral/sercom/usart/plib_sercom5_usart.c ../src/config/atsamd21g18a_default/peripheral/systick/plib_systick.c ../src/config/atsamd21g18a_default/peripheral/tc/plib_tc3.c ../src/config/atsamd21g18a_default/peripheral/tc/plib_tc4.c ../src/config/atsamd21g18a_default/peripheral/tc/plib_tc5.c ../src/config/atsamd21g18a_default/peripheral/wdt/plib_wdt.c ../src/config/atsamd21g18a_default/stdio/xc32_monitor.c ../src/config/atsamd21g18a_default/system/int/src/sys_int.c ../src/config/atsamd21g18a_default/usb/src/usb_device.c ../src/config/atsamd21g18a_default/usb/src/usb_device_cdc.c ../src/config/atsamd21g18a_default/usb/src/usb_device_cdc_acm.c ../src/config/atsamd21g18a_default/initialization.c ../src/config/atsamd21g18a_default/interrupts.c ../src/config/atsamd21g18a_default/exceptions.c ../src/config/atsamd21g18a_default/startup_xc32.c ../src/config/atsamd21g18a_default/libc_syscalls.c ../src/config/atsamd21g18a_default/usb_device_init_data.c ../src/config/atsamd21g18a_default/tasks.c ../src/w25q128jv.c ../src/util.c ../src/s5851a.c ../src/gpioexp.c ../src/rtc.c ../src/mlog.c ../src/sensor.c ../src/uart_debug.c ../src/uart_comm.c ../src/wpfm.c ../src/battery.c ../src/communicate.c ../src/init.c ../src/measure.c ../src/alert.c ../src/smpif4.c ../src/smpif.c ../src/smpif1.c ../src/smpif2.c ../src/smpif3.c ../src/main.c ../src/app.c ../src/MATcore.c ../src/moni.c ../src/version.c ../src/DLCpara.c ../src/EventLog.c ../src/FOTAcmd.c

# Object Files Quoted if spaced
OBJECTFILES_QUOTED_IF_SPACED=${OBJECTDIR}/_ext/1814754785/drv_usbfsv1.o ${OBJECTDIR}/_ext/1814754785/drv_usbfsv1_device.o ${OBJECTDIR}/_ext/1885044035/plib_adc.o ${OBJECTDIR}/_ext/950981355/plib_clock.o ${OBJECTDIR}/_ext/1885040036/plib_eic.o ${OBJECTDIR}/_ext/953130841/plib_evsys.o ${OBJECTDIR}/_ext/1693581925/plib_nvic.o ${OBJECTDIR}/_ext/522110765/plib_nvmctrl.o ${OBJECTDIR}/_ext/1324665920/plib_pm.o ${OBJECTDIR}/_ext/1693635076/plib_port.o ${OBJECTDIR}/_ext/163103410/plib_sercom3_i2c_master.o ${OBJECTDIR}/_ext/328131232/plib_sercom1_spi_master.o ${OBJECTDIR}/_ext/472979226/plib_sercom0_usart.o ${OBJECTDIR}/_ext/472979226/plib_sercom5_usart.o ${OBJECTDIR}/_ext/756585863/plib_systick.o ${OBJECTDIR}/_ext/1324666034/plib_tc3.o ${OBJECTDIR}/_ext/1324666034/plib_tc4.o ${OBJECTDIR}/_ext/1324666034/plib_tc5.o ${OBJECTDIR}/_ext/1885022876/plib_wdt.o ${OBJECTDIR}/_ext/9958233/xc32_monitor.o ${OBJECTDIR}/_ext/63538924/sys_int.o ${OBJECTDIR}/_ext/1572229207/usb_device.o ${OBJECTDIR}/_ext/1572229207/usb_device_cdc.o ${OBJECTDIR}/_ext/1572229207/usb_device_cdc_acm.o ${OBJECTDIR}/_ext/1640317663/initialization.o ${OBJECTDIR}/_ext/1640317663/interrupts.o ${OBJECTDIR}/_ext/1640317663/exceptions.o ${OBJECTDIR}/_ext/1640317663/startup_xc32.o ${OBJECTDIR}/_ext/1640317663/libc_syscalls.o ${OBJECTDIR}/_ext/1640317663/usb_device_init_data.o ${OBJECTDIR}/_ext/1640317663/tasks.o ${OBJECTDIR}/_ext/1360937237/w25q128jv.o ${OBJECTDIR}/_ext/1360937237/util.o ${OBJECTDIR}/_ext/1360937237/s5851a.o ${OBJECTDIR}/_ext/1360937237/gpioexp.o ${OBJECTDIR}/_ext/1360937237/rtc.o ${OBJECTDIR}/_ext/1360937237/mlog.o ${OBJECTDIR}/_ext/1360937237/sensor.o ${OBJECTDIR}/_ext/1360937237/uart_debug.o ${OBJECTDIR}/_ext/1360937237/uart_comm.o ${OBJECTDIR}/_ext/1360937237/wpfm.o ${OBJECTDIR}/_ext/1360937237/battery.o ${OBJECTDIR}/_ext/1360937237/communicate.o ${OBJECTDIR}/_ext/1360937237/init.o ${OBJECTDIR}/_ext/1360937237/measure.o ${OBJECTDIR}/_ext/1360937237/alert.o ${OBJECTDIR}/_ext/1360937237/smpif4.o ${OBJECTDIR}/_ext/1360937237/smpif.o ${OBJECTDIR}/_ext/1360937237/smpif1.o ${OBJECTDIR}/_ext/1360937237/smpif2.o ${OBJECTDIR}/_ext/1360937237/smpif3.o ${OBJECTDIR}/_ext/1360937237/main.o ${OBJECTDIR}/_ext/1360937237/app.o ${OBJECTDIR}/_ext/1360937237/MATcore.o ${OBJECTDIR}/_ext/1360937237/moni.o ${OBJECTDIR}/_ext/1360937237/version.o ${OBJECTDIR}/_ext/1360937237/DLCpara.o ${OBJECTDIR}/_ext/1360937237/EventLog.o ${OBJECTDIR}/_ext/1360937237/FOTAcmd.o
POSSIBLE_DEPFILES=${OBJECTDIR}/_ext/1814754785/drv_usbfsv1.o.d ${OBJECTDIR}/_ext/1814754785/drv_usbfsv1_device.o.d ${OBJECTDIR}/_ext/1885044035/plib_adc.o.d ${OBJECTDIR}/_ext/950981355/plib_clock.o.d ${OBJECTDIR}/_ext/1885040036/plib_eic.o.d ${OBJECTDIR}/_ext/953130841/plib_evsys.o.d ${OBJECTDIR}/_ext/1693581925/plib_nvic.o.d ${OBJECTDIR}/_ext/522110765/plib_nvmctrl.o.d ${OBJECTDIR}/_ext/1324665920/plib_pm.o.d ${OBJECTDIR}/_ext/1693635076/plib_port.o.d ${OBJECTDIR}/_ext/163103410/plib_sercom3_i2c_master.o.d ${OBJECTDIR}/_ext/328131232/plib_sercom1_spi_master.o.d ${OBJECTDIR}/_ext/472979226/plib_sercom0_usart.o.d ${OBJECTDIR}/_ext/472979226/plib_sercom5_usart.o.d ${OBJECTDIR}/_ext/756585863/plib_systick.o.d ${OBJECTDIR}/_ext/1324666034/plib_tc3.o.d ${OBJECTDIR}/_ext/1324666034/plib_tc4.o.d ${OBJECTDIR}/_ext/1324666034/plib_tc5.o.d ${OBJECTDIR}/_ext/1885022876/plib_wdt.o.d ${OBJECTDIR}/_ext/9958233/xc32_monitor.o.d ${OBJECTDIR}/_ext/63538924/sys_int.o.d ${OBJECTDIR}/_ext/1572229207/usb_device.o.d ${OBJECTDIR}/_ext/1572229207/usb_device_cdc.o.d ${OBJECTDIR}/_ext/1572229207/usb_device_cdc_acm.o.d ${OBJECTDIR}/_ext/1640317663/initialization.o.d ${OBJECTDIR}/_ext/1640317663/interrupts.o.d ${OBJECTDIR}/_ext/1640317663/exceptions.o.d ${OBJECTDIR}/_ext/1640317663/startup_xc32.o.d ${OBJECTDIR}/_ext/1640317663/libc_syscalls.o.d ${OBJECTDIR}/_ext/1640317663/usb_device_init_data.o.d ${OBJECTDIR}/_ext/1640317663/tasks.o.d ${OBJECTDIR}/_ext/1360937237/w25q128jv.o.d ${OBJECTDIR}/_ext/1360937237/util.o.d ${OBJECTDIR}/_ext/1360937237/s5851a.o.d ${OBJECTDIR}/_ext/1360937237/gpioexp.o.d ${OBJECTDIR}/_ext/1360937237/rtc.o.d ${OBJECTDIR}/_ext/1360937237/mlog.o.d ${OBJECTDIR}/_ext/1360937237/sensor.o.d ${OBJECTDIR}/_ext/1360937237/uart_debug.o.d ${OBJECTDIR}/_ext/1360937237/uart_comm.o.d ${OBJECTDIR}/_ext/1360937237/wpfm.o.d ${OBJECTDIR}/_ext/1360937237/battery.o.d ${OBJECTDIR}/_ext/1360937237/communicate.o.d ${OBJECTDIR}/_ext/1360937237/init.o.d ${OBJECTDIR}/_ext/1360937237/measure.o.d ${OBJECTDIR}/_ext/1360937237/alert.o.d ${OBJECTDIR}/_ext/1360937237/smpif4.o.d ${OBJECTDIR}/_ext/1360937237/smpif.o.d ${OBJECTDIR}/_ext/1360937237/smpif1.o.d ${OBJECTDIR}/_ext/1360937237/smpif2.o.d ${OBJECTDIR}/_ext/1360937237/smpif3.o.d ${OBJECTDIR}/_ext/1360937237/main.o.d ${OBJECTDIR}/_ext/1360937237/app.o.d ${OBJECTDIR}/_ext/1360937237/MATcore.o.d ${OBJECTDIR}/_ext/1360937237/moni.o.d ${OBJECTDIR}/_ext/1360937237/version.o.d ${OBJECTDIR}/_ext/1360937237/DLCpara.o.d ${OBJECTDIR}/_ext/1360937237/EventLog.o.d ${OBJECTDIR}/_ext/1360937237/FOTAcmd.o.d

# Object Files
OBJECTFILES=${OBJECTDIR}/_ext/1814754785/drv_usbfsv1.o ${OBJECTDIR}/_ext/1814754785/drv_usbfsv1_device.o ${OBJECTDIR}/_ext/1885044035/plib_adc.o ${OBJECTDIR}/_ext/950981355/plib_clock.o ${OBJECTDIR}/_ext/1885040036/plib_eic.o ${OBJECTDIR}/_ext/953130841/plib_evsys.o ${OBJECTDIR}/_ext/1693581925/plib_nvic.o ${OBJECTDIR}/_ext/522110765/plib_nvmctrl.o ${OBJECTDIR}/_ext/1324665920/plib_pm.o ${OBJECTDIR}/_ext/1693635076/plib_port.o ${OBJECTDIR}/_ext/163103410/plib_sercom3_i2c_master.o ${OBJECTDIR}/_ext/328131232/plib_sercom1_spi_master.o ${OBJECTDIR}/_ext/472979226/plib_sercom0_usart.o ${OBJECTDIR}/_ext/472979226/plib_sercom5_usart.o ${OBJECTDIR}/_ext/756585863/plib_systick.o ${OBJECTDIR}/_ext/1324666034/plib_tc3.o ${OBJECTDIR}/_ext/1324666034/plib_tc4.o ${OBJECTDIR}/_ext/1324666034/plib_tc5.o ${OBJECTDIR}/_ext/1885022876/plib_wdt.o ${OBJECTDIR}/_ext/9958233/xc32_monitor.o ${OBJECTDIR}/_ext/63538924/sys_int.o ${OBJECTDIR}/_ext/1572229207/usb_device.o ${OBJECTDIR}/_ext/1572229207/usb_device_cdc.o ${OBJECTDIR}/_ext/1572229207/usb_device_cdc_acm.o ${OBJECTDIR}/_ext/1640317663/initialization.o ${OBJECTDIR}/_ext/1640317663/interrupts.o ${OBJECTDIR}/_ext/1640317663/exceptions.o ${OBJECTDIR}/_ext/1640317663/startup_xc32.o ${OBJECTDIR}/_ext/1640317663/libc_syscalls.o ${OBJECTDIR}/_ext/1640317663/usb_device_init_data.o ${OBJECTDIR}/_ext/1640317663/tasks.o ${OBJECTDIR}/_ext/1360937237/w25q128jv.o ${OBJECTDIR}/_ext/1360937237/util.o ${OBJECTDIR}/_ext/1360937237/s5851a.o ${OBJECTDIR}/_ext/1360937237/gpioexp.o ${OBJECTDIR}/_ext/1360937237/rtc.o ${OBJECTDIR}/_ext/1360937237/mlog.o ${OBJECTDIR}/_ext/1360937237/sensor.o ${OBJECTDIR}/_ext/1360937237/uart_debug.o ${OBJECTDIR}/_ext/1360937237/uart_comm.o ${OBJECTDIR}/_ext/1360937237/wpfm.o ${OBJECTDIR}/_ext/1360937237/battery.o ${OBJECTDIR}/_ext/1360937237/communicate.o ${OBJECTDIR}/_ext/1360937237/init.o ${OBJECTDIR}/_ext/1360937237/measure.o ${OBJECTDIR}/_ext/1360937237/alert.o ${OBJECTDIR}/_ext/1360937237/smpif4.o ${OBJECTDIR}/_ext/1360937237/smpif.o ${OBJECTDIR}/_ext/1360937237/smpif1.o ${OBJECTDIR}/_ext/1360937237/smpif2.o ${OBJECTDIR}/_ext/1360937237/smpif3.o ${OBJECTDIR}/_ext/1360937237/main.o ${OBJECTDIR}/_ext/1360937237/app.o ${OBJECTDIR}/_ext/1360937237/MATcore.o ${OBJECTDIR}/_ext/1360937237/moni.o ${OBJECTDIR}/_ext/1360937237/version.o ${OBJECTDIR}/_ext/1360937237/DLCpara.o ${OBJECTDIR}/_ext/1360937237/EventLog.o ${OBJECTDIR}/_ext/1360937237/FOTAcmd.o

# Source Files
SOURCEFILES=../src/config/atsamd21g18a_default/driver/usb/usbfsv1/src/drv_usbfsv1.c ../src/config/atsamd21g18a_default/driver/usb/usbfsv1/src/drv_usbfsv1_device.c ../src/config/atsamd21g18a_default/peripheral/adc/plib_adc.c ../src/config/atsamd21g18a_default/peripheral/clock/plib_clock.c ../src/config/atsamd21g18a_default/peripheral/eic/plib_eic.c ../src/config/atsamd21g18a_default/peripheral/evsys/plib_evsys.c ../src/config/atsamd21g18a_default/peripheral/nvic/plib_nvic.c ../src/config/atsamd21g18a_default/peripheral/nvmctrl/plib_nvmctrl.c ../src/config/atsamd21g18a_default/peripheral/pm/plib_pm.c ../src/config/atsamd21g18a_default/peripheral/port/plib_port.c ../src/config/atsamd21g18a_default/peripheral/sercom/i2c_master/plib_sercom3_i2c_master.c ../src/config/atsamd21g18a_default/peripheral/sercom/spi_master/plib_sercom1_spi_master.c ../src/config/atsamd21g18a_default/peripheral/sercom/usart/plib_sercom0_usart.c ../src/config/atsamd21g18a_default/peripheral/sercom/usart/plib_sercom5_usart.c ../src/config/atsamd21g18a_default/peripheral/systick/plib_systick.c ../src/config/atsamd21g18a_default/peripheral/tc/plib_tc3.c ../src/config/atsamd21g18a_default/peripheral/tc/plib_tc4.c ../src/config/atsamd21g18a_default/peripheral/tc/plib_tc5.c ../src/config/atsamd21g18a_default/peripheral/wdt/plib_wdt.c ../src/config/atsamd21g18a_default/stdio/xc32_monitor.c ../src/config/atsamd21g18a_default/system/int/src/sys_int.c ../src/config/atsamd21g18a_default/usb/src/usb_device.c ../src/config/atsamd21g18a_default/usb/src/usb_device_cdc.c ../src/config/atsamd21g18a_default/usb/src/usb_device_cdc_acm.c ../src/config/atsamd21g18a_default/initialization.c ../src/config/atsamd21g18a_default/interrupts.c ../src/config/atsamd21g18a_default/exceptions.c ../src/config/atsamd21g18a_default/startup_xc32.c ../src/config/atsamd21g18a_default/libc_syscalls.c ../src/config/atsamd21g18a_default/usb_device_init_data.c ../src/config/atsamd21g18a_default/tasks.c ../src/w25q128jv.c ../src/util.c ../src/s5851a.c ../src/gpioexp.c ../src/rtc.c ../src/mlog.c ../src/sensor.c ../src/uart_debug.c ../src/uart_comm.c ../src/wpfm.c ../src/battery.c ../src/communicate.c ../src/init.c ../src/measure.c ../src/alert.c ../src/smpif4.c ../src/smpif.c ../src/smpif1.c ../src/smpif2.c ../src/smpif3.c ../src/main.c ../src/app.c ../src/MATcore.c ../src/moni.c ../src/version.c ../src/DLCpara.c ../src/EventLog.c ../src/FOTAcmd.c

# Pack Options 
PACK_COMMON_OPTIONS=-I "${CMSIS_DIR}/CMSIS/Core/Include"



CFLAGS=
ASFLAGS=
LDLIBSOPTIONS=

############# Tool locations ##########################################
# If you copy a project from one host to another, the path where the  #
# compiler is installed may be different.                             #
# If you open this project with MPLAB X in the new host, this         #
# makefile will be regenerated and the paths will be corrected.       #
#######################################################################
# fixDeps replaces a bunch of sed/cat/printf statements that slow down the build
FIXDEPS=fixDeps

# The following macros may be used in the pre and post step lines
_/_=\\
ShExtension=.bat
Device=ATSAMD21G18A
ProjectDir="D:\FCOM\DLC01\firmware\DLC00.X"
ProjectName=DLC00
ConfName=atsamd21g18a_default
ImagePath="${DISTDIR}\DLC00.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}"
ImageDir="${DISTDIR}"
ImageName="DLC00.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}"
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
IsDebug="true"
else
IsDebug="false"
endif

.build-conf:  .pre ${BUILD_SUBPROJECTS}
ifneq ($(INFORMATION_MESSAGE), )
	@echo $(INFORMATION_MESSAGE)
endif
	${MAKE}  -f nbproject/Makefile-atsamd21g18a_default.mk ${DISTDIR}/DLC00.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}
	@echo "--------------------------------------"
	@echo "User defined post-build step: [..\..\HEX2MOT ${ImagePath}]"
	@..\..\HEX2MOT ${ImagePath}
	@echo "--------------------------------------"

MP_PROCESSOR_OPTION=ATSAMD21G18A
MP_LINKER_FILE_OPTION=,--script="..\src\config\atsamd21g18a_default\ATSAMD21G18A.ld"
# ------------------------------------------------------------------------------------
# Rules for buildStep: assemble
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
else
endif

# ------------------------------------------------------------------------------------
# Rules for buildStep: assembleWithPreprocess
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
else
endif

# ------------------------------------------------------------------------------------
# Rules for buildStep: compile
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
${OBJECTDIR}/_ext/1814754785/drv_usbfsv1.o: ../src/config/atsamd21g18a_default/driver/usb/usbfsv1/src/drv_usbfsv1.c  .generated_files/flags/atsamd21g18a_default/e0c446e9822fc5b8e3bbbb406f06783a26ca00f0 .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/1814754785" 
	@${RM} ${OBJECTDIR}/_ext/1814754785/drv_usbfsv1.o.d 
	@${RM} ${OBJECTDIR}/_ext/1814754785/drv_usbfsv1.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1814754785/drv_usbfsv1.o.d" -o ${OBJECTDIR}/_ext/1814754785/drv_usbfsv1.o ../src/config/atsamd21g18a_default/driver/usb/usbfsv1/src/drv_usbfsv1.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1814754785/drv_usbfsv1_device.o: ../src/config/atsamd21g18a_default/driver/usb/usbfsv1/src/drv_usbfsv1_device.c  .generated_files/flags/atsamd21g18a_default/5e805b1efb1fdf4859039007a5136a6dabed154e .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/1814754785" 
	@${RM} ${OBJECTDIR}/_ext/1814754785/drv_usbfsv1_device.o.d 
	@${RM} ${OBJECTDIR}/_ext/1814754785/drv_usbfsv1_device.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1814754785/drv_usbfsv1_device.o.d" -o ${OBJECTDIR}/_ext/1814754785/drv_usbfsv1_device.o ../src/config/atsamd21g18a_default/driver/usb/usbfsv1/src/drv_usbfsv1_device.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1885044035/plib_adc.o: ../src/config/atsamd21g18a_default/peripheral/adc/plib_adc.c  .generated_files/flags/atsamd21g18a_default/5166e933b07e1a184b51610be90f58eeeaa7b0e5 .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/1885044035" 
	@${RM} ${OBJECTDIR}/_ext/1885044035/plib_adc.o.d 
	@${RM} ${OBJECTDIR}/_ext/1885044035/plib_adc.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1885044035/plib_adc.o.d" -o ${OBJECTDIR}/_ext/1885044035/plib_adc.o ../src/config/atsamd21g18a_default/peripheral/adc/plib_adc.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/950981355/plib_clock.o: ../src/config/atsamd21g18a_default/peripheral/clock/plib_clock.c  .generated_files/flags/atsamd21g18a_default/42fc430f42d9dfa110fcc602b8740f87cc35938b .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/950981355" 
	@${RM} ${OBJECTDIR}/_ext/950981355/plib_clock.o.d 
	@${RM} ${OBJECTDIR}/_ext/950981355/plib_clock.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/950981355/plib_clock.o.d" -o ${OBJECTDIR}/_ext/950981355/plib_clock.o ../src/config/atsamd21g18a_default/peripheral/clock/plib_clock.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1885040036/plib_eic.o: ../src/config/atsamd21g18a_default/peripheral/eic/plib_eic.c  .generated_files/flags/atsamd21g18a_default/a4daf79779b5fa9b3cd3314fa3f4723cade7d5bd .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/1885040036" 
	@${RM} ${OBJECTDIR}/_ext/1885040036/plib_eic.o.d 
	@${RM} ${OBJECTDIR}/_ext/1885040036/plib_eic.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1885040036/plib_eic.o.d" -o ${OBJECTDIR}/_ext/1885040036/plib_eic.o ../src/config/atsamd21g18a_default/peripheral/eic/plib_eic.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/953130841/plib_evsys.o: ../src/config/atsamd21g18a_default/peripheral/evsys/plib_evsys.c  .generated_files/flags/atsamd21g18a_default/14fcef6aebf6ad88f3c9d5ab2740bef694ef77a8 .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/953130841" 
	@${RM} ${OBJECTDIR}/_ext/953130841/plib_evsys.o.d 
	@${RM} ${OBJECTDIR}/_ext/953130841/plib_evsys.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/953130841/plib_evsys.o.d" -o ${OBJECTDIR}/_ext/953130841/plib_evsys.o ../src/config/atsamd21g18a_default/peripheral/evsys/plib_evsys.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1693581925/plib_nvic.o: ../src/config/atsamd21g18a_default/peripheral/nvic/plib_nvic.c  .generated_files/flags/atsamd21g18a_default/f0d42521f5efa4e48efbbf1d94dc81779091eee8 .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/1693581925" 
	@${RM} ${OBJECTDIR}/_ext/1693581925/plib_nvic.o.d 
	@${RM} ${OBJECTDIR}/_ext/1693581925/plib_nvic.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1693581925/plib_nvic.o.d" -o ${OBJECTDIR}/_ext/1693581925/plib_nvic.o ../src/config/atsamd21g18a_default/peripheral/nvic/plib_nvic.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/522110765/plib_nvmctrl.o: ../src/config/atsamd21g18a_default/peripheral/nvmctrl/plib_nvmctrl.c  .generated_files/flags/atsamd21g18a_default/d891a88c1cfc96f47cdb29c13959e0044f95a992 .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/522110765" 
	@${RM} ${OBJECTDIR}/_ext/522110765/plib_nvmctrl.o.d 
	@${RM} ${OBJECTDIR}/_ext/522110765/plib_nvmctrl.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/522110765/plib_nvmctrl.o.d" -o ${OBJECTDIR}/_ext/522110765/plib_nvmctrl.o ../src/config/atsamd21g18a_default/peripheral/nvmctrl/plib_nvmctrl.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1324665920/plib_pm.o: ../src/config/atsamd21g18a_default/peripheral/pm/plib_pm.c  .generated_files/flags/atsamd21g18a_default/e656d1765af004b648265b964ec87cb973a8f22c .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/1324665920" 
	@${RM} ${OBJECTDIR}/_ext/1324665920/plib_pm.o.d 
	@${RM} ${OBJECTDIR}/_ext/1324665920/plib_pm.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1324665920/plib_pm.o.d" -o ${OBJECTDIR}/_ext/1324665920/plib_pm.o ../src/config/atsamd21g18a_default/peripheral/pm/plib_pm.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1693635076/plib_port.o: ../src/config/atsamd21g18a_default/peripheral/port/plib_port.c  .generated_files/flags/atsamd21g18a_default/57ec26d8b81814c008a0f374f75ad53a4da283f6 .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/1693635076" 
	@${RM} ${OBJECTDIR}/_ext/1693635076/plib_port.o.d 
	@${RM} ${OBJECTDIR}/_ext/1693635076/plib_port.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1693635076/plib_port.o.d" -o ${OBJECTDIR}/_ext/1693635076/plib_port.o ../src/config/atsamd21g18a_default/peripheral/port/plib_port.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/163103410/plib_sercom3_i2c_master.o: ../src/config/atsamd21g18a_default/peripheral/sercom/i2c_master/plib_sercom3_i2c_master.c  .generated_files/flags/atsamd21g18a_default/dd2b541d34753d5c37e1c638657c0b6f04a0dfab .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/163103410" 
	@${RM} ${OBJECTDIR}/_ext/163103410/plib_sercom3_i2c_master.o.d 
	@${RM} ${OBJECTDIR}/_ext/163103410/plib_sercom3_i2c_master.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/163103410/plib_sercom3_i2c_master.o.d" -o ${OBJECTDIR}/_ext/163103410/plib_sercom3_i2c_master.o ../src/config/atsamd21g18a_default/peripheral/sercom/i2c_master/plib_sercom3_i2c_master.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/328131232/plib_sercom1_spi_master.o: ../src/config/atsamd21g18a_default/peripheral/sercom/spi_master/plib_sercom1_spi_master.c  .generated_files/flags/atsamd21g18a_default/9d32e028819afe7242d2c4de9990f30d7f3da23 .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/328131232" 
	@${RM} ${OBJECTDIR}/_ext/328131232/plib_sercom1_spi_master.o.d 
	@${RM} ${OBJECTDIR}/_ext/328131232/plib_sercom1_spi_master.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/328131232/plib_sercom1_spi_master.o.d" -o ${OBJECTDIR}/_ext/328131232/plib_sercom1_spi_master.o ../src/config/atsamd21g18a_default/peripheral/sercom/spi_master/plib_sercom1_spi_master.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/472979226/plib_sercom0_usart.o: ../src/config/atsamd21g18a_default/peripheral/sercom/usart/plib_sercom0_usart.c  .generated_files/flags/atsamd21g18a_default/b27ad265367f9105aafd07032efda3e84b1d823e .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/472979226" 
	@${RM} ${OBJECTDIR}/_ext/472979226/plib_sercom0_usart.o.d 
	@${RM} ${OBJECTDIR}/_ext/472979226/plib_sercom0_usart.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/472979226/plib_sercom0_usart.o.d" -o ${OBJECTDIR}/_ext/472979226/plib_sercom0_usart.o ../src/config/atsamd21g18a_default/peripheral/sercom/usart/plib_sercom0_usart.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/472979226/plib_sercom5_usart.o: ../src/config/atsamd21g18a_default/peripheral/sercom/usart/plib_sercom5_usart.c  .generated_files/flags/atsamd21g18a_default/11326e3f3fd6a8c94a9f8965391606f7fc7be5d2 .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/472979226" 
	@${RM} ${OBJECTDIR}/_ext/472979226/plib_sercom5_usart.o.d 
	@${RM} ${OBJECTDIR}/_ext/472979226/plib_sercom5_usart.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/472979226/plib_sercom5_usart.o.d" -o ${OBJECTDIR}/_ext/472979226/plib_sercom5_usart.o ../src/config/atsamd21g18a_default/peripheral/sercom/usart/plib_sercom5_usart.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/756585863/plib_systick.o: ../src/config/atsamd21g18a_default/peripheral/systick/plib_systick.c  .generated_files/flags/atsamd21g18a_default/a47d346e43ea1da7d9e73a091fd23db0ac997468 .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/756585863" 
	@${RM} ${OBJECTDIR}/_ext/756585863/plib_systick.o.d 
	@${RM} ${OBJECTDIR}/_ext/756585863/plib_systick.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/756585863/plib_systick.o.d" -o ${OBJECTDIR}/_ext/756585863/plib_systick.o ../src/config/atsamd21g18a_default/peripheral/systick/plib_systick.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1324666034/plib_tc3.o: ../src/config/atsamd21g18a_default/peripheral/tc/plib_tc3.c  .generated_files/flags/atsamd21g18a_default/c0bc410c60f2392e4efdfb09e9e7e3bd86fa6a4a .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/1324666034" 
	@${RM} ${OBJECTDIR}/_ext/1324666034/plib_tc3.o.d 
	@${RM} ${OBJECTDIR}/_ext/1324666034/plib_tc3.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1324666034/plib_tc3.o.d" -o ${OBJECTDIR}/_ext/1324666034/plib_tc3.o ../src/config/atsamd21g18a_default/peripheral/tc/plib_tc3.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1324666034/plib_tc4.o: ../src/config/atsamd21g18a_default/peripheral/tc/plib_tc4.c  .generated_files/flags/atsamd21g18a_default/f15af3dca1b1c30d50681f72df330ee942bbf37c .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/1324666034" 
	@${RM} ${OBJECTDIR}/_ext/1324666034/plib_tc4.o.d 
	@${RM} ${OBJECTDIR}/_ext/1324666034/plib_tc4.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1324666034/plib_tc4.o.d" -o ${OBJECTDIR}/_ext/1324666034/plib_tc4.o ../src/config/atsamd21g18a_default/peripheral/tc/plib_tc4.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1324666034/plib_tc5.o: ../src/config/atsamd21g18a_default/peripheral/tc/plib_tc5.c  .generated_files/flags/atsamd21g18a_default/4606a9b42c3687d4fd4964f709a3c74e2b13374b .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/1324666034" 
	@${RM} ${OBJECTDIR}/_ext/1324666034/plib_tc5.o.d 
	@${RM} ${OBJECTDIR}/_ext/1324666034/plib_tc5.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1324666034/plib_tc5.o.d" -o ${OBJECTDIR}/_ext/1324666034/plib_tc5.o ../src/config/atsamd21g18a_default/peripheral/tc/plib_tc5.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1885022876/plib_wdt.o: ../src/config/atsamd21g18a_default/peripheral/wdt/plib_wdt.c  .generated_files/flags/atsamd21g18a_default/abf1f6f42208c3eb2b0a24877b5baaec47b1c125 .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/1885022876" 
	@${RM} ${OBJECTDIR}/_ext/1885022876/plib_wdt.o.d 
	@${RM} ${OBJECTDIR}/_ext/1885022876/plib_wdt.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1885022876/plib_wdt.o.d" -o ${OBJECTDIR}/_ext/1885022876/plib_wdt.o ../src/config/atsamd21g18a_default/peripheral/wdt/plib_wdt.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/9958233/xc32_monitor.o: ../src/config/atsamd21g18a_default/stdio/xc32_monitor.c  .generated_files/flags/atsamd21g18a_default/b3775e77735275ea173621f6940ed43cadee15d4 .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/9958233" 
	@${RM} ${OBJECTDIR}/_ext/9958233/xc32_monitor.o.d 
	@${RM} ${OBJECTDIR}/_ext/9958233/xc32_monitor.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/9958233/xc32_monitor.o.d" -o ${OBJECTDIR}/_ext/9958233/xc32_monitor.o ../src/config/atsamd21g18a_default/stdio/xc32_monitor.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/63538924/sys_int.o: ../src/config/atsamd21g18a_default/system/int/src/sys_int.c  .generated_files/flags/atsamd21g18a_default/b8b4d72d409b04d3a7924bdaa03a88c90e29b5f1 .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/63538924" 
	@${RM} ${OBJECTDIR}/_ext/63538924/sys_int.o.d 
	@${RM} ${OBJECTDIR}/_ext/63538924/sys_int.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/63538924/sys_int.o.d" -o ${OBJECTDIR}/_ext/63538924/sys_int.o ../src/config/atsamd21g18a_default/system/int/src/sys_int.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1572229207/usb_device.o: ../src/config/atsamd21g18a_default/usb/src/usb_device.c  .generated_files/flags/atsamd21g18a_default/d52b168f24605368f9559c42961af68a586eadd9 .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/1572229207" 
	@${RM} ${OBJECTDIR}/_ext/1572229207/usb_device.o.d 
	@${RM} ${OBJECTDIR}/_ext/1572229207/usb_device.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1572229207/usb_device.o.d" -o ${OBJECTDIR}/_ext/1572229207/usb_device.o ../src/config/atsamd21g18a_default/usb/src/usb_device.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1572229207/usb_device_cdc.o: ../src/config/atsamd21g18a_default/usb/src/usb_device_cdc.c  .generated_files/flags/atsamd21g18a_default/d9d6efe3f0668ff1d5483d3556dd0c82c70051c7 .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/1572229207" 
	@${RM} ${OBJECTDIR}/_ext/1572229207/usb_device_cdc.o.d 
	@${RM} ${OBJECTDIR}/_ext/1572229207/usb_device_cdc.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1572229207/usb_device_cdc.o.d" -o ${OBJECTDIR}/_ext/1572229207/usb_device_cdc.o ../src/config/atsamd21g18a_default/usb/src/usb_device_cdc.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1572229207/usb_device_cdc_acm.o: ../src/config/atsamd21g18a_default/usb/src/usb_device_cdc_acm.c  .generated_files/flags/atsamd21g18a_default/2f540cce830987e77bf9d11d9186f6a8a74a3322 .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/1572229207" 
	@${RM} ${OBJECTDIR}/_ext/1572229207/usb_device_cdc_acm.o.d 
	@${RM} ${OBJECTDIR}/_ext/1572229207/usb_device_cdc_acm.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1572229207/usb_device_cdc_acm.o.d" -o ${OBJECTDIR}/_ext/1572229207/usb_device_cdc_acm.o ../src/config/atsamd21g18a_default/usb/src/usb_device_cdc_acm.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1640317663/initialization.o: ../src/config/atsamd21g18a_default/initialization.c  .generated_files/flags/atsamd21g18a_default/4494b7606a2fcaf0da8442eda5e7277896632edb .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/1640317663" 
	@${RM} ${OBJECTDIR}/_ext/1640317663/initialization.o.d 
	@${RM} ${OBJECTDIR}/_ext/1640317663/initialization.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1640317663/initialization.o.d" -o ${OBJECTDIR}/_ext/1640317663/initialization.o ../src/config/atsamd21g18a_default/initialization.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1640317663/interrupts.o: ../src/config/atsamd21g18a_default/interrupts.c  .generated_files/flags/atsamd21g18a_default/726fef705811fdb23cad02dde2f72c294bf6311c .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/1640317663" 
	@${RM} ${OBJECTDIR}/_ext/1640317663/interrupts.o.d 
	@${RM} ${OBJECTDIR}/_ext/1640317663/interrupts.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1640317663/interrupts.o.d" -o ${OBJECTDIR}/_ext/1640317663/interrupts.o ../src/config/atsamd21g18a_default/interrupts.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1640317663/exceptions.o: ../src/config/atsamd21g18a_default/exceptions.c  .generated_files/flags/atsamd21g18a_default/ec9813072ad879cc3c6ef67d14be6e433550b797 .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/1640317663" 
	@${RM} ${OBJECTDIR}/_ext/1640317663/exceptions.o.d 
	@${RM} ${OBJECTDIR}/_ext/1640317663/exceptions.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1640317663/exceptions.o.d" -o ${OBJECTDIR}/_ext/1640317663/exceptions.o ../src/config/atsamd21g18a_default/exceptions.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1640317663/startup_xc32.o: ../src/config/atsamd21g18a_default/startup_xc32.c  .generated_files/flags/atsamd21g18a_default/7c68bca8c5300aa70440df10033e6c0d921d7c5f .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/1640317663" 
	@${RM} ${OBJECTDIR}/_ext/1640317663/startup_xc32.o.d 
	@${RM} ${OBJECTDIR}/_ext/1640317663/startup_xc32.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1640317663/startup_xc32.o.d" -o ${OBJECTDIR}/_ext/1640317663/startup_xc32.o ../src/config/atsamd21g18a_default/startup_xc32.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1640317663/libc_syscalls.o: ../src/config/atsamd21g18a_default/libc_syscalls.c  .generated_files/flags/atsamd21g18a_default/d13494d3104f2f92ca0b3effe14cfb98c1610bc5 .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/1640317663" 
	@${RM} ${OBJECTDIR}/_ext/1640317663/libc_syscalls.o.d 
	@${RM} ${OBJECTDIR}/_ext/1640317663/libc_syscalls.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1640317663/libc_syscalls.o.d" -o ${OBJECTDIR}/_ext/1640317663/libc_syscalls.o ../src/config/atsamd21g18a_default/libc_syscalls.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1640317663/usb_device_init_data.o: ../src/config/atsamd21g18a_default/usb_device_init_data.c  .generated_files/flags/atsamd21g18a_default/d0b85c76bacf0c90aed99c6ad5094708bd016cec .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/1640317663" 
	@${RM} ${OBJECTDIR}/_ext/1640317663/usb_device_init_data.o.d 
	@${RM} ${OBJECTDIR}/_ext/1640317663/usb_device_init_data.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1640317663/usb_device_init_data.o.d" -o ${OBJECTDIR}/_ext/1640317663/usb_device_init_data.o ../src/config/atsamd21g18a_default/usb_device_init_data.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1640317663/tasks.o: ../src/config/atsamd21g18a_default/tasks.c  .generated_files/flags/atsamd21g18a_default/62c464b2d8718a07ae91f5da9b4b9425723ff456 .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/1640317663" 
	@${RM} ${OBJECTDIR}/_ext/1640317663/tasks.o.d 
	@${RM} ${OBJECTDIR}/_ext/1640317663/tasks.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1640317663/tasks.o.d" -o ${OBJECTDIR}/_ext/1640317663/tasks.o ../src/config/atsamd21g18a_default/tasks.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/w25q128jv.o: ../src/w25q128jv.c  .generated_files/flags/atsamd21g18a_default/3714284bf3b1535fc46514f0edb216fea7d33d59 .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/w25q128jv.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/w25q128jv.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/w25q128jv.o.d" -o ${OBJECTDIR}/_ext/1360937237/w25q128jv.o ../src/w25q128jv.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/util.o: ../src/util.c  .generated_files/flags/atsamd21g18a_default/e888aceecbc569c7b2a41192bfa47f326040fb4f .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/util.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/util.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/util.o.d" -o ${OBJECTDIR}/_ext/1360937237/util.o ../src/util.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/s5851a.o: ../src/s5851a.c  .generated_files/flags/atsamd21g18a_default/6646f14e918a5e47c0da8ebe0734a5f54d4f261 .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/s5851a.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/s5851a.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/s5851a.o.d" -o ${OBJECTDIR}/_ext/1360937237/s5851a.o ../src/s5851a.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/gpioexp.o: ../src/gpioexp.c  .generated_files/flags/atsamd21g18a_default/52bb9f0ce718baf08ce34fbe517f1b42a27875c2 .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/gpioexp.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/gpioexp.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/gpioexp.o.d" -o ${OBJECTDIR}/_ext/1360937237/gpioexp.o ../src/gpioexp.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/rtc.o: ../src/rtc.c  .generated_files/flags/atsamd21g18a_default/12b35c0d5d55c679cf0e4f955a6d1b793eced7b6 .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/rtc.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/rtc.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/rtc.o.d" -o ${OBJECTDIR}/_ext/1360937237/rtc.o ../src/rtc.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/mlog.o: ../src/mlog.c  .generated_files/flags/atsamd21g18a_default/807070ef9fc06ef81cb06131b88d1228a148c7fd .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/mlog.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/mlog.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/mlog.o.d" -o ${OBJECTDIR}/_ext/1360937237/mlog.o ../src/mlog.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/sensor.o: ../src/sensor.c  .generated_files/flags/atsamd21g18a_default/fcdecbf31c24c63444e0f7c0ff189bc9775ee5b3 .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/sensor.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/sensor.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/sensor.o.d" -o ${OBJECTDIR}/_ext/1360937237/sensor.o ../src/sensor.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/uart_debug.o: ../src/uart_debug.c  .generated_files/flags/atsamd21g18a_default/3bd49b74e6b4ccc271881ee266fb5af159d2cf15 .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/uart_debug.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/uart_debug.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/uart_debug.o.d" -o ${OBJECTDIR}/_ext/1360937237/uart_debug.o ../src/uart_debug.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/uart_comm.o: ../src/uart_comm.c  .generated_files/flags/atsamd21g18a_default/ee60d0426b6e1a24a58f4aae57a3db09eaee3346 .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/uart_comm.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/uart_comm.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/uart_comm.o.d" -o ${OBJECTDIR}/_ext/1360937237/uart_comm.o ../src/uart_comm.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/wpfm.o: ../src/wpfm.c  .generated_files/flags/atsamd21g18a_default/a8ff9ee0ff53037b522310b08b0d5c924485e10e .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/wpfm.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/wpfm.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/wpfm.o.d" -o ${OBJECTDIR}/_ext/1360937237/wpfm.o ../src/wpfm.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/battery.o: ../src/battery.c  .generated_files/flags/atsamd21g18a_default/687ad135b1d3c1126b672ae7fd04ca0d1df70b63 .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/battery.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/battery.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/battery.o.d" -o ${OBJECTDIR}/_ext/1360937237/battery.o ../src/battery.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/communicate.o: ../src/communicate.c  .generated_files/flags/atsamd21g18a_default/299a7998315cfd6de111cf22be1cbb98c69b9d6 .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/communicate.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/communicate.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/communicate.o.d" -o ${OBJECTDIR}/_ext/1360937237/communicate.o ../src/communicate.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/init.o: ../src/init.c  .generated_files/flags/atsamd21g18a_default/b8298fa7b2f098e3a6fa3b917273eb5b97ad42ac .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/init.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/init.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/init.o.d" -o ${OBJECTDIR}/_ext/1360937237/init.o ../src/init.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/measure.o: ../src/measure.c  .generated_files/flags/atsamd21g18a_default/a378f468fe61782b428cc993c9099f639ed39f6f .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/measure.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/measure.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/measure.o.d" -o ${OBJECTDIR}/_ext/1360937237/measure.o ../src/measure.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/alert.o: ../src/alert.c  .generated_files/flags/atsamd21g18a_default/25ed3e4da3a6c77894f9ab12ef72aebed7a12b3 .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/alert.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/alert.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/alert.o.d" -o ${OBJECTDIR}/_ext/1360937237/alert.o ../src/alert.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/smpif4.o: ../src/smpif4.c  .generated_files/flags/atsamd21g18a_default/69dc38d3b61e22f65f2b44c49027e1bf4f4d9471 .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/smpif4.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/smpif4.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/smpif4.o.d" -o ${OBJECTDIR}/_ext/1360937237/smpif4.o ../src/smpif4.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/smpif.o: ../src/smpif.c  .generated_files/flags/atsamd21g18a_default/b79be513b7a0f9d75f4ae830dc4f12a2545ccbbb .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/smpif.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/smpif.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/smpif.o.d" -o ${OBJECTDIR}/_ext/1360937237/smpif.o ../src/smpif.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/smpif1.o: ../src/smpif1.c  .generated_files/flags/atsamd21g18a_default/2a554af09337365085c143903105c708562b49db .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/smpif1.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/smpif1.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/smpif1.o.d" -o ${OBJECTDIR}/_ext/1360937237/smpif1.o ../src/smpif1.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/smpif2.o: ../src/smpif2.c  .generated_files/flags/atsamd21g18a_default/ad542b2d7250f2632c8e2a2e92260d962f8ca2a0 .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/smpif2.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/smpif2.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/smpif2.o.d" -o ${OBJECTDIR}/_ext/1360937237/smpif2.o ../src/smpif2.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/smpif3.o: ../src/smpif3.c  .generated_files/flags/atsamd21g18a_default/604661c3c6c2d7e220cfaa84ea64574086b4cd1e .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/smpif3.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/smpif3.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/smpif3.o.d" -o ${OBJECTDIR}/_ext/1360937237/smpif3.o ../src/smpif3.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/main.o: ../src/main.c  .generated_files/flags/atsamd21g18a_default/80d9cfc9200b0665a2a2769cef5f6b4575e2f012 .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/main.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/main.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/main.o.d" -o ${OBJECTDIR}/_ext/1360937237/main.o ../src/main.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/app.o: ../src/app.c  .generated_files/flags/atsamd21g18a_default/af1d66325e405553af9ba6c0572b70093fc4b6c6 .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/app.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/app.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/app.o.d" -o ${OBJECTDIR}/_ext/1360937237/app.o ../src/app.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/MATcore.o: ../src/MATcore.c  .generated_files/flags/atsamd21g18a_default/71c3329a1d3296884be4b1c29bf645fa98e97523 .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/MATcore.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/MATcore.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/MATcore.o.d" -o ${OBJECTDIR}/_ext/1360937237/MATcore.o ../src/MATcore.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/moni.o: ../src/moni.c  .generated_files/flags/atsamd21g18a_default/e28c8f897101ec2e1fdcc8df727e16758dd903db .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/moni.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/moni.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/moni.o.d" -o ${OBJECTDIR}/_ext/1360937237/moni.o ../src/moni.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/version.o: ../src/version.c  .generated_files/flags/atsamd21g18a_default/116bb5f876c10983066b0fce9edca258a106089e .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/version.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/version.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/version.o.d" -o ${OBJECTDIR}/_ext/1360937237/version.o ../src/version.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/DLCpara.o: ../src/DLCpara.c  .generated_files/flags/atsamd21g18a_default/629784806a21285caa45ab5d608f4bcdb553bff0 .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/DLCpara.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/DLCpara.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/DLCpara.o.d" -o ${OBJECTDIR}/_ext/1360937237/DLCpara.o ../src/DLCpara.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/EventLog.o: ../src/EventLog.c  .generated_files/flags/atsamd21g18a_default/b320e500ae28f2a4e63a0cef16f6adbbc9bbc65c .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/EventLog.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/EventLog.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/EventLog.o.d" -o ${OBJECTDIR}/_ext/1360937237/EventLog.o ../src/EventLog.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/FOTAcmd.o: ../src/FOTAcmd.c  .generated_files/flags/atsamd21g18a_default/fc56ac9efb8604fbcbd0fa0c8d832228b3d731d5 .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/FOTAcmd.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/FOTAcmd.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/FOTAcmd.o.d" -o ${OBJECTDIR}/_ext/1360937237/FOTAcmd.o ../src/FOTAcmd.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
else
${OBJECTDIR}/_ext/1814754785/drv_usbfsv1.o: ../src/config/atsamd21g18a_default/driver/usb/usbfsv1/src/drv_usbfsv1.c  .generated_files/flags/atsamd21g18a_default/57dd46a3e3ba95c3faec6d25152c929bc444b4a1 .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/1814754785" 
	@${RM} ${OBJECTDIR}/_ext/1814754785/drv_usbfsv1.o.d 
	@${RM} ${OBJECTDIR}/_ext/1814754785/drv_usbfsv1.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1814754785/drv_usbfsv1.o.d" -o ${OBJECTDIR}/_ext/1814754785/drv_usbfsv1.o ../src/config/atsamd21g18a_default/driver/usb/usbfsv1/src/drv_usbfsv1.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1814754785/drv_usbfsv1_device.o: ../src/config/atsamd21g18a_default/driver/usb/usbfsv1/src/drv_usbfsv1_device.c  .generated_files/flags/atsamd21g18a_default/dda8b05c96e4c87a511275cf5cd57d27d4a5a22f .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/1814754785" 
	@${RM} ${OBJECTDIR}/_ext/1814754785/drv_usbfsv1_device.o.d 
	@${RM} ${OBJECTDIR}/_ext/1814754785/drv_usbfsv1_device.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1814754785/drv_usbfsv1_device.o.d" -o ${OBJECTDIR}/_ext/1814754785/drv_usbfsv1_device.o ../src/config/atsamd21g18a_default/driver/usb/usbfsv1/src/drv_usbfsv1_device.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1885044035/plib_adc.o: ../src/config/atsamd21g18a_default/peripheral/adc/plib_adc.c  .generated_files/flags/atsamd21g18a_default/326733f6ae54a5ccaf02dff085041f6aee36c396 .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/1885044035" 
	@${RM} ${OBJECTDIR}/_ext/1885044035/plib_adc.o.d 
	@${RM} ${OBJECTDIR}/_ext/1885044035/plib_adc.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1885044035/plib_adc.o.d" -o ${OBJECTDIR}/_ext/1885044035/plib_adc.o ../src/config/atsamd21g18a_default/peripheral/adc/plib_adc.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/950981355/plib_clock.o: ../src/config/atsamd21g18a_default/peripheral/clock/plib_clock.c  .generated_files/flags/atsamd21g18a_default/ee0d38de5455685fb4a74b4847151c2d3908ce95 .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/950981355" 
	@${RM} ${OBJECTDIR}/_ext/950981355/plib_clock.o.d 
	@${RM} ${OBJECTDIR}/_ext/950981355/plib_clock.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/950981355/plib_clock.o.d" -o ${OBJECTDIR}/_ext/950981355/plib_clock.o ../src/config/atsamd21g18a_default/peripheral/clock/plib_clock.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1885040036/plib_eic.o: ../src/config/atsamd21g18a_default/peripheral/eic/plib_eic.c  .generated_files/flags/atsamd21g18a_default/490342469c5801dc7fceffc132f083a91e556550 .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/1885040036" 
	@${RM} ${OBJECTDIR}/_ext/1885040036/plib_eic.o.d 
	@${RM} ${OBJECTDIR}/_ext/1885040036/plib_eic.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1885040036/plib_eic.o.d" -o ${OBJECTDIR}/_ext/1885040036/plib_eic.o ../src/config/atsamd21g18a_default/peripheral/eic/plib_eic.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/953130841/plib_evsys.o: ../src/config/atsamd21g18a_default/peripheral/evsys/plib_evsys.c  .generated_files/flags/atsamd21g18a_default/2b381f5b7bea77c0c592892b63be9857027389cb .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/953130841" 
	@${RM} ${OBJECTDIR}/_ext/953130841/plib_evsys.o.d 
	@${RM} ${OBJECTDIR}/_ext/953130841/plib_evsys.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/953130841/plib_evsys.o.d" -o ${OBJECTDIR}/_ext/953130841/plib_evsys.o ../src/config/atsamd21g18a_default/peripheral/evsys/plib_evsys.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1693581925/plib_nvic.o: ../src/config/atsamd21g18a_default/peripheral/nvic/plib_nvic.c  .generated_files/flags/atsamd21g18a_default/138616ee181f474f733fe72bab696e410ad5521f .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/1693581925" 
	@${RM} ${OBJECTDIR}/_ext/1693581925/plib_nvic.o.d 
	@${RM} ${OBJECTDIR}/_ext/1693581925/plib_nvic.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1693581925/plib_nvic.o.d" -o ${OBJECTDIR}/_ext/1693581925/plib_nvic.o ../src/config/atsamd21g18a_default/peripheral/nvic/plib_nvic.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/522110765/plib_nvmctrl.o: ../src/config/atsamd21g18a_default/peripheral/nvmctrl/plib_nvmctrl.c  .generated_files/flags/atsamd21g18a_default/ed94cf2a2a8069454830da7572ceb2ccdd13228f .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/522110765" 
	@${RM} ${OBJECTDIR}/_ext/522110765/plib_nvmctrl.o.d 
	@${RM} ${OBJECTDIR}/_ext/522110765/plib_nvmctrl.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/522110765/plib_nvmctrl.o.d" -o ${OBJECTDIR}/_ext/522110765/plib_nvmctrl.o ../src/config/atsamd21g18a_default/peripheral/nvmctrl/plib_nvmctrl.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1324665920/plib_pm.o: ../src/config/atsamd21g18a_default/peripheral/pm/plib_pm.c  .generated_files/flags/atsamd21g18a_default/e9a77fec0a1743484904b072c5eba466b31c42b4 .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/1324665920" 
	@${RM} ${OBJECTDIR}/_ext/1324665920/plib_pm.o.d 
	@${RM} ${OBJECTDIR}/_ext/1324665920/plib_pm.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1324665920/plib_pm.o.d" -o ${OBJECTDIR}/_ext/1324665920/plib_pm.o ../src/config/atsamd21g18a_default/peripheral/pm/plib_pm.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1693635076/plib_port.o: ../src/config/atsamd21g18a_default/peripheral/port/plib_port.c  .generated_files/flags/atsamd21g18a_default/40119b0da1b1df4e79c6e7aa016b3b4ef139761e .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/1693635076" 
	@${RM} ${OBJECTDIR}/_ext/1693635076/plib_port.o.d 
	@${RM} ${OBJECTDIR}/_ext/1693635076/plib_port.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1693635076/plib_port.o.d" -o ${OBJECTDIR}/_ext/1693635076/plib_port.o ../src/config/atsamd21g18a_default/peripheral/port/plib_port.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/163103410/plib_sercom3_i2c_master.o: ../src/config/atsamd21g18a_default/peripheral/sercom/i2c_master/plib_sercom3_i2c_master.c  .generated_files/flags/atsamd21g18a_default/3e2608c2b4108c6ddbf3cc39c51ead8b68c4e16d .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/163103410" 
	@${RM} ${OBJECTDIR}/_ext/163103410/plib_sercom3_i2c_master.o.d 
	@${RM} ${OBJECTDIR}/_ext/163103410/plib_sercom3_i2c_master.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/163103410/plib_sercom3_i2c_master.o.d" -o ${OBJECTDIR}/_ext/163103410/plib_sercom3_i2c_master.o ../src/config/atsamd21g18a_default/peripheral/sercom/i2c_master/plib_sercom3_i2c_master.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/328131232/plib_sercom1_spi_master.o: ../src/config/atsamd21g18a_default/peripheral/sercom/spi_master/plib_sercom1_spi_master.c  .generated_files/flags/atsamd21g18a_default/64aca01a145faf253c60a635f4c3276902a3cb5a .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/328131232" 
	@${RM} ${OBJECTDIR}/_ext/328131232/plib_sercom1_spi_master.o.d 
	@${RM} ${OBJECTDIR}/_ext/328131232/plib_sercom1_spi_master.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/328131232/plib_sercom1_spi_master.o.d" -o ${OBJECTDIR}/_ext/328131232/plib_sercom1_spi_master.o ../src/config/atsamd21g18a_default/peripheral/sercom/spi_master/plib_sercom1_spi_master.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/472979226/plib_sercom0_usart.o: ../src/config/atsamd21g18a_default/peripheral/sercom/usart/plib_sercom0_usart.c  .generated_files/flags/atsamd21g18a_default/f6441a0772a8aff7c8d88058c65065e281754ab .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/472979226" 
	@${RM} ${OBJECTDIR}/_ext/472979226/plib_sercom0_usart.o.d 
	@${RM} ${OBJECTDIR}/_ext/472979226/plib_sercom0_usart.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/472979226/plib_sercom0_usart.o.d" -o ${OBJECTDIR}/_ext/472979226/plib_sercom0_usart.o ../src/config/atsamd21g18a_default/peripheral/sercom/usart/plib_sercom0_usart.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/472979226/plib_sercom5_usart.o: ../src/config/atsamd21g18a_default/peripheral/sercom/usart/plib_sercom5_usart.c  .generated_files/flags/atsamd21g18a_default/9730dc6201d7b03aabae31761bc4228761fdb0ef .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/472979226" 
	@${RM} ${OBJECTDIR}/_ext/472979226/plib_sercom5_usart.o.d 
	@${RM} ${OBJECTDIR}/_ext/472979226/plib_sercom5_usart.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/472979226/plib_sercom5_usart.o.d" -o ${OBJECTDIR}/_ext/472979226/plib_sercom5_usart.o ../src/config/atsamd21g18a_default/peripheral/sercom/usart/plib_sercom5_usart.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/756585863/plib_systick.o: ../src/config/atsamd21g18a_default/peripheral/systick/plib_systick.c  .generated_files/flags/atsamd21g18a_default/b8a19e5fee98664156ed1da137d5af4ef619b6e6 .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/756585863" 
	@${RM} ${OBJECTDIR}/_ext/756585863/plib_systick.o.d 
	@${RM} ${OBJECTDIR}/_ext/756585863/plib_systick.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/756585863/plib_systick.o.d" -o ${OBJECTDIR}/_ext/756585863/plib_systick.o ../src/config/atsamd21g18a_default/peripheral/systick/plib_systick.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1324666034/plib_tc3.o: ../src/config/atsamd21g18a_default/peripheral/tc/plib_tc3.c  .generated_files/flags/atsamd21g18a_default/6f2e6762ca3397881fa804471f4c526157d693d3 .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/1324666034" 
	@${RM} ${OBJECTDIR}/_ext/1324666034/plib_tc3.o.d 
	@${RM} ${OBJECTDIR}/_ext/1324666034/plib_tc3.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1324666034/plib_tc3.o.d" -o ${OBJECTDIR}/_ext/1324666034/plib_tc3.o ../src/config/atsamd21g18a_default/peripheral/tc/plib_tc3.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1324666034/plib_tc4.o: ../src/config/atsamd21g18a_default/peripheral/tc/plib_tc4.c  .generated_files/flags/atsamd21g18a_default/520083dc5860adcd69372b30da3f242fb93590c7 .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/1324666034" 
	@${RM} ${OBJECTDIR}/_ext/1324666034/plib_tc4.o.d 
	@${RM} ${OBJECTDIR}/_ext/1324666034/plib_tc4.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1324666034/plib_tc4.o.d" -o ${OBJECTDIR}/_ext/1324666034/plib_tc4.o ../src/config/atsamd21g18a_default/peripheral/tc/plib_tc4.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1324666034/plib_tc5.o: ../src/config/atsamd21g18a_default/peripheral/tc/plib_tc5.c  .generated_files/flags/atsamd21g18a_default/95e680b60a6178ee483ff2ce593869c6ce85d248 .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/1324666034" 
	@${RM} ${OBJECTDIR}/_ext/1324666034/plib_tc5.o.d 
	@${RM} ${OBJECTDIR}/_ext/1324666034/plib_tc5.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1324666034/plib_tc5.o.d" -o ${OBJECTDIR}/_ext/1324666034/plib_tc5.o ../src/config/atsamd21g18a_default/peripheral/tc/plib_tc5.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1885022876/plib_wdt.o: ../src/config/atsamd21g18a_default/peripheral/wdt/plib_wdt.c  .generated_files/flags/atsamd21g18a_default/7a8daad76bd93066858f0545c71836ce1af80c81 .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/1885022876" 
	@${RM} ${OBJECTDIR}/_ext/1885022876/plib_wdt.o.d 
	@${RM} ${OBJECTDIR}/_ext/1885022876/plib_wdt.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1885022876/plib_wdt.o.d" -o ${OBJECTDIR}/_ext/1885022876/plib_wdt.o ../src/config/atsamd21g18a_default/peripheral/wdt/plib_wdt.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/9958233/xc32_monitor.o: ../src/config/atsamd21g18a_default/stdio/xc32_monitor.c  .generated_files/flags/atsamd21g18a_default/f9720755cccd796818441e384b9cf5a411ff6d11 .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/9958233" 
	@${RM} ${OBJECTDIR}/_ext/9958233/xc32_monitor.o.d 
	@${RM} ${OBJECTDIR}/_ext/9958233/xc32_monitor.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/9958233/xc32_monitor.o.d" -o ${OBJECTDIR}/_ext/9958233/xc32_monitor.o ../src/config/atsamd21g18a_default/stdio/xc32_monitor.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/63538924/sys_int.o: ../src/config/atsamd21g18a_default/system/int/src/sys_int.c  .generated_files/flags/atsamd21g18a_default/98a1eca3e8a37b0b8b9125a178723a2830e0fdae .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/63538924" 
	@${RM} ${OBJECTDIR}/_ext/63538924/sys_int.o.d 
	@${RM} ${OBJECTDIR}/_ext/63538924/sys_int.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/63538924/sys_int.o.d" -o ${OBJECTDIR}/_ext/63538924/sys_int.o ../src/config/atsamd21g18a_default/system/int/src/sys_int.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1572229207/usb_device.o: ../src/config/atsamd21g18a_default/usb/src/usb_device.c  .generated_files/flags/atsamd21g18a_default/b0a4d47aa13a297bba1b79f9f965156c13b785f .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/1572229207" 
	@${RM} ${OBJECTDIR}/_ext/1572229207/usb_device.o.d 
	@${RM} ${OBJECTDIR}/_ext/1572229207/usb_device.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1572229207/usb_device.o.d" -o ${OBJECTDIR}/_ext/1572229207/usb_device.o ../src/config/atsamd21g18a_default/usb/src/usb_device.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1572229207/usb_device_cdc.o: ../src/config/atsamd21g18a_default/usb/src/usb_device_cdc.c  .generated_files/flags/atsamd21g18a_default/c2a10a67aa6690b9cc4cbac134c0429dd3aea987 .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/1572229207" 
	@${RM} ${OBJECTDIR}/_ext/1572229207/usb_device_cdc.o.d 
	@${RM} ${OBJECTDIR}/_ext/1572229207/usb_device_cdc.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1572229207/usb_device_cdc.o.d" -o ${OBJECTDIR}/_ext/1572229207/usb_device_cdc.o ../src/config/atsamd21g18a_default/usb/src/usb_device_cdc.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1572229207/usb_device_cdc_acm.o: ../src/config/atsamd21g18a_default/usb/src/usb_device_cdc_acm.c  .generated_files/flags/atsamd21g18a_default/a8ab4b7bc82f4eb58295922fb8acce2e311a51ed .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/1572229207" 
	@${RM} ${OBJECTDIR}/_ext/1572229207/usb_device_cdc_acm.o.d 
	@${RM} ${OBJECTDIR}/_ext/1572229207/usb_device_cdc_acm.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1572229207/usb_device_cdc_acm.o.d" -o ${OBJECTDIR}/_ext/1572229207/usb_device_cdc_acm.o ../src/config/atsamd21g18a_default/usb/src/usb_device_cdc_acm.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1640317663/initialization.o: ../src/config/atsamd21g18a_default/initialization.c  .generated_files/flags/atsamd21g18a_default/a70702c5aba9cded629593d3d98a5d6785b66803 .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/1640317663" 
	@${RM} ${OBJECTDIR}/_ext/1640317663/initialization.o.d 
	@${RM} ${OBJECTDIR}/_ext/1640317663/initialization.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1640317663/initialization.o.d" -o ${OBJECTDIR}/_ext/1640317663/initialization.o ../src/config/atsamd21g18a_default/initialization.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1640317663/interrupts.o: ../src/config/atsamd21g18a_default/interrupts.c  .generated_files/flags/atsamd21g18a_default/f604559743535961f50a1495ade28e42352a98d2 .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/1640317663" 
	@${RM} ${OBJECTDIR}/_ext/1640317663/interrupts.o.d 
	@${RM} ${OBJECTDIR}/_ext/1640317663/interrupts.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1640317663/interrupts.o.d" -o ${OBJECTDIR}/_ext/1640317663/interrupts.o ../src/config/atsamd21g18a_default/interrupts.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1640317663/exceptions.o: ../src/config/atsamd21g18a_default/exceptions.c  .generated_files/flags/atsamd21g18a_default/1f5207951d968ddfcf367eee6a8115f783de0710 .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/1640317663" 
	@${RM} ${OBJECTDIR}/_ext/1640317663/exceptions.o.d 
	@${RM} ${OBJECTDIR}/_ext/1640317663/exceptions.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1640317663/exceptions.o.d" -o ${OBJECTDIR}/_ext/1640317663/exceptions.o ../src/config/atsamd21g18a_default/exceptions.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1640317663/startup_xc32.o: ../src/config/atsamd21g18a_default/startup_xc32.c  .generated_files/flags/atsamd21g18a_default/dc2c8dc5d18e60000caa2a23a402647e8bd7b4e2 .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/1640317663" 
	@${RM} ${OBJECTDIR}/_ext/1640317663/startup_xc32.o.d 
	@${RM} ${OBJECTDIR}/_ext/1640317663/startup_xc32.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1640317663/startup_xc32.o.d" -o ${OBJECTDIR}/_ext/1640317663/startup_xc32.o ../src/config/atsamd21g18a_default/startup_xc32.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1640317663/libc_syscalls.o: ../src/config/atsamd21g18a_default/libc_syscalls.c  .generated_files/flags/atsamd21g18a_default/65834678e6c82d991b8f3266665d4e198deb643e .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/1640317663" 
	@${RM} ${OBJECTDIR}/_ext/1640317663/libc_syscalls.o.d 
	@${RM} ${OBJECTDIR}/_ext/1640317663/libc_syscalls.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1640317663/libc_syscalls.o.d" -o ${OBJECTDIR}/_ext/1640317663/libc_syscalls.o ../src/config/atsamd21g18a_default/libc_syscalls.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1640317663/usb_device_init_data.o: ../src/config/atsamd21g18a_default/usb_device_init_data.c  .generated_files/flags/atsamd21g18a_default/f9b47703bc044583ad63e79d7d2e7024caa16dc0 .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/1640317663" 
	@${RM} ${OBJECTDIR}/_ext/1640317663/usb_device_init_data.o.d 
	@${RM} ${OBJECTDIR}/_ext/1640317663/usb_device_init_data.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1640317663/usb_device_init_data.o.d" -o ${OBJECTDIR}/_ext/1640317663/usb_device_init_data.o ../src/config/atsamd21g18a_default/usb_device_init_data.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1640317663/tasks.o: ../src/config/atsamd21g18a_default/tasks.c  .generated_files/flags/atsamd21g18a_default/b3c9023e533218cedd0341e7a5a5a74fb7bcc701 .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/1640317663" 
	@${RM} ${OBJECTDIR}/_ext/1640317663/tasks.o.d 
	@${RM} ${OBJECTDIR}/_ext/1640317663/tasks.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1640317663/tasks.o.d" -o ${OBJECTDIR}/_ext/1640317663/tasks.o ../src/config/atsamd21g18a_default/tasks.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/w25q128jv.o: ../src/w25q128jv.c  .generated_files/flags/atsamd21g18a_default/3b76897c73933fbef9172baa12f451c4d86b3e2a .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/w25q128jv.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/w25q128jv.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/w25q128jv.o.d" -o ${OBJECTDIR}/_ext/1360937237/w25q128jv.o ../src/w25q128jv.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/util.o: ../src/util.c  .generated_files/flags/atsamd21g18a_default/1b6b9e504e0aec9a9eec8ea0be449794a4c17cde .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/util.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/util.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/util.o.d" -o ${OBJECTDIR}/_ext/1360937237/util.o ../src/util.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/s5851a.o: ../src/s5851a.c  .generated_files/flags/atsamd21g18a_default/d18a879379ecef4e2fbe7a406c5cbdca6a82de14 .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/s5851a.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/s5851a.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/s5851a.o.d" -o ${OBJECTDIR}/_ext/1360937237/s5851a.o ../src/s5851a.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/gpioexp.o: ../src/gpioexp.c  .generated_files/flags/atsamd21g18a_default/1e267f850e2059ceee0e8ef4b38d5b45000c9f3e .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/gpioexp.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/gpioexp.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/gpioexp.o.d" -o ${OBJECTDIR}/_ext/1360937237/gpioexp.o ../src/gpioexp.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/rtc.o: ../src/rtc.c  .generated_files/flags/atsamd21g18a_default/bfae9244cc8551020aa25a5e3ce4e09cec30f3a5 .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/rtc.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/rtc.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/rtc.o.d" -o ${OBJECTDIR}/_ext/1360937237/rtc.o ../src/rtc.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/mlog.o: ../src/mlog.c  .generated_files/flags/atsamd21g18a_default/26a851637d1b20a1784552e4a9e16dc20d8dad8c .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/mlog.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/mlog.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/mlog.o.d" -o ${OBJECTDIR}/_ext/1360937237/mlog.o ../src/mlog.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/sensor.o: ../src/sensor.c  .generated_files/flags/atsamd21g18a_default/9cf9c381775e6f4faca0ccc2146594bbd4aa6579 .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/sensor.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/sensor.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/sensor.o.d" -o ${OBJECTDIR}/_ext/1360937237/sensor.o ../src/sensor.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/uart_debug.o: ../src/uart_debug.c  .generated_files/flags/atsamd21g18a_default/d2f8f7c5db23416b590636b02be7776fc16728e4 .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/uart_debug.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/uart_debug.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/uart_debug.o.d" -o ${OBJECTDIR}/_ext/1360937237/uart_debug.o ../src/uart_debug.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/uart_comm.o: ../src/uart_comm.c  .generated_files/flags/atsamd21g18a_default/917e6da0912d1e98ee6b73004501eb5c1489733b .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/uart_comm.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/uart_comm.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/uart_comm.o.d" -o ${OBJECTDIR}/_ext/1360937237/uart_comm.o ../src/uart_comm.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/wpfm.o: ../src/wpfm.c  .generated_files/flags/atsamd21g18a_default/e4fe43c6ad2c0e2505c8fed37571a8ec04f93d36 .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/wpfm.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/wpfm.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/wpfm.o.d" -o ${OBJECTDIR}/_ext/1360937237/wpfm.o ../src/wpfm.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/battery.o: ../src/battery.c  .generated_files/flags/atsamd21g18a_default/69ddfd037654d12192abc7cea8536243f6ce471f .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/battery.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/battery.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/battery.o.d" -o ${OBJECTDIR}/_ext/1360937237/battery.o ../src/battery.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/communicate.o: ../src/communicate.c  .generated_files/flags/atsamd21g18a_default/1cd2640340619b27b73ee6b2e7b07c59f0c79e29 .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/communicate.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/communicate.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/communicate.o.d" -o ${OBJECTDIR}/_ext/1360937237/communicate.o ../src/communicate.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/init.o: ../src/init.c  .generated_files/flags/atsamd21g18a_default/8762f7bb6f57f9ebeabdd0e1ee95e920fb972a4c .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/init.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/init.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/init.o.d" -o ${OBJECTDIR}/_ext/1360937237/init.o ../src/init.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/measure.o: ../src/measure.c  .generated_files/flags/atsamd21g18a_default/ac9871cadb17e209b515d816ccc1e46dd0c54740 .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/measure.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/measure.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/measure.o.d" -o ${OBJECTDIR}/_ext/1360937237/measure.o ../src/measure.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/alert.o: ../src/alert.c  .generated_files/flags/atsamd21g18a_default/9c7fe64b3edad260545ef2ed39204e6422e7e7f2 .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/alert.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/alert.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/alert.o.d" -o ${OBJECTDIR}/_ext/1360937237/alert.o ../src/alert.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/smpif4.o: ../src/smpif4.c  .generated_files/flags/atsamd21g18a_default/f3f527d9f95579d93f9cf2930b32b2daea46456d .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/smpif4.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/smpif4.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/smpif4.o.d" -o ${OBJECTDIR}/_ext/1360937237/smpif4.o ../src/smpif4.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/smpif.o: ../src/smpif.c  .generated_files/flags/atsamd21g18a_default/35b28877a426f6dafb70d7c95af75beacd74c445 .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/smpif.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/smpif.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/smpif.o.d" -o ${OBJECTDIR}/_ext/1360937237/smpif.o ../src/smpif.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/smpif1.o: ../src/smpif1.c  .generated_files/flags/atsamd21g18a_default/f066dc492411fe0309dd7f0d7545b8b87c70f161 .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/smpif1.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/smpif1.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/smpif1.o.d" -o ${OBJECTDIR}/_ext/1360937237/smpif1.o ../src/smpif1.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/smpif2.o: ../src/smpif2.c  .generated_files/flags/atsamd21g18a_default/8193f2c71df7f258903fc5d8475d291c85483b26 .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/smpif2.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/smpif2.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/smpif2.o.d" -o ${OBJECTDIR}/_ext/1360937237/smpif2.o ../src/smpif2.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/smpif3.o: ../src/smpif3.c  .generated_files/flags/atsamd21g18a_default/4440995e981c6e6ace8d0356377977bcfe3e6405 .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/smpif3.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/smpif3.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/smpif3.o.d" -o ${OBJECTDIR}/_ext/1360937237/smpif3.o ../src/smpif3.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/main.o: ../src/main.c  .generated_files/flags/atsamd21g18a_default/80020b144a895a87d76db5157843bda13045c51e .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/main.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/main.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/main.o.d" -o ${OBJECTDIR}/_ext/1360937237/main.o ../src/main.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/app.o: ../src/app.c  .generated_files/flags/atsamd21g18a_default/88d62318d28947a3b12aaad41c280a7833cd8035 .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/app.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/app.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/app.o.d" -o ${OBJECTDIR}/_ext/1360937237/app.o ../src/app.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/MATcore.o: ../src/MATcore.c  .generated_files/flags/atsamd21g18a_default/f21477e7d6a6cf4fa11f0071a5182ee5c9a6d5b .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/MATcore.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/MATcore.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/MATcore.o.d" -o ${OBJECTDIR}/_ext/1360937237/MATcore.o ../src/MATcore.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/moni.o: ../src/moni.c  .generated_files/flags/atsamd21g18a_default/f292eeacf5c94987885bafd47db1a8751064ae65 .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/moni.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/moni.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/moni.o.d" -o ${OBJECTDIR}/_ext/1360937237/moni.o ../src/moni.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/version.o: ../src/version.c  .generated_files/flags/atsamd21g18a_default/617d60bfa822c894cce9f9f7f8452c3025e8ddc3 .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/version.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/version.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/version.o.d" -o ${OBJECTDIR}/_ext/1360937237/version.o ../src/version.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/DLCpara.o: ../src/DLCpara.c  .generated_files/flags/atsamd21g18a_default/c742fa9d12e6d6e84d5ea9075cb8c4510a466bcf .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/DLCpara.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/DLCpara.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/DLCpara.o.d" -o ${OBJECTDIR}/_ext/1360937237/DLCpara.o ../src/DLCpara.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/EventLog.o: ../src/EventLog.c  .generated_files/flags/atsamd21g18a_default/488882d8cf0e2890bead3194cdcc9d52404a1d0b .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/EventLog.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/EventLog.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/EventLog.o.d" -o ${OBJECTDIR}/_ext/1360937237/EventLog.o ../src/EventLog.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/FOTAcmd.o: ../src/FOTAcmd.c  .generated_files/flags/atsamd21g18a_default/5a1645bb1140af14c4561e2808cbdb122e66fe68 .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/FOTAcmd.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/FOTAcmd.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/FOTAcmd.o.d" -o ${OBJECTDIR}/_ext/1360937237/FOTAcmd.o ../src/FOTAcmd.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
endif

# ------------------------------------------------------------------------------------
# Rules for buildStep: compileCPP
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
else
endif

# ------------------------------------------------------------------------------------
# Rules for buildStep: link
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
${DISTDIR}/DLC00.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}: ${OBJECTFILES}  nbproject/Makefile-${CND_CONF}.mk    ../src/config/atsamd21g18a_default/ATSAMD21G18A.ld
	@${MKDIR} ${DISTDIR} 
	${MP_CC} $(MP_EXTRA_LD_PRE) -g   -mprocessor=$(MP_PROCESSOR_OPTION) -mno-device-startup-code -o ${DISTDIR}/DLC00.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX} ${OBJECTFILES_QUOTED_IF_SPACED}          -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -Wl,--defsym=__MPLAB_BUILD=1$(MP_EXTRA_LD_POST)$(MP_LINKER_FILE_OPTION),--defsym=__ICD2RAM=1,--defsym=__MPLAB_DEBUG=1,--defsym=__DEBUG=1,-D=__DEBUG_D,--defsym=_min_heap_size=512,--gc-sections,-Map="${DISTDIR}/${PROJECTNAME}.${IMAGE_TYPE}.map",--memorysummary,${DISTDIR}/memoryfile.xml -mdfp="${DFP_DIR}/samd21a"
	
else
${DISTDIR}/DLC00.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}: ${OBJECTFILES}  nbproject/Makefile-${CND_CONF}.mk   ../src/config/atsamd21g18a_default/ATSAMD21G18A.ld
	@${MKDIR} ${DISTDIR} 
	${MP_CC} $(MP_EXTRA_LD_PRE)  -mprocessor=$(MP_PROCESSOR_OPTION) -mno-device-startup-code -o ${DISTDIR}/DLC00.X.${IMAGE_TYPE}.${DEBUGGABLE_SUFFIX} ${OBJECTFILES_QUOTED_IF_SPACED}          -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -Wl,--defsym=__MPLAB_BUILD=1$(MP_EXTRA_LD_POST)$(MP_LINKER_FILE_OPTION),--defsym=_min_heap_size=512,--gc-sections,-Map="${DISTDIR}/${PROJECTNAME}.${IMAGE_TYPE}.map",--memorysummary,${DISTDIR}/memoryfile.xml -mdfp="${DFP_DIR}/samd21a"
	${MP_CC_DIR}\\xc32-bin2hex ${DISTDIR}/DLC00.X.${IMAGE_TYPE}.${DEBUGGABLE_SUFFIX} 
	@echo Normalizing hex file
	@"C:/Program Files/Microchip/MPLABX/v6.00/mplab_platform/platform/../mplab_ide/modules/../../bin/hexmate" --edf="C:/Program Files/Microchip/MPLABX/v6.00/mplab_platform/platform/../mplab_ide/modules/../../dat/en_msgs.txt" ${DISTDIR}/DLC00.X.${IMAGE_TYPE}.hex -o${DISTDIR}/DLC00.X.${IMAGE_TYPE}.hex

endif

.pre:
	@echo "--------------------------------------"
	@echo "User defined pre-build step: [touch ..\src\version.c]"
	@touch ..\src\version.c
	@echo "--------------------------------------"

# Subprojects
.build-subprojects:


# Subprojects
.clean-subprojects:

# Clean Targets
.clean-conf: ${CLEAN_SUBPROJECTS}
	${RM} -r ${OBJECTDIR}
	${RM} -r ${DISTDIR}

# Enable dependency checking
.dep.inc: .depcheck-impl

DEPFILES=$(shell mplabwildcard ${POSSIBLE_DEPFILES})
ifneq (${DEPFILES},)
include ${DEPFILES}
endif
