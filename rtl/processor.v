module top(input clk, 
input rst); 

// control wires
wire branch;
wire jal;
wire jalr;
wire memRead;
wire [2:0] ALUOp;
wire memWrite;
wire RegWrite;
wire ALUASel;
wire ALUBSel;
wire halt;
wire [1:0] WBSel;
wire [3:0] ALUSel;
wire cf;
wire zf;
wire vf;
wire sf;
wire [1:0] PCSel;

// data wires
wire [31:0] instruction_mem_data_out; 
wire [31:0] pcout;
wire [31:0] pcin;
wire [31:0] write_data;
wire [31:0] readdata1;
wire [31:0] readdata2;
wire[31:0] generatedImm;
wire [31:0] pcplus4;
wire [31:0] ALUinput1;
wire [31:0] ALUinput2;
wire [31:0] ALUResult;
wire [31:0] dataMemOut;

wire [31:0] targetAddress;
wire [31:0] dataMemOrALUMUXOutput;
wire [31:0] PCorDMorALUOutput;
wire [31:0] pc4OrtargetAddressOutput;
wire [31:0] jalRTarget;

// First step: PC Register
register pcdut (.D(pcin), .L(~halt), .clk(clk), .rst(rst), .Q(pcout)); 
// when halt is zero -> load = 1, updates pc

// PC to instruction memory
instMem im(.addr(pcout), .data_out(instruction_mem_data_out));


// Instruction to Control Unit
controlUnit control(.opcode(instruction_mem_data_out[`IR_opcode]), .funct3(instruction_mem_data_out[`IR_funct3]), .inst20(instruction_mem_data_out[20]), .branch(branch), .jal(jal), .jalr(jalr), .lui(lui), .memRead(memRead), .memWrite(memWrite), .regWrite(RegWrite), .ALUASel(ALUASel), .ALUBSel(ALUBSel), .WBSel(WBSel), .ALUOp(ALUOp), .halt(halt));

// instruction to register
RegFile register(.clk(clk), .rst(rst), .readreg1(instruction_mem_data_out[`IR_rs1]), .readreg2(instruction_mem_data_out[`IR_rs2]), .writereg(instruction_mem_data_out[`IR_rd]), .writedata(write_data), .regwrite(RegWrite), .readdata1(readdata1),.readdata2(readdata2));

// instruction to immediate generator
rv32_ImmGen immGen(.IR(instruction_mem_data_out), .Imm(generatedImm));


// ALUinput1
twoby1mux mux(.A(readdata1), .B(pcin), .L(ALUASel), .C(ALUinput1));
// ALUinput2
twoby1mux mux(.A(readdata2), .B(generatedImm), .L(ALUBSel), .C(ALUinput2));

// ALUControl
ALUControlUnit alucontrol(.ALUOp(ALUOp), .funct3(instruction_mem_data_out[`IR_funct3]),.inst30(instruction_mem_data_out[30]), .lui(lui), .ALUSel(ALUSel));

// ALU
prv32_ALU ALU(.a(ALUinput1), .b(ALUinput2), .shamt(instruction_mem_data_out[`IR_shamt]), .r(ALUResult), .cf(cf), .zf(zf), .vf(vf), .sf(sf), .alufn(ALUSel));

// ALU to DataMem
DataMem DataMem(.clk(clk), .MemRead(memRead), .MemWrite(memWrite), .funct3(instruction_mem_data_out[`IR_funct3]),
.addr(ALUResult), .data_in(readdata2), .data_out(dataMemOut));




twoby1mux dataMemOrALUMUX(.A(ALUResult), .B(dataMemOut), .L(WBSel[0]), .C(dataMemOrALUMUXOutput));

assign pcplus4 = pcout +4;
twoby1mux PCorDMorALU(.A(dataMemOrALUMUXOutput), .B(pcplus4), .L(WBSel[1]), .C(write_data));

assign targetAddress = pcout + generatedImm;

twoby1mux pc4OrtargetAddress(.A(pcplus4), .B(targetAddress), .L(PCSel[0]), .C(pc4OrtargetAddressOutput));

assign jalRTarget = {ALUResult[31:1], 1’b0};

twoby1mux pc4OrtargetAddress(.A(pc4OrtargetAddressOutput), .B(jalRTarget), .L(PCSel[1]), .C(pcin));

branchUnit branchU(.branch(branch), .jal(jal), .jalr(jalr), .funct3(instruction_mem_data_out[`IR_funct3]), .cf(cf), .zf(zf), .vf(vf), .sf(sf), .PCSel(PCSel));










endmodule
