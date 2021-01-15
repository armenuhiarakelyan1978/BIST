module address_generator
#(parameter a_width = 4)
(
	output reg [a_width-1:0] address,
	output carry,
	input clk,
	input reset,
	input preset,
	input en,
	input up_down);

reg carry_r, carry_r_i;
assign carry = carry_r;

always@(posedge clk)
begin
	carry_r <= 0;
if(reset)begin
		address <=0;
end else
     if (preset)begin
		address <= { a_width{1'b1}};
	end else    
	if(en && up_down)begin
                                address <= address + 1;    
				if(address == {a_width{1'b1}}-1)
				begin
					carry_r <= 1;
				end
			end
	else if (en && ~up_down)begin
			address <= address - 1;
			if(address == 1)begin
				carry_r <= 1;
			end
		end

end
always@(posedge clk)
begin
	if(reset)begin
		carry_r_i <= 0;
	end
	else begin
		carry_r_i <= carry_r;
	end
end

endmodule
