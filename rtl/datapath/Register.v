`include "defines.v"

module Register #(parameter N = 32) (
    input [N-1:0] D,
    input L,
    input clk,
    input rst,
    output [N-1:0] Q
);

wire [N-1:0] muxoutput;

genvar j;

generate
    for (j = 0; j < N; j = j + 1) begin: genmodule

        twoby1mux  m1(
            .A(Q[j]),
            .B(D[j]),
            .S(L),
            .C(muxoutput[j])
        );

        DFlipFlop D1(
            .clk(clk),
            .rst(rst),
            .D(muxoutput[j]),
            .Q(Q[j])
        );

    end
endgenerate

endmodule

