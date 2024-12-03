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

    // �źŶ���
    reg clk_in;              // ����ʱ��
    reg reset;               // ��λ�ź�
    reg [31:0] binary_input; // 32λ����������
    wire [5:0] count_zeros;  // ���0�ļ���
    wire [5:0] count_ones;   // ���1�ļ���
    wire clk_out;            // �����Ƶʱ��
    wire [3:0] count;        // ��Ƶ������ֵ

    // ����ʱ���ź�
    always begin
        #5 clk_in = ~clk_in;  // ÿ5��ʱ�䵥λ��תһ��ʱ��
    end

    // ʵ����topģ��
    top uut (
        .clk_in(clk_in),
        .reset(reset),
        .binary_input(binary_input),
        .count_zeros(count_zeros),
        .count_ones(count_ones),
        .clk_out(clk_out),
        .count(count)
    );

    // ��ʼ���ź�
    initial begin
        clk_in = 0;
        reset = 0;
        binary_input = 32'b0; // ��ʼ����Ϊ0
        #10 reset = 1;        // ��ϵͳ��λ�ź�
        #10 reset = 0;        // �����λ

        // �������32λ����������
        #10 binary_input = $random;  // �������32λ����
        #10 binary_input = $random;  // �������32λ����
        #10 binary_input = $random;  // �������32λ����
        #10 binary_input = $random;  // �������32λ����
        #10 binary_input = $random;  // �������32λ����
        #10 binary_input = $random;  // �������32λ����

        // ���Է�Ƶ��
        #100;  // �ȴ�һ��ʱ�䣬�۲��Ƶ�����clk_out

        // ��������
        #100 $finish;
    end

    // ��ʾ������
    initial begin
        $monitor("Time = %0t | binary_input = %b | count_zeros = %d | count_ones = %d | clk_out = %b | count = %d", 
                 $time, binary_input, count_zeros, count_ones, clk_out, count);
    end
endmodule

