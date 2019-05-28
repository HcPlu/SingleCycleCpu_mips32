`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/26/2019 12:44:16 AM
// Design Name: 
// Module Name: top_3_sim
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


module top_3_sim(

    );
    reg rst=1;
    reg clk=0;
    
    reg[23:0] switch_i=24'b000000000000000000000000;
    wire[23:0] ledout;
  top t(clk,rst,ledout,switch_i);
        initial
    begin
  #7000  rst=0;
 // #5000 switch_i=24'b010000000000100000000000;
    end
    
     always #10 clk=~clk;
endmodule
