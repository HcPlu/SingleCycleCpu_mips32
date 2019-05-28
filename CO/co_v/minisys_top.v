`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/20/2019 05:18:20 PM
// Design Name: 
// Module Name: minisys_top
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


module minisys_top(clock,rst,Instruction,register,Jrn,RegDST,ALUSrc,
            MemorIOtoReg,MemtoReg,RegWrite,MemRead,MemWrite,IORead,IOWrite,Branch,nBranch,
            Jmp,Jal,I_format,Sftmd,ALUOp, read_data_1, read_data_2,Sign_extend,ALU_result,Add_Result,PC_plus_4,Zero,read_data
    );
    
    input clock;
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


control32_1 control32_1(Instruction[31:26],Jrn,Instruction[5:0],ALU_result[21:0],RegDST,ALUSrc,MemorIOtoReg,MemtoReg,RegWrite,MemRead,MemWrite,IORead,IOWrite,Branch,nBranch,Jmp,Jal,I_format,Sftmd,ALUOp);
////1 get from ifect32
Idecode32   Idecode32_1(read_data_1,read_data_2,Instruction,read_data,ALU_result,Jal,RegWrite,MemtoReg,RegDST,Sign_extend,clock,rst, opcplus4,register);          

Executs32 Executs32(read_data_1,read_data_2,Sign_extend,Function_opcode,Instruction[31:26],ALUOp,Instruction[10:6],ALUSrc,I_format,Zero,Jrn,Sftmd,ALU_result,Add_Result,PC_plus_4);  

Ifetc32 Ifetc32(Instruction,PC_plus_4,Add_Result,read_data_1,Branch,nBranch,Jmp,Jal,Jrn,Zero,clock,rst,opcplus4);
dmemory32 dmemory32_2(read_data,ALU_result,read_data_2,MemWrite,clock);

    
    
endmodule
