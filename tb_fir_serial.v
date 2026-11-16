`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/09/2026 03:22:01 AM
// Design Name: 
// Module Name: tb_fir_serial
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


module tb_fir_serial();
reg clk;
reg rst;
reg in_valid;
reg signed [15:0] data_in;
wire in_ready;
wire out_valid;
wire signed [36:0] data_out;

wire dds_valid;
wire [15:0] dds_data;
wire dds_phase_valid;
wire [31:0] dds_phase_data;

integer i;

dds_serial_1p6m dds_inst (
  .aclk(clk),                                // input wire aclk
  .m_axis_data_tvalid(dds_valid),    // output wire m_axis_data_tvalid
  .m_axis_data_tdata(dds_data),      // output wire [15 : 0] m_axis_data_tdata
  .m_axis_phase_tvalid(dds_phase_valid),  // output wire m_axis_phase_tvalid
  .m_axis_phase_tdata(dds_phase_data)    // output wire [23 : 0] m_axis_phase_tdata
);

fir_serial uut(
    .clk(clk),
    .rst(rst),
    .in_valid(in_valid),
    .data_in(data_in),
    .in_ready(in_ready),
    .out_valid(out_valid),
    .data_out(data_out)
);

initial begin
    clk = 0;
    forever #4.545 clk = ~clk;
end

initial begin

rst = 1;
//data_in = 0;
//in_valid = 0;
repeat (2) @(posedge clk);
@(negedge clk);
rst = 0;

//wait(in_ready == 1'b1);
//data_in = 16'sd100;
//in_valid = 1;
//@(posedge clk);
//@(negedge clk);
//in_valid = 0;

//for(i = 0; i < 20; i = i + 1)
//begin
//    wait(in_ready == 1'b1);
//    data_in = 0;
//    in_valid = 1;
//    @(posedge clk);
//    @(negedge clk);
//    in_valid = 0;
//end

//wait(out_valid == 1'b1);
//@(negedge clk);
//$finish;

end

initial begin
    repeat (4500) @(posedge clk);
    #1;
    $finish;
end

always @(*) begin
    data_in = {{1{dds_data[14]}}, dds_data[14:0]};
    in_valid = dds_valid;
end

endmodule
