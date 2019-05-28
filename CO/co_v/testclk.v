`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/26/2019 12:55:16 AM
// Design Name: 
// Module Name: testclk
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


module testclk(clk,clock

    );
    input clk;
    output clock;
    cpuclk clkc(.clk_in1(clk),.clk_out1(clock));
endmodule
