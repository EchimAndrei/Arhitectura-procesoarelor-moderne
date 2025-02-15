`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/20/2025 05:51:00 PM
// Design Name: 
// Module Name: MEM
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


module MEM(
    input clk,
    input MemRead_MEM,
    input MemWrite_MEM,
    input [31:0] ALU_OUT_MEM,
    input [31:0] REG_DATA2_MEM,
    input ZERO_MEM,
    input Branch_MEM,
    input [2:0] FUNCT3_MEM,
    output [31:0] DATA_MEMORY_MEM,
    output PCSrc
    );

    data_memory data_mem(clk,
                         MemRead_MEM,
                         MemWrite_MEM,
                         ALU_OUT_MEM,
                         REG_DATA2_MEM,
                         DATA_MEMORY_MEM);
    
    branch_control b_control(ZERO_MEM,
                             ALU_OUT_MEM,
                             Branch_MEM,
                             FUNCT3_MEM,
                             PCSrc);
endmodule