`timescale 1ns/1ns
module controller(output reg out,
output reg reset,
output reg preset,
output reg en,
output reg up_down,
output reg fail,
output reg read,
output reg write,
output reg done,
input clk,
input rst,
input start,
input carry,
input is_equal
);


reg [2:0] state, next_state;


parameter [2:0] RST = 3'b000,
                 W0 = 3'b001,
                 R0 = 3'b010,
                 W1 = 3'b011,
                 R1 = 3'b100;

always@( posedge clk or posedge rst)
begin
	if(rst)begin
		state <= RST;
	end
	else begin
	        state <= next_state;
	
	end
end
always@(state)
begin
#1;
	case(state)
		RST:begin
			out     = 0;
			reset   = 1;
			preset  = 0;
                        en      = 0;
			up_down = 0; 
                        fail    = 0;
			read    = 0;
			write   = 0;
                        done    = 0;

		end
		W0:begin

			out     = 0;
			reset   = 0;
			preset  = 0;
                        en      = 1;
			up_down = 1; 
                        fail    = 0;
			read    = 0;
			write   = 1;
                        done    = 0;
		end
		R0:begin
			
			out     = 0;
			reset   = 0;
			preset  = 0;
                        en      = 1;
			up_down = 0; 
			read    = 1;
			write   = 0;
                        done    = 0;
		end
		W1:begin 

			out     = 1;
			reset   = 0;
			preset  = 0;
                        en      = 1;
			up_down = 1; 
                        fail    = 0;
			read    = 0;
			write   = 1;
                        done    = 0;
		end
		R1:begin

			out     = 1;
			reset   = 0;
			preset  = 0;
                        en      = 1;
			up_down = 1; 
			read    = 1;
			write   = 0;
                        done    = 1;
		end
	endcase
end
always@(*)
begin
	case(state)
		RST:begin
			if(start == 1)begin
				next_state = W0;
			end
			else begin
				next_state = RST;
			end
		end
		W0:begin
			if(carry == 1)begin
				next_state = R0;
			end
			else begin
				next_state = W0;
			end
		end
		R0:begin
			if(carry == 1)begin
				next_state = W1;
			end
			else begin
				next_state = R0;
			end
		end
		W1:begin
			if(carry == 1)begin
				next_state = R1;
			end
			else begin
				next_state = W1;
			end
		end
		R1:begin
			if(carry == 1)begin
				next_state = RST;
			end
			else begin
				next_state = R1;
			end
		end
	endcase
end

always@(*)
begin
if(state == R0 || state == R1 )
begin
	if(is_equal)
	begin
		fail = 0;
	end
	else begin
		fail = 1;
	end

end	
end

endmodule
