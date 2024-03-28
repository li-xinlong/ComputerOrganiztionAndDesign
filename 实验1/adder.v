`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/03/22 10:26:28
// Design Name: 
// Module Name: adder
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


module adder(
    input  [31:0] operand1l,
    input  [31:0] operand1h,
    input  [31:0] operand2l,
    input  [31:0] operand2h,
    input         cin,
    output [31:0] resulth,
    output [31:0] resultl,
    output        cout1,
    output        cout2
    );
    assign {cout1,resultl} = operand1l + operand2l + cin;
    assign {cout2,resulth} = operand1h + operand2h + cout1;

endmodule

