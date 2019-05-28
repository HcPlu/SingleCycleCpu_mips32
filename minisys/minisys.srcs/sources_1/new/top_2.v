`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/23/2019 02:53:11 PM
// Design Name: 
// Module Name: top_2
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


module top_2(switchread,ledwrite,switch_i,ledout,clk,rst,Instruction,register,Jrn,RegDST,ALUSrc,
            MemorIOtoReg,MemtoReg,RegWrite,MemRead,MemWrite,IORead,IOWrite,Branch,nBranch,
            Jmp,Jal,I_format,Sftmd,ALUOp, read_data_1, read_data_2,Sign_extend,ALU_result,Add_Result,
            PC_plus_4,Zero,read_data,switchrdata,LEDCtrl,SwitchCtrl,write_data
    );
    
    input clk;
    input rst;
    
    
    
    wire[5:0]   Opcode;            // ����ȡָ��Ԫinstruction[31..26]
    wire[5:0]   Function_opcode;      // ����ȡָ��Ԫr-���� instructions[5..0]
    output       Jrn;              // Ϊ1������ǰָ����jr
    output       RegDST;          // Ϊ1����Ŀ�ļĴ�����rd������Ŀ�ļĴ�����rt
    output       ALUSrc;          // Ϊ1�����ڶ�������������������beq��bne���⣩
    output       RegWrite;       //  Ϊ1������ָ����Ҫд�Ĵ���
    output       MemorIOtoReg;
    output       MemRead;
    output       MemtoReg;
    output       IORead;
    output       IOWrite;
    output       MemWrite;       //  Ϊ1������ָ����Ҫд�洢��
    output       Branch;        //  Ϊ1������Beqָ��
    output       nBranch;       //  Ϊ1������Bneָ��
    output       Jmp;            //  Ϊ1������Jָ��
    output       Jal;            //  Ϊ1������Jalָ��
    output       I_format;      //  Ϊ1������ָ���ǳ�beq��bne��LW��SW֮�������I-����ָ��
    output      Sftmd;         //  Ϊ1��������λָ��
    output[1:0]  ALUOp;
    
    
        output[31:0] read_data_1;               // ����ĵ�һ������
        output[31:0] read_data_2;               // ����ĵڶ�������
        output[31:0]  Instruction;               // ȡָ��Ԫ����ָ��
        output [31:0]  read_data;                   //  ��DATA RAM or I/O portȡ��������
        output[31:0]  ALU_result;                   // ��ִ�е�Ԫ��������Ľ������Ҫ��չ��������32λ
        
        output [31:0] Sign_extend;
        wire [31:0]  opcplus4;
       output reg [31:0] register[0:31];
        output[31:0]PC_plus_4;
        output[31:0]Add_Result;
        output Zero; 
       wire [31:0] caddress;
       wire [15:0] ioread_data;
       wire[31:0] mread_data;        // data from memory
       input[23:0] switch_i;
       output[23:0] ledout;
       output LEDCtrl;
       output SwitchCtrl;
       output [15:0] switchrdata;
       input switchread;
       output[31:0] write_data;
       input ledwrite;
       wire[31:0] address;
       wire clock;
      cpuclk clkc(.clk_in1(clk),.clk_out1(clock));
       
    switchs switches(clock,rst,switchread,SwitchCtrl,address[1:0],switchrdata, switch_i);
    
    ioread io(rst,IORead,SwitchCtrl,ioread_data,switchrdata);
    
           memorio2 mem(ALU_result,address,MemRead,MemWrite,IORead,IOWrite,mread_data,ioread_data,read_data_2,read_data,write_data,LEDCtrl,SwitchCtrl);
           
             dmemory32 dmemory32_2(mread_data,ALU_result,write_data,MemWrite,clock);
                
              leds led(clock,rst, ledwrite,LEDCtrl,address[1:0],write_data[15:0], ledout); 
              
control32_1 control32_1(Instruction[31:26],Jrn,Instruction[5:0],ALU_result[31:10],RegDST,ALUSrc,MemorIOtoReg,MemtoReg,RegWrite,MemRead,MemWrite,IORead,IOWrite,Branch,nBranch,Jmp,Jal,I_format,Sftmd,ALUOp);
////1 get from ifect32
  Idecode32   Idecode32_1(read_data_1,read_data_2,Instruction,read_data,ALU_result,Jal,RegWrite,MemtoReg,RegDST,Sign_extend,clock,rst, opcplus4,register);          
    
 Executs32 Executs32(read_data_1,read_data_2,Sign_extend,Function_opcode,Instruction[31:26],ALUOp,Instruction[10:6],ALUSrc,I_format,Zero,Jrn,Sftmd,ALU_result,Add_Result,PC_plus_4);  
  
    Ifetc32_2 Ifetc32(Instruction,PC_plus_4,Add_Result,read_data_1,Branch,nBranch,Jmp,Jal,Jrn,Zero,clock,rst,opcplus4);

endmodule
