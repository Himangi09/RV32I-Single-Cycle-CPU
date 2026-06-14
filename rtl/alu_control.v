`timescale 1ns / 1ps

module alu_control(
    input  [1:0] ALUOp,
    input  [2:0] funct3,
    input  [6:0] funct7,

    output reg [3:0] alu_ctrl
);

always @(*) begin

    case(ALUOp)

        // LW, SW
        2'b00: alu_ctrl = 4'b0000;   // ADD

        // BEQ
        2'b01: alu_ctrl = 4'b0001;   // SUB

        // R-Type
        2'b10: begin

            case(funct3)

                3'b000: begin
                    if(funct7 == 7'b0100000)
                        alu_ctrl = 4'b0001; // SUB
                    else
                        alu_ctrl = 4'b0000; // ADD
                end

                3'b111: alu_ctrl = 4'b0010; // AND

                3'b110: alu_ctrl = 4'b0011; // OR

                3'b100: alu_ctrl = 4'b0100; // XOR

                3'b010: alu_ctrl = 4'b0101; // SLT

                3'b001: alu_ctrl = 4'b0110; // SLL

                3'b101: begin
                    if(funct7 == 7'b0100000)
                        alu_ctrl = 4'b1000; // SRA
                    else
                        alu_ctrl = 4'b0111; // SRL
                end

                default: alu_ctrl = 4'b0000;

            endcase

        end

        // I-Type (ADDI)
        2'b11: begin

            case(funct3)

                3'b000: alu_ctrl = 4'b0000; // ADDI

                default: alu_ctrl = 4'b0000;

            endcase

        end

        default: alu_ctrl = 4'b0000;

    endcase

end

endmodule