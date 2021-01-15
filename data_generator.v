module data_generator
#(parameter width = 4)(
inout [width-1:0] data_out,
input write,
input data_in,
output [width-1:0] data_comp);

assign data_out =(write)? {width{data_in}}:1'bz;
assign data_comp = data_out;
endmodule
