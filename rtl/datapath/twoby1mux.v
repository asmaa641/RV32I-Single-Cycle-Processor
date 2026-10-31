module twoby1mux (
    input [31:0] A,
    input [31:0] B,
    input L,
    output [31:0] C
);

assign C = L ? B : A;

endmodule

