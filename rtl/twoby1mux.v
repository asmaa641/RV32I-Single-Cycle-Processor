module twoby1mux (
    input [31:0] A,
    input [31:0] B,
    input S,
    output [31:0] C
);

assign C = S ? B : A;

endmodule

