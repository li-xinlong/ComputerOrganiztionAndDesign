`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/12/26 01:51:43
// Design Name: 
// Module Name: two_digit_seven_seg
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


module two_digit_seven_seg(
   input clk,                // ʱ���ź�
   input rst,                // �����ź�
   input [3:0]ones,
   input [3:0]tens,
   input [7:0] num,          // �������λʮ������ (��Χ 0-99)
   output reg [6:0] seg_ones, // ��λ���������ʾ�ź�
   output reg [6:0] seg_tens,  // ʮλ���������ʾ�ź�
   output reg[3:0] print_ones,
   output reg[3:0] print_tens
);
//   reg [3:0] ones;           // ��λ
//   reg [3:0] tens;           // ʮλ

   // �������ʾ������
   function [6:0] decode_digit(input [3:0] digit);
       case (digit)
           4'b0000: decode_digit = 7'b011_1111; // ��ʾ 0
           4'b0001: decode_digit = 7'b000_0110; // ��ʾ 1
           4'b0010: decode_digit = 7'b101_1011; // ��ʾ 2
           4'b0011: decode_digit = 7'b100_1111; // ��ʾ 3
           4'b0100: decode_digit = 7'b110_0110; // ��ʾ 4
           4'b0101: decode_digit = 7'b110_1101; // ��ʾ 5
           4'b0110: decode_digit = 7'b111_1101; // ��ʾ 6
           4'b0111: decode_digit = 7'b000_0111; // ��ʾ 7
           4'b1000: decode_digit = 7'b111_1111; // ��ʾ 8
           4'b1001: decode_digit = 7'b110_1111; // ��ʾ 9
           default: decode_digit = 7'b0000000; // Ĭ��Ϩ��
       endcase
   endfunction


   // ͬ���߼�����ʱ�������ظ�����ʾֵ
   always @(posedge clk or posedge rst) begin
       if (rst) begin
           // ��λʱ���������ʾΪ��
//           ones <= 4'b0000;
//           tens <= 4'b0000;
           seg_ones <= 7'b0000000;
           seg_tens <= 7'b0000000;
           
       end else begin
           // ��ȡ��λ��ʮλ����
//           ones <= num % 10;                // ��λ����
//           tens <= num / 10;         // ʮλ����
            print_ones <= num % 10;
            print_tens <=(num / 10) % 10;
           // �����������ʾ
           seg_ones <= decode_digit(ones);  // ��λ�������ʾ
           seg_tens <= decode_digit(tens);  // ʮλ�������ʾ
       end
   end
endmodule