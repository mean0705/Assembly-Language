`timescale 1ns/ 1ns
module Total( A, B, ctrl, result, clk, rst, funct, Zero );
input [31:0] A, B;
input [2:0] ctrl;
input clk, rst, Zero;
input [5:0] funct ;
output [31:0] result;

wire [31:0] ALUOut, ShifterOut, HiOut, LoOut; 
//wire [63:0] MultiplierOut;

//wire [1:0] SIGfor_MUX;
//wire [2:0] SIGfor_ALU;
//wire [5:0] SIGfor_Shifter, SIGfor_Multiplier;

//ALUControl ALUControl( .SIGfor_ALU(SIGfor_ALU), .SIGfor_Shifter(SIGfor_Shifter), .SIGfor_Multiplier(SIGfor_Multiplier), .SIGfor_MUX(SIGfor_MUX), .clk(clk), .ctrl(ctrl) );
ALU_32bits ALU_32bits( .A(A), .B(B), .SIG(ctrl), .dataOut(ALUOut), .Zero(Zero) );
Shifter Shifter( .target(A), .shamt(B[4:0]), .result(ShifterOut) );
//Multiplier Multiplier( ._Multiplicand(A), ._Multiplier(B), .product(MultiplierOut), .clk(clk), .rst(rst) );
//HiLo HiLo( .product(MultiplierOut), .HiOut(HiOut), .LoOut(LoOut), .clk(clk), .rst(rst) );
//MUX_final MUX_final( ALUOut, ShifterOut, HiOut, LoOut, SIGfor_MUX, result );
assign result = ( funct == 6'd0 ) ? ShifterOut :  ALUOut ;
//assign Zero = ( funct != 6'd0 && result == 32'd0 ) ? 1 : 0 ;
endmodule