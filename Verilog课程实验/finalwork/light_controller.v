`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/12/12 20:53:49
// Design Name: 
// Module Name: light_controller
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


module light_controller(
    input [1:0] state,     // ◊¥Ã¨ ‰»Î
    input blink,           // …¡À∏–≈∫≈
    output reg red,        // ∫Ïµ∆
    output reg green,      // ¬Ãµ∆
    output reg yellow      // ª∆µ∆
);
    always @(*) begin
        case (state)
            2'b00: {red, green, yellow} = 3'b100; // ∫Ïµ∆¡¡
            2'b01: {red, green, yellow} = blink ? 3'b000 : 3'b010; // ¬Ãµ∆…¡À∏
            2'b10: {red, green, yellow} = 3'b001; // ª∆µ∆¡¡
            default: {red, green, yellow} = 3'b000; // ƒ¨»œœ®√
        endcase
    end
endmodule
