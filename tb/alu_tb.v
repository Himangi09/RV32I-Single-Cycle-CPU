`timescale 1ns / 1ps

module alu_tb;

    reg  [31:0] a;
    reg  [31:0] b;
    reg  [3:0]  alu_ctrl;

    wire [31:0] result;
    wire        zero;

    // DUT (Device Under Test)
    alu dut (
        .a(a),
        .b(b),
        .alu_ctrl(alu_ctrl),
        .result(result),
        .zero(zero)
    );
    // Test Stimulus
    initial begin

        $display("====================================");
        $display("      RV32I ALU TEST STARTED");
        $display("====================================");

        // ADD
        a = 10;
        b = 20;
        alu_ctrl = 4'b0000;
        #10;
        $display("ADD : %0d + %0d = %0d", a, b, result);

        // SUB
        a = 20;
        b = 10;
        alu_ctrl = 4'b0001;
        #10;
        $display("SUB : %0d - %0d = %0d", a, b, result);

        // AND
        a = 12;     // 1100
        b = 10;     // 1010
        alu_ctrl = 4'b0010;
        #10;
        $display("AND : %0d & %0d = %0d", a, b, result);

        // OR
        a = 12;
        b = 10;
        alu_ctrl = 4'b0011;
        #10;
        $display("OR  : %0d | %0d = %0d", a, b, result);

        // XOR
        a = 12;
        b = 10;
        alu_ctrl = 4'b0100;
        #10;
        $display("XOR : %0d ^ %0d = %0d", a, b, result);

        // SLT
        a = 5;
        b = 10;
        alu_ctrl = 4'b0101;
        #10;
        $display("SLT : (%0d < %0d) = %0d", a, b, result);

        // SLL
        a = 5;
        b = 2;
        alu_ctrl = 4'b0110;
        #10;
        $display("SLL : %0d << %0d = %0d", a, b, result);

        // SRL
        a = 20;
        b = 2;
        alu_ctrl = 4'b0111;
        #10;
        $display("SRL : %0d >> %0d = %0d", a, b, result);

        // SRA
        a = -16;
        b = 2;
        alu_ctrl = 4'b1000;
        #10;
        $display("SRA : %0d >>> %0d = %0d", $signed(a), b, $signed(result));

        // Zero Flag Check
        a = 15;
        b = 15;
        alu_ctrl = 4'b0001;
        #10;
        $display("ZERO FLAG TEST");
        $display("Result = %0d, Zero = %b", result, zero);

        $display("====================================");
        $display("      RV32I ALU TEST COMPLETED");
        $display("====================================");

        $finish;
    end

endmodule