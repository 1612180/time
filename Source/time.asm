# Thu vien TIME bang MIPS
# 1612180 - Nguyen Tran Hau
# 1612628 - Nguyen Duy Thanh
# 1612403 - Tran Hoai Nam
#       $s0 save DAY
#       $s1 save MONTH
#       $s2 save YEAR

# TODO Convert in type B, C
# TODO int Month(char* TIME)
# TODO int Year(char* TIME)
# TODO int LeapYear(char* TIME)
# TODO int GetTime(char* TIME_1, char* TIME_2)
# TODO char* Weekday(char* TIME)

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

        # ham Date
        add $a0, $zero, $s0
        add $a1, $zero, $s1
        add $a2, $zero, $s2
        la $a3, str_TIME
        jal Date
        # print Date: DD/MM/YYYY
        add $a0, $zero, $v0
        addi $v0, $zero, 4
        syscall
        # print '\n'
        add $a0, $zero, 10
        addi $v0, $zero, 11
        syscall

        # goi ham Convert
        la $a0, str_TIME
        addi $a1, $zero, 65
        jal Convert
        # print Convert
        add $a0, $zero, $v0
        addi $v0, $zero, 4
        syscall
        # print '\n'
        add $a0, $zero, 10
        addi $v0, $zero, 11
        syscall

        # goi ham Day
        la $a0, str_TIME
        jal Day
        add $a0, $zero, $v0
        addi $v0, $zero, 1
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
	sb $t2, 0($a3)		# str_TIME[0]
	sb $t3, 1($a3)
	addi $t4, $zero, 47	# 47 is '/'
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
	sb $zero, 10($a3)	# str_TIME[10]= '\0'
	add $v0, $zero, $a3
	jr $ra

# Ham chuyen doi dinh dang DD/MM/YYYY
#	$a0 str_TIME
#	$a1 type
#	type 'A': MM/DD/YYYY
#	type 'B': Month DD, YYYY
#	type 'C': DD Month, YYYY
Convert:
	beq $a1, 65, Convert_A	# 65 is 'A'
	beq $a1, 66, Convert_B
	beq $a1, 67, Convert_C
	j Convert_exit
Convert_A:
	# DD/MM/YYYY -> MM/DD/YYYY
	# only swap day <-> month
	# get DD, MM
	lb $t0, 0($a0)
	lb $t1, 1($a0)
	lb $t3, 3($a0)
	lb $t4, 4($a0)
	# swap
	sb $t3, 0($a0)
	sb $t4, 1($a0)
	sb $t0, 3($a0)
	sb $t1, 4($a0)
	j Convert_exit
Convert_B:
	# DD/MM/YYYY -> Month DD, YYYY

	j Convert_exit
Convert_C:
	# DD/MM/YYYY -> DD Month, YYYY
	j Convert_exit
Convert_exit:
	add $v0, $zero, $a0
	jr $ra

# Ham tra ve ngay trong TIME: DD/MM/YY
#	$a0 str_TIME
Day:
	# save to stack
	addi $sp, $sp, -4
	sw $ra, 0($sp)

	# Day is TIME[0:1]
	add $a1, $zero, $zero
	addi $a2, $zero, 1
	jal atoi

	# $v0 return from atoi is also return in Day

	# restore from stack
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	jr $ra

# str "12345" -> int 12345
# only positive, consider input is correct (only digits)
#	$a0 str
#	$a1 from
# 	$a2 to
atoi:
	add $v0, $zero, $zero	# $v0 store result
	add $t0, $a0, $a1	# p = str + from
	add $t1, $a0, $a2	# str + to
	addi $t1, $t1, 1	# str + to + 1
atoi_sum_loop:
	slt $t2, $t0, $t1	# $t2 = p < str + to + 1
	beq $t2, $zero, atoi_exit
	# result = result * 10 + *p - '0'
	addi $t3, $zero, 10
	mult $v0, $t3		# result * 10
	mflo $v0		# get from LO
	lb $t3, 0($t0)		# get *p
	addi $t3, $t3, -48	# *p - '0'
	add $v0, $v0, $t3
	addi $t0, $t0, 1	# p += 1
	j atoi_sum_loop
atoi_exit:
	jr $ra