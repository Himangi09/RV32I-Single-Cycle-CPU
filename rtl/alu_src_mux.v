`timescale 1ns / 1ps

module alu_src_mux(
    input  [31:0] rs2_data,
    input  [31:0] imm_data,
    input         ALUSrc,

    output [31:0] alu_in_b
);

    assign alu_in_b = (ALUSrc) ? imm_data : rs2_data;

endmodule