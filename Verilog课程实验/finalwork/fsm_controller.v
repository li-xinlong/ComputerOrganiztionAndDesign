`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/12/12 20:53:23
// Design Name: 
// Module Name: fsm_controller
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
module fsm_controller(
    input clk,             // 秒时钟
    input rst,             // 重置信号
    output reg [1:0] state,// 状态输出：00-红，01-绿，10-黄
    output reg blink,      // 闪烁信号：1-闪烁，0-常亮
    output reg [7:0] countdown // 倒计时
);
    reg [3:0] timer;       // 计时器

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            state <= 2'b00; // 红灯初始
            timer <= 0;
            blink <= 0;
            countdown <= 7'd9; // 红灯初始倒计时12秒
        end else begin
            case (state)
                2'b00: begin // 红灯状态
                    blink <= 0;
                    countdown <= 9 - timer; // 更新倒计时
                    if (timer < 10) timer <= timer + 1;
                    else begin
                        timer <= 0;
                        state <= 2'b01; // 转绿灯
                        countdown <= 7'd9; // 绿灯倒计时10秒
                    end
                   
                end
                2'b01: begin // 绿灯状态
                    countdown <= 9 - timer; // 更新倒计时
                    if (timer < 10) begin
                        if (timer >= 5) blink <= ~blink; // 绿灯最后3秒闪烁
                        else blink <= 0;
                        timer <= timer + 1;
                    end else begin
                        timer <= 0;
                        blink <= 0;
                        state <= 2'b10; // 转黄灯
                        countdown <= 9; // 黄灯倒计时2秒
                    end
                end
                2'b10: begin // 黄灯状态
                    blink <= 0;
                    countdown <= 9 - timer; // 更新倒计时
                    if (timer < 10) timer <= timer + 1;
                    else begin
                        timer <= 0;
                        state <= 2'b00; // 转红灯
                        countdown <= 9; // 红灯倒计时12秒
                    end
                end
            endcase
        end
    end
endmodule


