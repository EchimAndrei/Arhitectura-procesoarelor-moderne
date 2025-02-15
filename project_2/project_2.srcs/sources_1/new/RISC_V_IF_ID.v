`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/12/2024 01:02:45 PM
// Design Name: 
// Module Name: RISC_V_IF_ID
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


module RISC_V_IF_ID(input clk, // Semnalul de ceas
                    input reset, // Semnalul de reset
                    
                    // Semnale provenite din stagii viitoare
                    // Sunt pre-setate pentru aceasta lucrare
                    input IF_ID_write, // Semnal de scriere pentru registrul de pipeline IF_ID
                    input PCSrc, PC_write, // semnale de control pentru PC
                    input [31:0] PC_Branch, // PC-ul calculat in etapa EX pentru instructiunile de salt
                    input RegWrite_WB, // Semnal de activare a scrierii in bancul de registri
                    input [31:0] ALU_DATA_WB, // Rezultatul calculat de ALU
                    input [4:0] RD_WB, // registrul rezultat in care se face scrierea
                    
                    // semnale de iesire din ID
                    output [31:0] PC_ID, // adresa PC a instructiunii din etapa ID
                    output [31:0] INSTRUCTION_ID, // instructiunea curenta in etapa ID
                    output [31:0] IMM_ID, // valoarea calculata
                    output [31:0] REG_DATA1_ID, // valoarea primului registru sursa citit
                    output [31:0] REG_DATA2_ID, // valoarea celui de-al doilea registru sursa citit
                    
                    output [2:0] FUNCT3_ID, // funct3 din codificarea instructiunii
                    output [6:0] FUNCT7_ID, // funct7 din codificarea instructiunii
                    output [6:0] OPCODE_ID, // opcode-ul instructiunii
                    output [4:0] RD_ID, // registrul destinatie
                    output [4:0] RS1_ID, // registrul sursa1
                    output [4:0] RS2_ID ); // registru sursa 2
    
    wire [31:0] Out_PC_IF, Out_INSTRUCTION_IF;
    
    IF iff(clk, reset, PCSrc, PC_write, PC_Branch, Out_PC_IF, Out_INSTRUCTION_IF);
    IF_ID_PIPE pipe(clk, reset, IF_ID_write, Out_PC_IF, Out_INSTRUCTION_IF, PC_ID, INSTRUCTION_ID);
    ID idd(clk, PC_ID, INSTRUCTION_ID, RegWrite_WB, ALU_DATA_WB, RD_WB, IMM_ID, 
    REG_DATA1_ID, REG_DATA2_ID, FUNCT3_ID, FUNCT7_ID, OPCODE_ID, RD_ID, RS1_ID, RS2_ID);
    
endmodule