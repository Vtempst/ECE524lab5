`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/08/2026 11:45:36 PM
// Design Name: 
// Module Name: fir_parallel
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


module fir_parallel(
input clk,
input rst,
input signed [15:0] data_in,
output reg signed [36:0] data_out
    );

reg signed [15:0] coeff [0:20];
reg signed [15:0] samples [0:20];
reg signed [36:0] accumulator;
integer i;
integer j; 

initial begin
    coeff[0] = 16'sd0;
    coeff[1] = 16'sd113;
    coeff[2] = 16'sd0;
    coeff[3] = -16'sd389;
    coeff[4] = 16'sd0;
    coeff[5] = 16'sd1107;
    coeff[6] = 16'sd0;
    coeff[7] = -16'sd2797;
    coeff[8] = 16'sd0;
    coeff[9] = 16'sd10172;
    coeff[10] = 16'sd16356;
    coeff[11] = 16'sd10172;
    coeff[12] = 16'sd0;
    coeff[13] = -16'sd2797;
    coeff[14] = 16'sd0;
    coeff[15] = 16'sd1107;
    coeff[16] = 16'sd0;
    coeff[17] = -16'sd389;
    coeff[18] = 16'sd0;
    coeff[19] = 16'sd113;
    coeff[20] = 16'sd0;    
end

always @(posedge clk) begin
    if(rst)
        begin
            for(i = 0; i < 21; i = i + 1) 
            begin
                samples[i] <= 0;
            end
        end
    else
    begin
        samples[0] <= data_in;
        for(i = 1; i < 21; i = i + 1) 
        begin
            samples[i] <= samples[i - 1];
        end
    end
end

always @(*) begin
    accumulator = 0;
    for(j = 0; j < 21; j = j + 1)
    begin
        accumulator = accumulator + (samples[j] * coeff[j]);
    end
end

always @(posedge clk) begin
    if(rst) 
        begin
            data_out <= 0;
        end
    else
    begin
        data_out <= accumulator;
    end
end
endmodule
