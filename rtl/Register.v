
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

            twoby1mux mux_inst (
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
