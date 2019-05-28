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
     wire       RegDST;          // 为1表明目的寄存器是rd，否则目的寄存器是rt
    wire       ALUSrc;          // 为1表明第二个操作数是立即数（beq，bne除外）
    wire      RegWrite;       //  为1表明该指令需要写寄存器
    wire       MemorIOtoReg;
    wire       MemRead;
    wire       MemtoReg;
    wire       IORead;
    wire       IOWrite;
    wire       MemWrite;       //  为1表明该指令需要写存储器
    wire       Branch;        //  为1表明是Beq指令
    wire       nBranch;       //  为1表明是Bne指令
    wire       Jmp;            //  为1表明是J指令
    wire       Jal;            //  为1表明是Jal指令
    wire       I_format;      //  为1表明该指令是除beq，bne，LW，SW之外的其他I-类型指令
    wire      Sftmd;         //  为1表明是移位指令
    wire[1:0]  ALUOp;
    wire[31:0] read_data_1;               // 输出的第一操作数
    wire[31:0] read_data_2;               // 输出的第二操作数
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
