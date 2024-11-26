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

    integer i; // 将变量声明移到模块级别

    // 实例化被测试模块
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

    // 初始化测试
    initial begin
        $display("开始随机测试...");
        $display("Time\tina\tinb\tsumab\tsumflag\tleftshiftA\tlessflag\tequalflag\tbitXorflag");
        for (i = 0; i < 100; i = i + 1) begin
            // 随机生成 8 位输入
            ina = $random % 256; // 0-255 的随机数
            inb = $random % 256; // 0-255 的随机数
            #10; // 等待 10 单位时间观察结果
            
            // 显示结果
            $display("%0t\t%0d\t%0d\t%0d\t%b\t%0d\t%b\t%b\t%b",
                     $time, ina, inb, sumab, sumflag, leftshiftA, lessflag, equalflag, bitXorflag);
        end
        $display("随机测试结束");
        $finish;
    end
endmodule