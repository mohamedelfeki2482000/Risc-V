module alu (
input wire [31:0] srcA,srcB,
output reg [31:0] AluResult ,
input wire [2:0] sel,
input wire reset, 
output wire zero
);

always @(*)
    begin 
        if (!reset)
        begin 
            AluResult=32'h00000000;
        end
        else
            begin
                case (sel)
                3'b010:AluResult =srcA & srcB;
                3'b011:AluResult =srcA | srcB;
                3'b000:AluResult =srcA + srcB;
                3'b001:AluResult =srcA - srcB;
                3'b101:AluResult =(srcA<srcB)? 1: 0;
                default: AluResult =32'h00000000 ;

                endcase

            end
    end
    
assign zero=(AluResult==0)? 1: 0;

endmodule 
