/* CS 385 - Semester Project - Progress Report 1

   Authors:
   Robert Rotaru
   Bryan Bigelow
   Anthony Cerritelli

   Content:
   16-bit MIPS CPU in Verilog

   All source code and project work can be found on GitHub at:
   https://github.com/rrotaru/CS385-CPU
*/

/*** Multiplexers ***/

module mux2x1(A,B,select,OUT);
	input A,B,select;
	output OUT;
	wire x,y;
	and	g1(x,A,~select),
		g2(y,B,select);
	or	g3(OUT,x,y);
endmodule

module mux4x1(i0,i1,i2,i3,select,O); 
	input i0,i1,i2,i3;
	input [1:0] select;
	output O;
	wire w,x,y,z;
	and g1(w,i0,~select[1],~select[0]),
		g2(x,i1,~select[1],select[0]),
		g3(y,i2,select[1],~select[0]),
		g4(z,i3,select[1],select[0]);
	or	g5(O,w,x,y,z);
endmodule

module mux16Bit4x1(i0, i1, i2, i3, select, O);
	input [15:0] i0, i1, i2, i3;
	input [1:0] select;
	output [15:0] O;
	
	mux4x1 	mux0(i0[0], i1[0], i2[0], i3[0], select, O[0]),
			mux1(i0[1], i1[1], i2[1], i3[1], select, O[1]),
			mux2(i0[2], i1[2], i2[2], i3[2], select, O[2]),
			mux3(i0[3], i1[3], i2[3], i3[3], select, O[3]),
			mux4(i0[4], i1[4], i2[4], i3[4], select, O[4]),
			mux5(i0[5], i1[5], i2[5], i3[5], select, O[5]),
			mux6(i0[6], i1[6], i2[6], i3[6], select, O[6]),
			mux7(i0[7], i1[7], i2[7], i3[7], select, O[7]),
			mux8(i0[8], i1[8], i2[8], i3[8], select, O[8]),
			mux9(i0[9], i1[9], i2[9], i3[9], select, O[9]),
			mux10(i0[10], i1[10], i2[10], i3[10], select, O[10]),
			mux11(i0[11], i1[11], i2[11], i3[11], select, O[11]),
			mux12(i0[12], i1[12], i2[12], i3[12], select, O[12]),
			mux13(i0[13], i1[13], i2[13], i3[13], select, O[13]),
			mux14(i0[14], i1[14], i2[14], i3[14], select, O[14]),
			mux15(i0[15], i1[15], i2[15], i3[15], select, O[15]);
endmodule

module mux2bit2x1(A,B,select,OUT);
	input [1:0] A,B;
    input select;
	output [1:0] OUT;

    mux2x1 mux1(A[0], B[0], select, OUT[0]),
           mux2(A[1], B[1], select, OUT[1]);
endmodule

module mux16bit2x1(A, B, select, OUT);
	input [15:0] A,B;
    input select;
	output [15:0] OUT;

    mux2x1 mux1(A[0], B[0], select, OUT[0]),
           mux2(A[1], B[1], select, OUT[1]),
           mux3(A[2], B[2], select, OUT[2]),
           mux4(A[3], B[3], select, OUT[3]),
           mux5(A[4], B[4], select, OUT[4]),
           mux6(A[5], B[5], select, OUT[5]),
           mux7(A[6], B[6], select, OUT[6]),
           mux8(A[7], B[7], select, OUT[7]),
           mux9(A[8], B[8], select, OUT[8]),
           mux10(A[9], B[9], select, OUT[9]),
           mux11(A[10], B[10], select, OUT[10]),
           mux12(A[11], B[11], select, OUT[11]),
           mux13(A[12], B[12], select, OUT[12]),
           mux14(A[13], B[13], select, OUT[13]),
           mux15(A[14], B[14], select, OUT[14]),
           mux16(A[15], B[15], select, OUT[15]);
endmodule

/*** 16-bit D flip flop ***/

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

/*** 16-bit register source code ***/

module reg_file (rr1,rr2,wr,wd,regwrite,rd1,rd2,clock);

   input [1:0] rr1,rr2,wr;
   input [15:0] wd;
   input regwrite,clock;
   output [15:0] rd1,rd2;
   wire [15:0] q1, q2, q3;

   // registers
   D_16_Flip_flop r1 (wd,c1,q1);
   D_16_Flip_flop r2 (wd,c2,q2);
   D_16_Flip_flop r3 (wd,c3,q3);

   // output port
   mux16Bit4x1  mux1 (16'b0,q1,q2,q3,rr1,rd1),
                mux2 (16'b0,q1,q2,q3,rr2,rd2);

   // input port
   decoder dec(wr[1],wr[0],w3,w2,w1,w0);

   and a (regwrite_and_clock,regwrite,clock);

   and a1 (c1,regwrite_and_clock,w1),
       a2 (c2,regwrite_and_clock,w2),
       a3 (c3,regwrite_and_clock,w3);

endmodule

module decoder (S1,S0,D3,D2,D1,D0); 
   input S0,S1; 
   output D0,D1,D2,D3; 
 
   not n1 (notS0,S0),
       n2 (notS1,S1);

   and a0 (D0,notS1,notS0), 
       a1 (D1,notS1,   S0), 
       a2 (D2,   S1,notS0), 
       a3 (D3,   S1,   S0); 
endmodule 

/*** ALU and arithmetic source code ***/

module halfadder (S,C,x,y); 
   input x,y; 
   output S,C; 

   xor (S,x,y); 
   and (C,x,y); 
endmodule 


module fulladder (S,C,x,y,z); 
   input x,y,z; 
   output S,C; 
   wire S1,D1,D2;

   halfadder HA1 (S1,D1,x,y), 
             HA2 (S,D2,S1,z); 
   or g1(C,D2,D1); 
endmodule 

// 1-bit ALU for bits 0-14
module ALU1 (a,b,binvert,op,less,carryin,carryout,result);
   input a,b,less,carryin,binvert;
   input [1:0] op;
   output carryout,result;
   wire sum, a_and_b, a_or_b, b_inv;
	
   not not1(b_inv, b);
   mux2x1 mux1(b,b_inv,binvert,b1);
   and and1(a_and_b, a, b);
   or or1(a_or_b, a, b);
   fulladder adder1(sum,carryout,a,b1,carryin);
   mux4x1 mux2(a_and_b,a_or_b,sum,less,op[1:0],result); 

endmodule

// 1-bit ALU for the most significant bit
module ALUmsb (a,b,binvert,op,less,carryin,carryout,result,sum);
   input a,b,less,carryin,binvert;
   input [1:0] op;
   output carryout,result,sum;
   wire sum, a_and_b, a_or_b, b_inv;
	
   not not1(b_inv, b);
   mux2x1 mux1(b,b_inv,binvert,b1);
   and and1(a_and_b, a, b);
   or or1(a_or_b, a, b);
   fulladder adder1(sum,carryout,a,b1,carryin);
   mux4x1 mux2(a_and_b,a_or_b,sum,less,op[1:0],result); 

endmodule

module ALU (op,a,b,result,zero);
   input [15:0] a;
   input [15:0] b;
   input [2:0] op;
   output [15:0] result;
   output zero;
   wire c1,c2,c3,c4,c5,c6,c7,c8,c9,c10,c11,c12,c13,c14,c15,c16;
	
   ALU1   alu0  (a[0], b[0], op[2], op[1:0],set,op[2],c1, result[0]);
   ALU1   alu1  (a[1], b[1], op[2], op[1:0],0,  c1,   c2, result[1]);
   ALU1   alu2  (a[2], b[2], op[2], op[1:0],0,  c2,   c3, result[2]);
   ALU1   alu3  (a[3], b[3], op[2], op[1:0],0,  c3,   c4, result[3]);
   ALU1   alu4  (a[4], b[4], op[2], op[1:0],0,  c4,   c5, result[4]);
   ALU1   alu5  (a[5], b[5], op[2], op[1:0],0,  c5,   c6, result[5]);
   ALU1   alu6  (a[6], b[6], op[2], op[1:0],0,  c6,   c7, result[6]);
   ALU1   alu7  (a[7], b[7], op[2], op[1:0],0,  c7,   c8, result[7]);
   ALU1   alu8  (a[8], b[8], op[2], op[1:0],0,  c8,   c9, result[8]);
   ALU1   alu9  (a[9], b[9], op[2], op[1:0],0,  c9,   c10,result[9]);
   ALU1   alu10 (a[10],b[10],op[2], op[1:0],0,  c10,  c11,result[10]);
   ALU1   alu11 (a[11],b[11],op[2], op[1:0],0,  c11,  c12,result[11]);
   ALU1   alu12 (a[12],b[12],op[2], op[1:0],0,  c12,  c13,result[12]);
   ALU1   alu13 (a[13],b[13],op[2], op[1:0],0,  c13,  c14,result[13]);
   ALU1   alu14 (a[14],b[14],op[2], op[1:0],0,  c14,  c15,result[14]);
   ALUmsb alu15 (a[15],b[15],op[2], op[1:0],0,  c15,  c16,result[15],set);

   or or1(or01, result[0],result[1]);
   or or2(or23, result[2],result[3]);
   nor nor1(zero,or01,or23);

endmodule

module branchCtrl (BranchOp, Zero, BranchOut);

    input [1:0] BranchOp;
    input Zero;
    output BranchOut;
    wire not_Zero, w1, w2;

    not G1(not_Zero, Zero);
    and G2(w1, BranchOp[0], Zero),
        G3(w2, BranchOp[1], not_Zero);
    or  G4(BranchOut, w1, w2);

endmodule

/*** 16-bit CPU control source code ***/

module mainCtrl (op,ctrl); 

  input [3:0] op;
  output reg [10:0] ctrl;

  always @(op) case (op)
    //IDEX_RegDst,IDEX_ALUSrc[1:0],IDEX_MemtoReg,IDEX_RegWrite,IDEX_MemWrite,IDEX_Branch[1:0],IDEX_ALUop[2:0] 
    4'b0000: ctrl <= 11'b10001000010; // ADD
    4'b0001: ctrl <= 11'b10001000110; // SUB
    4'b0010: ctrl <= 11'b10001000000; // AND
    4'b0011: ctrl <= 11'b10001000001; // OR
    4'b0111: ctrl <= 11'b10001000111; // SLT
    4'b0101: ctrl <= 11'b00111000010; // LW
    4'b0110: ctrl <= 11'b00100100010; // SW
    4'b1000: ctrl <= 11'b00000001110; // BEQ
    4'b1001: ctrl <= 11'b00000010110; // BNE
    4'b0100: ctrl <= 11'b00101000010; // ADDI  
    4'b1111: ctrl <= 11'b01001000001; // LUI  
    
  endcase

endmodule

module ALUSrcControl (ALUSrc, RD2, SignExt, ShiftToUpper, ALUSrcOp);
  
  input [15:0] RD2, SignExt, ShiftToUpper;
  input [1:0] ALUSrcOp;
  output [15:0] ALUSrc;
  wire w0;
  wire w1_0,w1_1,w1_2,w1_3,w1_4,w1_5,w1_6,w1_7,w1_8,w1_9,w1_10,w1_11,w1_12,w1_13,w1_14,w1_15; 
  wire w2_0,w2_1,w2_2,w2_3,w2_4,w2_5,w2_6,w2_7,w2_8,w2_9,w2_10,w2_11,w2_12,w2_13,w2_14,w2_15;
  wire w3_0,w3_1,w3_2,w3_3,w3_4,w3_5,w3_6,w3_7,w3_8,w3_9,w3_10,w3_11,w3_12,w3_13,w3_14,w3_15;
  
  nor nor1(w0, ALUSrcOp[0], ALUSrcOp[1]);
  
  and and1_0 (w1_0,  w0, RD2[0]);    and and1_1 (w1_1,  w0, RD2[1]);
  and and1_2 (w1_2,  w0, RD2[2]);    and and1_3 (w1_3,  w0, RD2[3]); 
  and and1_4 (w1_4,  w0, RD2[4]);    and and1_5 (w1_5,  w0, RD2[5]);
  and and1_6 (w1_6,  w0, RD2[6]);    and and1_7 (w1_7,  w0, RD2[7]);  
  and and1_8 (w1_8,  w0, RD2[8]);    and and1_9 (w1_9,  w0, RD2[9]);
  and and1_10(w1_10, w0, RD2[10]);   and and1_11(w1_11, w0, RD2[11]);
  and and1_12(w1_12, w0, RD2[12]);   and and1_13(w1_13, w0, RD2[13]);
  and and1_14(w1_14, w0, RD2[14]);   and and1_15(w1_15, w0, RD2[15]);

  and and2_0 (w2_0,  ALUSrcOp[0], SignExt[0]);  and and2_1 (w2_1,  ALUSrcOp[0], SignExt[1]);
  and and2_2 (w2_2,  ALUSrcOp[0], SignExt[2]);  and and2_3 (w2_3,  ALUSrcOp[0], SignExt[3]);
  and and2_4 (w2_4,  ALUSrcOp[0], SignExt[4]);  and and2_5 (w2_5,  ALUSrcOp[0], SignExt[5]);
  and and2_6 (w2_6,  ALUSrcOp[0], SignExt[6]);  and and2_7 (w2_7,  ALUSrcOp[0], SignExt[7]);
  and and2_8 (w2_8,  ALUSrcOp[0], SignExt[8]);  and and2_9 (w2_9,  ALUSrcOp[0], SignExt[9]); 
  and and2_10(w2_10, ALUSrcOp[0], SignExt[10]); and and2_11(w2_11, ALUSrcOp[0], SignExt[11]);
  and and2_12(w2_12, ALUSrcOp[0], SignExt[12]); and and2_13(w2_13, ALUSrcOp[0], SignExt[13]);
  and and2_14(w2_14, ALUSrcOp[0], SignExt[14]); and and2_15(w2_15, ALUSrcOp[0], SignExt[15]);

  and and3_0 (w3_0,  ALUSrcOp[1], ShiftToUpper[0]);  and and3_1 (w3_1,  ALUSrcOp[1], ShiftToUpper[1]); 
  and and3_2 (w3_2,  ALUSrcOp[1], ShiftToUpper[2]);  and and3_3 (w3_3,  ALUSrcOp[1], ShiftToUpper[3]); 
  and and3_4 (w3_4,  ALUSrcOp[1], ShiftToUpper[4]);  and and3_5 (w3_5,  ALUSrcOp[1], ShiftToUpper[5]);
  and and3_6 (w3_6,  ALUSrcOp[1], ShiftToUpper[6]);  and and3_7 (w3_7,  ALUSrcOp[1], ShiftToUpper[7]);
  and and3_8 (w3_8,  ALUSrcOp[1], ShiftToUpper[8]);  and and3_9 (w3_9,  ALUSrcOp[1], ShiftToUpper[9]);
  and and3_10(w3_10, ALUSrcOp[1], ShiftToUpper[10]); and and3_11(w3_11, ALUSrcOp[1], ShiftToUpper[11]);
  and and3_12(w3_12, ALUSrcOp[1], ShiftToUpper[12]); and and3_13(w3_13, ALUSrcOp[1], ShiftToUpper[13]);
  and and3_14(w3_14, ALUSrcOp[1], ShiftToUpper[14]); and and3_15(w3_15, ALUSrcOp[1], ShiftToUpper[15]);
  
  or(ALUSrc[0],  w1_0,  w2_0,  w3_0);  or(ALUSrc[1],  w1_1,  w2_1,  w3_1);
  or(ALUSrc[2],  w1_2,  w2_2,  w3_2);  or(ALUSrc[3],  w1_3,  w2_3,  w3_3);
  or(ALUSrc[4],  w1_4,  w2_4,  w3_4);  or(ALUSrc[5],  w1_5,  w2_5,  w3_5);
  or(ALUSrc[6],  w1_6,  w2_6,  w3_6);  or(ALUSrc[7],  w1_7,  w2_7,  w3_7);
  or(ALUSrc[8],  w1_8,  w2_8,  w3_8);  or(ALUSrc[9],  w1_9,  w2_9,  w3_9);
  or(ALUSrc[10], w1_10, w2_10, w3_10); or(ALUSrc[11], w1_11, w2_11, w3_11);
  or(ALUSrc[12], w1_12, w2_12, w3_12); or(ALUSrc[13], w1_13, w2_13, w3_13);
  or(ALUSrc[14], w1_14, w2_14, w3_14); or(ALUSrc[15], w1_15, w2_15, w3_15);
  
endmodule

module CPU (clock,PC,IFID_IR,IDEX_IR,EXMEM_IR,MEMWB_IR,WD);

  input clock;
  output [15:0] PC,IFID_IR,IDEX_IR,EXMEM_IR,MEMWB_IR,WD;

    /* Test Program */
    initial begin 
        // Simple program to load 1 from DMemory[0] into $1 and 3 from
        // DMemory[1] into $2, add $1 to $2, add 1 to $1, then swaps
        // the values in $1 and $2 and loops to decrement $2 by $1 until 
        // $2 reaches 0. Finishes by storing 0 into DMemory[1].

        IMemory[0] = 16'b0101000100000000;  // lw $1, 0($0)       1   Load DMemory[0] into $1  
        IMemory[1] = 16'b0101001000000010;  // lw $2, 2($0)       3   Load DMemory[1] into $2 
        IMemory[2] = 16'b0000000000000000;  // nop   
        IMemory[3] = 16'b0000000000000000;  // nop   
        IMemory[4] = 16'b0000000000000000;  // nop
        IMemory[5] = 16'b0000100110000000;  // add  $2, $2, $1    4
        IMemory[6] = 16'b0100010100000001;  // addi $1, $1, 1     2
        IMemory[7] = 16'b0000000000000000;  // nop   
        IMemory[8] = 16'b0000000000000000;  // nop   
        IMemory[9] = 16'b0000000000000000;  // nop
        IMemory[10] = 16'b0111011011000000;  // slt $3, $1, $2    1   Set $3 on $1 < $2
        IMemory[11] = 16'b0000000000000000;  // nop   
        IMemory[12] = 16'b0000000000000000;  // nop   
        IMemory[13] = 16'b0000000000000000;  // nop 
        IMemory[14] = 16'b1000110000000100;  // beq $3, $0, 4     X   Branch to IMemory[8] if $3 == 0
        IMemory[15] = 16'b0000000000000000;  // nop   
        IMemory[16] = 16'b0000000000000000;  // nop   
        IMemory[17] = 16'b0000000000000000;  // nop   
        IMemory[18] = 16'b0110000100000010;  // sw $1, 2($0)      X   Store $1 into DMemory[1] 
        IMemory[19] = 16'b0110001000000000;  // sw $2, 0($0)      X   Store $2 into DMemory[0]     
        IMemory[20] = 16'b0000000000000000;  // nop   
        IMemory[21] = 16'b0000000000000000;  // nop   
        IMemory[22] = 16'b0101000100000000;  // lw $1, 0($0)      4   Load DMemory[0] into $1
        IMemory[23] = 16'b0101001000000010;  // lw $2, 2($0)      2   Load DMemory[1] into $2
        IMemory[24] = 16'b0000000000000000;  // nop   
        IMemory[25] = 16'b0000000000000000;  // nop   
        IMemory[26] = 16'b0000000000000000;  // nop    
        IMemory[27] = 16'b0001011001000000;  // sub $1, $1, $2    2   $1 <- $1 - $2
        IMemory[28] = 16'b0000000000000000;  // nop   
        IMemory[29] = 16'b0000000000000000;  // nop   
        IMemory[30] = 16'b0000000000000000;  // nop   
        IMemory[31] = 16'b1001000111111011;  // bne $1, $0, -5    X   Branch to IMemory[27] if $1 != 0
        IMemory[32] = 16'b0000000000000000;  // nop   
        IMemory[33] = 16'b0000000000000000;  // nop   
        IMemory[34] = 16'b0000000000000000;  // nop   
        IMemory[35] = 16'b0110000100000010;  // sw  $1, 2($0)     0   Store $1 into DMemory[1] 
        IMemory[36] = 16'b1000010000010011;  // beq $1, $0, 4     X   Branch to IMemory[56] if $1 == 0
        IMemory[37] = 16'b0000000000000000;  // nop   
        IMemory[38] = 16'b0000000000000000;  // nop   
        IMemory[39] = 16'b0000000000000000;  // nop   
        IMemory[40] = 16'b0100000100000001;  // addi $t1, $0, 1   X   Branched over
        IMemory[41] = 16'b0000000000000000;  // nop   
        IMemory[42] = 16'b0000000000000000;  // nop   
        IMemory[43] = 16'b0000000000000000;  // nop   
        IMemory[44] = 16'b0100000100000001;  // addi $t1, $0, 1   X   Branched over
        IMemory[45] = 16'b0000000000000000;  // nop   
        IMemory[46] = 16'b0000000000000000;  // nop   
        IMemory[47] = 16'b0000000000000000;  // nop   
        IMemory[48] = 16'b0100000100000001;  // addi $t1, $0, 1   X   Branched over
        IMemory[49] = 16'b0000000000000000;  // nop   
        IMemory[50] = 16'b0000000000000000;  // nop   
        IMemory[51] = 16'b0000000000000000;  // nop   
        IMemory[52] = 16'b0100000100000001;  // addi $t1, $0, 1   X   Branched over
        IMemory[53] = 16'b0000000000000000;  // nop   
        IMemory[54] = 16'b0000000000000000;  // nop   
        IMemory[55] = 16'b0000000000000000;  // nop   
        IMemory[56] = 16'b0101001000000010;  // lw $2, 2($0)      0   Load DMemory[1] into $2

        // Data
        DMemory [0] = 16'h1;
        DMemory [1] = 16'h3;
    end

// Pipeline stages

// IF 
   wire [15:0] PCplus2, NextPC;
   reg[15:0] PC, IMemory[0:1023], IFID_IR, IFID_PCplus2;
   ALU fetch (3'b010,PC,2,PCplus2,Unused1);
   reg [1:0] EXMEM_Branch;
   reg EXMEM_Zero;
   reg [15:0] EXMEM_Target;
   branchCtrl bCtrl (EXMEM_Branch, EXMEM_Zero, branchOut);
   mux16bit2x1 branchMux (PCplus2, EXMEM_Target, branchOut, NextPC);

// ID
   wire [10:0] Control;
   reg IDEX_RegWrite,IDEX_MemtoReg,IDEX_MemWrite,IDEX_RegDst;
   reg [1:0] IDEX_Branch, IDEX_ALUSrc;
   reg [2:0]  IDEX_ALUOp;
   wire [15:0] RD1,RD2,SignExtend, WD;
   reg [15:0] IDEX_PCplus2,IDEX_RD1,IDEX_RD2,IDEX_SignExt,IDEXE_IR;
   reg [15:0] IDEX_IR; // For monitoring the pipeline
   reg [1:0]  IDEX_rt,IDEX_rd;
   reg MEMWB_RegWrite;
   reg [1:0] MEMWB_rd; 
   reg_file rf (IFID_IR[11:10],IFID_IR[9:8],MEMWB_rd,WD,MEMWB_RegWrite,RD1,RD2,clock);
   mainCtrl MainCtr (IFID_IR[15:12],Control); 
   assign SignExtend = {{8{IFID_IR[7]}},IFID_IR[7:0]}; 
  
// EXE
   reg EXMEM_RegWrite,EXMEM_MemtoReg,EXMEM_MemWrite;
   wire [15:0] Target;
   reg [15:0] EXMEM_ALUOut,EXMEM_RD2;
   reg [15:0] EXMEM_IR; // For monitoring the pipeline
   reg [1:0] EXMEM_rd; 
   wire [15:0] B,ALUOut;
   wire [1:0] WR;
   ALU branch (3'b010,IDEX_SignExt<<1,IDEX_PCplus2,Target,Unused2);
   ALU ex (IDEX_ALUOp, IDEX_RD1, B, ALUOut, Zero);

   mux2bit2x1 RegDstMux (IDEX_rt, IDEX_rd, IDEX_RegDst, WR);         // RegDst Mux
   ALUSrcControl ALUSrcControl1(B, IDEX_RD2, IDEX_SignExt, IDEX_SignExt<<8, IDEX_ALUSrc);

// MEM
   reg MEMWB_MemtoReg;
   reg [15:0] DMemory[0:1023],MEMWB_MemOut,MEMWB_ALUOut;
   reg [15:0] MEMWB_IR; // For monitoring the pipeline
   wire [15:0] MemOut;
   assign MemOut = DMemory[EXMEM_ALUOut>>1];
   always @(negedge clock) if (EXMEM_MemWrite) DMemory[EXMEM_ALUOut>>1] <= EXMEM_RD2;
  
// WB
   mux16bit2x1 Mem2Reg (MEMWB_ALUOut, MEMWB_MemOut, MEMWB_MemtoReg, WD); // MemtoReg Mux


   initial begin
    PC = 0;
// Init registers
    IDEX_RegWrite=0;IDEX_MemtoReg=0;IDEX_Branch=0;IDEX_MemWrite=0;IDEX_ALUSrc=0;IDEX_RegDst=0;IDEX_ALUOp=0;
    IFID_IR=0;
    EXMEM_RegWrite=0;EXMEM_MemtoReg=0;EXMEM_Branch=0;EXMEM_MemWrite=0;
    EXMEM_Target=0;
    MEMWB_RegWrite=0;MEMWB_MemtoReg=0;
   end

// Running the pipeline

   always @(negedge clock) begin 

// IF
    PC <= NextPC;
    IFID_PCplus2 <= PCplus2;
    IFID_IR <= IMemory[PC>>1];

// ID
    IDEX_IR <= IFID_IR; // For monitoring the pipeline
    {IDEX_RegDst,IDEX_ALUSrc,IDEX_MemtoReg,IDEX_RegWrite,IDEX_MemWrite,IDEX_Branch,IDEX_ALUOp} <= Control;   
    IDEX_PCplus2 <= IFID_PCplus2;
    IDEX_RD1 <= RD1; 
    IDEX_RD2 <= RD2;
    IDEX_SignExt <= SignExtend;
    IDEX_rt <= IFID_IR[9:8];
    IDEX_rd <= IFID_IR[7:6];

// EXE
    EXMEM_IR <= IDEX_IR; // For monitoring the pipeline
    EXMEM_RegWrite <= IDEX_RegWrite;
    EXMEM_MemtoReg <= IDEX_MemtoReg;
    EXMEM_Branch   <= IDEX_Branch;
    EXMEM_MemWrite <= IDEX_MemWrite;
    EXMEM_Target <= Target;
    EXMEM_Zero <= Zero;
    EXMEM_ALUOut <= ALUOut;
    EXMEM_RD2 <= IDEX_RD2;
    EXMEM_rd <= WR;

// MEM
    MEMWB_IR <= EXMEM_IR; // For monitoring the pipeline
    MEMWB_RegWrite <= EXMEM_RegWrite;
    MEMWB_MemtoReg <= EXMEM_MemtoReg;
    MEMWB_MemOut <= MemOut;
    MEMWB_ALUOut <= EXMEM_ALUOut;
    MEMWB_rd <= EXMEM_rd;

// WB
// Register write happens on neg edge of the clock (if MEMWB_RegWrite is asserted)

  end

endmodule

/*** CPU testing source code ***/

module test();
  reg clock;
  wire [15:0] PC,IFID_IR,IDEX_IR,EXMEM_IR,MEMWB_IR,WD;

  CPU test_cpu(clock,PC,IFID_IR,IDEX_IR,EXMEM_IR,MEMWB_IR,WD);

  always #1 clock = ~clock;
  
initial begin
    $display ("time\tPC\tIFID_IR\tIDEX_IR\tEXMEM_IR\tMEMWB_IR\tWD");
    $monitor ("%2d\t%3d\t%h\t%h\t%h\t\t%h\t\t%d", $time,PC,IFID_IR,IDEX_IR,EXMEM_IR,MEMWB_IR,WD);
    clock = 1;
    #103 $finish;
  end
endmodule

/* Compiling and simulation
C:\Users\User\git\forks\CS385-CPU\Source Files\Final>vvp out
time    PC      IFID_IR IDEX_IR EXMEM_IR        MEMWB_IR        WD
 0        0     0000    xxxx    xxxx            xxxx                x
 1        2     5100    0000    xxxx            xxxx                x
 3        4     5202    5100    0000            xxxx                x
 5        6     0000    5202    5100            0000                0
 7        8     0000    0000    5202            5100                1
 9       10     0000    0000    0000            5202                3
11       12     0980    0000    0000            0000                0
13       14     4501    0980    0000            0000                0
15       16     0000    4501    0980            0000                0
17       18     0000    0000    4501            0980                4
19       20     0000    0000    0000            4501                2
21       22     76c0    0000    0000            0000                0
23       24     0000    76c0    0000            0000                0
25       26     0000    0000    76c0            0000                0
27       28     0000    0000    0000            76c0                1
29       30     8c04    0000    0000            0000                0
31       32     0000    8c04    0000            0000                0
33       34     0000    0000    8c04            0000                0
35       36     0000    0000    0000            8c04                1
37       38     6102    0000    0000            0000                0
39       40     6200    6102    0000            0000                0
41       42     0000    6200    6102            0000                0
43       44     0000    0000    6200            6102                2
45       46     5100    0000    0000            6200                0
47       48     5202    5100    0000            0000                0
49       50     0000    5202    5100            0000                0
51       52     0000    0000    5202            5100                4
53       54     0000    0000    0000            5202                2
55       56     1640    0000    0000            0000                0
57       58     0000    1640    0000            0000                0
59       60     0000    0000    1640            0000                0
61       62     0000    0000    0000            1640                2
63       64     91fb    0000    0000            0000                0
65       66     0000    91fb    0000            0000                0
67       68     0000    0000    91fb            0000                0
69       54     0000    0000    0000            91fb            65534
71       56     1640    0000    0000            0000                0
73       58     0000    1640    0000            0000                0
75       60     0000    0000    1640            0000                0
77       62     0000    0000    0000            1640                0
79       64     91fb    0000    0000            0000                0
81       66     0000    91fb    0000            0000                0
83       68     0000    0000    91fb            0000                0
85       70     0000    0000    0000            91fb                0
87       72     6102    0000    0000            0000                0
89       74     8413    6102    0000            0000                0
91       76     0000    8413    6102            0000                0
93       78     0000    0000    8413            6102                2
95      112     0000    0000    0000            8413                0
97      114     5202    0000    0000            0000                0
99      116     xxxx    5202    0000            0000                0
101     118     xxxx    xxxx    5202            0000                0
103     120     xxxx    xxxx    xxxx            5202                0