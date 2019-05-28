`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/19/2019 04:54:06 PM
// Design Name: 
// Module Name: mem_top_sim
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


module mem_top_sim();
reg IORead=0;
reg IOWrite=0;
reg switchread=0;
reg MemWrite=0;
reg MemRead=0;
reg [23:0]switch_i=24'b100000000000000000001111;
reg [31:0]caddress= 32'hFFFFFC70;
reg ledwrite=0;
reg clk=0;
reg rst=1;
reg[31:0] wdata=0;
wire [31:0]rdata;
wire [23:0]ledout;
wire [15:0] switchrdata;
wire[15:0] ioread_data;
wire LEDCtrl;
wire SwitchCtrl;
wire[31:0]write_data;
wire[31:0]mread_data;

 mem_top top(IORead,IOWrite,MemRead,MemWrite,switchread,ledwrite,switch_i,caddress,clk,rst,wdata,rdata,ledout,switchrdata,ioread_data,LEDCtrl,SwitchCtrl,write_data,mread_data);
 initial begin 
 #200 begin rst=0;switchread=1;IORead=1;end
 #200 begin caddress= 32'hFFFFFC72;end
 #200 begin IORead=0;wdata=24'b100000000000000000001111;switchread=0;MemWrite=1;caddress=1;end
 #200 begin MemWrite=0;MemRead=1;wdata=1;end
 #200 begin IOWrite=1;caddress= 32'hFFFFFC60;ledwrite=1;end
 #200 begin caddress= 32'hFFFFFC62;end
 end
 
     always #50 clk = ~clk;  
endmodule
