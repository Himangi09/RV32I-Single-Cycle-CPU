# RV32I Single-Cycle Processor in Verilog

## Overview

This project implements a 32-bit Single-Cycle RISC-V (RV32I) Processor using Verilog HDL. The processor executes instructions in a single clock cycle and demonstrates the complete instruction execution flow:

Fetch → Decode → Execute → Memory Access → Write Back

The design was developed and verified using Xilinx Vivado Behavioral Simulation.

---

## Features

### Supported Instruction Types

#### R-Type
- ADD
- SUB
- AND
- OR
- XOR
- SLT
- SLL
- SRL
- SRA

#### I-Type
- ADDI
- LW

#### S-Type
- SW

#### B-Type
- BEQ

---

## Processor Architecture

The processor consists of the following modules:

| Module | Function |
|----------|----------|
| Program Counter (PC) | Holds current instruction address |
| PC + 4 Adder | Generates sequential next address |
| Branch PC Logic | Handles branch target selection |
| Instruction Memory | Stores program instructions |
| Control Unit | Generates control signals |
| Register File | 32 × 32-bit general-purpose registers |
| Immediate Generator | Generates I, S and B type immediates |
| ALU Control | Generates ALU operation select signals |
| Arithmetic Logic Unit (ALU) | Executes arithmetic and logical operations |
| Data Memory | Supports load/store operations |
| ALU Source MUX | Selects ALU operand source |
| Mem-to-Reg MUX | Selects write-back source |

---

## Datapath

```text
                   +----------------+
                   | Program Counter|
                   +-------+--------+
                           |
                           v
                  +------------------+
                  | Instruction Memory|
                  +--------+---------+
                           |
                           v
                  +------------------+
                  |  Control Unit    |
                  +--------+---------+
                           |
                           v
                  +------------------+
                  |  Register File   |
                  +--------+---------+
                           |
                           v
                  +------------------+
                  | Immediate Gen    |
                  +--------+---------+
                           |
                           v
                  +------------------+
                  |       ALU        |
                  +--------+---------+
                           |
                           v
                  +------------------+
                  |   Data Memory    |
                  +--------+---------+
                           |
                           v
                  +------------------+
                  | Write Back MUX   |
                  +------------------+
```

---

## Verification Program

The processor was verified using the following test program:

```assembly
addi x1, x0, 5
addi x2, x0, 10
add  x3, x1, x2
sw   x3, 0(x0)
lw   x4, 0(x0)
```

---

## Expected Results

| Register | Expected Value |
|-----------|---------------|
| x1 | 5 |
| x2 | 10 |
| x3 | 15 |
| x4 | 15 |

Memory Location 0:

```text
memory[0] = 15
```

---

## Simulation Results

The processor successfully executed:

- Arithmetic operations
- Register write-back
- Memory store operation
- Memory load operation
- Branch control logic

Verified through Vivado Behavioral Simulation waveforms.

### Sample Execution

```text
PC = 0   -> ADDI x1,x0,5
PC = 4   -> ADDI x2,x0,10
PC = 8   -> ADD  x3,x1,x2
PC = 12  -> SW   x3,0(x0)
PC = 16  -> LW   x4,0(x0)
```

Final State:

```text
x1 = 5
x2 = 10
x3 = 15
x4 = 15

memory[0] = 15
```

---

## Directory Structure

```text
RV32I-Single-Cycle-CPU/
├── rtl/
│   ├── alu.v
│   ├── alu_control.v
│   ├── alu_src_mux.v
│   ├── Branch_PC.v
│   ├── control_unit.v
│   ├── data_memory.v
│   ├── imm_gen.v
│   ├── instruction_memory.v
│   ├── mem_to_reg_mux.v
│   ├── pc_plus4.v
│   ├── pc_unit.v
│   ├── regfile.v
│   └── riscv_single_cycle_top.v
│
├── tb/
│   ├── alu_tb.v
│   ├── control_unit_tb.v
│   ├── imm_gen_tb.v
│   └── riscv_single_cycle_tb.v
│
├── screenshots/
│   ├── cpu_full_waveform.png
│   ├── register_file_result.png
│   ├── data_memory_result.png
│   └── rtl_schematic.png
│
└── README.md
```

---

## Tools Used

- Verilog HDL
- Xilinx Vivado 2023.1
- Behavioral Simulation
- GitHub

---

## Future Improvements

- Full RV32I ISA Support
- Pipelined Processor Implementation
- Hazard Detection Unit
- Forwarding Unit
- FPGA Implementation
- Performance Analysis

---

## Author

## Author

Developed as a Digital Design project to demonstrate RISC-V CPU architecture, RTL development, datapath/control integration, and functional verification using Verilog HDL.
---