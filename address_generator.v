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
assign carry = address;
always@(posedge clk)
begin
if(reset)begin
		address <=0;
end else 
     if (preset)begin
		address <= {a_width{1'b1}};        
	end else    
         if(en)
	begin
			if(up_down== 1)
			begin
				address <= address + 1;
			end
			else begin
				address <= address - 1;
			end
	end
end
endmodule
