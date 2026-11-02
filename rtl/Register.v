/*******************************************************************
*
* Module: Register
* Project: RISCV Processor
* Author: Asmaa Elshabshiri
* Emails: asmaaelshabshiri@aucegypt.edu
* Description: Register implementation for register file and pc
*
* Change history: 10/29/2026 = Edited for clarity and bit lengths
*
**********************************************************************/
module Register (
    input [31:0] D,
    input L,
    input clk,
    input rst,
    output [31:0] Q
);

    wire [31:0] muxoutput;

    genvar j;
    generate
        for (j = 0; j < 32; j = j + 1) begin : genmodule

            TwoBy1Mux mux_inst (
                .A(Q[j]),
                .B(D[j]),
                .S(L),
                .C(muxoutput[j])
            );

            DFlipFlop dff_inst (
                .clk(clk),
                .rst(rst),
                .D(muxoutput[j]),
                .Q(Q[j])
            );

        end
    endgenerate

endmodule
