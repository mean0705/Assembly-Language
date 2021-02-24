`timescale 1ns/ 1ns
module tb_ALU();
	reg clk, rst;
	reg[5:0] ctrl;
	reg[31:0] inputA, inputB;
	wire[31:0] result;

	ALUControl ALUControl( .A(inputA), .B(inputB), .sel(ctrl), .result(result), .clk(clk), .rst(rst) );
	

parameter	th = 100;
parameter	t = 200;

	always #th clk = ~clk;
	initial begin
	  clk = 0;
	  //rst = 1;


      ctrl = 42; // 
	  inputA = -4;
	  inputB = 11;		

	  #t
      ctrl = 42; // 
	  inputA = -4;
	  inputB = -4;

	  #t
      ctrl = 42; // 
	  inputA = -4;
	  inputB = -3;
	  #t   
      ctrl = 42; // 
	  inputA = 13;
	  inputB = 11;	  
	  
	  #t
      ctrl = 42; // 
	  inputA = 11;
	  inputB = 11;	
	  	  #t
      ctrl = 42; // 
	  inputA = 10;
	  inputB = 11;
	  #t
      ctrl = 42; // 
	  inputA = 32'h80000000;
	  inputB = 1;	  
	  
	  #t $stop;
	  
	end	
	
	
endmodule	