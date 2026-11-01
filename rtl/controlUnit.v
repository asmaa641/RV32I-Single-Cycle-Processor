`include "defines.v"

module controlUnit (input [4:0] opcode, input [2:0] funct3, input inst20, output reg branch, output reg jal, output reg jalr, output reg lui, output reg memRead, output reg memWrite, output reg regWrite, output reg ALUASel, output reg ALUBSel, output reg [1:0] WBSel, output reg  [2:0] ALUOp, output reg halt);

always @(*) begin
//defaults
branch = 1'b0;
jal = 1'b0;
jalr = 1'b0;
lui = 1'b0;
memRead = 1'b0;
memWrite = 1'b0;
regWrite = 1'b0;
ALUASel = `ALU_A_RS1;
ALUBSel = `ALU_B_RS2;
WBSel = `WB_ALU;
ALUOp = `ALUOP_ADD;
halt = 1'b0;

case (opcode)
`OPCODE_Arith_R: begin
regWrite = 1'b1;
ALUOp = `ALUOP_R;
end

`OPCODE_Arith_I: begin
regWrite = 1'b1;
ALUBSel = `ALU_B_IMM;
ALUOp = `ALUOP_I;
end

`OPCODE_Load: begin
regWrite = 1'b1;
memRead = 1'b1;
ALUBSel = `ALU_B_IMM;
WBSel = `WB_MEM;
end

`OPCODE_Store: begin
memWrite = 1'b1;
ALUBSel = `ALU_B_IMM;
end

`OPCODE_Branch: begin
branch = 1'b1;
ALUOp = `ALUOP_SUB;
end

`OPCODE_JAL: begin
jal = 1'b1;
regWrite = 1'b1;
WBSel = `WB_PC4;
end

`OPCODE_JALR: begin
jalr = 1'b1;
regWrite = 1'b1;
ALUBSel = `ALU_B_IMM;
WBSel = `WB_PC4;
end

`OPCODE_LUI: begin
regWrite = 1'b1;
ALUBSel = `ALU_B_IMM;
lui = 1'b1;
end

`OPCODE_AUIPC: begin
regWrite = 1'b1;
ALUASel = `ALU_A_PC;
ALUBSel = `ALU_B_IMM;
end

`OPCODE_SYSTEM: begin
//EBREAK: funct3 = 0 and imm[0] (inst[20]) = 1
//ECALL (inst[20] = 0) stays a no-op
halt = ((funct3 == `SYS_EC_EB) && (inst20 == 1'b1));
end
default: begin
//FENCE / FENCE.TSO / PAUSE (MISC_MEM) and anything unknown: keep the no-op defaults
halt = 1'b0;
end
endcase
end

endmodule
