`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/05/2024 01:11:28 PM
// Design Name: 
// Module Name: IF
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module IF(input clk, reset,
          input PCSrc, PC_write,
          input [31:0] PC_Branch,
          output [31:0] PC_IF, INSTRUCTION_IF);
    
    wire [31:0] PC_mux;
    wire [31:0] out_PC;
    wire [31:0] PC_IF_4;
    wire [31:0] out_inst;
    wire [31:0] inb;

    assign inb = 4;

    mux2_1 mux(PC_IF_4, PC_Branch, PCSrc, PC_mux);
    PC pc(clk, reset, PC_write, PC_mux, out_PC);
    adder add(out_PC, inb, PC_IF_4);
    instruction_memory mem(out_PC[11:2], out_inst);
  
    assign PC_IF = out_PC;
    assign INSTRUCTION_IF = out_inst;

endmodule
