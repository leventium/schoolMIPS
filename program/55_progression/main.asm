           .text

start:     addiu $t1, $zero, 13
           addiu $t2, $zero, 91
           addu $t3, $t1, $t2
           subu $t4, $t2, $t1
           addiu $t4, $t4, 2
           mul $t5, $t4, $t3
           
           addiu $t6, $zero, 2
           srlv $t7, $t5, $t6
           
loop:      beq $zero, $zero, loop
