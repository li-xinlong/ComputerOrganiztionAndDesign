`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/11/18 14:36:58
// Design Name: 
// Module Name: full_adder
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


module full_adder(
    input A,
    input B,
    input CIN,
    output SUM,
    output COUT
);
    wire sum1, carry1, carry2;

    half_adder ha1(.A(A), .B(B), .SUM(sum1), .CARRY(carry1));
    half_adder ha2(.A(sum1), .B(CIN), .SUM(SUM), .CARRY(carry2));

    assign COUT = carry1 | carry2; // 或实现进位输出
endmodule
