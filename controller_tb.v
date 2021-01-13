`timescale 1ns/1ns
module controller_tb.v;
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
.is_equal(is_equal),
.carry(carry),
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
	reset = 1;
	preset = 0;
	up_down = 0;
	en = 0;
	fail = 0;
	done = 0;
	clk = 0
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
	#3; rst = 0;
	#4; start = 0;
	carry = 0;

end


endmodule
