`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/26/2019 12:04:24 AM
// Design Name: 
// Module Name: final_top
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


module final_top(switch_i,ledout,clk,rst);
    input clk;
    input rst;
    input[23:0] switch_i;
    output[23:0] ledout;
    
    
    
    wire[5:0]   Opcode;            // ����ȡָ��Ԫinstruction[31..26]
    wire[5:0]   Function_opcode;      // ����ȡָ��Ԫr-���� instructions[5..0]
    wire       Jrn;              // Ϊ1������ǰָ����jr
    wire       RegDST;          // Ϊ1����Ŀ�ļĴ�����rd������Ŀ�ļĴ�����rt
    wire       ALUSrc;          // Ϊ1�����ڶ�������������������beq��bne���⣩
    wire       RegWrite;       //  Ϊ1������ָ����Ҫд�Ĵ���
    wire       MemorIOtoReg;
    wire       MemRead;
    wire       MemtoReg;
    wire       IORead;
    wire       IOWrite;
    wire       MemWrite;       //  Ϊ1������ָ����Ҫд�洢��
    wire       Branch;        //  Ϊ1������Beqָ��
    wire       nBranch;       //  Ϊ1������Bneָ��
    wire       Jmp;            //  Ϊ1������Jָ��
    wire       Jal;            //  Ϊ1������Jalָ��
    wire       I_format;      //  Ϊ1������ָ���ǳ�beq��bne��LW��SW֮�������I-����ָ��
    wire      Sftmd;         //  Ϊ1��������λָ��
    wire[1:0]  ALUOp;
    
    
     wire[31:0] read_data_1;               // ����ĵ�һ������
     wire[31:0] read_data_2;               // ����ĵڶ�������
     wire[31:0]  Instruction;               // ȡָ��Ԫ����ָ��
     wire [31:0]  read_data;                   //  ��DATA RAM or I/O portȡ��������
     wire[31:0]  ALU_result;                   // ��ִ�е�Ԫ��������Ľ������Ҫ��չ��������32λ
        
     wire [31:0] Sign_extend;
     wire [31:0]  opcplus4;
     reg [31:0] register[0:31];
     wire[31:0]PC_plus_4;
     wire[31:0]Add_Result;
     wire Zero; 
     wire [31:0] caddress;
     wire [15:0] ioread_data;
     wire[31:0] mread_data;        // data from memory
     wire  LEDCtrl;
     wire SwitchCtrl;
     wire [15:0] switchrdata;
     reg  switchread;
     wire[31:0] write_data;
     reg ledwrite;
     wire[31:0] address;
     wire clock;
     cpuclk clkc(clock,clk);
       
    switchs switches(clock,rst,IORead,SwitchCtrl,address[1:0],switchrdata, switch_i);
    
    ioread io(rst,IORead,SwitchCtrl,ioread_data,switchrdata);
    
           memorio2 mem(ALU_result,address,MemRead,MemWrite,IORead,IOWrite,mread_data,ioread_data,read_data_2,read_data,write_data,LEDCtrl,SwitchCtrl);
           
             dmemory32 dmemory32_2(mread_data,ALU_result,write_data,MemWrite,clock);
                
              leds led(clock,rst, IOWrite,LEDCtrl,address[1:0],write_data[15:0], ledout); 
              
control32_1 control32_1(Instruction[31:26],Jrn,Instruction[5:0],ALU_result[31:10],RegDST,ALUSrc,MemorIOtoReg,MemtoReg,RegWrite,MemRead,MemWrite,IORead,IOWrite,Branch,nBranch,Jmp,Jal,I_format,Sftmd,ALUOp);
////1 get from ifect32
  Idecode32   Idecode32_1(read_data_1,read_data_2,Instruction,read_data,ALU_result,Jal,RegWrite,MemtoReg,RegDST,Sign_extend,clock,rst, opcplus4,register);          
    
 Executs32 Executs32(read_data_1,read_data_2,Sign_extend,Instruction[5:0],Instruction[31:26],ALUOp,Instruction[10:6],ALUSrc,I_format,Zero,Jrn,Sftmd,ALU_result,Add_Result,PC_plus_4);  
  
    Ifetc32_2 Ifetc32(Instruction,PC_plus_4,Add_Result,read_data_1,Branch,nBranch,Jmp,Jal,Jrn,Zero,clock,rst,opcplus4);

endmodule
