/*******************************************************************
*
* Module: instMem
* Project: RISCV Processor
* Author: Asmaa Elshabshiri
* Emails: asmaaelshabshiri@aucegypt.edu
* Description: the instruction memory of the datapath 
*
* Change history: 10/29/2026 = edited the input bit length
* 11/1/2026 finished
*
**********************************************************************/


module InstMem (input [31:0] addr, output [31:0] data_out);
reg [31:0] mem [0:63];

assign data_out = mem[addr[7:2]];

endmodule
