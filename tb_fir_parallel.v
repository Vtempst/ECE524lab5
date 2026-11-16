`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/09/2026 12:46:31 AM
// Design Name: 
// Module Name: tb_fir_parallel
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


module tb_fir_parallel();
reg clk;
reg rst;
reg signed [15:0] data_in;
wire signed [36:0] data_out;

wire dds_valid;
wire [15:0] dds_data;
wire dds_phase_valid;
wire [23:0] dds_phase_data;

dds_compiler_1 dds_inst (
  .aclk(clk),                                // input wire aclk
  .m_axis_data_tvalid(dds_valid),    // output wire m_axis_data_tvalid
  .m_axis_data_tdata(dds_data),      // output wire [15 : 0] m_axis_data_tdata
  .m_axis_phase_tvalid(dds_phase_valid),  // output wire m_axis_phase_tvalid
  .m_axis_phase_tdata(dds_phase_data)    // output wire [23 : 0] m_axis_phase_tdata
);

fir_parallel uut(
    .clk(clk),
    .rst(rst),
    .data_in(data_in),
    .data_out(data_out)
);

initial begin
    clk = 0;
    forever #100 clk = ~clk;
end

initial begin

rst = 1;
//data_in = 0;
repeat (2) @(posedge clk);
@(negedge clk);
rst = 0;

//data_in = 16'sd100;
//@(posedge clk);
//@(negedge clk);
//data_in = 0;
//repeat (22) @(posedge clk);
//#1
//$finish;
repeat (100) @(posedge clk);
#1;
$finish;
end

always @(*) begin
    if (dds_valid) 
    begin
        data_in = {{1{dds_data[14]}}, dds_data[14:0]}; 
    end
    else
    begin
        data_in = 0;
    end
end

endmodule
