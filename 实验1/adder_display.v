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
    //时钟与复位信号
     input clk,
    input resetn,    //后缀"n"代表低电平有效

    //拨码开关，用于选择输入数和产生cin
    input input_sel1, //0:输入为加数1(add_operand1);1:输入为加数2(add_operand2)
    input input_sel2, //0:输入为加数1(add_operand1);1:输入为加数2(add_operand2)
    input sw_cin,

    //led灯，用于显示cout
    output led_cout,
    
    //触摸屏相关接口，不需要更改
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

//-----{调用加法模块}begin
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
//-----{调用加法模块}end

//---------------------{调用触摸屏模块}begin--------------------//
//-----{实例化触摸屏}begin
//此小节不需要更改
    reg         display_valid;
    reg  [39:0] display_name;
    reg  [31:0] display_value;
    wire [5 :0] display_number;
    wire        input_valid;
    wire [31:0] input_value;

    lcd_module lcd_module(
        .clk            (clk           ),   //10Mhz
        .resetn         (resetn        ),

        //调用触摸屏的接口
        .display_valid  (display_valid ),
        .display_name   (display_name  ),
        .display_value  (display_value ),
        .display_number (display_number),
        .input_valid    (input_valid   ),
        .input_value    (input_value   ),

        //lcd触摸屏相关接口，不需要更改
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
//-----{实例化触摸屏}end
//-----{从触摸屏获取输入}begin
//根据实际需要输入的数修改此小节，
//建议对每一个数的输入，编写单独一个always块
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
//-----{从触摸屏获取输入}end

//-----{输出到触摸屏显示}begin
//根据需要显示的数修改此小节，
//触摸屏上共有44块显示区域，可显示44组32位数据
//44块显示区域从1开始编号，编号为1~44，
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
//-----{输出到触摸屏显示}end
//----------------------{调用触摸屏模块}end---------------------//
endmodule

