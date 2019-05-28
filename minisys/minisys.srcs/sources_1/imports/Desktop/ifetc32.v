module Ifetc32(Instruction,PC_plus_4_out,Add_result,Read_data_1,Branch,nBranch,Jmp,Jal,Jrn,Zero,clock,reset,opcplus4);
    output[31:0] Instruction;			// ���ָ�����ģ��
    output[31:0] PC_plus_4_out;         // (pc+4)��ִ�е�Ԫ
    input[31:0]  Add_result;            // ����ִ�е�Ԫ,�������ת��ַ
    input[31:0]  Read_data_1;           // �������뵥Ԫ��jrָ���õĵ�ַ
    input        Branch;                // ���Կ��Ƶ�Ԫ
    input        nBranch;               // ���Կ��Ƶ�Ԫ
    input        Jmp;                   // ���Կ��Ƶ�Ԫ
    input        Jal;                   // ���Կ��Ƶ�Ԫ
    input        Jrn;                   // ���Կ��Ƶ�Ԫ
    input        Zero;                  //����ִ�е�Ԫ
    input        clock,reset;           //ʱ���븴λ
    output[31:0] opcplus4;              // JALָ��ר�õ�PC+4
    wire[31:0]   PC_plus_4;             // PC+4
     reg[31:0]	  PC;                   // PC�Ĵ����������������
    reg[31:0]    next_PC;               // ����ָ���PC����һ����PC+4)
    reg[31:0]    opcplus4;
   //����64KB ROM��������ʵ��ֻ�� 64KB ROM
    prgrom instmem(
        .clka(clock),         // input wire clka
        .addra(PC[15:2]),     // input wire [13 : 0] addra
        .douta(Instruction)         // output wire [31 : 0] douta
    );

    assign PC_plus_4[31:2] =PC[31:2]+1'b1;
    assign PC_plus_4[1:0] =2'b0;
    assign PC_plus_4_out = PC_plus_4[31:0];
//nextPC�������
    always @* begin  
    next_PC=PC>>2;
    // beq $n ,$m if $n=$m branch   bne if $n /=$m branch jr
  if((Branch&Zero)+(nBranch&(~Zero))>=1)begin  next_PC= Add_result; end
  else if(Jrn==1)begin next_PC=Read_data_1; end
  else  next_PC=next_PC+1'b1;  // �뿼����������ָ����ж�������
                        // �Լ�����ָ���ִ�иø�next_PC��ʲôֵ
    end
  //2d 101101->b4
   always @(negedge clock) begin   
  //����J��Jalָ���reset�Ĵ���
     if(reset==1)PC=1'b0;
     else if(Jmp==1)begin PC=Instruction[25:0]<<2; end
     else if(Jal==1)begin opcplus4={18'b0,PC[15:2]+1};PC=Instruction[25:0]<<2;end
     else begin PC=(next_PC<<2); end
   end
endmodule
