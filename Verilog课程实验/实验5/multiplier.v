module multiplier (
    input wire [31:0] a,    // ������
    input wire [31:0] b,    // ����
    output reg [63:0] product // �˻�
);
    integer i;              // ѭ������

    always @(*) begin
        product = 64'b0;    // ��ʼ���˻�Ϊ0
        for (i = 0; i < 32; i = i + 1) begin
            // ��������ǰλ�Ƿ�Ϊ1
            if (b[i]) begin
                // ���Ϊ1��������������iλ��ӵ��˻�
                product = product + (a << i);
            end
        end
    end
endmodule