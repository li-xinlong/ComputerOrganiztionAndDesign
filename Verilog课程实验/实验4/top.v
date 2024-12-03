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
    input clk_in,         // ����ʱ��
    input reset,          // �����ź�
    input [31:0] binary_input, // 32λ����������
    output [5:0] count_zeros,  // ͳ��0�Ĵ���
    output [5:0] count_ones,   // ͳ��1�Ĵ���
    output clk_out ,       // ��Ƶ���ʱ�����
    output [3:0]count     // ���ڷ�Ƶ���ļ����ź�
);


    // ʵ����divider10ģ��
    divider10 div (
        .clk_in(clk_in),
        .reset(reset),
        .clk_out(clk_out),
        .count(count)
    );

    // ʵ����CountZeroOneģ��
    CountZeroOne counter (
        .binary_input(binary_input),
        .count_zeros(count_zeros),
        .count_ones(count_ones)
    );

endmodule

