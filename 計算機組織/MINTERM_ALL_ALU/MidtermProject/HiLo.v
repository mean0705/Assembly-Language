`timescale 1ns/ 1ns
module HiLo( product, HiOut, LoOut, clk, rst );
input [63:0] product;
input clk, rst;
output [31:0] HiOut, LoOut;

reg [63:0] HiLo;

assign HiOut = HiLo[63:32] ;
assign LoOut = HiLo[31:0] ;


always @ ( posedge clk or posedge rst )
begin
  if ( rst ) HiLo = 64'b0;
  else HiLo = product;
end


endmodule