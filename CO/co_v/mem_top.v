`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/16/2019 11:25:38 AM
// Design Name: 
// Module Name: mem_top
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


module mem_top(
IORead,
IOWrite,
MemRead,
MemWrite,
switchread,
ledwrite,
switch_i,//从板子上读
caddress,
clk,rst,
wdata,
rdata,
ledout,
switchrdata,
ioread_data,
LEDCtrl,
SwitchCtrl,
write_data,
mread_data);
            

            input[31:0] caddress;
                        input ledwrite;//???
            input clk;
            input rst;
          //  input[5:0]   Opcode;            // 来自取指单元instruction[31..26]
         //   input[5:0]   Function_opcode;      // 来自取指单元r-类型 instructions[5..0]
       //     input[21:0]  Alu_resultHigh;
            input[31:0] wdata;			// the data from idecode32,that want to write memory or io
            input [23:0] switch_i;
            input switchread;
            output [15:0] switchrdata;
            
           output[31:0] rdata;            // data from memory or IO that want to read into register
           output [31:0] write_data;    // data to memory or I/O
           wire[31:0] address;       // address to mAddress and I/O
           output[23:0] ledout;
         //   wire       Jrn;              // 为1表明当前指令是jr
      //      wire       RegDST;          // 为1表明目的寄存器是rd，否则目的寄存器是rt
        //    wire       ALUSrc;          // 为1表明第二个操作数是立即数（beq，bne除外）
    //        wire       RegWrite;       //  为1表明该指令需要写寄存器
     //       wire       MemorIOtoReg;
            input       MemRead;
            input       IORead;
            input       IOWrite;
            input       MemWrite;       //  为1表明该指令需要写存储器
           // wire       Branch;        //  为1表明是Beq指令
        //   wire       nBranch;       //  为1表明是Bne指令
           // wire       Jmp;            //  为1表明是J指令
         //   wire       Jal;            //  为1表明是Jal指令
          //  wire       I_format;      //  为1表明该指令是除beq，bne，LW，SW之外的其他I-类型指令
        //    wire       Sftmd;         //  为1表明是移位指令
            output LEDCtrl;
            output SwitchCtrl;

            output [15:0] ioread_data;
            output[31:0] mread_data;		// data from memory

        switchs switches(clk,rst,switchread,SwitchCtrl,caddress[1:0],switchrdata, switch_i);
        ioread io(rst,IORead,SwitchCtrl,ioread_data,switchrdata);
//         control32_1 control32_1(Opcode,Jrn,Function_opcode,Alu_resultHigh,RegDST,ALUSrc,MemorIOtoReg,RegWrite,MemRead,MemWrite,IORead,IOWrite,Branch,nBranch,
//                Jmp,Jal,I_format,Sftmd,ALUOp);            
         memorio2 mem(caddress,address,MemRead,MemWrite,IORead,IOWrite,mread_data,ioread_data,wdata,rdata,write_data,LEDCtrl,SwitchCtrl);
    
         dmemory32 dmem32(mread_data,address,write_data,MemWrite,clk);

         leds led(clk,rst, ledwrite,LEDCtrl,caddress[1:0],write_data, ledout);  
    
endmodule
