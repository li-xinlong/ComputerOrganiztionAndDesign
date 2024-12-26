module bcd_counter(
    input clk_signal,         // ʱ���ź�
    input btn_increment,      // ��������
    input btn_reset,          // ��λ����
    output overflow_indicator, // ���ָʾ��
    output [3:0] digit_select, // �����λѡ�ź�
    output [7:0] segment_data  // ����ܶ�ѡ�ź�
    );

    // �ڲ��Ĵ�������
    reg [15:0] count_value;      // BCD ����ֵ
    reg overflow_flag;           // �����־

    // ȥ�������
    reg [19:0] debounce_counter = 20'd0; // 20 λȥ��������
    reg btn_increment_sync_0, btn_increment_sync_1;
    reg btn_increment_stable;
    wire btn_increment_pulse;

    // �ź�ͬ������������̬����
    always @(posedge clk_signal) begin
        btn_increment_sync_0 <= btn_increment;
        btn_increment_sync_1 <= btn_increment_sync_0;
    end

    // ȥ�����߼�
    always @(posedge clk_signal) begin
        if (btn_increment_sync_1 == btn_increment_stable) begin
            debounce_counter <= 20'd0;
        end
        else begin
            debounce_counter <= debounce_counter + 1'b1;
            if (debounce_counter == 20'd999_999) begin // ��Լ 10ms ��ȥ����ʱ��
                btn_increment_stable <= btn_increment_sync_1;
                debounce_counter <= 20'd0;
            end
        end
    end

    // �������ؼ��
    reg btn_increment_prev;
    always @(posedge clk_signal) begin
        btn_increment_prev <= btn_increment_stable;
    end

    assign btn_increment_pulse = btn_increment_stable & ~btn_increment_prev;

    // BCD �������߼�
    always @(posedge clk_signal) begin
        if (btn_reset) begin
            count_value <= 16'd0;  
            overflow_flag <= 0;    
        end
        else if (btn_increment_pulse) begin
            if (count_value[3:0] == 4'd9) begin  // ��λ��9
                count_value[3:0] <= 4'd0;
                if (count_value[7:4] == 4'd5) begin  // ʮλ��5
                    count_value[7:4] <= 4'd0;
                    overflow_flag <= 1;
                end
                else begin
                    count_value[7:4] <= count_value[7:4] + 1'b1;
                    overflow_flag <= 0;
                end
            end
            else begin
                count_value[3:0] <= count_value[3:0] + 1'b1;
                overflow_flag <= 0;
            end
            count_value[15:8] <= 8'd0; // ���ֽ�����
        end
    end

    // ���ݴ����������ģ��
    wire [15:0] display_data;
    assign display_data = count_value;

    // ��� LED ָʾ
    assign overflow_indicator = overflow_flag;

    // ��������ܿ���ģ��
    display_driver display_module (
        .clk(clk_signal), 
        .data(display_data), 
        .sm_wei(digit_select), 
        .sm_duan(segment_data)
    );

endmodule
