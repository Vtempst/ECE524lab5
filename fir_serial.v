`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/09/2026 02:04:58 AM
// Design Name: 
// Module Name: fir_serial
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


module fir_serial(
input clk,
input rst,
input in_valid,
input signed [15:0] data_in,
output wire in_ready,
output reg out_valid,
output reg signed [36:0] data_out
    );
    
reg signed [15:0] coeff [0:20];
reg signed [15:0] samples [0:20];
reg busy;
reg [4:0] tap;
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

assign in_ready = ~busy & ~rst;

always @(posedge clk) begin
    if(rst)
    begin
        busy <= 0;
        tap <= 0;
        accumulator <= 0;
        data_out <= 0;
        out_valid <= 0;
        for(i = 0; i < 21; i = i + 1) 
        begin
            samples[i] <= 0;
        end
    end
    else
    begin
        out_valid <= 0;
        if (in_valid && in_ready)
        begin
            for(j = 1; j < 21; j = j + 1)
            begin
                samples[j] <= samples[j - 1];
            end
            busy <= 1;
            tap <= 0;
            accumulator <= 0;
            samples[0] <= data_in;
        end
        else if(busy)
        begin
            if (tap < 20)
            begin
                accumulator <= accumulator + samples[tap] * coeff[tap];
                tap <= tap + 1;
            end
            else if(tap == 20)
            begin
                data_out <= accumulator + (samples[20] * coeff[20]);
                out_valid <= 1;
                busy <= 0;
                tap <= 0;
            end
        end
    end
end

endmodule
