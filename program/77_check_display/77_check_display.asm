	.text
	
start:  addiu $t0, $zero, 10
	sw $t0, 0x1001beb0
end:	beqz $zero, end
