`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/09/2026 03:21:40 AM
// Design Name: 
// Module Name: tb_fir_systolic
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


module tb_fir_systolic();
reg aclk;
//reg s_axis_data_tvalid;
wire s_axis_data_tvalid;
wire s_axis_data_tready;
//reg [15:0] s_axis_data_tdata;
wire [15:0] s_axis_data_tdata;
wire m_axis_data_tvalid;
wire [31:0] m_axis_data_tdata;
//integer i;

wire dds_valid;
wire [15:0] dds_data;
wire dds_phase_valid;
wire [23:0] dds_phase_data;

dds_compiler_0 dds_inst (
  .aclk(aclk),                                // input wire aclk
  .m_axis_data_tvalid(dds_valid),    // output wire m_axis_data_tvalid
  .m_axis_data_tdata(dds_data),      // output wire [15 : 0] m_axis_data_tdata
  .m_axis_phase_tvalid(dds_phase_valid),  // output wire m_axis_phase_tvalid
  .m_axis_phase_tdata(dds_phase_data)    // output wire [23 : 0] m_axis_phase_tdata
);

fir_systolic uut (
  .aclk(aclk),                              // input wire aclk
  .s_axis_data_tvalid(s_axis_data_tvalid),  // input wire s_axis_data_tvalid
  .s_axis_data_tready(s_axis_data_tready),  // output wire s_axis_data_tready
  .s_axis_data_tdata(s_axis_data_tdata),    // input wire [15 : 0] s_axis_data_tdata
  .m_axis_data_tvalid(m_axis_data_tvalid),  // output wire m_axis_data_tvalid
  .m_axis_data_tdata(m_axis_data_tdata)    // output wire [31 : 0] m_axis_data_tdata
);

initial begin
    aclk = 0;
    forever #100 aclk = ~aclk;
end

//initial begin
//    s_axis_data_tvalid = 0;
//    s_axis_data_tdata = 0;
//    repeat (5) @(posedge aclk);
//    @(negedge aclk);
//    s_axis_data_tdata = 16'sd100;
//    s_axis_data_tvalid = 1;
//    while (s_axis_data_tready !== 1'b1)
//    begin
//        @(negedge aclk);
//    end 
//    @(posedge aclk);
//    @(negedge aclk);
//    s_axis_data_tvalid = 0;
//    for(i = 0; i < 20; i = i + 1)
//    begin
//        @(negedge aclk);
//        s_axis_data_tdata = 0;
//        s_axis_data_tvalid = 1;
//        while (s_axis_data_tready !== 1'b1)
//        begin
//            @(negedge aclk);
//        end
//        @(posedge aclk); 
//        @(negedge aclk);
//        s_axis_data_tvalid = 0;
//    end
//    repeat (25) @(posedge aclk);
//    #1 
//    $finish;
//end
assign s_axis_data_tvalid = dds_valid;
assign s_axis_data_tdata = {{1{dds_data[14]}}, dds_data[14:0]};

initial begin
    repeat (150) @(posedge aclk);
    #1;
    $finish;
end

endmodule
