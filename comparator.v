module comparator
#(parameter width = 4)(
output is_equal,
input [width-1:0] data_in1,
input [width-1:0] data_in2);
assign is_equal = (data_in1 === data_in2)?1:0;
endmodule
