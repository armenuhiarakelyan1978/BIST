module data_generator
#(parameter width = 4)(
output [width-1:0] data_out,
input data_in );

assign data_out = {width{data_in}};
endmodule
