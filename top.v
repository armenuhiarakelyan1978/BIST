`include "comparator.v"
`include "controller.v"
`include "memory.v"
`include "address_generator.v"
`include "data_generator.v"



module top(output fail,
output done,
input clk,
input rst,
input start);

parameter a_width = 4;
parameter width = 4;

wire [a_width-1:0] address;
wire reset;
wire preset;
wire en;
wire up_down;
wire carry;
wire read;
wire write;
wire [width-1:0] data_out;
wire [width-1:0] data_in;
wire is_equal;
wire in;
wire [width-1:0] data_comp;


address_generator #(.a_width(a_width)) add_gen(
.clk(clk),
.reset(reset),
.address(address),
.preset(preset),
.en(en),
.up_down(up_down),
.carry(carry));

controller cont(.clk(clk),
.reset(reset),
.preset(preset),
.en(en),
.up_down(up_down),
.out(out),
.fail(fail),
.read(read),
.write(write),
.done(done),
.rst(rst),
.start(start),
.carry(carry),
.is_equal(is_equal));

memory #(.a_width(a_width), .width(width)) mem(
.data_out_in(data_out),
.read(read),
.write(write),
.address(address),
.clk(clk)
);

comparator comp(.data_in1(data_comp),
.read(read),
.data_in2(data_out),
.is_equal(is_equal));

data_generator #(.width(width)) data_gen(.data_in(out),
.data_out(data_out),.write(write), .data_comp(data_comp));


endmodule
