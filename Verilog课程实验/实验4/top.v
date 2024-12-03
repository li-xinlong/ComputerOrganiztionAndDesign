`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/11/28 21:58:00
// Design Name: 
// Module Name: top
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

module top (
    input clk_in,         // 输入时钟
    input reset,          // 重置信号
    input [31:0] binary_input, // 32位二进制输入
    output [5:0] count_zeros,  // 统计0的次数
    output [5:0] count_ones,   // 统计1的次数
    output clk_out ,       // 分频后的时钟输出
    output [3:0]count     // 用于分频器的计数信号
);


    // 实例化divider10模块
    divider10 div (
        .clk_in(clk_in),
        .reset(reset),
        .clk_out(clk_out),
        .count(count)
    );

    // 实例化CountZeroOne模块
    CountZeroOne counter (
        .binary_input(binary_input),
        .count_zeros(count_zeros),
        .count_ones(count_ones)
    );

endmodule

