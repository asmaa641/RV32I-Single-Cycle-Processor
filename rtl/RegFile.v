/*******************************************************************
*
* Module: regFile
* Project: RISCV Processor
* Author: Asmaa Elshabshiri
* Emails: asmaaelshabshiri@aucegypt.edu
* Description: The register file of the datapath
* Change history: 10/29/2026 = edited for clarity
*
**********************************************************************/
`include "defines.v"

module RegFile (
    input clk,
    input rst,
    input [4:0] readreg1,
    input [4:0] readreg2,
    input [4:0] writereg,
    input [31:0] writedata,
    input regwrite,
    output [31:0] readdata1,
    output [31:0] readdata2
);

    wire [31:0] q [0:31];
    reg [31:0] load;

    always @(*) begin
        load = 32'd0;

        if (regwrite && writereg != 5'd0)
            load[writereg] = 1'b1;
    end

    genvar j;
    generate
        for (j = 0; j < 32; j = j + 1) begin : register_array
            Register register_inst (
                .D(writedata),
                .L(load[j]),
                .clk(clk),
                .rst(rst),
                .Q(q[j])
            );
        end
    endgenerate

    assign readdata1 = q[readreg1];
    assign readdata2 = q[readreg2];

endmodule
