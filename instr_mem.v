module instr_mem (
input [31:0] pc,
output reg [31:0] instr 
);

reg [31:0] mem [0:31]; 

initial begin
  $readmemh("Program2.txt",mem);  
end 

always @(*)
    begin 
        instr=mem[pc>>2];
    end 

endmodule
