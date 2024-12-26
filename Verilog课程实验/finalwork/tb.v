`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/12/12 19:31:03
// Design Name: 
// Module Name: tb
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


module tb;
    // Testbench Signals
   reg clk_in;    // 时钟信号
       reg rst;       // 重置信号

       // 输出信号
       wire red;      // 红灯
       wire green;    // 绿灯
       wire yellow;   // 黄灯
       wire [6:0] seg_ones;// 数码管显示信号
       wire [6:0] seg_tens;// 数码管显示信号
       wire [7:0]countdown;
       wire [3:0]print_ones;
       wire [3:0]print_tens;
       // 实例化交通灯顶层模块
       traffic_light uut (
           .clk_in(clk_in),
           .rst(rst),
           .red(red),
           .green(green),
           .yellow(yellow),
           .seg_ones(seg_ones),
            .seg_tens(seg_tens),
           .countdown(countdown),
           .print_ones(print_ones),
                   .print_tens(print_tens)
       );

       // 时钟生成
       initial begin
           clk_in = 0;
           forever #5 clk_in = ~clk_in; // 100 MHz -> 每5 ns翻转一次
       end

       // 仿真流程
       initial begin
           // 初始化信号
           rst = 1;      // 复位信号激活
           #20;          // 等待一段时间
           rst = 0;      // 释放复位

           // 运行一段时间观察输出
           #5000;        // 5000 ns 仿真时间（5 us）

           // 结束仿真
           $stop;
       end

       // 显示仿真结果
//       always @(posedge clk_in) begin
//           $display("Time: %0t | Red: %b | Green: %b | Yellow: %b | Seg: %b", 
//                    $time, red, green, yellow, seg);
//       end
   endmodule
