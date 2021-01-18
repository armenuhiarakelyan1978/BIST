module address_generator
#(parameter a_width = 4)
(
	output reg [a_width-1:0] address,
	output reg carry,
	input clk,
	input reset,
	input preset,
	input en,
	input up_down);

always@(posedge clk)
begin
	carry <= 0;
	if(reset)begin
		address <=0;
	end 
	else if (preset)begin
		address <= { a_width{1'b1}};
	end 
	else if(en && up_down)begin
		address <= address + 1;    
		if(address == {a_width{1'b1}}-1)
		begin
			carry <= 1;
		end
	end
	else if (en && ~up_down)begin
		address <= address - 1;
		if(address == 1)begin
			carry <= 1;
		end
	end

end

endmodule
