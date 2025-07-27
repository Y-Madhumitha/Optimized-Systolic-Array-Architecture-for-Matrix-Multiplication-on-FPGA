// Updated systolic_array.v
module systolic_array #(parameter DATA_WIDTH = 8, SIZE = 4) (
    input clk,
    input rst,
    input signed [DATA_WIDTH*SIZE*SIZE-1:0] a_in,  // Corrected width for a_in
    input signed [DATA_WIDTH*SIZE*SIZE-1:0] b_in,  // Corrected width for b_in
    output signed [2*DATA_WIDTH*SIZE*SIZE-1:0] result  // Corrected width for result
);

wire signed [DATA_WIDTH-1:0] a [0:SIZE-1][0:SIZE-1];
wire signed [DATA_WIDTH-1:0] b [0:SIZE-1][0:SIZE-1];
wire signed [2*DATA_WIDTH-1:0] accum [0:SIZE-1][0:SIZE-1];

// Unpacking input vectors
generate
    genvar i, j;
    for (i = 0; i < SIZE; i = i + 1) begin
        for (j = 0; j < SIZE; j = j + 1) begin
            assign a[i][j] = a_in[(i * SIZE + j) * DATA_WIDTH +: DATA_WIDTH];
            assign b[i][j] = b_in[(i * SIZE + j) * DATA_WIDTH +: DATA_WIDTH];
        end
    end
endgenerate

// Instantiating Processing Elements
generate
    for (i = 0; i < SIZE; i = i + 1) begin
        for (j = 0; j < SIZE; j = j + 1) begin
            if (i == 0) begin
                processing_element #(.DATA_WIDTH(DATA_WIDTH)) pe (
                    .clk(clk), .rst(rst),
                    .a_in(a[i][j]), .b_in(b[i][j]),
                    .accum_in(0),  // For the first row, accum_in is 0
                    .accum_out(accum[i][j])
                );
            end else begin
                processing_element #(.DATA_WIDTH(DATA_WIDTH)) pe (
                    .clk(clk), .rst(rst),
                    .a_in(a[i][j]), .b_in(b[i][j]),
                    .accum_in(accum[i-1][j]),  // For other rows, pass previous accum
                    .accum_out(accum[i][j])
                );
            end
        end
    end
endgenerate

// Packing results
generate
    for (i = 0; i < SIZE; i = i + 1) begin
        for (j = 0; j < SIZE; j = j + 1) begin
            assign result[(i * SIZE + j) * 2 * DATA_WIDTH +: 2 * DATA_WIDTH] = accum[i][j];
        end
    end
endgenerate

endmodule