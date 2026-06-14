`timescale 1ns/1ps

module Branch_PC(
    input  [31:0] pc,
    input  [31:0] pc_plus_4,

    input  [31:0] branch_offset,

    input         branch_en,
    input         zero,

    output [31:0] next_pc
);

wire branch_taken;
wire [31:0] branch_target;

assign branch_taken  = branch_en & zero;
assign branch_target = pc + branch_offset;

assign next_pc = (branch_taken) ?
                 branch_target :
                 pc_plus_4;

endmodule