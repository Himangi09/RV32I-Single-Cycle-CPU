`timescale 1ns / 1ps

module riscv_single_cycle_top(
    input clk,
    input rst
);

// ======================================================
// Wires
// ======================================================

wire [31:0] pc;
wire [31:0] pc_plus_4;
wire [31:0] next_pc;

wire [31:0] instruction;

wire [6:0] opcode;
wire [2:0] funct3;
wire [6:0] funct7;

wire [4:0] rs1;
wire [4:0] rs2;
wire [4:0] rd;

wire RegWrite;
wire ALUSrc;
wire MemRead;
wire MemWrite;
wire Branch;
wire MemtoReg;

wire [1:0] ALUOp;
wire [3:0] alu_ctrl;

wire [31:0] rs1_data;
wire [31:0] rs2_data;

wire [31:0] imm_data;

wire [31:0] alu_in_b;
wire [31:0] alu_result;

wire zero;

wire [31:0] mem_read_data;

wire [31:0] write_back_data;

// ======================================================
// Instruction Field Extraction
// ======================================================

assign opcode = instruction[6:0];
assign rd     = instruction[11:7];
assign funct3 = instruction[14:12];
assign rs1    = instruction[19:15];
assign rs2    = instruction[24:20];
assign funct7 = instruction[31:25];

// ======================================================
// PC
// ======================================================

pc_unit PC_REG(
    .clk(clk),
    .rst(rst),
    .next_pc(next_pc),
    .pc(pc)
);

pc_plus4 PC_ADD(
    .pc(pc),
    .pc_plus_4(pc_plus_4)
);

// ======================================================
// Instruction Memory
// ======================================================

instruction_memory IMEM(
    .addr(pc),
    .instruction(instruction)
);

// ======================================================
// Control Unit
// ======================================================

control_unit CTRL(
    .opcode(opcode),

    .RegWrite(RegWrite),
    .ALUSrc(ALUSrc),
    .MemRead(MemRead),
    .MemWrite(MemWrite),
    .Branch(Branch),
    .MemtoReg(MemtoReg),
    .ALUOp(ALUOp)
);

// ======================================================
// Register File
// ======================================================

regfile RF(
    .clk(clk),
    .rst(rst),

    .rs1_addr(rs1),
    .read_data1(rs1_data),

    .rs2_addr(rs2),
    .read_data2(rs2_data),

    .reg_write(RegWrite),
    .rd_addr(rd),
    .write_data(write_back_data)
);

// ======================================================
// Immediate Generator
// ======================================================

imm_gen IMM_GEN(
    .instruction(instruction),
    .imm_out(imm_data)
);

// ======================================================
// ALU Control
// ======================================================

alu_control ALU_CTRL(
    .ALUOp(ALUOp),
    .funct3(funct3),
    .funct7(funct7),

    .alu_ctrl(alu_ctrl)
);

// ======================================================
// ALU Source MUX
// ======================================================

alu_src_mux SRC_MUX(
    .rs2_data(rs2_data),
    .imm_data(imm_data),
    .ALUSrc(ALUSrc),

    .alu_in_b(alu_in_b)
);

// ======================================================
// ALU
// ======================================================

alu ALU_CORE(
    .a(rs1_data),
    .b(alu_in_b),
    .alu_ctrl(alu_ctrl),

    .result(alu_result),
    .zero(zero)
);

// ======================================================
// Data Memory
// ======================================================

data_memory DMEM(
    .clk(clk),
    .mem_read(MemRead),
    .mem_write(MemWrite),

    .addr(alu_result),

    .write_data(rs2_data),

    .read_data(mem_read_data)
);

// ======================================================
// Write Back MUX
// ======================================================

mem_to_reg_mux WB_MUX(
    .alu_result(alu_result),
    .memory_data(mem_read_data),

    .MemtoReg(MemtoReg),

    .write_back_data(write_back_data)
);

// ======================================================
// Branch PC Logic
// ======================================================

Branch_PC BRANCH_UNIT(
    .pc(pc),
    .pc_plus_4(pc_plus_4),

    .branch_offset(imm_data),

    .branch_en(Branch),
    .zero(zero),

    .next_pc(next_pc)
);

endmodule