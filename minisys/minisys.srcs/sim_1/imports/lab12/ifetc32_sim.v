`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2016/08/07 21:00:51
// Design Name: 
// Module Name: ifetc32_sim
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


module ifetc32_sim(

    );
    // input
    reg[31:0]  Add_result ;
    reg[31:0]  Read_data_1;
    reg        Branch = 1'b0;
    reg        nBranch = 1'b0;
    reg        Jmp = 1'b0;
    reg        Jal = 1'b0;
    reg        Jrn = 1'b0;
    reg        Zero = 1'b0;
    reg        clock = 1'b0,reset = 1'b1;
    // output
    wire[31:0] Instruction;            // ??????
    wire[31:0] PC_plus_4_out;
    wire[31:0] opcplus4;
    wire[31:0] PC;
    wire[31:0] next_PC;
        
    Ifetc32_2  Ifetc32(Instruction,PC_plus_4_out,Add_result,Read_data_1,Branch,nBranch,Jmp,Jal,Jrn,Zero,clock,reset,opcplus4,
    PC, next_PC
    );

    initial begin
        #100   reset = 1'b0;
//        #100   Jal = 1;
//        #100   begin Jrn = 1;Jal = 0; Read_data_1 = 32'h0000019c;end
//        #100   begin Jrn = 0;Branch = 1'b1; Zero = 1'b1; Add_result = 32'h00000002;end       
//        #100   begin Branch = 1'b0; Zero = 1'b0; end 
    end
    always #50 clock = ~clock;     
endmodule
