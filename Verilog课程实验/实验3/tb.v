`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/11/26 22:35:14
// Design Name: 
// Module Name: tb
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
module tb;

    reg [7:0] ina;
    reg [7:0] inb;
    wire [8:0] sumab;
    wire sumflag;
    wire [7:0] leftshiftA;
    wire lessflag;
    wire equalflag;
    wire bitXorflag;

    integer i; // �����������Ƶ�ģ�鼶��

    // ʵ����������ģ��
    SimpleArithmetic uut (
        .ina(ina),
        .inb(inb),
        .sumab(sumab),
        .sumflag(sumflag),
        .leftshiftA(leftshiftA),
        .lessflag(lessflag),
        .equalflag(equalflag),
        .bitXorflag(bitXorflag)
    );

    // ��ʼ������
    initial begin
        $display("��ʼ�������...");
        $display("Time\tina\tinb\tsumab\tsumflag\tleftshiftA\tlessflag\tequalflag\tbitXorflag");
        for (i = 0; i < 100; i = i + 1) begin
            // ������� 8 λ����
            ina = $random % 256; // 0-255 �������
            inb = $random % 256; // 0-255 �������
            #10; // �ȴ� 10 ��λʱ��۲���
            
            // ��ʾ���
            $display("%0t\t%0d\t%0d\t%0d\t%b\t%0d\t%b\t%b\t%b",
                     $time, ina, inb, sumab, sumflag, leftshiftA, lessflag, equalflag, bitXorflag);
        end
        $display("������Խ���");
        $finish;
    end
endmodule