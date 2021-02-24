`timescale 1ns/1ns
module ALUControl( A, B, sel, result, clk, rst );
input [31:0] A, B;
input [5:0] sel;
input clk, rst;
output [31:0] result;

reg cin, invB, set;
wire overFlow; 
wire [31:0] out;

/*
AND : 36
OR : 37
ADD : 32
SUB : 34
SLT : 42
SLL : 00
MULTU : 25
*/
parameter AND = 6'b100100;
parameter OR  = 6'b100101;
parameter ADD = 6'b100000;
parameter SUB = 6'b100010;
parameter SLT = 6'b101010;
parameter SLL = 6'b000000;
parameter MULTU = 6'b011001;

ALU_32bits ALU_32bits( .A(A), .B(B), .sel(sel), .Out(result), .clk(clk), .rst(rst), .cin(cin), .invB(invB), .overFlow(overFlow) );
// Multiplier Multiplier();
//Shifter Shifter( .target(A), .shmat(B), .result(out), .signal(sel) );

always @( negedge clk )
begin
  case ( sel )
  SUB:
	begin
	  cin = 1;
	  invB = 1;
	end  
  SLT:
    begin
	  cin = 1;
	  invB = 1;
	end
  default: 
    begin
	  cin = 0;
	  invB = 0;
	end
  endcase	
end
endmodule