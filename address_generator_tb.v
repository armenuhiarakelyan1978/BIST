`include "address_generator.v"
`timescale 1ns/1ns


module address_generator_tb;
reg clk;
reg preset;
reg reset;
reg up_down;
reg en;
wire carry;
wire [3:0] address;

address_generator #(.a_width(4)) add_gen(.clk(clk),
.reset(reset),
.en(en),
.preset(preset),
.carry(carry),
.address(address),
.up_down(up_down));

initial
begin
	clk = 0;
	reset = 1;
	en = 0;
	preset = 0;

end
always
begin
	#5  clk = ~clk;
end
initial
begin
	#15 reset = 0;
        #35 preset = 1;
        #50 reset = 1;
        #11 reset = 0;	preset = 0;
	#12 up_down =1;
        #12  en = 1;
	#1050 up_down = 0; en = 1;
	#3050 $finish;
end

initial
begin
	$dumpfile("address_generator_tb.vcd");
	$dumpvars();
end
endmodule
