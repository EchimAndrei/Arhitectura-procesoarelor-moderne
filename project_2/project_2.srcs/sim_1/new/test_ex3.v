`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/25/2024 07:32:02 PM
// Design Name: 
// Module Name: test_ex3
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


module test_ex3;
    reg clk, reg_write;
    reg [4:0] read_reg1, read_reg2, write_reg;
    reg [31:0] write_data;
    wire [31:0] read_data1, read_data2;
    
    registers regs(clk, reg_write, read_reg1, read_reg2, write_reg,
                   write_data, read_data1, read_data2);
    always #10 clk = ~clk;
    
    initial begin
        clk = 1; read_reg1 = 0; read_reg2 = 0; write_reg = 0; write_data = 0;
        reg_write = 0;
        
        #10 
        read_reg1 = 1;
        read_reg2 = 2;
        
        #10
        reg_write = 1;
        write_reg = 1;
        write_data = 100;
        read_reg1 = 4;
        read_reg2 = 5;
        
        #10 
        reg_write = 0;
        read_reg1 = 1;
        read_reg2 = 5;
    end
endmodule
