module hazard_detection(input [4:0] rd,     //adresa registrului destinatie in etapa EX
                        input [4:0] rs1,    //adresa registrului sursa 1 decodificat in etapa ID
                        input [4:0] rs2,    //adresa registrului sursa 2 decodificat in etapa ID
                        input MemRead,      //semnalul de control MemRead din etapa EX
                        output reg PCwrite, // semnalul PCwrite ce controleaza scrierea in registrul PC
                        output reg IF_IDwrite,//semnal ce controleaza scrierea in registrul de pipeline IF_ID
                        output reg control_sel);//semnal transmis spre unitatea de control
    always@(MemRead, rd, rs1, rs2) begin 
        if (MemRead && ((rd == rs1)||(rd == rs2))) begin
              // daca avem hazard, stall the pipeline
              PCwrite <= 1'b0;
              IF_IDwrite <= 1'b0;
              control_sel <= 1'b1;
        end
        else begin 
              // daca nu:
              PCwrite <= 1'b1;
              IF_IDwrite <= 1'b1;
              control_sel <= 1'b0;
        end  
    end                         
    
endmodule