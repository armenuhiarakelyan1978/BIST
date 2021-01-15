module memory
#(parameter a_width = 4,
parameter width = 4)
(inout [width-1:0] data_out_in,
	input read,
	input write,
	input [a_width-1:0] address,
	input clk
	);
reg [width-1:0] memory [((1<< a_width)-1):0];
always@(posedge clk )
begin
	 if(write)
		memory[address] <= data_out_in;
end


assign data_out_in = (read)?(memory[address]):{width{1'bz}};

endmodule
