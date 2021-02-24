//	Title: MIPS Single-Cycle Processor
//	Editor: Selene (Computer System and Architecture Lab, ICE, CYCU)
module mips_single( clk, rst );
	input clk, rst;
	
	// instruction bus
	wire[31:0] instr;
	
	// break out important fields from instruction
	wire [5:0] opcode, funct;
    wire [4:0] rs, rt, rd, shamt;
    wire [15:0] immed;
    wire [31:0] extend_immed, b_offset;
    wire [25:0] jumpoffset;
	
	// datapath signals
    wire [4:0] rfile_wn;
    wire [31:0] rfile_rd1, rfile_rd2, rfile_wd, alu_b, alu_out, b_tgt, pc_next,
                pc, pc_incr, dmem_rdata, jump_addr, branch_addr;

	// control signals
    wire RegWrite, Branch, PCSrc, RegDst, MemtoReg, MemRead, MemWrite, ALUSrc, Zero, Jump;
    wire [1:0] ALUOp;
    wire [2:0] Operation;
	
//---------------------------------
	wire[31:0] output_pc, output_instr;
//-----------------------------------	
    wire output_RegDst, output_ALUSrc, output_MemtoReg, output_RegWrite, output_MemRead, output_MemWrite, output_Branch, output_Jump ; 
    wire [31:0] output2_pc, output_rfile_rd1, output_rfile_rd2, output_extend_immed ;
	wire [4:0] output_rt, output_rd ;
	wire [1:0] output_ALUOp ;
	wire [5:0] output_funct ;
//--------------------------------------------------------------------------------------------------------------------------------------------------------
    wire output2_Branch, output2_RegWrite, output2_MemtoReg, output2_MemRead, output2_MemWrite, output_Zero ;
	wire [31:0] output_alu_out, output2_rfile_rd2, output_b_tgt ;
	wire [4:0] output_rfile_wn ;
//----------------------------------------------------------------------------------------------------------------
    wire output3_RegWrite, output3_MemtoReg ;
	wire [31:0] output2_alu_out, output_dmem_rdata ;
	wire [4:0] output2_rfile_wn ;

//---------------------------------
	
    assign opcode = output_instr[31:26];
    assign rs = output_instr[25:21];
    assign rt = output_instr[20:16];
    assign rd = output_instr[15:11];
    assign shamt = output_instr[10:6];
    assign funct = output_instr[5:0];
    assign immed = output_instr[15:0];
    assign jumpoffset = output_instr[25:0];
	
	// branch offset shifter
    assign b_offset = extend_immed << 2;
	
	// jump offset shifter & concatenation
	assign jump_addr = { pc_incr[31:28], jumpoffset <<2 };

	// module instantiations
	
	reg32 PC( .clk(clk), .rst(rst), .en_reg(1'b1), .d_in(pc_next), .d_out(pc) );
	// sign-extender
	sign_extend SignExt( .immed_in(immed), .ext_immed_out(extend_immed) );
	
	add32 PCADD( .a(pc), .b(32'd4), .result(pc_incr) );

    add32 BRADD( .a(output2_pc), .b(b_offset), .result(b_tgt) );

    Total Total( .ctrl(Operation), .A(rfile_rd1), .B(alu_b), .result(alu_out), .Zero(Zero), .clk(clk), .rst(rst), .funct(funct) );

    and BR_AND(PCSrc, Branch, Zero);

    mux2 #(5) RFMUX( .sel(RegDst), .a(rt), .b(rd), .y(rfile_wn) );

    mux2 #(32) PCMUX( .sel(PCSrc), .a(pc_incr), .b(b_tgt), .y(branch_addr) );
	
	mux2 #(32) JMUX( .sel(Jump), .a(branch_addr), .b(jump_addr), .y(pc_next) );
	
    mux2 #(32) ALUMUX( .sel(output_ALUSrc), .a(rfile_rd2), .b(extend_immed), .y(alu_b) );

    mux2 #(32) WRMUX( .sel(MemtoReg), .a(alu_out), .b(dmem_rdata), .y(rfile_wd) );

    control_single CTL(.opcode(opcode), .RegDst(RegDst), .ALUSrc(ALUSrc), .MemtoReg(MemtoReg), 
                       .RegWrite(RegWrite), .MemRead(MemRead), .MemWrite(MemWrite), .Branch(Branch), 
                       .Jump(Jump), .ALUOp(ALUOp), .instr(instr) );

    alu_ctl ALUCTL( .ALUOp(output_ALUOp), .Funct(funct), .ALUOperation(Operation) );
	

	reg_file RegFile( .clk(clk), .RegWrite(RegWrite), .RN1(rs), .RN2(rt), .WN(rfile_wn), 
					  .WD(rfile_wd), .RD1(rfile_rd1), .RD2(rfile_rd2) );

	memory InstrMem( .clk(clk), .MemRead(1'b1), .MemWrite(1'b0), .wd(32'd0), .addr(pc), .rd(instr) );

	memory DatMem( .clk(clk), .MemRead(MemRead), .MemWrite(MemWrite), .wd(rfile_rd2), 
				   .addr(alu_out), .rd(dmem_rdata) );	   
	
// ----------------------------------------------------------------PIPELINE------------------------------------------------------------
		   
    IF_ID IF_ID( .rst(rst), .clk(clk), .pc(pc_incr), .instr(instr), .output_pc(output_pc), .output_instr(output_instr) );
	ID_EX ID_EX( .rst(rst), .clk(clk), .RegDst(RegDst), .ALUSrc(ALUSrc), .MemtoReg(MemtoReg), .RegWrite(RegWrite), .MemRead(MemRead), .MemWrite(MemWrite), .Branch(Branch), 
	             .Jump(Jump), .ALUOp(ALUOp), .output_pc(output_pc), .rfile_rd1(rfile_rd1), .rfile_rd2(rfile_rd2), .extend_immed(extend_immed), .rt(rt), .rd(rd), .funct( funct ), 
				 .output_RegDst(output_RegDst), .output_ALUSrc(output_ALUSrc), .output_MemtoReg(output_MemtoReg), .output_RegWrite(output_RegWrite), .output_MemRead(output_MemRead), 
				 .output_MemWrite(output_MemWrite), .output_Branch(output_Branch), .output_Jump(output_Jump), .output_ALUOp(output_ALUOp), .output2_pc(output2_pc), 
				 .output_rfile_rd1(output_rfile_rd1), .output_rfile_rd2(output_rfile_rd2), .output_extend_immed(output_extend_immed), .output_rt(output_rt), .output_rd(output_rd),
                 .output_funct( output_funct ) ) ;
    EX_MEM EX_MEM( .rst(rst), .clk(clk), .output_Branch(output_Branch), .output_RegWrite(output_RegWrite), .output_MemtoReg(output_MemtoReg), .output_MemRead(output_MemRead), 
	               .output_MemWrite(output_MemWrite), .b_tgt(b_tgt), .Zero(Zero), .alu_out(alu_out), .output_rfile_rd2(output_rfile_rd2), .rfile_wn(rfile_wn), 
				   .output2_Branch(output2_Branch), .output2_RegWrite(output2_RegWrite), .output2_MemtoReg(output2_MemtoReg), .output2_MemRead(output2_MemRead), 
				   .output2_MemWrite(output2_MemWrite), .output_b_tgt(output_b_tgt), .output_Zero(output_Zero), .output_alu_out(output_alu_out), 
				   .output2_rfile_rd2(output2_rfile_rd2), .output_rfile_wn(output_rfile_wn) ) ;
    MEM_WB MEM_WB( .rst(rst), .clk(clk), .output2_RegWrite(output2_RegWrite), .output2_MemtoReg(output2_MemtoReg), .dmem_rdata(dmem_rdata), .output_alu_out(output_alu_out),
                   .output_rfile_wn(output_rfile_wn), .output3_RegWrite(output3_RegWrite), .output3_MemtoReg(output3_MemtoReg), .output_dmem_rdata(output_dmem_rdata), 
				   .output2_alu_out(output2_alu_out), .output2_rfile_wn(output2_rfile_wn) );
// ------------------------------------------------------------------------------------------------------------------------------------			
endmodule
