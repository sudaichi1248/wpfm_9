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
FINAL_IMAGE=${DISTDIR}/DLC02.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}
else
IMAGE_TYPE=production
OUTPUT_SUFFIX=hex
DEBUGGABLE_SUFFIX=elf
FINAL_IMAGE=${DISTDIR}/DLC02.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}
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
ProjectDir="D:\FCOM\DLC01\firmware\DLC02.X"
ProjectName=DLC02
ConfName=atsamd21g18a_default
ImagePath="${DISTDIR}\DLC02.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}"
ImageDir="${DISTDIR}"
ImageName="DLC02.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}"
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
IsDebug="true"
else
IsDebug="false"
endif

.build-conf:  .pre ${BUILD_SUBPROJECTS}
ifneq ($(INFORMATION_MESSAGE), )
	@echo $(INFORMATION_MESSAGE)
endif
	${MAKE}  -f nbproject/Makefile-atsamd21g18a_default.mk ${DISTDIR}/DLC02.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}
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
${OBJECTDIR}/_ext/1814754785/drv_usbfsv1.o: ../src/config/atsamd21g18a_default/driver/usb/usbfsv1/src/drv_usbfsv1.c  .generated_files/flags/atsamd21g18a_default/873721bc63b63f644107cfc5d9ef2d6bc7cc3a75 .generated_files/flags/atsamd21g18a_default/371f82de429950eaa99b35fa67f9d4c59ae13e52
	@${MKDIR} "${OBJECTDIR}/_ext/1814754785" 
	@${RM} ${OBJECTDIR}/_ext/1814754785/drv_usbfsv1.o.d 
	@${RM} ${OBJECTDIR}/_ext/1814754785/drv_usbfsv1.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1814754785/drv_usbfsv1.o.d" -o ${OBJECTDIR}/_ext/1814754785/drv_usbfsv1.o ../src/config/atsamd21g18a_default/driver/usb/usbfsv1/src/drv_usbfsv1.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -D_Version2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1814754785/drv_usbfsv1_device.o: ../src/config/atsamd21g18a_default/driver/usb/usbfsv1/src/drv_usbfsv1_device.c  .generated_files/flags/atsamd21g18a_default/2ab4a9779565bfc45a7828e81e666ab639364105 .generated_files/flags/atsamd21g18a_default/371f82de429950eaa99b35fa67f9d4c59ae13e52
	@${MKDIR} "${OBJECTDIR}/_ext/1814754785" 
	@${RM} ${OBJECTDIR}/_ext/1814754785/drv_usbfsv1_device.o.d 
	@${RM} ${OBJECTDIR}/_ext/1814754785/drv_usbfsv1_device.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1814754785/drv_usbfsv1_device.o.d" -o ${OBJECTDIR}/_ext/1814754785/drv_usbfsv1_device.o ../src/config/atsamd21g18a_default/driver/usb/usbfsv1/src/drv_usbfsv1_device.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -D_Version2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1885044035/plib_adc.o: ../src/config/atsamd21g18a_default/peripheral/adc/plib_adc.c  .generated_files/flags/atsamd21g18a_default/3925b4f1b1532d20a3ba11bae5f1e8d44feb2392 .generated_files/flags/atsamd21g18a_default/371f82de429950eaa99b35fa67f9d4c59ae13e52
	@${MKDIR} "${OBJECTDIR}/_ext/1885044035" 
	@${RM} ${OBJECTDIR}/_ext/1885044035/plib_adc.o.d 
	@${RM} ${OBJECTDIR}/_ext/1885044035/plib_adc.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1885044035/plib_adc.o.d" -o ${OBJECTDIR}/_ext/1885044035/plib_adc.o ../src/config/atsamd21g18a_default/peripheral/adc/plib_adc.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -D_Version2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/950981355/plib_clock.o: ../src/config/atsamd21g18a_default/peripheral/clock/plib_clock.c  .generated_files/flags/atsamd21g18a_default/6eda18e2849e55857e9411cdbe17823df81e38ba .generated_files/flags/atsamd21g18a_default/371f82de429950eaa99b35fa67f9d4c59ae13e52
	@${MKDIR} "${OBJECTDIR}/_ext/950981355" 
	@${RM} ${OBJECTDIR}/_ext/950981355/plib_clock.o.d 
	@${RM} ${OBJECTDIR}/_ext/950981355/plib_clock.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/950981355/plib_clock.o.d" -o ${OBJECTDIR}/_ext/950981355/plib_clock.o ../src/config/atsamd21g18a_default/peripheral/clock/plib_clock.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -D_Version2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1885040036/plib_eic.o: ../src/config/atsamd21g18a_default/peripheral/eic/plib_eic.c  .generated_files/flags/atsamd21g18a_default/8adc87ea886b5f25688617bbfec1cc2b46f9f9cc .generated_files/flags/atsamd21g18a_default/371f82de429950eaa99b35fa67f9d4c59ae13e52
	@${MKDIR} "${OBJECTDIR}/_ext/1885040036" 
	@${RM} ${OBJECTDIR}/_ext/1885040036/plib_eic.o.d 
	@${RM} ${OBJECTDIR}/_ext/1885040036/plib_eic.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1885040036/plib_eic.o.d" -o ${OBJECTDIR}/_ext/1885040036/plib_eic.o ../src/config/atsamd21g18a_default/peripheral/eic/plib_eic.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -D_Version2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/953130841/plib_evsys.o: ../src/config/atsamd21g18a_default/peripheral/evsys/plib_evsys.c  .generated_files/flags/atsamd21g18a_default/cde3c3c53882743ee02abdf9b60ddf5881744139 .generated_files/flags/atsamd21g18a_default/371f82de429950eaa99b35fa67f9d4c59ae13e52
	@${MKDIR} "${OBJECTDIR}/_ext/953130841" 
	@${RM} ${OBJECTDIR}/_ext/953130841/plib_evsys.o.d 
	@${RM} ${OBJECTDIR}/_ext/953130841/plib_evsys.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/953130841/plib_evsys.o.d" -o ${OBJECTDIR}/_ext/953130841/plib_evsys.o ../src/config/atsamd21g18a_default/peripheral/evsys/plib_evsys.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -D_Version2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1693581925/plib_nvic.o: ../src/config/atsamd21g18a_default/peripheral/nvic/plib_nvic.c  .generated_files/flags/atsamd21g18a_default/ec1dfdecce97535f17fbe4c6c4eb98553642f2aa .generated_files/flags/atsamd21g18a_default/371f82de429950eaa99b35fa67f9d4c59ae13e52
	@${MKDIR} "${OBJECTDIR}/_ext/1693581925" 
	@${RM} ${OBJECTDIR}/_ext/1693581925/plib_nvic.o.d 
	@${RM} ${OBJECTDIR}/_ext/1693581925/plib_nvic.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1693581925/plib_nvic.o.d" -o ${OBJECTDIR}/_ext/1693581925/plib_nvic.o ../src/config/atsamd21g18a_default/peripheral/nvic/plib_nvic.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -D_Version2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/522110765/plib_nvmctrl.o: ../src/config/atsamd21g18a_default/peripheral/nvmctrl/plib_nvmctrl.c  .generated_files/flags/atsamd21g18a_default/c896786d50481ecca85a8c18207d79c4b812ac89 .generated_files/flags/atsamd21g18a_default/371f82de429950eaa99b35fa67f9d4c59ae13e52
	@${MKDIR} "${OBJECTDIR}/_ext/522110765" 
	@${RM} ${OBJECTDIR}/_ext/522110765/plib_nvmctrl.o.d 
	@${RM} ${OBJECTDIR}/_ext/522110765/plib_nvmctrl.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/522110765/plib_nvmctrl.o.d" -o ${OBJECTDIR}/_ext/522110765/plib_nvmctrl.o ../src/config/atsamd21g18a_default/peripheral/nvmctrl/plib_nvmctrl.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -D_Version2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1324665920/plib_pm.o: ../src/config/atsamd21g18a_default/peripheral/pm/plib_pm.c  .generated_files/flags/atsamd21g18a_default/49e68b4cb77b90c9ff5907a21118e444772d576d .generated_files/flags/atsamd21g18a_default/371f82de429950eaa99b35fa67f9d4c59ae13e52
	@${MKDIR} "${OBJECTDIR}/_ext/1324665920" 
	@${RM} ${OBJECTDIR}/_ext/1324665920/plib_pm.o.d 
	@${RM} ${OBJECTDIR}/_ext/1324665920/plib_pm.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1324665920/plib_pm.o.d" -o ${OBJECTDIR}/_ext/1324665920/plib_pm.o ../src/config/atsamd21g18a_default/peripheral/pm/plib_pm.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -D_Version2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1693635076/plib_port.o: ../src/config/atsamd21g18a_default/peripheral/port/plib_port.c  .generated_files/flags/atsamd21g18a_default/6b9d8f17f5170620cadc722ca3fa9ae8c4ff4dae .generated_files/flags/atsamd21g18a_default/371f82de429950eaa99b35fa67f9d4c59ae13e52
	@${MKDIR} "${OBJECTDIR}/_ext/1693635076" 
	@${RM} ${OBJECTDIR}/_ext/1693635076/plib_port.o.d 
	@${RM} ${OBJECTDIR}/_ext/1693635076/plib_port.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1693635076/plib_port.o.d" -o ${OBJECTDIR}/_ext/1693635076/plib_port.o ../src/config/atsamd21g18a_default/peripheral/port/plib_port.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -D_Version2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/163103410/plib_sercom3_i2c_master.o: ../src/config/atsamd21g18a_default/peripheral/sercom/i2c_master/plib_sercom3_i2c_master.c  .generated_files/flags/atsamd21g18a_default/5a190815c085a8b6414392cb1bea983032feb8de .generated_files/flags/atsamd21g18a_default/371f82de429950eaa99b35fa67f9d4c59ae13e52
	@${MKDIR} "${OBJECTDIR}/_ext/163103410" 
	@${RM} ${OBJECTDIR}/_ext/163103410/plib_sercom3_i2c_master.o.d 
	@${RM} ${OBJECTDIR}/_ext/163103410/plib_sercom3_i2c_master.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/163103410/plib_sercom3_i2c_master.o.d" -o ${OBJECTDIR}/_ext/163103410/plib_sercom3_i2c_master.o ../src/config/atsamd21g18a_default/peripheral/sercom/i2c_master/plib_sercom3_i2c_master.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -D_Version2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/328131232/plib_sercom1_spi_master.o: ../src/config/atsamd21g18a_default/peripheral/sercom/spi_master/plib_sercom1_spi_master.c  .generated_files/flags/atsamd21g18a_default/9d8ed30fd862bca1b24aa3ce9aae3492772a3d7d .generated_files/flags/atsamd21g18a_default/371f82de429950eaa99b35fa67f9d4c59ae13e52
	@${MKDIR} "${OBJECTDIR}/_ext/328131232" 
	@${RM} ${OBJECTDIR}/_ext/328131232/plib_sercom1_spi_master.o.d 
	@${RM} ${OBJECTDIR}/_ext/328131232/plib_sercom1_spi_master.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/328131232/plib_sercom1_spi_master.o.d" -o ${OBJECTDIR}/_ext/328131232/plib_sercom1_spi_master.o ../src/config/atsamd21g18a_default/peripheral/sercom/spi_master/plib_sercom1_spi_master.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -D_Version2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/472979226/plib_sercom0_usart.o: ../src/config/atsamd21g18a_default/peripheral/sercom/usart/plib_sercom0_usart.c  .generated_files/flags/atsamd21g18a_default/8f1b24a81d1d23250ab3cd6080f016a108568f60 .generated_files/flags/atsamd21g18a_default/371f82de429950eaa99b35fa67f9d4c59ae13e52
	@${MKDIR} "${OBJECTDIR}/_ext/472979226" 
	@${RM} ${OBJECTDIR}/_ext/472979226/plib_sercom0_usart.o.d 
	@${RM} ${OBJECTDIR}/_ext/472979226/plib_sercom0_usart.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/472979226/plib_sercom0_usart.o.d" -o ${OBJECTDIR}/_ext/472979226/plib_sercom0_usart.o ../src/config/atsamd21g18a_default/peripheral/sercom/usart/plib_sercom0_usart.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -D_Version2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/472979226/plib_sercom5_usart.o: ../src/config/atsamd21g18a_default/peripheral/sercom/usart/plib_sercom5_usart.c  .generated_files/flags/atsamd21g18a_default/e8e70a7da4d3c2397bdd8b1a6c90686ab0a41c50 .generated_files/flags/atsamd21g18a_default/371f82de429950eaa99b35fa67f9d4c59ae13e52
	@${MKDIR} "${OBJECTDIR}/_ext/472979226" 
	@${RM} ${OBJECTDIR}/_ext/472979226/plib_sercom5_usart.o.d 
	@${RM} ${OBJECTDIR}/_ext/472979226/plib_sercom5_usart.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/472979226/plib_sercom5_usart.o.d" -o ${OBJECTDIR}/_ext/472979226/plib_sercom5_usart.o ../src/config/atsamd21g18a_default/peripheral/sercom/usart/plib_sercom5_usart.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -D_Version2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/756585863/plib_systick.o: ../src/config/atsamd21g18a_default/peripheral/systick/plib_systick.c  .generated_files/flags/atsamd21g18a_default/24ebc61de8f5d536c57be25858582a5c64ed1103 .generated_files/flags/atsamd21g18a_default/371f82de429950eaa99b35fa67f9d4c59ae13e52
	@${MKDIR} "${OBJECTDIR}/_ext/756585863" 
	@${RM} ${OBJECTDIR}/_ext/756585863/plib_systick.o.d 
	@${RM} ${OBJECTDIR}/_ext/756585863/plib_systick.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/756585863/plib_systick.o.d" -o ${OBJECTDIR}/_ext/756585863/plib_systick.o ../src/config/atsamd21g18a_default/peripheral/systick/plib_systick.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -D_Version2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1324666034/plib_tc3.o: ../src/config/atsamd21g18a_default/peripheral/tc/plib_tc3.c  .generated_files/flags/atsamd21g18a_default/563fc70c155f00996d01daf514a1fd98d757b91 .generated_files/flags/atsamd21g18a_default/371f82de429950eaa99b35fa67f9d4c59ae13e52
	@${MKDIR} "${OBJECTDIR}/_ext/1324666034" 
	@${RM} ${OBJECTDIR}/_ext/1324666034/plib_tc3.o.d 
	@${RM} ${OBJECTDIR}/_ext/1324666034/plib_tc3.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1324666034/plib_tc3.o.d" -o ${OBJECTDIR}/_ext/1324666034/plib_tc3.o ../src/config/atsamd21g18a_default/peripheral/tc/plib_tc3.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -D_Version2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1324666034/plib_tc4.o: ../src/config/atsamd21g18a_default/peripheral/tc/plib_tc4.c  .generated_files/flags/atsamd21g18a_default/6a9181801ab0b2d69d1b78bd1b5acd1535192b03 .generated_files/flags/atsamd21g18a_default/371f82de429950eaa99b35fa67f9d4c59ae13e52
	@${MKDIR} "${OBJECTDIR}/_ext/1324666034" 
	@${RM} ${OBJECTDIR}/_ext/1324666034/plib_tc4.o.d 
	@${RM} ${OBJECTDIR}/_ext/1324666034/plib_tc4.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1324666034/plib_tc4.o.d" -o ${OBJECTDIR}/_ext/1324666034/plib_tc4.o ../src/config/atsamd21g18a_default/peripheral/tc/plib_tc4.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -D_Version2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1324666034/plib_tc5.o: ../src/config/atsamd21g18a_default/peripheral/tc/plib_tc5.c  .generated_files/flags/atsamd21g18a_default/8d561c1986e4388a6bd893db07ed232152a9c024 .generated_files/flags/atsamd21g18a_default/371f82de429950eaa99b35fa67f9d4c59ae13e52
	@${MKDIR} "${OBJECTDIR}/_ext/1324666034" 
	@${RM} ${OBJECTDIR}/_ext/1324666034/plib_tc5.o.d 
	@${RM} ${OBJECTDIR}/_ext/1324666034/plib_tc5.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1324666034/plib_tc5.o.d" -o ${OBJECTDIR}/_ext/1324666034/plib_tc5.o ../src/config/atsamd21g18a_default/peripheral/tc/plib_tc5.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -D_Version2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1885022876/plib_wdt.o: ../src/config/atsamd21g18a_default/peripheral/wdt/plib_wdt.c  .generated_files/flags/atsamd21g18a_default/3bfb5cd2dbd1f84e1ba38d81df652b70920d0cd2 .generated_files/flags/atsamd21g18a_default/371f82de429950eaa99b35fa67f9d4c59ae13e52
	@${MKDIR} "${OBJECTDIR}/_ext/1885022876" 
	@${RM} ${OBJECTDIR}/_ext/1885022876/plib_wdt.o.d 
	@${RM} ${OBJECTDIR}/_ext/1885022876/plib_wdt.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1885022876/plib_wdt.o.d" -o ${OBJECTDIR}/_ext/1885022876/plib_wdt.o ../src/config/atsamd21g18a_default/peripheral/wdt/plib_wdt.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -D_Version2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/9958233/xc32_monitor.o: ../src/config/atsamd21g18a_default/stdio/xc32_monitor.c  .generated_files/flags/atsamd21g18a_default/2a49f2d5e1a0e9348aebff7ae93529901c3cd54a .generated_files/flags/atsamd21g18a_default/371f82de429950eaa99b35fa67f9d4c59ae13e52
	@${MKDIR} "${OBJECTDIR}/_ext/9958233" 
	@${RM} ${OBJECTDIR}/_ext/9958233/xc32_monitor.o.d 
	@${RM} ${OBJECTDIR}/_ext/9958233/xc32_monitor.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/9958233/xc32_monitor.o.d" -o ${OBJECTDIR}/_ext/9958233/xc32_monitor.o ../src/config/atsamd21g18a_default/stdio/xc32_monitor.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -D_Version2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/63538924/sys_int.o: ../src/config/atsamd21g18a_default/system/int/src/sys_int.c  .generated_files/flags/atsamd21g18a_default/4796156c99afced1751fd4e927cccecc2cc400e9 .generated_files/flags/atsamd21g18a_default/371f82de429950eaa99b35fa67f9d4c59ae13e52
	@${MKDIR} "${OBJECTDIR}/_ext/63538924" 
	@${RM} ${OBJECTDIR}/_ext/63538924/sys_int.o.d 
	@${RM} ${OBJECTDIR}/_ext/63538924/sys_int.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/63538924/sys_int.o.d" -o ${OBJECTDIR}/_ext/63538924/sys_int.o ../src/config/atsamd21g18a_default/system/int/src/sys_int.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -D_Version2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1572229207/usb_device.o: ../src/config/atsamd21g18a_default/usb/src/usb_device.c  .generated_files/flags/atsamd21g18a_default/bdd5208c869189d5b6a76db2c161606c9b80cb76 .generated_files/flags/atsamd21g18a_default/371f82de429950eaa99b35fa67f9d4c59ae13e52
	@${MKDIR} "${OBJECTDIR}/_ext/1572229207" 
	@${RM} ${OBJECTDIR}/_ext/1572229207/usb_device.o.d 
	@${RM} ${OBJECTDIR}/_ext/1572229207/usb_device.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1572229207/usb_device.o.d" -o ${OBJECTDIR}/_ext/1572229207/usb_device.o ../src/config/atsamd21g18a_default/usb/src/usb_device.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -D_Version2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1572229207/usb_device_cdc.o: ../src/config/atsamd21g18a_default/usb/src/usb_device_cdc.c  .generated_files/flags/atsamd21g18a_default/fa4cc621bd9ae88ccb7003498a9bd61886db4635 .generated_files/flags/atsamd21g18a_default/371f82de429950eaa99b35fa67f9d4c59ae13e52
	@${MKDIR} "${OBJECTDIR}/_ext/1572229207" 
	@${RM} ${OBJECTDIR}/_ext/1572229207/usb_device_cdc.o.d 
	@${RM} ${OBJECTDIR}/_ext/1572229207/usb_device_cdc.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1572229207/usb_device_cdc.o.d" -o ${OBJECTDIR}/_ext/1572229207/usb_device_cdc.o ../src/config/atsamd21g18a_default/usb/src/usb_device_cdc.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -D_Version2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1572229207/usb_device_cdc_acm.o: ../src/config/atsamd21g18a_default/usb/src/usb_device_cdc_acm.c  .generated_files/flags/atsamd21g18a_default/77ca8753aa4fab0f2d87ac09a9902c5b200d2bf5 .generated_files/flags/atsamd21g18a_default/371f82de429950eaa99b35fa67f9d4c59ae13e52
	@${MKDIR} "${OBJECTDIR}/_ext/1572229207" 
	@${RM} ${OBJECTDIR}/_ext/1572229207/usb_device_cdc_acm.o.d 
	@${RM} ${OBJECTDIR}/_ext/1572229207/usb_device_cdc_acm.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1572229207/usb_device_cdc_acm.o.d" -o ${OBJECTDIR}/_ext/1572229207/usb_device_cdc_acm.o ../src/config/atsamd21g18a_default/usb/src/usb_device_cdc_acm.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -D_Version2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1640317663/initialization.o: ../src/config/atsamd21g18a_default/initialization.c  .generated_files/flags/atsamd21g18a_default/5871e066efacdd8b457f1c938d43d66e4799522 .generated_files/flags/atsamd21g18a_default/371f82de429950eaa99b35fa67f9d4c59ae13e52
	@${MKDIR} "${OBJECTDIR}/_ext/1640317663" 
	@${RM} ${OBJECTDIR}/_ext/1640317663/initialization.o.d 
	@${RM} ${OBJECTDIR}/_ext/1640317663/initialization.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1640317663/initialization.o.d" -o ${OBJECTDIR}/_ext/1640317663/initialization.o ../src/config/atsamd21g18a_default/initialization.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -D_Version2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1640317663/interrupts.o: ../src/config/atsamd21g18a_default/interrupts.c  .generated_files/flags/atsamd21g18a_default/d28e4e6da37d4b6104d5d2d3462304ac9cfea3dc .generated_files/flags/atsamd21g18a_default/371f82de429950eaa99b35fa67f9d4c59ae13e52
	@${MKDIR} "${OBJECTDIR}/_ext/1640317663" 
	@${RM} ${OBJECTDIR}/_ext/1640317663/interrupts.o.d 
	@${RM} ${OBJECTDIR}/_ext/1640317663/interrupts.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1640317663/interrupts.o.d" -o ${OBJECTDIR}/_ext/1640317663/interrupts.o ../src/config/atsamd21g18a_default/interrupts.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -D_Version2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1640317663/exceptions.o: ../src/config/atsamd21g18a_default/exceptions.c  .generated_files/flags/atsamd21g18a_default/f4f1d50db32d99c547b6941f580bb591e30f9823 .generated_files/flags/atsamd21g18a_default/371f82de429950eaa99b35fa67f9d4c59ae13e52
	@${MKDIR} "${OBJECTDIR}/_ext/1640317663" 
	@${RM} ${OBJECTDIR}/_ext/1640317663/exceptions.o.d 
	@${RM} ${OBJECTDIR}/_ext/1640317663/exceptions.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1640317663/exceptions.o.d" -o ${OBJECTDIR}/_ext/1640317663/exceptions.o ../src/config/atsamd21g18a_default/exceptions.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -D_Version2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1640317663/startup_xc32.o: ../src/config/atsamd21g18a_default/startup_xc32.c  .generated_files/flags/atsamd21g18a_default/8f2deb4231c60511e092aa94d137fd700df0019c .generated_files/flags/atsamd21g18a_default/371f82de429950eaa99b35fa67f9d4c59ae13e52
	@${MKDIR} "${OBJECTDIR}/_ext/1640317663" 
	@${RM} ${OBJECTDIR}/_ext/1640317663/startup_xc32.o.d 
	@${RM} ${OBJECTDIR}/_ext/1640317663/startup_xc32.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1640317663/startup_xc32.o.d" -o ${OBJECTDIR}/_ext/1640317663/startup_xc32.o ../src/config/atsamd21g18a_default/startup_xc32.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -D_Version2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1640317663/libc_syscalls.o: ../src/config/atsamd21g18a_default/libc_syscalls.c  .generated_files/flags/atsamd21g18a_default/48962ec59f693a8a596fca1a6c7c47259c29c52a .generated_files/flags/atsamd21g18a_default/371f82de429950eaa99b35fa67f9d4c59ae13e52
	@${MKDIR} "${OBJECTDIR}/_ext/1640317663" 
	@${RM} ${OBJECTDIR}/_ext/1640317663/libc_syscalls.o.d 
	@${RM} ${OBJECTDIR}/_ext/1640317663/libc_syscalls.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1640317663/libc_syscalls.o.d" -o ${OBJECTDIR}/_ext/1640317663/libc_syscalls.o ../src/config/atsamd21g18a_default/libc_syscalls.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -D_Version2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1640317663/usb_device_init_data.o: ../src/config/atsamd21g18a_default/usb_device_init_data.c  .generated_files/flags/atsamd21g18a_default/d64b14bb3b0544eae72c666e7314d924bac3dd0b .generated_files/flags/atsamd21g18a_default/371f82de429950eaa99b35fa67f9d4c59ae13e52
	@${MKDIR} "${OBJECTDIR}/_ext/1640317663" 
	@${RM} ${OBJECTDIR}/_ext/1640317663/usb_device_init_data.o.d 
	@${RM} ${OBJECTDIR}/_ext/1640317663/usb_device_init_data.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1640317663/usb_device_init_data.o.d" -o ${OBJECTDIR}/_ext/1640317663/usb_device_init_data.o ../src/config/atsamd21g18a_default/usb_device_init_data.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -D_Version2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1640317663/tasks.o: ../src/config/atsamd21g18a_default/tasks.c  .generated_files/flags/atsamd21g18a_default/288373755ad02ca84a0fb89c23349108d3b524ae .generated_files/flags/atsamd21g18a_default/371f82de429950eaa99b35fa67f9d4c59ae13e52
	@${MKDIR} "${OBJECTDIR}/_ext/1640317663" 
	@${RM} ${OBJECTDIR}/_ext/1640317663/tasks.o.d 
	@${RM} ${OBJECTDIR}/_ext/1640317663/tasks.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1640317663/tasks.o.d" -o ${OBJECTDIR}/_ext/1640317663/tasks.o ../src/config/atsamd21g18a_default/tasks.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -D_Version2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/w25q128jv.o: ../src/w25q128jv.c  .generated_files/flags/atsamd21g18a_default/3b7e900c24270e81ce100c1528fc3e4f6735c89a .generated_files/flags/atsamd21g18a_default/371f82de429950eaa99b35fa67f9d4c59ae13e52
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/w25q128jv.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/w25q128jv.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/w25q128jv.o.d" -o ${OBJECTDIR}/_ext/1360937237/w25q128jv.o ../src/w25q128jv.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -D_Version2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/util.o: ../src/util.c  .generated_files/flags/atsamd21g18a_default/3f5b57507a31ca701ee16f1ec3055fa4163f6ee2 .generated_files/flags/atsamd21g18a_default/371f82de429950eaa99b35fa67f9d4c59ae13e52
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/util.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/util.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/util.o.d" -o ${OBJECTDIR}/_ext/1360937237/util.o ../src/util.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -D_Version2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/s5851a.o: ../src/s5851a.c  .generated_files/flags/atsamd21g18a_default/9bededdcf1beeb1208a89a7c6b2ef8c3e59c117d .generated_files/flags/atsamd21g18a_default/371f82de429950eaa99b35fa67f9d4c59ae13e52
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/s5851a.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/s5851a.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/s5851a.o.d" -o ${OBJECTDIR}/_ext/1360937237/s5851a.o ../src/s5851a.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -D_Version2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/gpioexp.o: ../src/gpioexp.c  .generated_files/flags/atsamd21g18a_default/64fb2f4fcedcc47d29ed2a93132652764de8e0a0 .generated_files/flags/atsamd21g18a_default/371f82de429950eaa99b35fa67f9d4c59ae13e52
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/gpioexp.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/gpioexp.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/gpioexp.o.d" -o ${OBJECTDIR}/_ext/1360937237/gpioexp.o ../src/gpioexp.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -D_Version2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/rtc.o: ../src/rtc.c  .generated_files/flags/atsamd21g18a_default/e6bc30253025b67ed5dcc2cdd28e96d91f5045a1 .generated_files/flags/atsamd21g18a_default/371f82de429950eaa99b35fa67f9d4c59ae13e52
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/rtc.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/rtc.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/rtc.o.d" -o ${OBJECTDIR}/_ext/1360937237/rtc.o ../src/rtc.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -D_Version2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/mlog.o: ../src/mlog.c  .generated_files/flags/atsamd21g18a_default/c08a9870fa4314eaba2a167ac33cf91caddedbc .generated_files/flags/atsamd21g18a_default/371f82de429950eaa99b35fa67f9d4c59ae13e52
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/mlog.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/mlog.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/mlog.o.d" -o ${OBJECTDIR}/_ext/1360937237/mlog.o ../src/mlog.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -D_Version2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/sensor.o: ../src/sensor.c  .generated_files/flags/atsamd21g18a_default/b93cb6a68c85e3d223427e6720405e49169b40b0 .generated_files/flags/atsamd21g18a_default/371f82de429950eaa99b35fa67f9d4c59ae13e52
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/sensor.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/sensor.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/sensor.o.d" -o ${OBJECTDIR}/_ext/1360937237/sensor.o ../src/sensor.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -D_Version2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/uart_debug.o: ../src/uart_debug.c  .generated_files/flags/atsamd21g18a_default/ec62eb2d1f2d913a3f4d8d55c17c98d005ed256f .generated_files/flags/atsamd21g18a_default/371f82de429950eaa99b35fa67f9d4c59ae13e52
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/uart_debug.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/uart_debug.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/uart_debug.o.d" -o ${OBJECTDIR}/_ext/1360937237/uart_debug.o ../src/uart_debug.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -D_Version2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/uart_comm.o: ../src/uart_comm.c  .generated_files/flags/atsamd21g18a_default/aa06587242aa4544d1c6719a9e86987c1ce03769 .generated_files/flags/atsamd21g18a_default/371f82de429950eaa99b35fa67f9d4c59ae13e52
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/uart_comm.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/uart_comm.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/uart_comm.o.d" -o ${OBJECTDIR}/_ext/1360937237/uart_comm.o ../src/uart_comm.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -D_Version2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/wpfm.o: ../src/wpfm.c  .generated_files/flags/atsamd21g18a_default/cca411619990bd34162289180f1deb4862d2fd76 .generated_files/flags/atsamd21g18a_default/371f82de429950eaa99b35fa67f9d4c59ae13e52
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/wpfm.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/wpfm.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/wpfm.o.d" -o ${OBJECTDIR}/_ext/1360937237/wpfm.o ../src/wpfm.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -D_Version2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/battery.o: ../src/battery.c  .generated_files/flags/atsamd21g18a_default/9e3792126faf717516cc91c02de76cc40594fcf3 .generated_files/flags/atsamd21g18a_default/371f82de429950eaa99b35fa67f9d4c59ae13e52
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/battery.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/battery.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/battery.o.d" -o ${OBJECTDIR}/_ext/1360937237/battery.o ../src/battery.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -D_Version2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/communicate.o: ../src/communicate.c  .generated_files/flags/atsamd21g18a_default/821a0dd92f0a3db89a387557552f9fe2151d2acb .generated_files/flags/atsamd21g18a_default/371f82de429950eaa99b35fa67f9d4c59ae13e52
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/communicate.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/communicate.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/communicate.o.d" -o ${OBJECTDIR}/_ext/1360937237/communicate.o ../src/communicate.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -D_Version2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/init.o: ../src/init.c  .generated_files/flags/atsamd21g18a_default/7432cad09fde498bed83b23ef4d89a269ab99cd9 .generated_files/flags/atsamd21g18a_default/371f82de429950eaa99b35fa67f9d4c59ae13e52
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/init.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/init.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/init.o.d" -o ${OBJECTDIR}/_ext/1360937237/init.o ../src/init.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -D_Version2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/measure.o: ../src/measure.c  .generated_files/flags/atsamd21g18a_default/43d6448945b3f0a141571bb2744d5467e31b2c4b .generated_files/flags/atsamd21g18a_default/371f82de429950eaa99b35fa67f9d4c59ae13e52
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/measure.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/measure.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/measure.o.d" -o ${OBJECTDIR}/_ext/1360937237/measure.o ../src/measure.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -D_Version2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/alert.o: ../src/alert.c  .generated_files/flags/atsamd21g18a_default/2ebb6f1354b85e933bf7463461db72d22c0ea765 .generated_files/flags/atsamd21g18a_default/371f82de429950eaa99b35fa67f9d4c59ae13e52
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/alert.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/alert.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/alert.o.d" -o ${OBJECTDIR}/_ext/1360937237/alert.o ../src/alert.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -D_Version2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/smpif4.o: ../src/smpif4.c  .generated_files/flags/atsamd21g18a_default/2f1968c739af33417f42684f0a4f99eafac669a .generated_files/flags/atsamd21g18a_default/371f82de429950eaa99b35fa67f9d4c59ae13e52
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/smpif4.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/smpif4.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/smpif4.o.d" -o ${OBJECTDIR}/_ext/1360937237/smpif4.o ../src/smpif4.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -D_Version2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/smpif.o: ../src/smpif.c  .generated_files/flags/atsamd21g18a_default/1929f3b59489d16c881cce57617ca2f4c3f87927 .generated_files/flags/atsamd21g18a_default/371f82de429950eaa99b35fa67f9d4c59ae13e52
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/smpif.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/smpif.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/smpif.o.d" -o ${OBJECTDIR}/_ext/1360937237/smpif.o ../src/smpif.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -D_Version2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/smpif1.o: ../src/smpif1.c  .generated_files/flags/atsamd21g18a_default/487fefa8f330f57f678e3b9a6d8d29c1f5d2a822 .generated_files/flags/atsamd21g18a_default/371f82de429950eaa99b35fa67f9d4c59ae13e52
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/smpif1.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/smpif1.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/smpif1.o.d" -o ${OBJECTDIR}/_ext/1360937237/smpif1.o ../src/smpif1.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -D_Version2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/smpif2.o: ../src/smpif2.c  .generated_files/flags/atsamd21g18a_default/afff649ecf33db2a427887c91010feaa0521c8 .generated_files/flags/atsamd21g18a_default/371f82de429950eaa99b35fa67f9d4c59ae13e52
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/smpif2.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/smpif2.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/smpif2.o.d" -o ${OBJECTDIR}/_ext/1360937237/smpif2.o ../src/smpif2.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -D_Version2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/smpif3.o: ../src/smpif3.c  .generated_files/flags/atsamd21g18a_default/943ce90d4f58d5575ddda7981acbfd906a229b8f .generated_files/flags/atsamd21g18a_default/371f82de429950eaa99b35fa67f9d4c59ae13e52
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/smpif3.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/smpif3.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/smpif3.o.d" -o ${OBJECTDIR}/_ext/1360937237/smpif3.o ../src/smpif3.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -D_Version2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/main.o: ../src/main.c  .generated_files/flags/atsamd21g18a_default/c2b92a28405b7fef1eecdc7cf69d47910ef2ebdf .generated_files/flags/atsamd21g18a_default/371f82de429950eaa99b35fa67f9d4c59ae13e52
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/main.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/main.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/main.o.d" -o ${OBJECTDIR}/_ext/1360937237/main.o ../src/main.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -D_Version2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/app.o: ../src/app.c  .generated_files/flags/atsamd21g18a_default/5969ae4b100862f8570f55e05ec4ad9311c17353 .generated_files/flags/atsamd21g18a_default/371f82de429950eaa99b35fa67f9d4c59ae13e52
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/app.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/app.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/app.o.d" -o ${OBJECTDIR}/_ext/1360937237/app.o ../src/app.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -D_Version2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/MATcore.o: ../src/MATcore.c  .generated_files/flags/atsamd21g18a_default/8f30af87f5cb0b5109ea2622fc10f56b24256081 .generated_files/flags/atsamd21g18a_default/371f82de429950eaa99b35fa67f9d4c59ae13e52
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/MATcore.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/MATcore.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/MATcore.o.d" -o ${OBJECTDIR}/_ext/1360937237/MATcore.o ../src/MATcore.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -D_Version2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/moni.o: ../src/moni.c  .generated_files/flags/atsamd21g18a_default/9abf127f70ea7e33b4b3388922077c8a79d15b21 .generated_files/flags/atsamd21g18a_default/371f82de429950eaa99b35fa67f9d4c59ae13e52
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/moni.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/moni.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/moni.o.d" -o ${OBJECTDIR}/_ext/1360937237/moni.o ../src/moni.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -D_Version2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/version.o: ../src/version.c  .generated_files/flags/atsamd21g18a_default/ab6ff1a86dcfc25b2f8f9d48391bd477d9e319db .generated_files/flags/atsamd21g18a_default/371f82de429950eaa99b35fa67f9d4c59ae13e52
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/version.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/version.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/version.o.d" -o ${OBJECTDIR}/_ext/1360937237/version.o ../src/version.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -D_Version2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/DLCpara.o: ../src/DLCpara.c  .generated_files/flags/atsamd21g18a_default/b7fbdeae4576ac6e1926d87841b337908daccd7e .generated_files/flags/atsamd21g18a_default/371f82de429950eaa99b35fa67f9d4c59ae13e52
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/DLCpara.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/DLCpara.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/DLCpara.o.d" -o ${OBJECTDIR}/_ext/1360937237/DLCpara.o ../src/DLCpara.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -D_Version2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/EventLog.o: ../src/EventLog.c  .generated_files/flags/atsamd21g18a_default/50df61f51a7105db44e94ab1f77cf46f45687521 .generated_files/flags/atsamd21g18a_default/371f82de429950eaa99b35fa67f9d4c59ae13e52
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/EventLog.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/EventLog.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/EventLog.o.d" -o ${OBJECTDIR}/_ext/1360937237/EventLog.o ../src/EventLog.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -D_Version2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/FOTAcmd.o: ../src/FOTAcmd.c  .generated_files/flags/atsamd21g18a_default/7323c283b3f72ec7922efb1393e37b46dc018cdf .generated_files/flags/atsamd21g18a_default/371f82de429950eaa99b35fa67f9d4c59ae13e52
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/FOTAcmd.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/FOTAcmd.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE) -g -D__DEBUG   -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/FOTAcmd.o.d" -o ${OBJECTDIR}/_ext/1360937237/FOTAcmd.o ../src/FOTAcmd.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -D_Version2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
else
${OBJECTDIR}/_ext/1814754785/drv_usbfsv1.o: ../src/config/atsamd21g18a_default/driver/usb/usbfsv1/src/drv_usbfsv1.c  .generated_files/flags/atsamd21g18a_default/a11057a4984e0e995305b7f125628fcb6da64f3b .generated_files/flags/atsamd21g18a_default/371f82de429950eaa99b35fa67f9d4c59ae13e52
	@${MKDIR} "${OBJECTDIR}/_ext/1814754785" 
	@${RM} ${OBJECTDIR}/_ext/1814754785/drv_usbfsv1.o.d 
	@${RM} ${OBJECTDIR}/_ext/1814754785/drv_usbfsv1.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1814754785/drv_usbfsv1.o.d" -o ${OBJECTDIR}/_ext/1814754785/drv_usbfsv1.o ../src/config/atsamd21g18a_default/driver/usb/usbfsv1/src/drv_usbfsv1.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -D_Version2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1814754785/drv_usbfsv1_device.o: ../src/config/atsamd21g18a_default/driver/usb/usbfsv1/src/drv_usbfsv1_device.c  .generated_files/flags/atsamd21g18a_default/6883234e58f14dd2423828916ade0992499bf632 .generated_files/flags/atsamd21g18a_default/371f82de429950eaa99b35fa67f9d4c59ae13e52
	@${MKDIR} "${OBJECTDIR}/_ext/1814754785" 
	@${RM} ${OBJECTDIR}/_ext/1814754785/drv_usbfsv1_device.o.d 
	@${RM} ${OBJECTDIR}/_ext/1814754785/drv_usbfsv1_device.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1814754785/drv_usbfsv1_device.o.d" -o ${OBJECTDIR}/_ext/1814754785/drv_usbfsv1_device.o ../src/config/atsamd21g18a_default/driver/usb/usbfsv1/src/drv_usbfsv1_device.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -D_Version2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1885044035/plib_adc.o: ../src/config/atsamd21g18a_default/peripheral/adc/plib_adc.c  .generated_files/flags/atsamd21g18a_default/f764433647e043d8b58bb49ce6e19bdd5883c44d .generated_files/flags/atsamd21g18a_default/371f82de429950eaa99b35fa67f9d4c59ae13e52
	@${MKDIR} "${OBJECTDIR}/_ext/1885044035" 
	@${RM} ${OBJECTDIR}/_ext/1885044035/plib_adc.o.d 
	@${RM} ${OBJECTDIR}/_ext/1885044035/plib_adc.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1885044035/plib_adc.o.d" -o ${OBJECTDIR}/_ext/1885044035/plib_adc.o ../src/config/atsamd21g18a_default/peripheral/adc/plib_adc.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -D_Version2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/950981355/plib_clock.o: ../src/config/atsamd21g18a_default/peripheral/clock/plib_clock.c  .generated_files/flags/atsamd21g18a_default/88c8d05d59fef9fb906b181ab8982e1c9863caad .generated_files/flags/atsamd21g18a_default/371f82de429950eaa99b35fa67f9d4c59ae13e52
	@${MKDIR} "${OBJECTDIR}/_ext/950981355" 
	@${RM} ${OBJECTDIR}/_ext/950981355/plib_clock.o.d 
	@${RM} ${OBJECTDIR}/_ext/950981355/plib_clock.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/950981355/plib_clock.o.d" -o ${OBJECTDIR}/_ext/950981355/plib_clock.o ../src/config/atsamd21g18a_default/peripheral/clock/plib_clock.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -D_Version2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1885040036/plib_eic.o: ../src/config/atsamd21g18a_default/peripheral/eic/plib_eic.c  .generated_files/flags/atsamd21g18a_default/d83bbb4c283bdcb64ba160eb4cea4024515da4e9 .generated_files/flags/atsamd21g18a_default/371f82de429950eaa99b35fa67f9d4c59ae13e52
	@${MKDIR} "${OBJECTDIR}/_ext/1885040036" 
	@${RM} ${OBJECTDIR}/_ext/1885040036/plib_eic.o.d 
	@${RM} ${OBJECTDIR}/_ext/1885040036/plib_eic.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1885040036/plib_eic.o.d" -o ${OBJECTDIR}/_ext/1885040036/plib_eic.o ../src/config/atsamd21g18a_default/peripheral/eic/plib_eic.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -D_Version2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/953130841/plib_evsys.o: ../src/config/atsamd21g18a_default/peripheral/evsys/plib_evsys.c  .generated_files/flags/atsamd21g18a_default/167449c1c50c6a10d703e1118b59d93450b31feb .generated_files/flags/atsamd21g18a_default/371f82de429950eaa99b35fa67f9d4c59ae13e52
	@${MKDIR} "${OBJECTDIR}/_ext/953130841" 
	@${RM} ${OBJECTDIR}/_ext/953130841/plib_evsys.o.d 
	@${RM} ${OBJECTDIR}/_ext/953130841/plib_evsys.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/953130841/plib_evsys.o.d" -o ${OBJECTDIR}/_ext/953130841/plib_evsys.o ../src/config/atsamd21g18a_default/peripheral/evsys/plib_evsys.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -D_Version2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1693581925/plib_nvic.o: ../src/config/atsamd21g18a_default/peripheral/nvic/plib_nvic.c  .generated_files/flags/atsamd21g18a_default/79b3264adc43add427183ae212ad2bfa5532b7c3 .generated_files/flags/atsamd21g18a_default/371f82de429950eaa99b35fa67f9d4c59ae13e52
	@${MKDIR} "${OBJECTDIR}/_ext/1693581925" 
	@${RM} ${OBJECTDIR}/_ext/1693581925/plib_nvic.o.d 
	@${RM} ${OBJECTDIR}/_ext/1693581925/plib_nvic.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1693581925/plib_nvic.o.d" -o ${OBJECTDIR}/_ext/1693581925/plib_nvic.o ../src/config/atsamd21g18a_default/peripheral/nvic/plib_nvic.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -D_Version2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/522110765/plib_nvmctrl.o: ../src/config/atsamd21g18a_default/peripheral/nvmctrl/plib_nvmctrl.c  .generated_files/flags/atsamd21g18a_default/ae1747b033085468baef23b98a816f91005935fe .generated_files/flags/atsamd21g18a_default/371f82de429950eaa99b35fa67f9d4c59ae13e52
	@${MKDIR} "${OBJECTDIR}/_ext/522110765" 
	@${RM} ${OBJECTDIR}/_ext/522110765/plib_nvmctrl.o.d 
	@${RM} ${OBJECTDIR}/_ext/522110765/plib_nvmctrl.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/522110765/plib_nvmctrl.o.d" -o ${OBJECTDIR}/_ext/522110765/plib_nvmctrl.o ../src/config/atsamd21g18a_default/peripheral/nvmctrl/plib_nvmctrl.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -D_Version2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1324665920/plib_pm.o: ../src/config/atsamd21g18a_default/peripheral/pm/plib_pm.c  .generated_files/flags/atsamd21g18a_default/5633e7ef0eeafef8738c7f37cffeb51996a1eeab .generated_files/flags/atsamd21g18a_default/371f82de429950eaa99b35fa67f9d4c59ae13e52
	@${MKDIR} "${OBJECTDIR}/_ext/1324665920" 
	@${RM} ${OBJECTDIR}/_ext/1324665920/plib_pm.o.d 
	@${RM} ${OBJECTDIR}/_ext/1324665920/plib_pm.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1324665920/plib_pm.o.d" -o ${OBJECTDIR}/_ext/1324665920/plib_pm.o ../src/config/atsamd21g18a_default/peripheral/pm/plib_pm.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -D_Version2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1693635076/plib_port.o: ../src/config/atsamd21g18a_default/peripheral/port/plib_port.c  .generated_files/flags/atsamd21g18a_default/2e72966924b66648cef629cf3802aa1c3e9c7e1 .generated_files/flags/atsamd21g18a_default/371f82de429950eaa99b35fa67f9d4c59ae13e52
	@${MKDIR} "${OBJECTDIR}/_ext/1693635076" 
	@${RM} ${OBJECTDIR}/_ext/1693635076/plib_port.o.d 
	@${RM} ${OBJECTDIR}/_ext/1693635076/plib_port.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1693635076/plib_port.o.d" -o ${OBJECTDIR}/_ext/1693635076/plib_port.o ../src/config/atsamd21g18a_default/peripheral/port/plib_port.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -D_Version2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/163103410/plib_sercom3_i2c_master.o: ../src/config/atsamd21g18a_default/peripheral/sercom/i2c_master/plib_sercom3_i2c_master.c  .generated_files/flags/atsamd21g18a_default/2a270ae06d9f6cc4fc4b9471e92ef9dc52608979 .generated_files/flags/atsamd21g18a_default/371f82de429950eaa99b35fa67f9d4c59ae13e52
	@${MKDIR} "${OBJECTDIR}/_ext/163103410" 
	@${RM} ${OBJECTDIR}/_ext/163103410/plib_sercom3_i2c_master.o.d 
	@${RM} ${OBJECTDIR}/_ext/163103410/plib_sercom3_i2c_master.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/163103410/plib_sercom3_i2c_master.o.d" -o ${OBJECTDIR}/_ext/163103410/plib_sercom3_i2c_master.o ../src/config/atsamd21g18a_default/peripheral/sercom/i2c_master/plib_sercom3_i2c_master.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -D_Version2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/328131232/plib_sercom1_spi_master.o: ../src/config/atsamd21g18a_default/peripheral/sercom/spi_master/plib_sercom1_spi_master.c  .generated_files/flags/atsamd21g18a_default/57e40cb51e9429aecf024af578f03698c922667a .generated_files/flags/atsamd21g18a_default/371f82de429950eaa99b35fa67f9d4c59ae13e52
	@${MKDIR} "${OBJECTDIR}/_ext/328131232" 
	@${RM} ${OBJECTDIR}/_ext/328131232/plib_sercom1_spi_master.o.d 
	@${RM} ${OBJECTDIR}/_ext/328131232/plib_sercom1_spi_master.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/328131232/plib_sercom1_spi_master.o.d" -o ${OBJECTDIR}/_ext/328131232/plib_sercom1_spi_master.o ../src/config/atsamd21g18a_default/peripheral/sercom/spi_master/plib_sercom1_spi_master.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -D_Version2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/472979226/plib_sercom0_usart.o: ../src/config/atsamd21g18a_default/peripheral/sercom/usart/plib_sercom0_usart.c  .generated_files/flags/atsamd21g18a_default/56c89e4919d3c26bf0f49a018ff1652f6e704bc2 .generated_files/flags/atsamd21g18a_default/371f82de429950eaa99b35fa67f9d4c59ae13e52
	@${MKDIR} "${OBJECTDIR}/_ext/472979226" 
	@${RM} ${OBJECTDIR}/_ext/472979226/plib_sercom0_usart.o.d 
	@${RM} ${OBJECTDIR}/_ext/472979226/plib_sercom0_usart.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/472979226/plib_sercom0_usart.o.d" -o ${OBJECTDIR}/_ext/472979226/plib_sercom0_usart.o ../src/config/atsamd21g18a_default/peripheral/sercom/usart/plib_sercom0_usart.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -D_Version2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/472979226/plib_sercom5_usart.o: ../src/config/atsamd21g18a_default/peripheral/sercom/usart/plib_sercom5_usart.c  .generated_files/flags/atsamd21g18a_default/41667e87c096780b4f543dc5065ec3252b7097b4 .generated_files/flags/atsamd21g18a_default/371f82de429950eaa99b35fa67f9d4c59ae13e52
	@${MKDIR} "${OBJECTDIR}/_ext/472979226" 
	@${RM} ${OBJECTDIR}/_ext/472979226/plib_sercom5_usart.o.d 
	@${RM} ${OBJECTDIR}/_ext/472979226/plib_sercom5_usart.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/472979226/plib_sercom5_usart.o.d" -o ${OBJECTDIR}/_ext/472979226/plib_sercom5_usart.o ../src/config/atsamd21g18a_default/peripheral/sercom/usart/plib_sercom5_usart.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -D_Version2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/756585863/plib_systick.o: ../src/config/atsamd21g18a_default/peripheral/systick/plib_systick.c  .generated_files/flags/atsamd21g18a_default/d0ebb5d610828a89888c6e617ed6c9e40342e8ec .generated_files/flags/atsamd21g18a_default/371f82de429950eaa99b35fa67f9d4c59ae13e52
	@${MKDIR} "${OBJECTDIR}/_ext/756585863" 
	@${RM} ${OBJECTDIR}/_ext/756585863/plib_systick.o.d 
	@${RM} ${OBJECTDIR}/_ext/756585863/plib_systick.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/756585863/plib_systick.o.d" -o ${OBJECTDIR}/_ext/756585863/plib_systick.o ../src/config/atsamd21g18a_default/peripheral/systick/plib_systick.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -D_Version2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1324666034/plib_tc3.o: ../src/config/atsamd21g18a_default/peripheral/tc/plib_tc3.c  .generated_files/flags/atsamd21g18a_default/45695139928cc3e2d1587099d94c155712d46743 .generated_files/flags/atsamd21g18a_default/371f82de429950eaa99b35fa67f9d4c59ae13e52
	@${MKDIR} "${OBJECTDIR}/_ext/1324666034" 
	@${RM} ${OBJECTDIR}/_ext/1324666034/plib_tc3.o.d 
	@${RM} ${OBJECTDIR}/_ext/1324666034/plib_tc3.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1324666034/plib_tc3.o.d" -o ${OBJECTDIR}/_ext/1324666034/plib_tc3.o ../src/config/atsamd21g18a_default/peripheral/tc/plib_tc3.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -D_Version2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1324666034/plib_tc4.o: ../src/config/atsamd21g18a_default/peripheral/tc/plib_tc4.c  .generated_files/flags/atsamd21g18a_default/efffccc12056d85f17daa8e627a9c3cfdd5a495 .generated_files/flags/atsamd21g18a_default/371f82de429950eaa99b35fa67f9d4c59ae13e52
	@${MKDIR} "${OBJECTDIR}/_ext/1324666034" 
	@${RM} ${OBJECTDIR}/_ext/1324666034/plib_tc4.o.d 
	@${RM} ${OBJECTDIR}/_ext/1324666034/plib_tc4.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1324666034/plib_tc4.o.d" -o ${OBJECTDIR}/_ext/1324666034/plib_tc4.o ../src/config/atsamd21g18a_default/peripheral/tc/plib_tc4.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -D_Version2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1324666034/plib_tc5.o: ../src/config/atsamd21g18a_default/peripheral/tc/plib_tc5.c  .generated_files/flags/atsamd21g18a_default/2f71a9b6faa98b7bfd462f471024cd04a0e35d32 .generated_files/flags/atsamd21g18a_default/371f82de429950eaa99b35fa67f9d4c59ae13e52
	@${MKDIR} "${OBJECTDIR}/_ext/1324666034" 
	@${RM} ${OBJECTDIR}/_ext/1324666034/plib_tc5.o.d 
	@${RM} ${OBJECTDIR}/_ext/1324666034/plib_tc5.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1324666034/plib_tc5.o.d" -o ${OBJECTDIR}/_ext/1324666034/plib_tc5.o ../src/config/atsamd21g18a_default/peripheral/tc/plib_tc5.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -D_Version2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1885022876/plib_wdt.o: ../src/config/atsamd21g18a_default/peripheral/wdt/plib_wdt.c  .generated_files/flags/atsamd21g18a_default/3fd692bad59de2c2fc6d9ac4b2614a3e40aa2120 .generated_files/flags/atsamd21g18a_default/371f82de429950eaa99b35fa67f9d4c59ae13e52
	@${MKDIR} "${OBJECTDIR}/_ext/1885022876" 
	@${RM} ${OBJECTDIR}/_ext/1885022876/plib_wdt.o.d 
	@${RM} ${OBJECTDIR}/_ext/1885022876/plib_wdt.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1885022876/plib_wdt.o.d" -o ${OBJECTDIR}/_ext/1885022876/plib_wdt.o ../src/config/atsamd21g18a_default/peripheral/wdt/plib_wdt.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -D_Version2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/9958233/xc32_monitor.o: ../src/config/atsamd21g18a_default/stdio/xc32_monitor.c  .generated_files/flags/atsamd21g18a_default/55f7f7d97c4a84da4546d3138a580e4ccb02ca9c .generated_files/flags/atsamd21g18a_default/371f82de429950eaa99b35fa67f9d4c59ae13e52
	@${MKDIR} "${OBJECTDIR}/_ext/9958233" 
	@${RM} ${OBJECTDIR}/_ext/9958233/xc32_monitor.o.d 
	@${RM} ${OBJECTDIR}/_ext/9958233/xc32_monitor.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/9958233/xc32_monitor.o.d" -o ${OBJECTDIR}/_ext/9958233/xc32_monitor.o ../src/config/atsamd21g18a_default/stdio/xc32_monitor.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -D_Version2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/63538924/sys_int.o: ../src/config/atsamd21g18a_default/system/int/src/sys_int.c  .generated_files/flags/atsamd21g18a_default/74d4b85491dfa703b7b7cc6e5ddb830de0695ffa .generated_files/flags/atsamd21g18a_default/371f82de429950eaa99b35fa67f9d4c59ae13e52
	@${MKDIR} "${OBJECTDIR}/_ext/63538924" 
	@${RM} ${OBJECTDIR}/_ext/63538924/sys_int.o.d 
	@${RM} ${OBJECTDIR}/_ext/63538924/sys_int.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/63538924/sys_int.o.d" -o ${OBJECTDIR}/_ext/63538924/sys_int.o ../src/config/atsamd21g18a_default/system/int/src/sys_int.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -D_Version2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1572229207/usb_device.o: ../src/config/atsamd21g18a_default/usb/src/usb_device.c  .generated_files/flags/atsamd21g18a_default/a9e8cb4389b7d6155f10b86a2eb660aab6a1c55b .generated_files/flags/atsamd21g18a_default/371f82de429950eaa99b35fa67f9d4c59ae13e52
	@${MKDIR} "${OBJECTDIR}/_ext/1572229207" 
	@${RM} ${OBJECTDIR}/_ext/1572229207/usb_device.o.d 
	@${RM} ${OBJECTDIR}/_ext/1572229207/usb_device.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1572229207/usb_device.o.d" -o ${OBJECTDIR}/_ext/1572229207/usb_device.o ../src/config/atsamd21g18a_default/usb/src/usb_device.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -D_Version2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1572229207/usb_device_cdc.o: ../src/config/atsamd21g18a_default/usb/src/usb_device_cdc.c  .generated_files/flags/atsamd21g18a_default/204dec7b6adcf14b11faa3d6f0c9fa6fb36a78b7 .generated_files/flags/atsamd21g18a_default/371f82de429950eaa99b35fa67f9d4c59ae13e52
	@${MKDIR} "${OBJECTDIR}/_ext/1572229207" 
	@${RM} ${OBJECTDIR}/_ext/1572229207/usb_device_cdc.o.d 
	@${RM} ${OBJECTDIR}/_ext/1572229207/usb_device_cdc.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1572229207/usb_device_cdc.o.d" -o ${OBJECTDIR}/_ext/1572229207/usb_device_cdc.o ../src/config/atsamd21g18a_default/usb/src/usb_device_cdc.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -D_Version2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1572229207/usb_device_cdc_acm.o: ../src/config/atsamd21g18a_default/usb/src/usb_device_cdc_acm.c  .generated_files/flags/atsamd21g18a_default/f101ee36debe5a4bdc0d2c986182a2d87b7da9a2 .generated_files/flags/atsamd21g18a_default/371f82de429950eaa99b35fa67f9d4c59ae13e52
	@${MKDIR} "${OBJECTDIR}/_ext/1572229207" 
	@${RM} ${OBJECTDIR}/_ext/1572229207/usb_device_cdc_acm.o.d 
	@${RM} ${OBJECTDIR}/_ext/1572229207/usb_device_cdc_acm.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1572229207/usb_device_cdc_acm.o.d" -o ${OBJECTDIR}/_ext/1572229207/usb_device_cdc_acm.o ../src/config/atsamd21g18a_default/usb/src/usb_device_cdc_acm.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -D_Version2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1640317663/initialization.o: ../src/config/atsamd21g18a_default/initialization.c  .generated_files/flags/atsamd21g18a_default/1b1c2af579ffecb23f5c4b0267d2bc7ffca4dabb .generated_files/flags/atsamd21g18a_default/371f82de429950eaa99b35fa67f9d4c59ae13e52
	@${MKDIR} "${OBJECTDIR}/_ext/1640317663" 
	@${RM} ${OBJECTDIR}/_ext/1640317663/initialization.o.d 
	@${RM} ${OBJECTDIR}/_ext/1640317663/initialization.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1640317663/initialization.o.d" -o ${OBJECTDIR}/_ext/1640317663/initialization.o ../src/config/atsamd21g18a_default/initialization.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -D_Version2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1640317663/interrupts.o: ../src/config/atsamd21g18a_default/interrupts.c  .generated_files/flags/atsamd21g18a_default/4c19dfa5016226b6a1ee8b21cd7aed073284dd7 .generated_files/flags/atsamd21g18a_default/371f82de429950eaa99b35fa67f9d4c59ae13e52
	@${MKDIR} "${OBJECTDIR}/_ext/1640317663" 
	@${RM} ${OBJECTDIR}/_ext/1640317663/interrupts.o.d 
	@${RM} ${OBJECTDIR}/_ext/1640317663/interrupts.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1640317663/interrupts.o.d" -o ${OBJECTDIR}/_ext/1640317663/interrupts.o ../src/config/atsamd21g18a_default/interrupts.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -D_Version2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1640317663/exceptions.o: ../src/config/atsamd21g18a_default/exceptions.c  .generated_files/flags/atsamd21g18a_default/db841c091005d6e5b94a1c1560c9876ba599a937 .generated_files/flags/atsamd21g18a_default/371f82de429950eaa99b35fa67f9d4c59ae13e52
	@${MKDIR} "${OBJECTDIR}/_ext/1640317663" 
	@${RM} ${OBJECTDIR}/_ext/1640317663/exceptions.o.d 
	@${RM} ${OBJECTDIR}/_ext/1640317663/exceptions.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1640317663/exceptions.o.d" -o ${OBJECTDIR}/_ext/1640317663/exceptions.o ../src/config/atsamd21g18a_default/exceptions.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -D_Version2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1640317663/startup_xc32.o: ../src/config/atsamd21g18a_default/startup_xc32.c  .generated_files/flags/atsamd21g18a_default/5f84623ef9b4f82c53b47c7dab180854d23d8828 .generated_files/flags/atsamd21g18a_default/371f82de429950eaa99b35fa67f9d4c59ae13e52
	@${MKDIR} "${OBJECTDIR}/_ext/1640317663" 
	@${RM} ${OBJECTDIR}/_ext/1640317663/startup_xc32.o.d 
	@${RM} ${OBJECTDIR}/_ext/1640317663/startup_xc32.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1640317663/startup_xc32.o.d" -o ${OBJECTDIR}/_ext/1640317663/startup_xc32.o ../src/config/atsamd21g18a_default/startup_xc32.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -D_Version2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1640317663/libc_syscalls.o: ../src/config/atsamd21g18a_default/libc_syscalls.c  .generated_files/flags/atsamd21g18a_default/39a996aabd40683a85665f6d2808e610fbd9be70 .generated_files/flags/atsamd21g18a_default/371f82de429950eaa99b35fa67f9d4c59ae13e52
	@${MKDIR} "${OBJECTDIR}/_ext/1640317663" 
	@${RM} ${OBJECTDIR}/_ext/1640317663/libc_syscalls.o.d 
	@${RM} ${OBJECTDIR}/_ext/1640317663/libc_syscalls.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1640317663/libc_syscalls.o.d" -o ${OBJECTDIR}/_ext/1640317663/libc_syscalls.o ../src/config/atsamd21g18a_default/libc_syscalls.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -D_Version2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1640317663/usb_device_init_data.o: ../src/config/atsamd21g18a_default/usb_device_init_data.c  .generated_files/flags/atsamd21g18a_default/1384778f67ce951c22e66979354dbeefeb76c000 .generated_files/flags/atsamd21g18a_default/371f82de429950eaa99b35fa67f9d4c59ae13e52
	@${MKDIR} "${OBJECTDIR}/_ext/1640317663" 
	@${RM} ${OBJECTDIR}/_ext/1640317663/usb_device_init_data.o.d 
	@${RM} ${OBJECTDIR}/_ext/1640317663/usb_device_init_data.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1640317663/usb_device_init_data.o.d" -o ${OBJECTDIR}/_ext/1640317663/usb_device_init_data.o ../src/config/atsamd21g18a_default/usb_device_init_data.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -D_Version2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1640317663/tasks.o: ../src/config/atsamd21g18a_default/tasks.c  .generated_files/flags/atsamd21g18a_default/4219e63696e9c8e5af21dc956e5fd3368f1cfbdc .generated_files/flags/atsamd21g18a_default/371f82de429950eaa99b35fa67f9d4c59ae13e52
	@${MKDIR} "${OBJECTDIR}/_ext/1640317663" 
	@${RM} ${OBJECTDIR}/_ext/1640317663/tasks.o.d 
	@${RM} ${OBJECTDIR}/_ext/1640317663/tasks.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1640317663/tasks.o.d" -o ${OBJECTDIR}/_ext/1640317663/tasks.o ../src/config/atsamd21g18a_default/tasks.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -D_Version2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/w25q128jv.o: ../src/w25q128jv.c  .generated_files/flags/atsamd21g18a_default/73c7dec84eb3c080238ab2360daa77061dc7c031 .generated_files/flags/atsamd21g18a_default/371f82de429950eaa99b35fa67f9d4c59ae13e52
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/w25q128jv.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/w25q128jv.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/w25q128jv.o.d" -o ${OBJECTDIR}/_ext/1360937237/w25q128jv.o ../src/w25q128jv.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -D_Version2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/util.o: ../src/util.c  .generated_files/flags/atsamd21g18a_default/b36bc5660e1c60b4b03b2dceaf1bbef3487a69e4 .generated_files/flags/atsamd21g18a_default/371f82de429950eaa99b35fa67f9d4c59ae13e52
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/util.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/util.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/util.o.d" -o ${OBJECTDIR}/_ext/1360937237/util.o ../src/util.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -D_Version2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/s5851a.o: ../src/s5851a.c  .generated_files/flags/atsamd21g18a_default/1ff13cbe9bdb06e6f320fb84a37a891188606496 .generated_files/flags/atsamd21g18a_default/371f82de429950eaa99b35fa67f9d4c59ae13e52
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/s5851a.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/s5851a.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/s5851a.o.d" -o ${OBJECTDIR}/_ext/1360937237/s5851a.o ../src/s5851a.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -D_Version2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/gpioexp.o: ../src/gpioexp.c  .generated_files/flags/atsamd21g18a_default/1a093f0f2d09e77640652e7d80153bbeaa4b66df .generated_files/flags/atsamd21g18a_default/371f82de429950eaa99b35fa67f9d4c59ae13e52
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/gpioexp.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/gpioexp.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/gpioexp.o.d" -o ${OBJECTDIR}/_ext/1360937237/gpioexp.o ../src/gpioexp.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -D_Version2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/rtc.o: ../src/rtc.c  .generated_files/flags/atsamd21g18a_default/b88b69fb98a3a42fe654b7897a7a23ef09a61910 .generated_files/flags/atsamd21g18a_default/371f82de429950eaa99b35fa67f9d4c59ae13e52
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/rtc.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/rtc.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/rtc.o.d" -o ${OBJECTDIR}/_ext/1360937237/rtc.o ../src/rtc.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -D_Version2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/mlog.o: ../src/mlog.c  .generated_files/flags/atsamd21g18a_default/8c13fd6ff38a10f8ab3db67b8bd24b924f9147f7 .generated_files/flags/atsamd21g18a_default/371f82de429950eaa99b35fa67f9d4c59ae13e52
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/mlog.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/mlog.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/mlog.o.d" -o ${OBJECTDIR}/_ext/1360937237/mlog.o ../src/mlog.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -D_Version2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/sensor.o: ../src/sensor.c  .generated_files/flags/atsamd21g18a_default/13f8e5bb51cbd853f7c63922fe4d9343d38dd5d .generated_files/flags/atsamd21g18a_default/371f82de429950eaa99b35fa67f9d4c59ae13e52
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/sensor.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/sensor.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/sensor.o.d" -o ${OBJECTDIR}/_ext/1360937237/sensor.o ../src/sensor.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -D_Version2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/uart_debug.o: ../src/uart_debug.c  .generated_files/flags/atsamd21g18a_default/879d688288b770bda96094cc9a72e6b209a09c93 .generated_files/flags/atsamd21g18a_default/371f82de429950eaa99b35fa67f9d4c59ae13e52
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/uart_debug.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/uart_debug.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/uart_debug.o.d" -o ${OBJECTDIR}/_ext/1360937237/uart_debug.o ../src/uart_debug.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -D_Version2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/uart_comm.o: ../src/uart_comm.c  .generated_files/flags/atsamd21g18a_default/98dc3a5bf08e97ee8112c8a90212a7b12a3f6db .generated_files/flags/atsamd21g18a_default/371f82de429950eaa99b35fa67f9d4c59ae13e52
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/uart_comm.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/uart_comm.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/uart_comm.o.d" -o ${OBJECTDIR}/_ext/1360937237/uart_comm.o ../src/uart_comm.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -D_Version2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/wpfm.o: ../src/wpfm.c  .generated_files/flags/atsamd21g18a_default/b8781e644df315a1bd8d70cdacc0c887e23edcd4 .generated_files/flags/atsamd21g18a_default/371f82de429950eaa99b35fa67f9d4c59ae13e52
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/wpfm.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/wpfm.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/wpfm.o.d" -o ${OBJECTDIR}/_ext/1360937237/wpfm.o ../src/wpfm.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -D_Version2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/battery.o: ../src/battery.c  .generated_files/flags/atsamd21g18a_default/735e9d836f81d311886500493f9788f5438d2c47 .generated_files/flags/atsamd21g18a_default/371f82de429950eaa99b35fa67f9d4c59ae13e52
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/battery.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/battery.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/battery.o.d" -o ${OBJECTDIR}/_ext/1360937237/battery.o ../src/battery.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -D_Version2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/communicate.o: ../src/communicate.c  .generated_files/flags/atsamd21g18a_default/a58d5284ea92bfc05f211ac471861cd3eb806a62 .generated_files/flags/atsamd21g18a_default/371f82de429950eaa99b35fa67f9d4c59ae13e52
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/communicate.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/communicate.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/communicate.o.d" -o ${OBJECTDIR}/_ext/1360937237/communicate.o ../src/communicate.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -D_Version2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/init.o: ../src/init.c  .generated_files/flags/atsamd21g18a_default/996929ebcb1fbdc8d822262122d889ac76fbbdac .generated_files/flags/atsamd21g18a_default/371f82de429950eaa99b35fa67f9d4c59ae13e52
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/init.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/init.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/init.o.d" -o ${OBJECTDIR}/_ext/1360937237/init.o ../src/init.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -D_Version2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/measure.o: ../src/measure.c  .generated_files/flags/atsamd21g18a_default/8e7f3aafef30fbd98257d244b38fe89e5c39d2a5 .generated_files/flags/atsamd21g18a_default/371f82de429950eaa99b35fa67f9d4c59ae13e52
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/measure.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/measure.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/measure.o.d" -o ${OBJECTDIR}/_ext/1360937237/measure.o ../src/measure.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -D_Version2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/alert.o: ../src/alert.c  .generated_files/flags/atsamd21g18a_default/8adb150ed002342a31d2e2e14b808446cbcc017d .generated_files/flags/atsamd21g18a_default/371f82de429950eaa99b35fa67f9d4c59ae13e52
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/alert.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/alert.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/alert.o.d" -o ${OBJECTDIR}/_ext/1360937237/alert.o ../src/alert.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -D_Version2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/smpif4.o: ../src/smpif4.c  .generated_files/flags/atsamd21g18a_default/eed32d0c8e9ac726648a266b99e43b47c1f39927 .generated_files/flags/atsamd21g18a_default/371f82de429950eaa99b35fa67f9d4c59ae13e52
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/smpif4.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/smpif4.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/smpif4.o.d" -o ${OBJECTDIR}/_ext/1360937237/smpif4.o ../src/smpif4.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -D_Version2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/smpif.o: ../src/smpif.c  .generated_files/flags/atsamd21g18a_default/8f3a79757c4be0a47b19a1aa43c33a3894bcc1ad .generated_files/flags/atsamd21g18a_default/371f82de429950eaa99b35fa67f9d4c59ae13e52
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/smpif.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/smpif.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/smpif.o.d" -o ${OBJECTDIR}/_ext/1360937237/smpif.o ../src/smpif.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -D_Version2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/smpif1.o: ../src/smpif1.c  .generated_files/flags/atsamd21g18a_default/aa959abaf70b7f2b58fa136480416b36ab449804 .generated_files/flags/atsamd21g18a_default/371f82de429950eaa99b35fa67f9d4c59ae13e52
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/smpif1.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/smpif1.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/smpif1.o.d" -o ${OBJECTDIR}/_ext/1360937237/smpif1.o ../src/smpif1.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -D_Version2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/smpif2.o: ../src/smpif2.c  .generated_files/flags/atsamd21g18a_default/7b4febdfdc5c0a77350c942f59731d7b242e07bb .generated_files/flags/atsamd21g18a_default/371f82de429950eaa99b35fa67f9d4c59ae13e52
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/smpif2.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/smpif2.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/smpif2.o.d" -o ${OBJECTDIR}/_ext/1360937237/smpif2.o ../src/smpif2.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -D_Version2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/smpif3.o: ../src/smpif3.c  .generated_files/flags/atsamd21g18a_default/61b6920c4fead396f301d028421b1550a6b66289 .generated_files/flags/atsamd21g18a_default/371f82de429950eaa99b35fa67f9d4c59ae13e52
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/smpif3.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/smpif3.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/smpif3.o.d" -o ${OBJECTDIR}/_ext/1360937237/smpif3.o ../src/smpif3.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -D_Version2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/main.o: ../src/main.c  .generated_files/flags/atsamd21g18a_default/2f9a2448d7f8084d2e8b4bc934b9f6d933cdb5a5 .generated_files/flags/atsamd21g18a_default/371f82de429950eaa99b35fa67f9d4c59ae13e52
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/main.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/main.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/main.o.d" -o ${OBJECTDIR}/_ext/1360937237/main.o ../src/main.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -D_Version2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/app.o: ../src/app.c  .generated_files/flags/atsamd21g18a_default/3f247437163e1b749b48d4624e442a21ee4a050d .generated_files/flags/atsamd21g18a_default/371f82de429950eaa99b35fa67f9d4c59ae13e52
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/app.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/app.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/app.o.d" -o ${OBJECTDIR}/_ext/1360937237/app.o ../src/app.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -D_Version2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/MATcore.o: ../src/MATcore.c  .generated_files/flags/atsamd21g18a_default/54989c13f435a3c7067a3238bb6dd81e07736b2d .generated_files/flags/atsamd21g18a_default/371f82de429950eaa99b35fa67f9d4c59ae13e52
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/MATcore.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/MATcore.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/MATcore.o.d" -o ${OBJECTDIR}/_ext/1360937237/MATcore.o ../src/MATcore.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -D_Version2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/moni.o: ../src/moni.c  .generated_files/flags/atsamd21g18a_default/a5a1b70ef9561d9f2e45456e2c204046e2a02ac8 .generated_files/flags/atsamd21g18a_default/371f82de429950eaa99b35fa67f9d4c59ae13e52
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/moni.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/moni.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/moni.o.d" -o ${OBJECTDIR}/_ext/1360937237/moni.o ../src/moni.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -D_Version2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/version.o: ../src/version.c  .generated_files/flags/atsamd21g18a_default/49381e8ff3f44b5e128767d3ed2eb3826403fbb0 .generated_files/flags/atsamd21g18a_default/371f82de429950eaa99b35fa67f9d4c59ae13e52
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/version.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/version.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/version.o.d" -o ${OBJECTDIR}/_ext/1360937237/version.o ../src/version.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -D_Version2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/DLCpara.o: ../src/DLCpara.c  .generated_files/flags/atsamd21g18a_default/f93c06b3499af09f27dbedd6954540fbd207b444 .generated_files/flags/atsamd21g18a_default/371f82de429950eaa99b35fa67f9d4c59ae13e52
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/DLCpara.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/DLCpara.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/DLCpara.o.d" -o ${OBJECTDIR}/_ext/1360937237/DLCpara.o ../src/DLCpara.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -D_Version2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/EventLog.o: ../src/EventLog.c  .generated_files/flags/atsamd21g18a_default/b128b7578a926636a796c1fe7fec7601b240800b .generated_files/flags/atsamd21g18a_default/371f82de429950eaa99b35fa67f9d4c59ae13e52
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/EventLog.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/EventLog.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/EventLog.o.d" -o ${OBJECTDIR}/_ext/1360937237/EventLog.o ../src/EventLog.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -D_Version2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
${OBJECTDIR}/_ext/1360937237/FOTAcmd.o: ../src/FOTAcmd.c  .generated_files/flags/atsamd21g18a_default/ffeae0d8d96b004d2b6bf7640d38e31c11b30cae .generated_files/flags/atsamd21g18a_default/371f82de429950eaa99b35fa67f9d4c59ae13e52
	@${MKDIR} "${OBJECTDIR}/_ext/1360937237" 
	@${RM} ${OBJECTDIR}/_ext/1360937237/FOTAcmd.o.d 
	@${RM} ${OBJECTDIR}/_ext/1360937237/FOTAcmd.o 
	${MP_CC}  $(MP_EXTRA_CC_PRE)  -g -x c -c -mprocessor=$(MP_PROCESSOR_OPTION)  -ffunction-sections -fdata-sections -O1 -fno-common -I"../src" -I"../src/config/atsamd21g18a_default" -I"../src/packs/ATSAMD21G18A_DFP" -I"../src/packs/CMSIS/" -I"../src/packs/CMSIS/CMSIS/Core/Include" -Werror -Wall -MP -MMD -MF "${OBJECTDIR}/_ext/1360937237/FOTAcmd.o.d" -o ${OBJECTDIR}/_ext/1360937237/FOTAcmd.o ../src/FOTAcmd.c    -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -DBOARD_PROTOTYPE2 -D_Version2 -mdfp="${DFP_DIR}/samd21a" ${PACK_COMMON_OPTIONS} 
	
endif

# ------------------------------------------------------------------------------------
# Rules for buildStep: compileCPP
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
else
endif

# ------------------------------------------------------------------------------------
# Rules for buildStep: link
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
${DISTDIR}/DLC02.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}: ${OBJECTFILES}  nbproject/Makefile-${CND_CONF}.mk    ../src/config/atsamd21g18a_default/ATSAMD21G18A.ld
	@${MKDIR} ${DISTDIR} 
	${MP_CC} $(MP_EXTRA_LD_PRE) -g   -mprocessor=$(MP_PROCESSOR_OPTION) -mno-device-startup-code -o ${DISTDIR}/DLC02.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX} ${OBJECTFILES_QUOTED_IF_SPACED}          -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -Wl,--defsym=__MPLAB_BUILD=1$(MP_EXTRA_LD_POST)$(MP_LINKER_FILE_OPTION),--defsym=__ICD2RAM=1,--defsym=__MPLAB_DEBUG=1,--defsym=__DEBUG=1,-D=__DEBUG_D,--defsym=_min_heap_size=512,--gc-sections,-Map="${DISTDIR}/${PROJECTNAME}.${IMAGE_TYPE}.map",--memorysummary,${DISTDIR}/memoryfile.xml -mdfp="${DFP_DIR}/samd21a"
	
else
${DISTDIR}/DLC02.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}: ${OBJECTFILES}  nbproject/Makefile-${CND_CONF}.mk   ../src/config/atsamd21g18a_default/ATSAMD21G18A.ld
	@${MKDIR} ${DISTDIR} 
	${MP_CC} $(MP_EXTRA_LD_PRE)  -mprocessor=$(MP_PROCESSOR_OPTION) -mno-device-startup-code -o ${DISTDIR}/DLC02.X.${IMAGE_TYPE}.${DEBUGGABLE_SUFFIX} ${OBJECTFILES_QUOTED_IF_SPACED}          -DXPRJ_atsamd21g18a_default=$(CND_CONF)    $(COMPARISON_BUILD)  -Wl,--defsym=__MPLAB_BUILD=1$(MP_EXTRA_LD_POST)$(MP_LINKER_FILE_OPTION),--defsym=_min_heap_size=512,--gc-sections,-Map="${DISTDIR}/${PROJECTNAME}.${IMAGE_TYPE}.map",--memorysummary,${DISTDIR}/memoryfile.xml -mdfp="${DFP_DIR}/samd21a"
	${MP_CC_DIR}\\xc32-bin2hex ${DISTDIR}/DLC02.X.${IMAGE_TYPE}.${DEBUGGABLE_SUFFIX} 
	@echo Normalizing hex file
	@"C:/Program Files/Microchip/MPLABX/v6.00/mplab_platform/platform/../mplab_ide/modules/../../bin/hexmate" --edf="C:/Program Files/Microchip/MPLABX/v6.00/mplab_platform/platform/../mplab_ide/modules/../../dat/en_msgs.txt" ${DISTDIR}/DLC02.X.${IMAGE_TYPE}.hex -o${DISTDIR}/DLC02.X.${IMAGE_TYPE}.hex

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
