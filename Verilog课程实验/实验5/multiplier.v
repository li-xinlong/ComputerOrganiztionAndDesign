module multiplier (
    input wire [31:0] a,    // 被乘数
    input wire [31:0] b,    // 乘数
    output reg [63:0] product // 乘积
);
    integer i;              // 循环变量

    always @(*) begin
        product = 64'b0;    // 初始化乘积为0
        for (i = 0; i < 32; i = i + 1) begin
            // 检查乘数当前位是否为1
            if (b[i]) begin
                // 如果为1，将被乘数左移i位后加到乘积
                product = product + (a << i);
            end
        end
    end
endmodule