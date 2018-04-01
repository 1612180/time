# Thu vien TIME bang MIPS
#       $s0 save DAY
#       $s1 save MONTH
#       $s2 save YEAR

        .data
msg_nhap_ngay:
        .asciiz "Nhap ngay DAY: "
msg_nhap_thang:
        .asciiz "Nhap thang MONTH: "
msg_nhap_nam:
        .asciiz "Nhap nam YEAR: "
day_in_month_reg:
	.word 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31
day_in_month_nhuan:
	.word 31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31
str_TIME:
        .space 1024

        .text
main:
        # nhap ngay, save in $s0
        addi $v0, $zero, 4      # print str
        la $a0, msg_nhap_ngay
        syscall
        addi $v0, $zero, 5      # read int
        syscall
        add $s0, $zero, $v0     # $v0 save read int

        # nhap thang, save in $s1
        addi $v0, $zero, 4     	# print str
        la $a0, msg_nhap_thang
        syscall
        addi $v0, $zero, 5      # read int
        syscall
        add $s1, $zero, $v0     # $v0 save read int

        # nhap nam, save in $s2
        addi $v0, $zero, 4      # print str
        la $a0, msg_nhap_nam
        syscall
        addi $v0, $zero, 5      # read int
        syscall
      	add $s2, $zero, $v0     # $v0 save read int

        # goi ham Date
        add $a0, $zero, $s0
        add $a1, $zero, $s1
        add $a2, $zero, $s2
        la $a3, str_TIME
        jal Date

        # print DD/MM/YYYY
        add $a0, $zero, $v0
        addi $v0, $zero, 4
        syscall

        # exit
        addi $v0, $zero, 10
        syscall

# Ham tra ve chuoi TIME theo dinh dang DD/MM/YYYY
#       $a0 DAY
#       $a1 MONTH
#       $a2 YEAR
#       $a3 str_TIME
Date:
	# DAY -> DD
	addi $t1, $zero, 10
	div $a0, $t1
	mflo $t2		# DAY / 10
	mfhi $t3		# DAY % 10
	addi $t2, $t2, 48	# 48 is '0'
	addi $t3, $t3, 48
	sb $t2, 0($a3)
	sb $t3, 1($a3)
	addi $t4, $zero, 47	# 47 is '\'
	sb $t4, 2($a3)

	# MONTH -> MM
	addi $t1, $zero, 10
	div $a1, $t1
	mflo $t2		# MONTH / 10
	mfhi $t3		# MONTH % 10
	addi $t2, $t2, 48
	addi $t3, $t3, 48
	sb $t2, 3($a3)
	sb $t3, 4($a3)
	addi $t4, $zero, 47
	sb $t4, 5($a3)

	# YEAR -> YYYY
	add $t0, $zero, $a2	# $t0 save YEAR
	addi $t1, $zero, 1000
	div $t0, $t1
	mflo $t2		# YEAR / 1000
	mfhi $t0		# YEAR % 1000
	addi $t2, $t2, 48
	sb $t2, 6($a3)

	addi $t1, $zero, 100
	div $t0, $t1
	mflo $t2		# (YEAR % 1000) / 100
	mfhi $t0		# (YEAR % 1000) % 100
	addi $t2, $t2, 48
	sb $t2, 7($a3)

	addi $t1, $zero, 10
	div $t0, $t1
	mflo $t2		# ((YEAR % 1000) % 100) / 10
	mfhi $t0		# ((YEAR % 1000) % 100) % 10
	addi $t2, $t2, 48
	addi $t0, $t0, 48
	sb $t2, 8($a3)
	sb $t0, 9($a3)

	# exit
	sb $zero, 10($a3)
	add $v0, $zero, $a3
	jr $ra