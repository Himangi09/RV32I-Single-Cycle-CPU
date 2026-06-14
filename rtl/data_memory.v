`timescale 1ns / 1ps

module data_memory(
    input              clk,
    input              mem_read,
    input              mem_write,
    input      [31:0]  addr,
    input      [31:0]  write_data,
    output reg [31:0]  read_data
);

    // 256 words of 32-bit memory
    reg [31:0] memory [0:255];

    integer i;

    // Initialize memory
    initial begin
        for(i = 0; i < 256; i = i + 1)
            memory[i] = 32'd0;
    end

    // Write Operation (SW)
    always @(posedge clk) begin
        if(mem_write)
            memory[addr[31:2]] <= write_data;
    end

    // Read Operation (LW)
    always @(*) begin
        if(mem_read)
            read_data = memory[addr[31:2]];
        else
            read_data = 32'd0;
    end

endmodule