`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/28/2019 08:39:24 PM
// Design Name: 
// Module Name: Idecoder32_v2
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


module Idecoder32_v2(read_data_1,read_data_2,Instruction,read_data,ALU_result,
                 Jal,RegWrite,MemtoReg,RegDst,Sign_extend,clock,reset, opcplus4, 
                 rgs_0, rgs_1, rgs_2, rgs_3, rgs_4, rgs_5, rgs_6, rgs_7, rgs_8, rgs_9, rgs_10,
                 rgs_11, rgs_12, rgs_13, rgs_14, rgs_15, rgs_16, rgs_17, rgs_18, rgs_19, rgs_20, rgs_21,
                 rgs_22, rgs_23, rgs_24, rgs_25, rgs_26, rgs_27, rgs_28, rgs_29, rgs_30, rgs_31);
    output[31:0] read_data_1;               // ����ĵ�һ������
    output[31:0] read_data_2;               // ����ĵڶ�������
    input[31:0]  Instruction;               // ȡָ��Ԫ����ָ��
    input[31:0]  read_data;   				//  ��DATA RAM or I/O portȡ��������
    input[31:0]  ALU_result;   				// ��ִ�е�Ԫ��������Ľ������Ҫ��չ��������32λ
    input        Jal;                               //  ���Կ��Ƶ�Ԫ��˵����JALָ�� 
    input        RegWrite;                  // ���Կ��Ƶ�Ԫ
    input        MemtoReg;              // ���Կ��Ƶ�Ԫ
    input        RegDst;                    //  ���Կ��Ƶ�Ԫ
    output[31:0] Sign_extend;               // ���뵥Ԫ�������չ���32λ������
    input		 clock,reset;                // ʱ�Ӻ͸�λ
    input[31:0]  opcplus4;                 // ����ȡָ��Ԫ��JAL����
    output [31:0]  rgs_0; output[31:0] rgs_1; output [31:0]  rgs_2;  output [31:0]  rgs_3;  output [31:0]  rgs_4;  output [31:0]  rgs_5;  output [31:0]  rgs_6;  output [31:0]  rgs_7; 
    output [31:0]  rgs_8; output[31:0] rgs_9; output [31:0]  rgs_10;  output [31:0]  rgs_11;  output [31:0]  rgs_12;  output [31:0]  rgs_13;  output [31:0]  rgs_14;output [31:0]  rgs_15; 
    output [31:0]  rgs_16; output[31:0] rgs_17; output [31:0]  rgs_18;  output [31:0]  rgs_19;  output [31:0]  rgs_20;  output [31:0]  rgs_21;  output [31:0]  rgs_22;  output [31:0]  rgs_23;
    output [31:0]  rgs_24; output[31:0] rgs_25; output [31:0]  rgs_26;  output [31:0]  rgs_27;  output [31:0]  rgs_28;  output [31:0]  rgs_29;  output [31:0]  rgs_30;  output [31:0]  rgs_31; 
    wire[31:0] read_data_1;
    wire[31:0] read_data_2;
    reg[31:0] register[0:31];			   //�Ĵ����鹲32��32λ�Ĵ���
    reg[4:0] write_register_address;        // Ҫд�ļĴ����ĺ�
    reg[31:0] write_data;                   // Ҫд�Ĵ��������ݷ�����

    wire[4:0] read_register_1_address;    // Ҫ���ĵ�һ���Ĵ����ĺţ�rs��
    wire[4:0] read_register_2_address;     // Ҫ���ĵڶ����Ĵ����ĺţ�rt��
    wire[4:0] write_register_address_1;   // r-formָ��Ҫд�ļĴ����ĺţ�rd��
    wire[4:0] write_register_address_0;    // i-formָ��Ҫд�ļĴ����ĺ�(rt)
    wire[15:0] Instruction_immediate_value;  // ָ���е�������
    wire[5:0] opcode;                       // ָ����
    
    assign opcode = Instruction[31:26];	//OP
    assign read_register_1_address =Instruction[25:21];//rs 
    assign read_register_2_address = Instruction[20:16];//rt 
    assign write_register_address_1 = Instruction[15:11];// rd(r-form)
    assign write_register_address_0 = Instruction[20:16];//rt(i-form)
    assign Instruction_immediate_value = Instruction[15:0];//data,rladr(i-form)
    

    wire sign;                                         // ȡ����λ��ֵ
    reg ext;
    assign sign = Instruction_immediate_value[15];
    always @(*)
    begin
    if(opcode==6'b001101||opcode==6'b001100)
        ext=register[0][0];
    else
        ext=sign;
    end
    assign Sign_extend[31:0] = {{16{ext}},Instruction_immediate_value[15:0]};
    
    assign read_data_1 = register[read_register_1_address];
    assign read_data_2 = register[read_register_2_address];
    
    always @* begin   
    if(Jal==1) begin
    write_register_address<=31;
    end else if(RegDst==1)begin
    write_register_address<=write_register_address_1;
    end  else
     write_register_address<=write_register_address_0;                                   //�������ָ����ָͬ���µ�Ŀ��Ĵ���

    end
    
    always @* begin  //������̻�������ʵ�ֽṹͼ�����µĶ�·ѡ����,׼��Ҫд������
     if(Jal==1)
     write_data<=opcplus4;
     else if(MemtoReg==0)
     write_data<=ALU_result;
     else write_data<=read_data;
     end
    
    integer i;
    always @(posedge clock) begin  // ������дĿ��Ĵ���  
        if(reset==1) begin              // ��ʼ���Ĵ�����
            for(i=0;i<32;i=i+1) register[i] <= i;
        end else if(RegWrite==1) begin  // ע��Ĵ���0�����0
             register[write_register_address]<=write_data;
        end else register[write_register_address]<=write_data;
    end
    assign rgs_0=register[0];    
    assign rgs_1=register[1];
    assign rgs_2=register[2];
    assign rgs_3=register[3];
    assign rgs_4=register[4];
    assign rgs_5=register[5];
    assign rgs_6=register[6];
    assign rgs_7=register[7];
    
    assign rgs_8=register[8];
    assign rgs_9=register[9];
    assign rgs_10=register[10];
    assign rgs_11=register[11];
    assign rgs_12=register[12];
    assign rgs_13=register[13];
    assign rgs_14=register[14];
    assign rgs_15=register[15];
    
      assign rgs_16=register[16];
      assign rgs_17=register[17];
      assign rgs_18=register[18];
      assign rgs_19=register[19];
      assign rgs_20=register[20];
      assign rgs_21=register[21];
      assign rgs_22=register[22];
      assign rgs_23=register[23];
     
      assign rgs_24=register[24];
      assign rgs_25=register[25];
      assign rgs_26=register[26];
      assign rgs_27=register[27];
      assign rgs_28=register[28];
      assign rgs_29=register[29];
      assign rgs_30=register[30];
      assign rgs_31=register[31];
endmodule
