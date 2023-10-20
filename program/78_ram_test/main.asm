        .text
start:  li $v1, 10
        sw $v1, 0x00000008
        lw $v0, 0x00000008
        sw $v0, 0x1001beb0
        lw $v0, 0x1001beb4
        sw $v0, 0x1001beb0
end:    beqz $zero, end
