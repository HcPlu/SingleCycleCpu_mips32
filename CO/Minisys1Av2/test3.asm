.data 0x0000  
.text 0x0000
shumeigiku:
		ori $at,$zero,1       #�Ĵ�����ʼ��
		ori $v0,$zero,2
		ori $v1,$zero,3
		ori $a0,$zero,4
		ori $a1,$zero,5
		ori $a2,$zero,6
		ori $a3,$zero,7
		ori $t0,$zero,8
		ori $t1,$zero,0
		ori $t2,$zero,10
		ori $t3,$zero,11
		ori $t4,$zero,12
		ori $t5,$zero,13
		ori $t6,$zero,14
		ori $t7,$zero,15
		ori $s0,$zero,16
		ori $s1,$zero,17
		ori $s2,$zero,18
		ori $s3,$zero,19
		ori $s4,$zero,20
		ori $s5,$zero,21
		ori $s6,$zero,22
		ori $s7,$zero,23
		ori $t8,$zero,24
		ori $t9,$zero,25
		ori $i0,$zero,26
		ori $i1,$zero,27
		ori $s9,$zero,28
		ori $sp,$zero,29
		ori $s8,$zero,30
		ori $ra,$zero,31
lui  $28,0xFFFF
ori $28,$28,0xF000
ori $13,$zero,1
ori $1,$zero,0x0020
ori $2,$zero,0x0040
ori $3,$zero,0x0060
ori $5,$zero,0x00A0
ori $6,$zero,0x00C0
ori $7,$zero,0x00E0
ori $8,$zero,0x5555
ori $17,$zero,0xFFFF
start:
lw $10,0xC72($28)
beq $10,$1,cd1
beq $10,$2,cd2
beq $10,$3,cd3
beq $10,$5,cd5
beq $10,$6,cd6
beq $10,$7,cd7
xori $8,$8,0xFFFF
sw $8,0xC60($28)
j start