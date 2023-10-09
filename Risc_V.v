module Risc_V (
input clk,reset 
);
wire [31:0] pc,pc_in;
wire [2:0] alucontrol ;
wire [1:0] resultsrc,immsrc;
wire memwrite ,branch ,alusrc ,regwrite, jump;
wire zero;
wire [31:0] result;
wire [31:0] srcA,read_data2;
wire [31:0] srcB;
wire [31:0] AluResult ;
wire [31:0] signlmm;
wire[31:0] read_data;
wire [31:0] pcplus4;
wire [31:0] instr ;
wire [31:0] pcbranch;

pc prog_coun (
.clk(clk),
.reset(reset),
.pc(pc),
.pc_in(pc_in)
);

instr_mem instr_memory (
.pc(pc),
.instr(instr)
);


ControlUnit control_unit (
.opcode(instr[6:0]) ,
.funct3(instr[14:12]) ,
.funct7(instr[30]),
.immsrc(immsrc) ,
.memwrite(memwrite) ,
.branch(branch) ,
.alusrc(alusrc) ,
.resultsrc(resultsrc) ,
.regwrite(regwrite) ,
.alucontrol(alucontrol) ,
.jump(jump)
);

reg_file regster_file (
.a1(instr[19:15]),
.a2(instr[24:20]),
.a3(instr[11:7]),
.write_data(result),
.clk(clk),
.reset(reset) ,
.write_enable(regwrite),
.read_data1(srcA),
.read_data2(read_data2)
);


alu alu_ (
.srcA(srcA),
.srcB(srcB),
.AluResult(AluResult) ,
.sel(alucontrol),
.reset(reset), 
.zero(zero)
);

signextend sign_ex (
.instr(instr),
.immsrc(immsrc),
.signlmm(signlmm)
);

adder adder1 (
.a(signlmm),
.b(pc),
.c(pcbranch)
);

adder adder2 (
.a(pc),
.b(32'd4),
.c(pcplus4)
);


mux #(.length(32)) mux1(
.in1(pcplus4),
.in2(pcbranch),
.sel(pcsrc),
.out(pc_in)
);

mux #(.length(32)) mux2 (
.in1(read_data2),
.in2(signlmm),
.sel(alusrc),
.out(srcB) 
);



 

data_mem data_memory (
.add(AluResult) ,
.write_data(read_data2),
.clk(clk) ,
.write_enable(memwrite),
.reset(reset),
.read_data(read_data) 
);


mux_4x1 #(.length(32)) mux3(
.in1(AluResult),
.in2(read_data),
.in3(pcplus4),
.sel(resultsrc),
.out(result)
);
assign pcsrc=(branch&zero)|jump;

endmodule 