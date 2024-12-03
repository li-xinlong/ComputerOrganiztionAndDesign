`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/11/28 21:55:20
// Design Name: 
// Module Name: divider10
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

module divider10 (
    input clk_in,       // 输入时钟信号
    input reset,        // 重置信号
    output reg [3:0] count, // 计数器，取值范围0~10
    output reg clk_out  // 输出十分频后的时钟信号
);

    always @(posedge clk_in or posedge reset) begin
        if (reset) begin
            count <= 4'b0;       // 复位时，计数器清零
            clk_out <= 1'b1;     // 初始化 clk_out 为 1
        end else begin
            if (count == 4'd10) begin
                count <= 4'b0;   // 计数器到 10 时清零
                clk_out <= 1'b1; // clk_out 从 0 变为 1
            end else if (count == 4'd5) begin
                clk_out <= 1'b0; // 计数器到 5 时 clk_out 从 1 变为 0
                count <= count + 1;
            end else begin
                count <= count + 1; // 计数器递增
            end
        end
    end
endmodule

