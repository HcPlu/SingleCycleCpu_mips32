`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/13/2019 05:47:53 PM
// Design Name: 
// Module Name: control32_1
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


module control32_1(Opcode,Jrn,Function_opcode,Alu_resultHigh,RegDST,ALUSrc,
            MemorIOtoReg,MemtoReg,RegWrite,MemRead,MemWrite,IORead,IOWrite,Branch,nBranch,
            Jmp,Jal,I_format,Sftmd,ALUOp);
input[5:0]   Opcode;            // ����ȡָ��Ԫinstruction[31..26]
input[5:0]   Function_opcode;      // ����ȡָ��Ԫr-���� instructions[5..0]
input[21:0]  Alu_resultHigh;
output       Jrn;              // Ϊ1������ǰָ����jr
output       RegDST;          // Ϊ1����Ŀ�ļĴ�����rd������Ŀ�ļĴ�����rt
output       ALUSrc;          // Ϊ1�����ڶ�������������������beq��bne���⣩
output       RegWrite;       //  Ϊ1������ָ����Ҫд�Ĵ���
output       MemorIOtoReg;
output       MemtoReg;
output       MemRead;
output       IORead;
output       IOWrite;
output       MemWrite;       //  Ϊ1������ָ����Ҫд�洢��
output       Branch;        //  Ϊ1������Beqָ��
output       nBranch;       //  Ϊ1������Bneָ��
output       Jmp;            //  Ϊ1������Jָ��
output       Jal;            //  Ϊ1������Jalָ��
output       I_format;      //  Ϊ1������ָ���ǳ�beq��bne��LW��SW֮�������I-����ָ��
output       Sftmd;         //  Ϊ1��������λָ��
output[1:0]  ALUOp;

wire Jmp,I_format,Jal,Branch,nBranch;
    wire  R_format;        // Ϊ1��ʾ��R-����ָ��
    wire Lw;               // Ϊ1��ʾ��lwָ��
    wire Sw;               // Ϊ1��ʾ��swָ��

    assign RegWrite=(R_format|Lw|Jal|I_format)&!(Jrn);
    assign MemWrite =((Sw==1)&&(Alu_resultHigh[21:0]!=22'b1111111111111111111111))?1'b1:1'b0;
    assign MemRead  =((Lw==1)&&(Alu_resultHigh[21:0]!=22'b1111111111111111111111))?1'b1:1'b0;
    assign IORead =((Lw==1)&&(Alu_resultHigh[21:0]==22'b1111111111111111111111))?1'b1:1'b0;
    assign IOWrite=((Sw==1)&&(Alu_resultHigh[21:0]==22'b1111111111111111111111))?1'b1:1'b0;
    assign MemorIOtoReg=IORead|MemRead;
   
    assign R_format = (Opcode==6'b000000)? 1'b1:1'b0;    	//--00h 
    assign RegDST = R_format;                               //˵��Ŀ����rd��������rt

    assign I_format = (Opcode[5:3]==001)? 1'b1:1'b0;
    assign Lw = (Opcode==6'b100011)? 1'b1:1'b0;
    assign Jal = (Opcode==6'b000011&&Opcode ==6'b000011)? 1'b1:1'b0; 
    assign Jrn = (Function_opcode==6'b001000&&R_format)? 1'b1:1'b0;
//    assign RegWrite = (R_format&&Function_opcode==6'b001000)?0:R_format|I_format|Lw|Jal;

    assign Sw = (Opcode==6'b101011)? 1'b1:1'b0;
    assign ALUSrc = I_format|Lw|Sw;
    assign Branch =(Opcode==6'b000100)? 1'b1:1'b0;
    assign nBranch = (Opcode==6'b000101)? 1'b1:1'b0;
    assign Jmp = (Opcode == 6'b000010)? 1'b1:1'b0;
    
//    assign MemWrite = Sw;
    assign MemtoReg = Lw;
    assign Sftmd =(Opcode==6'b000000&&Function_opcode==2'h02|Opcode == 6'b000010)?1:0;
  
    assign ALUOp = {(R_format || I_format),(Branch || nBranch)};  // ��R��type����Ҫ��������32λ��չ��ָ��1λΪ1,beq��bneָ����0λΪ1
endmodule
