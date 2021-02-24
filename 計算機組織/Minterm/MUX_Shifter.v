`timescale 1ns/1ns
module MUX_shifter( _1, _0, steps, out );
input _0, _1, steps;
output reg out;

always@( _0 or _1 or steps )
begin
  case( steps )
    1'b0: out = _0;
    1'b1: out = _1;
  endcase
end

endmodule