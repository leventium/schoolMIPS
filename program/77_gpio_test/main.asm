	.text
start:  lw $t0, 0x1001beb4
	sw $t0, 0x1001beb0
end:	beqz $zero, end
