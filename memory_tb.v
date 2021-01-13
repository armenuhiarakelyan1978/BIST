`timescale 1ns/1ns
`include "memory.v"

module memory_tb;
parameter width = 2;
parameter a_width = 4;

reg [width-1:0] data_in;
wire [width-1:0] data_out;
reg read;
reg write;
reg [a_width-1:0] address;
reg clk;
reg rst;
integer i;


memory #(.a_width(4), .width(2)) mm(.clk(clk),
.rst(rst), .address(address), .write(write),
.read(read), .data_in(data_in), .data_out(data_out));

always #5 clk = ~ clk;

initial
begin
	clk = 0;
	rst = 1;
	read = 0;
	write = 0;
	address = 0;
	data_in = 0;
end
initial
begin
repeat(2) @(posedge clk);

rst = 0;
for( i = 0; i < 2**a_width; i = i + 1)begin
        @(negedge clk)   address <= i; write <=1; data_in <= 1;  
end
write = 0;

for (i = 0; i < 2**a_width; i = i + 1)begin
 @(negedge clk) address <= i; read <=1;  
end

#100 $finish;
end
initial
begin
	$dumpfile("memory_tb.vcd");
	$dumpvars();

end
 

endmodule
