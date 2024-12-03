`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/11/28 21:54:43
// Design Name: 
// Module Name: CountZeroOne
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

module CountZeroOne (
    input [31:0] binary_input,  // �����32λ��������
    output reg [5:0] count_zeros,  // 0�ļ��������6λ
    output reg [5:0] count_ones   // 1�ļ��������6λ
);
    integer i;

    always @(*) begin
        count_zeros = 0;
        count_ones = 0;
        for (i = 0; i < 32; i = i + 1) begin
            if (binary_input[i] == 0)
                count_zeros = count_zeros + 1;
            else
                count_ones = count_ones + 1;
        end
    end
endmodule
