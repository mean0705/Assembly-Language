`timescale 1ns/1ns
module ALUControl( SIGfor_ALU, SIGfor_Shifter, SIGfor_Multiplier, SIGfor_MUX, clk, ctrl );
input [5:0] ctrl;
input clk;

output reg [1:0] SIGfor_MUX; 
output [2:0] SIGfor_ALU; 
output [5:0] SIGfor_Shifter, SIGfor_Multiplier;

reg [5:0] temp;

parameter AND = 6'b100100;
parameter OR  = 6'b100101;
parameter ADD = 6'b100000;
parameter SUB = 6'b100010;
parameter SLT = 6'b101010;
parameter SLL = 6'b000000;
parameter MULTU = 6'b011001;
parameter MFHI= 6'b010000;
parameter MFLO= 6'b010010;

assign SIGfor_ALU = temp[2:0];
assign SIGfor_Shifter = temp;
assign SIGfor_Multiplier = temp;

always @( posedge clk )
begin
  case ( ctrl )
    AND: temp = 6'b000000;
	 OR: temp = 6'b000001;
    ADD: temp = 6'b000010;
	SUB: temp = 6'b000110;
	SLT: temp = 6'b000111;
	default: temp = ctrl;
  endcase
  
end

always @ ( posedge clk )
begin
  case ( ctrl )
    SLL: SIGfor_MUX = 2'b01;
    MFHI: SIGfor_MUX = 2'b10;
    MFLO: SIGfor_MUX = 2'b11;
    default: SIGfor_MUX = 2'b00;
  endcase

end

endmodule
