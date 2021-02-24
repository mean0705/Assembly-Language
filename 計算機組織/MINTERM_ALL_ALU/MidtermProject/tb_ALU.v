`timescale 1ns/ 1ns
module tb_ALU();
reg clk, rst;
reg[5:0] ctrl;
reg[31:0] inputA, inputB, ans;	
wire[31:0] result;
	
Total Total( .A(inputA), .B(inputB), .ctrl(ctrl), .result(result), .clk(clk), .rst(rst) );
/*
AND : 36
OR : 37
ADD : 32
SUB : 34
SLT : 42
SLL : 00
MULTU : 25
*/

integer fp_r, fp_r_ans, eof;

initial begin 
    clk = 1'b0;
    forever #5 clk = ~clk;
end  
	
initial 
begin
	    eof = 0;
	    rst = 1;
		#10 rst = 0;
		
	    fp_r = $fopen( "input.txt", "r" );
	    fp_r_ans = $fopen( "ans.txt", "r" );

		$display( "Start\n" );
		eof = $fscanf(fp_r_ans, "%d", ans);
		while( eof != -1 ) begin
			$fscanf(fp_r, "%d%d%d", ctrl, inputA, inputB );
			$write( "%d: Input: ", $time/10 );
			if ( ctrl == 6'd36 ) $write( "AND(%d)", ctrl );
			else if ( ctrl == 6'd37 ) $write( "OR(%d) ", ctrl );
			else if ( ctrl == 6'd32 ) $write( "ADD(%d) ", ctrl );
			else if ( ctrl == 6'd34 ) $write( "SUB(%d) ", ctrl );
			else if ( ctrl == 6'd42 ) $write( "SLT(%d) ", ctrl );
			else if ( ctrl == 6'd00 ) $write( "SLL(%d) ", ctrl );
			else if ( ctrl == 6'd25 ) $write( "MULTU(%d) ", ctrl );
			$display( "%d%d", inputA, inputB );
			if ( ctrl == 32'd25 ) begin
				#330;
				$display( "%d: MULTU End\n", $time/10 );

				#10;
				#10;
				
				$display( "                   Move Hi" );
				ctrl = 6'd16;
				#10;
				if ( ans == result )
					$display( "%d: Correct: Your answer is:%d,\n                                 Correct answer is:%d\n", $time/10, result, ans );
				else
					$display( "%d: Wrong Answer: Your answer is:%d,\n                                             Correct answer is:%d\n", $time/10, result, ans );
					
				$display( "                   Move Lo" );
				//#10
				ctrl = 6'd18;
				eof = $fscanf(fp_r_ans, "%d", ans);
				#10;
				if ( ans == result )
					$display( "%d: Correct: Your answer is:%d,\n                                 Correct answer is:%d\n", $time/10, result, ans );
				else
					$display( "%d: Wrong Answer: Your answer is:%d,\n                                             Correct answer is:%d\n", $time/10, result, ans );
			end
			else begin
				#10;
				if ( ans == result )
					$display( "%d: Correct: Your answer is:%d,\n                                 Correct answer is:%d\n", $time/10, result, ans );
				else
					$display( "%d: Wrong Answer: Your answer is:%d,\n                                             Correct answer is:%d\n", $time/10, result, ans );
			end
			eof = $fscanf(fp_r_ans, "%d", ans);
		end
		$fclose( fp_r );
		$fclose( fp_r_ans );
		$display( "Simulation End\n" );
		
		$stop();

end	
	
	
endmodule	