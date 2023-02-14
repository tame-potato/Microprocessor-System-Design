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
ifeq "$(wildcard nbproject/Makefile-local-default.mk)" "nbproject/Makefile-local-default.mk"
include nbproject/Makefile-local-default.mk
endif
endif

# Environment
MKDIR=gnumkdir -p
RM=rm -f 
MV=mv 
CP=cp 

# Macros
CND_CONF=default
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
IMAGE_TYPE=debug
OUTPUT_SUFFIX=elf
DEBUGGABLE_SUFFIX=elf
FINAL_IMAGE=dist/${CND_CONF}/${IMAGE_TYPE}/HW2.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}
else
IMAGE_TYPE=production
OUTPUT_SUFFIX=hex
DEBUGGABLE_SUFFIX=elf
FINAL_IMAGE=dist/${CND_CONF}/${IMAGE_TYPE}/HW2.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}
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
SOURCEFILES_QUOTED_IF_SPACED=midterm_test.S hw2.S hw2_q2.S hw2_q3.S hw3_q1.S hw3_q2.S hw3_q3.S

# Object Files Quoted if spaced
OBJECTFILES_QUOTED_IF_SPACED=${OBJECTDIR}/midterm_test.o ${OBJECTDIR}/hw2.o ${OBJECTDIR}/hw2_q2.o ${OBJECTDIR}/hw2_q3.o ${OBJECTDIR}/hw3_q1.o ${OBJECTDIR}/hw3_q2.o ${OBJECTDIR}/hw3_q3.o
POSSIBLE_DEPFILES=${OBJECTDIR}/midterm_test.o.d ${OBJECTDIR}/hw2.o.d ${OBJECTDIR}/hw2_q2.o.d ${OBJECTDIR}/hw2_q3.o.d ${OBJECTDIR}/hw3_q1.o.d ${OBJECTDIR}/hw3_q2.o.d ${OBJECTDIR}/hw3_q3.o.d

# Object Files
OBJECTFILES=${OBJECTDIR}/midterm_test.o ${OBJECTDIR}/hw2.o ${OBJECTDIR}/hw2_q2.o ${OBJECTDIR}/hw2_q3.o ${OBJECTDIR}/hw3_q1.o ${OBJECTDIR}/hw3_q2.o ${OBJECTDIR}/hw3_q3.o

# Source Files
SOURCEFILES=midterm_test.S hw2.S hw2_q2.S hw2_q3.S hw3_q1.S hw3_q2.S hw3_q3.S



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

.build-conf:  ${BUILD_SUBPROJECTS}
ifneq ($(INFORMATION_MESSAGE), )
	@echo $(INFORMATION_MESSAGE)
endif
	${MAKE}  -f nbproject/Makefile-default.mk dist/${CND_CONF}/${IMAGE_TYPE}/HW2.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}

MP_PROCESSOR_OPTION=32MM0032GPL036
MP_LINKER_FILE_OPTION=
# ------------------------------------------------------------------------------------
# Rules for buildStep: assemble
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
else
endif

# ------------------------------------------------------------------------------------
# Rules for buildStep: assembleWithPreprocess
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
${OBJECTDIR}/midterm_test.o: midterm_test.S  .generated_files/753107d88ab378f74ae0c3706175854beb5e4d50.flag .generated_files/cd268ce93258a529b0fb3dab2d9c2872c1e094b8.flag
	@${MKDIR} "${OBJECTDIR}" 
	@${RM} ${OBJECTDIR}/midterm_test.o.d 
	@${RM} ${OBJECTDIR}/midterm_test.o 
	@${RM} ${OBJECTDIR}/midterm_test.o.ok ${OBJECTDIR}/midterm_test.o.err 
	${MP_CC} $(MP_EXTRA_AS_PRE)  -D__DEBUG -D__MPLAB_DEBUGGER_SIMULATOR=1 -c -mprocessor=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/midterm_test.o.d"  -o ${OBJECTDIR}/midterm_test.o midterm_test.S  -DXPRJ_default=$(CND_CONF)  -legacy-libc  -Wa,--defsym=__MPLAB_BUILD=1$(MP_EXTRA_AS_POST),-MD="${OBJECTDIR}/midterm_test.o.asm.d",--defsym=__MPLAB_DEBUG=1,--gdwarf-2,--defsym=__DEBUG=1,--defsym=__MPLAB_DEBUGGER_SIMULATOR=1 -mdfp="${DFP_DIR}"
	@${FIXDEPS} "${OBJECTDIR}/midterm_test.o.d" "${OBJECTDIR}/midterm_test.o.asm.d" -t $(SILENT) -rsi ${MP_CC_DIR}../ 
	
${OBJECTDIR}/hw2.o: hw2.S  .generated_files/b61538e9c7f9201923946ce7674764a6bc46b659.flag .generated_files/cd268ce93258a529b0fb3dab2d9c2872c1e094b8.flag
	@${MKDIR} "${OBJECTDIR}" 
	@${RM} ${OBJECTDIR}/hw2.o.d 
	@${RM} ${OBJECTDIR}/hw2.o 
	@${RM} ${OBJECTDIR}/hw2.o.ok ${OBJECTDIR}/hw2.o.err 
	${MP_CC} $(MP_EXTRA_AS_PRE)  -D__DEBUG -D__MPLAB_DEBUGGER_SIMULATOR=1 -c -mprocessor=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/hw2.o.d"  -o ${OBJECTDIR}/hw2.o hw2.S  -DXPRJ_default=$(CND_CONF)  -legacy-libc  -Wa,--defsym=__MPLAB_BUILD=1$(MP_EXTRA_AS_POST),-MD="${OBJECTDIR}/hw2.o.asm.d",--defsym=__MPLAB_DEBUG=1,--gdwarf-2,--defsym=__DEBUG=1,--defsym=__MPLAB_DEBUGGER_SIMULATOR=1 -mdfp="${DFP_DIR}"
	@${FIXDEPS} "${OBJECTDIR}/hw2.o.d" "${OBJECTDIR}/hw2.o.asm.d" -t $(SILENT) -rsi ${MP_CC_DIR}../ 
	
${OBJECTDIR}/hw2_q2.o: hw2_q2.S  .generated_files/d191598968d5271440a0f71da98890dd7b8b3d33.flag .generated_files/cd268ce93258a529b0fb3dab2d9c2872c1e094b8.flag
	@${MKDIR} "${OBJECTDIR}" 
	@${RM} ${OBJECTDIR}/hw2_q2.o.d 
	@${RM} ${OBJECTDIR}/hw2_q2.o 
	@${RM} ${OBJECTDIR}/hw2_q2.o.ok ${OBJECTDIR}/hw2_q2.o.err 
	${MP_CC} $(MP_EXTRA_AS_PRE)  -D__DEBUG -D__MPLAB_DEBUGGER_SIMULATOR=1 -c -mprocessor=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/hw2_q2.o.d"  -o ${OBJECTDIR}/hw2_q2.o hw2_q2.S  -DXPRJ_default=$(CND_CONF)  -legacy-libc  -Wa,--defsym=__MPLAB_BUILD=1$(MP_EXTRA_AS_POST),-MD="${OBJECTDIR}/hw2_q2.o.asm.d",--defsym=__MPLAB_DEBUG=1,--gdwarf-2,--defsym=__DEBUG=1,--defsym=__MPLAB_DEBUGGER_SIMULATOR=1 -mdfp="${DFP_DIR}"
	@${FIXDEPS} "${OBJECTDIR}/hw2_q2.o.d" "${OBJECTDIR}/hw2_q2.o.asm.d" -t $(SILENT) -rsi ${MP_CC_DIR}../ 
	
${OBJECTDIR}/hw2_q3.o: hw2_q3.S  .generated_files/4ce3b4e754295b4b1741d29d73c63c14a60033f6.flag .generated_files/cd268ce93258a529b0fb3dab2d9c2872c1e094b8.flag
	@${MKDIR} "${OBJECTDIR}" 
	@${RM} ${OBJECTDIR}/hw2_q3.o.d 
	@${RM} ${OBJECTDIR}/hw2_q3.o 
	@${RM} ${OBJECTDIR}/hw2_q3.o.ok ${OBJECTDIR}/hw2_q3.o.err 
	${MP_CC} $(MP_EXTRA_AS_PRE)  -D__DEBUG -D__MPLAB_DEBUGGER_SIMULATOR=1 -c -mprocessor=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/hw2_q3.o.d"  -o ${OBJECTDIR}/hw2_q3.o hw2_q3.S  -DXPRJ_default=$(CND_CONF)  -legacy-libc  -Wa,--defsym=__MPLAB_BUILD=1$(MP_EXTRA_AS_POST),-MD="${OBJECTDIR}/hw2_q3.o.asm.d",--defsym=__MPLAB_DEBUG=1,--gdwarf-2,--defsym=__DEBUG=1,--defsym=__MPLAB_DEBUGGER_SIMULATOR=1 -mdfp="${DFP_DIR}"
	@${FIXDEPS} "${OBJECTDIR}/hw2_q3.o.d" "${OBJECTDIR}/hw2_q3.o.asm.d" -t $(SILENT) -rsi ${MP_CC_DIR}../ 
	
${OBJECTDIR}/hw3_q1.o: hw3_q1.S  .generated_files/6eca0c5289e16855d45ef547c4250b0bcf527df6.flag .generated_files/cd268ce93258a529b0fb3dab2d9c2872c1e094b8.flag
	@${MKDIR} "${OBJECTDIR}" 
	@${RM} ${OBJECTDIR}/hw3_q1.o.d 
	@${RM} ${OBJECTDIR}/hw3_q1.o 
	@${RM} ${OBJECTDIR}/hw3_q1.o.ok ${OBJECTDIR}/hw3_q1.o.err 
	${MP_CC} $(MP_EXTRA_AS_PRE)  -D__DEBUG -D__MPLAB_DEBUGGER_SIMULATOR=1 -c -mprocessor=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/hw3_q1.o.d"  -o ${OBJECTDIR}/hw3_q1.o hw3_q1.S  -DXPRJ_default=$(CND_CONF)  -legacy-libc  -Wa,--defsym=__MPLAB_BUILD=1$(MP_EXTRA_AS_POST),-MD="${OBJECTDIR}/hw3_q1.o.asm.d",--defsym=__MPLAB_DEBUG=1,--gdwarf-2,--defsym=__DEBUG=1,--defsym=__MPLAB_DEBUGGER_SIMULATOR=1 -mdfp="${DFP_DIR}"
	@${FIXDEPS} "${OBJECTDIR}/hw3_q1.o.d" "${OBJECTDIR}/hw3_q1.o.asm.d" -t $(SILENT) -rsi ${MP_CC_DIR}../ 
	
${OBJECTDIR}/hw3_q2.o: hw3_q2.S  .generated_files/c0c1ffc2b83b9a6dd24098fc930ac061bb3f0f89.flag .generated_files/cd268ce93258a529b0fb3dab2d9c2872c1e094b8.flag
	@${MKDIR} "${OBJECTDIR}" 
	@${RM} ${OBJECTDIR}/hw3_q2.o.d 
	@${RM} ${OBJECTDIR}/hw3_q2.o 
	@${RM} ${OBJECTDIR}/hw3_q2.o.ok ${OBJECTDIR}/hw3_q2.o.err 
	${MP_CC} $(MP_EXTRA_AS_PRE)  -D__DEBUG -D__MPLAB_DEBUGGER_SIMULATOR=1 -c -mprocessor=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/hw3_q2.o.d"  -o ${OBJECTDIR}/hw3_q2.o hw3_q2.S  -DXPRJ_default=$(CND_CONF)  -legacy-libc  -Wa,--defsym=__MPLAB_BUILD=1$(MP_EXTRA_AS_POST),-MD="${OBJECTDIR}/hw3_q2.o.asm.d",--defsym=__MPLAB_DEBUG=1,--gdwarf-2,--defsym=__DEBUG=1,--defsym=__MPLAB_DEBUGGER_SIMULATOR=1 -mdfp="${DFP_DIR}"
	@${FIXDEPS} "${OBJECTDIR}/hw3_q2.o.d" "${OBJECTDIR}/hw3_q2.o.asm.d" -t $(SILENT) -rsi ${MP_CC_DIR}../ 
	
${OBJECTDIR}/hw3_q3.o: hw3_q3.S  .generated_files/a5564c0834ea7b1109d6c9f6eb098f2a9a4ff8fc.flag .generated_files/cd268ce93258a529b0fb3dab2d9c2872c1e094b8.flag
	@${MKDIR} "${OBJECTDIR}" 
	@${RM} ${OBJECTDIR}/hw3_q3.o.d 
	@${RM} ${OBJECTDIR}/hw3_q3.o 
	@${RM} ${OBJECTDIR}/hw3_q3.o.ok ${OBJECTDIR}/hw3_q3.o.err 
	${MP_CC} $(MP_EXTRA_AS_PRE)  -D__DEBUG -D__MPLAB_DEBUGGER_SIMULATOR=1 -c -mprocessor=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/hw3_q3.o.d"  -o ${OBJECTDIR}/hw3_q3.o hw3_q3.S  -DXPRJ_default=$(CND_CONF)  -legacy-libc  -Wa,--defsym=__MPLAB_BUILD=1$(MP_EXTRA_AS_POST),-MD="${OBJECTDIR}/hw3_q3.o.asm.d",--defsym=__MPLAB_DEBUG=1,--gdwarf-2,--defsym=__DEBUG=1,--defsym=__MPLAB_DEBUGGER_SIMULATOR=1 -mdfp="${DFP_DIR}"
	@${FIXDEPS} "${OBJECTDIR}/hw3_q3.o.d" "${OBJECTDIR}/hw3_q3.o.asm.d" -t $(SILENT) -rsi ${MP_CC_DIR}../ 
	
else
${OBJECTDIR}/midterm_test.o: midterm_test.S  .generated_files/de3c714df8692228cbcc05d718aaa9f207e5281a.flag .generated_files/cd268ce93258a529b0fb3dab2d9c2872c1e094b8.flag
	@${MKDIR} "${OBJECTDIR}" 
	@${RM} ${OBJECTDIR}/midterm_test.o.d 
	@${RM} ${OBJECTDIR}/midterm_test.o 
	@${RM} ${OBJECTDIR}/midterm_test.o.ok ${OBJECTDIR}/midterm_test.o.err 
	${MP_CC} $(MP_EXTRA_AS_PRE)  -c -mprocessor=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/midterm_test.o.d"  -o ${OBJECTDIR}/midterm_test.o midterm_test.S  -DXPRJ_default=$(CND_CONF)  -legacy-libc  -Wa,--defsym=__MPLAB_BUILD=1$(MP_EXTRA_AS_POST),-MD="${OBJECTDIR}/midterm_test.o.asm.d",--gdwarf-2 -mdfp="${DFP_DIR}"
	@${FIXDEPS} "${OBJECTDIR}/midterm_test.o.d" "${OBJECTDIR}/midterm_test.o.asm.d" -t $(SILENT) -rsi ${MP_CC_DIR}../ 
	
${OBJECTDIR}/hw2.o: hw2.S  .generated_files/c21fdae07123f1aec42c6b20161e682ae3b28c8c.flag .generated_files/cd268ce93258a529b0fb3dab2d9c2872c1e094b8.flag
	@${MKDIR} "${OBJECTDIR}" 
	@${RM} ${OBJECTDIR}/hw2.o.d 
	@${RM} ${OBJECTDIR}/hw2.o 
	@${RM} ${OBJECTDIR}/hw2.o.ok ${OBJECTDIR}/hw2.o.err 
	${MP_CC} $(MP_EXTRA_AS_PRE)  -c -mprocessor=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/hw2.o.d"  -o ${OBJECTDIR}/hw2.o hw2.S  -DXPRJ_default=$(CND_CONF)  -legacy-libc  -Wa,--defsym=__MPLAB_BUILD=1$(MP_EXTRA_AS_POST),-MD="${OBJECTDIR}/hw2.o.asm.d",--gdwarf-2 -mdfp="${DFP_DIR}"
	@${FIXDEPS} "${OBJECTDIR}/hw2.o.d" "${OBJECTDIR}/hw2.o.asm.d" -t $(SILENT) -rsi ${MP_CC_DIR}../ 
	
${OBJECTDIR}/hw2_q2.o: hw2_q2.S  .generated_files/8c7d03da0846629ee266a1d4679f8b6388b63aba.flag .generated_files/cd268ce93258a529b0fb3dab2d9c2872c1e094b8.flag
	@${MKDIR} "${OBJECTDIR}" 
	@${RM} ${OBJECTDIR}/hw2_q2.o.d 
	@${RM} ${OBJECTDIR}/hw2_q2.o 
	@${RM} ${OBJECTDIR}/hw2_q2.o.ok ${OBJECTDIR}/hw2_q2.o.err 
	${MP_CC} $(MP_EXTRA_AS_PRE)  -c -mprocessor=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/hw2_q2.o.d"  -o ${OBJECTDIR}/hw2_q2.o hw2_q2.S  -DXPRJ_default=$(CND_CONF)  -legacy-libc  -Wa,--defsym=__MPLAB_BUILD=1$(MP_EXTRA_AS_POST),-MD="${OBJECTDIR}/hw2_q2.o.asm.d",--gdwarf-2 -mdfp="${DFP_DIR}"
	@${FIXDEPS} "${OBJECTDIR}/hw2_q2.o.d" "${OBJECTDIR}/hw2_q2.o.asm.d" -t $(SILENT) -rsi ${MP_CC_DIR}../ 
	
${OBJECTDIR}/hw2_q3.o: hw2_q3.S  .generated_files/c508a63694ae22187d3703673a7e5af0cffcb015.flag .generated_files/cd268ce93258a529b0fb3dab2d9c2872c1e094b8.flag
	@${MKDIR} "${OBJECTDIR}" 
	@${RM} ${OBJECTDIR}/hw2_q3.o.d 
	@${RM} ${OBJECTDIR}/hw2_q3.o 
	@${RM} ${OBJECTDIR}/hw2_q3.o.ok ${OBJECTDIR}/hw2_q3.o.err 
	${MP_CC} $(MP_EXTRA_AS_PRE)  -c -mprocessor=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/hw2_q3.o.d"  -o ${OBJECTDIR}/hw2_q3.o hw2_q3.S  -DXPRJ_default=$(CND_CONF)  -legacy-libc  -Wa,--defsym=__MPLAB_BUILD=1$(MP_EXTRA_AS_POST),-MD="${OBJECTDIR}/hw2_q3.o.asm.d",--gdwarf-2 -mdfp="${DFP_DIR}"
	@${FIXDEPS} "${OBJECTDIR}/hw2_q3.o.d" "${OBJECTDIR}/hw2_q3.o.asm.d" -t $(SILENT) -rsi ${MP_CC_DIR}../ 
	
${OBJECTDIR}/hw3_q1.o: hw3_q1.S  .generated_files/2cd0fe539f4a5bc5c7883e2f697aa77b62b0d222.flag .generated_files/cd268ce93258a529b0fb3dab2d9c2872c1e094b8.flag
	@${MKDIR} "${OBJECTDIR}" 
	@${RM} ${OBJECTDIR}/hw3_q1.o.d 
	@${RM} ${OBJECTDIR}/hw3_q1.o 
	@${RM} ${OBJECTDIR}/hw3_q1.o.ok ${OBJECTDIR}/hw3_q1.o.err 
	${MP_CC} $(MP_EXTRA_AS_PRE)  -c -mprocessor=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/hw3_q1.o.d"  -o ${OBJECTDIR}/hw3_q1.o hw3_q1.S  -DXPRJ_default=$(CND_CONF)  -legacy-libc  -Wa,--defsym=__MPLAB_BUILD=1$(MP_EXTRA_AS_POST),-MD="${OBJECTDIR}/hw3_q1.o.asm.d",--gdwarf-2 -mdfp="${DFP_DIR}"
	@${FIXDEPS} "${OBJECTDIR}/hw3_q1.o.d" "${OBJECTDIR}/hw3_q1.o.asm.d" -t $(SILENT) -rsi ${MP_CC_DIR}../ 
	
${OBJECTDIR}/hw3_q2.o: hw3_q2.S  .generated_files/9b5014e030d5390ffbb9c1ac0abca1dfdaecd896.flag .generated_files/cd268ce93258a529b0fb3dab2d9c2872c1e094b8.flag
	@${MKDIR} "${OBJECTDIR}" 
	@${RM} ${OBJECTDIR}/hw3_q2.o.d 
	@${RM} ${OBJECTDIR}/hw3_q2.o 
	@${RM} ${OBJECTDIR}/hw3_q2.o.ok ${OBJECTDIR}/hw3_q2.o.err 
	${MP_CC} $(MP_EXTRA_AS_PRE)  -c -mprocessor=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/hw3_q2.o.d"  -o ${OBJECTDIR}/hw3_q2.o hw3_q2.S  -DXPRJ_default=$(CND_CONF)  -legacy-libc  -Wa,--defsym=__MPLAB_BUILD=1$(MP_EXTRA_AS_POST),-MD="${OBJECTDIR}/hw3_q2.o.asm.d",--gdwarf-2 -mdfp="${DFP_DIR}"
	@${FIXDEPS} "${OBJECTDIR}/hw3_q2.o.d" "${OBJECTDIR}/hw3_q2.o.asm.d" -t $(SILENT) -rsi ${MP_CC_DIR}../ 
	
${OBJECTDIR}/hw3_q3.o: hw3_q3.S  .generated_files/f143f579b7d2dab2ca0a60b196cd8714d0a74a26.flag .generated_files/cd268ce93258a529b0fb3dab2d9c2872c1e094b8.flag
	@${MKDIR} "${OBJECTDIR}" 
	@${RM} ${OBJECTDIR}/hw3_q3.o.d 
	@${RM} ${OBJECTDIR}/hw3_q3.o 
	@${RM} ${OBJECTDIR}/hw3_q3.o.ok ${OBJECTDIR}/hw3_q3.o.err 
	${MP_CC} $(MP_EXTRA_AS_PRE)  -c -mprocessor=$(MP_PROCESSOR_OPTION)  -MMD -MF "${OBJECTDIR}/hw3_q3.o.d"  -o ${OBJECTDIR}/hw3_q3.o hw3_q3.S  -DXPRJ_default=$(CND_CONF)  -legacy-libc  -Wa,--defsym=__MPLAB_BUILD=1$(MP_EXTRA_AS_POST),-MD="${OBJECTDIR}/hw3_q3.o.asm.d",--gdwarf-2 -mdfp="${DFP_DIR}"
	@${FIXDEPS} "${OBJECTDIR}/hw3_q3.o.d" "${OBJECTDIR}/hw3_q3.o.asm.d" -t $(SILENT) -rsi ${MP_CC_DIR}../ 
	
endif

# ------------------------------------------------------------------------------------
# Rules for buildStep: compile
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
else
endif

# ------------------------------------------------------------------------------------
# Rules for buildStep: compileCPP
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
else
endif

# ------------------------------------------------------------------------------------
# Rules for buildStep: link
ifeq ($(TYPE_IMAGE), DEBUG_RUN)
dist/${CND_CONF}/${IMAGE_TYPE}/HW2.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}: ${OBJECTFILES}  nbproject/Makefile-${CND_CONF}.mk    
	@${MKDIR} dist/${CND_CONF}/${IMAGE_TYPE} 
	${MP_CC} $(MP_EXTRA_LD_PRE) -g -mdebugger -D__MPLAB_DEBUGGER_SIMULATOR=1 -mprocessor=$(MP_PROCESSOR_OPTION)  -o dist/${CND_CONF}/${IMAGE_TYPE}/HW2.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX} ${OBJECTFILES_QUOTED_IF_SPACED}          -DXPRJ_default=$(CND_CONF)  -legacy-libc  $(COMPARISON_BUILD)      -Wl,--defsym=__MPLAB_BUILD=1$(MP_EXTRA_LD_POST)$(MP_LINKER_FILE_OPTION),--defsym=__MPLAB_DEBUG=1,--defsym=__DEBUG=1,-D=__DEBUG_D,--defsym=__MPLAB_DEBUGGER_SIMULATOR=1,--no-code-in-dinit,--no-dinit-in-serial-mem,-Map="${DISTDIR}/${PROJECTNAME}.${IMAGE_TYPE}.map",--memorysummary,dist/${CND_CONF}/${IMAGE_TYPE}/memoryfile.xml -mdfp="${DFP_DIR}"
	
else
dist/${CND_CONF}/${IMAGE_TYPE}/HW2.X.${IMAGE_TYPE}.${OUTPUT_SUFFIX}: ${OBJECTFILES}  nbproject/Makefile-${CND_CONF}.mk   
	@${MKDIR} dist/${CND_CONF}/${IMAGE_TYPE} 
	${MP_CC} $(MP_EXTRA_LD_PRE)  -mprocessor=$(MP_PROCESSOR_OPTION)  -o dist/${CND_CONF}/${IMAGE_TYPE}/HW2.X.${IMAGE_TYPE}.${DEBUGGABLE_SUFFIX} ${OBJECTFILES_QUOTED_IF_SPACED}          -DXPRJ_default=$(CND_CONF)  -legacy-libc  $(COMPARISON_BUILD)  -Wl,--defsym=__MPLAB_BUILD=1$(MP_EXTRA_LD_POST)$(MP_LINKER_FILE_OPTION),--no-code-in-dinit,--no-dinit-in-serial-mem,-Map="${DISTDIR}/${PROJECTNAME}.${IMAGE_TYPE}.map",--memorysummary,dist/${CND_CONF}/${IMAGE_TYPE}/memoryfile.xml -mdfp="${DFP_DIR}"
	${MP_CC_DIR}\\xc32-bin2hex dist/${CND_CONF}/${IMAGE_TYPE}/HW2.X.${IMAGE_TYPE}.${DEBUGGABLE_SUFFIX} 
endif


# Subprojects
.build-subprojects:


# Subprojects
.clean-subprojects:

# Clean Targets
.clean-conf: ${CLEAN_SUBPROJECTS}
	${RM} -r build/default
	${RM} -r dist/default

# Enable dependency checking
.dep.inc: .depcheck-impl

DEPFILES=$(shell mplabwildcard ${POSSIBLE_DEPFILES})
ifneq (${DEPFILES},)
include ${DEPFILES}
endif
