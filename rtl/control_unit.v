`timescale 1ns / 1ps

module control_unit(
    input  [6:0] opcode,

    output reg RegWrite,
    output reg ALUSrc,
    output reg MemRead,
    output reg MemWrite,
    output reg Branch,
    output reg MemtoReg,
    output reg [1:0] ALUOp
);

always @(*) begin

    // Default values
    RegWrite = 1'b0;
    ALUSrc   = 1'b0;
    MemRead  = 1'b0;
    MemWrite = 1'b0;
    Branch   = 1'b0;
    MemtoReg = 1'b0;
    ALUOp    = 2'b00;

    case(opcode)

        // R-Type Instructions
        // add, sub, and, or
        7'b0110011: begin
            RegWrite = 1'b1;
            ALUSrc   = 1'b0;
            MemRead  = 1'b0;
            MemWrite = 1'b0;
            Branch   = 1'b0;
            MemtoReg = 1'b0;
            ALUOp    = 2'b10;
        end

        // I-Type Instruction
        // addi
        7'b0010011: begin
            RegWrite = 1'b1;
            ALUSrc   = 1'b1;
            MemRead  = 1'b0;
            MemWrite = 1'b0;
            Branch   = 1'b0;
            MemtoReg = 1'b0;
            ALUOp    = 2'b00;
        end

        // Load Word (LW)
        7'b0000011: begin
            RegWrite = 1'b1;
            ALUSrc   = 1'b1;
            MemRead  = 1'b1;
            MemWrite = 1'b0;
            Branch   = 1'b0;
            MemtoReg = 1'b1;
            ALUOp    = 2'b00;
        end

        // Store Word (SW)
        7'b0100011: begin
            RegWrite = 1'b0;
            ALUSrc   = 1'b1;
            MemRead  = 1'b0;
            MemWrite = 1'b1;
            Branch   = 1'b0;
            MemtoReg = 1'b0;
            ALUOp    = 2'b00;
        end

        // Branch Equal (BEQ)
        7'b1100011: begin
            RegWrite = 1'b0;
            ALUSrc   = 1'b0;
            MemRead  = 1'b0;
            MemWrite = 1'b0;
            Branch   = 1'b1;
            MemtoReg = 1'b0;
            ALUOp    = 2'b01;
        end

        default: begin
            RegWrite = 1'b0;
            ALUSrc   = 1'b0;
            MemRead  = 1'b0;
            MemWrite = 1'b0;
            Branch   = 1'b0;
            MemtoReg = 1'b0;
            ALUOp    = 2'b00;
        end

    endcase

end

endmodule