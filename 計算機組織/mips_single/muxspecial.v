//-----------------------------------------------------------------------------
// Title         : 2-1 multiplexer
//-----------------------------------------------------------------------------

module muxspecial( sel, a, a2, b, y, SIG_SHIFTER );
    parameter bitwidth=32;
    input sel, SIG_SHIFTER;
    input  [bitwidth-1:0] a, b, a2;
    output [bitwidth-1:0] y;

    assign y = sel ? b : ( SIG_SHIFTER? a : a2 ) ;
endmodule
