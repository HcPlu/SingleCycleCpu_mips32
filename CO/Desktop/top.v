`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/05/20 09:30:12
// Design Name: 
// Module Name: top
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


module top(clk,rst,ledout,switch_i);
            input clk;
           wire clock;
            wire[31:0]aluresult;
            input rst;
            input [23:0] switch_i;
            wire [15:0] ioread_data_switch;
            wire[31:0] rdata;            // data from memory or IO that want to read into register
            wire [31:0] write_data;    // data to memory or I/O
           wire [31:0] address;       // address to mAddress and I/O
            output[23:0] ledout;
            wire memread;
           wire ioread;
            wire iowrite;
            wire memwrite;       //  为1表明该指令需要写存储器
            wire LEDCtrl;
            wire switchctrl;
            wire [15:0] ioread_data;
            wire[31:0] read_data;		// data from memory
            wire[31:0]ALU_Result;
            wire[31:0]Read_data_1;
            wire[31:0]Read_data_2;
           wire [31:0]Instruction;
            wire RegWrite;
            wire MemorIOtoReg;
            wire[31:0]Sign_extend;
            wire[31:0]opcplus4;
            
            wire Branch;
            wire nBranch;
            wire[1:0]ALUOp;
            wire Sftmd;
            wire ALUSrc;
            wire I_format;
            wire [31:0]Add_Result;
            wire [31:0]PC_plus_4;
            wire Jmp;
            wire Jal;
            wire Jrn;
            wire Zero;
            wire RegDst;

cpuclk cl(clock,clk);           
  Ifetc32 ife(Instruction,PC_plus_4,Add_Result,Read_data_1,Branch,nBranch
  ,Jmp,Jal,Jrn,Zero,clock,rst,opcplus4);
 Executs32 ex(Read_data_1,Read_data_2,Sign_extend,Instruction[5:0],Instruction[31:26],ALUOp,
                   Instruction[10:6],ALUSrc,I_format,Zero,Jrn,Sftmd,ALU_Result,Add_Result,PC_plus_4
                   ) ;
Idecode32 ide(Read_data_1,Read_data_2,Instruction,rdata,ALU_Result,
              Jal,RegWrite,MemorIOtoReg,RegDst,Sign_extend,clock,rst,opcplus4);
control32 ctr(Instruction[31:26],Instruction[5:0],ALU_Result[31:10],Jrn,RegDst,ALUSrc,MemorIOtoReg,RegWrite,
                                    memread,
                                    memwrite,
                                    ioread,iowrite,
                                    Branch,nBranch,Jmp,Jal,I_format,Sftmd,ALUOp
                                    );   
                                                        
switchs s1(clock,rst,ioread,switchctrl,ALU_Result[1:0],ioread_data_switch, switch_i);//memio
dmemory32 d1(read_data,address,write_data,memwrite,clock);//NC
 ioread i1(rst,ioread,switchctrl,ioread_data,ioread_data_switch);//NC
 memorio m1(ALU_Result,address,memread,memwrite,ioread,iowrite,read_data,ioread_data,
Read_data_2,rdata,write_data,LEDCtrl,switchctrl);//NC
 leds l1(clock,rst,iowrite,LEDCtrl,ALU_Result[1:0],write_data,ledout);//io
endmodule
