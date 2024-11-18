module tb;
    reg [7:0] A, B;
    reg CIN;
    wire [7:0] SUM;
    wire COUT;
    integer i;              // ѭ�����Ʊ���
    reg [8:0] tempa, tempb; // ��������ɵ��м����

    // ʵ���� 8 λ�ӷ���
    adder_8bit uut(
        .A(A),
        .B(B),
        .CIN(CIN),
        .SUM(SUM),
        .COUT(COUT)
    );

    initial begin
        CIN = 0;

        // ��ӡ�������
        $display("Time\tA\tB\tCIN\tSUM\tCOUT");

        // ���ж���������
        for (i = 0; i < 10; i = i + 1) begin
            tempa = $random % 9'b1_0000_0000; // ������� A
            tempb = $random % 9'b1_0000_0000; // ������� B

            A = tempa[7:0]; // ��ȡ�� 8 λ
            B = tempb[7:0]; // ��ȡ�� 8 λ
            CIN = $random % 2; // ������� CIN (0 �� 1)

            #10; // �ȴ� 10 ��ʱ�䵥λ
            $display("%0t\t%b\t%b\t%b\t%b\t%b", $time, A, B, CIN, SUM, COUT);
        end

        $finish; // �������
    end
endmodule
