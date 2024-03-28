`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/03/22 10:55:44
// Design Name: 
// Module Name: adder_display
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

module adder_display(
    //ʱ���븴λ�ź�
     input clk,
    input resetn,    //��׺"n"����͵�ƽ��Ч

    //���뿪�أ�����ѡ���������Ͳ���cin
    input input_sel1, //0:����Ϊ����1(add_operand1);1:����Ϊ����2(add_operand2)
    input input_sel2, //0:����Ϊ����1(add_operand1);1:����Ϊ����2(add_operand2)
    input sw_cin,

    //led�ƣ�������ʾcout
    output led_cout,
    
    //��������ؽӿڣ�����Ҫ����
    output lcd_rst,
    output lcd_cs,
    output lcd_rs,
    output lcd_wr,
    output lcd_rd,
    inout[15:0] lcd_data_io,
    output lcd_bl_ctr,
    inout ct_int,
    inout ct_sda,
    output ct_scl,
    output ct_rstn
    );

//-----{���üӷ�ģ��}begin
    reg  [31:0] adder_operand1l;
    reg  [31:0] adder_operand2l;
    reg  [31:0] adder_operand1h;
    reg   [31:0] adder_operand2h;
    wire        adder_cin;
    wire [31:0] adder_resultl  ;
    wire [31:0] adder_resulth;
    wire        adder_cout1;
    wire        adder_cout2;
    adder adder_module(
        .operand1l(adder_operand1l),
        .operand2l(adder_operand2l),
        .cin     (adder_cin     ),
        .resultl  (adder_resultl ),
        .cout1    (adder_cout1    ),
        .operand1h(adder_operand1h),
        .operand2h(adder_operand2h),
        .resulth(adder_resulth),
        .cout2(adder_cout2)
    );
   assign adder_cin = sw_cin;
   assign led_cout  = adder_cout2;
//-----{���üӷ�ģ��}end

//---------------------{���ô�����ģ��}begin--------------------//
//-----{ʵ����������}begin
//��С�ڲ���Ҫ����
    reg         display_valid;
    reg  [39:0] display_name;
    reg  [31:0] display_value;
    wire [5 :0] display_number;
    wire        input_valid;
    wire [31:0] input_value;

    lcd_module lcd_module(
        .clk            (clk           ),   //10Mhz
        .resetn         (resetn        ),

        //���ô������Ľӿ�
        .display_valid  (display_valid ),
        .display_name   (display_name  ),
        .display_value  (display_value ),
        .display_number (display_number),
        .input_valid    (input_valid   ),
        .input_value    (input_value   ),

        //lcd��������ؽӿڣ�����Ҫ����
        .lcd_rst        (lcd_rst       ),
        .lcd_cs         (lcd_cs        ),
        .lcd_rs         (lcd_rs        ),
        .lcd_wr         (lcd_wr        ),
        .lcd_rd         (lcd_rd        ),
        .lcd_data_io    (lcd_data_io   ),
        .lcd_bl_ctr     (lcd_bl_ctr    ),
        .ct_int         (ct_int        ),
        .ct_sda         (ct_sda        ),
        .ct_scl         (ct_scl        ),
        .ct_rstn        (ct_rstn       )
    ); 
//-----{ʵ����������}end
//-----{�Ӵ�������ȡ����}begin
//����ʵ����Ҫ��������޸Ĵ�С�ڣ�
//�����ÿһ���������룬��д����һ��always��
    always @(posedge clk)
    begin
        if (!resetn)
        begin
            adder_operand1l <= 32'd0;
        end
        else if (input_valid && !input_sel1&&!input_sel2)
        begin
            adder_operand1l <= input_value;
        end
    end
    always @(posedge clk)
    begin
        if (!resetn)
        begin
            adder_operand1h <= 32'd0;
        end
        else if (input_valid && !input_sel1&&input_sel2)
        begin
            adder_operand1h <= input_value;
        end
    end
     always @(posedge clk)
       begin
           if (!resetn)
           begin
               adder_operand2l <= 32'd0;
           end
           else if (input_valid &&input_sel1&&!input_sel2)
           begin
               adder_operand2l <= input_value;
           end
       end
        always @(posedge clk)
          begin
              if (!resetn)
              begin
                  adder_operand2h <= 32'd0;
              end
              else if (input_valid && input_sel1&&input_sel2)
              begin
                  adder_operand2h <= input_value;
              end
          end
//-----{�Ӵ�������ȡ����}end

//-----{�������������ʾ}begin
//������Ҫ��ʾ�����޸Ĵ�С�ڣ�
//�������Ϲ���44����ʾ���򣬿���ʾ44��32λ����
//44����ʾ�����1��ʼ��ţ����Ϊ1~44��
    always @(posedge clk)
    begin
        case(display_number)
            6'd1 :
            begin
                display_valid <= 1'b1;
                display_name  <= "s1";
                display_value <= adder_operand1l;
            end
            6'd2 :
            begin
                display_valid <= 1'b1;
                display_name  <= "b1";
                display_value <= adder_operand2l;
            end
           6'd3 :
                       begin
                           display_valid <= 1'b1;
                           display_name  <= "s2";
                           display_value <= adder_operand1h;
                       end
             6'd4 :
             begin
                            display_valid <= 1'b1;
                            display_name  <= "b2";
                            display_value <= adder_operand2h;
                        end
              6'd5 :
              begin
                display_valid <= 1'b1;
                display_name  <= "R1";
                display_value <= adder_resultl;
              end
              6'd6 :
              begin
                display_valid <= 1'b1;
                display_name  <= "R2";
                display_value <= adder_resulth;
              end
            default :
            begin
                display_valid <= 1'b0;
                display_name  <= 40'd0;
                display_value <= 32'd0;
            end
        endcase
    end
//-----{�������������ʾ}end
//----------------------{���ô�����ģ��}end---------------------//
endmodule

