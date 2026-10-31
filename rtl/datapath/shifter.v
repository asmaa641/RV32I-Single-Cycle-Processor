`include "defines.v"

module shifter (input [31:0] a, input [4:0]  shamt, input [1:0] type, output reg [31:0] r);

always @(*) begin
case (type)
`SH_SRL: r = a >> shamt;
`SH_SLL: r = a << shamt;
`SH_SRA: r = $signed(a) >>> shamt;
default: r = a;
endcase
end

endmodule
