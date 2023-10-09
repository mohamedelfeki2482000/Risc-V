module reg_file(
input [4:0] a1,a2,a3,
input [31:0] write_data,
input clk,reset ,write_enable,
output [31:0] read_data1,read_data2
);
integer i;
reg [31:0] register [0:31];
always @(posedge clk ,negedge reset)
    begin 
        if (!reset)
            for(i=0 ;i<32;i=i+1) 
                register[i]<=32'h00000000;
            else if (write_enable)
                register[a3]<=write_data;
    end 

assign read_data1=register[a1];
assign read_data2=register[a2];
endmodule 