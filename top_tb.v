`timescale 1ns/1ns
module top_tb;
reg clk;
reg rst;
reg start;
wire fail;
wire done;

top tp(.clk(clk),
.rst(rst),
.start(start),
.fail(fail),
.done(done));


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
	$dumpfile("top_tb.vcd");
	$dumpvars();

end

initial
begin
	#15; rst = 0;
	#4; start = 1;
	#15; start = 0;
	#1500 $finish;



end


endmodule
