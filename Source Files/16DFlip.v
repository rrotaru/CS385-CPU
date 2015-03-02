/* CS 385 - Semester Project

   Authors:
   Robert Rotaru
   Bryan Bigelow
   Anthony Cerritelli

   Content:
   16-bit D Flip Flop in Verilog
*/
module D_16_Flip_flop(D,CLK,Q);
	input [15:0] D;
	input CLK;
	output [15:0] Q;
	
	D_flip_flop f0(D[0], CLK, Q[0]),
				f1(D[1], CLK, Q[1]),
				f2(D[2], CLK, Q[2]),
				f3(D[3], CLK, Q[3]),
				f4(D[4], CLK, Q[4]),
				f5(D[5], CLK, Q[5]),
				f6(D[6], CLK, Q[6]),
				f7(D[7], CLK, Q[7]),
				f8(D[8], CLK, Q[8]),
				f9(D[9], CLK, Q[9]),
				f10(D[10], CLK, Q[10]),
				f11(D[11], CLK, Q[11]),
				f12(D[12], CLK, Q[12]),
				f13(D[13], CLK, Q[13]),
				f14(D[14], CLK, Q[14]),
				f15(D[15], CLK, Q[15]);	
endmodule

module D_flip_flop(D,CLK,Q);
   input D,CLK; 
   output Q; 
   wire CLK1, Y;
   not  not1 (CLK1,CLK);
   D_latch D1(D,CLK, Y),
           D2(Y,CLK1,Q);
endmodule 

module D_latch(D,C,Q);
   input D,C; 
   output Q;
   wire x,y,D1,Q1; 
   nand nand1 (x,D, C), 
        nand2 (y,D1,C), 
        nand3 (Q,x,Q1),
        nand4 (Q1,y,Q); 
   not  not1  (D1,D);
endmodule

/*
module testing ();
	reg [15:0] D;
	reg CLK;
	wire [15:0] Q;
	
	D_16_Flip_flop flop(D,CLK,Q);
	
 initial 
   begin  
	
     D=16'b0000_0000_0000_1111; CLK=1;
	 #10 CLK=0;
	 #10 D=16'b0000_0000_1111_1111; CLK=1;
	 #10 CLK=0;
	 #10 D=16'b0000_1111_1111_1111; CLK=1;
	 #10 CLK=0;

   end 

 initial
   $monitor ("%b %b", CLK, Q);
 
endmodule 
*/
