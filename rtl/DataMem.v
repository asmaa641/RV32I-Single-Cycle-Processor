`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/29/2026 02:43:11 PM
// Design Name: 
// Module Name: dataMem
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module DataMem(input clk, input MemRead, input MemWrite, input [2:0] funct3,
input [31:0] addr, input [31:0] data_in, output reg [31:0] data_out);

reg [31:0] mem [0:63];
wire [5:0] word_index;
wire [1:0] byte_offset;

assign word_index = addr[7:2];
assign byte_offset = addr[1:0];

// do synchronous write
always@(posedge clk)
begin
    if(MemWrite == 1'b1) begin
	case (funct3)
		3'b000: begin // sb
        case (byte_offset)
            2'b00: mem[word_index][7:0] <= data_in[7:0]; 
            2'b01: mem[word_index][15:8] <= data_in[7:0]; 
            2'b10: mem[word_index][23:16] <= data_in[7:0]; 
            2'b11: mem[word_index][31:24] <= data_in[7:0];
        endcase
        end
		3'b001: begin //sh
        case (byte_offset)
            2'b00: mem[word_index][15:0] <= data_in [15:0];
            2'b10: mem[word_index][31:16] <= data_in [15:0]; 
	       default: begin // do nothing
	       end
	    endcase
        end
		3'b010: begin
if (byte_offset == 2'b00)
       			 mem[word_index] <= data_in;  // sw
		end
        default: begin // do nothing
		end
endcase
end
end

//do combinational read
	always@(*) begin
	       data_out = 32'b0;
		if(MemRead == 1'b1) begin
	       case (funct3) 
	          3'b000: begin // lb
                case (byte_offset)
                    2'b00: data_out = {{24{mem[word_index][7]}},mem[word_index][7:0]}; // lb
                    2'b01: data_out =  {{24{mem[word_index][15]}},mem[word_index][15:8]}; 
                    2'b10: data_out =  {{24{mem[word_index][23]}},mem[word_index][23:16]}; 
                    2'b11: data_out =  {{24{mem[word_index][31]}},mem[word_index][31:24]}; 
		        endcase
	          end
	          3'b001: begin // lh
	            case (byte_offset)
	               2'b00: data_out = {{16{mem[word_index][15]}}, mem[word_index][15:0]}; 
	               2'b10: data_out = {{16{mem[word_index][31]}}, mem[word_index][31:16]}; 
	            endcase
	           end
	          3'b010: data_out = mem[word_index]; //lw
	          3'b100: begin  // lbu
	          case (byte_offset)
                    2'b00: data_out = {24'b0,mem[word_index][7:0]}; // lbu
                    2'b01: data_out =  {24'b0,mem[word_index][15:8]}; 
                    2'b10: data_out =  {24'b0,mem[word_index][23:16]}; 
                    2'b11: data_out =  {24'b0,mem[word_index][31:24]}; 
		        endcase
	          end
	          3'b101: begin //lhu
	          case(byte_offset)
                    2'b00: data_out = {16'b0,mem[word_index][15:0]}; // lhu
                    2'b10: data_out =  {16'b0,mem[word_index][31:16]}; 
                    
		        endcase
	         end
	 endcase
	end
	end
   endmodule



