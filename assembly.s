 addi x1, x0, 15 
 addi x2, x0, 20
 addi x3, x0, 25
 addi x4, x0, 30
 addi x5, x0, 25
 
 sw x2, 5(x1)
 sw x3, 6(x1)
 sw x4, 7(x1)
 sw x5, 8(x1)

  lw x6, 5(x1)
  lw x7, 6(x1)
  lw x8, 7(x1)
  lw x9, 8(x1)
