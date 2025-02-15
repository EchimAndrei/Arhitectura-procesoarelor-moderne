//////////////////////////////////////////////RISC-V_MODULE///////////////////////////////////////////////////
module RISC_V(
    input clk,      //semnalul de ceas global
    input reset,    //semnalul de reset global
    
    output [31:0] PC_EX,        //adresa PC in etapa EX
    output [31:0] ALU_OUT_EX,   //valoarea calculata de ALE in etapa EX
    output [31:0] PC_MEM,       //adresa de salt calculata
    output PCSrc,               //semnal de selectie pentru PC
    output [31:0] DATA_MEMORY_MEM,//valoarea citita din memoria de date in MEM
    output [31:0] ALU_DATA_WB,    //valoarea finala scrisa in etapa WB
    output [1:0] forwardA, forwardB,//semnalele de forwarding
    output pipeline_stall           //semnal de stall la detectia de hazarduri
    );

    //////////////////////////////////////////internal signals////////////////////////////////////////////////////////
    wire [31:0] PC_IF, INSTRUCTION_IF;
    wire [31:0] PC_Branch;
    wire PC_write;
    
    wire IF_ID_write;
    wire [31:0] PC_ID, INSTRUCTION_ID;
    
    wire RegWrite_WB;
    wire [4:0] RD_WB;
    wire [31:0] IMM_ID, REG_DATA1_ID, REG_DATA2_ID;
    wire RegWrite_ID, MemtoReg_ID;
    wire MemRead_ID, MemWrite_ID, ALUSrc_ID, Branch_ID;
    wire [1:0] ALUop_ID;
    wire [2:0] FUNCT3_ID;
    wire [6:0] FUNCT7_ID, OPCODE_ID;
    wire [4:0] RD_ID, RS1_ID, RS2_ID;
    
    wire write = 1'b1;
    wire [31:0] IMM_EX, REG_DATA1_EX, REG_DATA2_EX;
    wire RegWrite_EX, MemtoReg_EX;
    wire MemRead_EX, MemWrite_EX, ALUSrc_EX, Branch_EX;
    wire [1:0] ALUop_EX;
    wire [2:0] FUNCT3_EX;
    wire [6:0] FUNCT7_EX;
    wire [4:0] RD_EX, RS1_EX, RS2_EX;
    
    wire [31:0] ALU_OUT_MEM;
    wire ZERO_EX;
    wire [31:0] PC_Branch_EX, REG_DATA2_EX_FINAL;
    
    wire [2:0] FUNCT3_MEM;
    wire [6:0] FUNCT7_MEM;
    wire ZERO_MEM;
    wire [31:0] REG_DATA2_MEM;
    wire [4:0] RD_MEM;
    wire RegWrite_MEM, MemtoReg_MEM;
    wire MemRead_MEM, MemWrite_MEM, ALUSrc_MEM, Branch_MEM;
    wire [1:0] ALUop_MEM;
    
    wire [31:0] ALU_OUT_WB, DATA_MEMORY_WB;
    wire MemtoReg_WB;

    IF instruction_fetch(clk, reset,
                         PCSrc, PC_write,
                         PC_Branch,
                         PC_IF,INSTRUCTION_IF);
  
  
    IF_ID_reg IF_ID_REGISTER(clk, reset,
                             IF_ID_write,
                             PC_IF, INSTRUCTION_IF,
                             PC_ID, INSTRUCTION_ID);

    hazard_detection hazard(RD_EX,
                            RS1_ID,
                            RS2_ID,
                            MemRead_EX,
                            PC_write,
                            IF_ID_write,
                            pipeline_stall); 
                            
    ID instruction_decode(clk,
                          PC_ID, INSTRUCTION_ID,
                          RegWrite_WB, 
                          ALU_DATA_WB,
                          RD_WB,
                          IMM_ID,
                          REG_DATA1_ID,REG_DATA2_ID,
                          RegWrite_ID, MemtoReg_ID, MemRead_ID, MemWrite_ID,
                          ALUop_ID,
                          ALUSrc_ID,
                          Branch_ID,
                          FUNCT3_ID, FUNCT7_ID,
                          OPCODE_ID,
                          RD_ID, RS1_ID, RS2_ID);

    pipeline_id_ex id_ex(clk, reset, write,
                         IMM_ID,
                         PC_ID,
                         FUNCT3_ID, FUNCT7_ID,
                         REG_DATA1_ID, REG_DATA2_ID,
                         RS1_ID, RS2_ID, RD_ID,
                         RegWrite_ID,
                         MemtoReg_ID, MemRead_ID, MemWrite_ID,
                         ALUop_ID, ALUSrc_ID,
                         Branch_ID,
                         IMM_EX,
                         PC_EX,
                         FUNCT3_EX, FUNCT7_EX,
                         REG_DATA1_EX, REG_DATA2_EX,
                         RS1_EX, RS2_EX, RD_EX,
                         RegWrite_EX,
                         MemtoReg_EX, MemRead_EX, MemWrite_EX,
                         ALUop_EX, ALUSrc_EX,
                         Branch_EX);
  
    EX execute(IMM_EX,
          REG_DATA1_EX, REG_DATA2_EX,
          PC_EX,
          FUNCT3_EX, FUNCT7_EX,
          RD_EX, RS1_EX, RS2_EX,
          RegWrite_EX,
          MemtoReg_EX,
          MemRead_EX,
          MemWrite_EX,
          ALUop_EX,
          ALUSrc_EX,
          Branch_EX,
          forwardA, forwardB,
          ALU_DATA_WB,
          ALU_OUT_MEM,
          ZERO_EX,
          ALU_OUT_EX,
          PC_Branch_EX,
          REG_DATA2_EX_FINAL);
    
    forwarding forward(RS1_EX,
                       RS2_EX,
                       RD_MEM,
                       RD_WB,
                       RegWrite_MEM,
                       RegWrite_WB,
                       forwardA, forwardB);

    pipeline_ex_mem ex_mem(clk, reset, write,
                           PC_Branch_EX,
                           FUNCT3_EX,
                           ZERO_EX,
                           ALU_OUT_EX,
                           REG_DATA2_EX_FINAL,
                           RD_EX,
                           RegWrite_EX,
                           MemtoReg_EX, MemRead_EX, MemWrite_EX,
                           Branch_EX,
                           PC_MEM,
                           FUNCT3_MEM,
                           ZERO_MEM,
                           ALU_OUT_MEM,
                           REG_DATA2_MEM,
                           RD_MEM,
                           RegWrite_MEM,
                           MemtoReg_MEM, MemRead_MEM, MemWrite_MEM,
                           Branch_MEM);
                           
    MEM memory(clk,
               MemRead_MEM,
               MemWrite_MEM,
               ALU_OUT_MEM,
               REG_DATA2_MEM,
               ZERO_MEM,
               Branch_MEM,
               FUNCT3_MEM,
               DATA_MEMORY_MEM,
               PCSrc);
    
    pipeline_mem_wb mem_wb(clk, reset, write,
                           DATA_MEMORY_MEM,
                           ALU_OUT_MEM,
                           RD_MEM,
                           RegWrite_MEM,
                           MemtoReg_MEM,
                           ALU_OUT_WB,
                           DATA_MEMORY_WB,
                           RD_WB,
                           RegWrite_WB,
                           MemtoReg_WB);

    mux2_1 mux(ALU_OUT_WB, DATA_MEMORY_WB, MemtoReg_WB, ALU_DATA_WB);                                                     
endmodule
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
