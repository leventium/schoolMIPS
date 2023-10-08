	.text
start:  addiu $v1, $zero, 10
	sw $v1, 4
	lw $v0, 4
	lw $t0, 0x1001beb4
	addu $v0, $v0, $t0
	sw $v0, 0x1001beb0
end:	beqz $zero, end
