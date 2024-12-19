module divider(
    input              clk,         // ʱ���ź�
    input              div_begin,   // ������ʼ�ź�
    input      [31:0]  div_op1,     // ������
    input      [31:0]  div_op2,     // ����
    output reg [31:0]  quotient,    // ��
    output reg [31:0]  remainder,   // ����
    output reg         div_end      // ���������ź�
);

    // ״̬��״̬����
    reg [1:0] state;
    parameter IDLE  = 2'b00, // ����״̬
              WORK  = 2'b01, // ����״̬
              DONE  = 2'b10; // ���״̬

    reg [31:0] dividend;  // ��ǰ������
    reg [31:0] divisor;   // ��ǰ����
    reg [31:0] temp_quotient; // �м���
    reg [31:0] temp_remainder; // �м�����
    reg [5:0]  bit_index;  // λ��������

    always @(posedge clk) begin
        case (state)
            IDLE: begin
                div_end <= 0;  // ��������ź�
                if (div_begin) begin
                    // ��ʼ������
                    dividend       <= div_op1;
                    divisor        <= div_op2;
                    temp_quotient  <= 0;
                    temp_remainder <= 0;
                    bit_index      <= 31;
                    state          <= WORK;
                end
            end
            WORK: begin
                if (bit_index >= 0) begin
                    temp_remainder = {temp_remainder[30:0], dividend[31]};
                    dividend = dividend << 1;

                    if (temp_remainder >= divisor) begin
                        temp_remainder = temp_remainder - divisor;
                        temp_quotient = (temp_quotient << 1) | 1;
                    end else begin
                        temp_quotient = temp_quotient << 1;
                    end

                    // ����λ����
                    if (bit_index == 0) begin
                        state <= DONE;
                    end else begin
                        bit_index <= bit_index - 1;
                    end
                end
            end
            DONE: begin
                // ������ɣ�������
                quotient <= temp_quotient;
                remainder <= temp_remainder;
                div_end <= 1;  // �ø߽����ź�
                state <= IDLE; // ���ؿ���״̬
            end
            default: state <= IDLE; // ��ȫ����
        endcase
    end
endmodule
