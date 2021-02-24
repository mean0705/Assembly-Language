`timescale 1ns/1ns
module ALU_1bit( a, b, sel, cin, invB, less, cout, out );

input a, b, cin, invB, less;
input [5:0] sel;
output cout, out;

wire e1, e2, e3, t1;


and ( e1, a, b );

or ( e2, a, b );

xor ( t1, invB, b );
FA FA( .a(a), .b(t1), .cin(cin), .cout(cout), .sum(e3) );

MUX MUX( ._AND(e1), ._OR(e2), .FA(e3), .Less(less), .sel(sel), .Out(out) ); 

endmodule