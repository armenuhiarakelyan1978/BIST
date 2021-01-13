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
reg addr;
assign carry = (en && up_down && address=={a_width{1'b1}})?1:
	(en && ~up_down && address == 0)?0:1'bz;
always@(posedge clk)
begin
if(reset)begin
		address <=0;
end else 
     if (preset)begin
		address <= {a_width{1'b1}};        
	end else    
         if(en && up_down)

			if (address == {a_width{1'b1}})
			begin
				address <= 0;
			end
			else begin
				address <= address + 1;
			end
	else if (en && ~up_down)
		if(address == 0)begin
			address <= {a_width{1'b1}};
		end
		else begin
			address <= address - 1;
		end

end
endmodule
