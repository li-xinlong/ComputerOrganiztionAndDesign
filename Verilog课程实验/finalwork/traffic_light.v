`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/12/12 20:54:13
// Design Name: 
// Module Name: traffic_light
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
module traffic_light(
    input clk_in,          // 输入时钟（如100 MHz）
    input rst,             // 重置信号
    output red,            // 红灯输出
    output green,          // 绿灯输出
    output yellow,         // 黄灯输出
    output [6:0] seg_ones,      
    output [6:0]seg_tens,
    output one,
    output ten,
    output [3:0]print_ones,
    output [3:0]print_tens,
    output [7:0]countdown
);
    wire clk_1hz;          // 秒时钟
    wire [1:0] state;      // 状态信号
    wire blink;            // 闪烁信号
   // wire [7:0] countdown;  // 倒计时信号
    assign one =1;
    assign ten=1;
    // 实例化模块
    clock_divider clk_div (
        .clk_in(clk_in),
        .rst(rst),
        .clk_out(clk_1hz)
    );

    fsm_controller fsm (
        .clk(clk_1hz),
        .rst(rst),
        .state(state),
        .blink(blink),
        .countdown(countdown) // 倒计时输出
    );

    light_controller light_ctrl (
        .state(state),
        .blink(blink),
        .red(red),
        .green(green),
        .yellow(yellow)
    );
//    wire [3:0]print_ones;
//    wire [3:0]print_tens;
   wire[3:0] ones;           // 个位
  wire[3:0] tens;           // 十位
  assign ones=countdown%10;
  assign tens=countdown/10;
    two_digit_seven_seg  segs( 
        .clk(clk_1hz),
        .rst(rst),
        .num(countdown),
        .seg_ones(seg_ones),
        .seg_tens(seg_tens),
        .print_ones(print_ones),
        .print_tens(print_tens),
        .ones(ones),
        .tens(tens)
         );
endmodule



