`include "defines.v"

module branchUnit(input branch, jal, jalr, input [2:0] funct3, input cf, zf, vf, sf, output reg [1:0] PCSel);

reg taken;

always @(*) begin

case (funct3)
//branch condition from the flags of rs1 - rs2
`BR_BEQ: taken = zf;
`BR_BNE: taken = ~zf;
`BR_BLT: taken = (sf != vf);
`BR_BGE: taken = (sf == vf);
`BR_BLTU: taken = ~cf;
`BR_BGEU: taken = cf;
default: taken = 1’b0;

endcase

//next PC source: jalr has priority, then jal, then branch
if (jalr == 1’b1)
PCSel = `PC_JALR;
else if (jal == 1’b1)
PCSel = `PC_TARGET;
else if ((branch == 1’b1) && (taken == 1’b1))
PCSel = `PC_TARGET;
else
PCSel = `PC_PLUS4;

end

endmodule
