`timescale 1ns / 1ps

module regfile(
    input clk,
    input rst,

    // Read Port 1
    input  [4:0] rs1_addr,
    output [31:0] read_data1,

    // Read Port 2
    input  [4:0] rs2_addr,
    output [31:0] read_data2,

    // Write Port
    input         reg_write,
    input  [4:0]  rd_addr,
    input  [31:0] write_data
);

    // 32 Registers, each 32 bits
    reg [31:0] regs [0:31];

    integer i;

    // Synchronous Reset + Write Logic
    always @(posedge clk) begin

        if (rst) begin
            for(i = 0; i < 32; i = i + 1)
                regs[i] <= 32'b0;
        end

        else if (reg_write && (rd_addr != 5'd0)) begin
            regs[rd_addr] <= write_data;
        end

    end

    // Combinational Read Ports
    assign read_data1 = (rs1_addr == 5'd0) ? 32'b0 : regs[rs1_addr];
    assign read_data2 = (rs2_addr == 5'd0) ? 32'b0 : regs[rs2_addr];

endmodule