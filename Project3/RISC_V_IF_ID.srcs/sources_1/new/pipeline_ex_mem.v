module pipeline_ex_mem(input clk,
                       input res,
                       input write,
                       input [31:0] PC_IN,
                       input [2:0] FUNCT3_IN,
                       input ZERO_IN,
                       input [31:0] ALU_IN,
                       input [31:0] REG2_DATA_IN,
                       input [4:0] RD_IN,
                       input RegWrite_IN,
                       input MemtoReg_IN,
                       input MemRead_IN,
                       input MemWrite_IN,
                       input Branch_IN,
                        
                       output reg [31:0] PC_OUT,
                       output reg [2:0] FUNCT3_OUT,
                       output reg ZERO_OUT,
                       output reg [31:0] ALU_OUT,
                       output reg [31:0] REG2_DATA_OUT,
                       output reg [4:0] RD_OUT,
                       output reg RegWrite_OUT,
                       output reg MemtoReg_OUT,
                       output reg MemRead_OUT,
                       output reg MemWrite_OUT,
                       output reg Branch_OUT
                       );
    
    always @(posedge clk or posedge res)
    begin
        if (res) begin
            PC_OUT <= 32'b0;
            FUNCT3_OUT <= 3'b0;
            ZERO_OUT <= 1'b0;
            ALU_OUT <= 32'b0;
            REG2_DATA_OUT <= 32'b0;
            RD_OUT <= 5'b0;
            RegWrite_OUT <= 1'b0;
            MemtoReg_OUT <= 1'b0;
            MemRead_OUT <= 1'b0;
            MemWrite_OUT <= 1'b0;
            Branch_OUT <= 1'b0;
        end
        else if (write)
        begin
            PC_OUT <= PC_IN;
            FUNCT3_OUT <= FUNCT3_IN;
            ZERO_OUT <= ZERO_IN;
            ALU_OUT <= ALU_IN;
            REG2_DATA_OUT <= REG2_DATA_IN;
            RD_OUT <= RD_IN;
            RegWrite_OUT <= RegWrite_IN;
            MemtoReg_OUT <= MemtoReg_IN;
            MemRead_OUT <= MemRead_IN;
            MemWrite_OUT <= MemWrite_IN;
            Branch_OUT <= Branch_IN;
        end
    end
    
endmodule