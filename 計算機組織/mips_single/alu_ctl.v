/*
	Title:	ALU Control Unit
	Author: Garfield (Computer System and Architecture Lab, ICE, CYCU)
	Input Port
		1. ALUOp: ����alu�O�n��+�٬O-�άO��L���O
		2. Funct: �p�G�O��L���O�h�γo��6�X�P�_
	Output Port
		1. ALUOperation: �̫�ѽX���������O
*/

module alu_ctl(ALUOp, Funct, ALUOperation, SIG_SHIFTER, SIG_MULTIPLIER );
    input [1:0] ALUOp;
    input [5:0] Funct;
    output [2:0] ALUOperation;
    reg    [2:0] ALUOperation;
	
	output [5:0] SIG_SHIFTER, SIG_MULTIPLIER;
	reg    [5:0] SIG_SHIFTER, SIG_MULTIPLIER;

    // symbolic constants for instruction function code
    parameter F_add = 6'd32;
    parameter F_sub = 6'd34;
    parameter F_and = 6'd36;
    parameter F_or  = 6'd37;
    parameter F_slt = 6'd42;
	//parameter F_multu = 6'd25;
	//parameter F_mfhi = 6'd16;
	//parameter F_mflo = 6'd18;
    parameter F_sll = 6'd0;


    // symbolic constants for ALU Operations
    parameter ALU_add = 3'b010;
    parameter ALU_sub = 3'b110;
    parameter ALU_and = 3'b000;
    parameter ALU_or  = 3'b001;
    parameter ALU_slt = 3'b111;

    always @(ALUOp or Funct)
    begin
        case (ALUOp) 
            2'b00 : ALUOperation = ALU_add;
            2'b01 : ALUOperation = ALU_sub;
            2'b10 : case (Funct) 
                        F_add : ALUOperation = ALU_add;
                        F_sub : ALUOperation = ALU_sub;
                        F_and : ALUOperation = ALU_and;
                        F_or  : ALUOperation = ALU_or;
                        F_slt : ALUOperation = ALU_slt;
						
						F_sll : SIG_SHIFTER = Funct;
                        //F_multu : ALUOperation = ALU_slt;
						//F_mfhi : SIG_MULTIPLIER = Funct;
                        //F_mflo : SIG_MULTIPLIER = Funct;

                        default ALUOperation = 3'bxxx;
                    endcase
            default ALUOperation = 3'bxxx;
        endcase
    end
	

endmodule

