`include "address_generator.v"
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
input start
);

parameter a_width = 4;

reg [2:0] state, next_state;
wire [a_width-1:0] address;


localparam RST = 3'b000;
localparam W0 = 3'b001;
localparam R0 = 3'b010;
localparam W1 = 3'b011;
localparam R1 = 3'b100;

address_generator #(.a_width(a_width)) add_gen(
.clk(clk),
.reset(reset),
.preset(preset),
.en(en),
.up_down(up_down),
.address(address),
.carry(carry));


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
			reset   = 1;
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

/*always@(*)
begin
if(state == R0 || state == R1 || state == W0 || state == W1)
begin
	if(re)

end	

end*/




endmodule
