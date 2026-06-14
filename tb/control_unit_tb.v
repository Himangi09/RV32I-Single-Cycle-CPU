`timescale 1ns / 1ps

module control_unit_tb;

reg  [6:0] opcode;

wire RegWrite;
wire ALUSrc;
wire MemRead;
wire MemWrite;
wire Branch;
wire MemtoReg;
wire [1:0] ALUOp;

// DUT
control_unit uut (
    .opcode(opcode),

    .RegWrite(RegWrite),
    .ALUSrc(ALUSrc),
    .MemRead(MemRead),
    .MemWrite(MemWrite),
    .Branch(Branch),
    .MemtoReg(MemtoReg),
    .ALUOp(ALUOp)
);

initial begin

    $display("------------------------------------------------------------");

    // R-Type
    opcode = 7'b0110011;
    #10;
    $display("time=%0t,opcode=%b,RegWrite=%b,ALUSrc=%b,MemRead=%b,MemWrite=%b,Branch=%b,MemtoReg=%b,ALUOp=%b",
              $time, opcode,
              RegWrite, ALUSrc, MemRead,
              MemWrite, Branch, MemtoReg, ALUOp);

    // ADDI
    opcode = 7'b0010011;
    #10;
    $display("time=%0t,opcode=%b,RegWrite=%b,ALUSrc=%b,MemRead=%b,MemWrite=%b,Branch=%b,MemtoReg=%b,ALUOp=%b",
              $time, opcode,
              RegWrite, ALUSrc, MemRead,
              MemWrite, Branch, MemtoReg, ALUOp);

    // LW
    opcode = 7'b0000011;
    #10;
    $display("time=%0t,opcode=%b,RegWrite=%b,ALUSrc=%b,MemRead=%b,MemWrite=%b,Branch=%b,MemtoReg=%b,ALUOp=%b",
              $time, opcode,
              RegWrite, ALUSrc, MemRead,
              MemWrite, Branch, MemtoReg, ALUOp);

    // SW
    opcode = 7'b0100011;
    #10;
    $display("time=%0t,opcode=%b,RegWrite=%b,ALUSrc=%b,MemRead=%b,MemWrite=%b,Branch=%b,MemtoReg=%b,ALUOp=%b",
              $time, opcode,
              RegWrite, ALUSrc, MemRead,
              MemWrite, Branch, MemtoReg, ALUOp);

    // BEQ
    opcode = 7'b1100011;
    #10;
    $display("time=%0t,opcode=%b,RegWrite=%b,ALUSrc=%b,MemRead=%b,MemWrite=%b,Branch=%b,MemtoReg=%b,ALUOp=%b",
              $time, opcode,
              RegWrite, ALUSrc, MemRead,
              MemWrite, Branch, MemtoReg, ALUOp);
    $display("------------------------------------------------------------");

    $finish;

end

endmodule