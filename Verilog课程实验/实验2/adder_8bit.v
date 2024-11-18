`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/11/18 14:36:58
// Design Name: 
// Module Name: adder_8bit
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


module adder_8bit(
    input [7:0] A,
    input [7:0] B,
    input CIN,
    output [7:0] SUM,
    output COUT
);
    wire [7:0] carry; // 每个位的进位信号

    full_adder fa0(.A(A[0]), .B(B[0]), .CIN(CIN), .SUM(SUM[0]), .COUT(carry[0]));
    full_adder fa1(.A(A[1]), .B(B[1]), .CIN(carry[0]), .SUM(SUM[1]), .COUT(carry[1]));
    full_adder fa2(.A(A[2]), .B(B[2]), .CIN(carry[1]), .SUM(SUM[2]), .COUT(carry[2]));
    full_adder fa3(.A(A[3]), .B(B[3]), .CIN(carry[2]), .SUM(SUM[3]), .COUT(carry[3]));
    full_adder fa4(.A(A[4]), .B(B[4]), .CIN(carry[3]), .SUM(SUM[4]), .COUT(carry[4]));
    full_adder fa5(.A(A[5]), .B(B[5]), .CIN(carry[4]), .SUM(SUM[5]), .COUT(carry[5]));
    full_adder fa6(.A(A[6]), .B(B[6]), .CIN(carry[5]), .SUM(SUM[6]), .COUT(carry[6]));
    full_adder fa7(.A(A[7]), .B(B[7]), .CIN(carry[6]), .SUM(SUM[7]), .COUT(COUT));
endmodule
