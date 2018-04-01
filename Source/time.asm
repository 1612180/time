# Thu vien TIME bang MIPS
# 1612180 - Nguyen Tran Hau
# 1612628 - Nguyen Duy Thanh
# 1612403 - Tran Hoai Nam
#	TIME_1
#       $s0 save DAY
#       $s1 save MONTH
#       $s2 save YEAR
#	TIME_2
#       $s3 save DAY
#       $s4 save MONTH
#       $s5 save YEAR

# TODO Convert in type B, C
# TODO char* Weekday(char* TIME)

        .data
msg_nhap_ngay:
        .asciiz "Nhap ngay DAY: "
msg_nhap_thang:
        .asciiz "Nhap thang MONTH: "
msg_nhap_nam:
        .asciiz "Nhap nam YEAR: "
TIME_1:
        .space 1024
TIME_2:
	.space 1024

        .text
main:
	# nhap TIME_1
	# nhap ngay, save in $s0
        addi $v0, $zero, 4      # syscall print str
        la $a0, msg_nhap_ngay	# $a0 is str
        syscall
        addi $v0, $zero, 5      # syscall read int
        syscall
        add $s0, $zero, $v0     # $s0 get read int from $v0

        # nhap thang, save in $s1
        addi $v0, $zero, 4	# syscall print str
        la $a0, msg_nhap_thang	# $a0 is str
        syscall
        addi $v0, $zero, 5	# syscall read int
        syscall
        add $s1, $zero, $v0	# $s1 get read int from $v0

        # nhap nam, save in $s2
        addi $v0, $zero, 4	# syscall print str
        la $a0, msg_nhap_nam	# $a0 is str
        syscall
        addi $v0, $zero, 5	# syscall read int
        syscall
      	add $s2, $zero, $v0	# $s2 get read int from $v0

        # ham Date
        add $a0, $zero, $s0	# $a0 la ngay
        add $a1, $zero, $s1	# $a1 la thang
        add $a2, $zero, $s2	# $a2 la nam
        la $a3, TIME_1
        jal Date
        # print Date: DD/MM/YYYY
        add $a0, $zero, $v0
        addi $v0, $zero, 4
        syscall
        # print '\n'
        add $a0, $zero, 10
        addi $v0, $zero, 11
        syscall

	# nhap TIME_2
        # nhap ngay, save in $s0
        addi $v0, $zero, 4      # print str
        la $a0, msg_nhap_ngay
        syscall
        addi $v0, $zero, 5      # read int
        syscall
        add $s3, $zero, $v0     # $v0 save read int

        # nhap thang, save in $s1
        addi $v0, $zero, 4
        la $a0, msg_nhap_thang
        syscall
        addi $v0, $zero, 5
        syscall
        add $s4, $zero, $v0

        # nhap nam, save in $s2
        addi $v0, $zero, 4
        la $a0, msg_nhap_nam
        syscall
        addi $v0, $zero, 5
        syscall
      	add $s5, $zero, $v0

        # ham Date
        add $a0, $zero, $s3
        add $a1, $zero, $s4
        add $a2, $zero, $s5
        la $a3, TIME_2
        jal Date
        # print Date: DD/MM/YYYY
        add $a0, $zero, $v0
        addi $v0, $zero, 4
        syscall
        # print '\n'
        add $a0, $zero, 10
        addi $v0, $zero, 11
        syscall

        # GetTime
        la $a0, TIME_1
        la $a1, TIME_2
        jal GetTime
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
#       $a3 TIME
Date:
	# DAY -> DD
	addi $t1, $zero, 10
	div $a0, $t1
	mflo $t2		# $t2 save DAY / 10
	mfhi $t3		# $t3 save DAY % 10
	addi $t2, $t2, 48	# $t2 from int to char, 48 is '0'
	addi $t3, $t3, 48	# $t3 from int to char
	sb $t2, 0($a3)		# TIME[0] = $t2
	sb $t3, 1($a3)		# TIME[1] = $t3
	addi $t4, $zero, 47	# 47 is '/'
	sb $t4, 2($a3)		# TIME[2] = '/'

	# MONTH -> MM
	addi $t1, $zero, 10
	div $a1, $t1
	mflo $t2		# $t2 MONTH / 10
	mfhi $t3		# $t3 MONTH % 10
	addi $t2, $t2, 48	# $t2 from int to char
	addi $t3, $t3, 48	# $t3 from int to char
	sb $t2, 3($a3)		# TIME[3] = $t2
	sb $t3, 4($a3)		# TIME[4] = $t3
	addi $t4, $zero, 47	# 47 is '/'
	sb $t4, 5($a3)		# TIME[5] = '/'

	# YEAR -> YYYY
	add $t0, $zero, $a2	# $t0 save YEAR
	addi $t1, $zero, 1000
	div $t0, $t1
	mflo $t2		# $t2 save YEAR / 1000
	mfhi $t0		# $t0 save YEAR % 1000
	addi $t2, $t2, 48	# $t2 from int to char
	sb $t2, 6($a3)		# TIME[6] = $t2

	addi $t1, $zero, 100
	div $t0, $t1
	mflo $t2		# $t2 save (YEAR % 1000) / 100
	mfhi $t0		# $t0 save YEAR % 100
	addi $t2, $t2, 48	# $t2 from int to char
	sb $t2, 7($a3)		# TIME[7] = $t2

	addi $t1, $zero, 10
	div $t0, $t1
	mflo $t2		# $t2 save (YEAR % 100) / 10
	mfhi $t0		# $t0 save YEAR % 10
	addi $t2, $t2, 48	# $t2 from int to char
	addi $t0, $t0, 48	# $t0 from int to char
	sb $t2, 8($a3)		# TIME[8] = $t2
	sb $t0, 9($a3)		# TIME[9] = $t0

	# exit
	sb $zero, 10($a3)	# TIME[10]= '\0'
	add $v0, $zero, $a3	# tra ve $a3 giu dia chi TIME
	jr $ra

# Ham chuyen doi dinh dang DD/MM/YYYY
#	$a0 TIME
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

# Ham tra ve ngay trong TIME: DD/MM/YYYY
#	$a0 TIME
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

# Ham tra ve thang trong TIME: DD/MM/YYYY
#	$a0 TIME
Month:
	# save to stack
	addi $sp, $sp, -4
	sw $ra, 0($sp)

	# Month is TIME[3:4]
	addi $a1, $zero, 3
	addi $a2, $zero, 4
	jal atoi

	# $v0 return from atoi is also return in Month

	# restore from stack
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	jr $ra

# Ham tra ve nam trong TIME: DD/MM/YYYY
#	$a0 TIME
Year:
	# save to stack
	addi $sp, $sp, -4
	sw $ra, 0($sp)

	# Year is TIME[6:9]
	addi $a1, $zero, 6
	addi $a2, $zero, 9
	jal atoi

	# $v0 return from atoi is also return in Year

	# restore from stack
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	jr $ra

# Ham kiem tra nam nhuan
#	$a0 TIME
LeapYear:
	# save to stack
	addi $sp, $sp, -4
	sw $ra, 0($sp)

	jal Year
	add $t0, $zero, $v0	# $t0 save year

	# if year % 400 == 0, nam nhuan
	addi $t1, $zero, 400
	div $t0, $t1
	mfhi $t2 		#  year % 400
	beq $t2, $zero, LeapYear_nhuan

	# if year % 4 != 0, nam khong nhuan
	addi $t1, $zero, 4
	div $t0, $t1
	mfhi $t2 		# year % 4
	bne $t2, $zero, LeapYear_khong_nhuan

	# after above, year % 4 == 0, need to check year % 100 != 0
	addi $t1, $zero, 100
	div $t0, $t1
	mfhi $t2 		# year % 100
	beq $t2, $zero, LeapYear_khong_nhuan
LeapYear_nhuan:
	addi $v0, $zero, 1
	j LeapYear_exit
LeapYear_khong_nhuan:
	add $v0, $zero, $zero
	j LeapYear_exit
LeapYear_exit:
	# restore from stack
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	jr $ra

# str "12345" -> int 12345
# only positive, consider input is correct (only digits)
#	$a0 string
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

# Ham kiem tra tinh hop le cua ngay, thang, nam vua nhap
# 	$a0 TIME
check_hop_le:
	# save to stack
	addi $sp, $sp, -12
	sw $ra, 8($sp)

	# Check month in 1..12
	jal Month
	add $t1, $zero, $v0	# $t1 save month
	slti $t0, $t1, 1	# $t0 = month < 1
	bne $t0, $zero, check_hop_le_khong
	slti $t0, $t1, 13	# $t0 = month < 13
	beq $t0, $zero , check_hop_le_khong
	sw $t1, 4($sp)		# $t1 will lose in next jal

	# Check day in month
	jal Day
	add $t2, $zero, $v0	# $t2 save day
	lw $t1, 4($sp)		# restore $t1 after jal

	addi $t3, $zero, 1	# thang 1
	beq $t1, $t3, check_31_ngay
	addi $t3, $zero, 2
	beq $t1, $t3, check_thang_2
	addi $t3, $zero, 3
	beq $t1, $t3, check_31_ngay
	addi $t3, $zero, 4
	beq $t1, $t3, check_30_ngay
	addi $t3, $zero, 5
	beq $t1, $t3, check_31_ngay
	addi $t3, $zero, 6
	beq $t1, $t3, check_30_ngay
	addi $t3, $zero, 7
	beq $t1, $t3, check_31_ngay
	addi $t3, $zero, 8
	beq $t1, $t3, check_31_ngay
	addi $t3, $zero, 9
	beq $t1, $t3, check_30_ngay
	addi $t3, $zero, 10
	beq $t1, $t3, check_31_ngay
	addi $t3, $zero, 11
	beq $t1, $t3, check_30_ngay
	addi $t3, $zero, 12
	beq $t1, $t3, check_31_ngay
check_31_ngay:
	slti $t0, $t2, 1	# $t0 = day < 1
	bne $t0, $zero, check_hop_le_khong
	slti $t0, $t2, 32	# $t0 = day < 32
	beq $t0, $zero, check_hop_le_khong
	j check_hop_le_co
check_30_ngay:
	slti $t0, $t2, 1	# $t0 = day < 1
	bne $t0, $zero, check_hop_le_khong
	slti $t0, $t2, 31	# $t0 = day < 31
	beq $t0, $zero, check_hop_le_khong
	j check_hop_le_co
check_thang_2:
	slti $t0, $t2, 1	# $t0 = day < 1
	bne $t0, $zero, check_hop_le_khong
	slti $t0, $t2, 30	# $t0 = day < 30
	beq $t0, $zero, check_hop_le_khong
	sw $t2, 0($sp)		# save $t2 before jal
	jal LeapYear
	add $t4, $zero, $v0	# $t4 = 0 la nam khong nhuan
	lw $t2, 0($sp)		# restore $t2 after jal
	beq $t4, $zero, check_thang_2_khong_nhuan
	j check_hop_le_co
check_thang_2_khong_nhuan:
	addi $t5, $zero, 29
	beq $t2, $t5, check_hop_le_khong
	j check_hop_le_co
check_hop_le_co:
	addi $v0, $zero, 1
	j check_hop_le_exit
check_hop_le_khong:
	add $v0, $zero, $zero
	j check_hop_le_exit
check_hop_le_exit:
	# restore from stack
	lw $ra, 8($sp)
	addi $sp, $sp, 12
	jr $ra

# Ham tra ve khoang cach thoi gian, tinh bang nam
#	$a0 TIME_1
#	$a1 TIME_2
GetTime:
	# save to stack
	addi $sp, $sp, -16
	sw $ra, 12($sp)
	sw $a0, 8($sp)
	sw $a1, 4($sp)

	jal Year
	add $t0, $zero, $v0	# $t0 save Year(TIME_1)

	sw $t0, 0($sp)		# $t0 will lose in next jal
	lw $a0, 4($sp)		# load TIME_2 to $a0
	jal Year
	add $t1, $zero, $v0	# $t1 save Year(TIME_2)
	lw $t0, 0($sp)		# restore $t0

	sub $v0, $t0, $t1 	# year diff between TIME_1 and TIME_2
	slt $t2, $v0, $zero	# $t2 = $v0 < 0
	beq $t2, $zero, GetTime_exit
	sub $v0, $zero, $v0	# doi dau

GetTime_exit:
	# restore from stack
	lw $ra, 12($sp)
	lw $a0, 8($sp)
	lw $a1, 4($sp)
	addi $sp, $sp, 16
	jr $ra