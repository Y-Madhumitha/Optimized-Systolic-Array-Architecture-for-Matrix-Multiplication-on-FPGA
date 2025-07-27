// Updated systolic_array_tb.v
`timescale 1ns / 1ps

module systolic_array_tb();

parameter DATA_WIDTH = 8;
parameter SIZE = 4;

reg clk, rst;
reg signed [DATA_WIDTH*SIZE-1:0] a_in, b_in;
wire signed [2*DATA_WIDTH*SIZE-1:0] result;

systolic_array #(.DATA_WIDTH(DATA_WIDTH), .SIZE(SIZE)) uut (
    .clk(clk), .rst(rst),
    .a_in(a_in), .b_in(b_in),
    .result(result)
);

// Clock generation
always #5 clk = ~clk;

initial begin
    // Test initialization
    clk = 0;
    rst = 1;
    #10 rst = 0;

    // Test input
    a_in = {8'd9, 8'd10, 8'd11, 8'd12, 8'd5, 8'd6, 8'd7, 8'd8, 8'd1, 8'd2, 8'd3, 8'd4, 8'd13, 8'd14, 8'd15, 8'd16};
    b_in = {8'd13, 8'd14, 8'd15, 8'd16, 8'd9, 8'd10, 8'd11, 8'd12, 8'd5, 8'd6, 8'd7, 8'd8, 8'd1, 8'd2, 8'd3, 8'd4};
    
    #100;

    // Additional test cases can be added here

    $finish;
end

endmodule