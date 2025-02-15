`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/05/2024 01:31:21 PM
// Design Name: 
// Module Name: imm_gen
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


module imm_gen(input [31:0] in, output reg [31:0] out);
always@(in)begin
    out <= 32'b0;
    casex (in[6:0])
        7'b1100011:
            begin //beq, bne, blt, bge, bltu, bgeu opecode B
                out[0] <= 0;
                out[4:1] <= in[11:8];
                out[10:5] <= in[30:25];
                out[11] <= in[7];
                out[31:12] <= {20{in[31]}};
             end
        7'b0100011:
           begin
            if(in[14:12] == 3'b010)
                begin //sw opecode S
                    out[0] <= in[7]; 
                    out[4:1] <= in[11:8];
                    out[10:5] <= in[30:25];
                    out[31:11] <= {21{in[31]}};
                   end
            end
        7'b0010011:
            // Pentru SLLI si SRLI si SRAI 
             if(in[14:12] == 3'b001 || in[14:12] == 3'b101)
                 begin
                    out <= 32'b0;
                    out[4:0] <= in[24:20];
                 end
             else
                  begin //addi,andi,ori,xori,slti,sltiu opecode I
                    out[0] <= in[20];
                    out[4:1] <= in[24:21];
                    out[10:5] <= in[30:25];
                    out[31:11] <= {21{in[31]}};
                   end
        7'b0000011:
            begin
                if(in[14:12] == 3'b010)
                    begin //lw opecode I
                        out[0] <= in[20];
                        out[4:1] <= in[24:21];
                        out[10:5] <= in[30:25];
                        out[31:11] <= {21{in[31]}};
                    end
            end
        default: out <= 32'b0;
    endcase
    
end
endmodule
