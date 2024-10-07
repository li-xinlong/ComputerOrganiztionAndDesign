`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   11:57:16 04/23/2016
// Design Name:   pipeline_cpu
// Module Name:   F:/new_lab/8_pipeline_cpu/tb.v
// Project Name:  pipeline_cpu
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: pipeline_cpu
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module tb;

    // Inputs
    reg clk;
    reg resetn;
    reg [4:0] rf_addr;
    reg [31:0] mem_addr;

    // Outputs
    wire [31:0] rf_data;
    wire [31:0] mem_data;
    wire [31:0] IF_pc;
    wire [31:0] IF_inst;
    wire [31:0] ID_pc;
    wire [31:0] EXE_pc;
    wire [31:0] MEM_pc;
    wire [31:0] WB_pc;
    wire [31:0] cpu_5_valid;
    wire [ 31:0] print_rf_wdata;
    wire [ 31:0] print_dm_wdata;
    wire [ 31:0] print_dm_rdata;
    wire [ 31:0] print_rs_value;    
    wire [ 31:0] print_rt_value;  
    wire [  4:0] print_rs_addr;
    wire [  4:0] print_rt_addr;
    wire [  4:0] print_rf_wdest;
    wire[  4:0] print_EXE_wdest;
    wire [  4:0] print_WB_wdest;
    wire [  4:0] print_MEM_wdest;
    wire [31:0]print_jbr_target;
    wire [63:0]print_IF_ID_bus_r;
    // Instantiate the Unit Under Test (UUT)
    pipeline_cpu uut (
        .clk(clk), 
        .resetn(resetn), 
        .rf_addr(rf_addr), 
        .mem_addr(mem_addr), 
        .rf_data(rf_data), 
        .mem_data(mem_data), 
        .IF_pc(IF_pc), 
        .IF_inst(IF_inst), 
        .ID_pc(ID_pc), 
        .EXE_pc(EXE_pc), 
        .MEM_pc(MEM_pc), 
        .WB_pc(WB_pc), 
        .cpu_5_valid(cpu_5_valid),
        .print_rf_wdata(print_rf_wdata),
        .print_dm_wdata(print_dm_wdata),
        .print_dm_rdata(print_dm_rdata),
        .print_rs_value(print_rs_value),
        .print_rt_value(print_rt_value),
        .print_rs_addr(print_rs_addr),
        .print_rt_addr(print_rt_addr),
        .print_rf_wdest(print_rf_wdest),
        .print_EXE_wdest(print_EXE_wdest),
        .print_MEM_wdest(print_MEM_wdest),
        .print_WB_wdest(print_WB_wdest),
        .print_jbr_target(print_jbr_target),
        .print_IF_ID_bus_r(print_IF_ID_bus_r)
    );

    initial begin
        // Initialize Inputs
        clk = 0;
        resetn = 0;
        rf_addr = 0;
        mem_addr = 0;

        // Wait 100 ns for global reset to finish
        #100;
      resetn = 1;
        // Add stimulus here
    end
   always #5 clk=~clk;
endmodule

