`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/12/06 23:55:21
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
    // �����źź�����ź�
    reg [31:0] a;             // ������
    reg [31:0] b;             // ����
    wire [63:0] product;      // ����˻�

    // ʵ���������Եĳ˷�ģ��
    multiplier uut (
        .a(a),
        .b(b),
        .product(product)
    );

    // ��ʼ������
    initial begin
        $display("Starting Testbench...");

        // �������� 1���򵥵ĳ˷�
        a = 32'd5; b = 32'd3;
        #10; // �ȴ�����
        $display("Test Case 1: a = %d, b = %d, product = %d", a, b, product);

        // �������� 2��һ��������Ϊ��
        a = 32'd0; b = 32'd12345;
        #10;
        $display("Test Case 2: a = %d, b = %d, product = %d", a, b, product);

        // �������� 3������������Ϊ��
        a = 32'd0; b = 32'd0;
        #10;
        $display("Test Case 3: a = %d, b = %d, product = %d", a, b, product);

        // �������� 4��һ��������һ��С��
        a = 32'd4294967295; b = 32'd2; // ���32λ�޷�������
        #10;
        $display("Test Case 4: a = %d, b = %d, product = %d", a, b, product);

        // �������� 5�������еȴ�С����
        a = 32'd12345; b = 32'd6789;
        #10;
        $display("Test Case 5: a = %d, b = %d, product = %d", a, b, product);

        // �������� 6���߽�ֵ���ԣ�1 �����ֵ��
        a = 32'd1; b = 32'd4294967295;
        #10;
        $display("Test Case 6: a = %d, b = %d, product = %d", a, b, product);

        // �������� 7�������
        a = 32'd123456789; b = 32'd987654321;
        #10;
        $display("Test Case 7: a = %d, b = %d, product = %d", a, b, product);

        // �������� 8���������ԣ�������չΪ�з�������ʱ���ã�
        a = -32'd10; b = 32'd20; // �����з���֧��������
        #10;
        $display("Test Case 8: a = %d, b = %d, product = %d", a, b, product);

        $display("All tests completed.");
        $stop; // ��������
    end
endmodule

