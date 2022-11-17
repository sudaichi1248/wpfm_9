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
FINAL_IMAGE=${DISTDIR}/wpfm.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}
else
IMAGE_TYPE=production
OUTPUT_SUFFIX=hex
DEBUGGABLE_SUFFIX=elf
FINAL_IMAGE=${DISTDIR}/wpfm.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}
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
ProjectDir="D:\FCOM\wpfm_9\firmware\wpfm.X"
ProjectName=DLC
ConfName=atsamd21g18a_default
ImagePath="${DISTDIR}\wpfm.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}"
ImageDir="${DISTDIR}"
ImageName="wpfm.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}"
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
IsDebug="true"
else
IsDebug="false"
endif

.build-conf:  ${BUILD_SUBPROJECTS}
ifneq ($(INFORMATION_MESSAGE), )
	@echo $(INFORMATION_MESSAGE)
endif
	${MAKE}  -f nbproject/Makefile-atsamd21g18a_default.mk ${DISTDIR}/wpfm.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}
	@echo "--------------------------------------"
	@echo "User defined post-build step: [..\..\HEX2MOT ${ImagePath} ]"
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
${OBJECTDIR}/_ext/1814754785/drv_usbfsv1.o: ../src/config/atsamd21g18a_default/driver/usb/usbfsv1/src/drv_usbfsv1.c  .generated_files/flags/atsamd21g18a_default/dbd91eab4b78197dc8505ff033e6435dcfeb3d43 .generated_files/flags/atsamd21g18a_default/af5f9e26d98d06614ffc6c9a1f41ce910e5b7cd1
	@${MKDIR} "${OBJECTDIR}/_ext/1814754785" 
	@${RM} ${OBJECTDIR}/_ext/1814754785/drv_usbfsv1.o.d 
	@${RM} ${OBJECTDIR}/_ext/1814754785/drv_usbfsv1.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1814754785/drv_usbfsv1.o.d" -o ${OBJECTDIR}/_ext/1814754785/drv_usbfsv1.o ../src/config/atsamd21g18a_default/driver/usb/usbfsv1/src/drv_usbfsv1.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1814754785/drv_usbfsv1_device.o: ../src/config/atsamd21g18a_default/driver/usb/usbfsv1/src/drv_usbfsv1_device.c  .generated_files/flags/atsamd21g18a_default/de78a89139578a0805a0df618b0ed4ed25a603be .generated_files/flags/atsamd21g18a_default/af5f9e26d98d06614ffc6c9a1f41ce910e5b7cd1
	@${MKDIR} "${OBJECTDIR}/_ext/1814754785" 
	@${RM} ${OBJECTDIR}/_ext/1814754785/drv_usbfsv1_device.o.d 
	@${RM} ${OBJECTDIR}/_ext/1814754785/drv_usbfsv1_device.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1814754785/drv_usbfsv1_device.o.d" -o ${OBJECTDIR}/_ext/1814754785/drv_usbfsv1_device.o ../src/config/atsamd21g18a_default/driver/usb/usbfsv1/src/drv_usbfsv1_device.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1885044035/plib_adc.o: ../src/config/atsamd21g18a_default/peripheral/adc/plib_adc.c  .generated_files/flags/atsamd21g18a_default/669bdb39dc201717878cda6f02c59c59fefae81 .generated_files/flags/atsamd21g18a_default/af5f9e26d98d06614ffc6c9a1f41ce910e5b7cd1
	@${MKDIR} "${OBJECTDIR}/_ext/1885044035" 
	@${RM} ${OBJECTDIR}/_ext/1885044035/plib_adc.o.d 
	@${RM} ${OBJECTDIR}/_ext/1885044035/plib_adc.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1885044035/plib_adc.o.d" -o ${OBJECTDIR}/_ext/1885044035/plib_adc.o ../src/config/atsamd21g18a_default/peripheral/adc/plib_adc.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/950981355/plib_clock.o: ../src/config/atsamd21g18a_default/peripheral/clock/plib_clock.c  .generated_files/flags/atsamd21g18a_default/b204944eb0b1d90cfc4986ffdf5f49221976b0c1 .generated_files/flags/atsamd21g18a_default/af5f9e26d98d06614ffc6c9a1f41ce910e5b7cd1
	@${MKDIR} "${OBJECTDIR}/_ext/950981355" 
	@${RM} ${OBJECTDIR}/_ext/950981355/plib_clock.o.d 
	@${RM} ${OBJECTDIR}/_ext/950981355/plib_clock.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/950981355/plib_clock.o.d" -o ${OBJECTDIR}/_ext/950981355/plib_clock.o ../src/config/atsamd21g18a_default/peripheral/clock/plib_clock.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1885040036/plib_eic.o: ../src/config/atsamd21g18a_default/peripheral/eic/plib_eic.c  .generated_files/flags/atsamd21g18a_default/67574ea6fd9736dcac495d71592659bbfb1eb63 .generated_files/flags/atsamd21g18a_default/af5f9e26d98d06614ffc6c9a1f41ce910e5b7cd1
	@${MKDIR} "${OBJECTDIR}/_ext/1885040036" 
	@${RM} ${OBJECTDIR}/_ext/1885040036/plib_eic.o.d 
	@${RM} ${OBJECTDIR}/_ext/1885040036/plib_eic.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1885040036/plib_eic.o.d" -o ${OBJECTDIR}/_ext/1885040036/plib_eic.o ../src/config/atsamd21g18a_default/peripheral/eic/plib_eic.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/953130841/plib_evsys.o: ../src/config/atsamd21g18a_default/peripheral/evsys/plib_evsys.c  .generated_files/flags/atsamd21g18a_default/f38a526518fb67a6d9b26761673b1c8cbbcb8965 .generated_files/flags/atsamd21g18a_default/af5f9e26d98d06614ffc6c9a1f41ce910e5b7cd1
	@${MKDIR} "${OBJECTDIR}/_ext/953130841" 
	@${RM} ${OBJECTDIR}/_ext/953130841/plib_evsys.o.d 
	@${RM} ${OBJECTDIR}/_ext/953130841/plib_evsys.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/953130841/plib_evsys.o.d" -o ${OBJECTDIR}/_ext/953130841/plib_evsys.o ../src/config/atsamd21g18a_default/peripheral/evsys/plib_evsys.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1693581925/plib_nvic.o: ../src/config/atsamd21g18a_default/peripheral/nvic/plib_nvic.c  .generated_files/flags/atsamd21g18a_default/4b037221611c9e3b3cab528772eacd14a49ff596 .generated_files/flags/atsamd21g18a_default/af5f9e26d98d06614ffc6c9a1f41ce910e5b7cd1
	@${MKDIR} "${OBJECTDIR}/_ext/1693581925" 
	@${RM} ${OBJECTDIR}/_ext/1693581925/plib_nvic.o.d 
	@${RM} ${OBJECTDIR}/_ext/1693581925/plib_nvic.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1693581925/plib_nvic.o.d" -o ${OBJECTDIR}/_ext/1693581925/plib_nvic.o ../src/config/atsamd21g18a_default/peripheral/nvic/plib_nvic.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/522110765/plib_nvmctrl.o: ../src/config/atsamd21g18a_default/peripheral/nvmctrl/plib_nvmctrl.c  .generated_files/flags/atsamd21g18a_default/deb418564676257a1d14654f52b59ed803be8711 .generated_files/flags/atsamd21g18a_default/af5f9e26d98d06614ffc6c9a1f41ce910e5b7cd1
	@${MKDIR} "${OBJECTDIR}/_ext/522110765" 
	@${RM} ${OBJECTDIR}/_ext/522110765/plib_nvmctrl.o.d 
	@${RM} ${OBJECTDIR}/_ext/522110765/plib_nvmctrl.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/522110765/plib_nvmctrl.o.d" -o ${OBJECTDIR}/_ext/522110765/plib_nvmctrl.o ../src/config/atsamd21g18a_default/peripheral/nvmctrl/plib_nvmctrl.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1324665920/plib_pm.o: ../src/config/atsamd21g18a_default/peripheral/pm/plib_pm.c  .generated_files/flags/atsamd21g18a_default/7d70d7d1600a90b00419d8522e1cafb8be538f2c .generated_files/flags/atsamd21g18a_default/af5f9e26d98d06614ffc6c9a1f41ce910e5b7cd1
	@${MKDIR} "${OBJECTDIR}/_ext/1324665920" 
	@${RM} ${OBJECTDIR}/_ext/1324665920/plib_pm.o.d 
	@${RM} ${OBJECTDIR}/_ext/1324665920/plib_pm.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1324665920/plib_pm.o.d" -o ${OBJECTDIR}/_ext/1324665920/plib_pm.o ../src/config/atsamd21g18a_default/peripheral/pm/plib_pm.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1693635076/plib_port.o: ../src/config/atsamd21g18a_default/peripheral/port/plib_port.c  .generated_files/flags/atsamd21g18a_default/c328a1eea4c1531ce16567148635f34c1f565cf7 .generated_files/flags/atsamd21g18a_default/af5f9e26d98d06614ffc6c9a1f41ce910e5b7cd1
	@${MKDIR} "${OBJECTDIR}/_ext/1693635076" 
	@${RM} ${OBJECTDIR}/_ext/1693635076/plib_port.o.d 
	@${RM} ${OBJECTDIR}/_ext/1693635076/plib_port.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1693635076/plib_port.o.d" -o ${OBJECTDIR}/_ext/1693635076/plib_port.o ../src/config/atsamd21g18a_default/peripheral/port/plib_port.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/163103410/plib_sercom3_i2c_master.o: ../src/config/atsamd21g18a_default/peripheral/sercom/i2c_master/plib_sercom3_i2c_master.c  .generated_files/flags/atsamd21g18a_default/4cda0d250eafb65cac4dfdb5ddb7dcba95b744f3 .generated_files/flags/atsamd21g18a_default/af5f9e26d98d06614ffc6c9a1f41ce910e5b7cd1
	@${MKDIR} "${OBJECTDIR}/_ext/163103410" 
	@${RM} ${OBJECTDIR}/_ext/163103410/plib_sercom3_i2c_master.o.d 
	@${RM} ${OBJECTDIR}/_ext/163103410/plib_sercom3_i2c_master.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/163103410/plib_sercom3_i2c_master.o.d" -o ${OBJECTDIR}/_ext/163103410/plib_sercom3_i2c_master.o ../src/config/atsamd21g18a_default/peripheral/sercom/i2c_master/plib_sercom3_i2c_master.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/328131232/plib_sercom1_spi_master.o: ../src/config/atsamd21g18a_default/peripheral/sercom/spi_master/plib_sercom1_spi_master.c  .generated_files/flags/atsamd21g18a_default/5eb6da1d41c31fbc49fd47bc36a861f7dff99420 .generated_files/flags/atsamd21g18a_default/af5f9e26d98d06614ffc6c9a1f41ce910e5b7cd1
	@${MKDIR} "${OBJECTDIR}/_ext/328131232" 
	@${RM} ${OBJECTDIR}/_ext/328131232/plib_sercom1_spi_master.o.d 
	@${RM} ${OBJECTDIR}/_ext/328131232/plib_sercom1_spi_master.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/328131232/plib_sercom1_spi_master.o.d" -o ${OBJECTDIR}/_ext/328131232/plib_sercom1_spi_master.o ../src/config/atsamd21g18a_default/peripheral/sercom/spi_master/plib_sercom1_spi_master.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/472979226/plib_sercom0_usart.o: ../src/config/atsamd21g18a_default/peripheral/sercom/usart/plib_sercom0_usart.c  .generated_files/flags/atsamd21g18a_default/2ee9e20045dff891abebc4444680201026754335 .generated_files/flags/atsamd21g18a_default/af5f9e26d98d06614ffc6c9a1f41ce910e5b7cd1
	@${MKDIR} "${OBJECTDIR}/_ext/472979226" 
	@${RM} ${OBJECTDIR}/_ext/472979226/plib_sercom0_usart.o.d 
	@${RM} ${OBJECTDIR}/_ext/472979226/plib_sercom0_usart.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/472979226/plib_sercom0_usart.o.d" -o ${OBJECTDIR}/_ext/472979226/plib_sercom0_usart.o ../src/config/atsamd21g18a_default/peripheral/sercom/usart/plib_sercom0_usart.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/472979226/plib_sercom5_usart.o: ../src/config/atsamd21g18a_default/peripheral/sercom/usart/plib_sercom5_usart.c  .generated_files/flags/atsamd21g18a_default/f6c7faa3415a711d490711afa17bf962d13489aa .generated_files/flags/atsamd21g18a_default/af5f9e26d98d06614ffc6c9a1f41ce910e5b7cd1
	@${MKDIR} "${OBJECTDIR}/_ext/472979226" 
	@${RM} ${OBJECTDIR}/_ext/472979226/plib_sercom5_usart.o.d 
	@${RM} ${OBJECTDIR}/_ext/472979226/plib_sercom5_usart.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/472979226/plib_sercom5_usart.o.d" -o ${OBJECTDIR}/_ext/472979226/plib_sercom5_usart.o ../src/config/atsamd21g18a_default/peripheral/sercom/usart/plib_sercom5_usart.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/756585863/plib_systick.o: ../src/config/atsamd21g18a_default/peripheral/systick/plib_systick.c  .generated_files/flags/atsamd21g18a_default/8e5cf1e864868d115525898290694ad6ec5b8b68 .generated_files/flags/atsamd21g18a_default/af5f9e26d98d06614ffc6c9a1f41ce910e5b7cd1
	@${MKDIR} "${OBJECTDIR}/_ext/756585863" 
	@${RM} ${OBJECTDIR}/_ext/756585863/plib_systick.o.d 
	@${RM} ${OBJECTDIR}/_ext/756585863/plib_systick.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/756585863/plib_systick.o.d" -o ${OBJECTDIR}/_ext/756585863/plib_systick.o ../src/config/atsamd21g18a_default/peripheral/systick/plib_systick.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1324666034/plib_tc3.o: ../src/config/atsamd21g18a_default/peripheral/tc/plib_tc3.c  .generated_files/flags/atsamd21g18a_default/66d98c38869c165b659589a02fb2a71c65605230 .generated_files/flags/atsamd21g18a_default/af5f9e26d98d06614ffc6c9a1f41ce910e5b7cd1
	@${MKDIR} "${OBJECTDIR}/_ext/1324666034" 
	@${RM} ${OBJECTDIR}/_ext/1324666034/plib_tc3.o.d 
	@${RM} ${OBJECTDIR}/_ext/1324666034/plib_tc3.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1324666034/plib_tc3.o.d" -o ${OBJECTDIR}/_ext/1324666034/plib_tc3.o ../src/config/atsamd21g18a_default/peripheral/tc/plib_tc3.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1324666034/plib_tc4.o: ../src/config/atsamd21g18a_default/peripheral/tc/plib_tc4.c  .generated_files/flags/atsamd21g18a_default/8814367ee258ecc320cbd490d2ecf1ff0d13bea1 .generated_files/flags/atsamd21g18a_default/af5f9e26d98d06614ffc6c9a1f41ce910e5b7cd1
	@${MKDIR} "${OBJECTDIR}/_ext/1324666034" 
	@${RM} ${OBJECTDIR}/_ext/1324666034/plib_tc4.o.d 
	@${RM} ${OBJECTDIR}/_ext/1324666034/plib_tc4.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1324666034/plib_tc4.o.d" -o ${OBJECTDIR}/_ext/1324666034/plib_tc4.o ../src/config/atsamd21g18a_default/peripheral/tc/plib_tc4.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1324666034/plib_tc5.o: ../src/config/atsamd21g18a_default/peripheral/tc/plib_tc5.c  .generated_files/flags/atsamd21g18a_default/a74b0f2c2c305454a1481bb1c6d0b6c0d9e0b894 .generated_files/flags/atsamd21g18a_default/af5f9e26d98d06614ffc6c9a1f41ce910e5b7cd1
	@${MKDIR} "${OBJECTDIR}/_ext/1324666034" 
	@${RM} ${OBJECTDIR}/_ext/1324666034/plib_tc5.o.d 
	@${RM} ${OBJECTDIR}/_ext/1324666034/plib_tc5.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1324666034/plib_tc5.o.d" -o ${OBJECTDIR}/_ext/1324666034/plib_tc5.o ../src/config/atsamd21g18a_default/peripheral/tc/plib_tc5.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1885022876/plib_wdt.o: ../src/config/atsamd21g18a_default/peripheral/wdt/plib_wdt.c  .generated_files/flags/atsamd21g18a_default/3413ad1fb92197eb8bc266e23d0d267de65bac33 .generated_files/flags/atsamd21g18a_default/af5f9e26d98d06614ffc6c9a1f41ce910e5b7cd1
	@${MKDIR} "${OBJECTDIR}/_ext/1885022876" 
	@${RM} ${OBJECTDIR}/_ext/1885022876/plib_wdt.o.d 
	@${RM} ${OBJECTDIR}/_ext/1885022876/plib_wdt.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1885022876/plib_wdt.o.d" -o ${OBJECTDIR}/_ext/1885022876/plib_wdt.o ../src/config/atsamd21g18a_default/peripheral/wdt/plib_wdt.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/9958233/xc32_monitor.o: ../src/config/atsamd21g18a_default/stdio/xc32_monitor.c  .generated_files/flags/atsamd21g18a_default/fd2571304f174750f6d36208b566fc1f6d97b326 .generated_files/flags/atsamd21g18a_default/af5f9e26d98d06614ffc6c9a1f41ce910e5b7cd1
	@${MKDIR} "${OBJECTDIR}/_ext/9958233" 
	@${RM} ${OBJECTDIR}/_ext/9958233/xc32_monitor.o.d 
	@${RM} ${OBJECTDIR}/_ext/9958233/xc32_monitor.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/9958233/xc32_monitor.o.d" -o ${OBJECTDIR}/_ext/9958233/xc32_monitor.o ../src/config/atsamd21g18a_default/stdio/xc32_monitor.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/63538924/sys_int.o: ../src/config/atsamd21g18a_default/system/int/src/sys_int.c  .generated_files/flags/atsamd21g18a_default/cdbb2e35fe57f513ebf02a97ac217a9b59a58823 .generated_files/flags/atsamd21g18a_default/af5f9e26d98d06614ffc6c9a1f41ce910e5b7cd1
	@${MKDIR} "${OBJECTDIR}/_ext/63538924" 
	@${RM} ${OBJECTDIR}/_ext/63538924/sys_int.o.d 
	@${RM} ${OBJECTDIR}/_ext/63538924/sys_int.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/63538924/sys_int.o.d" -o ${OBJECTDIR}/_ext/63538924/sys_int.o ../src/config/atsamd21g18a_default/system/int/src/sys_int.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1572229207/usb_device.o: ../src/config/atsamd21g18a_default/usb/src/usb_device.c  .generated_files/flags/atsamd21g18a_default/d47e9ba2830046e5ae5bd87783c4fe9107e34614 .generated_files/flags/atsamd21g18a_default/af5f9e26d98d06614ffc6c9a1f41ce910e5b7cd1
	@${MKDIR} "${OBJECTDIR}/_ext/1572229207" 
	@${RM} ${OBJECTDIR}/_ext/1572229207/usb_device.o.d 
	@${RM} ${OBJECTDIR}/_ext/1572229207/usb_device.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1572229207/usb_device.o.d" -o ${OBJECTDIR}/_ext/1572229207/usb_device.o ../src/config/atsamd21g18a_default/usb/src/usb_device.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1572229207/usb_device_cdc.o: ../src/config/atsamd21g18a_default/usb/src/usb_device_cdc.c  .generated_files/flags/atsamd21g18a_default/ef0faa37e6bad44307e0623d71d073ad50d47258 .generated_files/flags/atsamd21g18a_default/af5f9e26d98d06614ffc6c9a1f41ce910e5b7cd1
	@${MKDIR} "${OBJECTDIR}/_ext/1572229207" 
	@${RM} ${OBJECTDIR}/_ext/1572229207/usb_device_cdc.o.d 
	@${RM} ${OBJECTDIR}/_ext/1572229207/usb_device_cdc.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1572229207/usb_device_cdc.o.d" -o ${OBJECTDIR}/_ext/1572229207/usb_device_cdc.o ../src/config/atsamd21g18a_default/usb/src/usb_device_cdc.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1572229207/usb_device_cdc_acm.o: ../src/config/atsamd21g18a_default/usb/src/usb_device_cdc_acm.c  .generated_files/flags/atsamd21g18a_default/ae1b1601a97511738391210ba7d4af5de455d07b .generated_files/flags/atsamd21g18a_default/af5f9e26d98d06614ffc6c9a1f41ce910e5b7cd1
	@${MKDIR} "${OBJECTDIR}/_ext/1572229207" 
	@${RM} ${OBJECTDIR}/_ext/1572229207/usb_device_cdc_acm.o.d 
	@${RM} ${OBJECTDIR}/_ext/1572229207/usb_device_cdc_acm.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1572229207/usb_device_cdc_acm.o.d" -o ${OBJECTDIR}/_ext/1572229207/usb_device_cdc_acm.o ../src/config/atsamd21g18a_default/usb/src/usb_device_cdc_acm.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1640317663/initialization.o: ../src/config/atsamd21g18a_default/initialization.c  .generated_files/flags/atsamd21g18a_default/7c681041258b0007a4120c8ab368f65e21d95b59 .generated_files/flags/atsamd21g18a_default/af5f9e26d98d06614ffc6c9a1f41ce910e5b7cd1
	@${MKDIR} "${OBJECTDIR}/_ext/1640317663" 
	@${RM} ${OBJECTDIR}/_ext/1640317663/initialization.o.d 
	@${RM} ${OBJECTDIR}/_ext/1640317663/initialization.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1640317663/initialization.o.d" -o ${OBJECTDIR}/_ext/1640317663/initialization.o ../src/config/atsamd21g18a_default/initialization.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1640317663/interrupts.o: ../src/config/atsamd21g18a_default/interrupts.c  .generated_files/flags/atsamd21g18a_default/a69f9939b3910208425de865a65e089d5972b65f .generated_files/flags/atsamd21g18a_default/af5f9e26d98d06614ffc6c9a1f41ce910e5b7cd1
	@${MKDIR} "${OBJECTDIR}/_ext/1640317663" 
	@${RM} ${OBJECTDIR}/_ext/1640317663/interrupts.o.d 
	@${RM} ${OBJECTDIR}/_ext/1640317663/interrupts.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1640317663/interrupts.o.d" -o ${OBJECTDIR}/_ext/1640317663/interrupts.o ../src/config/atsamd21g18a_default/interrupts.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1640317663/exceptions.o: ../src/config/atsamd21g18a_default/exceptions.c  .generated_files/flags/atsamd21g18a_default/d732393612b5babb5375c984501ffb6623202824 .generated_files/flags/atsamd21g18a_default/af5f9e26d98d06614ffc6c9a1f41ce910e5b7cd1
	@${MKDIR} "${OBJECTDIR}/_ext/1640317663" 
	@${RM} ${OBJECTDIR}/_ext/1640317663/exceptions.o.d 
	@${RM} ${OBJECTDIR}/_ext/1640317663/exceptions.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1640317663/exceptions.o.d" -o ${OBJECTDIR}/_ext/1640317663/exceptions.o ../src/config/atsamd21g18a_default/exceptions.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1640317663/startup_xc32.o: ../src/config/atsamd21g18a_default/startup_xc32.c  .generated_files/flags/atsamd21g18a_default/da9701fe081f450c0f57714cca91b99c78ef5804 .generated_files/flags/atsamd21g18a_default/af5f9e26d98d06614ffc6c9a1f41ce910e5b7cd1
	@${MKDIR} "${OBJECTDIR}/_ext/1640317663" 
	@${RM} ${OBJECTDIR}/_ext/1640317663/startup_xc32.o.d 
	@${RM} ${OBJECTDIR}/_ext/1640317663/startup_xc32.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1640317663/startup_xc32.o.d" -o ${OBJECTDIR}/_ext/1640317663/startup_xc32.o ../src/config/atsamd21g18a_default/startup_xc32.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1640317663/libc_syscalls.o: ../src/config/atsamd21g18a_default/libc_syscalls.c  .generated_files/flags/atsamd21g18a_default/f33616b495ebdd777015ecb536ae21cb1d5519d9 .generated_files/flags/atsamd21g18a_default/af5f9e26d98d06614ffc6c9a1f41ce910e5b7cd1
	@${MKDIR} "${OBJECTDIR}/_ext/1640317663" 
	@${RM} ${OBJECTDIR}/_ext/1640317663/libc_syscalls.o.d 
	@${RM} ${OBJECTDIR}/_ext/1640317663/libc_syscalls.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1640317663/libc_syscalls.o.d" -o ${OBJECTDIR}/_ext/1640317663/libc_syscalls.o ../src/config/atsamd21g18a_default/libc_syscalls.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1640317663/usb_device_init_data.o: ../src/config/atsamd21g18a_default/usb_device_init_data.c  .generated_files/flags/atsamd21g18a_default/4c2f16c6d5b37a3125b9abce1c0368b3c11017f5 .generated_files/flags/atsamd21g18a_default/af5f9e26d98d06614ffc6c9a1f41ce910e5b7cd1
	@${MKDIR} "${OBJECTDIR}/_ext/1640317663" 
	@${RM} ${OBJECTDIR}/_ext/1640317663/usb_device_init_data.o.d 
	@${RM} ${OBJECTDIR}/_ext/1640317663/usb_device_init_data.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1640317663/usb_device_init_data.o.d" -o ${OBJECTDIR}/_ext/1640317663/usb_device_init_data.o ../src/config/atsamd21g18a_default/usb_device_init_data.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1640317663/tasks.o: ../src/config/atsamd21g18a_default/tasks.c  .generated_files/flags/atsamd21g18a_default/eff785e19fa5956b91c622ac6296d3091d2a6e32 .generated_files/flags/atsamd21g18a_default/af5f9e26d98d06614ffc6c9a1f41ce910e5b7cd1
	@${MKDIR} "${OBJECTDIR}/_ext/1640317663" 
	@${RM} ${OBJECTDIR}/_ext/1640317663/tasks.o.d 
	@${RM} ${OBJECTDIR}/_ext/1640317663/tasks.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1640317663/tasks.o.d" -o ${OBJECTDIR}/_ext/1640317663/tasks.o ../src/config/atsamd21g18a_default/tasks.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/w25q128jv.o: ../src/w25q128jv.c  .generated_files/flags/atsamd21g18a_default/e32ce436797841080d5f7f2ca65c7f29aa87f692 .generated_files/flags/atsamd21g18a_default/af5f9e26d98d06614ffc6c9a1f41ce910e5b7cd1
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/w25q128jv.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/w25q128jv.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/w25q128jv.o.d" -o ${OBJECTDIR}/_ext/1360937237/w25q128jv.o ../src/w25q128jv.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/util.o: ../src/util.c  .generated_files/flags/atsamd21g18a_default/8310d630209ef96dac1034fc6313b924909e4c4a .generated_files/flags/atsamd21g18a_default/af5f9e26d98d06614ffc6c9a1f41ce910e5b7cd1
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/util.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/util.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/util.o.d" -o ${OBJECTDIR}/_ext/1360937237/util.o ../src/util.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/s5851a.o: ../src/s5851a.c  .generated_files/flags/atsamd21g18a_default/76a024bc582b94596dc3431daecde598ccbc332c .generated_files/flags/atsamd21g18a_default/af5f9e26d98d06614ffc6c9a1f41ce910e5b7cd1
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/s5851a.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/s5851a.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/s5851a.o.d" -o ${OBJECTDIR}/_ext/1360937237/s5851a.o ../src/s5851a.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/gpioexp.o: ../src/gpioexp.c  .generated_files/flags/atsamd21g18a_default/1d61b4102fc326be946bf861fce44f5d488542b5 .generated_files/flags/atsamd21g18a_default/af5f9e26d98d06614ffc6c9a1f41ce910e5b7cd1
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/gpioexp.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/gpioexp.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/gpioexp.o.d" -o ${OBJECTDIR}/_ext/1360937237/gpioexp.o ../src/gpioexp.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/rtc.o: ../src/rtc.c  .generated_files/flags/atsamd21g18a_default/b1184fcb373a6bd7ad6e447ecc92b7e743d5bfd7 .generated_files/flags/atsamd21g18a_default/af5f9e26d98d06614ffc6c9a1f41ce910e5b7cd1
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/rtc.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/rtc.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/rtc.o.d" -o ${OBJECTDIR}/_ext/1360937237/rtc.o ../src/rtc.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/mlog.o: ../src/mlog.c  .generated_files/flags/atsamd21g18a_default/38df04b08082109e81a7f989a565411473acdfa7 .generated_files/flags/atsamd21g18a_default/af5f9e26d98d06614ffc6c9a1f41ce910e5b7cd1
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/mlog.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/mlog.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/mlog.o.d" -o ${OBJECTDIR}/_ext/1360937237/mlog.o ../src/mlog.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/sensor.o: ../src/sensor.c  .generated_files/flags/atsamd21g18a_default/53aad89a5c36d11fe3831c2d5be2881e286edd91 .generated_files/flags/atsamd21g18a_default/af5f9e26d98d06614ffc6c9a1f41ce910e5b7cd1
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/sensor.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/sensor.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/sensor.o.d" -o ${OBJECTDIR}/_ext/1360937237/sensor.o ../src/sensor.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/uart_debug.o: ../src/uart_debug.c  .generated_files/flags/atsamd21g18a_default/f1578e3debf147bf29aefc2af6fd9e8ae80ce836 .generated_files/flags/atsamd21g18a_default/af5f9e26d98d06614ffc6c9a1f41ce910e5b7cd1
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/uart_debug.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/uart_debug.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/uart_debug.o.d" -o ${OBJECTDIR}/_ext/1360937237/uart_debug.o ../src/uart_debug.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/uart_comm.o: ../src/uart_comm.c  .generated_files/flags/atsamd21g18a_default/93273a602f262db9873cde4660750227b6758a8b .generated_files/flags/atsamd21g18a_default/af5f9e26d98d06614ffc6c9a1f41ce910e5b7cd1
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/uart_comm.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/uart_comm.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/uart_comm.o.d" -o ${OBJECTDIR}/_ext/1360937237/uart_comm.o ../src/uart_comm.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/wpfm.o: ../src/wpfm.c  .generated_files/flags/atsamd21g18a_default/6b09180f83faffe01c224c9e6bcf5e9a984d1e0 .generated_files/flags/atsamd21g18a_default/af5f9e26d98d06614ffc6c9a1f41ce910e5b7cd1
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/wpfm.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/wpfm.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/wpfm.o.d" -o ${OBJECTDIR}/_ext/1360937237/wpfm.o ../src/wpfm.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/battery.o: ../src/battery.c  .generated_files/flags/atsamd21g18a_default/e7726adc12b477b616e477ac04e72d3b5ee10a5e .generated_files/flags/atsamd21g18a_default/af5f9e26d98d06614ffc6c9a1f41ce910e5b7cd1
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/battery.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/battery.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/battery.o.d" -o ${OBJECTDIR}/_ext/1360937237/battery.o ../src/battery.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/communicate.o: ../src/communicate.c  .generated_files/flags/atsamd21g18a_default/f36979fc87ea9fd2a22defc61fb667fd60392e9d .generated_files/flags/atsamd21g18a_default/af5f9e26d98d06614ffc6c9a1f41ce910e5b7cd1
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/communicate.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/communicate.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/communicate.o.d" -o ${OBJECTDIR}/_ext/1360937237/communicate.o ../src/communicate.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/init.o: ../src/init.c  .generated_files/flags/atsamd21g18a_default/681add5904532f86da9e6255d6e8011f90c3cac7 .generated_files/flags/atsamd21g18a_default/af5f9e26d98d06614ffc6c9a1f41ce910e5b7cd1
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/init.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/init.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/init.o.d" -o ${OBJECTDIR}/_ext/1360937237/init.o ../src/init.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/measure.o: ../src/measure.c  .generated_files/flags/atsamd21g18a_default/22c7a28d7a2034d05f9cbc969ca19c6e112a7277 .generated_files/flags/atsamd21g18a_default/af5f9e26d98d06614ffc6c9a1f41ce910e5b7cd1
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/measure.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/measure.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/measure.o.d" -o ${OBJECTDIR}/_ext/1360937237/measure.o ../src/measure.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/alert.o: ../src/alert.c  .generated_files/flags/atsamd21g18a_default/5e21e8c3a749bd4e3884948ff22f021fc9bb365d .generated_files/flags/atsamd21g18a_default/af5f9e26d98d06614ffc6c9a1f41ce910e5b7cd1
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/alert.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/alert.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/alert.o.d" -o ${OBJECTDIR}/_ext/1360937237/alert.o ../src/alert.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/smpif4.o: ../src/smpif4.c  .generated_files/flags/atsamd21g18a_default/1d680b60c19cb107cae4e9634f043e9c2705e20f .generated_files/flags/atsamd21g18a_default/af5f9e26d98d06614ffc6c9a1f41ce910e5b7cd1
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/smpif4.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/smpif4.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/smpif4.o.d" -o ${OBJECTDIR}/_ext/1360937237/smpif4.o ../src/smpif4.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/smpif.o: ../src/smpif.c  .generated_files/flags/atsamd21g18a_default/bff0d349de36deccf2ba514e961501193e7a01ef .generated_files/flags/atsamd21g18a_default/af5f9e26d98d06614ffc6c9a1f41ce910e5b7cd1
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/smpif.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/smpif.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/smpif.o.d" -o ${OBJECTDIR}/_ext/1360937237/smpif.o ../src/smpif.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/smpif1.o: ../src/smpif1.c  .generated_files/flags/atsamd21g18a_default/dcbcd73f838588dba4d4bee32bb7e05022db28b7 .generated_files/flags/atsamd21g18a_default/af5f9e26d98d06614ffc6c9a1f41ce910e5b7cd1
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/smpif1.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/smpif1.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/smpif1.o.d" -o ${OBJECTDIR}/_ext/1360937237/smpif1.o ../src/smpif1.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/smpif2.o: ../src/smpif2.c  .generated_files/flags/atsamd21g18a_default/c57899d6c8a2750a3ba68d48664696170cabbe7d .generated_files/flags/atsamd21g18a_default/af5f9e26d98d06614ffc6c9a1f41ce910e5b7cd1
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/smpif2.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/smpif2.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/smpif2.o.d" -o ${OBJECTDIR}/_ext/1360937237/smpif2.o ../src/smpif2.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/smpif3.o: ../src/smpif3.c  .generated_files/flags/atsamd21g18a_default/384d1561f09a928e41e47eef075a6dcf28f176 .generated_files/flags/atsamd21g18a_default/af5f9e26d98d06614ffc6c9a1f41ce910e5b7cd1
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/smpif3.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/smpif3.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/smpif3.o.d" -o ${OBJECTDIR}/_ext/1360937237/smpif3.o ../src/smpif3.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/main.o: ../src/main.c  .generated_files/flags/atsamd21g18a_default/37949e68ea8223712b8f52d449d80a8b5b1e4fb6 .generated_files/flags/atsamd21g18a_default/af5f9e26d98d06614ffc6c9a1f41ce910e5b7cd1
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/main.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/main.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/main.o.d" -o ${OBJECTDIR}/_ext/1360937237/main.o ../src/main.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/app.o: ../src/app.c  .generated_files/flags/atsamd21g18a_default/ad51bcd6af08dfca619c08e6d11f1c04b8acfe6f .generated_files/flags/atsamd21g18a_default/af5f9e26d98d06614ffc6c9a1f41ce910e5b7cd1
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/app.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/app.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/app.o.d" -o ${OBJECTDIR}/_ext/1360937237/app.o ../src/app.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/MATcore.o: ../src/MATcore.c  .generated_files/flags/atsamd21g18a_default/a326a809b7f1e90ac7b6857f10d4f423819a4805 .generated_files/flags/atsamd21g18a_default/af5f9e26d98d06614ffc6c9a1f41ce910e5b7cd1
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/MATcore.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/MATcore.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/MATcore.o.d" -o ${OBJECTDIR}/_ext/1360937237/MATcore.o ../src/MATcore.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/moni.o: ../src/moni.c  .generated_files/flags/atsamd21g18a_default/ce3fdef9f3dd028d9b60094f384501384b1404b1 .generated_files/flags/atsamd21g18a_default/af5f9e26d98d06614ffc6c9a1f41ce910e5b7cd1
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/moni.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/moni.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/moni.o.d" -o ${OBJECTDIR}/_ext/1360937237/moni.o ../src/moni.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/version.o: ../src/version.c  .generated_files/flags/atsamd21g18a_default/5798d35991ca06e321126f2115eba75ef414bfa6 .generated_files/flags/atsamd21g18a_default/af5f9e26d98d06614ffc6c9a1f41ce910e5b7cd1
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/version.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/version.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/version.o.d" -o ${OBJECTDIR}/_ext/1360937237/version.o ../src/version.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/DLCpara.o: ../src/DLCpara.c  .generated_files/flags/atsamd21g18a_default/611cd66824ce9dd10c7d63c2215a54346b0d8822 .generated_files/flags/atsamd21g18a_default/af5f9e26d98d06614ffc6c9a1f41ce910e5b7cd1
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/DLCpara.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/DLCpara.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/DLCpara.o.d" -o ${OBJECTDIR}/_ext/1360937237/DLCpara.o ../src/DLCpara.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/EventLog.o: ../src/EventLog.c  .generated_files/flags/atsamd21g18a_default/141eb6e1865f627caf013d652dc231faf67c5b81 .generated_files/flags/atsamd21g18a_default/af5f9e26d98d06614ffc6c9a1f41ce910e5b7cd1
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/EventLog.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/EventLog.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/EventLog.o.d" -o ${OBJECTDIR}/_ext/1360937237/EventLog.o ../src/EventLog.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/FOTAcmd.o: ../src/FOTAcmd.c  .generated_files/flags/atsamd21g18a_default/16fc7d9c209765aff48370ee059ecb74345eefe3 .generated_files/flags/atsamd21g18a_default/af5f9e26d98d06614ffc6c9a1f41ce910e5b7cd1
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/FOTAcmd.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/FOTAcmd.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/FOTAcmd.o.d" -o ${OBJECTDIR}/_ext/1360937237/FOTAcmd.o ../src/FOTAcmd.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
else
${OBJECTDIR}/_ext/1814754785/drv_usbfsv1.o: ../src/config/atsamd21g18a_default/driver/usb/usbfsv1/src/drv_usbfsv1.c  .generated_files/flags/atsamd21g18a_default/5bd13475f2aa9bea9effb2996445228fd703c3a5 .generated_files/flags/atsamd21g18a_default/af5f9e26d98d06614ffc6c9a1f41ce910e5b7cd1
	@${MKDIR} "${OBJECTDIR}/_ext/1814754785" 
	@${RM} ${OBJECTDIR}/_ext/1814754785/drv_usbfsv1.o.d 
	@${RM} ${OBJECTDIR}/_ext/1814754785/drv_usbfsv1.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1814754785/drv_usbfsv1.o.d" -o ${OBJECTDIR}/_ext/1814754785/drv_usbfsv1.o ../src/config/atsamd21g18a_default/driver/usb/usbfsv1/src/drv_usbfsv1.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1814754785/drv_usbfsv1_device.o: ../src/config/atsamd21g18a_default/driver/usb/usbfsv1/src/drv_usbfsv1_device.c  .generated_files/flags/atsamd21g18a_default/ea9ecd00f79872f72d17dae420d4619f1ff48203 .generated_files/flags/atsamd21g18a_default/af5f9e26d98d06614ffc6c9a1f41ce910e5b7cd1
	@${MKDIR} "${OBJECTDIR}/_ext/1814754785" 
	@${RM} ${OBJECTDIR}/_ext/1814754785/drv_usbfsv1_device.o.d 
	@${RM} ${OBJECTDIR}/_ext/1814754785/drv_usbfsv1_device.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1814754785/drv_usbfsv1_device.o.d" -o ${OBJECTDIR}/_ext/1814754785/drv_usbfsv1_device.o ../src/config/atsamd21g18a_default/driver/usb/usbfsv1/src/drv_usbfsv1_device.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1885044035/plib_adc.o: ../src/config/atsamd21g18a_default/peripheral/adc/plib_adc.c  .generated_files/flags/atsamd21g18a_default/da04acfe8a42ad12fcd67a0693f34c43136731e3 .generated_files/flags/atsamd21g18a_default/af5f9e26d98d06614ffc6c9a1f41ce910e5b7cd1
	@${MKDIR} "${OBJECTDIR}/_ext/1885044035" 
	@${RM} ${OBJECTDIR}/_ext/1885044035/plib_adc.o.d 
	@${RM} ${OBJECTDIR}/_ext/1885044035/plib_adc.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1885044035/plib_adc.o.d" -o ${OBJECTDIR}/_ext/1885044035/plib_adc.o ../src/config/atsamd21g18a_default/peripheral/adc/plib_adc.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/950981355/plib_clock.o: ../src/config/atsamd21g18a_default/peripheral/clock/plib_clock.c  .generated_files/flags/atsamd21g18a_default/658422cb29dc85f7485529611c87beb15cb5d463 .generated_files/flags/atsamd21g18a_default/af5f9e26d98d06614ffc6c9a1f41ce910e5b7cd1
	@${MKDIR} "${OBJECTDIR}/_ext/950981355" 
	@${RM} ${OBJECTDIR}/_ext/950981355/plib_clock.o.d 
	@${RM} ${OBJECTDIR}/_ext/950981355/plib_clock.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/950981355/plib_clock.o.d" -o ${OBJECTDIR}/_ext/950981355/plib_clock.o ../src/config/atsamd21g18a_default/peripheral/clock/plib_clock.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1885040036/plib_eic.o: ../src/config/atsamd21g18a_default/peripheral/eic/plib_eic.c  .generated_files/flags/atsamd21g18a_default/86cc474657d08c980fda5d5ea8727525b113a96d .generated_files/flags/atsamd21g18a_default/af5f9e26d98d06614ffc6c9a1f41ce910e5b7cd1
	@${MKDIR} "${OBJECTDIR}/_ext/1885040036" 
	@${RM} ${OBJECTDIR}/_ext/1885040036/plib_eic.o.d 
	@${RM} ${OBJECTDIR}/_ext/1885040036/plib_eic.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1885040036/plib_eic.o.d" -o ${OBJECTDIR}/_ext/1885040036/plib_eic.o ../src/config/atsamd21g18a_default/peripheral/eic/plib_eic.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/953130841/plib_evsys.o: ../src/config/atsamd21g18a_default/peripheral/evsys/plib_evsys.c  .generated_files/flags/atsamd21g18a_default/7359f70616514f5fb8d0196520b72e1908ec375 .generated_files/flags/atsamd21g18a_default/af5f9e26d98d06614ffc6c9a1f41ce910e5b7cd1
	@${MKDIR} "${OBJECTDIR}/_ext/953130841" 
	@${RM} ${OBJECTDIR}/_ext/953130841/plib_evsys.o.d 
	@${RM} ${OBJECTDIR}/_ext/953130841/plib_evsys.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/953130841/plib_evsys.o.d" -o ${OBJECTDIR}/_ext/953130841/plib_evsys.o ../src/config/atsamd21g18a_default/peripheral/evsys/plib_evsys.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1693581925/plib_nvic.o: ../src/config/atsamd21g18a_default/peripheral/nvic/plib_nvic.c  .generated_files/flags/atsamd21g18a_default/145eca5c3786963c26088ec8717f4614def55f43 .generated_files/flags/atsamd21g18a_default/af5f9e26d98d06614ffc6c9a1f41ce910e5b7cd1
	@${MKDIR} "${OBJECTDIR}/_ext/1693581925" 
	@${RM} ${OBJECTDIR}/_ext/1693581925/plib_nvic.o.d 
	@${RM} ${OBJECTDIR}/_ext/1693581925/plib_nvic.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1693581925/plib_nvic.o.d" -o ${OBJECTDIR}/_ext/1693581925/plib_nvic.o ../src/config/atsamd21g18a_default/peripheral/nvic/plib_nvic.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/522110765/plib_nvmctrl.o: ../src/config/atsamd21g18a_default/peripheral/nvmctrl/plib_nvmctrl.c  .generated_files/flags/atsamd21g18a_default/b30c2e48d80d229db6c18a3b72674320b4d5fda8 .generated_files/flags/atsamd21g18a_default/af5f9e26d98d06614ffc6c9a1f41ce910e5b7cd1
	@${MKDIR} "${OBJECTDIR}/_ext/522110765" 
	@${RM} ${OBJECTDIR}/_ext/522110765/plib_nvmctrl.o.d 
	@${RM} ${OBJECTDIR}/_ext/522110765/plib_nvmctrl.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/522110765/plib_nvmctrl.o.d" -o ${OBJECTDIR}/_ext/522110765/plib_nvmctrl.o ../src/config/atsamd21g18a_default/peripheral/nvmctrl/plib_nvmctrl.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1324665920/plib_pm.o: ../src/config/atsamd21g18a_default/peripheral/pm/plib_pm.c  .generated_files/flags/atsamd21g18a_default/e7f8d7b1fde8ca11cbf6742692cf3ff9f643ab32 .generated_files/flags/atsamd21g18a_default/af5f9e26d98d06614ffc6c9a1f41ce910e5b7cd1
	@${MKDIR} "${OBJECTDIR}/_ext/1324665920" 
	@${RM} ${OBJECTDIR}/_ext/1324665920/plib_pm.o.d 
	@${RM} ${OBJECTDIR}/_ext/1324665920/plib_pm.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1324665920/plib_pm.o.d" -o ${OBJECTDIR}/_ext/1324665920/plib_pm.o ../src/config/atsamd21g18a_default/peripheral/pm/plib_pm.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1693635076/plib_port.o: ../src/config/atsamd21g18a_default/peripheral/port/plib_port.c  .generated_files/flags/atsamd21g18a_default/a3ee62cf38f372f21e6d9acd53d5b5277cae3c8e .generated_files/flags/atsamd21g18a_default/af5f9e26d98d06614ffc6c9a1f41ce910e5b7cd1
	@${MKDIR} "${OBJECTDIR}/_ext/1693635076" 
	@${RM} ${OBJECTDIR}/_ext/1693635076/plib_port.o.d 
	@${RM} ${OBJECTDIR}/_ext/1693635076/plib_port.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1693635076/plib_port.o.d" -o ${OBJECTDIR}/_ext/1693635076/plib_port.o ../src/config/atsamd21g18a_default/peripheral/port/plib_port.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/163103410/plib_sercom3_i2c_master.o: ../src/config/atsamd21g18a_default/peripheral/sercom/i2c_master/plib_sercom3_i2c_master.c  .generated_files/flags/atsamd21g18a_default/66729014aab1bd3183859aae90fd2721afafdad .generated_files/flags/atsamd21g18a_default/af5f9e26d98d06614ffc6c9a1f41ce910e5b7cd1
	@${MKDIR} "${OBJECTDIR}/_ext/163103410" 
	@${RM} ${OBJECTDIR}/_ext/163103410/plib_sercom3_i2c_master.o.d 
	@${RM} ${OBJECTDIR}/_ext/163103410/plib_sercom3_i2c_master.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/163103410/plib_sercom3_i2c_master.o.d" -o ${OBJECTDIR}/_ext/163103410/plib_sercom3_i2c_master.o ../src/config/atsamd21g18a_default/peripheral/sercom/i2c_master/plib_sercom3_i2c_master.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/328131232/plib_sercom1_spi_master.o: ../src/config/atsamd21g18a_default/peripheral/sercom/spi_master/plib_sercom1_spi_master.c  .generated_files/flags/atsamd21g18a_default/108ae79b27f891cbc795d97a89057dca06639bd3 .generated_files/flags/atsamd21g18a_default/af5f9e26d98d06614ffc6c9a1f41ce910e5b7cd1
	@${MKDIR} "${OBJECTDIR}/_ext/328131232" 
	@${RM} ${OBJECTDIR}/_ext/328131232/plib_sercom1_spi_master.o.d 
	@${RM} ${OBJECTDIR}/_ext/328131232/plib_sercom1_spi_master.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/328131232/plib_sercom1_spi_master.o.d" -o ${OBJECTDIR}/_ext/328131232/plib_sercom1_spi_master.o ../src/config/atsamd21g18a_default/peripheral/sercom/spi_master/plib_sercom1_spi_master.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/472979226/plib_sercom0_usart.o: ../src/config/atsamd21g18a_default/peripheral/sercom/usart/plib_sercom0_usart.c  .generated_files/flags/atsamd21g18a_default/8cbf1826c2e1bd3d5d9484ba91125d16443f1682 .generated_files/flags/atsamd21g18a_default/af5f9e26d98d06614ffc6c9a1f41ce910e5b7cd1
	@${MKDIR} "${OBJECTDIR}/_ext/472979226" 
	@${RM} ${OBJECTDIR}/_ext/472979226/plib_sercom0_usart.o.d 
	@${RM} ${OBJECTDIR}/_ext/472979226/plib_sercom0_usart.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/472979226/plib_sercom0_usart.o.d" -o ${OBJECTDIR}/_ext/472979226/plib_sercom0_usart.o ../src/config/atsamd21g18a_default/peripheral/sercom/usart/plib_sercom0_usart.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/472979226/plib_sercom5_usart.o: ../src/config/atsamd21g18a_default/peripheral/sercom/usart/plib_sercom5_usart.c  .generated_files/flags/atsamd21g18a_default/be3f6db04266fe401a34672257b12d780cd954db .generated_files/flags/atsamd21g18a_default/af5f9e26d98d06614ffc6c9a1f41ce910e5b7cd1
	@${MKDIR} "${OBJECTDIR}/_ext/472979226" 
	@${RM} ${OBJECTDIR}/_ext/472979226/plib_sercom5_usart.o.d 
	@${RM} ${OBJECTDIR}/_ext/472979226/plib_sercom5_usart.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/472979226/plib_sercom5_usart.o.d" -o ${OBJECTDIR}/_ext/472979226/plib_sercom5_usart.o ../src/config/atsamd21g18a_default/peripheral/sercom/usart/plib_sercom5_usart.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/756585863/plib_systick.o: ../src/config/atsamd21g18a_default/peripheral/systick/plib_systick.c  .generated_files/flags/atsamd21g18a_default/e5373f9e17999e5cb5a33bf87e133bbf8614c31b .generated_files/flags/atsamd21g18a_default/af5f9e26d98d06614ffc6c9a1f41ce910e5b7cd1
	@${MKDIR} "${OBJECTDIR}/_ext/756585863" 
	@${RM} ${OBJECTDIR}/_ext/756585863/plib_systick.o.d 
	@${RM} ${OBJECTDIR}/_ext/756585863/plib_systick.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/756585863/plib_systick.o.d" -o ${OBJECTDIR}/_ext/756585863/plib_systick.o ../src/config/atsamd21g18a_default/peripheral/systick/plib_systick.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1324666034/plib_tc3.o: ../src/config/atsamd21g18a_default/peripheral/tc/plib_tc3.c  .generated_files/flags/atsamd21g18a_default/f2e2e2c18654cb84c21e70dc525599350e27c186 .generated_files/flags/atsamd21g18a_default/af5f9e26d98d06614ffc6c9a1f41ce910e5b7cd1
	@${MKDIR} "${OBJECTDIR}/_ext/1324666034" 
	@${RM} ${OBJECTDIR}/_ext/1324666034/plib_tc3.o.d 
	@${RM} ${OBJECTDIR}/_ext/1324666034/plib_tc3.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1324666034/plib_tc3.o.d" -o ${OBJECTDIR}/_ext/1324666034/plib_tc3.o ../src/config/atsamd21g18a_default/peripheral/tc/plib_tc3.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1324666034/plib_tc4.o: ../src/config/atsamd21g18a_default/peripheral/tc/plib_tc4.c  .generated_files/flags/atsamd21g18a_default/9c4177b5f54bbbe23650101c18e7cc3fe97f4415 .generated_files/flags/atsamd21g18a_default/af5f9e26d98d06614ffc6c9a1f41ce910e5b7cd1
	@${MKDIR} "${OBJECTDIR}/_ext/1324666034" 
	@${RM} ${OBJECTDIR}/_ext/1324666034/plib_tc4.o.d 
	@${RM} ${OBJECTDIR}/_ext/1324666034/plib_tc4.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1324666034/plib_tc4.o.d" -o ${OBJECTDIR}/_ext/1324666034/plib_tc4.o ../src/config/atsamd21g18a_default/peripheral/tc/plib_tc4.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1324666034/plib_tc5.o: ../src/config/atsamd21g18a_default/peripheral/tc/plib_tc5.c  .generated_files/flags/atsamd21g18a_default/dcd438a22203f01b9f4ac0e3c2a7c3cf5f49c7f0 .generated_files/flags/atsamd21g18a_default/af5f9e26d98d06614ffc6c9a1f41ce910e5b7cd1
	@${MKDIR} "${OBJECTDIR}/_ext/1324666034" 
	@${RM} ${OBJECTDIR}/_ext/1324666034/plib_tc5.o.d 
	@${RM} ${OBJECTDIR}/_ext/1324666034/plib_tc5.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1324666034/plib_tc5.o.d" -o ${OBJECTDIR}/_ext/1324666034/plib_tc5.o ../src/config/atsamd21g18a_default/peripheral/tc/plib_tc5.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1885022876/plib_wdt.o: ../src/config/atsamd21g18a_default/peripheral/wdt/plib_wdt.c  .generated_files/flags/atsamd21g18a_default/4100f50d94d45bf915bdc2e6a6c0c9c174c89122 .generated_files/flags/atsamd21g18a_default/af5f9e26d98d06614ffc6c9a1f41ce910e5b7cd1
	@${MKDIR} "${OBJECTDIR}/_ext/1885022876" 
	@${RM} ${OBJECTDIR}/_ext/1885022876/plib_wdt.o.d 
	@${RM} ${OBJECTDIR}/_ext/1885022876/plib_wdt.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1885022876/plib_wdt.o.d" -o ${OBJECTDIR}/_ext/1885022876/plib_wdt.o ../src/config/atsamd21g18a_default/peripheral/wdt/plib_wdt.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/9958233/xc32_monitor.o: ../src/config/atsamd21g18a_default/stdio/xc32_monitor.c  .generated_files/flags/atsamd21g18a_default/98f1d4f94122f0057207c20f2a98bc4ffcfd93eb .generated_files/flags/atsamd21g18a_default/af5f9e26d98d06614ffc6c9a1f41ce910e5b7cd1
	@${MKDIR} "${OBJECTDIR}/_ext/9958233" 
	@${RM} ${OBJECTDIR}/_ext/9958233/xc32_monitor.o.d 
	@${RM} ${OBJECTDIR}/_ext/9958233/xc32_monitor.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/9958233/xc32_monitor.o.d" -o ${OBJECTDIR}/_ext/9958233/xc32_monitor.o ../src/config/atsamd21g18a_default/stdio/xc32_monitor.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/63538924/sys_int.o: ../src/config/atsamd21g18a_default/system/int/src/sys_int.c  .generated_files/flags/atsamd21g18a_default/18f892e8a10101eacd873952bc05e7483dfe8c4e .generated_files/flags/atsamd21g18a_default/af5f9e26d98d06614ffc6c9a1f41ce910e5b7cd1
	@${MKDIR} "${OBJECTDIR}/_ext/63538924" 
	@${RM} ${OBJECTDIR}/_ext/63538924/sys_int.o.d 
	@${RM} ${OBJECTDIR}/_ext/63538924/sys_int.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/63538924/sys_int.o.d" -o ${OBJECTDIR}/_ext/63538924/sys_int.o ../src/config/atsamd21g18a_default/system/int/src/sys_int.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1572229207/usb_device.o: ../src/config/atsamd21g18a_default/usb/src/usb_device.c  .generated_files/flags/atsamd21g18a_default/81a9c15c61b2ff64f94ec88f7cd5c6031067d188 .generated_files/flags/atsamd21g18a_default/af5f9e26d98d06614ffc6c9a1f41ce910e5b7cd1
	@${MKDIR} "${OBJECTDIR}/_ext/1572229207" 
	@${RM} ${OBJECTDIR}/_ext/1572229207/usb_device.o.d 
	@${RM} ${OBJECTDIR}/_ext/1572229207/usb_device.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1572229207/usb_device.o.d" -o ${OBJECTDIR}/_ext/1572229207/usb_device.o ../src/config/atsamd21g18a_default/usb/src/usb_device.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1572229207/usb_device_cdc.o: ../src/config/atsamd21g18a_default/usb/src/usb_device_cdc.c  .generated_files/flags/atsamd21g18a_default/b6739d94a53772deb886e08250552a0d3ae6308c .generated_files/flags/atsamd21g18a_default/af5f9e26d98d06614ffc6c9a1f41ce910e5b7cd1
	@${MKDIR} "${OBJECTDIR}/_ext/1572229207" 
	@${RM} ${OBJECTDIR}/_ext/1572229207/usb_device_cdc.o.d 
	@${RM} ${OBJECTDIR}/_ext/1572229207/usb_device_cdc.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1572229207/usb_device_cdc.o.d" -o ${OBJECTDIR}/_ext/1572229207/usb_device_cdc.o ../src/config/atsamd21g18a_default/usb/src/usb_device_cdc.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1572229207/usb_device_cdc_acm.o: ../src/config/atsamd21g18a_default/usb/src/usb_device_cdc_acm.c  .generated_files/flags/atsamd21g18a_default/95995c6ae36d29c905963b25e65beae40a5f5fc1 .generated_files/flags/atsamd21g18a_default/af5f9e26d98d06614ffc6c9a1f41ce910e5b7cd1
	@${MKDIR} "${OBJECTDIR}/_ext/1572229207" 
	@${RM} ${OBJECTDIR}/_ext/1572229207/usb_device_cdc_acm.o.d 
	@${RM} ${OBJECTDIR}/_ext/1572229207/usb_device_cdc_acm.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1572229207/usb_device_cdc_acm.o.d" -o ${OBJECTDIR}/_ext/1572229207/usb_device_cdc_acm.o ../src/config/atsamd21g18a_default/usb/src/usb_device_cdc_acm.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1640317663/initialization.o: ../src/config/atsamd21g18a_default/initialization.c  .generated_files/flags/atsamd21g18a_default/a381a13dbae940c312a49bf0751a4ae0c2cd4799 .generated_files/flags/atsamd21g18a_default/af5f9e26d98d06614ffc6c9a1f41ce910e5b7cd1
	@${MKDIR} "${OBJECTDIR}/_ext/1640317663" 
	@${RM} ${OBJECTDIR}/_ext/1640317663/initialization.o.d 
	@${RM} ${OBJECTDIR}/_ext/1640317663/initialization.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1640317663/initialization.o.d" -o ${OBJECTDIR}/_ext/1640317663/initialization.o ../src/config/atsamd21g18a_default/initialization.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1640317663/interrupts.o: ../src/config/atsamd21g18a_default/interrupts.c  .generated_files/flags/atsamd21g18a_default/a73e29725c746c771e05d86d03f390a303ef9c1f .generated_files/flags/atsamd21g18a_default/af5f9e26d98d06614ffc6c9a1f41ce910e5b7cd1
	@${MKDIR} "${OBJECTDIR}/_ext/1640317663" 
	@${RM} ${OBJECTDIR}/_ext/1640317663/interrupts.o.d 
	@${RM} ${OBJECTDIR}/_ext/1640317663/interrupts.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1640317663/interrupts.o.d" -o ${OBJECTDIR}/_ext/1640317663/interrupts.o ../src/config/atsamd21g18a_default/interrupts.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1640317663/exceptions.o: ../src/config/atsamd21g18a_default/exceptions.c  .generated_files/flags/atsamd21g18a_default/5a8db60a7147c00ebf6503ea7cd2bddf99c32d10 .generated_files/flags/atsamd21g18a_default/af5f9e26d98d06614ffc6c9a1f41ce910e5b7cd1
	@${MKDIR} "${OBJECTDIR}/_ext/1640317663" 
	@${RM} ${OBJECTDIR}/_ext/1640317663/exceptions.o.d 
	@${RM} ${OBJECTDIR}/_ext/1640317663/exceptions.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1640317663/exceptions.o.d" -o ${OBJECTDIR}/_ext/1640317663/exceptions.o ../src/config/atsamd21g18a_default/exceptions.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1640317663/startup_xc32.o: ../src/config/atsamd21g18a_default/startup_xc32.c  .generated_files/flags/atsamd21g18a_default/7e7e85b540329eecb0b9e0b7ba31b3908b6c7d6 .generated_files/flags/atsamd21g18a_default/af5f9e26d98d06614ffc6c9a1f41ce910e5b7cd1
	@${MKDIR} "${OBJECTDIR}/_ext/1640317663" 
	@${RM} ${OBJECTDIR}/_ext/1640317663/startup_xc32.o.d 
	@${RM} ${OBJECTDIR}/_ext/1640317663/startup_xc32.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1640317663/startup_xc32.o.d" -o ${OBJECTDIR}/_ext/1640317663/startup_xc32.o ../src/config/atsamd21g18a_default/startup_xc32.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1640317663/libc_syscalls.o: ../src/config/atsamd21g18a_default/libc_syscalls.c  .generated_files/flags/atsamd21g18a_default/3cebce5bdd09ce7673b9b653c15928a8ca0a0f21 .generated_files/flags/atsamd21g18a_default/af5f9e26d98d06614ffc6c9a1f41ce910e5b7cd1
	@${MKDIR} "${OBJECTDIR}/_ext/1640317663" 
	@${RM} ${OBJECTDIR}/_ext/1640317663/libc_syscalls.o.d 
	@${RM} ${OBJECTDIR}/_ext/1640317663/libc_syscalls.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1640317663/libc_syscalls.o.d" -o ${OBJECTDIR}/_ext/1640317663/libc_syscalls.o ../src/config/atsamd21g18a_default/libc_syscalls.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1640317663/usb_device_init_data.o: ../src/config/atsamd21g18a_default/usb_device_init_data.c  .generated_files/flags/atsamd21g18a_default/7674ee4f714d723d7a70f62847997569ab69be33 .generated_files/flags/atsamd21g18a_default/af5f9e26d98d06614ffc6c9a1f41ce910e5b7cd1
	@${MKDIR} "${OBJECTDIR}/_ext/1640317663" 
	@${RM} ${OBJECTDIR}/_ext/1640317663/usb_device_init_data.o.d 
	@${RM} ${OBJECTDIR}/_ext/1640317663/usb_device_init_data.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1640317663/usb_device_init_data.o.d" -o ${OBJECTDIR}/_ext/1640317663/usb_device_init_data.o ../src/config/atsamd21g18a_default/usb_device_init_data.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1640317663/tasks.o: ../src/config/atsamd21g18a_default/tasks.c  .generated_files/flags/atsamd21g18a_default/cab5251d671e1af80af33a8f38b7426deda8747e .generated_files/flags/atsamd21g18a_default/af5f9e26d98d06614ffc6c9a1f41ce910e5b7cd1
	@${MKDIR} "${OBJECTDIR}/_ext/1640317663" 
	@${RM} ${OBJECTDIR}/_ext/1640317663/tasks.o.d 
	@${RM} ${OBJECTDIR}/_ext/1640317663/tasks.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1640317663/tasks.o.d" -o ${OBJECTDIR}/_ext/1640317663/tasks.o ../src/config/atsamd21g18a_default/tasks.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/w25q128jv.o: ../src/w25q128jv.c  .generated_files/flags/atsamd21g18a_default/f0a411e1f347a3cc9f89a04378bd1a5336128363 .generated_files/flags/atsamd21g18a_default/af5f9e26d98d06614ffc6c9a1f41ce910e5b7cd1
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/w25q128jv.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/w25q128jv.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/w25q128jv.o.d" -o ${OBJECTDIR}/_ext/1360937237/w25q128jv.o ../src/w25q128jv.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/util.o: ../src/util.c  .generated_files/flags/atsamd21g18a_default/71cd330da856e414b20c6af537baf2aefd26c99c .generated_files/flags/atsamd21g18a_default/af5f9e26d98d06614ffc6c9a1f41ce910e5b7cd1
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/util.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/util.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/util.o.d" -o ${OBJECTDIR}/_ext/1360937237/util.o ../src/util.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/s5851a.o: ../src/s5851a.c  .generated_files/flags/atsamd21g18a_default/b175c1eb5f50054575bbc9b45872ffc3de3b66ec .generated_files/flags/atsamd21g18a_default/af5f9e26d98d06614ffc6c9a1f41ce910e5b7cd1
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/s5851a.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/s5851a.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/s5851a.o.d" -o ${OBJECTDIR}/_ext/1360937237/s5851a.o ../src/s5851a.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/gpioexp.o: ../src/gpioexp.c  .generated_files/flags/atsamd21g18a_default/eac344c56a4250aa2f466cfa381094a56051b3c1 .generated_files/flags/atsamd21g18a_default/af5f9e26d98d06614ffc6c9a1f41ce910e5b7cd1
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/gpioexp.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/gpioexp.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/gpioexp.o.d" -o ${OBJECTDIR}/_ext/1360937237/gpioexp.o ../src/gpioexp.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/rtc.o: ../src/rtc.c  .generated_files/flags/atsamd21g18a_default/9da6be23803b3611c2585124a4b759f76646da8d .generated_files/flags/atsamd21g18a_default/af5f9e26d98d06614ffc6c9a1f41ce910e5b7cd1
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/rtc.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/rtc.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/rtc.o.d" -o ${OBJECTDIR}/_ext/1360937237/rtc.o ../src/rtc.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/mlog.o: ../src/mlog.c  .generated_files/flags/atsamd21g18a_default/cf8dabcebe40e14eb4cd172c3b8670421cbca48a .generated_files/flags/atsamd21g18a_default/af5f9e26d98d06614ffc6c9a1f41ce910e5b7cd1
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/mlog.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/mlog.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/mlog.o.d" -o ${OBJECTDIR}/_ext/1360937237/mlog.o ../src/mlog.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/sensor.o: ../src/sensor.c  .generated_files/flags/atsamd21g18a_default/f29864693205860a99a9948e5691c6c3db9ec599 .generated_files/flags/atsamd21g18a_default/af5f9e26d98d06614ffc6c9a1f41ce910e5b7cd1
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/sensor.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/sensor.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/sensor.o.d" -o ${OBJECTDIR}/_ext/1360937237/sensor.o ../src/sensor.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/uart_debug.o: ../src/uart_debug.c  .generated_files/flags/atsamd21g18a_default/8aaab0c01f5885940385eb515703091ac69f7e51 .generated_files/flags/atsamd21g18a_default/af5f9e26d98d06614ffc6c9a1f41ce910e5b7cd1
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/uart_debug.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/uart_debug.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/uart_debug.o.d" -o ${OBJECTDIR}/_ext/1360937237/uart_debug.o ../src/uart_debug.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/uart_comm.o: ../src/uart_comm.c  .generated_files/flags/atsamd21g18a_default/bac41244c6e56c526bc328852f3d7552afc03080 .generated_files/flags/atsamd21g18a_default/af5f9e26d98d06614ffc6c9a1f41ce910e5b7cd1
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/uart_comm.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/uart_comm.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/uart_comm.o.d" -o ${OBJECTDIR}/_ext/1360937237/uart_comm.o ../src/uart_comm.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/wpfm.o: ../src/wpfm.c  .generated_files/flags/atsamd21g18a_default/3b24fcee550738420d965ad7524c1715e6346888 .generated_files/flags/atsamd21g18a_default/af5f9e26d98d06614ffc6c9a1f41ce910e5b7cd1
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/wpfm.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/wpfm.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/wpfm.o.d" -o ${OBJECTDIR}/_ext/1360937237/wpfm.o ../src/wpfm.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/battery.o: ../src/battery.c  .generated_files/flags/atsamd21g18a_default/3fc576f13d671dc2d5dc37523bf37a8f715d09df .generated_files/flags/atsamd21g18a_default/af5f9e26d98d06614ffc6c9a1f41ce910e5b7cd1
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/battery.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/battery.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/battery.o.d" -o ${OBJECTDIR}/_ext/1360937237/battery.o ../src/battery.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/communicate.o: ../src/communicate.c  .generated_files/flags/atsamd21g18a_default/558dad39d6782fa878d7b96d0a3ec0ffca674b5c .generated_files/flags/atsamd21g18a_default/af5f9e26d98d06614ffc6c9a1f41ce910e5b7cd1
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/communicate.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/communicate.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/communicate.o.d" -o ${OBJECTDIR}/_ext/1360937237/communicate.o ../src/communicate.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/init.o: ../src/init.c  .generated_files/flags/atsamd21g18a_default/5b9532f4b220dad7f830499e24e585f69fe390cb .generated_files/flags/atsamd21g18a_default/af5f9e26d98d06614ffc6c9a1f41ce910e5b7cd1
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/init.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/init.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/init.o.d" -o ${OBJECTDIR}/_ext/1360937237/init.o ../src/init.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/measure.o: ../src/measure.c  .generated_files/flags/atsamd21g18a_default/6828943dcebeb4f5a3c6ac41908dd6e2801dd48c .generated_files/flags/atsamd21g18a_default/af5f9e26d98d06614ffc6c9a1f41ce910e5b7cd1
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/measure.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/measure.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/measure.o.d" -o ${OBJECTDIR}/_ext/1360937237/measure.o ../src/measure.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/alert.o: ../src/alert.c  .generated_files/flags/atsamd21g18a_default/1f87cfad4ca68be2aba7e2d9ee459951c1cc1d83 .generated_files/flags/atsamd21g18a_default/af5f9e26d98d06614ffc6c9a1f41ce910e5b7cd1
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/alert.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/alert.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/alert.o.d" -o ${OBJECTDIR}/_ext/1360937237/alert.o ../src/alert.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/smpif4.o: ../src/smpif4.c  .generated_files/flags/atsamd21g18a_default/bfe5ee1c7935b940148814c35892b2518eb09c61 .generated_files/flags/atsamd21g18a_default/af5f9e26d98d06614ffc6c9a1f41ce910e5b7cd1
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/smpif4.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/smpif4.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/smpif4.o.d" -o ${OBJECTDIR}/_ext/1360937237/smpif4.o ../src/smpif4.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/smpif.o: ../src/smpif.c  .generated_files/flags/atsamd21g18a_default/87ba174d088948f87f22d39cf6358856dd9077b3 .generated_files/flags/atsamd21g18a_default/af5f9e26d98d06614ffc6c9a1f41ce910e5b7cd1
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/smpif.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/smpif.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/smpif.o.d" -o ${OBJECTDIR}/_ext/1360937237/smpif.o ../src/smpif.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/smpif1.o: ../src/smpif1.c  .generated_files/flags/atsamd21g18a_default/8623e7e0ef5427a8f76da36593f8f1e296a0ca3f .generated_files/flags/atsamd21g18a_default/af5f9e26d98d06614ffc6c9a1f41ce910e5b7cd1
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/smpif1.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/smpif1.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/smpif1.o.d" -o ${OBJECTDIR}/_ext/1360937237/smpif1.o ../src/smpif1.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/smpif2.o: ../src/smpif2.c  .generated_files/flags/atsamd21g18a_default/ecfcb2e00b76998c4bac66ef3bbf4ec834d52016 .generated_files/flags/atsamd21g18a_default/af5f9e26d98d06614ffc6c9a1f41ce910e5b7cd1
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/smpif2.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/smpif2.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/smpif2.o.d" -o ${OBJECTDIR}/_ext/1360937237/smpif2.o ../src/smpif2.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/smpif3.o: ../src/smpif3.c  .generated_files/flags/atsamd21g18a_default/da15410451171374e7efa08140bf7706bc80c2b1 .generated_files/flags/atsamd21g18a_default/af5f9e26d98d06614ffc6c9a1f41ce910e5b7cd1
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/smpif3.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/smpif3.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/smpif3.o.d" -o ${OBJECTDIR}/_ext/1360937237/smpif3.o ../src/smpif3.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/main.o: ../src/main.c  .generated_files/flags/atsamd21g18a_default/de02186d7267a47ceb28ed0fc543ce8a21c353d7 .generated_files/flags/atsamd21g18a_default/af5f9e26d98d06614ffc6c9a1f41ce910e5b7cd1
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/main.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/main.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/main.o.d" -o ${OBJECTDIR}/_ext/1360937237/main.o ../src/main.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/app.o: ../src/app.c  .generated_files/flags/atsamd21g18a_default/511bde442a768314357fc5ddae0d78e9a1a958e5 .generated_files/flags/atsamd21g18a_default/af5f9e26d98d06614ffc6c9a1f41ce910e5b7cd1
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/app.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/app.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/app.o.d" -o ${OBJECTDIR}/_ext/1360937237/app.o ../src/app.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/MATcore.o: ../src/MATcore.c  .generated_files/flags/atsamd21g18a_default/e78a81e40b871e30f8139e38d68eca7dd54c0d1d .generated_files/flags/atsamd21g18a_default/af5f9e26d98d06614ffc6c9a1f41ce910e5b7cd1
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/MATcore.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/MATcore.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/MATcore.o.d" -o ${OBJECTDIR}/_ext/1360937237/MATcore.o ../src/MATcore.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/moni.o: ../src/moni.c  .generated_files/flags/atsamd21g18a_default/84ee880b385b3ab06cf81800abf2448e880edc7d .generated_files/flags/atsamd21g18a_default/af5f9e26d98d06614ffc6c9a1f41ce910e5b7cd1
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/moni.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/moni.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/moni.o.d" -o ${OBJECTDIR}/_ext/1360937237/moni.o ../src/moni.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/version.o: ../src/version.c  .generated_files/flags/atsamd21g18a_default/375992ea04f40de6a230fcb663ac410c94ea6f6f .generated_files/flags/atsamd21g18a_default/af5f9e26d98d06614ffc6c9a1f41ce910e5b7cd1
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/version.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/version.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/version.o.d" -o ${OBJECTDIR}/_ext/1360937237/version.o ../src/version.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/DLCpara.o: ../src/DLCpara.c  .generated_files/flags/atsamd21g18a_default/8793c82ccb52b6a361ad167abdd28b596c64fc2d .generated_files/flags/atsamd21g18a_default/af5f9e26d98d06614ffc6c9a1f41ce910e5b7cd1
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/DLCpara.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/DLCpara.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/DLCpara.o.d" -o ${OBJECTDIR}/_ext/1360937237/DLCpara.o ../src/DLCpara.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/EventLog.o: ../src/EventLog.c  .generated_files/flags/atsamd21g18a_default/f1a9f4919ab1de6f80795f5e4523548eedd32dcf .generated_files/flags/atsamd21g18a_default/af5f9e26d98d06614ffc6c9a1f41ce910e5b7cd1
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/EventLog.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/EventLog.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/EventLog.o.d" -o ${OBJECTDIR}/_ext/1360937237/EventLog.o ../src/EventLog.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/FOTAcmd.o: ../src/FOTAcmd.c  .generated_files/flags/atsamd21g18a_default/3f2866a96e0628125aed0e049df2af1100db504c .generated_files/flags/atsamd21g18a_default/af5f9e26d98d06614ffc6c9a1f41ce910e5b7cd1
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
${DISTDIR}/wpfm.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}: ${OBJECTFILES}  nbproject/Makefile-${CND_CONF}.mk    ../src/config/atsamd21g18a_default/ATSAMD21G18A.ld
	@${MKDIR} ${DISTDIR} 
	${MP_CC} $(MP_EXTRA_LD_PRE) -g   -mprocessor=$(MP_PROCESSOR_OPTION) -mno-device-startup-code -o ${DISTDIR}/wpfm.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX} ${OBJECTFILES_QUOTED_IF_SPACED}          -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -Wl,--defsym=__MPLAB_BUILD=1$(MP_EXTRA_LD_POST)$(MP_LINKER_FILE_OPTION),--defsym=__ICD2RAM=1,--defsym=__MPLAB_DEBUG=1,--defsym=__DEBUG=1,-D=__DEBUG_D,--defsym=_min_heap_size=512,--gc-sections,-Map="${DISTDIR}/${PROJECTNAME}.${IMAGE_TYPE}.map",--memorysummary,${DISTDIR}/memoryfile.xml -mdfp="${DFP_DIR}/samd21a"
	
else
${DISTDIR}/wpfm.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}: ${OBJECTFILES}  nbproject/Makefile-${CND_CONF}.mk   ../src/config/atsamd21g18a_default/ATSAMD21G18A.ld
	@${MKDIR} ${DISTDIR} 
	${MP_CC} $(MP_EXTRA_LD_PRE)  -mprocessor=$(MP_PROCESSOR_OPTION) -mno-device-startup-code -o ${DISTDIR}/wpfm.X.${IMAGE_TYPE}.${DEBUGGABLE_SUFFIX} ${OBJECTFILES_QUOTED_IF_SPACED}          -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -Wl,--defsym=__MPLAB_BUILD=1$(MP_EXTRA_LD_POST)$(MP_LINKER_FILE_OPTION),--defsym=_min_heap_size=512,--gc-sections,-Map="${DISTDIR}/${PROJECTNAME}.${IMAGE_TYPE}.map",--memorysummary,${DISTDIR}/memoryfile.xml -mdfp="${DFP_DIR}/samd21a"
	${MP_CC_DIR}\\xc32-bin2hex ${DISTDIR}/wpfm.X.${IMAGE_TYPE}.${DEBUGGABLE_SUFFIX} 
	@echo Normalizing hex file
	@"C:/Program Files/Microchip/MPLABX/v6.00/mplab_platform/platform/../mplab_ide/modules/../../bin/hexmate" --edf="C:/Program Files/Microchip/MPLABX/v6.00/mplab_platform/platform/../mplab_ide/modules/../../dat/en_msgs.txt" ${DISTDIR}/wpfm.X.${IMAGE_TYPE}.hex -o${DISTDIR}/wpfm.X.${IMAGE_TYPE}.hex

endif


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
