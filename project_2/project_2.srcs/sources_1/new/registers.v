`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/05/2024 01:29:04 PM
// Design Name: 
// Module Name: registers
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


module registers(input clk, reg_write,
                 input [4:0] read_reg1, read_reg2, write_reg,
                 input [31:0] write_data,
                 output [31:0] read_data1, read_data2);
    reg [31:0] x[31:0];
    integer i;
    
    // Initializam registrii
    initial begin
        for (i = 0; i < 32; i = i + 1)begin
            x[i] <= i;
        end
    end
    
    // Extragem informatia din registrul corespunzator
    assign read_data1 = (read_reg1 == 0) ? 32'b0 : ((read_reg1 != write_reg || (read_reg1 == write_reg && reg_write == 0)) ? x[read_reg1] : write_data);
    assign read_data2 = (read_reg2 == 0) ? 32'b0 : ((read_reg2 != write_reg || (read_reg2 == write_reg && reg_write == 0)) ? x[read_reg2] : write_data);
    
    // Actualizam registrii
    always@(posedge clk)
    begin 
        if(reg_write == 1 && write_reg) begin
            x[write_reg] <= write_data;
        end 
    end 

    
endmodule
