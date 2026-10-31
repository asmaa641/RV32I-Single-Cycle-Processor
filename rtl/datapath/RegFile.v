module RegFile #(parameter N = 32) (
input clk, rst, input [4:0] readreg1, readreg2, writereg,
input [N-1:0] writedata, input regwrite, output [31:0] readdata1, readdata2 );
wire [31:0] q [0:N-1];
 reg [31:0] load;

always @(*) // load=1<<writereg;
begin
load=32'd0;
 if(regwrite == 1 && writereg != 5'd0)
load[writereg]=1'b1;
end
genvar j;
generate 
for(j = 0; j < 32; j =j +1)
begin 
register register(.D(writedata), .L(load[j]),.clk(clk),.rst(rst),.Q(q[j]));
end 
endgenerate

assign readdata1=q[readreg1];
assign readdata2=q[readreg2];

endmodule

