module data_memory(input clk,       
                   input mem_read,              //semnal de activare a citirii din memorie
                   input mem_write,             //semnal de activare a scrierii in memorie
                   input [31:0] address,        //adresa de scriere/citire
                   input [31:0] write_data,     //valoarea scrisa in memorie
                   output reg [31:0] read_data);//valoarea citita din memorie
    reg [31:0] memData [0:1023];
    integer i;
    
    // initializare cu 0
    initial begin
        for (i = 0; i< 1024; i = i + 1) begin 
            memData[i] = 32'b0; 
        end
    end 
     
    // scriere data
    always@(posedge clk) begin
        if(mem_write)
          memData[address[11:2]] <= write_data;
    end
    
    // citire data
    always@(*)
    begin
      if (mem_read == 1) 
          read_data <= memData[address[11:2]];
    end
    
endmodule