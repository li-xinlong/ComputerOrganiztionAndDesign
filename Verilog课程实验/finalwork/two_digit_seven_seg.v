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
   input clk,                // 时钟信号
   input rst,                // 重置信号
   input [3:0]ones,
   input [3:0]tens,
   input [7:0] num,          // 输入的两位十进制数 (范围 0-99)
   output reg [6:0] seg_ones, // 个位的数码管显示信号
   output reg [6:0] seg_tens,  // 十位的数码管显示信号
   output reg[3:0] print_ones,
   output reg[3:0] print_tens
);
//   reg [3:0] ones;           // 个位
//   reg [3:0] tens;           // 十位

   // 数码管显示译码器
   function [6:0] decode_digit(input [3:0] digit);
       case (digit)
           4'b0000: decode_digit = 7'b011_1111; // 显示 0
           4'b0001: decode_digit = 7'b000_0110; // 显示 1
           4'b0010: decode_digit = 7'b101_1011; // 显示 2
           4'b0011: decode_digit = 7'b100_1111; // 显示 3
           4'b0100: decode_digit = 7'b110_0110; // 显示 4
           4'b0101: decode_digit = 7'b110_1101; // 显示 5
           4'b0110: decode_digit = 7'b111_1101; // 显示 6
           4'b0111: decode_digit = 7'b000_0111; // 显示 7
           4'b1000: decode_digit = 7'b111_1111; // 显示 8
           4'b1001: decode_digit = 7'b110_1111; // 显示 9
           default: decode_digit = 7'b0000000; // 默认熄灭
       endcase
   endfunction


   // 同步逻辑：在时钟上升沿更新显示值
   always @(posedge clk or posedge rst) begin
       if (rst) begin
           // 复位时，数码管显示为零
//           ones <= 4'b0000;
//           tens <= 4'b0000;
           seg_ones <= 7'b0000000;
           seg_tens <= 7'b0000000;
           
       end else begin
           // 提取个位和十位数字
//           ones <= num % 10;                // 个位数字
//           tens <= num / 10;         // 十位数字
            print_ones <= num % 10;
            print_tens <=(num / 10) % 10;
           // 更新数码管显示
           seg_ones <= decode_digit(ones);  // 个位数码管显示
           seg_tens <= decode_digit(tens);  // 十位数码管显示
       end
   end
endmodule