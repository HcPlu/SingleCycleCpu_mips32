`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/23/2019 10:47:21 AM
// Design Name: 
// Module Name: sim_1
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


module sim_1(

    );
    
//    reg[31:0] read_data;
//    reg[31:0] ALU_result;
    reg clock=0;
    reg rst=1;
    
    wire[31:0] register[0:31];
    wire[31:0] Instruction;
     wire       RegDST;          // Ϊ1����Ŀ�ļĴ�����rd������Ŀ�ļĴ�����rt
    wire       ALUSrc;          // Ϊ1�����ڶ�������������������beq��bne���⣩
    wire      RegWrite;       //  Ϊ1������ָ����Ҫд�Ĵ���
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
     wire [31:0] Sign_extend;
      wire[31:0]  ALU_result;  
      wire[31:0]Add_Result;
      wire[31:0]PC_plus_4;
      wire Jrn;
      wire Zero;
     wire [31:0]  read_data;
//     reg switchread=1;
//     reg ledwrite=1;
     reg [23:0]switch_i=24'b000000000000000000000000;
     //24'b111111111111111111111111
     //24'b001000000011111111111111;
     //24'b001000000000100000000000
     wire LEDCtrl;
     wire SwitchCtrl;
     wire [23:0]ledout;
     wire[15:0]switchrdata;
     wire[31:0] write_data;
//    minisys_top top(clock,rst,Instruction,register,Jrn,RegDST,ALUSrc,
//                  MemorIOtoReg,MemtoReg,RegWrite,MemRead,MemWrite,IORead,IOWrite,Branch,nBranch,
//                  Jmp,Jal,I_format,Sftmd,ALUOp, read_data_1, read_data_2,Sign_extend,ALU_result,Add_Result,PC_plus_4,Zero, read_data
//          );


    top_2 top(1,1,switch_i,ledout,clock,rst,Instruction,register,Jrn,RegDST,ALUSrc,
            MemorIOtoReg,MemtoReg,RegWrite,MemRead,MemWrite,IORead,IOWrite,Branch,nBranch,
            Jmp,Jal,I_format,Sftmd,ALUOp, read_data_1, read_data_2,Sign_extend,ALU_result,Add_Result,
            PC_plus_4,Zero,read_data,switchrdata,LEDCtrl,SwitchCtrl,write_data);
    
    initial
    begin
  #7000  rst=0;
  //#5000 switch_i=24'b010000000000100000000000;
    end
    
     always #10 clock=~clock;
    
    
endmodule
