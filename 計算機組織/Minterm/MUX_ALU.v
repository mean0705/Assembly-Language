`timescale 1ns/1ns
module MUX( _AND, _OR, FA, Less, sel, Out );
input _AND, _OR, FA, Less;
input [5:0] sel ;
output reg Out ;

parameter AND = 6'b100100;
parameter OR  = 6'b100101;
parameter ADD = 6'b100000;
parameter SUB = 6'b100010;
parameter SLT = 6'b101010;
parameter SLL = 6'b000000;
parameter MULTU = 6'b011001;


always @ ( _AND or _OR or FA or Less or sel )
begin
  case ( sel )
    AND: Out = _AND;
    OR:  Out = _OR;
    ADD: Out = FA;
    SUB: Out = FA;
    SLT: Out = Less;

    //SLL:
    //MULTU:
    //default: Out = 1'b0;
  endcase

end
endmodule
