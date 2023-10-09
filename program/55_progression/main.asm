           .text

start:     li $t7, 0xbebe
           sw $t7, 0x1001beb0
           lw $t1, 0x1001beb4
           li $t7, 0xbaba
           sw $t7, 0x1001beb0
           lw $t2, 0x1001beb4
           addu $t3, $t1, $t2
           subu $t4, $t2, $t1
           addiu $t4, $t4, 2
           mul $t5, $t4, $t3
           
           addiu $t6, $zero, 2
           srlv $v0, $t5, $t6
           sw $v0, 0x1001beb0
           
end:       beq $zero, $zero, end
