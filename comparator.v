module comparator
#(parameter width = 4)(
output is_equal,
input [width-1:0] data_in1,
input [width-1:0] data_in2);
//wire data_in;
//assign data_in = (read)?data_in2:{width{1'bz}};
assign is_equal = (data_in1 === data_in2)? 1'b1:1'b0;
endmodule
