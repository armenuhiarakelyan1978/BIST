`timescale 1ns/1ns
//`include "controller.v"
module controller_tb;
reg clk;
reg rst;
reg start;
reg is_equal;
reg carry;
wire out;
wire reset;
wire preset;
wire en;
wire up_down;
wire fail;
wire done;

controller cont(.clk(clk),
.rst(rst),
.start(start),
.out(out),
.reset(reset),
.preset(preset),
.en(en),
.up_down(up_down),
.fail(fail),
.done(done)
);

initial
begin
rst = 1;
clk = 0;
start = 0;
end
initial
begin
	forever # 5 clk = ~ clk;
end

initial
begin
	$dumpfile("controller_tb.vcd");
	$dumpvars();

end

initial
begin
	#15; rst = 0;
	#4; start = 1;
	#500 $finish;



end


endmodule
