`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/28/2019 08:42:23 PM
// Design Name: 
// Module Name: sim_de_v_2
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


module sim_de_v_2(
    );
    // input 
    reg[31:0]  Instruction = 32'b000000_00010_00011_00111_00000_100000; //add $7,$2,$3
    reg[31:0]  read_data = 32'h00000000;                    //  从DATA RAM or I/O port取出的数据
    reg[31:0]  ALU_result = 32'h00000005;                   //  需要扩展立即数到32位
    reg        Jal = 1'b0; 
    reg        RegWrite = 1'b1;
    reg        MemtoReg = 1'b0;
    reg        RegDst = 1'b1;
    reg         clock = 1'b0 ,reset = 1'b1;
    reg[31:0]  opcplus4 = 32'h00000004;                 // 来自取指单元，JAL中用
    // output
    wire[31:0] read_data_1;
    wire[31:0] read_data_2;
    wire[31:0] Sign_extend;
    wire [31:0]  rgs_0; wire[31:0] rgs_1; wire [31:0]  rgs_2;  wire [31:0]  rgs_3;  wire[31:0]  rgs_4;  wire [31:0]  rgs_5; wire [31:0]  rgs_6; wire [31:0]  rgs_7; 
       wire [31:0]  rgs_8; wire[31:0] rgs_9; wire [31:0]  rgs_10; wire [31:0]  rgs_11;  wire [31:0]  rgs_12;  wire [31:0]  rgs_13;  wire [31:0]  rgs_14;wire [31:0]  rgs_15; 
        wire [31:0]  rgs_16; wire[31:0] rgs_17; wire [31:0]  rgs_18;  wire [31:0]  rgs_19; wire [31:0]  rgs_20;  wire [31:0]  rgs_21;  wire [31:0]  rgs_22;  wire [31:0]  rgs_23;
        wire [31:0]  rgs_24; wire[31:0] rgs_25; wire [31:0]  rgs_26; wire[31:0]  rgs_27;  wire [31:0]  rgs_28; wire [31:0]  rgs_29; wire [31:0]  rgs_30;  wire [31:0]  rgs_31; 
    Idecoder32_v2 Uid(read_data_1,read_data_2,Instruction,read_data,ALU_result,
                     Jal,RegWrite,MemtoReg,RegDst,Sign_extend,clock,reset, opcplus4,
                     rgs_0, rgs_1, rgs_2, rgs_3, rgs_4, rgs_5, rgs_6, rgs_7, rgs_8, rgs_9, rgs_10,
                     rgs_11, rgs_12, rgs_13, rgs_14, rgs_15, rgs_16, rgs_17, rgs_18, rgs_19, rgs_20, rgs_21,
                     rgs_22, rgs_23, rgs_24, rgs_25, rgs_26, rgs_27, rgs_28, rgs_29, rgs_30, rgs_31);

    initial begin
        #200   reset = 1'b0;
        #200   begin Instruction = 32'b001000_00111_00011_1000000000110111;  //addi $3,$7,0X8037
                    read_data = 32'h00000000; 
                    ALU_result = 32'hFFFF803c;
                    Jal = 1'b0;
                    RegWrite = 1'b1;
                    MemtoReg = 1'b0;
                    RegDst = 1'b0;
                    opcplus4 = 32'h00000008; 
               end
        #200   begin Instruction = 32'b001100_00010_00100_1000000010010111;  //andi $4,$2,0X8097
                           read_data = 32'h00000000; 
                           ALU_result = 32'h00000002;
                           Jal = 1'b0;
                           RegWrite = 1'b1;
                           MemtoReg = 1'b0;
                           RegDst = 1'b0;
                           opcplus4 = 32'h0000000c; 
                end
        #200   begin Instruction = 32'b000000_00000_00001_00101_00010_000000;  //sll $5,$1,2
                                   read_data = 32'h00000000; 
                                   ALU_result = 32'h00000004;
                                   Jal = 1'b0;
                                   RegWrite = 1'b1;
                                   MemtoReg = 1'b0;
                                   RegDst = 1'b1;
                                   opcplus4 = 32'h00000010; 
               end
        #200   begin Instruction = 32'b100011_00000_00110_0000000100000000;  //LW $6,0(0X100)
                                          read_data = 32'h0000007B; 
                                          ALU_result = 32'h00000054;
                                          Jal = 1'b0;
                                          RegWrite = 1'b1;
                                          MemtoReg = 1'b1;
                                          RegDst = 1'b0;
                                          opcplus4 = 32'h00000014; 
               end
        #200   begin Instruction = 32'b000011_00000000000000000000000000;  //JAL 0000
                                          read_data = 32'h00000000; 
                                          ALU_result = 32'h00000004;
                                          Jal = 1'b1;
                                          RegWrite = 1'b1;
                                          MemtoReg = 1'b0;
                                          RegDst = 1'b0;
                                          opcplus4 = 32'h00000018; 
               end
    end 
    always #50 clock = ~clock;  
endmodule
