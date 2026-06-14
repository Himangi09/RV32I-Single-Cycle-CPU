`timescale 1ns / 1ps

module imm_gen_tb;

reg  [31:0] instruction;
wire [31:0] imm_out;

imm_gen uut(
    .instruction(instruction),
    .imm_out(imm_out)
);

initial begin

    $display("==============================================");
    $display("IMM_GEN TEST");
    $display("==============================================");

    // ---------------------------------
    // I-Type
    // addi x1,x0,5
    // imm = 5
    // ---------------------------------

    instruction = 32'h00500093;

    #10;

    $display("I-Type ADDI");
    $display("Instruction = %h", instruction);
    $display("Immediate   = %d", imm_out);

    // ---------------------------------
    // I-Type
    // lw x1,8(x0)
    // imm = 8
    // ---------------------------------

    instruction = 32'h00802083;

    #10;

    $display("LW");
    $display("Instruction = %h", instruction);
    $display("Immediate   = %d", imm_out);

    // ---------------------------------
    // S-Type
    // sw x1,12(x0)
    // imm = 12
    // ---------------------------------

    instruction = 32'h00102623;

    #10;

    $display("SW");
    $display("Instruction = %h", instruction);
    $display("Immediate   = %d", imm_out);

    // ---------------------------------
    // B-Type
    // beq x0,x0,+16
    // imm = 16
    // ---------------------------------

    instruction = 32'h00000863;

    #10;

    $display("BEQ");
    $display("Instruction = %h", instruction);
    $display("Immediate   = %d", imm_out);

    $display("==============================================");

    $finish;

end

endmodule