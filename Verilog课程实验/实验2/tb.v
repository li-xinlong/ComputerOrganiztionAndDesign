module tb;
    reg [7:0] A, B;
    reg CIN;
    wire [7:0] SUM;
    wire COUT;
    integer i;              // 循环控制变量
    reg [8:0] tempa, tempb; // 随机数生成的中间变量

    // 实例化 8 位加法器
    adder_8bit uut(
        .A(A),
        .B(B),
        .CIN(CIN),
        .SUM(SUM),
        .COUT(COUT)
    );

    initial begin
        CIN = 0;

        // 打印输出标题
        $display("Time\tA\tB\tCIN\tSUM\tCOUT");

        // 进行多次随机测试
        for (i = 0; i < 10; i = i + 1) begin
            tempa = $random % 9'b1_0000_0000; // 随机生成 A
            tempb = $random % 9'b1_0000_0000; // 随机生成 B

            A = tempa[7:0]; // 截取低 8 位
            B = tempb[7:0]; // 截取低 8 位
            CIN = $random % 2; // 随机生成 CIN (0 或 1)

            #10; // 等待 10 个时间单位
            $display("%0t\t%b\t%b\t%b\t%b\t%b", $time, A, B, CIN, SUM, COUT);
        end

        $finish; // 仿真结束
    end
endmodule
