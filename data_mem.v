module data_mem (
input [31:0] add ,write_data,
input clk ,write_enable,reset,
output [31:0] read_data 
);
integer i;
reg [31:0] mem [0:31];

always @(posedge clk,negedge reset)
    begin 
        if (!reset)
            begin  
                for(i=0;i<32;i=i+1)  
                    mem[i] <= 32'h0000;  
            end 
        else if (write_enable)
            mem[add]<=write_data;
    end
        
assign read_data =mem[add];
endmodule 