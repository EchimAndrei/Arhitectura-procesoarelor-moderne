module EX(input [31:0] IMM_EX,        //valoare immediate in EX 
          input [31:0] REG_DATA1_EX,  //valoarea registrului sursa 1
          input [31:0] REG_DATA2_EX,  //valoarea registrului sursa 2
          input [31:0] PC_EX,         //adresa instructiunii curente in EX
          input [2:0] FUNCT3_EX,      //funct3 pentru instructiunea din EX
          input [6:0] FUNCT7_EX,      //funct7 pentru instructiunea din EX
          input [4:0] RD_EX,          //adresa registrului destinatie
          input [4:0] RS1_EX,         //adresa registrului sursa 1
          input [4:0] RS2_EX,         //adresa registrului sursa 2
          input RegWrite_EX,          //semnal de scriere in bancul de registri
          input MemtoReg_EX,          //..............
          input MemRead_EX,           //semnal pentru activarea citirii din memorie
          input MemWrite_EX,          //semnal pentru activarea scrierii in memorie
          input [1:0] ALUop_EX,       //semnalul de control ALUop
          input ALUSrc_EX,            //semnal de selectie intre RS2 si valoarea imediata
          input Branch_EX,            //semnal de identificare a instructiunilor de tip branch
          input [1:0] forwardA,forwardB,// semnalele de selectie pentru multiplexoare de forwarding
          
          input [31:0] ALU_DATA_WB,   //valoarea calculata de ALU, prezenta in WB
          input [31:0] ALU_OUT_MEM,   //valoarea calculata de ALU, prezenta in MEM
          
          output ZERO_EX,             //flag-ul ZERO calculat de ALU
          output [31:0] ALU_OUT_EX,   //rezultatul calculat de ALU in EX
          output [31:0] PC_Branch_EX, //adresa de salt calculata in EX
          output [31:0] REG_DATA2_EX_FINAL//valoarea registrului sursa 2 selectata dintre
          );                              //valorile prezente in etapele EX, MEM si WB
          
wire [31:0] OUT_MUX_1, OUT_MUX_2, OUT_MUX_3;
wire [3:0] ALU_cont;

          // muxuri 4_1
          
          mux4_1 mux1(REG_DATA1_EX,
                      ALU_DATA_WB, 
                      ALU_OUT_MEM,
                      0,
                      forwardA,
                      OUT_MUX_1);
                      
          mux4_1 mux2(REG_DATA2_EX,
                      ALU_DATA_WB, 
                      ALU_OUT_MEM,
                      0,
                      forwardB,
                      OUT_MUX_2);
         
         // muxuri 2_1

         mux2_1 mux3(OUT_MUX_2,
                         IMM_EX,        
                         ALUSrc_EX,
                         OUT_MUX_3);

         ALUcontrol ALU_control(ALUop_EX,    
                                   FUNCT7_EX,    
                                   FUNCT3_EX,
                                   ALU_cont);
         ALU alu(ALU_cont,
                         OUT_MUX_1,
                         OUT_MUX_3,
                         ZERO_EX,
                         ALU_OUT_EX);

                         
         adder add_EX(PC_EX,
                      IMM_EX,
                      PC_Branch_EX);
        
        assign REG_DATA2_EX_FINAL = OUT_MUX_2;
endmodule