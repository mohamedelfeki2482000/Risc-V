module mux_4x1 #(parameter length=32 )(
input [length-1:0]in1,in2,in3,
input [1:0] sel,
output reg [length-1:0]out 
);

always @(*) begin
case (sel)
2'b00: out = in1;
2'b01: out = in2;
2'b10: out = in3;   
default: out = in1;
endcase    
end
endmodule 