module top_module (
    input wire clk,             // System clock
    input wire [3:0] sw,        // Switch inputs
    output wire [3:0] led,      // LED outputs
    output [7:0] an,            // Anode control for 8 displays
    output [6:0] seg            // 7-segment display segments
);

    reg [31:0] hex_values;       // 8-digit hex display data
    reg [3:0] led_reg;           // Internal register for LED states

    always @(posedge clk) begin
        case (sw)
            4'b0001: begin
                led_reg <= 4'b0001;
                hex_values <= 32'h0D0E0F10; // Display "0D0E0F10"
            end
            4'b0010: begin
                led_reg <= 4'b0010;
                hex_values <= 32'h01020304; // Display "01020304"
            end
            4'b0100: begin
                led_reg <= 4'b0100;
                hex_values <= 32'h000D001C; // Display "000D001C"
            end
            4'b1000: begin
                led_reg <= 4'b1000;
                hex_values <= 32'h002D0040; // Display "002D0040"
            end
            default: begin
                led_reg <= 4'b0000;
                hex_values <= 32'h00000000; // Default to blank display
            end
        endcase
    end

    // Internal wire to pass display data
    wire [3:0] led_internal;

    // Instantiate the seven-segment display module
    seven_segment_display display_unit (
        .clk(clk),
        .sw(sw),
        .an(an),
        .led(led_internal),   // Connect internal LED wire
        .seg(seg)
    );

    // Assign LED output from internal register
    assign led = led_reg;  // ? Fix: Correctly assigning led_reg to led

endmodule