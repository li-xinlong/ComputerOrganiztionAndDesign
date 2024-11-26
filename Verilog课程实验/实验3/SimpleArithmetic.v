`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/11/26 22:34:39
// Design Name: 
// Module Name: SimpleArithmetic
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

module SimpleArithmetic(
    input [7:0] ina,       // ���� A
    input [7:0] inb,       // ���� B
    output [8:0] sumab,    // A �� B �ĺͣ�9 λ�����ڰ�����λ��
    output sumflag,        // �͵Ľ�λ��־
    output [7:0] leftshiftA, // A ������λ inb λ
    output lessflag,       // A < B ��־
    output equalflag,      // A == B ��־
    output bitXorflag      // A �İ�λ���������
);

    // ������Լ���λ��־
    assign sumab = ina + inb; // sumab �����˽�λ
    assign sumflag = sumab[8]; // ��ȡ��λ

    // A �����߼���λ inb λ
    assign leftshiftA = (inb < 9) ? (ina << inb) : 8'b0; 

    // �ж� A �Ƿ�С�� B
    assign lessflag = (ina < inb) ? 1'b1 : 1'b0;

    // �ж� A �Ƿ���� B
    assign equalflag = (ina == inb) ? 1'b1 : 1'b0;

    // ���� A �İ�λ���������
    assign bitXorflag = ^ina; // ��λ�������

endmodule

