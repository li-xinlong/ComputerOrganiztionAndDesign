`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/11/28 21:58:50
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

    // 信号定义
    reg clk_in;              // 输入时钟
    reg reset;               // 复位信号
    reg [31:0] binary_input; // 32位二进制输入
    wire [5:0] count_zeros;  // 输出0的计数
    wire [5:0] count_ones;   // 输出1的计数
    wire clk_out;            // 输出降频时钟
    wire [3:0] count;        // 分频器计数值

    // 生成时钟信号
    always begin
        #5 clk_in = ~clk_in;  // 每5个时间单位反转一次时钟
    end

    // 实例化top模块
    top uut (
        .clk_in(clk_in),
        .reset(reset),
        .binary_input(binary_input),
        .count_zeros(count_zeros),
        .count_ones(count_ones),
        .clk_out(clk_out),
        .count(count)
    );

    // 初始化信号
    initial begin
        clk_in = 0;
        reset = 0;
        binary_input = 32'b0; // 初始输入为0
        #10 reset = 1;        // 给系统复位信号
        #10 reset = 0;        // 解除复位

        // 随机测试32位二进制输入
        #10 binary_input = $random;  // 随机生成32位输入
        #10 binary_input = $random;  // 随机生成32位输入
        #10 binary_input = $random;  // 随机生成32位输入
        #10 binary_input = $random;  // 随机生成32位输入
        #10 binary_input = $random;  // 随机生成32位输入
        #10 binary_input = $random;  // 随机生成32位输入

        // 测试分频器
        #100;  // 等待一段时间，观察分频器输出clk_out

        // 结束仿真
        #100 $finish;
    end

    // 显示输出结果
    initial begin
        $monitor("Time = %0t | binary_input = %b | count_zeros = %d | count_ones = %d | clk_out = %b | count = %d", 
                 $time, binary_input, count_zeros, count_ones, clk_out, count);
    end
endmodule

