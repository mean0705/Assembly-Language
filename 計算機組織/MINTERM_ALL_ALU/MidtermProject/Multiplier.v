`timescale 1ns/ 1ns
module Multiplier( _Multiplicand, _Multiplier, product, clk, rst );
input [31:0] _Multiplicand;
input [31:0] _Multiplier;
input clk, rst;
output reg [63:0] product;

reg [6:0] count ;
reg [63:0] MCND ;
reg [31:0] MPY ;

always @ ( posedge clk or posedge rst )
begin
  if ( rst ) count = 6'b0;
  else
  begin
    if ( count == 0 )
    begin
      MCND = _Multiplicand;
      MPY = _Multiplier;
  	  product = 64'b0;
    end
  
    if ( count <= 32 )
    begin
      if ( MPY[0] ) product = product + MCND;
	  
      MCND = MCND << 1 ;
      MPY = MPY >> 1 ;
	  count = count + 1;
    end
	
	if ( count == 33 ) count = 6'b0;
  end
end

endmodule