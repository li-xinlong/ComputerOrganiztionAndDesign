`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/12/26 03:15:06
// Design Name: 
// Module Name: display
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


module display(
    input clk_in,          // 输入时钟（如100 MHz）
    input rst,             // 重置信号
    output red,            // 红灯输出
    output green,          // 绿灯输出
    output yellow,         // 黄灯输出
    output [6:0] seg_ones,      
    output one
    );
    traffic_light trafficlight(
    .clk_in(clk_in),
    .rst(rst),
    .red(red),
    .green(green),
    .yellow(yellow),
    .seg_ones(seg_ones),
    .one(one)
    );

endmodule
