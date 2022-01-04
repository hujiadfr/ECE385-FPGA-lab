/*
 * system.h - SOPC Builder system and BSP software package information
 *
 * Machine generated for CPU 'nios2_gen2_0' in SOPC Builder design 'final_soc'
 * SOPC Builder design path: ../../final_soc.sopcinfo
 *
 * Generated: Tue Jan 04 13:18:05 CST 2022
 */

/*
 * DO NOT MODIFY THIS FILE
 *
 * Changing this file will have subtle consequences
 * which will almost certainly lead to a nonfunctioning
 * system. If you do modify this file, be aware that your
 * changes will be overwritten and lost when this file
 * is generated again.
 *
 * DO NOT MODIFY THIS FILE
 */

/*
 * License Agreement
 *
 * Copyright (c) 2008
 * Altera Corporation, San Jose, California, USA.
 * All rights reserved.
 *
 * Permission is hereby granted, free of charge, to any person obtaining a
 * copy of this software and associated documentation files (the "Software"),
 * to deal in the Software without restriction, including without limitation
 * the rights to use, copy, modify, merge, publish, distribute, sublicense,
 * and/or sell copies of the Software, and to permit persons to whom the
 * Software is furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
 * DEALINGS IN THE SOFTWARE.
 *
 * This agreement shall be governed in all respects by the laws of the State
 * of California and by the laws of the United States of America.
 */

#ifndef __SYSTEM_H_
#define __SYSTEM_H_

/* Include definitions from linker script generator */
#include "linker.h"


/*
 * CPU configuration
 *
 */

#define ALT_CPU_ARCHITECTURE "altera_nios2_gen2"
#define ALT_CPU_BIG_ENDIAN 0
#define ALT_CPU_BREAK_ADDR 0x10000820
#define ALT_CPU_CPU_ARCH_NIOS2_R1
#define ALT_CPU_CPU_FREQ 50000000u
#define ALT_CPU_CPU_ID_SIZE 1
#define ALT_CPU_CPU_ID_VALUE 0x00000000
#define ALT_CPU_CPU_IMPLEMENTATION "tiny"
#define ALT_CPU_DATA_ADDR_WIDTH 0x1d
#define ALT_CPU_DCACHE_LINE_SIZE 0
#define ALT_CPU_DCACHE_LINE_SIZE_LOG2 0
#define ALT_CPU_DCACHE_SIZE 0
#define ALT_CPU_EXCEPTION_ADDR 0x08000020
#define ALT_CPU_FLASH_ACCELERATOR_LINES 0
#define ALT_CPU_FLASH_ACCELERATOR_LINE_SIZE 0
#define ALT_CPU_FLUSHDA_SUPPORTED
#define ALT_CPU_FREQ 50000000
#define ALT_CPU_HARDWARE_DIVIDE_PRESENT 0
#define ALT_CPU_HARDWARE_MULTIPLY_PRESENT 0
#define ALT_CPU_HARDWARE_MULX_PRESENT 0
#define ALT_CPU_HAS_DEBUG_CORE 1
#define ALT_CPU_HAS_DEBUG_STUB
#define ALT_CPU_HAS_ILLEGAL_INSTRUCTION_EXCEPTION
#define ALT_CPU_HAS_JMPI_INSTRUCTION
#define ALT_CPU_ICACHE_LINE_SIZE 0
#define ALT_CPU_ICACHE_LINE_SIZE_LOG2 0
#define ALT_CPU_ICACHE_SIZE 0
#define ALT_CPU_INST_ADDR_WIDTH 0x1d
#define ALT_CPU_NAME "nios2_gen2_0"
#define ALT_CPU_OCI_VERSION 1
#define ALT_CPU_RESET_ADDR 0x08000000


/*
 * CPU configuration (with legacy prefix - don't use these anymore)
 *
 */

#define NIOS2_BIG_ENDIAN 0
#define NIOS2_BREAK_ADDR 0x10000820
#define NIOS2_CPU_ARCH_NIOS2_R1
#define NIOS2_CPU_FREQ 50000000u
#define NIOS2_CPU_ID_SIZE 1
#define NIOS2_CPU_ID_VALUE 0x00000000
#define NIOS2_CPU_IMPLEMENTATION "tiny"
#define NIOS2_DATA_ADDR_WIDTH 0x1d
#define NIOS2_DCACHE_LINE_SIZE 0
#define NIOS2_DCACHE_LINE_SIZE_LOG2 0
#define NIOS2_DCACHE_SIZE 0
#define NIOS2_EXCEPTION_ADDR 0x08000020
#define NIOS2_FLASH_ACCELERATOR_LINES 0
#define NIOS2_FLASH_ACCELERATOR_LINE_SIZE 0
#define NIOS2_FLUSHDA_SUPPORTED
#define NIOS2_HARDWARE_DIVIDE_PRESENT 0
#define NIOS2_HARDWARE_MULTIPLY_PRESENT 0
#define NIOS2_HARDWARE_MULX_PRESENT 0
#define NIOS2_HAS_DEBUG_CORE 1
#define NIOS2_HAS_DEBUG_STUB
#define NIOS2_HAS_ILLEGAL_INSTRUCTION_EXCEPTION
#define NIOS2_HAS_JMPI_INSTRUCTION
#define NIOS2_ICACHE_LINE_SIZE 0
#define NIOS2_ICACHE_LINE_SIZE_LOG2 0
#define NIOS2_ICACHE_SIZE 0
#define NIOS2_INST_ADDR_WIDTH 0x1d
#define NIOS2_OCI_VERSION 1
#define NIOS2_RESET_ADDR 0x08000000


/*
 * Define for each module class mastered by the CPU
 *
 */

#define __ALTERA_AVALON_JTAG_UART
#define __ALTERA_AVALON_NEW_SDRAM_CONTROLLER
#define __ALTERA_AVALON_PIO
#define __ALTERA_AVALON_SYSID_QSYS
#define __ALTERA_NIOS2_GEN2
#define __ALTPLL
#define __GAME_CORE


/*
 * SDRAM configuration
 *
 */

#define ALT_MODULE_CLASS_SDRAM altera_avalon_new_sdram_controller
#define SDRAM_BASE 0x8000000
#define SDRAM_CAS_LATENCY 3
#define SDRAM_CONTENTS_INFO
#define SDRAM_INIT_NOP_DELAY 0.0
#define SDRAM_INIT_REFRESH_COMMANDS 2
#define SDRAM_IRQ -1
#define SDRAM_IRQ_INTERRUPT_CONTROLLER_ID -1
#define SDRAM_IS_INITIALIZED 1
#define SDRAM_NAME "/dev/SDRAM"
#define SDRAM_POWERUP_DELAY 100.0
#define SDRAM_REFRESH_PERIOD 7.8125
#define SDRAM_REGISTER_DATA_IN 1
#define SDRAM_SDRAM_ADDR_WIDTH 0x19
#define SDRAM_SDRAM_BANK_WIDTH 2
#define SDRAM_SDRAM_COL_WIDTH 10
#define SDRAM_SDRAM_DATA_WIDTH 32
#define SDRAM_SDRAM_NUM_BANKS 4
#define SDRAM_SDRAM_NUM_CHIPSELECTS 1
#define SDRAM_SDRAM_ROW_WIDTH 13
#define SDRAM_SHARED_DATA 0
#define SDRAM_SIM_MODEL_BASE 0
#define SDRAM_SPAN 134217728
#define SDRAM_STARVATION_INDICATOR 0
#define SDRAM_TRISTATE_BRIDGE_SLAVE ""
#define SDRAM_TYPE "altera_avalon_new_sdram_controller"
#define SDRAM_T_AC 5.5
#define SDRAM_T_MRD 3
#define SDRAM_T_RCD 20.0
#define SDRAM_T_RFC 70.0
#define SDRAM_T_RP 20.0
#define SDRAM_T_WR 14.0


/*
 * System configuration
 *
 */

#define ALT_DEVICE_FAMILY "Cyclone IV E"
#define ALT_ENHANCED_INTERRUPT_API_PRESENT
#define ALT_IRQ_BASE NULL
#define ALT_LOG_PORT "/dev/null"
#define ALT_LOG_PORT_BASE 0x0
#define ALT_LOG_PORT_DEV null
#define ALT_LOG_PORT_TYPE ""
#define ALT_NUM_EXTERNAL_INTERRUPT_CONTROLLERS 0
#define ALT_NUM_INTERNAL_INTERRUPT_CONTROLLERS 1
#define ALT_NUM_INTERRUPT_CONTROLLERS 1
#define ALT_STDERR "/dev/jtag_uart_0"
#define ALT_STDERR_BASE 0x10001410
#define ALT_STDERR_DEV jtag_uart_0
#define ALT_STDERR_IS_JTAG_UART
#define ALT_STDERR_PRESENT
#define ALT_STDERR_TYPE "altera_avalon_jtag_uart"
#define ALT_STDIN "/dev/jtag_uart_0"
#define ALT_STDIN_BASE 0x10001410
#define ALT_STDIN_DEV jtag_uart_0
#define ALT_STDIN_IS_JTAG_UART
#define ALT_STDIN_PRESENT
#define ALT_STDIN_TYPE "altera_avalon_jtag_uart"
#define ALT_STDOUT "/dev/jtag_uart_0"
#define ALT_STDOUT_BASE 0x10001410
#define ALT_STDOUT_DEV jtag_uart_0
#define ALT_STDOUT_IS_JTAG_UART
#define ALT_STDOUT_PRESENT
#define ALT_STDOUT_TYPE "altera_avalon_jtag_uart"
#define ALT_SYSTEM_NAME "final_soc"


/*
 * bullet_1_x_0 configuration
 *
 */

#define ALT_MODULE_CLASS_bullet_1_x_0 altera_avalon_pio
#define BULLET_1_X_0_BASE 0x10001380
#define BULLET_1_X_0_BIT_CLEARING_EDGE_REGISTER 0
#define BULLET_1_X_0_BIT_MODIFYING_OUTPUT_REGISTER 0
#define BULLET_1_X_0_CAPTURE 0
#define BULLET_1_X_0_DATA_WIDTH 10
#define BULLET_1_X_0_DO_TEST_BENCH_WIRING 0
#define BULLET_1_X_0_DRIVEN_SIM_VALUE 0
#define BULLET_1_X_0_EDGE_TYPE "NONE"
#define BULLET_1_X_0_FREQ 50000000
#define BULLET_1_X_0_HAS_IN 0
#define BULLET_1_X_0_HAS_OUT 1
#define BULLET_1_X_0_HAS_TRI 0
#define BULLET_1_X_0_IRQ -1
#define BULLET_1_X_0_IRQ_INTERRUPT_CONTROLLER_ID -1
#define BULLET_1_X_0_IRQ_TYPE "NONE"
#define BULLET_1_X_0_NAME "/dev/bullet_1_x_0"
#define BULLET_1_X_0_RESET_VALUE 0
#define BULLET_1_X_0_SPAN 16
#define BULLET_1_X_0_TYPE "altera_avalon_pio"


/*
 * bullet_1_x_1 configuration
 *
 */

#define ALT_MODULE_CLASS_bullet_1_x_1 altera_avalon_pio
#define BULLET_1_X_1_BASE 0x10001370
#define BULLET_1_X_1_BIT_CLEARING_EDGE_REGISTER 0
#define BULLET_1_X_1_BIT_MODIFYING_OUTPUT_REGISTER 0
#define BULLET_1_X_1_CAPTURE 0
#define BULLET_1_X_1_DATA_WIDTH 10
#define BULLET_1_X_1_DO_TEST_BENCH_WIRING 0
#define BULLET_1_X_1_DRIVEN_SIM_VALUE 0
#define BULLET_1_X_1_EDGE_TYPE "NONE"
#define BULLET_1_X_1_FREQ 50000000
#define BULLET_1_X_1_HAS_IN 0
#define BULLET_1_X_1_HAS_OUT 1
#define BULLET_1_X_1_HAS_TRI 0
#define BULLET_1_X_1_IRQ -1
#define BULLET_1_X_1_IRQ_INTERRUPT_CONTROLLER_ID -1
#define BULLET_1_X_1_IRQ_TYPE "NONE"
#define BULLET_1_X_1_NAME "/dev/bullet_1_x_1"
#define BULLET_1_X_1_RESET_VALUE 0
#define BULLET_1_X_1_SPAN 16
#define BULLET_1_X_1_TYPE "altera_avalon_pio"


/*
 * bullet_1_x_2 configuration
 *
 */

#define ALT_MODULE_CLASS_bullet_1_x_2 altera_avalon_pio
#define BULLET_1_X_2_BASE 0x10001360
#define BULLET_1_X_2_BIT_CLEARING_EDGE_REGISTER 0
#define BULLET_1_X_2_BIT_MODIFYING_OUTPUT_REGISTER 0
#define BULLET_1_X_2_CAPTURE 0
#define BULLET_1_X_2_DATA_WIDTH 10
#define BULLET_1_X_2_DO_TEST_BENCH_WIRING 0
#define BULLET_1_X_2_DRIVEN_SIM_VALUE 0
#define BULLET_1_X_2_EDGE_TYPE "NONE"
#define BULLET_1_X_2_FREQ 50000000
#define BULLET_1_X_2_HAS_IN 0
#define BULLET_1_X_2_HAS_OUT 1
#define BULLET_1_X_2_HAS_TRI 0
#define BULLET_1_X_2_IRQ -1
#define BULLET_1_X_2_IRQ_INTERRUPT_CONTROLLER_ID -1
#define BULLET_1_X_2_IRQ_TYPE "NONE"
#define BULLET_1_X_2_NAME "/dev/bullet_1_x_2"
#define BULLET_1_X_2_RESET_VALUE 0
#define BULLET_1_X_2_SPAN 16
#define BULLET_1_X_2_TYPE "altera_avalon_pio"


/*
 * bullet_1_x_3 configuration
 *
 */

#define ALT_MODULE_CLASS_bullet_1_x_3 altera_avalon_pio
#define BULLET_1_X_3_BASE 0x10001350
#define BULLET_1_X_3_BIT_CLEARING_EDGE_REGISTER 0
#define BULLET_1_X_3_BIT_MODIFYING_OUTPUT_REGISTER 0
#define BULLET_1_X_3_CAPTURE 0
#define BULLET_1_X_3_DATA_WIDTH 10
#define BULLET_1_X_3_DO_TEST_BENCH_WIRING 0
#define BULLET_1_X_3_DRIVEN_SIM_VALUE 0
#define BULLET_1_X_3_EDGE_TYPE "NONE"
#define BULLET_1_X_3_FREQ 50000000
#define BULLET_1_X_3_HAS_IN 0
#define BULLET_1_X_3_HAS_OUT 1
#define BULLET_1_X_3_HAS_TRI 0
#define BULLET_1_X_3_IRQ -1
#define BULLET_1_X_3_IRQ_INTERRUPT_CONTROLLER_ID -1
#define BULLET_1_X_3_IRQ_TYPE "NONE"
#define BULLET_1_X_3_NAME "/dev/bullet_1_x_3"
#define BULLET_1_X_3_RESET_VALUE 0
#define BULLET_1_X_3_SPAN 16
#define BULLET_1_X_3_TYPE "altera_avalon_pio"


/*
 * bullet_1_x_4 configuration
 *
 */

#define ALT_MODULE_CLASS_bullet_1_x_4 altera_avalon_pio
#define BULLET_1_X_4_BASE 0x10001340
#define BULLET_1_X_4_BIT_CLEARING_EDGE_REGISTER 0
#define BULLET_1_X_4_BIT_MODIFYING_OUTPUT_REGISTER 0
#define BULLET_1_X_4_CAPTURE 0
#define BULLET_1_X_4_DATA_WIDTH 10
#define BULLET_1_X_4_DO_TEST_BENCH_WIRING 0
#define BULLET_1_X_4_DRIVEN_SIM_VALUE 0
#define BULLET_1_X_4_EDGE_TYPE "NONE"
#define BULLET_1_X_4_FREQ 50000000
#define BULLET_1_X_4_HAS_IN 0
#define BULLET_1_X_4_HAS_OUT 1
#define BULLET_1_X_4_HAS_TRI 0
#define BULLET_1_X_4_IRQ -1
#define BULLET_1_X_4_IRQ_INTERRUPT_CONTROLLER_ID -1
#define BULLET_1_X_4_IRQ_TYPE "NONE"
#define BULLET_1_X_4_NAME "/dev/bullet_1_x_4"
#define BULLET_1_X_4_RESET_VALUE 0
#define BULLET_1_X_4_SPAN 16
#define BULLET_1_X_4_TYPE "altera_avalon_pio"


/*
 * bullet_1_x_5 configuration
 *
 */

#define ALT_MODULE_CLASS_bullet_1_x_5 altera_avalon_pio
#define BULLET_1_X_5_BASE 0x10001330
#define BULLET_1_X_5_BIT_CLEARING_EDGE_REGISTER 0
#define BULLET_1_X_5_BIT_MODIFYING_OUTPUT_REGISTER 0
#define BULLET_1_X_5_CAPTURE 0
#define BULLET_1_X_5_DATA_WIDTH 10
#define BULLET_1_X_5_DO_TEST_BENCH_WIRING 0
#define BULLET_1_X_5_DRIVEN_SIM_VALUE 0
#define BULLET_1_X_5_EDGE_TYPE "NONE"
#define BULLET_1_X_5_FREQ 50000000
#define BULLET_1_X_5_HAS_IN 0
#define BULLET_1_X_5_HAS_OUT 1
#define BULLET_1_X_5_HAS_TRI 0
#define BULLET_1_X_5_IRQ -1
#define BULLET_1_X_5_IRQ_INTERRUPT_CONTROLLER_ID -1
#define BULLET_1_X_5_IRQ_TYPE "NONE"
#define BULLET_1_X_5_NAME "/dev/bullet_1_x_5"
#define BULLET_1_X_5_RESET_VALUE 0
#define BULLET_1_X_5_SPAN 16
#define BULLET_1_X_5_TYPE "altera_avalon_pio"


/*
 * bullet_1_x_6 configuration
 *
 */

#define ALT_MODULE_CLASS_bullet_1_x_6 altera_avalon_pio
#define BULLET_1_X_6_BASE 0x10001320
#define BULLET_1_X_6_BIT_CLEARING_EDGE_REGISTER 0
#define BULLET_1_X_6_BIT_MODIFYING_OUTPUT_REGISTER 0
#define BULLET_1_X_6_CAPTURE 0
#define BULLET_1_X_6_DATA_WIDTH 10
#define BULLET_1_X_6_DO_TEST_BENCH_WIRING 0
#define BULLET_1_X_6_DRIVEN_SIM_VALUE 0
#define BULLET_1_X_6_EDGE_TYPE "NONE"
#define BULLET_1_X_6_FREQ 50000000
#define BULLET_1_X_6_HAS_IN 0
#define BULLET_1_X_6_HAS_OUT 1
#define BULLET_1_X_6_HAS_TRI 0
#define BULLET_1_X_6_IRQ -1
#define BULLET_1_X_6_IRQ_INTERRUPT_CONTROLLER_ID -1
#define BULLET_1_X_6_IRQ_TYPE "NONE"
#define BULLET_1_X_6_NAME "/dev/bullet_1_x_6"
#define BULLET_1_X_6_RESET_VALUE 0
#define BULLET_1_X_6_SPAN 16
#define BULLET_1_X_6_TYPE "altera_avalon_pio"


/*
 * bullet_1_x_7 configuration
 *
 */

#define ALT_MODULE_CLASS_bullet_1_x_7 altera_avalon_pio
#define BULLET_1_X_7_BASE 0x10001310
#define BULLET_1_X_7_BIT_CLEARING_EDGE_REGISTER 0
#define BULLET_1_X_7_BIT_MODIFYING_OUTPUT_REGISTER 0
#define BULLET_1_X_7_CAPTURE 0
#define BULLET_1_X_7_DATA_WIDTH 10
#define BULLET_1_X_7_DO_TEST_BENCH_WIRING 0
#define BULLET_1_X_7_DRIVEN_SIM_VALUE 0
#define BULLET_1_X_7_EDGE_TYPE "NONE"
#define BULLET_1_X_7_FREQ 50000000
#define BULLET_1_X_7_HAS_IN 0
#define BULLET_1_X_7_HAS_OUT 1
#define BULLET_1_X_7_HAS_TRI 0
#define BULLET_1_X_7_IRQ -1
#define BULLET_1_X_7_IRQ_INTERRUPT_CONTROLLER_ID -1
#define BULLET_1_X_7_IRQ_TYPE "NONE"
#define BULLET_1_X_7_NAME "/dev/bullet_1_x_7"
#define BULLET_1_X_7_RESET_VALUE 0
#define BULLET_1_X_7_SPAN 16
#define BULLET_1_X_7_TYPE "altera_avalon_pio"


/*
 * bullet_1_x_8 configuration
 *
 */

#define ALT_MODULE_CLASS_bullet_1_x_8 altera_avalon_pio
#define BULLET_1_X_8_BASE 0x10001300
#define BULLET_1_X_8_BIT_CLEARING_EDGE_REGISTER 0
#define BULLET_1_X_8_BIT_MODIFYING_OUTPUT_REGISTER 0
#define BULLET_1_X_8_CAPTURE 0
#define BULLET_1_X_8_DATA_WIDTH 10
#define BULLET_1_X_8_DO_TEST_BENCH_WIRING 0
#define BULLET_1_X_8_DRIVEN_SIM_VALUE 0
#define BULLET_1_X_8_EDGE_TYPE "NONE"
#define BULLET_1_X_8_FREQ 50000000
#define BULLET_1_X_8_HAS_IN 0
#define BULLET_1_X_8_HAS_OUT 1
#define BULLET_1_X_8_HAS_TRI 0
#define BULLET_1_X_8_IRQ -1
#define BULLET_1_X_8_IRQ_INTERRUPT_CONTROLLER_ID -1
#define BULLET_1_X_8_IRQ_TYPE "NONE"
#define BULLET_1_X_8_NAME "/dev/bullet_1_x_8"
#define BULLET_1_X_8_RESET_VALUE 0
#define BULLET_1_X_8_SPAN 16
#define BULLET_1_X_8_TYPE "altera_avalon_pio"


/*
 * bullet_1_x_9 configuration
 *
 */

#define ALT_MODULE_CLASS_bullet_1_x_9 altera_avalon_pio
#define BULLET_1_X_9_BASE 0x100012f0
#define BULLET_1_X_9_BIT_CLEARING_EDGE_REGISTER 0
#define BULLET_1_X_9_BIT_MODIFYING_OUTPUT_REGISTER 0
#define BULLET_1_X_9_CAPTURE 0
#define BULLET_1_X_9_DATA_WIDTH 10
#define BULLET_1_X_9_DO_TEST_BENCH_WIRING 0
#define BULLET_1_X_9_DRIVEN_SIM_VALUE 0
#define BULLET_1_X_9_EDGE_TYPE "NONE"
#define BULLET_1_X_9_FREQ 50000000
#define BULLET_1_X_9_HAS_IN 0
#define BULLET_1_X_9_HAS_OUT 1
#define BULLET_1_X_9_HAS_TRI 0
#define BULLET_1_X_9_IRQ -1
#define BULLET_1_X_9_IRQ_INTERRUPT_CONTROLLER_ID -1
#define BULLET_1_X_9_IRQ_TYPE "NONE"
#define BULLET_1_X_9_NAME "/dev/bullet_1_x_9"
#define BULLET_1_X_9_RESET_VALUE 0
#define BULLET_1_X_9_SPAN 16
#define BULLET_1_X_9_TYPE "altera_avalon_pio"


/*
 * bullet_1_y_0 configuration
 *
 */

#define ALT_MODULE_CLASS_bullet_1_y_0 altera_avalon_pio
#define BULLET_1_Y_0_BASE 0x100012e0
#define BULLET_1_Y_0_BIT_CLEARING_EDGE_REGISTER 0
#define BULLET_1_Y_0_BIT_MODIFYING_OUTPUT_REGISTER 0
#define BULLET_1_Y_0_CAPTURE 0
#define BULLET_1_Y_0_DATA_WIDTH 10
#define BULLET_1_Y_0_DO_TEST_BENCH_WIRING 0
#define BULLET_1_Y_0_DRIVEN_SIM_VALUE 0
#define BULLET_1_Y_0_EDGE_TYPE "NONE"
#define BULLET_1_Y_0_FREQ 50000000
#define BULLET_1_Y_0_HAS_IN 0
#define BULLET_1_Y_0_HAS_OUT 1
#define BULLET_1_Y_0_HAS_TRI 0
#define BULLET_1_Y_0_IRQ -1
#define BULLET_1_Y_0_IRQ_INTERRUPT_CONTROLLER_ID -1
#define BULLET_1_Y_0_IRQ_TYPE "NONE"
#define BULLET_1_Y_0_NAME "/dev/bullet_1_y_0"
#define BULLET_1_Y_0_RESET_VALUE 0
#define BULLET_1_Y_0_SPAN 16
#define BULLET_1_Y_0_TYPE "altera_avalon_pio"


/*
 * bullet_1_y_1 configuration
 *
 */

#define ALT_MODULE_CLASS_bullet_1_y_1 altera_avalon_pio
#define BULLET_1_Y_1_BASE 0x100012d0
#define BULLET_1_Y_1_BIT_CLEARING_EDGE_REGISTER 0
#define BULLET_1_Y_1_BIT_MODIFYING_OUTPUT_REGISTER 0
#define BULLET_1_Y_1_CAPTURE 0
#define BULLET_1_Y_1_DATA_WIDTH 10
#define BULLET_1_Y_1_DO_TEST_BENCH_WIRING 0
#define BULLET_1_Y_1_DRIVEN_SIM_VALUE 0
#define BULLET_1_Y_1_EDGE_TYPE "NONE"
#define BULLET_1_Y_1_FREQ 50000000
#define BULLET_1_Y_1_HAS_IN 0
#define BULLET_1_Y_1_HAS_OUT 1
#define BULLET_1_Y_1_HAS_TRI 0
#define BULLET_1_Y_1_IRQ -1
#define BULLET_1_Y_1_IRQ_INTERRUPT_CONTROLLER_ID -1
#define BULLET_1_Y_1_IRQ_TYPE "NONE"
#define BULLET_1_Y_1_NAME "/dev/bullet_1_y_1"
#define BULLET_1_Y_1_RESET_VALUE 0
#define BULLET_1_Y_1_SPAN 16
#define BULLET_1_Y_1_TYPE "altera_avalon_pio"


/*
 * bullet_1_y_2 configuration
 *
 */

#define ALT_MODULE_CLASS_bullet_1_y_2 altera_avalon_pio
#define BULLET_1_Y_2_BASE 0x100012c0
#define BULLET_1_Y_2_BIT_CLEARING_EDGE_REGISTER 0
#define BULLET_1_Y_2_BIT_MODIFYING_OUTPUT_REGISTER 0
#define BULLET_1_Y_2_CAPTURE 0
#define BULLET_1_Y_2_DATA_WIDTH 10
#define BULLET_1_Y_2_DO_TEST_BENCH_WIRING 0
#define BULLET_1_Y_2_DRIVEN_SIM_VALUE 0
#define BULLET_1_Y_2_EDGE_TYPE "NONE"
#define BULLET_1_Y_2_FREQ 50000000
#define BULLET_1_Y_2_HAS_IN 0
#define BULLET_1_Y_2_HAS_OUT 1
#define BULLET_1_Y_2_HAS_TRI 0
#define BULLET_1_Y_2_IRQ -1
#define BULLET_1_Y_2_IRQ_INTERRUPT_CONTROLLER_ID -1
#define BULLET_1_Y_2_IRQ_TYPE "NONE"
#define BULLET_1_Y_2_NAME "/dev/bullet_1_y_2"
#define BULLET_1_Y_2_RESET_VALUE 0
#define BULLET_1_Y_2_SPAN 16
#define BULLET_1_Y_2_TYPE "altera_avalon_pio"


/*
 * bullet_1_y_3 configuration
 *
 */

#define ALT_MODULE_CLASS_bullet_1_y_3 altera_avalon_pio
#define BULLET_1_Y_3_BASE 0x100012b0
#define BULLET_1_Y_3_BIT_CLEARING_EDGE_REGISTER 0
#define BULLET_1_Y_3_BIT_MODIFYING_OUTPUT_REGISTER 0
#define BULLET_1_Y_3_CAPTURE 0
#define BULLET_1_Y_3_DATA_WIDTH 10
#define BULLET_1_Y_3_DO_TEST_BENCH_WIRING 0
#define BULLET_1_Y_3_DRIVEN_SIM_VALUE 0
#define BULLET_1_Y_3_EDGE_TYPE "NONE"
#define BULLET_1_Y_3_FREQ 50000000
#define BULLET_1_Y_3_HAS_IN 0
#define BULLET_1_Y_3_HAS_OUT 1
#define BULLET_1_Y_3_HAS_TRI 0
#define BULLET_1_Y_3_IRQ -1
#define BULLET_1_Y_3_IRQ_INTERRUPT_CONTROLLER_ID -1
#define BULLET_1_Y_3_IRQ_TYPE "NONE"
#define BULLET_1_Y_3_NAME "/dev/bullet_1_y_3"
#define BULLET_1_Y_3_RESET_VALUE 0
#define BULLET_1_Y_3_SPAN 16
#define BULLET_1_Y_3_TYPE "altera_avalon_pio"


/*
 * bullet_1_y_4 configuration
 *
 */

#define ALT_MODULE_CLASS_bullet_1_y_4 altera_avalon_pio
#define BULLET_1_Y_4_BASE 0x100012a0
#define BULLET_1_Y_4_BIT_CLEARING_EDGE_REGISTER 0
#define BULLET_1_Y_4_BIT_MODIFYING_OUTPUT_REGISTER 0
#define BULLET_1_Y_4_CAPTURE 0
#define BULLET_1_Y_4_DATA_WIDTH 10
#define BULLET_1_Y_4_DO_TEST_BENCH_WIRING 0
#define BULLET_1_Y_4_DRIVEN_SIM_VALUE 0
#define BULLET_1_Y_4_EDGE_TYPE "NONE"
#define BULLET_1_Y_4_FREQ 50000000
#define BULLET_1_Y_4_HAS_IN 0
#define BULLET_1_Y_4_HAS_OUT 1
#define BULLET_1_Y_4_HAS_TRI 0
#define BULLET_1_Y_4_IRQ -1
#define BULLET_1_Y_4_IRQ_INTERRUPT_CONTROLLER_ID -1
#define BULLET_1_Y_4_IRQ_TYPE "NONE"
#define BULLET_1_Y_4_NAME "/dev/bullet_1_y_4"
#define BULLET_1_Y_4_RESET_VALUE 0
#define BULLET_1_Y_4_SPAN 16
#define BULLET_1_Y_4_TYPE "altera_avalon_pio"


/*
 * bullet_1_y_5 configuration
 *
 */

#define ALT_MODULE_CLASS_bullet_1_y_5 altera_avalon_pio
#define BULLET_1_Y_5_BASE 0x10001290
#define BULLET_1_Y_5_BIT_CLEARING_EDGE_REGISTER 0
#define BULLET_1_Y_5_BIT_MODIFYING_OUTPUT_REGISTER 0
#define BULLET_1_Y_5_CAPTURE 0
#define BULLET_1_Y_5_DATA_WIDTH 10
#define BULLET_1_Y_5_DO_TEST_BENCH_WIRING 0
#define BULLET_1_Y_5_DRIVEN_SIM_VALUE 0
#define BULLET_1_Y_5_EDGE_TYPE "NONE"
#define BULLET_1_Y_5_FREQ 50000000
#define BULLET_1_Y_5_HAS_IN 0
#define BULLET_1_Y_5_HAS_OUT 1
#define BULLET_1_Y_5_HAS_TRI 0
#define BULLET_1_Y_5_IRQ -1
#define BULLET_1_Y_5_IRQ_INTERRUPT_CONTROLLER_ID -1
#define BULLET_1_Y_5_IRQ_TYPE "NONE"
#define BULLET_1_Y_5_NAME "/dev/bullet_1_y_5"
#define BULLET_1_Y_5_RESET_VALUE 0
#define BULLET_1_Y_5_SPAN 16
#define BULLET_1_Y_5_TYPE "altera_avalon_pio"


/*
 * bullet_1_y_6 configuration
 *
 */

#define ALT_MODULE_CLASS_bullet_1_y_6 altera_avalon_pio
#define BULLET_1_Y_6_BASE 0x10001280
#define BULLET_1_Y_6_BIT_CLEARING_EDGE_REGISTER 0
#define BULLET_1_Y_6_BIT_MODIFYING_OUTPUT_REGISTER 0
#define BULLET_1_Y_6_CAPTURE 0
#define BULLET_1_Y_6_DATA_WIDTH 10
#define BULLET_1_Y_6_DO_TEST_BENCH_WIRING 0
#define BULLET_1_Y_6_DRIVEN_SIM_VALUE 0
#define BULLET_1_Y_6_EDGE_TYPE "NONE"
#define BULLET_1_Y_6_FREQ 50000000
#define BULLET_1_Y_6_HAS_IN 0
#define BULLET_1_Y_6_HAS_OUT 1
#define BULLET_1_Y_6_HAS_TRI 0
#define BULLET_1_Y_6_IRQ -1
#define BULLET_1_Y_6_IRQ_INTERRUPT_CONTROLLER_ID -1
#define BULLET_1_Y_6_IRQ_TYPE "NONE"
#define BULLET_1_Y_6_NAME "/dev/bullet_1_y_6"
#define BULLET_1_Y_6_RESET_VALUE 0
#define BULLET_1_Y_6_SPAN 16
#define BULLET_1_Y_6_TYPE "altera_avalon_pio"


/*
 * bullet_1_y_7 configuration
 *
 */

#define ALT_MODULE_CLASS_bullet_1_y_7 altera_avalon_pio
#define BULLET_1_Y_7_BASE 0x10001270
#define BULLET_1_Y_7_BIT_CLEARING_EDGE_REGISTER 0
#define BULLET_1_Y_7_BIT_MODIFYING_OUTPUT_REGISTER 0
#define BULLET_1_Y_7_CAPTURE 0
#define BULLET_1_Y_7_DATA_WIDTH 10
#define BULLET_1_Y_7_DO_TEST_BENCH_WIRING 0
#define BULLET_1_Y_7_DRIVEN_SIM_VALUE 0
#define BULLET_1_Y_7_EDGE_TYPE "NONE"
#define BULLET_1_Y_7_FREQ 50000000
#define BULLET_1_Y_7_HAS_IN 0
#define BULLET_1_Y_7_HAS_OUT 1
#define BULLET_1_Y_7_HAS_TRI 0
#define BULLET_1_Y_7_IRQ -1
#define BULLET_1_Y_7_IRQ_INTERRUPT_CONTROLLER_ID -1
#define BULLET_1_Y_7_IRQ_TYPE "NONE"
#define BULLET_1_Y_7_NAME "/dev/bullet_1_y_7"
#define BULLET_1_Y_7_RESET_VALUE 0
#define BULLET_1_Y_7_SPAN 16
#define BULLET_1_Y_7_TYPE "altera_avalon_pio"


/*
 * bullet_1_y_8 configuration
 *
 */

#define ALT_MODULE_CLASS_bullet_1_y_8 altera_avalon_pio
#define BULLET_1_Y_8_BASE 0x10001260
#define BULLET_1_Y_8_BIT_CLEARING_EDGE_REGISTER 0
#define BULLET_1_Y_8_BIT_MODIFYING_OUTPUT_REGISTER 0
#define BULLET_1_Y_8_CAPTURE 0
#define BULLET_1_Y_8_DATA_WIDTH 10
#define BULLET_1_Y_8_DO_TEST_BENCH_WIRING 0
#define BULLET_1_Y_8_DRIVEN_SIM_VALUE 0
#define BULLET_1_Y_8_EDGE_TYPE "NONE"
#define BULLET_1_Y_8_FREQ 50000000
#define BULLET_1_Y_8_HAS_IN 0
#define BULLET_1_Y_8_HAS_OUT 1
#define BULLET_1_Y_8_HAS_TRI 0
#define BULLET_1_Y_8_IRQ -1
#define BULLET_1_Y_8_IRQ_INTERRUPT_CONTROLLER_ID -1
#define BULLET_1_Y_8_IRQ_TYPE "NONE"
#define BULLET_1_Y_8_NAME "/dev/bullet_1_y_8"
#define BULLET_1_Y_8_RESET_VALUE 0
#define BULLET_1_Y_8_SPAN 16
#define BULLET_1_Y_8_TYPE "altera_avalon_pio"


/*
 * bullet_1_y_9 configuration
 *
 */

#define ALT_MODULE_CLASS_bullet_1_y_9 altera_avalon_pio
#define BULLET_1_Y_9_BASE 0x10001250
#define BULLET_1_Y_9_BIT_CLEARING_EDGE_REGISTER 0
#define BULLET_1_Y_9_BIT_MODIFYING_OUTPUT_REGISTER 0
#define BULLET_1_Y_9_CAPTURE 0
#define BULLET_1_Y_9_DATA_WIDTH 10
#define BULLET_1_Y_9_DO_TEST_BENCH_WIRING 0
#define BULLET_1_Y_9_DRIVEN_SIM_VALUE 0
#define BULLET_1_Y_9_EDGE_TYPE "NONE"
#define BULLET_1_Y_9_FREQ 50000000
#define BULLET_1_Y_9_HAS_IN 0
#define BULLET_1_Y_9_HAS_OUT 1
#define BULLET_1_Y_9_HAS_TRI 0
#define BULLET_1_Y_9_IRQ -1
#define BULLET_1_Y_9_IRQ_INTERRUPT_CONTROLLER_ID -1
#define BULLET_1_Y_9_IRQ_TYPE "NONE"
#define BULLET_1_Y_9_NAME "/dev/bullet_1_y_9"
#define BULLET_1_Y_9_RESET_VALUE 0
#define BULLET_1_Y_9_SPAN 16
#define BULLET_1_Y_9_TYPE "altera_avalon_pio"


/*
 * bullet_2_x_0 configuration
 *
 */

#define ALT_MODULE_CLASS_bullet_2_x_0 altera_avalon_pio
#define BULLET_2_X_0_BASE 0x10001240
#define BULLET_2_X_0_BIT_CLEARING_EDGE_REGISTER 0
#define BULLET_2_X_0_BIT_MODIFYING_OUTPUT_REGISTER 0
#define BULLET_2_X_0_CAPTURE 0
#define BULLET_2_X_0_DATA_WIDTH 10
#define BULLET_2_X_0_DO_TEST_BENCH_WIRING 0
#define BULLET_2_X_0_DRIVEN_SIM_VALUE 0
#define BULLET_2_X_0_EDGE_TYPE "NONE"
#define BULLET_2_X_0_FREQ 50000000
#define BULLET_2_X_0_HAS_IN 0
#define BULLET_2_X_0_HAS_OUT 1
#define BULLET_2_X_0_HAS_TRI 0
#define BULLET_2_X_0_IRQ -1
#define BULLET_2_X_0_IRQ_INTERRUPT_CONTROLLER_ID -1
#define BULLET_2_X_0_IRQ_TYPE "NONE"
#define BULLET_2_X_0_NAME "/dev/bullet_2_x_0"
#define BULLET_2_X_0_RESET_VALUE 0
#define BULLET_2_X_0_SPAN 16
#define BULLET_2_X_0_TYPE "altera_avalon_pio"


/*
 * bullet_2_x_1 configuration
 *
 */

#define ALT_MODULE_CLASS_bullet_2_x_1 altera_avalon_pio
#define BULLET_2_X_1_BASE 0x10001230
#define BULLET_2_X_1_BIT_CLEARING_EDGE_REGISTER 0
#define BULLET_2_X_1_BIT_MODIFYING_OUTPUT_REGISTER 0
#define BULLET_2_X_1_CAPTURE 0
#define BULLET_2_X_1_DATA_WIDTH 10
#define BULLET_2_X_1_DO_TEST_BENCH_WIRING 0
#define BULLET_2_X_1_DRIVEN_SIM_VALUE 0
#define BULLET_2_X_1_EDGE_TYPE "NONE"
#define BULLET_2_X_1_FREQ 50000000
#define BULLET_2_X_1_HAS_IN 0
#define BULLET_2_X_1_HAS_OUT 1
#define BULLET_2_X_1_HAS_TRI 0
#define BULLET_2_X_1_IRQ -1
#define BULLET_2_X_1_IRQ_INTERRUPT_CONTROLLER_ID -1
#define BULLET_2_X_1_IRQ_TYPE "NONE"
#define BULLET_2_X_1_NAME "/dev/bullet_2_x_1"
#define BULLET_2_X_1_RESET_VALUE 0
#define BULLET_2_X_1_SPAN 16
#define BULLET_2_X_1_TYPE "altera_avalon_pio"


/*
 * bullet_2_x_2 configuration
 *
 */

#define ALT_MODULE_CLASS_bullet_2_x_2 altera_avalon_pio
#define BULLET_2_X_2_BASE 0x10001220
#define BULLET_2_X_2_BIT_CLEARING_EDGE_REGISTER 0
#define BULLET_2_X_2_BIT_MODIFYING_OUTPUT_REGISTER 0
#define BULLET_2_X_2_CAPTURE 0
#define BULLET_2_X_2_DATA_WIDTH 10
#define BULLET_2_X_2_DO_TEST_BENCH_WIRING 0
#define BULLET_2_X_2_DRIVEN_SIM_VALUE 0
#define BULLET_2_X_2_EDGE_TYPE "NONE"
#define BULLET_2_X_2_FREQ 50000000
#define BULLET_2_X_2_HAS_IN 0
#define BULLET_2_X_2_HAS_OUT 1
#define BULLET_2_X_2_HAS_TRI 0
#define BULLET_2_X_2_IRQ -1
#define BULLET_2_X_2_IRQ_INTERRUPT_CONTROLLER_ID -1
#define BULLET_2_X_2_IRQ_TYPE "NONE"
#define BULLET_2_X_2_NAME "/dev/bullet_2_x_2"
#define BULLET_2_X_2_RESET_VALUE 0
#define BULLET_2_X_2_SPAN 16
#define BULLET_2_X_2_TYPE "altera_avalon_pio"


/*
 * bullet_2_x_3 configuration
 *
 */

#define ALT_MODULE_CLASS_bullet_2_x_3 altera_avalon_pio
#define BULLET_2_X_3_BASE 0x10001210
#define BULLET_2_X_3_BIT_CLEARING_EDGE_REGISTER 0
#define BULLET_2_X_3_BIT_MODIFYING_OUTPUT_REGISTER 0
#define BULLET_2_X_3_CAPTURE 0
#define BULLET_2_X_3_DATA_WIDTH 10
#define BULLET_2_X_3_DO_TEST_BENCH_WIRING 0
#define BULLET_2_X_3_DRIVEN_SIM_VALUE 0
#define BULLET_2_X_3_EDGE_TYPE "NONE"
#define BULLET_2_X_3_FREQ 50000000
#define BULLET_2_X_3_HAS_IN 0
#define BULLET_2_X_3_HAS_OUT 1
#define BULLET_2_X_3_HAS_TRI 0
#define BULLET_2_X_3_IRQ -1
#define BULLET_2_X_3_IRQ_INTERRUPT_CONTROLLER_ID -1
#define BULLET_2_X_3_IRQ_TYPE "NONE"
#define BULLET_2_X_3_NAME "/dev/bullet_2_x_3"
#define BULLET_2_X_3_RESET_VALUE 0
#define BULLET_2_X_3_SPAN 16
#define BULLET_2_X_3_TYPE "altera_avalon_pio"


/*
 * bullet_2_x_4 configuration
 *
 */

#define ALT_MODULE_CLASS_bullet_2_x_4 altera_avalon_pio
#define BULLET_2_X_4_BASE 0x10001200
#define BULLET_2_X_4_BIT_CLEARING_EDGE_REGISTER 0
#define BULLET_2_X_4_BIT_MODIFYING_OUTPUT_REGISTER 0
#define BULLET_2_X_4_CAPTURE 0
#define BULLET_2_X_4_DATA_WIDTH 10
#define BULLET_2_X_4_DO_TEST_BENCH_WIRING 0
#define BULLET_2_X_4_DRIVEN_SIM_VALUE 0
#define BULLET_2_X_4_EDGE_TYPE "NONE"
#define BULLET_2_X_4_FREQ 50000000
#define BULLET_2_X_4_HAS_IN 0
#define BULLET_2_X_4_HAS_OUT 1
#define BULLET_2_X_4_HAS_TRI 0
#define BULLET_2_X_4_IRQ -1
#define BULLET_2_X_4_IRQ_INTERRUPT_CONTROLLER_ID -1
#define BULLET_2_X_4_IRQ_TYPE "NONE"
#define BULLET_2_X_4_NAME "/dev/bullet_2_x_4"
#define BULLET_2_X_4_RESET_VALUE 0
#define BULLET_2_X_4_SPAN 16
#define BULLET_2_X_4_TYPE "altera_avalon_pio"


/*
 * bullet_2_x_5 configuration
 *
 */

#define ALT_MODULE_CLASS_bullet_2_x_5 altera_avalon_pio
#define BULLET_2_X_5_BASE 0x100011f0
#define BULLET_2_X_5_BIT_CLEARING_EDGE_REGISTER 0
#define BULLET_2_X_5_BIT_MODIFYING_OUTPUT_REGISTER 0
#define BULLET_2_X_5_CAPTURE 0
#define BULLET_2_X_5_DATA_WIDTH 10
#define BULLET_2_X_5_DO_TEST_BENCH_WIRING 0
#define BULLET_2_X_5_DRIVEN_SIM_VALUE 0
#define BULLET_2_X_5_EDGE_TYPE "NONE"
#define BULLET_2_X_5_FREQ 50000000
#define BULLET_2_X_5_HAS_IN 0
#define BULLET_2_X_5_HAS_OUT 1
#define BULLET_2_X_5_HAS_TRI 0
#define BULLET_2_X_5_IRQ -1
#define BULLET_2_X_5_IRQ_INTERRUPT_CONTROLLER_ID -1
#define BULLET_2_X_5_IRQ_TYPE "NONE"
#define BULLET_2_X_5_NAME "/dev/bullet_2_x_5"
#define BULLET_2_X_5_RESET_VALUE 0
#define BULLET_2_X_5_SPAN 16
#define BULLET_2_X_5_TYPE "altera_avalon_pio"


/*
 * bullet_2_x_6 configuration
 *
 */

#define ALT_MODULE_CLASS_bullet_2_x_6 altera_avalon_pio
#define BULLET_2_X_6_BASE 0x100011e0
#define BULLET_2_X_6_BIT_CLEARING_EDGE_REGISTER 0
#define BULLET_2_X_6_BIT_MODIFYING_OUTPUT_REGISTER 0
#define BULLET_2_X_6_CAPTURE 0
#define BULLET_2_X_6_DATA_WIDTH 10
#define BULLET_2_X_6_DO_TEST_BENCH_WIRING 0
#define BULLET_2_X_6_DRIVEN_SIM_VALUE 0
#define BULLET_2_X_6_EDGE_TYPE "NONE"
#define BULLET_2_X_6_FREQ 50000000
#define BULLET_2_X_6_HAS_IN 0
#define BULLET_2_X_6_HAS_OUT 1
#define BULLET_2_X_6_HAS_TRI 0
#define BULLET_2_X_6_IRQ -1
#define BULLET_2_X_6_IRQ_INTERRUPT_CONTROLLER_ID -1
#define BULLET_2_X_6_IRQ_TYPE "NONE"
#define BULLET_2_X_6_NAME "/dev/bullet_2_x_6"
#define BULLET_2_X_6_RESET_VALUE 0
#define BULLET_2_X_6_SPAN 16
#define BULLET_2_X_6_TYPE "altera_avalon_pio"


/*
 * bullet_2_x_7 configuration
 *
 */

#define ALT_MODULE_CLASS_bullet_2_x_7 altera_avalon_pio
#define BULLET_2_X_7_BASE 0x100011d0
#define BULLET_2_X_7_BIT_CLEARING_EDGE_REGISTER 0
#define BULLET_2_X_7_BIT_MODIFYING_OUTPUT_REGISTER 0
#define BULLET_2_X_7_CAPTURE 0
#define BULLET_2_X_7_DATA_WIDTH 10
#define BULLET_2_X_7_DO_TEST_BENCH_WIRING 0
#define BULLET_2_X_7_DRIVEN_SIM_VALUE 0
#define BULLET_2_X_7_EDGE_TYPE "NONE"
#define BULLET_2_X_7_FREQ 50000000
#define BULLET_2_X_7_HAS_IN 0
#define BULLET_2_X_7_HAS_OUT 1
#define BULLET_2_X_7_HAS_TRI 0
#define BULLET_2_X_7_IRQ -1
#define BULLET_2_X_7_IRQ_INTERRUPT_CONTROLLER_ID -1
#define BULLET_2_X_7_IRQ_TYPE "NONE"
#define BULLET_2_X_7_NAME "/dev/bullet_2_x_7"
#define BULLET_2_X_7_RESET_VALUE 0
#define BULLET_2_X_7_SPAN 16
#define BULLET_2_X_7_TYPE "altera_avalon_pio"


/*
 * bullet_2_x_8 configuration
 *
 */

#define ALT_MODULE_CLASS_bullet_2_x_8 altera_avalon_pio
#define BULLET_2_X_8_BASE 0x100011c0
#define BULLET_2_X_8_BIT_CLEARING_EDGE_REGISTER 0
#define BULLET_2_X_8_BIT_MODIFYING_OUTPUT_REGISTER 0
#define BULLET_2_X_8_CAPTURE 0
#define BULLET_2_X_8_DATA_WIDTH 10
#define BULLET_2_X_8_DO_TEST_BENCH_WIRING 0
#define BULLET_2_X_8_DRIVEN_SIM_VALUE 0
#define BULLET_2_X_8_EDGE_TYPE "NONE"
#define BULLET_2_X_8_FREQ 50000000
#define BULLET_2_X_8_HAS_IN 0
#define BULLET_2_X_8_HAS_OUT 1
#define BULLET_2_X_8_HAS_TRI 0
#define BULLET_2_X_8_IRQ -1
#define BULLET_2_X_8_IRQ_INTERRUPT_CONTROLLER_ID -1
#define BULLET_2_X_8_IRQ_TYPE "NONE"
#define BULLET_2_X_8_NAME "/dev/bullet_2_x_8"
#define BULLET_2_X_8_RESET_VALUE 0
#define BULLET_2_X_8_SPAN 16
#define BULLET_2_X_8_TYPE "altera_avalon_pio"


/*
 * bullet_2_x_9 configuration
 *
 */

#define ALT_MODULE_CLASS_bullet_2_x_9 altera_avalon_pio
#define BULLET_2_X_9_BASE 0x100011b0
#define BULLET_2_X_9_BIT_CLEARING_EDGE_REGISTER 0
#define BULLET_2_X_9_BIT_MODIFYING_OUTPUT_REGISTER 0
#define BULLET_2_X_9_CAPTURE 0
#define BULLET_2_X_9_DATA_WIDTH 10
#define BULLET_2_X_9_DO_TEST_BENCH_WIRING 0
#define BULLET_2_X_9_DRIVEN_SIM_VALUE 0
#define BULLET_2_X_9_EDGE_TYPE "NONE"
#define BULLET_2_X_9_FREQ 50000000
#define BULLET_2_X_9_HAS_IN 0
#define BULLET_2_X_9_HAS_OUT 1
#define BULLET_2_X_9_HAS_TRI 0
#define BULLET_2_X_9_IRQ -1
#define BULLET_2_X_9_IRQ_INTERRUPT_CONTROLLER_ID -1
#define BULLET_2_X_9_IRQ_TYPE "NONE"
#define BULLET_2_X_9_NAME "/dev/bullet_2_x_9"
#define BULLET_2_X_9_RESET_VALUE 0
#define BULLET_2_X_9_SPAN 16
#define BULLET_2_X_9_TYPE "altera_avalon_pio"


/*
 * bullet_2_y_0 configuration
 *
 */

#define ALT_MODULE_CLASS_bullet_2_y_0 altera_avalon_pio
#define BULLET_2_Y_0_BASE 0x100011a0
#define BULLET_2_Y_0_BIT_CLEARING_EDGE_REGISTER 0
#define BULLET_2_Y_0_BIT_MODIFYING_OUTPUT_REGISTER 0
#define BULLET_2_Y_0_CAPTURE 0
#define BULLET_2_Y_0_DATA_WIDTH 10
#define BULLET_2_Y_0_DO_TEST_BENCH_WIRING 0
#define BULLET_2_Y_0_DRIVEN_SIM_VALUE 0
#define BULLET_2_Y_0_EDGE_TYPE "NONE"
#define BULLET_2_Y_0_FREQ 50000000
#define BULLET_2_Y_0_HAS_IN 0
#define BULLET_2_Y_0_HAS_OUT 1
#define BULLET_2_Y_0_HAS_TRI 0
#define BULLET_2_Y_0_IRQ -1
#define BULLET_2_Y_0_IRQ_INTERRUPT_CONTROLLER_ID -1
#define BULLET_2_Y_0_IRQ_TYPE "NONE"
#define BULLET_2_Y_0_NAME "/dev/bullet_2_y_0"
#define BULLET_2_Y_0_RESET_VALUE 0
#define BULLET_2_Y_0_SPAN 16
#define BULLET_2_Y_0_TYPE "altera_avalon_pio"


/*
 * bullet_2_y_1 configuration
 *
 */

#define ALT_MODULE_CLASS_bullet_2_y_1 altera_avalon_pio
#define BULLET_2_Y_1_BASE 0x10001190
#define BULLET_2_Y_1_BIT_CLEARING_EDGE_REGISTER 0
#define BULLET_2_Y_1_BIT_MODIFYING_OUTPUT_REGISTER 0
#define BULLET_2_Y_1_CAPTURE 0
#define BULLET_2_Y_1_DATA_WIDTH 10
#define BULLET_2_Y_1_DO_TEST_BENCH_WIRING 0
#define BULLET_2_Y_1_DRIVEN_SIM_VALUE 0
#define BULLET_2_Y_1_EDGE_TYPE "NONE"
#define BULLET_2_Y_1_FREQ 50000000
#define BULLET_2_Y_1_HAS_IN 0
#define BULLET_2_Y_1_HAS_OUT 1
#define BULLET_2_Y_1_HAS_TRI 0
#define BULLET_2_Y_1_IRQ -1
#define BULLET_2_Y_1_IRQ_INTERRUPT_CONTROLLER_ID -1
#define BULLET_2_Y_1_IRQ_TYPE "NONE"
#define BULLET_2_Y_1_NAME "/dev/bullet_2_y_1"
#define BULLET_2_Y_1_RESET_VALUE 0
#define BULLET_2_Y_1_SPAN 16
#define BULLET_2_Y_1_TYPE "altera_avalon_pio"


/*
 * bullet_2_y_2 configuration
 *
 */

#define ALT_MODULE_CLASS_bullet_2_y_2 altera_avalon_pio
#define BULLET_2_Y_2_BASE 0x10001110
#define BULLET_2_Y_2_BIT_CLEARING_EDGE_REGISTER 0
#define BULLET_2_Y_2_BIT_MODIFYING_OUTPUT_REGISTER 0
#define BULLET_2_Y_2_CAPTURE 0
#define BULLET_2_Y_2_DATA_WIDTH 10
#define BULLET_2_Y_2_DO_TEST_BENCH_WIRING 0
#define BULLET_2_Y_2_DRIVEN_SIM_VALUE 0
#define BULLET_2_Y_2_EDGE_TYPE "NONE"
#define BULLET_2_Y_2_FREQ 50000000
#define BULLET_2_Y_2_HAS_IN 0
#define BULLET_2_Y_2_HAS_OUT 1
#define BULLET_2_Y_2_HAS_TRI 0
#define BULLET_2_Y_2_IRQ -1
#define BULLET_2_Y_2_IRQ_INTERRUPT_CONTROLLER_ID -1
#define BULLET_2_Y_2_IRQ_TYPE "NONE"
#define BULLET_2_Y_2_NAME "/dev/bullet_2_y_2"
#define BULLET_2_Y_2_RESET_VALUE 0
#define BULLET_2_Y_2_SPAN 16
#define BULLET_2_Y_2_TYPE "altera_avalon_pio"


/*
 * bullet_2_y_3 configuration
 *
 */

#define ALT_MODULE_CLASS_bullet_2_y_3 altera_avalon_pio
#define BULLET_2_Y_3_BASE 0x10001130
#define BULLET_2_Y_3_BIT_CLEARING_EDGE_REGISTER 0
#define BULLET_2_Y_3_BIT_MODIFYING_OUTPUT_REGISTER 0
#define BULLET_2_Y_3_CAPTURE 0
#define BULLET_2_Y_3_DATA_WIDTH 10
#define BULLET_2_Y_3_DO_TEST_BENCH_WIRING 0
#define BULLET_2_Y_3_DRIVEN_SIM_VALUE 0
#define BULLET_2_Y_3_EDGE_TYPE "NONE"
#define BULLET_2_Y_3_FREQ 50000000
#define BULLET_2_Y_3_HAS_IN 0
#define BULLET_2_Y_3_HAS_OUT 1
#define BULLET_2_Y_3_HAS_TRI 0
#define BULLET_2_Y_3_IRQ -1
#define BULLET_2_Y_3_IRQ_INTERRUPT_CONTROLLER_ID -1
#define BULLET_2_Y_3_IRQ_TYPE "NONE"
#define BULLET_2_Y_3_NAME "/dev/bullet_2_y_3"
#define BULLET_2_Y_3_RESET_VALUE 0
#define BULLET_2_Y_3_SPAN 16
#define BULLET_2_Y_3_TYPE "altera_avalon_pio"


/*
 * bullet_2_y_4 configuration
 *
 */

#define ALT_MODULE_CLASS_bullet_2_y_4 altera_avalon_pio
#define BULLET_2_Y_4_BASE 0x10001120
#define BULLET_2_Y_4_BIT_CLEARING_EDGE_REGISTER 0
#define BULLET_2_Y_4_BIT_MODIFYING_OUTPUT_REGISTER 0
#define BULLET_2_Y_4_CAPTURE 0
#define BULLET_2_Y_4_DATA_WIDTH 10
#define BULLET_2_Y_4_DO_TEST_BENCH_WIRING 0
#define BULLET_2_Y_4_DRIVEN_SIM_VALUE 0
#define BULLET_2_Y_4_EDGE_TYPE "NONE"
#define BULLET_2_Y_4_FREQ 50000000
#define BULLET_2_Y_4_HAS_IN 0
#define BULLET_2_Y_4_HAS_OUT 1
#define BULLET_2_Y_4_HAS_TRI 0
#define BULLET_2_Y_4_IRQ -1
#define BULLET_2_Y_4_IRQ_INTERRUPT_CONTROLLER_ID -1
#define BULLET_2_Y_4_IRQ_TYPE "NONE"
#define BULLET_2_Y_4_NAME "/dev/bullet_2_y_4"
#define BULLET_2_Y_4_RESET_VALUE 0
#define BULLET_2_Y_4_SPAN 16
#define BULLET_2_Y_4_TYPE "altera_avalon_pio"


/*
 * bullet_2_y_5 configuration
 *
 */

#define ALT_MODULE_CLASS_bullet_2_y_5 altera_avalon_pio
#define BULLET_2_Y_5_BASE 0x10001180
#define BULLET_2_Y_5_BIT_CLEARING_EDGE_REGISTER 0
#define BULLET_2_Y_5_BIT_MODIFYING_OUTPUT_REGISTER 0
#define BULLET_2_Y_5_CAPTURE 0
#define BULLET_2_Y_5_DATA_WIDTH 10
#define BULLET_2_Y_5_DO_TEST_BENCH_WIRING 0
#define BULLET_2_Y_5_DRIVEN_SIM_VALUE 0
#define BULLET_2_Y_5_EDGE_TYPE "NONE"
#define BULLET_2_Y_5_FREQ 50000000
#define BULLET_2_Y_5_HAS_IN 0
#define BULLET_2_Y_5_HAS_OUT 1
#define BULLET_2_Y_5_HAS_TRI 0
#define BULLET_2_Y_5_IRQ -1
#define BULLET_2_Y_5_IRQ_INTERRUPT_CONTROLLER_ID -1
#define BULLET_2_Y_5_IRQ_TYPE "NONE"
#define BULLET_2_Y_5_NAME "/dev/bullet_2_y_5"
#define BULLET_2_Y_5_RESET_VALUE 0
#define BULLET_2_Y_5_SPAN 16
#define BULLET_2_Y_5_TYPE "altera_avalon_pio"


/*
 * bullet_2_y_6 configuration
 *
 */

#define ALT_MODULE_CLASS_bullet_2_y_6 altera_avalon_pio
#define BULLET_2_Y_6_BASE 0x10001170
#define BULLET_2_Y_6_BIT_CLEARING_EDGE_REGISTER 0
#define BULLET_2_Y_6_BIT_MODIFYING_OUTPUT_REGISTER 0
#define BULLET_2_Y_6_CAPTURE 0
#define BULLET_2_Y_6_DATA_WIDTH 10
#define BULLET_2_Y_6_DO_TEST_BENCH_WIRING 0
#define BULLET_2_Y_6_DRIVEN_SIM_VALUE 0
#define BULLET_2_Y_6_EDGE_TYPE "NONE"
#define BULLET_2_Y_6_FREQ 50000000
#define BULLET_2_Y_6_HAS_IN 0
#define BULLET_2_Y_6_HAS_OUT 1
#define BULLET_2_Y_6_HAS_TRI 0
#define BULLET_2_Y_6_IRQ -1
#define BULLET_2_Y_6_IRQ_INTERRUPT_CONTROLLER_ID -1
#define BULLET_2_Y_6_IRQ_TYPE "NONE"
#define BULLET_2_Y_6_NAME "/dev/bullet_2_y_6"
#define BULLET_2_Y_6_RESET_VALUE 0
#define BULLET_2_Y_6_SPAN 16
#define BULLET_2_Y_6_TYPE "altera_avalon_pio"


/*
 * bullet_2_y_7 configuration
 *
 */

#define ALT_MODULE_CLASS_bullet_2_y_7 altera_avalon_pio
#define BULLET_2_Y_7_BASE 0x10001160
#define BULLET_2_Y_7_BIT_CLEARING_EDGE_REGISTER 0
#define BULLET_2_Y_7_BIT_MODIFYING_OUTPUT_REGISTER 0
#define BULLET_2_Y_7_CAPTURE 0
#define BULLET_2_Y_7_DATA_WIDTH 10
#define BULLET_2_Y_7_DO_TEST_BENCH_WIRING 0
#define BULLET_2_Y_7_DRIVEN_SIM_VALUE 0
#define BULLET_2_Y_7_EDGE_TYPE "NONE"
#define BULLET_2_Y_7_FREQ 50000000
#define BULLET_2_Y_7_HAS_IN 0
#define BULLET_2_Y_7_HAS_OUT 1
#define BULLET_2_Y_7_HAS_TRI 0
#define BULLET_2_Y_7_IRQ -1
#define BULLET_2_Y_7_IRQ_INTERRUPT_CONTROLLER_ID -1
#define BULLET_2_Y_7_IRQ_TYPE "NONE"
#define BULLET_2_Y_7_NAME "/dev/bullet_2_y_7"
#define BULLET_2_Y_7_RESET_VALUE 0
#define BULLET_2_Y_7_SPAN 16
#define BULLET_2_Y_7_TYPE "altera_avalon_pio"


/*
 * bullet_2_y_8 configuration
 *
 */

#define ALT_MODULE_CLASS_bullet_2_y_8 altera_avalon_pio
#define BULLET_2_Y_8_BASE 0x10001150
#define BULLET_2_Y_8_BIT_CLEARING_EDGE_REGISTER 0
#define BULLET_2_Y_8_BIT_MODIFYING_OUTPUT_REGISTER 0
#define BULLET_2_Y_8_CAPTURE 0
#define BULLET_2_Y_8_DATA_WIDTH 10
#define BULLET_2_Y_8_DO_TEST_BENCH_WIRING 0
#define BULLET_2_Y_8_DRIVEN_SIM_VALUE 0
#define BULLET_2_Y_8_EDGE_TYPE "NONE"
#define BULLET_2_Y_8_FREQ 50000000
#define BULLET_2_Y_8_HAS_IN 0
#define BULLET_2_Y_8_HAS_OUT 1
#define BULLET_2_Y_8_HAS_TRI 0
#define BULLET_2_Y_8_IRQ -1
#define BULLET_2_Y_8_IRQ_INTERRUPT_CONTROLLER_ID -1
#define BULLET_2_Y_8_IRQ_TYPE "NONE"
#define BULLET_2_Y_8_NAME "/dev/bullet_2_y_8"
#define BULLET_2_Y_8_RESET_VALUE 0
#define BULLET_2_Y_8_SPAN 16
#define BULLET_2_Y_8_TYPE "altera_avalon_pio"


/*
 * bullet_2_y_9 configuration
 *
 */

#define ALT_MODULE_CLASS_bullet_2_y_9 altera_avalon_pio
#define BULLET_2_Y_9_BASE 0x10001140
#define BULLET_2_Y_9_BIT_CLEARING_EDGE_REGISTER 0
#define BULLET_2_Y_9_BIT_MODIFYING_OUTPUT_REGISTER 0
#define BULLET_2_Y_9_CAPTURE 0
#define BULLET_2_Y_9_DATA_WIDTH 10
#define BULLET_2_Y_9_DO_TEST_BENCH_WIRING 0
#define BULLET_2_Y_9_DRIVEN_SIM_VALUE 0
#define BULLET_2_Y_9_EDGE_TYPE "NONE"
#define BULLET_2_Y_9_FREQ 50000000
#define BULLET_2_Y_9_HAS_IN 0
#define BULLET_2_Y_9_HAS_OUT 1
#define BULLET_2_Y_9_HAS_TRI 0
#define BULLET_2_Y_9_IRQ -1
#define BULLET_2_Y_9_IRQ_INTERRUPT_CONTROLLER_ID -1
#define BULLET_2_Y_9_IRQ_TYPE "NONE"
#define BULLET_2_Y_9_NAME "/dev/bullet_2_y_9"
#define BULLET_2_Y_9_RESET_VALUE 0
#define BULLET_2_Y_9_SPAN 16
#define BULLET_2_Y_9_TYPE "altera_avalon_pio"


/*
 * game_core configuration
 *
 */

#define ALT_MODULE_CLASS_game_core game_core
#define GAME_CORE_BASE 0x10001000
#define GAME_CORE_IRQ -1
#define GAME_CORE_IRQ_INTERRUPT_CONTROLLER_ID -1
#define GAME_CORE_NAME "/dev/game_core"
#define GAME_CORE_SPAN 256
#define GAME_CORE_TYPE "game_core"


/*
 * hal configuration
 *
 */

#define ALT_INCLUDE_INSTRUCTION_RELATED_EXCEPTION_API
#define ALT_MAX_FD 32
#define ALT_SYS_CLK none
#define ALT_TIMESTAMP_CLK none


/*
 * jtag_uart_0 configuration
 *
 */

#define ALT_MODULE_CLASS_jtag_uart_0 altera_avalon_jtag_uart
#define JTAG_UART_0_BASE 0x10001410
#define JTAG_UART_0_IRQ 0
#define JTAG_UART_0_IRQ_INTERRUPT_CONTROLLER_ID 0
#define JTAG_UART_0_NAME "/dev/jtag_uart_0"
#define JTAG_UART_0_READ_DEPTH 64
#define JTAG_UART_0_READ_THRESHOLD 8
#define JTAG_UART_0_SPAN 8
#define JTAG_UART_0_TYPE "altera_avalon_jtag_uart"
#define JTAG_UART_0_WRITE_DEPTH 64
#define JTAG_UART_0_WRITE_THRESHOLD 8


/*
 * keycode_0 configuration
 *
 */

#define ALT_MODULE_CLASS_keycode_0 altera_avalon_pio
#define KEYCODE_0_BASE 0x10001390
#define KEYCODE_0_BIT_CLEARING_EDGE_REGISTER 0
#define KEYCODE_0_BIT_MODIFYING_OUTPUT_REGISTER 0
#define KEYCODE_0_CAPTURE 0
#define KEYCODE_0_DATA_WIDTH 8
#define KEYCODE_0_DO_TEST_BENCH_WIRING 0
#define KEYCODE_0_DRIVEN_SIM_VALUE 0
#define KEYCODE_0_EDGE_TYPE "NONE"
#define KEYCODE_0_FREQ 50000000
#define KEYCODE_0_HAS_IN 0
#define KEYCODE_0_HAS_OUT 1
#define KEYCODE_0_HAS_TRI 0
#define KEYCODE_0_IRQ -1
#define KEYCODE_0_IRQ_INTERRUPT_CONTROLLER_ID -1
#define KEYCODE_0_IRQ_TYPE "NONE"
#define KEYCODE_0_NAME "/dev/keycode_0"
#define KEYCODE_0_RESET_VALUE 0
#define KEYCODE_0_SPAN 16
#define KEYCODE_0_TYPE "altera_avalon_pio"


/*
 * otg_hpi_address configuration
 *
 */

#define ALT_MODULE_CLASS_otg_hpi_address altera_avalon_pio
#define OTG_HPI_ADDRESS_BASE 0x100013c0
#define OTG_HPI_ADDRESS_BIT_CLEARING_EDGE_REGISTER 0
#define OTG_HPI_ADDRESS_BIT_MODIFYING_OUTPUT_REGISTER 0
#define OTG_HPI_ADDRESS_CAPTURE 0
#define OTG_HPI_ADDRESS_DATA_WIDTH 2
#define OTG_HPI_ADDRESS_DO_TEST_BENCH_WIRING 0
#define OTG_HPI_ADDRESS_DRIVEN_SIM_VALUE 0
#define OTG_HPI_ADDRESS_EDGE_TYPE "NONE"
#define OTG_HPI_ADDRESS_FREQ 50000000
#define OTG_HPI_ADDRESS_HAS_IN 0
#define OTG_HPI_ADDRESS_HAS_OUT 1
#define OTG_HPI_ADDRESS_HAS_TRI 0
#define OTG_HPI_ADDRESS_IRQ -1
#define OTG_HPI_ADDRESS_IRQ_INTERRUPT_CONTROLLER_ID -1
#define OTG_HPI_ADDRESS_IRQ_TYPE "NONE"
#define OTG_HPI_ADDRESS_NAME "/dev/otg_hpi_address"
#define OTG_HPI_ADDRESS_RESET_VALUE 0
#define OTG_HPI_ADDRESS_SPAN 16
#define OTG_HPI_ADDRESS_TYPE "altera_avalon_pio"


/*
 * otg_hpi_cs configuration
 *
 */

#define ALT_MODULE_CLASS_otg_hpi_cs altera_avalon_pio
#define OTG_HPI_CS_BASE 0x100013b0
#define OTG_HPI_CS_BIT_CLEARING_EDGE_REGISTER 0
#define OTG_HPI_CS_BIT_MODIFYING_OUTPUT_REGISTER 0
#define OTG_HPI_CS_CAPTURE 0
#define OTG_HPI_CS_DATA_WIDTH 1
#define OTG_HPI_CS_DO_TEST_BENCH_WIRING 0
#define OTG_HPI_CS_DRIVEN_SIM_VALUE 0
#define OTG_HPI_CS_EDGE_TYPE "NONE"
#define OTG_HPI_CS_FREQ 50000000
#define OTG_HPI_CS_HAS_IN 0
#define OTG_HPI_CS_HAS_OUT 1
#define OTG_HPI_CS_HAS_TRI 0
#define OTG_HPI_CS_IRQ -1
#define OTG_HPI_CS_IRQ_INTERRUPT_CONTROLLER_ID -1
#define OTG_HPI_CS_IRQ_TYPE "NONE"
#define OTG_HPI_CS_NAME "/dev/otg_hpi_cs"
#define OTG_HPI_CS_RESET_VALUE 0
#define OTG_HPI_CS_SPAN 16
#define OTG_HPI_CS_TYPE "altera_avalon_pio"


/*
 * otg_hpi_data configuration
 *
 */

#define ALT_MODULE_CLASS_otg_hpi_data altera_avalon_pio
#define OTG_HPI_DATA_BASE 0x100013d0
#define OTG_HPI_DATA_BIT_CLEARING_EDGE_REGISTER 0
#define OTG_HPI_DATA_BIT_MODIFYING_OUTPUT_REGISTER 0
#define OTG_HPI_DATA_CAPTURE 0
#define OTG_HPI_DATA_DATA_WIDTH 16
#define OTG_HPI_DATA_DO_TEST_BENCH_WIRING 0
#define OTG_HPI_DATA_DRIVEN_SIM_VALUE 0
#define OTG_HPI_DATA_EDGE_TYPE "NONE"
#define OTG_HPI_DATA_FREQ 50000000
#define OTG_HPI_DATA_HAS_IN 1
#define OTG_HPI_DATA_HAS_OUT 1
#define OTG_HPI_DATA_HAS_TRI 0
#define OTG_HPI_DATA_IRQ -1
#define OTG_HPI_DATA_IRQ_INTERRUPT_CONTROLLER_ID -1
#define OTG_HPI_DATA_IRQ_TYPE "NONE"
#define OTG_HPI_DATA_NAME "/dev/otg_hpi_data"
#define OTG_HPI_DATA_RESET_VALUE 0
#define OTG_HPI_DATA_SPAN 16
#define OTG_HPI_DATA_TYPE "altera_avalon_pio"


/*
 * otg_hpi_r configuration
 *
 */

#define ALT_MODULE_CLASS_otg_hpi_r altera_avalon_pio
#define OTG_HPI_R_BASE 0x100013e0
#define OTG_HPI_R_BIT_CLEARING_EDGE_REGISTER 0
#define OTG_HPI_R_BIT_MODIFYING_OUTPUT_REGISTER 0
#define OTG_HPI_R_CAPTURE 0
#define OTG_HPI_R_DATA_WIDTH 1
#define OTG_HPI_R_DO_TEST_BENCH_WIRING 0
#define OTG_HPI_R_DRIVEN_SIM_VALUE 0
#define OTG_HPI_R_EDGE_TYPE "NONE"
#define OTG_HPI_R_FREQ 50000000
#define OTG_HPI_R_HAS_IN 0
#define OTG_HPI_R_HAS_OUT 1
#define OTG_HPI_R_HAS_TRI 0
#define OTG_HPI_R_IRQ -1
#define OTG_HPI_R_IRQ_INTERRUPT_CONTROLLER_ID -1
#define OTG_HPI_R_IRQ_TYPE "NONE"
#define OTG_HPI_R_NAME "/dev/otg_hpi_r"
#define OTG_HPI_R_RESET_VALUE 0
#define OTG_HPI_R_SPAN 16
#define OTG_HPI_R_TYPE "altera_avalon_pio"


/*
 * otg_hpi_reset configuration
 *
 */

#define ALT_MODULE_CLASS_otg_hpi_reset altera_avalon_pio
#define OTG_HPI_RESET_BASE 0x100013a0
#define OTG_HPI_RESET_BIT_CLEARING_EDGE_REGISTER 0
#define OTG_HPI_RESET_BIT_MODIFYING_OUTPUT_REGISTER 0
#define OTG_HPI_RESET_CAPTURE 0
#define OTG_HPI_RESET_DATA_WIDTH 1
#define OTG_HPI_RESET_DO_TEST_BENCH_WIRING 0
#define OTG_HPI_RESET_DRIVEN_SIM_VALUE 0
#define OTG_HPI_RESET_EDGE_TYPE "NONE"
#define OTG_HPI_RESET_FREQ 50000000
#define OTG_HPI_RESET_HAS_IN 0
#define OTG_HPI_RESET_HAS_OUT 1
#define OTG_HPI_RESET_HAS_TRI 0
#define OTG_HPI_RESET_IRQ -1
#define OTG_HPI_RESET_IRQ_INTERRUPT_CONTROLLER_ID -1
#define OTG_HPI_RESET_IRQ_TYPE "NONE"
#define OTG_HPI_RESET_NAME "/dev/otg_hpi_reset"
#define OTG_HPI_RESET_RESET_VALUE 0
#define OTG_HPI_RESET_SPAN 16
#define OTG_HPI_RESET_TYPE "altera_avalon_pio"


/*
 * otg_hpi_w configuration
 *
 */

#define ALT_MODULE_CLASS_otg_hpi_w altera_avalon_pio
#define OTG_HPI_W_BASE 0x100013f0
#define OTG_HPI_W_BIT_CLEARING_EDGE_REGISTER 0
#define OTG_HPI_W_BIT_MODIFYING_OUTPUT_REGISTER 0
#define OTG_HPI_W_CAPTURE 0
#define OTG_HPI_W_DATA_WIDTH 1
#define OTG_HPI_W_DO_TEST_BENCH_WIRING 0
#define OTG_HPI_W_DRIVEN_SIM_VALUE 0
#define OTG_HPI_W_EDGE_TYPE "NONE"
#define OTG_HPI_W_FREQ 50000000
#define OTG_HPI_W_HAS_IN 0
#define OTG_HPI_W_HAS_OUT 1
#define OTG_HPI_W_HAS_TRI 0
#define OTG_HPI_W_IRQ -1
#define OTG_HPI_W_IRQ_INTERRUPT_CONTROLLER_ID -1
#define OTG_HPI_W_IRQ_TYPE "NONE"
#define OTG_HPI_W_NAME "/dev/otg_hpi_w"
#define OTG_HPI_W_RESET_VALUE 0
#define OTG_HPI_W_SPAN 16
#define OTG_HPI_W_TYPE "altera_avalon_pio"


/*
 * sdram_pll configuration
 *
 */

#define ALT_MODULE_CLASS_sdram_pll altpll
#define SDRAM_PLL_BASE 0x10001100
#define SDRAM_PLL_IRQ -1
#define SDRAM_PLL_IRQ_INTERRUPT_CONTROLLER_ID -1
#define SDRAM_PLL_NAME "/dev/sdram_pll"
#define SDRAM_PLL_SPAN 16
#define SDRAM_PLL_TYPE "altpll"


/*
 * sysid_qsys_0 configuration
 *
 */

#define ALT_MODULE_CLASS_sysid_qsys_0 altera_avalon_sysid_qsys
#define SYSID_QSYS_0_BASE 0x10001408
#define SYSID_QSYS_0_ID 0
#define SYSID_QSYS_0_IRQ -1
#define SYSID_QSYS_0_IRQ_INTERRUPT_CONTROLLER_ID -1
#define SYSID_QSYS_0_NAME "/dev/sysid_qsys_0"
#define SYSID_QSYS_0_SPAN 8
#define SYSID_QSYS_0_TIMESTAMP 1641128659
#define SYSID_QSYS_0_TYPE "altera_avalon_sysid_qsys"

#endif /* __SYSTEM_H_ */
