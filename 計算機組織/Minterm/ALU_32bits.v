`timescale 1ns/1ns
module ALU_32bits( A, B, sel, Out, clk, rst, cin, invB, overFlow );
input [31:0] A, B;
input [5:0] sel;
input clk, rst, cin, invB;
output [31:0] Out;
output overFlow;

wire set;
wire [31:0] c, dataOut;

ALU_1bit ALU_0( .a(A[0]), .b(B[0]), .sel(sel), .cin(cin), .invB(invB), .less(set), .cout(c[0]), .out(dataOut[0]) );
ALU_1bit ALU_1( .a(A[1]), .b(B[1]), .sel(sel), .cin(c[0]), .invB(invB), .less(1'b0), .cout(c[1]), .out(dataOut[1]) );
ALU_1bit ALU_2( .a(A[2]), .b(B[2]), .sel(sel), .cin(c[1]), .invB(invB), .less(1'b0), .cout(c[2]), .out(dataOut[2]) );
ALU_1bit ALU_3( .a(A[3]), .b(B[3]), .sel(sel), .cin(c[2]), .invB(invB), .less(1'b0), .cout(c[3]), .out(dataOut[3]) );
ALU_1bit ALU_4( .a(A[4]), .b(B[4]), .sel(sel), .cin(c[3]), .invB(invB), .less(1'b0), .cout(c[4]), .out(dataOut[4]) );
ALU_1bit ALU_5( .a(A[5]), .b(B[5]), .sel(sel), .cin(c[4]), .invB(invB), .less(1'b0), .cout(c[5]), .out(dataOut[5]) );
ALU_1bit ALU_6( .a(A[6]), .b(B[6]), .sel(sel), .cin(c[5]), .invB(invB), .less(1'b0), .cout(c[6]), .out(dataOut[6]) );
ALU_1bit ALU_7( .a(A[7]), .b(B[7]), .sel(sel), .cin(c[6]), .invB(invB), .less(1'b0), .cout(c[7]), .out(dataOut[7]) );
ALU_1bit ALU_8( .a(A[8]), .b(B[8]), .sel(sel), .cin(c[7]), .invB(invB), .less(1'b0), .cout(c[8]), .out(dataOut[8]) );
ALU_1bit ALU_9( .a(A[9]), .b(B[9]), .sel(sel), .cin(c[8]), .invB(invB), .less(1'b0), .cout(c[9]), .out(dataOut[9]) );
ALU_1bit ALU_10( .a(A[10]), .b(B[10]), .sel(sel), .cin(c[9]), .invB(invB), .less(1'b0), .cout(c[10]), .out(dataOut[10]) );
ALU_1bit ALU_11( .a(A[11]), .b(B[11]), .sel(sel), .cin(c[10]), .invB(invB), .less(1'b0), .cout(c[11]), .out(dataOut[11]) );
ALU_1bit ALU_12( .a(A[12]), .b(B[12]), .sel(sel), .cin(c[11]), .invB(invB), .less(1'b0), .cout(c[12]), .out(dataOut[12]) );
ALU_1bit ALU_13( .a(A[13]), .b(B[13]), .sel(sel), .cin(c[12]), .invB(invB), .less(1'b0), .cout(c[13]), .out(dataOut[13]) );
ALU_1bit ALU_14( .a(A[14]), .b(B[14]), .sel(sel), .cin(c[13]), .invB(invB), .less(1'b0), .cout(c[14]), .out(dataOut[14]) );
ALU_1bit ALU_15( .a(A[15]), .b(B[15]), .sel(sel), .cin(c[14]), .invB(invB), .less(1'b0), .cout(c[15]), .out(dataOut[15]) );
ALU_1bit ALU_16( .a(A[16]), .b(B[16]), .sel(sel), .cin(c[15]), .invB(invB), .less(1'b0), .cout(c[16]), .out(dataOut[16]) );
ALU_1bit ALU_17( .a(A[17]), .b(B[17]), .sel(sel), .cin(c[16]), .invB(invB), .less(1'b0), .cout(c[17]), .out(dataOut[17]) );
ALU_1bit ALU_18( .a(A[18]), .b(B[18]), .sel(sel), .cin(c[17]), .invB(invB), .less(1'b0), .cout(c[18]), .out(dataOut[18]) );
ALU_1bit ALU_19( .a(A[19]), .b(B[19]), .sel(sel), .cin(c[18]), .invB(invB), .less(1'b0), .cout(c[19]), .out(dataOut[19]) );
ALU_1bit ALU_20( .a(A[20]), .b(B[20]), .sel(sel), .cin(c[19]), .invB(invB), .less(1'b0), .cout(c[20]), .out(dataOut[20]) );
ALU_1bit ALU_21( .a(A[21]), .b(B[21]), .sel(sel), .cin(c[20]), .invB(invB), .less(1'b0), .cout(c[21]), .out(dataOut[21]) );
ALU_1bit ALU_22( .a(A[22]), .b(B[22]), .sel(sel), .cin(c[21]), .invB(invB), .less(1'b0), .cout(c[22]), .out(dataOut[22]) );
ALU_1bit ALU_23( .a(A[23]), .b(B[23]), .sel(sel), .cin(c[22]), .invB(invB), .less(1'b0), .cout(c[23]), .out(dataOut[23]) );
ALU_1bit ALU_24( .a(A[24]), .b(B[24]), .sel(sel), .cin(c[23]), .invB(invB), .less(1'b0), .cout(c[24]), .out(dataOut[24]) );
ALU_1bit ALU_25( .a(A[25]), .b(B[25]), .sel(sel), .cin(c[24]), .invB(invB), .less(1'b0), .cout(c[25]), .out(dataOut[25]) );
ALU_1bit ALU_26( .a(A[26]), .b(B[26]), .sel(sel), .cin(c[25]), .invB(invB), .less(1'b0), .cout(c[26]), .out(dataOut[26]) );
ALU_1bit ALU_27( .a(A[27]), .b(B[27]), .sel(sel), .cin(c[26]), .invB(invB), .less(1'b0), .cout(c[27]), .out(dataOut[27]) );
ALU_1bit ALU_28( .a(A[28]), .b(B[28]), .sel(sel), .cin(c[27]), .invB(invB), .less(1'b0), .cout(c[28]), .out(dataOut[28]) );
ALU_1bit ALU_29( .a(A[29]), .b(B[29]), .sel(sel), .cin(c[28]), .invB(invB), .less(1'b0), .cout(c[29]), .out(dataOut[29]) );
ALU_1bit ALU_30( .a(A[30]), .b(B[30]), .sel(sel), .cin(c[29]), .invB(invB), .less(1'b0), .cout(c[30]), .out(dataOut[30]) );
ALU_msb ALU_31( .a(A[31]), .b(B[31]), .sel(sel), .cin(c[30]), .invB(invB), .less(1'b0), .cout(c[31]), .out(dataOut[31]), .set(set) );
assign Out = dataOut;
assign overFlow = c[31] ^ c[30];
  
endmodule  