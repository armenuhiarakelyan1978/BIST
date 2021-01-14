module memory
#(parameter a_width = 4,
parameter width = 4)
(output [width-1:0] data_out,
	input [width-1:0] data_in,
	input read,
	input write,
	input [a_width-1:0] address,
	input clk
	);
reg [width-1:0] memory [a_width-1:0];
reg [width-1:0] data_out_r;

always@(posedge clk )
begin
	 if(write && !read)
		memory[address] <= data_in;
	else if (read && !write)
		data_out_r <= memory[address];
end

assign data_out = data_out_r;

endmodule
