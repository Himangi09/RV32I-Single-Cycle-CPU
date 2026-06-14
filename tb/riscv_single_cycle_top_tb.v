`timescale 1ns / 1ps

module riscv_single_cycle_top_tb;

reg clk;
reg rst;

riscv_single_cycle_top DUT(
    .clk(clk),
    .rst(rst)
);

always #5 clk = ~clk;

initial begin

    clk = 0;
    rst = 1;

    #20;
    rst = 0;

    #70;

    $finish;

end

endmodule