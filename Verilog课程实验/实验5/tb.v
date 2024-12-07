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
    // 输入信号和输出信号
    reg [31:0] a;             // 被乘数
    reg [31:0] b;             // 乘数
    wire [63:0] product;      // 输出乘积

    // 实例化待测试的乘法模块
    multiplier uut (
        .a(a),
        .b(b),
        .product(product)
    );

    // 初始化测试
    initial begin
        $display("Starting Testbench...");

        // 测试用例 1：简单的乘法
        a = 32'd5; b = 32'd3;
        #10; // 等待计算
        $display("Test Case 1: a = %d, b = %d, product = %d", a, b, product);

        // 测试用例 2：一个操作数为零
        a = 32'd0; b = 32'd12345;
        #10;
        $display("Test Case 2: a = %d, b = %d, product = %d", a, b, product);

        // 测试用例 3：两个操作数为零
        a = 32'd0; b = 32'd0;
        #10;
        $display("Test Case 3: a = %d, b = %d, product = %d", a, b, product);

        // 测试用例 4：一个大数和一个小数
        a = 32'd4294967295; b = 32'd2; // 最大32位无符号整数
        #10;
        $display("Test Case 4: a = %d, b = %d, product = %d", a, b, product);

        // 测试用例 5：两个中等大小的数
        a = 32'd12345; b = 32'd6789;
        #10;
        $display("Test Case 5: a = %d, b = %d, product = %d", a, b, product);

        // 测试用例 6：边界值测试（1 和最大值）
        a = 32'd1; b = 32'd4294967295;
        #10;
        $display("Test Case 6: a = %d, b = %d, product = %d", a, b, product);

        // 测试用例 7：随机数
        a = 32'd123456789; b = 32'd987654321;
        #10;
        $display("Test Case 7: a = %d, b = %d, product = %d", a, b, product);

        // 测试用例 8：负数测试（假设扩展为有符号运算时适用）
        a = -32'd10; b = 32'd20; // 仅在有符号支持下意义
        #10;
        $display("Test Case 8: a = %d, b = %d, product = %d", a, b, product);

        $display("All tests completed.");
        $stop; // 结束仿真
    end
endmodule

