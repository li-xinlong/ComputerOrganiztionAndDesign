`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/11/18 14:36:58
// Design Name: 
// Module Name: half_adder
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

module half_adder(
    input A,
    input B,
    output SUM,
    output CARRY
);
    assign SUM = A ^ B; // ���ʵ�� SUM
    assign CARRY = A & B; // ��ʵ�� CARRY
endmodule
