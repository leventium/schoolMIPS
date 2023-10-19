        .text
start:  li $v0, 10
        sw $v0, 0x00000008
        lw $t0, 0x00000008
        sw $t0, 0x0000beb0
        lw $t0, 0x0000beb4
        sw $t0, 0x0000beb0
end:    beqz $zero, end
