	.text
start:  addiu $t1, $zero, 10
	sw $t1, 0x1001beb0
	lw $v0, 0x1001beb4
end:	beqz $zero, end
