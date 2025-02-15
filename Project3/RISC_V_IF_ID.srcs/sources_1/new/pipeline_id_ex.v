module pipeline_id_ex(input clk,
                      input res,
                      input write,
                      input [31:0] IMM_IN,
                      input [31:0] PC_IN,
                      input [2:0] FUNCT3_IN,
                      input [6:0] FUNCT7_IN,
                      input [31:0] ALU_A_IN,
                      input [31:0] ALU_B_IN,
                      input [4:0] RS1_IN,
                      input [4:0] RS2_IN,
                      input [4:0] RD_IN,
                      input RegWrite_ID,
                      input MemtoReg_ID,
                      input MemRead_ID,
                      input MemWrite_ID,
                      input [1:0] ALUop_ID,
                      input ALUSrc_ID,
                      input Branch_ID,
                    
                      output reg [31:0] IMM_OUT,
                      output reg [31:0] PC_OUT,
                      output reg [2:0] FUNCT3_OUT,
                      output reg [6:0] FUNCT7_OUT,
                      output reg [31:0] ALU_A_OUT,
                      output reg [31:0] ALU_B_OUT,
                      output reg [4:0] RS1_OUT,
                      output reg [4:0] RS2_OUT,
                      output reg [4:0] RD_OUT,
                      output reg RegWrite_EX, 
                      output reg MemtoReg_EX,
                      output reg MemRead_EX,
                      output reg MemWrite_EX, 
                      output reg [1:0] ALUop_EX, 
                      output reg ALUSrc_EX, 
                      output reg Branch_EX
                      );
    
    always @(posedge clk or posedge res)
    begin
        if (res)
        begin
            IMM_OUT <= 32'b0;
            PC_OUT <= 32'b0;
            FUNCT3_OUT <= 3'b0;
            FUNCT7_OUT <= 7'b0;
            ALU_A_OUT <= 32'b0;
            ALU_B_OUT <= 32'b0;
            RS1_OUT <= 5'b0;
            RS2_OUT <= 5'b0;
            RD_OUT <= 5'b0;
            RegWrite_EX <= 1'b0;
            MemtoReg_EX <= 1'b0;
            MemRead_EX <= 1'b0;
            MemWrite_EX <= 1'b0;
            ALUop_EX <= 2'b0;
            ALUSrc_EX <= 1'b0;
            Branch_EX <= 1'b0;
        end
        else if (write)
        begin
            IMM_OUT <= IMM_IN;
            PC_OUT <= PC_IN;
            FUNCT3_OUT <= FUNCT3_IN;
            FUNCT7_OUT <= FUNCT7_IN;
            ALU_A_OUT <= ALU_A_IN;
            ALU_B_OUT <= ALU_B_IN;
            RS1_OUT <= RS1_IN;
            RS2_OUT <= RS2_IN;
            RD_OUT <= RD_IN;
            RegWrite_EX <= RegWrite_ID;
            MemtoReg_EX <= MemtoReg_ID;
            MemRead_EX <= MemRead_ID;
            MemWrite_EX <= MemWrite_ID;
            ALUop_EX <= ALUop_ID;
            ALUSrc_EX <= ALUSrc_ID;
            Branch_EX <= Branch_ID;
        end
    end
    
endmodule
