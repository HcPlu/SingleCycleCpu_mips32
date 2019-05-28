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
    
    
    
    wire[5:0]   Opcode;            // 来自取指单元instruction[31..26]
    wire[5:0]   Function_opcode;      // 来自取指单元r-类型 instructions[5..0]
    output       Jrn;              // 为1表明当前指令是jr
    output       RegDST;          // 为1表明目的寄存器是rd，否则目的寄存器是rt
    output       ALUSrc;          // 为1表明第二个操作数是立即数（beq，bne除外）
    output       RegWrite;       //  为1表明该指令需要写寄存器
    output       MemorIOtoReg;
    output       MemRead;
    output       MemtoReg;
    output       IORead;
    output       IOWrite;
    output       MemWrite;       //  为1表明该指令需要写存储器
    output       Branch;        //  为1表明是Beq指令
    output       nBranch;       //  为1表明是Bne指令
    output       Jmp;            //  为1表明是J指令
    output       Jal;            //  为1表明是Jal指令
    output       I_format;      //  为1表明该指令是除beq，bne，LW，SW之外的其他I-类型指令
    output      Sftmd;         //  为1表明是移位指令
    output[1:0]  ALUOp;
    
    
        output[31:0] read_data_1;               // 输出的第一操作数
    output[31:0] read_data_2;               // 输出的第二操作数
    output[31:0]  Instruction;               // 取指单元来的指令
    output [31:0]  read_data;                   //  从DATA RAM or I/O port取出的数据
    output[31:0]  ALU_result;                   // 从执行单元来的运算的结果，需要扩展立即数到32位
    
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
