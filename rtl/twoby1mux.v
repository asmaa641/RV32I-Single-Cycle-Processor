/*******************************************************************
*
* Module: TwoBy1Mux
* Project: RISCV Processor
* Author: Asmaa Elshabshiri
* Emails: asmaaelshabshiri@aucegypt.edu
* Description: the mux used in the data path
*
* Change history: 10/29/2026 = edited for clarity 

*
**********************************************************************/

module TwoBy1Mux (
    input [31:0] A,
    input [31:0] B,
    input S,
    output [31:0] C
);

assign C = S ? B : A;

endmodule

