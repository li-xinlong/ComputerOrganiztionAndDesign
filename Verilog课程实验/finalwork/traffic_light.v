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
    input clk_in,          // ����ʱ�ӣ���100 MHz��
    input rst,             // �����ź�
    output red,            // ������
    output green,          // �̵����
    output yellow,         // �Ƶ����
    output [6:0] seg_ones,      
    output [6:0]seg_tens,
    output one,
    output ten,
    output [3:0]print_ones,
    output [3:0]print_tens,
    output [7:0]countdown
);
    wire clk_1hz;          // ��ʱ��
    wire [1:0] state;      // ״̬�ź�
    wire blink;            // ��˸�ź�
   // wire [7:0] countdown;  // ����ʱ�ź�
    assign one =1;
    assign ten=1;
    // ʵ����ģ��
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
        .countdown(countdown) // ����ʱ���
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
   wire[3:0] ones;           // ��λ
  wire[3:0] tens;           // ʮλ
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



