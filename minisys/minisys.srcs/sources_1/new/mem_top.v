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
switch_i,//�Ӱ����϶�
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
          //  input[5:0]   Opcode;            // ����ȡָ��Ԫinstruction[31..26]
         //   input[5:0]   Function_opcode;      // ����ȡָ��Ԫr-���� instructions[5..0]
       //     input[21:0]  Alu_resultHigh;
            input[31:0] wdata;			// the data from idecode32,that want to write memory or io
            input [23:0] switch_i;
            input switchread;
            output [15:0] switchrdata;
            
           output[31:0] rdata;            // data from memory or IO that want to read into register
           output [31:0] write_data;    // data to memory or I/O
           wire[31:0] address;       // address to mAddress and I/O
           output[23:0] ledout;
         //   wire       Jrn;              // Ϊ1������ǰָ����jr
      //      wire       RegDST;          // Ϊ1����Ŀ�ļĴ�����rd������Ŀ�ļĴ�����rt
        //    wire       ALUSrc;          // Ϊ1�����ڶ�������������������beq��bne���⣩
    //        wire       RegWrite;       //  Ϊ1������ָ����Ҫд�Ĵ���
     //       wire       MemorIOtoReg;
            input       MemRead;
            input       IORead;
            input       IOWrite;
            input       MemWrite;       //  Ϊ1������ָ����Ҫд�洢��
           // wire       Branch;        //  Ϊ1������Beqָ��
        //   wire       nBranch;       //  Ϊ1������Bneָ��
           // wire       Jmp;            //  Ϊ1������Jָ��
         //   wire       Jal;            //  Ϊ1������Jalָ��
          //  wire       I_format;      //  Ϊ1������ָ���ǳ�beq��bne��LW��SW֮�������I-����ָ��
        //    wire       Sftmd;         //  Ϊ1��������λָ��
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
