`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/12/12 20:53:49
// Design Name: 
// Module Name: light_controller
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


module light_controller(
    input [1:0] state,     // ״̬����
    input blink,           // ��˸�ź�
    output reg red,        // ���
    output reg green,      // �̵�
    output reg yellow      // �Ƶ�
);
    always @(*) begin
        case (state)
            2'b00: {red, green, yellow} = 3'b100; // �����
            2'b01: {red, green, yellow} = blink ? 3'b000 : 3'b010; // �̵���˸
            2'b10: {red, green, yellow} = 3'b001; // �Ƶ���
            default: {red, green, yellow} = 3'b000; // Ĭ��Ϩ��
        endcase
    end
endmodule
