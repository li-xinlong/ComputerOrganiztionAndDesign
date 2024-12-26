module bcd_counter(
    input clk_signal,         // 时钟信号
    input btn_increment,      // 增量按键
    input btn_reset,          // 复位按键
    output overflow_indicator, // 溢出指示灯
    output [3:0] digit_select, // 数码管位选信号
    output [7:0] segment_data  // 数码管段选信号
    );

    // 内部寄存器定义
    reg [15:0] count_value;      // BCD 计数值
    reg overflow_flag;           // 溢出标志

    // 去抖动相关
    reg [19:0] debounce_counter = 20'd0; // 20 位去抖计数器
    reg btn_increment_sync_0, btn_increment_sync_1;
    reg btn_increment_stable;
    wire btn_increment_pulse;

    // 信号同步，避免亚稳态问题
    always @(posedge clk_signal) begin
        btn_increment_sync_0 <= btn_increment;
        btn_increment_sync_1 <= btn_increment_sync_0;
    end

    // 去抖动逻辑
    always @(posedge clk_signal) begin
        if (btn_increment_sync_1 == btn_increment_stable) begin
            debounce_counter <= 20'd0;
        end
        else begin
            debounce_counter <= debounce_counter + 1'b1;
            if (debounce_counter == 20'd999_999) begin // 大约 10ms 的去抖动时间
                btn_increment_stable <= btn_increment_sync_1;
                debounce_counter <= 20'd0;
            end
        end
    end

    // 按键边沿检测
    reg btn_increment_prev;
    always @(posedge clk_signal) begin
        btn_increment_prev <= btn_increment_stable;
    end

    assign btn_increment_pulse = btn_increment_stable & ~btn_increment_prev;

    // BCD 计数器逻辑
    always @(posedge clk_signal) begin
        if (btn_reset) begin
            count_value <= 16'd0;  
            overflow_flag <= 0;    
        end
        else if (btn_increment_pulse) begin
            if (count_value[3:0] == 4'd9) begin  // 个位到9
                count_value[3:0] <= 4'd0;
                if (count_value[7:4] == 4'd5) begin  // 十位到5
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
            count_value[15:8] <= 8'd0; // 高字节清零
        end
    end

    // 数据传递至数码管模块
    wire [15:0] display_data;
    assign display_data = count_value;

    // 溢出 LED 指示
    assign overflow_indicator = overflow_flag;

    // 调用数码管控制模块
    display_driver display_module (
        .clk(clk_signal), 
        .data(display_data), 
        .sm_wei(digit_select), 
        .sm_duan(segment_data)
    );

endmodule
