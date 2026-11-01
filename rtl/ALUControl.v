`include "defines.v"

module ALUControl(input [2:0] ALUOp, input [2:0] funct3, input inst30, input lui, output reg [3:0] ALUSel);

always@(*) begin

case (ALUOp)

`ALUOP_ADD: ALUSel = `ALU_ADD;
`ALUOP_SUB: ALUSel = `ALU_SUB;
`ALUOP_PASS: ALUSel = `ALU_PASS;
`ALUOP_R,

`ALUOP_I: begin

case (funct3)

`F3_ADD: begin
//only r type add/sub uses inst[30]. For addi its just an imm bit
if ((ALUOp == `ALUOP_R) && (inst30 == 1'b1))
ALUSel = `ALU_SUB;
else ALUSel = `ALU_ADD;
end

`F3_SLL: ALUSel = `ALU_SLL;
`F3_SLT: ALUSel = `ALU_SLT;
`F3_SLTU: ALUSel = `ALU_SLTU;
`F3_XOR: ALUSel = `ALU_XOR;

`F3_SRL: begin
//srl/sra: inst[30] picks
if (inst30 == 1'b1)
ALUSel = `ALU_SRA;
else
ALUSel = `ALU_SRL;
end

`F3_OR: ALUSel = `ALU_OR;
`F3_AND: ALUSel = `ALU_AND;
default:  ALUSel = `ALU_ADD;

endcase

if (lui == 1'b1)
ALUSel = `ALU_PASS;

end

default: ALUSel = `ALU_ADD;
endcase
end

endmodule
