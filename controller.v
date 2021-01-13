module controller(output out,
output reset,
output preset,
output en,
output up_down,
output fail,
output read,
output write,
output done,
input clk,
input rst,
input start,
input is_equal,
input carry
);

reg [2:0] state, next_state;

localparam RST = 3'b000;
localparam W0 = 3'b001;
localparam R0 = 3'b010;
localparam W1 = 3'b011;
localparam R1 = 3'b100;

always@(posedge clk or posedge rst)
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
		WO:begin

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
			preset  = 1;
                        en      = 1;
			up_down = 0; 
                        fail    = 0;
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
                        fail    = 1;
			read    = 1;
			write   = 0;
                        done    = 1;
		end
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
			if(carry = 1)begin
				next_state = R0;
			end
			else begin
				next_state = W0;
			end
		end
		R0:begin
			if(carry = 0)begin
				next_state = W1;
			end
			else begin
				next_state = R0;
			end
		end
		W1:begin
			if(carry = 1)begin
				next_state = R1;
			end
			else begin
				next_state = W1;
			end
		end
		R1:begin
			if(carry = 1)begin
				next_state = RST;
			end
			else begin
				next_state = R1;
			end
		end
end





endmodule
