`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
module control32(Opcode,Function_opcode,ALU_resultHigh,Jrn,RegDST,ALUSrc,MemorIOtoReg,RegWrite,
MemRead,
MemWrite,
IORead,IOWrite,
Branch,nBranch,Jmp,Jal,I_format,Sftmd,ALUOp
);
    input[5:0]   Opcode;            // ����ȡָ��Ԫinstruction[31..26]
    input[5:0]   Function_opcode;  	// ����ȡָ��Ԫr-���� instructions[5..0]
    input[21:0] ALU_resultHigh;
    output MemRead;
    output IORead;
    output IOWrite;
    output       Jrn;         	 // Ϊ1������ǰָ����jr
    output       RegDST;          // Ϊ1����Ŀ�ļĴ�����rd������Ŀ�ļĴ�����rt
    output       ALUSrc;          // Ϊ1�����ڶ�������������������beq��bne���⣩
    output       MemorIOtoReg;   	//  Ϊ1������Ҫ�Ӵ洢�������ݵ��Ĵ���
    output       RegWrite;   	//  Ϊ1������ָ����Ҫд�Ĵ���
    output       MemWrite;   	//  Ϊ1������ָ����Ҫд�洢��
    output       Branch;    	//  Ϊ1������Beqָ��
    output       nBranch;   	//  Ϊ1������Bneָ��
    output       Jmp;        	//  Ϊ1������Jָ��
    output       Jal;        	//  Ϊ1������Jalָ��
    output       I_format;  	//  Ϊ1������ָ���ǳ�beq��bne��LW��SW֮�������I-����ָ��
    output       Sftmd;     	//  Ϊ1��������λָ��
    output[1:0]  ALUOp;	        //  ��R-���ͻ�I_format=1ʱλ1Ϊ1, beq��bneָ����λ0Ϊ1
   
    wire Jmp,I_format,Jal,Branch,nBranch;
    wire R_format;        // Ϊ1��ʾ��R-����ָ��
    wire Lw;               // Ϊ1��ʾ��lwָ��
    wire Sw;               // Ϊ1��ʾ��swָ��

    
   
    assign R_format = (Opcode==6'b000000)? 1'b1:1'b0;    	//--00h 
    assign RegDST = R_format;                               //˵��Ŀ����rd��������rt

    assign I_format = (Opcode>=6'b001000&&Opcode<=6'b001111)?1'b1:1'b0;
    assign Lw = (Opcode==6'b100011)?1'b1:1'b0;
    assign Jal = (Opcode==6'b000011)?1'b1:1'b0; 
    assign Jrn = (Opcode==6'b000000&&Function_opcode==6'b001000)?1'b1:1'b0;   
    assign RegWrite= (R_format||Lw||Jal||I_format)&&!(Jrn);
//û�ж�or and not�ķ���
    assign Sw = (Opcode==6'b101011)?1'b1:1'b0;
    assign ALUSrc = ((Opcode<=6'b001111&&Opcode>=6'b001000)||Opcode==6'b100011||Opcode==6'b101011)?1'b1:1'b0;
    assign Branch = (Opcode==6'b000100)?1'b1:1'b0;
    assign nBranch=(Opcode==6'b000101)?1'b1:1'b0;
    assign Jmp = (Opcode==6'b000010)?1'b1:1'b0;
    
    assign MemWrite =((Sw==1)&&(ALU_resultHigh[21:0]!=22'b1111_1111_1111_1111_1111_11))?1'b1:1'b0;
    assign MemRead=((Lw==1)&&(ALU_resultHigh[21:0]!=22'b1111_1111_1111_1111_1111_11))?1'b1:1'b0;
    assign IORead=((Lw==1)&&(ALU_resultHigh[21:0]==22'b1111_1111_1111_1111_1111_11))?1'b1:1'b0;
    assign IOWrite=((Sw==1)&&(ALU_resultHigh[21:0]==22'b1111_1111_1111_1111_1111_11))?1'b1:1'b0;
    assign MemorIOtoReg = IORead||MemRead;
    assign Sftmd = (Opcode==6'b000000&&(Function_opcode<=6'b000111&&Function_opcode>=6'b000000))?1'b1:1'b0;
  
    assign ALUOp = {(R_format || I_format),(Branch || nBranch)};  // ��R��type����Ҫ��������32λ��չ��ָ��1λΪ1,beq��bneָ����0λΪ1
endmodule
