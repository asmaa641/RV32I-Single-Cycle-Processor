module instMem (input [31:0] addr, output [31:0] data_out);
reg [31:0] mem [0:63];

assign data_out = mem[addr[7:2]];

endmodule
