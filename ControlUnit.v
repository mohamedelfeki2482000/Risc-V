module ControlUnit (
input wire [6:0] opcode,
input [2:0] funct3 ,
input funct7,
output reg regwrite , alusrc , memwrite , branch ,jump,
output reg [1:0] immsrc , resultsrc ,
output reg [2:0]  alucontrol
);
reg [1:0] aluop;

always @(*)
    begin 
        case(opcode)
        7'b0000011:begin
              aluop=00 ;memwrite=0 ;regwrite=1 ; immsrc=00 ;alusrc=1 ;resultsrc=01 ;branch=0 ; jump =0; 
              end
        7'b0100011:begin
              aluop=00 ;memwrite=1 ;regwrite=0 ; immsrc=01 ;alusrc=1 ;resultsrc=00/* xx */ ;branch=0 ; jump =0; 
              end
        7'b0110011:begin
              aluop=10 ;memwrite=0 ;regwrite=1 ; immsrc=00/* xx */ ;alusrc=0 ;resultsrc=00 ;branch=0 ;  jump =0;
              end
        7'b1100011:begin
              aluop=01 ;memwrite=0 ;regwrite=0 ; immsrc=10 ;alusrc=0 ;resultsrc=00/* xx */ ;branch=1 ;  jump =0;
              end
        7'b0010011:begin
              aluop=10 ;memwrite=0 ;regwrite=1 ; immsrc=00 ;alusrc=1 ;resultsrc=00 ;branch=0 ;  jump =0;
              end
        7'b1101111:begin
              aluop=00/*xx*/ ;memwrite=0 ;regwrite=1 ; immsrc=11 ;alusrc=0/* x */ ;resultsrc=10 ;branch=0 ; jump =1; 
              end
        
        default:   begin

              aluop=00 ;memwrite=0 ;regwrite=0 ; immsrc=00 ;alusrc=0 ;resultsrc=0 ;branch=0 ;  jump =0; 
              end
        
        endcase


        case(aluop)
        2'b00:alucontrol=3'b000;
        2'b01:alucontrol=3'b001;
        2'b10:case(funct3)
              3'b000:case({opcode[5],funct7}) 
                     2'b00 :  alucontrol=3'b000;
                     2'b01 : alucontrol=3'b000;
                     2'b10 : alucontrol=3'b000;
                     2'b11 : alucontrol = 3'b001; endcase 
              3'b010 : alucontrol = 3'b101;
              3'b110 : alucontrol = 3'b011;
              3'b111 : alucontrol = 3'b010;
               endcase

        default:alucontrol=3'b000;
        endcase
    end
endmodule 