`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/03/22 10:34:10
// Design Name: 
// Module Name: testbench
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


module testbench;

    // Inputs
    reg [31:0] operand1l;
    reg [31:0] operand1h;
    reg [31:0] operand2l;
    reg [31:0] operand2h;
    reg cin;
    // Outputs
    wire [31:0] resultl;
    wire [31:0] resulth;
    wire cout1;
    wire cout2;
    // Instantiate the Unit Under Test (UUT)
    adder uut (
        .operand1l(operand1l), 
        .operand2l(operand2l), 
        .cin(cin), 
        .resultl(resultl), 
        .cout1(cout1),
        .operand1h(operand1h),
        .operand2h(operand2h),
        .resulth(resulth),
        .cout2(cout2)
    );
    initial begin
        // Initialize Inputs
        operand1l = 0;
        operand1h = 0;
        operand2l = 0;
        operand2h = 0;
        cin = 0;
        // Wait 100 ns for global reset to finish
        #100;
        // Add stimulus here
    end
    always #10 operand1l = $random;  //$random为系统任务，产生一个随机的32位数
    always #10 operand2l = $random;  //#10 表示等待10个单位时间(10ns)，即每过10ns，赋值一个随机的32位数
    always #10 operand1h = $random;  //$random为系统任务，产生一个随机的32位数
    always #10 operand2h = $random;  //#10 表示等待10个单位时间(10ns)，即每过10ns，赋值一个随机的32位数
    always #10 cin = {$random} % 2; //加了拼接符，{$random}产生一个非负数，除2取余得到0或1
endmodule

