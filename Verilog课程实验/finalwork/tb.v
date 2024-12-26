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
   reg clk_in;    // ʱ���ź�
       reg rst;       // �����ź�

       // ����ź�
       wire red;      // ���
       wire green;    // �̵�
       wire yellow;   // �Ƶ�
       wire [6:0] seg_ones;// �������ʾ�ź�
       wire [6:0] seg_tens;// �������ʾ�ź�
       wire [7:0]countdown;
       wire [3:0]print_ones;
       wire [3:0]print_tens;
       // ʵ������ͨ�ƶ���ģ��
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

       // ʱ������
       initial begin
           clk_in = 0;
           forever #5 clk_in = ~clk_in; // 100 MHz -> ÿ5 ns��תһ��
       end

       // ��������
       initial begin
           // ��ʼ���ź�
           rst = 1;      // ��λ�źż���
           #20;          // �ȴ�һ��ʱ��
           rst = 0;      // �ͷŸ�λ

           // ����һ��ʱ��۲����
           #5000;        // 5000 ns ����ʱ�䣨5 us��

           // ��������
           $stop;
       end

       // ��ʾ������
//       always @(posedge clk_in) begin
//           $display("Time: %0t | Red: %b | Green: %b | Yellow: %b | Seg: %b", 
//                    $time, red, green, yellow, seg);
//       end
   endmodule
