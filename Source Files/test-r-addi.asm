# Test program for mips-r-type+addi.vl

  .text	

  .globl __start 
__start:

  addi $t1, $0,  15   # $t1=15 0100 00 01 00001111
  addi $t2, $0,  7    # $t2= 7 0100 00 10 00000111
  and  $t3, $t1, $t2  # $t3= 7 0000 01 10 11 xxxxxx
  sub  $t2, $t1, $t3  # $t2= 8 0110 01 11 10 xxxxxx 
  or   $t2, $t2, $t3  # $t2=15 0001 10 11 10 xxxxxx
  add  $t3, $t2, $t3  # $t3=22 0010 10 11 11 xxxxxx
  slt  $t1, $t3, $t2  # $t1= 0 0111 11 10 01 xxxxxx
  slt  $t1, $t2, $t3  # $t1= 1 0111 10 10 01 xxxxxx

  # 0100 00 01 00001111
  # 0100 00 10 00000111
  # 0010 01 10 11 xxxxxx
  # 0001 01 11 10 xxxxxx
  # 0011 10 11 10 xxxxxx
  
  # 0111 11 10 01 xxxxxx
  # 0111 10 11 01 xxxxxx





