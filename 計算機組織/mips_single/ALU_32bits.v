`timescale 1ns/1ns
//ALU_32bits ALU( .ctl(Operation), .a(rfile_rd1), .b(ALU_b), .result(ALU_out), .zero(Zero) ) ;
module ALU_32bits( ctl, a, b, result, zero );
input [2:0] ctl;
input [31:0] a, b;
output [31:0] result;
output zero ;

wire set;
wire [31:0] c;
reg zero ;

ALU_1bit ALU_0( .a(a[0]), .b(b[0]), .ctl(ctl[1:0]), .cin(ctl[2]), .invB(ctl[2]), .less(set), .cout(c[0]), .out(result[0]) );
ALU_1bit ALU_1( .a(a[1]), .b(b[1]), .ctl(ctl[1:0]), .cin(c[0]), .invB(ctl[2]), .less(1'b0), .cout(c[1]), .out(result[1]) );
ALU_1bit ALU_2( .a(a[2]), .b(b[2]), .ctl(ctl[1:0]), .cin(c[1]), .invB(ctl[2]), .less(1'b0), .cout(c[2]), .out(result[2]) );
ALU_1bit ALU_3( .a(a[3]), .b(b[3]), .ctl(ctl[1:0]), .cin(c[2]), .invB(ctl[2]), .less(1'b0), .cout(c[3]), .out(result[3]) );
ALU_1bit ALU_4( .a(a[4]), .b(b[4]), .ctl(ctl[1:0]), .cin(c[3]), .invB(ctl[2]), .less(1'b0), .cout(c[4]), .out(result[4]) );
ALU_1bit ALU_5( .a(a[5]), .b(b[5]), .ctl(ctl[1:0]), .cin(c[4]), .invB(ctl[2]), .less(1'b0), .cout(c[5]), .out(result[5]) );
ALU_1bit ALU_6( .a(a[6]), .b(b[6]), .ctl(ctl[1:0]), .cin(c[5]), .invB(ctl[2]), .less(1'b0), .cout(c[6]), .out(result[6]) );
ALU_1bit ALU_7( .a(a[7]), .b(b[7]), .ctl(ctl[1:0]), .cin(c[6]), .invB(ctl[2]), .less(1'b0), .cout(c[7]), .out(result[7]) );
ALU_1bit ALU_8( .a(a[8]), .b(b[8]), .ctl(ctl[1:0]), .cin(c[7]), .invB(ctl[2]), .less(1'b0), .cout(c[8]), .out(result[8]) );
ALU_1bit ALU_9( .a(a[9]), .b(b[9]), .ctl(ctl[1:0]), .cin(c[8]), .invB(ctl[2]), .less(1'b0), .cout(c[9]), .out(result[9]) );
ALU_1bit ALU_10( .a(a[10]), .b(b[10]), .ctl(ctl[1:0]), .cin(c[9]), .invB(ctl[2]), .less(1'b0), .cout(c[10]), .out(result[10]) );
ALU_1bit ALU_11( .a(a[11]), .b(b[11]), .ctl(ctl[1:0]), .cin(c[10]), .invB(ctl[2]), .less(1'b0), .cout(c[11]), .out(result[11]) );
ALU_1bit ALU_12( .a(a[12]), .b(b[12]), .ctl(ctl[1:0]), .cin(c[11]), .invB(ctl[2]), .less(1'b0), .cout(c[12]), .out(result[12]) );
ALU_1bit ALU_13( .a(a[13]), .b(b[13]), .ctl(ctl[1:0]), .cin(c[12]), .invB(ctl[2]), .less(1'b0), .cout(c[13]), .out(result[13]) );
ALU_1bit ALU_14( .a(a[14]), .b(b[14]), .ctl(ctl[1:0]), .cin(c[13]), .invB(ctl[2]), .less(1'b0), .cout(c[14]), .out(result[14]) );
ALU_1bit ALU_15( .a(a[15]), .b(b[15]), .ctl(ctl[1:0]), .cin(c[14]), .invB(ctl[2]), .less(1'b0), .cout(c[15]), .out(result[15]) );
ALU_1bit ALU_16( .a(a[16]), .b(b[16]), .ctl(ctl[1:0]), .cin(c[15]), .invB(ctl[2]), .less(1'b0), .cout(c[16]), .out(result[16]) );
ALU_1bit ALU_17( .a(a[17]), .b(b[17]), .ctl(ctl[1:0]), .cin(c[16]), .invB(ctl[2]), .less(1'b0), .cout(c[17]), .out(result[17]) );
ALU_1bit ALU_18( .a(a[18]), .b(b[18]), .ctl(ctl[1:0]), .cin(c[17]), .invB(ctl[2]), .less(1'b0), .cout(c[18]), .out(result[18]) );
ALU_1bit ALU_19( .a(a[19]), .b(b[19]), .ctl(ctl[1:0]), .cin(c[18]), .invB(ctl[2]), .less(1'b0), .cout(c[19]), .out(result[19]) );
ALU_1bit ALU_20( .a(a[20]), .b(b[20]), .ctl(ctl[1:0]), .cin(c[19]), .invB(ctl[2]), .less(1'b0), .cout(c[20]), .out(result[20]) );
ALU_1bit ALU_21( .a(a[21]), .b(b[21]), .ctl(ctl[1:0]), .cin(c[20]), .invB(ctl[2]), .less(1'b0), .cout(c[21]), .out(result[21]) );
ALU_1bit ALU_22( .a(a[22]), .b(b[22]), .ctl(ctl[1:0]), .cin(c[21]), .invB(ctl[2]), .less(1'b0), .cout(c[22]), .out(result[22]) );
ALU_1bit ALU_23( .a(a[23]), .b(b[23]), .ctl(ctl[1:0]), .cin(c[22]), .invB(ctl[2]), .less(1'b0), .cout(c[23]), .out(result[23]) );
ALU_1bit ALU_24( .a(a[24]), .b(b[24]), .ctl(ctl[1:0]), .cin(c[23]), .invB(ctl[2]), .less(1'b0), .cout(c[24]), .out(result[24]) );
ALU_1bit ALU_25( .a(a[25]), .b(b[25]), .ctl(ctl[1:0]), .cin(c[24]), .invB(ctl[2]), .less(1'b0), .cout(c[25]), .out(result[25]) );
ALU_1bit ALU_26( .a(a[26]), .b(b[26]), .ctl(ctl[1:0]), .cin(c[25]), .invB(ctl[2]), .less(1'b0), .cout(c[26]), .out(result[26]) );
ALU_1bit ALU_27( .a(a[27]), .b(b[27]), .ctl(ctl[1:0]), .cin(c[26]), .invB(ctl[2]), .less(1'b0), .cout(c[27]), .out(result[27]) );
ALU_1bit ALU_28( .a(a[28]), .b(b[28]), .ctl(ctl[1:0]), .cin(c[27]), .invB(ctl[2]), .less(1'b0), .cout(c[28]), .out(result[28]) );
ALU_1bit ALU_29( .a(a[29]), .b(b[29]), .ctl(ctl[1:0]), .cin(c[28]), .invB(ctl[2]), .less(1'b0), .cout(c[29]), .out(result[29]) );
ALU_1bit ALU_30( .a(a[30]), .b(b[30]), .ctl(ctl[1:0]), .cin(c[29]), .invB(ctl[2]), .less(1'b0), .cout(c[30]), .out(result[30]) );
ALU_msb ALU_31( .a(a[31]), .b(b[31]), .ctl(ctl[1:0]), .cin(c[30]), .invB(ctl[2]), .less(1'b0), .cout(c[31]), .out(result[31]), .set(set) );

always @( result )
  begin
   if (result == 32'd0) zero = 1;
   else zero = 0;
 end

endmodule  