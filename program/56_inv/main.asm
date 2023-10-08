	.text

start:	lw $v0, 0x1001beb4
	li $t0, 8
	move $t1, $v0
	sllv $t1, $t1, $t0
	move $t2, $t1
	sllv $t2, $t2, $t0
	addu $t1, $t1, $t2
	sllv $t2, $t2, $t0
	addu $t1, $t1, $t2

	nor $t1, $t1, $t1
	li $t3, 0xff
	subu $t1, $t1, $t3
	addu $v0, $v0, $t1
	sw $v0, 0x1001beb0
end:	beqz $zero, end
