`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/11/26 22:34:39
// Design Name: 
// Module Name: SimpleArithmetic
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

module SimpleArithmetic(
    input [7:0] ina,       // 输入 A
    input [7:0] inb,       // 输入 B
    output [8:0] sumab,    // A 和 B 的和（9 位，用于包含进位）
    output sumflag,        // 和的进位标志
    output [7:0] leftshiftA, // A 向左移位 inb 位
    output lessflag,       // A < B 标志
    output equalflag,      // A == B 标志
    output bitXorflag      // A 的按位缩减异或结果
);

    // 计算和以及进位标志
    assign sumab = ina + inb; // sumab 包括了进位
    assign sumflag = sumab[8]; // 提取进位

    // A 向左逻辑移位 inb 位
    assign leftshiftA = (inb < 9) ? (ina << inb) : 8'b0; 

    // 判断 A 是否小于 B
    assign lessflag = (ina < inb) ? 1'b1 : 1'b0;

    // 判断 A 是否等于 B
    assign equalflag = (ina == inb) ? 1'b1 : 1'b0;

    // 计算 A 的按位缩减异或结果
    assign bitXorflag = ^ina; // 按位异或并缩减

endmodule

