	.text
loop:   li $v0, 10
        lw $v0, 0x1001beb4
        sw $v0, 0x1001beb0
        beqz $zero, loop
