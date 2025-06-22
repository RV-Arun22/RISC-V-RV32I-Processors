`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Me
// 
// Create Date: 20.06.2025 15:39:40
// Design Name: Immediate value sign extend module
// Module Name: Imm_Sign_Extend
// Project Name: RISC-V RV32I Single cycle processor
// Target Devices: 
// Tool Versions: 
// Description: Selects the required bits from the instruction, arranges them as 
//              per the instr (select signals from contrl path) and sign extends it 
//              to full 32-bit value readu to be sent to ALU.
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments: It is basically a mux module to select appripriate bits from the
//                      instr field as per the instr. Select lines come from control path.
//////////////////////////////////////////////////////////////////////////////////


module Imm_Sign_Extend(
    input [1:0] imm_src,        //control path output that selects the required fields as per instr.
    input [31:0] instr,         //instruction from IM
    output reg [31:0] imm       //sign extended immediate value
    );
    
    always @ (*)
        begin
            case (imm_src)
                2'b00: imm = {{20{instr[31]}}, instr[31:20]};                   //I-type instr
                2'b01: imm = {{20{instr[31]}}, instr[31:25], instr[11:7]};      //S-type instr
                2'b10: imm = {{20{instr[31]}}, instr[7], instr[30:25], instr[11:8], 1'b0};  //B-type instr
                default: imm = 'd0;
            endcase
        end
endmodule
