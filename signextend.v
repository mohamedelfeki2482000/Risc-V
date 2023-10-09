module signextend (

input wire [31:0] instr ,
input [1:0] immsrc,
output reg [31:0] signlmm

);

always @(*)
    begin 
        case (immsrc)
        2'b00: signlmm = {{20{instr[31]}} , instr[31:20]};
        2'b01: signlmm = {{20{instr[31]}}, instr[31:25], instr[11:7]};
        2'b10: signlmm = {{20{instr[31]}}, instr[7], instr[30:25], instr[11:8], 1'b0};
        2'b11: signlmm =  {{12{instr[31]}}, instr[19:12], instr[20], instr[30:21], 1'b0};
        default: signlmm = 32'h00000000;
        endcase
    
    end

endmodule 
