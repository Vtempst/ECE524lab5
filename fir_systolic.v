`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/09/2026 11:23:41 AM
// Design Name: 
// Module Name: fir_systolic
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

module fir_systolic(
input aclk,
input s_axis_data_tvalid,
output wire s_axis_data_tready,
input [15:0] s_axis_data_tdata,
output wire m_axis_data_tvalid,
output wire [31:0] m_axis_data_tdata
    );
    
fir_compiler_0 fir_systolic_insta (
  .aclk(aclk),                              // input wire aclk
  .s_axis_data_tvalid(s_axis_data_tvalid),  // input wire s_axis_data_tvalid
  .s_axis_data_tready(s_axis_data_tready),  // output wire s_axis_data_tready
  .s_axis_data_tdata(s_axis_data_tdata),    // input wire [15 : 0] s_axis_data_tdata
  .m_axis_data_tvalid(m_axis_data_tvalid),  // output wire m_axis_data_tvalid
  .m_axis_data_tdata(m_axis_data_tdata)    // output wire [31 : 0] m_axis_data_tdata
);
    
endmodule
