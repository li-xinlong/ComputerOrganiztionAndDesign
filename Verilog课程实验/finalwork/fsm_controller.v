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
    input clk,             // ��ʱ��
    input rst,             // �����ź�
    output reg [1:0] state,// ״̬�����00-�죬01-�̣�10-��
    output reg blink,      // ��˸�źţ�1-��˸��0-����
    output reg [7:0] countdown // ����ʱ
);
    reg [3:0] timer;       // ��ʱ��

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            state <= 2'b00; // ��Ƴ�ʼ
            timer <= 0;
            blink <= 0;
            countdown <= 7'd9; // ��Ƴ�ʼ����ʱ12��
        end else begin
            case (state)
                2'b00: begin // ���״̬
                    blink <= 0;
                    countdown <= 9 - timer; // ���µ���ʱ
                    if (timer < 10) timer <= timer + 1;
                    else begin
                        timer <= 0;
                        state <= 2'b01; // ת�̵�
                        countdown <= 7'd9; // �̵Ƶ���ʱ10��
                    end
                   
                end
                2'b01: begin // �̵�״̬
                    countdown <= 9 - timer; // ���µ���ʱ
                    if (timer < 10) begin
                        if (timer >= 5) blink <= ~blink; // �̵����3����˸
                        else blink <= 0;
                        timer <= timer + 1;
                    end else begin
                        timer <= 0;
                        blink <= 0;
                        state <= 2'b10; // ת�Ƶ�
                        countdown <= 9; // �ƵƵ���ʱ2��
                    end
                end
                2'b10: begin // �Ƶ�״̬
                    blink <= 0;
                    countdown <= 9 - timer; // ���µ���ʱ
                    if (timer < 10) timer <= timer + 1;
                    else begin
                        timer <= 0;
                        state <= 2'b00; // ת���
                        countdown <= 9; // ��Ƶ���ʱ12��
                    end
                end
            endcase
        end
    end
endmodule


