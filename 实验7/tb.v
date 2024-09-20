`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   11:13:38 04/23/2016
// Design Name:   multi_cycle_cpu
// Module Name:   F:/new_lab/7_multi_cycle_cpu/tb.v
// Project Name:  multi_cycle_cpu
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: multi_cycle_cpu
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
    wire [31:0] display_state;
    wire [ 4:0] rs_addr;
    wire [ 4:0] rt_addr;
    wire [ 4:0] rd_addr;
    wire [ 31:0]test_rs_v;
    wire [ 31:0]test_rt_v;
    wire [ 31:0] test_alu_result;
    wire [ 31:0]test_dm_rdata;
    wire [ 31:0]test_dm_wdata;
    wire [ 63:0]test_IF_ID_bus_r;
    wire [ 31:0] test_rf_wdata;
    wire [31:0] test_IF_valid;
    wire [31:0] test_IF_over;
    // Instantiate the Unit Under Test (UUT)
    multi_cycle_cpu uut (
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
        .display_state(display_state),
        .rs_addr    (rs_addr),
        .rt_addr    (rt_addr),
        .rd_addr    (rd_addr),
        .test_rs_v  (test_rs_v),
        .test_rt_v  (test_rt_v),
        .test_alu_result(test_alu_result),
        .test_dm_rdata(test_dm_rdata),
        .test_dm_wdata(test_dm_wdata),
        .test_IF_ID_bus_r(test_IF_ID_bus_r),
        .test_rf_wdata( test_rf_wdata),
        .test_IF_valid(test_IF_valid),
        .test_IF_over(test_IF_over)
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

