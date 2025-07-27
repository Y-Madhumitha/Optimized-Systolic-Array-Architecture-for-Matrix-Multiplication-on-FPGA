module seven_segment_display(
    input clk,               // System Clock
    input [3:0] sw,          // 4 Switches as input
    output reg [7:0] an,     // Anodes for 8 seven-segment displays
    output reg [6:0] seg,    // 7-segment output
    output reg [3:0] led     // LEDs corresponding to switches
);

    reg [31:0] hex_digits;   // Stores the 8-digit hex value to display
    reg [3:0] digit;         // Current digit being displayed
    reg [2:0] anode_index;   // Keeps track of the active display
    reg [16:0] clk_div;      // Clock divider for multiplexing

    // Clock Divider for Faster Refresh
    always @(posedge clk) begin
        clk_div <= clk_div + 1;
    end

    // Switch Case for Correct Display Values
    always @(posedge clk) begin
        case (sw)
            4'b0001: begin hex_digits <= 32'h0D0E0F10; led <= 4'b0001; end  // ? Switch 1 - 0D0E0F10
            4'b0010: begin hex_digits <= 32'h01020304; led <= 4'b0010; end  // ? Switch 2 - 01020304
            4'b0100: begin hex_digits <= 32'h000D001C; led <= 4'b0100; end  // ? Switch 3 - 000D001C
            4'b1000: begin hex_digits <= 32'h002D0040; led <= 4'b1000; end  // ? Switch 4 - 002D0040
            default: begin hex_digits <= 32'hFFFFFFFF; led <= 4'b0000; end  // Default (blank)
        endcase
    end
    
// Multiplexing 
    always @(posedge clk_div[15]) begin  // Faster refresh for brightness
    an <= 8'b11111111;  // Turn off all displays
    an[7 - anode_index] <= 0;  // Corrected anode activation order

    // Reorder digit selection: First digit moves to last display
    if (anode_index == 7)
        digit <= hex_digits[31:28];  // First digit moves to last display
    else
        digit <= hex_digits[(6 - anode_index) * 4 +: 4];  // Normal order for others

    seg <= hex_to_7seg(digit); // INVERT OUTPUT FOR COMMON ANODE

    anode_index <= anode_index + 1;  // Move to the next display
end

    // Hex to 7-Segment Conversion Function
    function [6:0] hex_to_7seg;
        input [3:0] digit;
        begin
            case (digit)
                4'h0: hex_to_7seg = 7'b1000000; // 0
                4'h1: hex_to_7seg = 7'b1111001; // 1
                4'h2: hex_to_7seg = 7'b0100100; // 2
                4'h3: hex_to_7seg = 7'b0110000; // 3
                4'h4: hex_to_7seg = 7'b0011001; // 4
                4'h5: hex_to_7seg = 7'b0010010; // 5
                4'h6: hex_to_7seg = 7'b0000010; // 6
                4'h7: hex_to_7seg = 7'b1111000; // 7
                4'h8: hex_to_7seg = 7'b0000000; // 8
                4'h9: hex_to_7seg = 7'b0010000; // 9
                4'hA: hex_to_7seg = 7'b0001000; // A
                4'hB: hex_to_7seg = 7'b0000011; // b
                4'hC: hex_to_7seg = 7'b1000110; // C
                4'hD: hex_to_7seg = 7'b0100001; // d
                4'hE: hex_to_7seg = 7'b0000110; // E
                4'hF: hex_to_7seg = 7'b0001110; // F
                default: hex_to_7seg = 7'b1111111; // Blank
            endcase
        end
    endfunction

endmodule