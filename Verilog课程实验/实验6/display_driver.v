`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/12/19 18:37:40
// Design Name: 
// Module Name: display_driver
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module display_driver(clk_in, input_data, segment_enable, segment_display);
    input clk_in;
    input [15:0] input_data;
    output [3:0] segment_enable;
    output [7:0] segment_display;

    // ----------------------------------------------------------
    // Frequency Divider
    integer counter; 
    reg clk_divided;
    always @(posedge clk_in) 
    if (counter == 32'd100000) begin
        counter <= 1'b0; 
        clk_divided <= ~clk_divided;
    end else begin
        counter <= counter + 1'b1;
    end
    // ----------------------------------------------------------

    // Segment Enable Control
    reg [3:0] enable_ctrl = 4'b1110; 
    always @(posedge clk_divided)
        enable_ctrl <= {enable_ctrl[2:0], enable_ctrl[3]};

    // Segment Value Selection
    reg [3:0] segment_value;
    always @(enable_ctrl) 
    case (enable_ctrl)
        4'b1110: segment_value = input_data[3:0]; 
        4'b1101: segment_value = input_data[7:4]; 
        4'b1011: segment_value = input_data[11:8];
        4'b0111: segment_value = input_data[15:12]; 
        default: segment_value = 4'hF; 
    endcase

    // Segment Data Mapping
    reg [7:0] segment_data;
    always @(segment_value) 
    case (segment_value) 
        4'h0: segment_data = 8'b0011_1111; // 0
        4'h1: segment_data = 8'b0000_0110; // 1
        4'h2: segment_data = 8'b0101_1011; // 2
        4'h3: segment_data = 8'b0100_1111; // 3
        4'h4: segment_data = 8'b0110_0110; // 4
        4'h5: segment_data = 8'b0110_1101; // 5
        4'h6: segment_data = 8'b0111_1101; // 6
        4'h7: segment_data = 8'b0000_0111; // 7
        4'h8: segment_data = 8'b0111_1111; // 8
        4'h9: segment_data = 8'b0110_1111; // 9
        default: segment_data = 8'b0011_1111; // Default to 0
    endcase

    // Outputs
    assign segment_enable = ~enable_ctrl;
    assign segment_display = segment_data;
endmodule
