`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/11/28 21:55:20
// Design Name: 
// Module Name: divider10
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

module divider10 (
    input clk_in,       // ����ʱ���ź�
    input reset,        // �����ź�
    output reg [3:0] count, // ��������ȡֵ��Χ0~10
    output reg clk_out  // ���ʮ��Ƶ���ʱ���ź�
);

    always @(posedge clk_in or posedge reset) begin
        if (reset) begin
            count <= 4'b0;       // ��λʱ������������
            clk_out <= 1'b1;     // ��ʼ�� clk_out Ϊ 1
        end else begin
            if (count == 4'd10) begin
                count <= 4'b0;   // �������� 10 ʱ����
                clk_out <= 1'b1; // clk_out �� 0 ��Ϊ 1
            end else if (count == 4'd5) begin
                clk_out <= 1'b0; // �������� 5 ʱ clk_out �� 1 ��Ϊ 0
                count <= count + 1;
            end else begin
                count <= count + 1; // ����������
            end
        end
    end
endmodule

