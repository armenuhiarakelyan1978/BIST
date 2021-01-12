module memory
#(parameter a_width = 4,
parameter width = 4)
(output [width-1:0] data_out,
input [width-1:0] data_in,
input read,
input write,
input [a_width-1:0] address,
input clk,
input rst);
reg [width-1:0] memory [a_width-1:0];
reg [width-1:0] data_out_r;

always@(posedge clk or posedge rst)
begin
	if(rst)
		data_out_r = 0;
	else if(write && !read)
		memory[a_width] <= data_in;
       else if (read && !write)
               data_out <= memory[address];
end

assign data_out = data_out_r;


