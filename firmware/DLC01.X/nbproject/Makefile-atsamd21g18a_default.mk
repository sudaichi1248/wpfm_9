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
FINAL_IMAGE=${DISTDIR}/DLC01.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}
else
IMAGE_TYPE=production
OUTPUT_SUFFIX=hex
DEBUGGABLE_SUFFIX=elf
FINAL_IMAGE=${DISTDIR}/DLC01.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}
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
ProjectDir="D:\FCOM\DLC01\firmware\DLC01.X"
ProjectName=DLC01
ConfName=atsamd21g18a_default
ImagePath="${DISTDIR}\DLC01.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}"
ImageDir="${DISTDIR}"
ImageName="DLC01.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}"
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
IsDebug="true"
else
IsDebug="false"
endif

.build-conf:  .pre ${BUILD_SUBPROJECTS}
ifneq ($(INFORMATION_MESSAGE), )
	@echo $(INFORMATION_MESSAGE)
endif
	${MAKE}  -f nbproject/Makefile-atsamd21g18a_default.mk ${DISTDIR}/DLC01.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}
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
${OBJECTDIR}/_ext/1814754785/drv_usbfsv1.o: ../src/config/atsamd21g18a_default/driver/usb/usbfsv1/src/drv_usbfsv1.c  .generated_files/flags/atsamd21g18a_default/3411392a450c7851892e521a527830cbcf02382a .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/1814754785" 
	@${RM} ${OBJECTDIR}/_ext/1814754785/drv_usbfsv1.o.d 
	@${RM} ${OBJECTDIR}/_ext/1814754785/drv_usbfsv1.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1814754785/drv_usbfsv1.o.d" -o ${OBJECTDIR}/_ext/1814754785/drv_usbfsv1.o ../src/config/atsamd21g18a_default/driver/usb/usbfsv1/src/drv_usbfsv1.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1814754785/drv_usbfsv1_device.o: ../src/config/atsamd21g18a_default/driver/usb/usbfsv1/src/drv_usbfsv1_device.c  .generated_files/flags/atsamd21g18a_default/d80c14d2c6e53e3c66cc006d8bb7f18c6760e8f5 .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/1814754785" 
	@${RM} ${OBJECTDIR}/_ext/1814754785/drv_usbfsv1_device.o.d 
	@${RM} ${OBJECTDIR}/_ext/1814754785/drv_usbfsv1_device.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1814754785/drv_usbfsv1_device.o.d" -o ${OBJECTDIR}/_ext/1814754785/drv_usbfsv1_device.o ../src/config/atsamd21g18a_default/driver/usb/usbfsv1/src/drv_usbfsv1_device.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1885044035/plib_adc.o: ../src/config/atsamd21g18a_default/peripheral/adc/plib_adc.c  .generated_files/flags/atsamd21g18a_default/fba73827d7bfaac1395990d29afff53f40b91ae1 .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/1885044035" 
	@${RM} ${OBJECTDIR}/_ext/1885044035/plib_adc.o.d 
	@${RM} ${OBJECTDIR}/_ext/1885044035/plib_adc.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1885044035/plib_adc.o.d" -o ${OBJECTDIR}/_ext/1885044035/plib_adc.o ../src/config/atsamd21g18a_default/peripheral/adc/plib_adc.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/950981355/plib_clock.o: ../src/config/atsamd21g18a_default/peripheral/clock/plib_clock.c  .generated_files/flags/atsamd21g18a_default/a82c88120602c2d13d94046d5b6f172f956ca14a .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/950981355" 
	@${RM} ${OBJECTDIR}/_ext/950981355/plib_clock.o.d 
	@${RM} ${OBJECTDIR}/_ext/950981355/plib_clock.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/950981355/plib_clock.o.d" -o ${OBJECTDIR}/_ext/950981355/plib_clock.o ../src/config/atsamd21g18a_default/peripheral/clock/plib_clock.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1885040036/plib_eic.o: ../src/config/atsamd21g18a_default/peripheral/eic/plib_eic.c  .generated_files/flags/atsamd21g18a_default/b31d2a29a5a6d6d2c96953e568f998cd29086c49 .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/1885040036" 
	@${RM} ${OBJECTDIR}/_ext/1885040036/plib_eic.o.d 
	@${RM} ${OBJECTDIR}/_ext/1885040036/plib_eic.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1885040036/plib_eic.o.d" -o ${OBJECTDIR}/_ext/1885040036/plib_eic.o ../src/config/atsamd21g18a_default/peripheral/eic/plib_eic.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/953130841/plib_evsys.o: ../src/config/atsamd21g18a_default/peripheral/evsys/plib_evsys.c  .generated_files/flags/atsamd21g18a_default/48b53906838224162a840136a878907aa3956bc7 .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/953130841" 
	@${RM} ${OBJECTDIR}/_ext/953130841/plib_evsys.o.d 
	@${RM} ${OBJECTDIR}/_ext/953130841/plib_evsys.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/953130841/plib_evsys.o.d" -o ${OBJECTDIR}/_ext/953130841/plib_evsys.o ../src/config/atsamd21g18a_default/peripheral/evsys/plib_evsys.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1693581925/plib_nvic.o: ../src/config/atsamd21g18a_default/peripheral/nvic/plib_nvic.c  .generated_files/flags/atsamd21g18a_default/bd956a50f64660acfc053c4077a113813d214f90 .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/1693581925" 
	@${RM} ${OBJECTDIR}/_ext/1693581925/plib_nvic.o.d 
	@${RM} ${OBJECTDIR}/_ext/1693581925/plib_nvic.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1693581925/plib_nvic.o.d" -o ${OBJECTDIR}/_ext/1693581925/plib_nvic.o ../src/config/atsamd21g18a_default/peripheral/nvic/plib_nvic.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/522110765/plib_nvmctrl.o: ../src/config/atsamd21g18a_default/peripheral/nvmctrl/plib_nvmctrl.c  .generated_files/flags/atsamd21g18a_default/8405e189923fc779583f0e9154d43e9e8ab6e302 .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/522110765" 
	@${RM} ${OBJECTDIR}/_ext/522110765/plib_nvmctrl.o.d 
	@${RM} ${OBJECTDIR}/_ext/522110765/plib_nvmctrl.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/522110765/plib_nvmctrl.o.d" -o ${OBJECTDIR}/_ext/522110765/plib_nvmctrl.o ../src/config/atsamd21g18a_default/peripheral/nvmctrl/plib_nvmctrl.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1324665920/plib_pm.o: ../src/config/atsamd21g18a_default/peripheral/pm/plib_pm.c  .generated_files/flags/atsamd21g18a_default/d82e5769e6a8882f14a019189276585bc82e9ed7 .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/1324665920" 
	@${RM} ${OBJECTDIR}/_ext/1324665920/plib_pm.o.d 
	@${RM} ${OBJECTDIR}/_ext/1324665920/plib_pm.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1324665920/plib_pm.o.d" -o ${OBJECTDIR}/_ext/1324665920/plib_pm.o ../src/config/atsamd21g18a_default/peripheral/pm/plib_pm.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1693635076/plib_port.o: ../src/config/atsamd21g18a_default/peripheral/port/plib_port.c  .generated_files/flags/atsamd21g18a_default/5f03d716a84032d9a93db91edbfad07358416ed4 .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/1693635076" 
	@${RM} ${OBJECTDIR}/_ext/1693635076/plib_port.o.d 
	@${RM} ${OBJECTDIR}/_ext/1693635076/plib_port.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1693635076/plib_port.o.d" -o ${OBJECTDIR}/_ext/1693635076/plib_port.o ../src/config/atsamd21g18a_default/peripheral/port/plib_port.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/163103410/plib_sercom3_i2c_master.o: ../src/config/atsamd21g18a_default/peripheral/sercom/i2c_master/plib_sercom3_i2c_master.c  .generated_files/flags/atsamd21g18a_default/6b070334164db52c69bde958ace694becc20cc59 .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/163103410" 
	@${RM} ${OBJECTDIR}/_ext/163103410/plib_sercom3_i2c_master.o.d 
	@${RM} ${OBJECTDIR}/_ext/163103410/plib_sercom3_i2c_master.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/163103410/plib_sercom3_i2c_master.o.d" -o ${OBJECTDIR}/_ext/163103410/plib_sercom3_i2c_master.o ../src/config/atsamd21g18a_default/peripheral/sercom/i2c_master/plib_sercom3_i2c_master.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/328131232/plib_sercom1_spi_master.o: ../src/config/atsamd21g18a_default/peripheral/sercom/spi_master/plib_sercom1_spi_master.c  .generated_files/flags/atsamd21g18a_default/17b2eeee7084b03d792763d06f960e400adfe223 .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/328131232" 
	@${RM} ${OBJECTDIR}/_ext/328131232/plib_sercom1_spi_master.o.d 
	@${RM} ${OBJECTDIR}/_ext/328131232/plib_sercom1_spi_master.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/328131232/plib_sercom1_spi_master.o.d" -o ${OBJECTDIR}/_ext/328131232/plib_sercom1_spi_master.o ../src/config/atsamd21g18a_default/peripheral/sercom/spi_master/plib_sercom1_spi_master.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/472979226/plib_sercom0_usart.o: ../src/config/atsamd21g18a_default/peripheral/sercom/usart/plib_sercom0_usart.c  .generated_files/flags/atsamd21g18a_default/9ed6babb6c7e6058da291b77e9e568a269b5256d .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/472979226" 
	@${RM} ${OBJECTDIR}/_ext/472979226/plib_sercom0_usart.o.d 
	@${RM} ${OBJECTDIR}/_ext/472979226/plib_sercom0_usart.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/472979226/plib_sercom0_usart.o.d" -o ${OBJECTDIR}/_ext/472979226/plib_sercom0_usart.o ../src/config/atsamd21g18a_default/peripheral/sercom/usart/plib_sercom0_usart.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/472979226/plib_sercom5_usart.o: ../src/config/atsamd21g18a_default/peripheral/sercom/usart/plib_sercom5_usart.c  .generated_files/flags/atsamd21g18a_default/ac4977d6b779351c8ae8ed8ab598753eede7b476 .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/472979226" 
	@${RM} ${OBJECTDIR}/_ext/472979226/plib_sercom5_usart.o.d 
	@${RM} ${OBJECTDIR}/_ext/472979226/plib_sercom5_usart.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/472979226/plib_sercom5_usart.o.d" -o ${OBJECTDIR}/_ext/472979226/plib_sercom5_usart.o ../src/config/atsamd21g18a_default/peripheral/sercom/usart/plib_sercom5_usart.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/756585863/plib_systick.o: ../src/config/atsamd21g18a_default/peripheral/systick/plib_systick.c  .generated_files/flags/atsamd21g18a_default/66e915e77087fa91eaa0c98771754a24ba42f1ff .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/756585863" 
	@${RM} ${OBJECTDIR}/_ext/756585863/plib_systick.o.d 
	@${RM} ${OBJECTDIR}/_ext/756585863/plib_systick.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/756585863/plib_systick.o.d" -o ${OBJECTDIR}/_ext/756585863/plib_systick.o ../src/config/atsamd21g18a_default/peripheral/systick/plib_systick.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1324666034/plib_tc3.o: ../src/config/atsamd21g18a_default/peripheral/tc/plib_tc3.c  .generated_files/flags/atsamd21g18a_default/88542b04892d7335d75a3c3a5b96d4978afc3846 .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/1324666034" 
	@${RM} ${OBJECTDIR}/_ext/1324666034/plib_tc3.o.d 
	@${RM} ${OBJECTDIR}/_ext/1324666034/plib_tc3.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1324666034/plib_tc3.o.d" -o ${OBJECTDIR}/_ext/1324666034/plib_tc3.o ../src/config/atsamd21g18a_default/peripheral/tc/plib_tc3.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1324666034/plib_tc4.o: ../src/config/atsamd21g18a_default/peripheral/tc/plib_tc4.c  .generated_files/flags/atsamd21g18a_default/a8308ca5b58bd619b9d837af28cf7d75e16f6dc4 .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/1324666034" 
	@${RM} ${OBJECTDIR}/_ext/1324666034/plib_tc4.o.d 
	@${RM} ${OBJECTDIR}/_ext/1324666034/plib_tc4.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1324666034/plib_tc4.o.d" -o ${OBJECTDIR}/_ext/1324666034/plib_tc4.o ../src/config/atsamd21g18a_default/peripheral/tc/plib_tc4.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1324666034/plib_tc5.o: ../src/config/atsamd21g18a_default/peripheral/tc/plib_tc5.c  .generated_files/flags/atsamd21g18a_default/1a4badfee5327a9ea134cfb238a17c78a8d909d1 .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/1324666034" 
	@${RM} ${OBJECTDIR}/_ext/1324666034/plib_tc5.o.d 
	@${RM} ${OBJECTDIR}/_ext/1324666034/plib_tc5.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1324666034/plib_tc5.o.d" -o ${OBJECTDIR}/_ext/1324666034/plib_tc5.o ../src/config/atsamd21g18a_default/peripheral/tc/plib_tc5.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1885022876/plib_wdt.o: ../src/config/atsamd21g18a_default/peripheral/wdt/plib_wdt.c  .generated_files/flags/atsamd21g18a_default/182dd691ae7d1481a8a20a46bee5a9f51a7a7357 .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/1885022876" 
	@${RM} ${OBJECTDIR}/_ext/1885022876/plib_wdt.o.d 
	@${RM} ${OBJECTDIR}/_ext/1885022876/plib_wdt.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1885022876/plib_wdt.o.d" -o ${OBJECTDIR}/_ext/1885022876/plib_wdt.o ../src/config/atsamd21g18a_default/peripheral/wdt/plib_wdt.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/9958233/xc32_monitor.o: ../src/config/atsamd21g18a_default/stdio/xc32_monitor.c  .generated_files/flags/atsamd21g18a_default/64d3fb74c839f68b054d416a3e53ae60ddef5985 .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/9958233" 
	@${RM} ${OBJECTDIR}/_ext/9958233/xc32_monitor.o.d 
	@${RM} ${OBJECTDIR}/_ext/9958233/xc32_monitor.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/9958233/xc32_monitor.o.d" -o ${OBJECTDIR}/_ext/9958233/xc32_monitor.o ../src/config/atsamd21g18a_default/stdio/xc32_monitor.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/63538924/sys_int.o: ../src/config/atsamd21g18a_default/system/int/src/sys_int.c  .generated_files/flags/atsamd21g18a_default/4b1697ba10fa5da89b4ee281e2974043e8197a0d .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/63538924" 
	@${RM} ${OBJECTDIR}/_ext/63538924/sys_int.o.d 
	@${RM} ${OBJECTDIR}/_ext/63538924/sys_int.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/63538924/sys_int.o.d" -o ${OBJECTDIR}/_ext/63538924/sys_int.o ../src/config/atsamd21g18a_default/system/int/src/sys_int.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1572229207/usb_device.o: ../src/config/atsamd21g18a_default/usb/src/usb_device.c  .generated_files/flags/atsamd21g18a_default/ee716f2cacf28ac89cca4a6bbce905b6e206bd37 .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/1572229207" 
	@${RM} ${OBJECTDIR}/_ext/1572229207/usb_device.o.d 
	@${RM} ${OBJECTDIR}/_ext/1572229207/usb_device.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1572229207/usb_device.o.d" -o ${OBJECTDIR}/_ext/1572229207/usb_device.o ../src/config/atsamd21g18a_default/usb/src/usb_device.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1572229207/usb_device_cdc.o: ../src/config/atsamd21g18a_default/usb/src/usb_device_cdc.c  .generated_files/flags/atsamd21g18a_default/31412a7eccc4d4afdf8100345ff3b3515dc011b1 .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/1572229207" 
	@${RM} ${OBJECTDIR}/_ext/1572229207/usb_device_cdc.o.d 
	@${RM} ${OBJECTDIR}/_ext/1572229207/usb_device_cdc.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1572229207/usb_device_cdc.o.d" -o ${OBJECTDIR}/_ext/1572229207/usb_device_cdc.o ../src/config/atsamd21g18a_default/usb/src/usb_device_cdc.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1572229207/usb_device_cdc_acm.o: ../src/config/atsamd21g18a_default/usb/src/usb_device_cdc_acm.c  .generated_files/flags/atsamd21g18a_default/18656bdc400f4646b87f1749986de344466cacf .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/1572229207" 
	@${RM} ${OBJECTDIR}/_ext/1572229207/usb_device_cdc_acm.o.d 
	@${RM} ${OBJECTDIR}/_ext/1572229207/usb_device_cdc_acm.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1572229207/usb_device_cdc_acm.o.d" -o ${OBJECTDIR}/_ext/1572229207/usb_device_cdc_acm.o ../src/config/atsamd21g18a_default/usb/src/usb_device_cdc_acm.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1640317663/initialization.o: ../src/config/atsamd21g18a_default/initialization.c  .generated_files/flags/atsamd21g18a_default/91abcc4ac629b373f8a3c34706913037312e4402 .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/1640317663" 
	@${RM} ${OBJECTDIR}/_ext/1640317663/initialization.o.d 
	@${RM} ${OBJECTDIR}/_ext/1640317663/initialization.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1640317663/initialization.o.d" -o ${OBJECTDIR}/_ext/1640317663/initialization.o ../src/config/atsamd21g18a_default/initialization.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1640317663/interrupts.o: ../src/config/atsamd21g18a_default/interrupts.c  .generated_files/flags/atsamd21g18a_default/8e939c1be195c1cc724449971c65d320ee4bba0d .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/1640317663" 
	@${RM} ${OBJECTDIR}/_ext/1640317663/interrupts.o.d 
	@${RM} ${OBJECTDIR}/_ext/1640317663/interrupts.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1640317663/interrupts.o.d" -o ${OBJECTDIR}/_ext/1640317663/interrupts.o ../src/config/atsamd21g18a_default/interrupts.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1640317663/exceptions.o: ../src/config/atsamd21g18a_default/exceptions.c  .generated_files/flags/atsamd21g18a_default/9c58d19e5869efb23cdaae928444f4146dc5274f .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/1640317663" 
	@${RM} ${OBJECTDIR}/_ext/1640317663/exceptions.o.d 
	@${RM} ${OBJECTDIR}/_ext/1640317663/exceptions.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1640317663/exceptions.o.d" -o ${OBJECTDIR}/_ext/1640317663/exceptions.o ../src/config/atsamd21g18a_default/exceptions.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1640317663/startup_xc32.o: ../src/config/atsamd21g18a_default/startup_xc32.c  .generated_files/flags/atsamd21g18a_default/3c691c11ef6ea755ec68b3cff1bf4d468951ebaf .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/1640317663" 
	@${RM} ${OBJECTDIR}/_ext/1640317663/startup_xc32.o.d 
	@${RM} ${OBJECTDIR}/_ext/1640317663/startup_xc32.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1640317663/startup_xc32.o.d" -o ${OBJECTDIR}/_ext/1640317663/startup_xc32.o ../src/config/atsamd21g18a_default/startup_xc32.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1640317663/libc_syscalls.o: ../src/config/atsamd21g18a_default/libc_syscalls.c  .generated_files/flags/atsamd21g18a_default/a1b12fc5ee4c21daf8822d33e4aa201f27cafcee .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/1640317663" 
	@${RM} ${OBJECTDIR}/_ext/1640317663/libc_syscalls.o.d 
	@${RM} ${OBJECTDIR}/_ext/1640317663/libc_syscalls.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1640317663/libc_syscalls.o.d" -o ${OBJECTDIR}/_ext/1640317663/libc_syscalls.o ../src/config/atsamd21g18a_default/libc_syscalls.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1640317663/usb_device_init_data.o: ../src/config/atsamd21g18a_default/usb_device_init_data.c  .generated_files/flags/atsamd21g18a_default/702c38fc807acd7c460f0883286c8516d6ff6a88 .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/1640317663" 
	@${RM} ${OBJECTDIR}/_ext/1640317663/usb_device_init_data.o.d 
	@${RM} ${OBJECTDIR}/_ext/1640317663/usb_device_init_data.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1640317663/usb_device_init_data.o.d" -o ${OBJECTDIR}/_ext/1640317663/usb_device_init_data.o ../src/config/atsamd21g18a_default/usb_device_init_data.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1640317663/tasks.o: ../src/config/atsamd21g18a_default/tasks.c  .generated_files/flags/atsamd21g18a_default/fb9dd1a0e0b93fa20964eb3b63d70d300562cea2 .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/1640317663" 
	@${RM} ${OBJECTDIR}/_ext/1640317663/tasks.o.d 
	@${RM} ${OBJECTDIR}/_ext/1640317663/tasks.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1640317663/tasks.o.d" -o ${OBJECTDIR}/_ext/1640317663/tasks.o ../src/config/atsamd21g18a_default/tasks.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/w25q128jv.o: ../src/w25q128jv.c  .generated_files/flags/atsamd21g18a_default/fd2b652cc194b94c4b479fb7832d78a7b8f22534 .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/w25q128jv.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/w25q128jv.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/w25q128jv.o.d" -o ${OBJECTDIR}/_ext/1360937237/w25q128jv.o ../src/w25q128jv.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/util.o: ../src/util.c  .generated_files/flags/atsamd21g18a_default/69261df1b01c10844d1a6feaa3364253d04f96e2 .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/util.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/util.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/util.o.d" -o ${OBJECTDIR}/_ext/1360937237/util.o ../src/util.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/s5851a.o: ../src/s5851a.c  .generated_files/flags/atsamd21g18a_default/36c1efbba1dcacc72113f8c1045f93f8ebc88056 .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/s5851a.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/s5851a.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/s5851a.o.d" -o ${OBJECTDIR}/_ext/1360937237/s5851a.o ../src/s5851a.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/gpioexp.o: ../src/gpioexp.c  .generated_files/flags/atsamd21g18a_default/ea1d9111c1a3c800c2fa4764f1350359361f88db .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/gpioexp.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/gpioexp.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/gpioexp.o.d" -o ${OBJECTDIR}/_ext/1360937237/gpioexp.o ../src/gpioexp.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/rtc.o: ../src/rtc.c  .generated_files/flags/atsamd21g18a_default/624644d7e918a70667bc8c0e009019ec95a65a93 .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/rtc.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/rtc.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/rtc.o.d" -o ${OBJECTDIR}/_ext/1360937237/rtc.o ../src/rtc.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/mlog.o: ../src/mlog.c  .generated_files/flags/atsamd21g18a_default/1d063d7290606f0f321756e7cc7ad2c4aff78cee .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/mlog.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/mlog.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/mlog.o.d" -o ${OBJECTDIR}/_ext/1360937237/mlog.o ../src/mlog.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/sensor.o: ../src/sensor.c  .generated_files/flags/atsamd21g18a_default/3359149237451f2d3359b6fe0190118238739cc .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/sensor.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/sensor.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/sensor.o.d" -o ${OBJECTDIR}/_ext/1360937237/sensor.o ../src/sensor.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/uart_debug.o: ../src/uart_debug.c  .generated_files/flags/atsamd21g18a_default/a1fead7ea11d5d614f1c0d337ba12c53f9df30d5 .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/uart_debug.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/uart_debug.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/uart_debug.o.d" -o ${OBJECTDIR}/_ext/1360937237/uart_debug.o ../src/uart_debug.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/uart_comm.o: ../src/uart_comm.c  .generated_files/flags/atsamd21g18a_default/3cf972e335c9e09e7ce3c39873bdbc29ca29e44c .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/uart_comm.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/uart_comm.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/uart_comm.o.d" -o ${OBJECTDIR}/_ext/1360937237/uart_comm.o ../src/uart_comm.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/wpfm.o: ../src/wpfm.c  .generated_files/flags/atsamd21g18a_default/c286b55814e8069f55337f44201d17d6c0dc7c1 .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/wpfm.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/wpfm.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/wpfm.o.d" -o ${OBJECTDIR}/_ext/1360937237/wpfm.o ../src/wpfm.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/battery.o: ../src/battery.c  .generated_files/flags/atsamd21g18a_default/2434e243667b96d11a12b3d601d73fc22643155 .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/battery.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/battery.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/battery.o.d" -o ${OBJECTDIR}/_ext/1360937237/battery.o ../src/battery.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/communicate.o: ../src/communicate.c  .generated_files/flags/atsamd21g18a_default/a5c5ad35b6f559fea1200c86bae9796252b0e354 .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/communicate.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/communicate.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/communicate.o.d" -o ${OBJECTDIR}/_ext/1360937237/communicate.o ../src/communicate.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/init.o: ../src/init.c  .generated_files/flags/atsamd21g18a_default/a9da2d330fad6f6f872024bcccff6091470cba3e .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/init.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/init.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/init.o.d" -o ${OBJECTDIR}/_ext/1360937237/init.o ../src/init.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/measure.o: ../src/measure.c  .generated_files/flags/atsamd21g18a_default/ce0b76c2fadf45b5c023d8b29f2e4faed7bbfdea .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/measure.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/measure.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/measure.o.d" -o ${OBJECTDIR}/_ext/1360937237/measure.o ../src/measure.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/alert.o: ../src/alert.c  .generated_files/flags/atsamd21g18a_default/a59127ceefc3297de1e60caeedf4e37b4a4d73bc .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/alert.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/alert.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/alert.o.d" -o ${OBJECTDIR}/_ext/1360937237/alert.o ../src/alert.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/smpif4.o: ../src/smpif4.c  .generated_files/flags/atsamd21g18a_default/86f2188cf9b0ef826f7b74f94fd437b7d2511369 .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/smpif4.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/smpif4.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/smpif4.o.d" -o ${OBJECTDIR}/_ext/1360937237/smpif4.o ../src/smpif4.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/smpif.o: ../src/smpif.c  .generated_files/flags/atsamd21g18a_default/b626f8fcf1106e144c23932eaf6fdd8d69b2382d .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/smpif.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/smpif.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/smpif.o.d" -o ${OBJECTDIR}/_ext/1360937237/smpif.o ../src/smpif.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/smpif1.o: ../src/smpif1.c  .generated_files/flags/atsamd21g18a_default/d5feb0d6008a3c126016f13815fbb9d480263cd6 .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/smpif1.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/smpif1.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/smpif1.o.d" -o ${OBJECTDIR}/_ext/1360937237/smpif1.o ../src/smpif1.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/smpif2.o: ../src/smpif2.c  .generated_files/flags/atsamd21g18a_default/e2f4d1a1940f471bd7a527065e470624c8a5ee66 .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/smpif2.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/smpif2.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/smpif2.o.d" -o ${OBJECTDIR}/_ext/1360937237/smpif2.o ../src/smpif2.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/smpif3.o: ../src/smpif3.c  .generated_files/flags/atsamd21g18a_default/b891def7be9a885dc16da7b0c3a98dc2b2493c06 .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/smpif3.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/smpif3.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/smpif3.o.d" -o ${OBJECTDIR}/_ext/1360937237/smpif3.o ../src/smpif3.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/main.o: ../src/main.c  .generated_files/flags/atsamd21g18a_default/7d9d5c7658d76665c5ce863b3767369f396b4d8e .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/main.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/main.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/main.o.d" -o ${OBJECTDIR}/_ext/1360937237/main.o ../src/main.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/app.o: ../src/app.c  .generated_files/flags/atsamd21g18a_default/d669a74d6b5b118bf4faf0f81d08db36822b70a2 .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/app.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/app.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/app.o.d" -o ${OBJECTDIR}/_ext/1360937237/app.o ../src/app.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/MATcore.o: ../src/MATcore.c  .generated_files/flags/atsamd21g18a_default/2181996b08a19f7092594b1271e4ab4b748a28d1 .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/MATcore.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/MATcore.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/MATcore.o.d" -o ${OBJECTDIR}/_ext/1360937237/MATcore.o ../src/MATcore.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/moni.o: ../src/moni.c  .generated_files/flags/atsamd21g18a_default/7fb45bfcd9f213472655568bfbb9fd45fc7daf02 .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/moni.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/moni.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/moni.o.d" -o ${OBJECTDIR}/_ext/1360937237/moni.o ../src/moni.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/version.o: ../src/version.c  .generated_files/flags/atsamd21g18a_default/6dc1498a3084fde79678a689ed4bd322634b9e4a .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/version.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/version.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/version.o.d" -o ${OBJECTDIR}/_ext/1360937237/version.o ../src/version.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/DLCpara.o: ../src/DLCpara.c  .generated_files/flags/atsamd21g18a_default/e165a7aebb4ad6072c237458ac67f5269f7a6ad6 .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/DLCpara.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/DLCpara.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/DLCpara.o.d" -o ${OBJECTDIR}/_ext/1360937237/DLCpara.o ../src/DLCpara.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/EventLog.o: ../src/EventLog.c  .generated_files/flags/atsamd21g18a_default/abca047f2a94822cd0d4f82e8902f8b0ac516b29 .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/EventLog.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/EventLog.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/EventLog.o.d" -o ${OBJECTDIR}/_ext/1360937237/EventLog.o ../src/EventLog.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/FOTAcmd.o: ../src/FOTAcmd.c  .generated_files/flags/atsamd21g18a_default/1ec53de95f2190ab8a51144d69971e4de2120555 .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/FOTAcmd.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/FOTAcmd.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/FOTAcmd.o.d" -o ${OBJECTDIR}/_ext/1360937237/FOTAcmd.o ../src/FOTAcmd.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
else
${OBJECTDIR}/_ext/1814754785/drv_usbfsv1.o: ../src/config/atsamd21g18a_default/driver/usb/usbfsv1/src/drv_usbfsv1.c  .generated_files/flags/atsamd21g18a_default/2a2057abc1e30a0f06328630b0ca357e7d532453 .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/1814754785" 
	@${RM} ${OBJECTDIR}/_ext/1814754785/drv_usbfsv1.o.d 
	@${RM} ${OBJECTDIR}/_ext/1814754785/drv_usbfsv1.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1814754785/drv_usbfsv1.o.d" -o ${OBJECTDIR}/_ext/1814754785/drv_usbfsv1.o ../src/config/atsamd21g18a_default/driver/usb/usbfsv1/src/drv_usbfsv1.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1814754785/drv_usbfsv1_device.o: ../src/config/atsamd21g18a_default/driver/usb/usbfsv1/src/drv_usbfsv1_device.c  .generated_files/flags/atsamd21g18a_default/63ba1065483cae7efc27f35667db051b0908214d .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/1814754785" 
	@${RM} ${OBJECTDIR}/_ext/1814754785/drv_usbfsv1_device.o.d 
	@${RM} ${OBJECTDIR}/_ext/1814754785/drv_usbfsv1_device.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1814754785/drv_usbfsv1_device.o.d" -o ${OBJECTDIR}/_ext/1814754785/drv_usbfsv1_device.o ../src/config/atsamd21g18a_default/driver/usb/usbfsv1/src/drv_usbfsv1_device.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1885044035/plib_adc.o: ../src/config/atsamd21g18a_default/peripheral/adc/plib_adc.c  .generated_files/flags/atsamd21g18a_default/72749df66f8ce26ace7dd5132950804545b5e5a3 .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/1885044035" 
	@${RM} ${OBJECTDIR}/_ext/1885044035/plib_adc.o.d 
	@${RM} ${OBJECTDIR}/_ext/1885044035/plib_adc.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1885044035/plib_adc.o.d" -o ${OBJECTDIR}/_ext/1885044035/plib_adc.o ../src/config/atsamd21g18a_default/peripheral/adc/plib_adc.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/950981355/plib_clock.o: ../src/config/atsamd21g18a_default/peripheral/clock/plib_clock.c  .generated_files/flags/atsamd21g18a_default/c15786fea72fe8d9dabba96c4c973496736f0fcd .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/950981355" 
	@${RM} ${OBJECTDIR}/_ext/950981355/plib_clock.o.d 
	@${RM} ${OBJECTDIR}/_ext/950981355/plib_clock.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/950981355/plib_clock.o.d" -o ${OBJECTDIR}/_ext/950981355/plib_clock.o ../src/config/atsamd21g18a_default/peripheral/clock/plib_clock.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1885040036/plib_eic.o: ../src/config/atsamd21g18a_default/peripheral/eic/plib_eic.c  .generated_files/flags/atsamd21g18a_default/69f40745e73dbca3a4e589df440e1c6e345edbb1 .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/1885040036" 
	@${RM} ${OBJECTDIR}/_ext/1885040036/plib_eic.o.d 
	@${RM} ${OBJECTDIR}/_ext/1885040036/plib_eic.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1885040036/plib_eic.o.d" -o ${OBJECTDIR}/_ext/1885040036/plib_eic.o ../src/config/atsamd21g18a_default/peripheral/eic/plib_eic.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/953130841/plib_evsys.o: ../src/config/atsamd21g18a_default/peripheral/evsys/plib_evsys.c  .generated_files/flags/atsamd21g18a_default/6694fe6f40976e3c281b51fa5d61630f50d0cdf .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/953130841" 
	@${RM} ${OBJECTDIR}/_ext/953130841/plib_evsys.o.d 
	@${RM} ${OBJECTDIR}/_ext/953130841/plib_evsys.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/953130841/plib_evsys.o.d" -o ${OBJECTDIR}/_ext/953130841/plib_evsys.o ../src/config/atsamd21g18a_default/peripheral/evsys/plib_evsys.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1693581925/plib_nvic.o: ../src/config/atsamd21g18a_default/peripheral/nvic/plib_nvic.c  .generated_files/flags/atsamd21g18a_default/a0c78b7d9117fbac7e01d6ad4dd032d7c9372543 .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/1693581925" 
	@${RM} ${OBJECTDIR}/_ext/1693581925/plib_nvic.o.d 
	@${RM} ${OBJECTDIR}/_ext/1693581925/plib_nvic.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1693581925/plib_nvic.o.d" -o ${OBJECTDIR}/_ext/1693581925/plib_nvic.o ../src/config/atsamd21g18a_default/peripheral/nvic/plib_nvic.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/522110765/plib_nvmctrl.o: ../src/config/atsamd21g18a_default/peripheral/nvmctrl/plib_nvmctrl.c  .generated_files/flags/atsamd21g18a_default/ff52a3e39485b0efdf288022668efc0654cba388 .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/522110765" 
	@${RM} ${OBJECTDIR}/_ext/522110765/plib_nvmctrl.o.d 
	@${RM} ${OBJECTDIR}/_ext/522110765/plib_nvmctrl.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/522110765/plib_nvmctrl.o.d" -o ${OBJECTDIR}/_ext/522110765/plib_nvmctrl.o ../src/config/atsamd21g18a_default/peripheral/nvmctrl/plib_nvmctrl.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1324665920/plib_pm.o: ../src/config/atsamd21g18a_default/peripheral/pm/plib_pm.c  .generated_files/flags/atsamd21g18a_default/969d1b1d49ce5fb55e440b219193008392d5531b .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/1324665920" 
	@${RM} ${OBJECTDIR}/_ext/1324665920/plib_pm.o.d 
	@${RM} ${OBJECTDIR}/_ext/1324665920/plib_pm.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1324665920/plib_pm.o.d" -o ${OBJECTDIR}/_ext/1324665920/plib_pm.o ../src/config/atsamd21g18a_default/peripheral/pm/plib_pm.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1693635076/plib_port.o: ../src/config/atsamd21g18a_default/peripheral/port/plib_port.c  .generated_files/flags/atsamd21g18a_default/c60bf7e53d088fe3c179e256a8d50821c0d3e645 .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/1693635076" 
	@${RM} ${OBJECTDIR}/_ext/1693635076/plib_port.o.d 
	@${RM} ${OBJECTDIR}/_ext/1693635076/plib_port.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1693635076/plib_port.o.d" -o ${OBJECTDIR}/_ext/1693635076/plib_port.o ../src/config/atsamd21g18a_default/peripheral/port/plib_port.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/163103410/plib_sercom3_i2c_master.o: ../src/config/atsamd21g18a_default/peripheral/sercom/i2c_master/plib_sercom3_i2c_master.c  .generated_files/flags/atsamd21g18a_default/16548b446b18f3a94a7eea8a507af9841ffd8b75 .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/163103410" 
	@${RM} ${OBJECTDIR}/_ext/163103410/plib_sercom3_i2c_master.o.d 
	@${RM} ${OBJECTDIR}/_ext/163103410/plib_sercom3_i2c_master.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/163103410/plib_sercom3_i2c_master.o.d" -o ${OBJECTDIR}/_ext/163103410/plib_sercom3_i2c_master.o ../src/config/atsamd21g18a_default/peripheral/sercom/i2c_master/plib_sercom3_i2c_master.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/328131232/plib_sercom1_spi_master.o: ../src/config/atsamd21g18a_default/peripheral/sercom/spi_master/plib_sercom1_spi_master.c  .generated_files/flags/atsamd21g18a_default/75a997ccc5ad4d3beebd92b6fa568009cae1b3cc .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/328131232" 
	@${RM} ${OBJECTDIR}/_ext/328131232/plib_sercom1_spi_master.o.d 
	@${RM} ${OBJECTDIR}/_ext/328131232/plib_sercom1_spi_master.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/328131232/plib_sercom1_spi_master.o.d" -o ${OBJECTDIR}/_ext/328131232/plib_sercom1_spi_master.o ../src/config/atsamd21g18a_default/peripheral/sercom/spi_master/plib_sercom1_spi_master.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/472979226/plib_sercom0_usart.o: ../src/config/atsamd21g18a_default/peripheral/sercom/usart/plib_sercom0_usart.c  .generated_files/flags/atsamd21g18a_default/1f40adbeb78b71fc97f44ef5288df9b70ab61e3a .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/472979226" 
	@${RM} ${OBJECTDIR}/_ext/472979226/plib_sercom0_usart.o.d 
	@${RM} ${OBJECTDIR}/_ext/472979226/plib_sercom0_usart.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/472979226/plib_sercom0_usart.o.d" -o ${OBJECTDIR}/_ext/472979226/plib_sercom0_usart.o ../src/config/atsamd21g18a_default/peripheral/sercom/usart/plib_sercom0_usart.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/472979226/plib_sercom5_usart.o: ../src/config/atsamd21g18a_default/peripheral/sercom/usart/plib_sercom5_usart.c  .generated_files/flags/atsamd21g18a_default/a5a7d078b60209b67c605749af83078f90b039da .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/472979226" 
	@${RM} ${OBJECTDIR}/_ext/472979226/plib_sercom5_usart.o.d 
	@${RM} ${OBJECTDIR}/_ext/472979226/plib_sercom5_usart.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/472979226/plib_sercom5_usart.o.d" -o ${OBJECTDIR}/_ext/472979226/plib_sercom5_usart.o ../src/config/atsamd21g18a_default/peripheral/sercom/usart/plib_sercom5_usart.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/756585863/plib_systick.o: ../src/config/atsamd21g18a_default/peripheral/systick/plib_systick.c  .generated_files/flags/atsamd21g18a_default/de0f0f851407172a0209dbd5301ff56123edec5d .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/756585863" 
	@${RM} ${OBJECTDIR}/_ext/756585863/plib_systick.o.d 
	@${RM} ${OBJECTDIR}/_ext/756585863/plib_systick.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/756585863/plib_systick.o.d" -o ${OBJECTDIR}/_ext/756585863/plib_systick.o ../src/config/atsamd21g18a_default/peripheral/systick/plib_systick.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1324666034/plib_tc3.o: ../src/config/atsamd21g18a_default/peripheral/tc/plib_tc3.c  .generated_files/flags/atsamd21g18a_default/5f41e1084b1165d82a04abd8be835ea8486f9e81 .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/1324666034" 
	@${RM} ${OBJECTDIR}/_ext/1324666034/plib_tc3.o.d 
	@${RM} ${OBJECTDIR}/_ext/1324666034/plib_tc3.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1324666034/plib_tc3.o.d" -o ${OBJECTDIR}/_ext/1324666034/plib_tc3.o ../src/config/atsamd21g18a_default/peripheral/tc/plib_tc3.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1324666034/plib_tc4.o: ../src/config/atsamd21g18a_default/peripheral/tc/plib_tc4.c  .generated_files/flags/atsamd21g18a_default/9cc6a59f66f349e245bd5e162cb99b65d2114fd5 .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/1324666034" 
	@${RM} ${OBJECTDIR}/_ext/1324666034/plib_tc4.o.d 
	@${RM} ${OBJECTDIR}/_ext/1324666034/plib_tc4.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1324666034/plib_tc4.o.d" -o ${OBJECTDIR}/_ext/1324666034/plib_tc4.o ../src/config/atsamd21g18a_default/peripheral/tc/plib_tc4.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1324666034/plib_tc5.o: ../src/config/atsamd21g18a_default/peripheral/tc/plib_tc5.c  .generated_files/flags/atsamd21g18a_default/2b22b571ea1a0d7b067a2091b8d6bac505690998 .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/1324666034" 
	@${RM} ${OBJECTDIR}/_ext/1324666034/plib_tc5.o.d 
	@${RM} ${OBJECTDIR}/_ext/1324666034/plib_tc5.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1324666034/plib_tc5.o.d" -o ${OBJECTDIR}/_ext/1324666034/plib_tc5.o ../src/config/atsamd21g18a_default/peripheral/tc/plib_tc5.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1885022876/plib_wdt.o: ../src/config/atsamd21g18a_default/peripheral/wdt/plib_wdt.c  .generated_files/flags/atsamd21g18a_default/9f9df3c284345997124c79b96bf37dfea222ff4e .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/1885022876" 
	@${RM} ${OBJECTDIR}/_ext/1885022876/plib_wdt.o.d 
	@${RM} ${OBJECTDIR}/_ext/1885022876/plib_wdt.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1885022876/plib_wdt.o.d" -o ${OBJECTDIR}/_ext/1885022876/plib_wdt.o ../src/config/atsamd21g18a_default/peripheral/wdt/plib_wdt.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/9958233/xc32_monitor.o: ../src/config/atsamd21g18a_default/stdio/xc32_monitor.c  .generated_files/flags/atsamd21g18a_default/3cc2d6da0ac6052dd8bb2c971146f8b5fbeb693 .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/9958233" 
	@${RM} ${OBJECTDIR}/_ext/9958233/xc32_monitor.o.d 
	@${RM} ${OBJECTDIR}/_ext/9958233/xc32_monitor.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/9958233/xc32_monitor.o.d" -o ${OBJECTDIR}/_ext/9958233/xc32_monitor.o ../src/config/atsamd21g18a_default/stdio/xc32_monitor.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/63538924/sys_int.o: ../src/config/atsamd21g18a_default/system/int/src/sys_int.c  .generated_files/flags/atsamd21g18a_default/83d70dda2116edd5876962fb16f7aa44de11afb .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/63538924" 
	@${RM} ${OBJECTDIR}/_ext/63538924/sys_int.o.d 
	@${RM} ${OBJECTDIR}/_ext/63538924/sys_int.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/63538924/sys_int.o.d" -o ${OBJECTDIR}/_ext/63538924/sys_int.o ../src/config/atsamd21g18a_default/system/int/src/sys_int.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1572229207/usb_device.o: ../src/config/atsamd21g18a_default/usb/src/usb_device.c  .generated_files/flags/atsamd21g18a_default/67bd10ac86878a201b3d3d6961faaec3c0cf21e3 .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/1572229207" 
	@${RM} ${OBJECTDIR}/_ext/1572229207/usb_device.o.d 
	@${RM} ${OBJECTDIR}/_ext/1572229207/usb_device.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1572229207/usb_device.o.d" -o ${OBJECTDIR}/_ext/1572229207/usb_device.o ../src/config/atsamd21g18a_default/usb/src/usb_device.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1572229207/usb_device_cdc.o: ../src/config/atsamd21g18a_default/usb/src/usb_device_cdc.c  .generated_files/flags/atsamd21g18a_default/f58fdea5ea73b075b0d3c35407500534b15881f3 .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/1572229207" 
	@${RM} ${OBJECTDIR}/_ext/1572229207/usb_device_cdc.o.d 
	@${RM} ${OBJECTDIR}/_ext/1572229207/usb_device_cdc.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1572229207/usb_device_cdc.o.d" -o ${OBJECTDIR}/_ext/1572229207/usb_device_cdc.o ../src/config/atsamd21g18a_default/usb/src/usb_device_cdc.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1572229207/usb_device_cdc_acm.o: ../src/config/atsamd21g18a_default/usb/src/usb_device_cdc_acm.c  .generated_files/flags/atsamd21g18a_default/fca56fbbfe58c2dc5653132ba66ddfc9c30bf4fe .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/1572229207" 
	@${RM} ${OBJECTDIR}/_ext/1572229207/usb_device_cdc_acm.o.d 
	@${RM} ${OBJECTDIR}/_ext/1572229207/usb_device_cdc_acm.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1572229207/usb_device_cdc_acm.o.d" -o ${OBJECTDIR}/_ext/1572229207/usb_device_cdc_acm.o ../src/config/atsamd21g18a_default/usb/src/usb_device_cdc_acm.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1640317663/initialization.o: ../src/config/atsamd21g18a_default/initialization.c  .generated_files/flags/atsamd21g18a_default/103ecbe7ec0597d242201ca5c9e4086892ccf000 .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/1640317663" 
	@${RM} ${OBJECTDIR}/_ext/1640317663/initialization.o.d 
	@${RM} ${OBJECTDIR}/_ext/1640317663/initialization.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1640317663/initialization.o.d" -o ${OBJECTDIR}/_ext/1640317663/initialization.o ../src/config/atsamd21g18a_default/initialization.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1640317663/interrupts.o: ../src/config/atsamd21g18a_default/interrupts.c  .generated_files/flags/atsamd21g18a_default/88265e0517babff1aac1c7e0ec4181b6a97c1825 .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/1640317663" 
	@${RM} ${OBJECTDIR}/_ext/1640317663/interrupts.o.d 
	@${RM} ${OBJECTDIR}/_ext/1640317663/interrupts.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1640317663/interrupts.o.d" -o ${OBJECTDIR}/_ext/1640317663/interrupts.o ../src/config/atsamd21g18a_default/interrupts.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1640317663/exceptions.o: ../src/config/atsamd21g18a_default/exceptions.c  .generated_files/flags/atsamd21g18a_default/bc55f298975c5e9057bd99228f7afdfe54c67d3 .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/1640317663" 
	@${RM} ${OBJECTDIR}/_ext/1640317663/exceptions.o.d 
	@${RM} ${OBJECTDIR}/_ext/1640317663/exceptions.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1640317663/exceptions.o.d" -o ${OBJECTDIR}/_ext/1640317663/exceptions.o ../src/config/atsamd21g18a_default/exceptions.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1640317663/startup_xc32.o: ../src/config/atsamd21g18a_default/startup_xc32.c  .generated_files/flags/atsamd21g18a_default/c0b4fd688031c9bbc5c03d5f075152d1f4b21f6a .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/1640317663" 
	@${RM} ${OBJECTDIR}/_ext/1640317663/startup_xc32.o.d 
	@${RM} ${OBJECTDIR}/_ext/1640317663/startup_xc32.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1640317663/startup_xc32.o.d" -o ${OBJECTDIR}/_ext/1640317663/startup_xc32.o ../src/config/atsamd21g18a_default/startup_xc32.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1640317663/libc_syscalls.o: ../src/config/atsamd21g18a_default/libc_syscalls.c  .generated_files/flags/atsamd21g18a_default/5c02c306eed812d56d36122e9309e453ed29e2c8 .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/1640317663" 
	@${RM} ${OBJECTDIR}/_ext/1640317663/libc_syscalls.o.d 
	@${RM} ${OBJECTDIR}/_ext/1640317663/libc_syscalls.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1640317663/libc_syscalls.o.d" -o ${OBJECTDIR}/_ext/1640317663/libc_syscalls.o ../src/config/atsamd21g18a_default/libc_syscalls.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1640317663/usb_device_init_data.o: ../src/config/atsamd21g18a_default/usb_device_init_data.c  .generated_files/flags/atsamd21g18a_default/947bac84323dace6aebf43f8b096ade81b9e3f04 .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/1640317663" 
	@${RM} ${OBJECTDIR}/_ext/1640317663/usb_device_init_data.o.d 
	@${RM} ${OBJECTDIR}/_ext/1640317663/usb_device_init_data.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1640317663/usb_device_init_data.o.d" -o ${OBJECTDIR}/_ext/1640317663/usb_device_init_data.o ../src/config/atsamd21g18a_default/usb_device_init_data.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1640317663/tasks.o: ../src/config/atsamd21g18a_default/tasks.c  .generated_files/flags/atsamd21g18a_default/f977b7e75ff498d17ae268c739d0fb604fbe2e77 .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/1640317663" 
	@${RM} ${OBJECTDIR}/_ext/1640317663/tasks.o.d 
	@${RM} ${OBJECTDIR}/_ext/1640317663/tasks.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1640317663/tasks.o.d" -o ${OBJECTDIR}/_ext/1640317663/tasks.o ../src/config/atsamd21g18a_default/tasks.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/w25q128jv.o: ../src/w25q128jv.c  .generated_files/flags/atsamd21g18a_default/ce28c17dab7235408a451cf30876f8370a5ed6d0 .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/w25q128jv.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/w25q128jv.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/w25q128jv.o.d" -o ${OBJECTDIR}/_ext/1360937237/w25q128jv.o ../src/w25q128jv.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/util.o: ../src/util.c  .generated_files/flags/atsamd21g18a_default/e4a615c246de537caadbd7b9a51073bff5981418 .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/util.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/util.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/util.o.d" -o ${OBJECTDIR}/_ext/1360937237/util.o ../src/util.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/s5851a.o: ../src/s5851a.c  .generated_files/flags/atsamd21g18a_default/3320025a3d7b4ca3fbce33827085242d4d70a6bd .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/s5851a.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/s5851a.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/s5851a.o.d" -o ${OBJECTDIR}/_ext/1360937237/s5851a.o ../src/s5851a.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/gpioexp.o: ../src/gpioexp.c  .generated_files/flags/atsamd21g18a_default/d83a7c87f63254aa88c3903b853961c853131b50 .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/gpioexp.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/gpioexp.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/gpioexp.o.d" -o ${OBJECTDIR}/_ext/1360937237/gpioexp.o ../src/gpioexp.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/rtc.o: ../src/rtc.c  .generated_files/flags/atsamd21g18a_default/2b1dc25331227d7515aadc75433d2c9a2effd74d .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/rtc.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/rtc.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/rtc.o.d" -o ${OBJECTDIR}/_ext/1360937237/rtc.o ../src/rtc.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/mlog.o: ../src/mlog.c  .generated_files/flags/atsamd21g18a_default/30f30d55262c016387301b66aaf32db641652033 .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/mlog.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/mlog.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/mlog.o.d" -o ${OBJECTDIR}/_ext/1360937237/mlog.o ../src/mlog.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/sensor.o: ../src/sensor.c  .generated_files/flags/atsamd21g18a_default/b14df5af2997545a4d9b0962df10713b9c543264 .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/sensor.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/sensor.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/sensor.o.d" -o ${OBJECTDIR}/_ext/1360937237/sensor.o ../src/sensor.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/uart_debug.o: ../src/uart_debug.c  .generated_files/flags/atsamd21g18a_default/7c673c9d82528717cd4cdd340c56660b8066033b .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/uart_debug.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/uart_debug.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/uart_debug.o.d" -o ${OBJECTDIR}/_ext/1360937237/uart_debug.o ../src/uart_debug.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/uart_comm.o: ../src/uart_comm.c  .generated_files/flags/atsamd21g18a_default/67638639ec7130ff90903d584dea3863356d97bd .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/uart_comm.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/uart_comm.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/uart_comm.o.d" -o ${OBJECTDIR}/_ext/1360937237/uart_comm.o ../src/uart_comm.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/wpfm.o: ../src/wpfm.c  .generated_files/flags/atsamd21g18a_default/602914bbeaaa3d3c1e5ff174eee7ea359d1f9bdd .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/wpfm.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/wpfm.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/wpfm.o.d" -o ${OBJECTDIR}/_ext/1360937237/wpfm.o ../src/wpfm.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/battery.o: ../src/battery.c  .generated_files/flags/atsamd21g18a_default/4e53b487e97c9797e428384b5058a0ba521928f8 .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/battery.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/battery.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/battery.o.d" -o ${OBJECTDIR}/_ext/1360937237/battery.o ../src/battery.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/communicate.o: ../src/communicate.c  .generated_files/flags/atsamd21g18a_default/8e9ab7d6a8d50265edf68e5a370b1a35eb393ebc .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/communicate.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/communicate.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/communicate.o.d" -o ${OBJECTDIR}/_ext/1360937237/communicate.o ../src/communicate.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/init.o: ../src/init.c  .generated_files/flags/atsamd21g18a_default/f9e262cab7e5912547490ce78c07049ad7a78989 .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/init.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/init.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/init.o.d" -o ${OBJECTDIR}/_ext/1360937237/init.o ../src/init.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/measure.o: ../src/measure.c  .generated_files/flags/atsamd21g18a_default/58ef48f9a627d7ded45902a465d4b6b4361011e4 .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/measure.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/measure.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/measure.o.d" -o ${OBJECTDIR}/_ext/1360937237/measure.o ../src/measure.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/alert.o: ../src/alert.c  .generated_files/flags/atsamd21g18a_default/871e22a8bd8dfd818f686283e5a5df998a39891f .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/alert.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/alert.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/alert.o.d" -o ${OBJECTDIR}/_ext/1360937237/alert.o ../src/alert.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/smpif4.o: ../src/smpif4.c  .generated_files/flags/atsamd21g18a_default/c0f26d779f5979ead0c21f0c2b1306e83670a887 .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/smpif4.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/smpif4.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/smpif4.o.d" -o ${OBJECTDIR}/_ext/1360937237/smpif4.o ../src/smpif4.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/smpif.o: ../src/smpif.c  .generated_files/flags/atsamd21g18a_default/3c47c968b8319fdba41867448e7f669e890cc6df .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/smpif.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/smpif.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/smpif.o.d" -o ${OBJECTDIR}/_ext/1360937237/smpif.o ../src/smpif.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/smpif1.o: ../src/smpif1.c  .generated_files/flags/atsamd21g18a_default/bfe7fe663aeb3058d469a4aa2d4838a072652bcc .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/smpif1.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/smpif1.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/smpif1.o.d" -o ${OBJECTDIR}/_ext/1360937237/smpif1.o ../src/smpif1.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/smpif2.o: ../src/smpif2.c  .generated_files/flags/atsamd21g18a_default/ec78dc820cafddb16e10bcab862c51aac951527b .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/smpif2.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/smpif2.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/smpif2.o.d" -o ${OBJECTDIR}/_ext/1360937237/smpif2.o ../src/smpif2.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/smpif3.o: ../src/smpif3.c  .generated_files/flags/atsamd21g18a_default/89df91ac73f2779abf55185d1ea80aa26dd3162 .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/smpif3.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/smpif3.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/smpif3.o.d" -o ${OBJECTDIR}/_ext/1360937237/smpif3.o ../src/smpif3.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/main.o: ../src/main.c  .generated_files/flags/atsamd21g18a_default/ec0aee37be9b35257ed2c41706a7af1b2cce35cc .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/main.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/main.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/main.o.d" -o ${OBJECTDIR}/_ext/1360937237/main.o ../src/main.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/app.o: ../src/app.c  .generated_files/flags/atsamd21g18a_default/6b366e545363e2644a114acfe74f6c5af9dbf2c5 .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/app.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/app.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/app.o.d" -o ${OBJECTDIR}/_ext/1360937237/app.o ../src/app.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/MATcore.o: ../src/MATcore.c  .generated_files/flags/atsamd21g18a_default/4c8888c9fe7c3c0bba813987f144c57af1160590 .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/MATcore.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/MATcore.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/MATcore.o.d" -o ${OBJECTDIR}/_ext/1360937237/MATcore.o ../src/MATcore.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/moni.o: ../src/moni.c  .generated_files/flags/atsamd21g18a_default/4a6ab67e4298e16f969362d441585ffc0439e21a .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/moni.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/moni.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/moni.o.d" -o ${OBJECTDIR}/_ext/1360937237/moni.o ../src/moni.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/version.o: ../src/version.c  .generated_files/flags/atsamd21g18a_default/507cef25fe2f88b7f457cbc824e5118f3a9afdf4 .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/version.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/version.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/version.o.d" -o ${OBJECTDIR}/_ext/1360937237/version.o ../src/version.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/DLCpara.o: ../src/DLCpara.c  .generated_files/flags/atsamd21g18a_default/fefc961f7eba41e8fb2a310c9ad9c21e34ed559 .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/DLCpara.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/DLCpara.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/DLCpara.o.d" -o ${OBJECTDIR}/_ext/1360937237/DLCpara.o ../src/DLCpara.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/EventLog.o: ../src/EventLog.c  .generated_files/flags/atsamd21g18a_default/db44d08af8f9053c1ac0eca5d6a3c657fb1a5235 .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/EventLog.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/EventLog.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/EventLog.o.d" -o ${OBJECTDIR}/_ext/1360937237/EventLog.o ../src/EventLog.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/FOTAcmd.o: ../src/FOTAcmd.c  .generated_files/flags/atsamd21g18a_default/534e25241977f5420defec5661451c28983b2e44 .generated_files/flags/atsamd21g18a_default/c0b19aa7332c2c86ea8f8fb90c99ec9ccff997ba
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/FOTAcmd.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/FOTAcmd.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/FOTAcmd.o.d" -o ${OBJECTDIR}/_ext/1360937237/FOTAcmd.o ../src/FOTAcmd.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
endif

# ------------------------------------------------------------------------------------
# Rules for buildStep: compileCPP
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
else
endif

# ------------------------------------------------------------------------------------
# Rules for buildStep: link
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
${DISTDIR}/DLC01.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}: ${OBJECTFILES}  nbproject/Makefile-${CND_CONF}.mk    ../src/config/atsamd21g18a_default/ATSAMD21G18A.ld
	@${MKDIR} ${DISTDIR} 
	${MP_CC} $(MP_EXTRA_LD_PRE) -g   -mprocessor=$(MP_PROCESSOR_OPTION) -mno-device-startup-code -o ${DISTDIR}/DLC01.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX} ${OBJECTFILES_QUOTED_IF_SPACED}          -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -Wl,--defsym=__MPLAB_BUILD=1$(MP_EXTRA_LD_POST)$(MP_LINKER_FILE_OPTION),--defsym=__ICD2RAM=1,--defsym=__MPLAB_DEBUG=1,--defsym=__DEBUG=1,-D=__DEBUG_D,--defsym=_min_heap_size=512,--gc-sections,-Map="${DISTDIR}/${PROJECTNAME}.${IMAGE_TYPE}.map",--memorysummary,${DISTDIR}/memoryfile.xml -mdfp="${DFP_DIR}/samd21a"
	
else
${DISTDIR}/DLC01.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}: ${OBJECTFILES}  nbproject/Makefile-${CND_CONF}.mk   ../src/config/atsamd21g18a_default/ATSAMD21G18A.ld
	@${MKDIR} ${DISTDIR} 
	${MP_CC} $(MP_EXTRA_LD_PRE)  -mprocessor=$(MP_PROCESSOR_OPTION) -mno-device-startup-code -o ${DISTDIR}/DLC01.X.${IMAGE_TYPE}.${DEBUGGABLE_SUFFIX} ${OBJECTFILES_QUOTED_IF_SPACED}          -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -Wl,--defsym=__MPLAB_BUILD=1$(MP_EXTRA_LD_POST)$(MP_LINKER_FILE_OPTION),--defsym=_min_heap_size=512,--gc-sections,-Map="${DISTDIR}/${PROJECTNAME}.${IMAGE_TYPE}.map",--memorysummary,${DISTDIR}/memoryfile.xml -mdfp="${DFP_DIR}/samd21a"
	${MP_CC_DIR}\\xc32-bin2hex ${DISTDIR}/DLC01.X.${IMAGE_TYPE}.${DEBUGGABLE_SUFFIX} 
	@echo Normalizing hex file
	@"C:/Program Files/Microchip/MPLABX/v6.00/mplab_platform/platform/../mplab_ide/modules/../../bin/hexmate" --edf="C:/Program Files/Microchip/MPLABX/v6.00/mplab_platform/platform/../mplab_ide/modules/../../dat/en_msgs.txt" ${DISTDIR}/DLC01.X.${IMAGE_TYPE}.hex -o${DISTDIR}/DLC01.X.${IMAGE_TYPE}.hex

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
