`timescale 1ns/1ns
module MUX_final( SIG_ALU, SIG_Shifter, SIG_Hi, SIG_Lo, sel, finalOut );
input [31:0] SIG_ALU, SIG_Shifter, SIG_Hi, SIG_Lo;
input [1:0] sel;
output [31:0] finalOut;

assign finalOut = sel[1] ? ( sel[0] ? SIG_Lo : SIG_Hi ) : ( sel[0] ? SIG_Shifter : SIG_ALU );


endmodule