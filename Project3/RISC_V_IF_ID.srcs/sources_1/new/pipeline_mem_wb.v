module pipeline_mem_wb(input clk,
                       input res,
                       input write,
                       input [31:0] DATA_IN,
                       input [31:0] ALU_IN,
                       input [4:0] RD_IN,
                       input RegWrite_IN,
                       input MemtoReg_IN,
                        
                       output reg [31:0] ALU_OUT,
                       output reg [31:0] DATA_OUT,
                       output reg [4:0] RD_OUT,
                       output reg RegWrite_OUT,
                       output reg MemtoReg_OUT
                       );
    
    always @(posedge clk or posedge res)
    begin
        if (res)
        begin
            ALU_OUT <= 32'b0;
            DATA_OUT <= 32'b0;
            RD_OUT <= 5'b0;
            RegWrite_OUT <= 1'b0;
            MemtoReg_OUT <= 1'b0;
        end
        else if (write)
        begin
            ALU_OUT <= ALU_IN;
            DATA_OUT <= DATA_IN;
            RD_OUT <= RD_IN;
            RegWrite_OUT <= RegWrite_IN;
            MemtoReg_OUT <= MemtoReg_IN;
        end
    end
    
endmodule