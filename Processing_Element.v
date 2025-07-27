// Updated processing_element.v
module processing_element #(parameter DATA_WIDTH = 8) (
    input clk,
    input rst,
    input signed [DATA_WIDTH-1:0] a_in, b_in,
    input signed [2*DATA_WIDTH-1:0] accum_in,
    output reg signed [2*DATA_WIDTH-1:0] accum_out,
    output reg signed [DATA_WIDTH-1:0] a_out, b_out
);

always @(posedge clk or posedge rst) begin
    if (rst) begin
        accum_out <= 0;
        a_out <= 0;
        b_out <= 0;
    end else begin
        accum_out <= accum_in + a_in * b_in;
        a_out <= a_in;
        b_out <= b_in;
    end
end
endmodule