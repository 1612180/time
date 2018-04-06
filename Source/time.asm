# Thu vien TIME bang MIPS
# 1612180 - Nguyen Tran Hau
# 1612628 - Nguyen Duy Thanh
# 1612403 - Tran Hoai Nam

# TODO yeu cau 3, 5 ,6

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
str_temp:
	.space 1024
TEMP_1:
	.space 1024
TEMP_2:
	.space 1024
yeu_cau_chon:
	.asciiz "----Ban hay chon 1 trong cac thao tac duoi day----\n"
yeu_cau_1:
	.asciiz "1. Xuat chuoi TIME theo dinh dang DD/MM/YYYY\n"
yeu_cau_2:
	.asciiz "2. Xuat chuoi TIME thanh mot trong cac dinh dang sau\n   A. MM/DD/YYYY\n   B. Month DD, YYYY\n   C. DD Month, YYYY\n"
yeu_cau_2_type:
	.asciiz "Chon dinh dang A, B hay C\n"
yeu_cau_3:
	.asciiz "3. Cho biet ngay vua nhap la thu may trong tuan\n"
yeu_cau_4:
	.asciiz "4. Kiem tra nam trong chuoi TIME co phai la nam nhuan khong\n"
yeu_cau_5:
	.asciiz "5. Cho biet khoang thoi gian giua chuoi TIME_1 va TIME_2\n"
yeu_cau_6:
	.asciiz "6. Cho biet 2 nam nhuan gan nhat voi nam trong chuoi TIME\n"
yeu_cau_7:
	.asciiz "7. Kiem tra bo du lieu dau vao khi nhap, neu du lieu khong hop le thi yeu cau nguoi dung nhap lai\n"
Month_1:
	.asciiz "January"
Month_2:
	.asciiz "February"
Month_3:
	.asciiz "March"
Month_4:
	.asciiz "April"
Month_5:
	.asciiz "May"
Month_6:
	.asciiz "June"
Month_7:
	.asciiz "July"
Month_8:
	.asciiz "August"
Month_9:
	.asciiz "September"
Month_10:
	.asciiz "October"
Month_11:
	.asciiz "November"
Month_12:
	.asciiz "December"
msg_convert_khonghople:
	.asciiz "Type khong phai A, B, C\n"
msg_yc_khonghople:
	.asciiz "Yeu cau nhap vao khong phai 1-7\n"
msg_nam_nhuan:
	.asciiz "Nam nhuan\n"
msg_nam_khong_nhuan:
	.asciiz "Khong phai nam nhuan\n"
msg_input_hople:
	.asciiz "Du lieu dau vao hop le\n"
msg_input_khonghople:
	.asciiz "Du lieu dau vao khong hop le\n"
str_Chu_nhat:
	.asciiz "Sun"
str_Thu_2:
	.asciiz "Mon"
str_Thu_3:
	.asciiz "Tues"
str_Thu_4:
	.asciiz "Wed"
str_Thu_5:
	.asciiz "Thurs"
str_Thu_6:
	.asciiz "Fri"
str_Thu_7:
	.asciiz "Sat"

        .text
# Ham main cho nguoi dung chon yeu cau
# 	$s0 save TIME_1
#	$s1 tinh hop le TIME_1
#	$s2 yeu cau cua nguoi dung
main:
	# Nhap ngay, thang, nam TIME_1 luu vao $s0
	la $a0, TIME_1
	la $a1, str_temp
	jal nhap_time
	add $s0, $zero, $v0	# save TIME_1
	add $s1, $zero, $v1	# save hop le TIME_1

	# In ra toan bo yeu cau
	la $a0, yeu_cau_chon
	addi $v0, $zero, 4	# syscall print string
	syscall
	la $a0, yeu_cau_1
	addi $v0, $zero, 4	# syscall print string
	syscall
	la $a0, yeu_cau_2
	addi $v0, $zero, 4	# syscall print string
	syscall
	la $a0, yeu_cau_3
	addi $v0, $zero, 4	# syscall print string
	syscall
	la $a0, yeu_cau_4
	addi $v0, $zero, 4	# syscall print string
	syscall
	la $a0, yeu_cau_5
	addi $v0, $zero, 4	# syscall print string
	syscall
	la $a0, yeu_cau_6
	addi $v0, $zero, 4	# syscall print string
	syscall
	la $a0, yeu_cau_7
	addi $v0, $zero, 4	# syscall print string
	syscall

	# Doc yeu cau cua nguoi dung, luu vao $s2
	addi $v0, $zero, 5	# syscall read int
	syscall
	add $s2, $zero, $v0

	addi $t0, $zero, 1	# yeu cau 1
	beq $s2, $t0, main_yc1
	addi $t0, $zero, 2	# yeu cau 2
	beq $s2, $t0, main_yc2
	addi $t0, $zero, 3	# yeu cau 3
	beq $s2, $t0, main_yc3
	addi $t0, $zero, 4 	# yeu cau 4
	beq $s2, $t0, main_yc4
	addi $t0, $zero, 5 	# yeu cau 5
	beq $s2, $t0, main_yc5
	addi $t0, $zero, 7 	# yeu cau 7
	beq $s2, $t0, main_yc7

	j main_yc_khonghople
main_yc1:
	# Print DD/MM/YYYY
	add $a0, $zero, $s0	# TIME_1
	addi $v0, $zero, 4	# syscall print string
	syscall
	j main_exit

main_yc2:
	# Chon dinh dang A, B hay C
	la $a0, yeu_cau_2_type
	addi $v0, $zero, 4	# syscall print string
	syscall
	addi $v0, $zero, 12	# syscall read char
	syscall
	add $s2, $zero, $v0	# $s2 = type

	# print new line
	add $a0, $zero, 10	# 10 is '\n'
	addi $v0, $zero, 11	# syscall print char
	syscall

	# Convert
	add $a0, $zero, $s0	# TIME_1
	add $a1, $zero, $s2	# $s2 la type nhap vao
	jal Convert

	# In dinh dang da chuyen doi
	add $a0, $zero, $s0
	addi $v0, $zero, 4	# syscall print string
	syscall
	j main_exit

main_yc3:
	add $a0, $zero, $s0
	jal xacDinhThu
	add $a0, $zero, $v0
	addi $v0, $zero, 4	# syscall print string
	syscall
	j main_exit

main_yc4:
	add $a0, $zero, $s0	# TIME_1
	jal LeapYear
	beq $v0, $zero, main_yc4_khong_nhuan
	la $a0, msg_nam_nhuan
	addi $v0, $zero, 4	# syscall print string
	syscall
	jal main_yc4_exit
main_yc4_khong_nhuan:
	la $a0, msg_nam_khong_nhuan
	addi $v0, $zero, 4	# syscall print string
	syscall
	jal main_yc4_exit
main_yc4_exit:
	j main_exit

main_yc5:
	# get TIME_2
	la $a0, TIME_2
	la $a1, str_temp
	jal nhap_time

	# Tinh khoang cach
	la $a0, TIME_1
	la $a1, TIME_2
	jal GetTime
	add $a0, $zero, $v0	# Lay khoang cach luu vao $a0
	addi $v0, $zero, 1	# syscall print int
	syscall
	j main_exit

main_yc7:
	beq $s1, $zero, main_yc7_input_khonghople
	la $a0, msg_input_hople
	addi $v0, $zero, 4	# syscall print string
	syscall
	j main_yc7_exit
main_yc7_input_khonghople:
	la $a0, msg_input_khonghople
	addi $v0, $zero, 4	# syscall print string
	syscall
main_yc7_exit:
	j main_exit

main_yc_khonghople:
	la $a0, msg_yc_khonghople
	addi $v0, $zero, 4	# syscall print string
	syscall
	j main_exit

main_exit:
        addi $v0, $zero, 10
        syscall

# Ham tra ve chuoi TIME theo dinh dang DD/MM/YYYY
#       $a0 DAY
#       $a1 MONTH
#       $a2 YEAR
#       $a3 TIME
#	$v0 TIME dang DD/MM/YYYY
Date:
	# DAY -> DD
	addi $t1, $zero, 10
	div $a0, $t1
	mflo $t2		# $t2 = DAY / 10
	mfhi $t3		# $t3 = DAY % 10
	addi $t2, $t2, 48	# $t2 from int to char, 48 is '0'
	addi $t3, $t3, 48	# $t3 from int to char
	sb $t2, 0($a3)		# TIME[0] = $t2
	sb $t3, 1($a3)		# TIME[1] = $t3
	addi $t4, $zero, 47	# 47 is '/'
	sb $t4, 2($a3)		# TIME[2] = '/'

	# MONTH -> MM
	addi $t1, $zero, 10
	div $a1, $t1
	mflo $t2		# $t2 = MONTH / 10
	mfhi $t3		# $t3 = MONTH % 10
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
	mflo $t2		# $t2 = YEAR / 1000
	mfhi $t0		# $t0 = YEAR % 1000
	addi $t2, $t2, 48	# $t2 from int to char
	sb $t2, 6($a3)		# TIME[6] = $t2

	addi $t1, $zero, 100
	div $t0, $t1
	mflo $t2		# $t2 = (YEAR % 1000) / 100
	mfhi $t0		# $t0 = YEAR % 100
	addi $t2, $t2, 48	# $t2 from int to char
	sb $t2, 7($a3)		# TIME[7] = $t2

	addi $t1, $zero, 10
	div $t0, $t1
	mflo $t2		# $t2 = (YEAR % 100) / 10
	mfhi $t0		# $t0 = YEAR % 10
	addi $t2, $t2, 48	# $t2 from int to char
	addi $t0, $t0, 48	# $t0 from int to char
	sb $t2, 8($a3)		# TIME[8] = $t2
	sb $t0, 9($a3)		# TIME[9] = $t0

	# exit
	sb $zero, 10($a3)	# TIME[10] = '\0'
	add $v0, $zero, $a3	# tra ve $a3 giu dia chi TIME
	jr $ra

# Ham chuyen doi dinh dang DD/MM/YYYY
#	$a0 TIME
#	$a1 type
#	type 'A': MM/DD/YYYY
#	type 'B': Month DD, YYYY
#	type 'C': DD Month, YYYY
Convert:
	addi $t0, $zero, 65	# 65 is 'A'
	beq $a1, $t0, Convert_A
	addi $t0, $zero, 66
	beq $a1, $t0, Convert_B
	addi $t0, $zero, 67
	beq $a1, $t0, Convert_C
	j Convert_khonghople
Convert_A:
	# DD/MM/YYYY -> MM/DD/YYYY
	# only swap day <-> month
	# get DD, MM
	lb $t0, 0($a0)		# $t0 = TIME[0]
	lb $t1, 1($a0)		# $t1 = TIME[1]
	lb $t3, 3($a0)		# $t3 = TIME[3]
	lb $t4, 4($a0)		# $t4 = TIME[4]
	# swap
	sb $t3, 0($a0)		# TIME[0] = $t3
	sb $t4, 1($a0)		# TIME[1] = $t4
	sb $t0, 3($a0)		# TIME[3] = $t0
	sb $t1, 4($a0)		# TIME[4] = $t1
	j Convert_exit
Convert_B:
	# DD/MM/YYYY -> Month DD, YYYY
	# save to stack
	addi $sp, $sp, -32
	sw $ra, 28($sp)
	sw $a0, 24($sp)
	sw $a1, 20($sp)

	# Month 1 -> January
	jal Month
	add $a0, $zero, $v0	# $a0 = month (int)
	jal Month_in_String
	sw $v0, 16($sp)		# save month (string)

	lw $a0, 24($sp)		# $a0 = TIME

	# Copy " DD, " from TIME[0-1] to TEMP_1
	la $t0, TEMP_1
	addi $t1, $zero, 32	# 32 is ' '
	sb $t1, 0($t0)		# TEMP_1[0] = ' '

	lb $t1, 0($a0)		# D1 = TIME[0]
	sb $t1, 1($t0)		# TEMP_1[1] = D1
	lb $t1, 1($a0)		# D2 = TIME[1]
	sb $t1, 2($t0)		# TEMP_1[2] = D2

	addi $t1, $zero, 44	# 44 is ','
	sb $t1, 3($t0)		# TEMP_1[3] = ','
	addi $t1, $zero, 32	# 32 is ' '
	sb $t1, 4($t0)		# TEMP_1[4] = ' '
	sb $zero, 5($t0)	# TEMP_1[5] = '\0'
	sw $t0, 12($sp)		# save TEMP_1

	# Copy "YYYY" from TIME[6:9] to TEMP_2
	la $t0, TEMP_2
	lb $t1, 6($a0) 		# Y1 = TIME[6]
	sb $t1, 0($t0)		# TEMP_2[0] = Y1
	lb $t1, 7($a0) 		# Y2 = TIME[7]
	sb $t1, 1($t0)		# TEMP_2[1] = Y2
	lb $t1, 8($a0) 		# Y3 = TIME[8]
	sb $t1, 2($t0)		# TEMP_2[2] = Y3
	lb $t1, 9($a0) 		# Y4 = TIME[9]
	sb $t1, 3($t0)		# TEMP_2[3] = Y4
	sb $zero, 4($t0)	# TIME_2[4] = '\0'
	sw $t0, 8($sp) 		# save TEMP_2

	# Copy month (string) to TIME
	lw $a1, 16($sp)		# $a1 = month (string)
	jal strcpy

	# Noi " DD, " luu trong TEMP_1 vao TIME
	lw $a1, 12($sp)		# $a1 = TEMP_1
	jal strcat

	# Noi "YYYY" luu trong TEMP_2 vao TIME
	lw $a1, 8($sp)		# $a1 = TEMP_2
	jal strcat

	# restore from stack
	lw $ra, 28($sp)
	lw $a0, 24($sp)
	lw $a1, 20($sp)
	addi $sp, $sp, 32

	j Convert_exit
Convert_C:
	# DD/MM/YYYY -> DD Month, YYYY
	# save to stack
	addi $sp, $sp, -32
	sw $ra, 28($sp)
	sw $a0, 24($sp)
	sw $a1, 20($sp)

	# Month 1 -> January
	jal Month
	add $a0, $zero, $v0	# $a0 = month (int)
	jal Month_in_String
	sw $v0, 16($sp)		# save month (string)

	lw $a0, 24($sp)		# $a0 = TIME

	# Copy "DD " from TIME[0-1] to TEMP_1
	la $t0, TEMP_1
	lb $t1, 0($a0)		# D1 = TIME[0]
	sb $t1, 0($t0)		# TEMP_1[0] = D1
	lb $t1, 1($a0)		# D2 = TIME[1]
	sb $t1, 1($t0)		# TEMP_1[1] = D2

	addi $t1, $zero, 32	# 32 is ' '
	sb $t1, 2($t0)		# TEMP_1[2] = ' '
	sb $zero, 3($t0)	# TEMP_1[3] = '\0'
	sw $t0, 12($sp)		# save TEMP_1

	# Copy ", YYYY" from TIME[6:9] to TEMP_2
	la $t0, TEMP_2
	addi $t1, $zero, 44	# 44 is ','
	sb $t1, 0($t0)		# TEMP_2[0] = ','
	addi $t1, $zero, 32	# 32 is ' '
	sb $t1, 1($t0)		# TEMP_2[1] = ' '

	lb $t1, 6($a0) 		# Y1 = TIME[6]
	sb $t1, 2($t0)		# TEMP_2[2] = Y1
	lb $t1, 7($a0) 		# Y2 = TIME[7]
	sb $t1, 3($t0)		# TEMP_2[3] = Y2
	lb $t1, 8($a0) 		# Y3 = TIME[8]
	sb $t1, 4($t0)		# TEMP_2[4] = Y3
	lb $t1, 9($a0) 		# Y4 = TIME[9]
	sb $t1, 5($t0)		# TEMP_2[5] = Y4
	sb $zero, 6($t0)	# TIME_2[6] = '\0'
	sw $t0, 8($sp) 		# save TEMP_2

	# Copy "DD " luu trong TEMP_1 vao TIME
	lw $a1, 12($sp)		# $a1 = TEMP_1
	jal strcpy

	# Noi month (string) vao TIME
	lw $a1, 16($sp)		# $a1 = month (string)
	jal strcat

	# Noi ", YYYY" luu trong TEMP_2 vao TIME
	lw $a1, 8($sp)		# $a1 = TEMP_2
	jal strcat

	# restore from stack
	lw $ra, 28($sp)
	lw $a0, 24($sp)
	lw $a1, 20($sp)
	addi $sp, $sp, 32

	j Convert_exit
Convert_khonghople:
	# save to stack
	addi $sp, $sp, -8
	sw $a0, 4($sp)
	sw $a1, 0($sp)

	la $a0, msg_convert_khonghople
	addi $v0, $zero, 4	# syscall print string
	syscall

	# restore from stack
	lw $a0, 4($sp)
	lw $a1, 0($sp)
	addi $sp, $sp, 8
	j Convert_exit
Convert_exit:
	add $v0, $zero, $a0	# tra ve $a0 giu dia chi TIME
	jr $ra

# Ham tra ve ngay trong TIME: DD/MM/YYYY
#	$a0 TIME
#	$v0 day in TIME
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
# 	$v0 month in TIME
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
# 	$v0 year in TIME
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
# 	$v0 tra ve 	1 - nam nhuan, 0 - khong phai
LeapYear:
	# save to stack
	addi $sp, $sp, -4
	sw $ra, 0($sp)

	jal Year
	add $t0, $zero, $v0			# $t0 save year

	addi $t1, $zero, 400
	div $t0, $t1
	mfhi $t2 				# $t2 = year % 400
	beq $t2, $zero, LeapYear_nhuan 		# neu year chia het cho 400

	addi $t1, $zero, 4
	div $t0, $t1
	mfhi $t2 				# $t2 = year % 4
	bne $t2, $zero, LeapYear_khong_nhuan 	# neu year khong chia het cho 4

	addi $t1, $zero, 100
	div $t0, $t1
	mfhi $t2 				# $t2 = year % 100
	beq $t2, $zero, LeapYear_khong_nhuan 	# neu year chia het cho 4 va 100
LeapYear_nhuan:
	addi $v0, $zero, 1			# $t0 tra ve 1 la nam nhuan
	j LeapYear_exit
LeapYear_khong_nhuan:
	add $v0, $zero, $zero			# $t0 tra ve 0 la nam khnong nhuan
	j LeapYear_exit
LeapYear_exit:
	# restore from stack
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	jr $ra

# str "12345" -> int 12345
# only positive, consider input is correct (only digits)
#	$a0 str
#	$a1 from
# 	$a2 to
#	$v0 int
atoi:
	add $v0, $zero, $zero	# $v0 is result
	add $t0, $a0, $a1	# $t0 store p, p = str + from
	add $t1, $a0, $a2	# $t1 = str + to
	addi $t1, $t1, 1	# $t1 = str + to + 1
atoi_sum_loop:
	slt $t2, $t0, $t1
	beq $t2, $zero, atoi_exit	# neu p <= str + to
	# result = result * 10 + *p - '0'
	addi $t3, $zero, 10
	mult $v0, $t3
	mflo $v0		# result = result * 10
	lb $t3, 0($t0)		# $t3 = *p
	addi $t3, $t3, -48	# from char to int, *p = *p - '0'
	add $v0, $v0, $t3	# result += *p - '0'
	addi $t0, $t0, 1	# p += 1
	j atoi_sum_loop
atoi_exit:
	jr $ra

# atoi cho truong hop nguyen chuoi (doc den '\0')
# 	$a0 str
# 	$v0 int
atoi_whole:
	add $v0, $zero, $zero	# $v0 is result
	add $t0, $zero, $a0	# $t0 is pointer p, p = str
atoi_whole_loop:
	lb $t1, 0($t0)				# $t1 = *p
	beq $t1, $zero, atoi_whole_exit		# neu *p == '\0'
	# result = result * 10 + *p - '0'
	addi $t2, $zero, 10
	beq $t1, $t2, atoi_whole_exit		# neu *p == '\n'
	mult $v0, $t2
	mflo $v0		# result = result * 10
	addi $t1, $t1, -48	# from char to int, *p = *p -'0'
	add $v0, $v0, $t1	# result += *p - '0'
	add $t0, $t0, 1		# p += 1
	j atoi_whole_loop
atoi_whole_exit:
	jr $ra

# Ham kiem tra tinh hop le cua ngay, thang, nam vua nhap
# 	$a0 TIME
# 	$v0 tinh hop le 	1 - hop le, 0 - khong hop le
check_hop_le:
	# save to stack
	addi $sp, $sp, -12
	sw $ra, 8($sp)

	# Check month in 1..12
	jal Month
	add $t1, $zero, $v0			# $t1 = month
	slti $t0, $t1, 1
	bne $t0, $zero, check_hop_le_khong 	# neu month < 1
	slti $t0, $t1, 13
	beq $t0, $zero , check_hop_le_khong 	# neu month >= 13
	sw $t1, 4($sp)				# $t1 will lose in next jal

	# Check day in month
	jal Day
	add $t2, $zero, $v0			# $t2 = day
	lw $t1, 4($sp)				# restore $t1 after jal

	addi $t3, $zero, 1			# $t3 = thang 1
	beq $t1, $t3, check_31_ngay
	addi $t3, $zero, 2			# $t3 = thang 2
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
	slti $t0, $t2, 1
	bne $t0, $zero, check_hop_le_khong	# neu day < 1
	slti $t0, $t2, 32
	beq $t0, $zero, check_hop_le_khong	# neu day >= 32
	j check_hop_le_co
check_30_ngay:
	slti $t0, $t2, 1
	bne $t0, $zero, check_hop_le_khong	# neu day < 1
	slti $t0, $t2, 31
	beq $t0, $zero, check_hop_le_khong	# neu day >= 31
	j check_hop_le_co
check_thang_2:
	slti $t0, $t2, 1
	bne $t0, $zero, check_hop_le_khong	# neu day <
	slti $t0, $t2, 30
	beq $t0, $zero, check_hop_le_khong	# neu day >= 30
	sw $t2, 0($sp)				# save $t2 before jal
	jal LeapYear
	add $t4, $zero, $v0			# check nam khong nhuan
	lw $t2, 0($sp)				# restore $t2 after jal
	beq $t4, $zero, check_thang_2_khong_nhuan	# neu nam khong nhuan
	j check_hop_le_co
check_thang_2_khong_nhuan:
	addi $t5, $zero, 29
	beq $t2, $t5, check_hop_le_khong	# neu day = 29
	j check_hop_le_co
check_hop_le_co:
	addi $v0, $zero, 1			# $v0 = 1, hop le
	j check_hop_le_exit
check_hop_le_khong:
	add $v0, $zero, $zero			# $v0 = 0, khong hop le
	j check_hop_le_exit
check_hop_le_exit:
	# restore from stack
	lw $ra, 8($sp)
	addi $sp, $sp, 12
	jr $ra

# Ham tra ve khoang cach thoi gian, tinh bang ngay
#	$a0 TIME_1
#	$a1 TIME_2
GetTime:
	# save to stack
	addi $sp, $sp, -40
	sw $ra, 36($sp)
	sw $a0, 32($sp)
	sw $a1, 28($sp)

	# save TIME_1
	jal Year
	sw $v0, 24($sp)		# save Year(TIME_1)
	jal Month
	sw $v0, 20($sp)		# save Month(TIME_1)
	jal Day
	sw $v0, 16($sp)		# save Day(TIME_1)

	# save TIME_2
	lw $a0, 28($sp)		# get TIME_2
	jal Year
	sw $v0, 12($sp)		# save Year(TIME_2)
	jal Month
	sw $v0, 8($sp)		# save Month(TIME_2)
	jal Day
	sw $v0, 4($sp)		# save Day(TIME_2)

	# ngay tuyet doi TIME_1
	lw $a0, 24($sp)		# get Year(TIME_1)
	lw $a1, 20($sp)		# get Month(TIME_1)
	lw $a2, 16($sp)		# get Day(TIME_1)
	jal ngayTuyetDoi
	sw $v0, 0($sp)		# save ngay tuyet doi TIME_1

	# ngay tuyet doi TIME_2
	lw $a0, 12($sp)		# get Year(TIME_2)
	lw $a1, 8($sp)		# get Month(TIME_2)
	lw $a2, 4($sp)		# get Day(TIME_2)
	jal ngayTuyetDoi
	lw $t0, 0($sp)		# get ngay tuyet doi TIME_1
	sub $v0, $v0, $t0	# tru 2 ngay tuyet doi

	# Kiem tra ket qua < 0 hay khong
	slt $t1, $v0, $zero
	beq $t1, $zero, GetTime_exit
	sub $v0, $zero, $v0

GetTime_exit:
	# restore from stack
	lw $ra, 36($sp)
	lw $a0, 32($sp)
	lw $a1, 28($sp)
	addi $sp, $sp, 40
	jr $ra

# Ham nhap thoi gian theo ngay, thang, nam
# Nhap bang string, sau do kiem tra hop le:
#	- only digits (syntax, "ab/2/1000" is non-valid)
#	- valid date (logic, "30/2/2000" is non-valid)
#	$a0 TIME 		luu DD/MM/YYYY
#	$a1 str_temp		bien tam
# 	$v0 TIME 		tra ve vi tri TIME
#	$v1 tinh hop le 	1 - hop le, 0 - khong hop le
nhap_time:
	# save to stack
	addi $sp, $sp, -36
	sw $s0, 32($sp)		# luu tinh hop le chuoi ngay, thang, nam
	sw $ra, 28($sp)
	sw $a0, 24($sp)
	sw $a1, 20($sp)

	# $s0 kiem tra hop le bang cach
	# tinh tong hop le ngay thang nam
	# neu $s0 == 3, ngay thang nam deu hop le
	add $s0, $zero, $zero

	# Nhap chuoi ngay
	addi $v0, $zero, 4	# syscall print string
	la $a0, msg_nhap_ngay
	syscall
	addi $v0, $zero, 8	# syscall read string
	lw $a0, 20($sp)		# $a0 save str_temp
	addi $a1, $zero, 1024	# max size of str_temp
	syscall
	jal is_only_digits	# kiem tra hop le syntax ngay
	add $s0, $s0, $v0 	# $s0 += hop le ngay
	# Chuyen ngay string -> int
	lw $a0, 20($sp)		# $a0 save str_temp
	jal atoi_whole
	sw $v0, 16($sp)		# luu ngay dang int vao stack

	# Nhap chuoi thang
	addi $v0, $zero, 4	# syscall print string
	la $a0, msg_nhap_thang
	syscall
	addi $v0, $zero, 8	# syscall read string
	lw $a0, 20($sp)		# $a0 save str_temp
	addi $a1, $zero, 1024 	# max size of str_temp
	syscall
	jal is_only_digits 	# kiem tra hop le syntax thang
	add $s0, $s0, $v0	# $s0 += hop le thang
	# Chuyen thang string -> int
	lw $a0, 20($sp)		# $a0 save str_temp
	jal atoi_whole
	sw $v0, 12($sp) 	# luu thang dang int vao stack

	# Nhap chuoi nam
	addi $v0, $zero, 4	# syscall print string
	la $a0, msg_nhap_nam
	syscall
	addi $v0, $zero, 8 	# syscall read string
	lw $a0, 20($sp) 	# $a0 save str_temp
	addi $a1, $zero, 1024 	# max size of str_temp
	syscall
	jal is_only_digits 	# kiem tra hop le syntax nam
	add $s0, $s0, $v0	# $s0 += hop le nam
	# Chuyen nam string -> int
	lw $a0, 20($sp) 	# $a0 save str_temp
	jal atoi_whole
	sw $v0, 8($sp) 		# luu nam dang int vao stack

	# Nhap vap TIME theo chuan DD/MM/YYYY
	lw $a0, 16($sp)		# ngay dang int
	lw $a1, 12($sp)		# thang dang int
	lw $a2, 8($sp) 		# nam dang int
	lw $a3, 24($sp) 	# dia chi luu TIME
	jal Date

	# Kiem tra TIME hop le syntax
	addi $t0, $zero, 3	# tong hop le ngay thang nam
	bne $s0, $t0, nhap_time_non_valid

	# Kiem tra TIME hop le logic
	lw $a0, 24($sp)
	jal check_hop_le
	beq $v0, $zero, nhap_time_non_valid

	addi $v1, $zero, 1	# $v1 = 1, hop le
	j nhap_time_exit
nhap_time_non_valid:
	add $v1, $zero, $zero	# $v1 = 0, khong hop le
nhap_time_exit:
	# restore from stack
	lw $s0, 32($sp)
	lw $ra, 28($sp)
	lw $a0, 24($sp)
	lw $a1, 20($sp)
	addi $sp, $sp, 36

	add $v0, $zero, $a0	# $v0 tra ve dia chi TIME
	jr $ra

# Ham kiem tra tinh hop le cua chuoi ngay(thang, nam) nhap vao
# Hop le nghia la chuoi chi chua digits [0-9]
#	$a0 string
#	$v0 tinh hop le 	1 - hop le, 0 - khong hop le
is_only_digits:
	add $t0, $zero, $a0	# $t0 la con tro p, p = string
	addi $v0, $zero, 1	# $v0 = 1, mac dinh la hop le
is_only_digits_loop:
	lb $t1, 0($t0)				# $t1 = *p
	beq $t1, $zero, is_only_digits_exit 	# neu *p == '\0'
	addi $t2, $zero, 10
	beq $t1, $t2, is_only_digits_exit 	# neu *p == '\n'
	slti $t2, $t1, 48			# 48 la '0'
	bne $t2, $zero, is_only_digits_non	# neu *p < '0'
	slti $t2, $t1, 58			# 57 la '9'
	beq $t2, $zero, is_only_digits_non	# neu *p > '9'
	addi $t0, $t0, 1			# p += 1
	j is_only_digits_loop
is_only_digits_non:
	add $v0, $zero, $zero	# $v0 = 0, khong hop le
is_only_digits_exit:
	jr $ra

# Ham dem so nam nhuan tu nam 0 den nam hien tai theo cong thuc
# Neu thang < 3, nam tru di 1 don vi
# Ket qua = nam / 4 - nam / 100 + nam / 400
# 	$a0 nam hien tai
#	$a1 thang hien tai
# 	$v0 so nam nhuan 0 -> year
demSoNamNhuan:
	add $t0, $zero, $a0 		# $t0 = nam
	slti $t2, $a1, 3
	beq $t2, $zero, dem_skip 	# neu thang >= 3
	addi $t0, $t0, -1		# nam -= 1
dem_skip:
	add $t2, $zero, $t0 		# $t2 = nam
	addi $t3, $zero, 4 		# So chia $t3 = 4
	div $t2, $t3			# nam / 4
	mflo $v0   			# $v0 = nam / 4

	add $t2, $zero, $t0 		# $t2 = nam
	addi $t3, $zero, 100 		# So chia $t3 = 100
	div $t2, $t3 			# nam / 100
	mflo $t2 			# $t2 = nam / 100
	sub $v0, $v0, $t2 		# $v0 = nam / 4 - nam / 100

	add $t2, $zero, $t0 		# $t2 = nam
	addi $t3, $zero, 400 		# So chia t3 = 400
	div $t2, $t3 			# nam / 400
	mflo $t2 			# $t2 = nam / 400
	add $v0, $v0, $t2 		# $v0 = nam / 4 - nam / 100 + nam / 400
	jr $ra

# Ham copy string y -> string x
# 	$a0: string x
#	$a1: string y
strcpy:
	# save to stack
	addi $sp, $sp, -4
	sw $s0, 0($sp)

	add $s0, $zero, $zero 		# i = 0
strcpy_loop:
	add $t0, $s0, $a1		# $t0 = &y[i]
	lb $t1, 0($t0) 			# $t1 = y[i]
	add $t2, $s0, $a0 		# $t2 = &x[i]
	sb $t1, 0($t2) 			# x[i] = y[i]
	beq $t1, $zero, strcpy_exit	# Neu x[i] == '\0'
	addi $s0, $s0, 1		# i += 1
	j strcpy_loop
strcpy_exit:
	# restore from stack
	lw $s0, 0($sp)
	addi $sp, $sp, 4
	jr $ra

# Ham noi y vao x
# x la "aa", y la "b" ket qua x la "aab"
# 	$a0 string x
#	$a1 string y
strcat:
	# save to stack
	addi $sp, $sp, -8
	sw $s0, 0($sp)
	sw $s1, 4($sp)

	add $s0, $zero, $zero		# $s0 la i = 0
	add $s1, $zero, $zero 		# $s1 la j = 0
strcat_findEndLoop:
	add $t3, $a0, $s0
	lb $t4, 0($t3) 			# $t4 = x[i]
	beq $t4, $zero, appendLoop	# neu x[i] == '\0'
	addi $s0, $s0, 1  		# i += 1
	j strcat_findEndLoop
appendLoop:
	add $t4, $a1, $s1 		# $t4 = &y[j]
	lb $t5, 0($t4) 			# $t5 = y[j]
	add $t3, $a0, $s0 		# $t3 = &x[i]
	sb $t5, 0($t3) 			# x[i] = y[j]
	beq $t5, $zero, strcat_exit	# neu x[i] == '\0'
	addi $s0, $s0, 1		# i += 1
	addi $s1, $s1, 1		# j += 1
	j appendLoop
strcat_exit:
	# restore from stack
	lw $s0, 0($sp)
	lw $s1, 4($sp)
	addi $sp, $sp, 8
	jr $ra

# Ham tra ve ten thang trong nam
#	$a0 month (integer)
# 	$v0 month (string)
Month_in_String:
	slti $t0, $a0, 2 	# if month < 2 => month == 1
	bne $t0, $zero, Jan 	# jump to January

	slti $t0, $a0, 3 	# if month < 3 => month == 2
	bne $t0, $zero, Feb 	# jump to February

	slti $t0, $a0, 4	# if month < 4 => month == 3
	bne $t0, $zero, Mar 	# jump to March

	slti $t0, $a0, 5 	# if month < 5 => month == 4
	bne $t0, $zero, Apr 	# jump to April

	slti $t0, $a0, 6 	# if month < 6 => month == 5
	bne $t0, $zero, May 	# jump to May

	slti $t0, $a0, 7 	# if month < 7 => month == 6
	bne $t0, $zero, Jun 	# jump to June

	slti $t0, $a0, 8 	# if month < 8 => month == 7
	bne $t0, $zero, Jul 	# jump to July

	slti $t0, $a0, 9 	# if month < 9 => month == 8
	bne $t0, $zero, Aug 	# jump to August

	slti $t0, $a0, 10 	# if month < 10 => month == 9
	bne $t0, $zero, Sep 	# jump to September

	slti $t0, $a0, 11 	# if month < 11 => month == 10
	bne $t0, $zero, Oct 	# jump to October

	slti $t0, $a0, 12 	# if month < 12 => month == 11
	bne $t0, $zero, Nov 	# jump to November

	j Dec 			# jump to December
Jan:
	la $v0, Month_1
	j Month_in_Year_exit
Feb:
	la $v0, Month_2
	j Month_in_Year_exit
Mar:
	la $v0, Month_3
	j Month_in_Year_exit
Apr:
	la $v0, Month_4
	j Month_in_Year_exit
May:
	la $v0, Month_5
	j Month_in_Year_exit
Jun:
	la $v0, Month_6
	j Month_in_Year_exit
Jul:
	la $v0, Month_7
	j Month_in_Year_exit
Aug:
	la $v0, Month_8
	j Month_in_Year_exit
Sep:
	la $v0, Month_9
	j Month_in_Year_exit
Oct:
	la $v0, Month_10
	j Month_in_Year_exit
Nov:
	la $v0, Month_11
	j Month_in_Year_exit
Dec:
	la $v0, Month_12
Month_in_Year_exit:
	jr $ra

# Ham dem so ngay tuyet doi theo cong thuc
# ngayTuyetDoi = nam * 365 + ngayTuyetDoiTrongNam + soNamNhuan
# soNamNhuan la so nam nhuan tu nam 0 den nam hien tai
# ngayTuyetDoiTrongNam duoc tinh theo nam thuong, khong xet truong hop nam nhuan
# 	$a0 nam
# 	$a1 thang
#	$a2 ngay
ngayTuyetDoi:
	# Ket qua += nam * 365
	add $v0, $zero, $a0 	# Ket qua = nam
	addi $t0, $zero, 365 	# Gan bien tam t0 = 365
	mult $v0, $t0 		# Thuc hien phep nhan nam * 365
	mflo $v0 		# Ket qua = nam * 365

	# Ket qua += ngay
	add $v0, $v0, $a2 	# Ket qua = nam * 365 + ngay

	# Ket qua += ngay trong thang truoc do
	addi $t0, $zero,1 	# Gan bien tam t0 = 1 (thang 1)
	bne $t0, $a1, ngayTuyetDoi_t2
	addi $v0, $v0, 0 	# Ket qua = nam * 365 + ngayTuyetDoiTrongNam
	j ngayTuyetDoi_next
ngayTuyetDoi_t2:
	addi $t0, $zero, 2 	# Gan bien tam t0 = 2 (thang 2)
	bne $t0, $a1, ngayTuyetDoi_t3
	addi $v0, $v0, 31 	# Ket qua = nam * 365 + ngayTuyetDoiTrongNam
	j ngayTuyetDoi_next
ngayTuyetDoi_t3:
	addi $t0, $zero, 3 	# Gan bien tam t0 = 3 (thang 3)
	bne $t0, $a1, ngayTuyetDoi_t4
	addi $v0, $v0, 59 	# Ket qua = nam * 365 + ngayTuyetDoiTrongNam
	j ngayTuyetDoi_next
ngayTuyetDoi_t4:
	addi $t0, $zero, 4 	# Gan bien tam t0 = 4 (thang 4)
	bne $t0, $a1, ngayTuyetDoi_t5
	addi $v0, $v0, 90 	# Ket qua = nam * 365 + ngayTuyetDoiTrongNam
	j ngayTuyetDoi_next
ngayTuyetDoi_t5:
	addi $t0, $zero, 5 	# Gan bien tam t0 = 5 (thang 5)
	bne $t0, $a1, ngayTuyetDoi_t6
	addi $v0, $v0, 120 	# Ket qua = nam * 365 + ngayTuyetDoiTrongNam
	j ngayTuyetDoi_next
ngayTuyetDoi_t6:
	addi $t0, $zero, 6 	# Gan bien tam t0 = 6 (thang 6)
	bne $t0, $a1, ngayTuyetDoi_t7
	addi $v0, $v0, 151 	# Ket qua = nam * 365 + ngayTuyetDoiTrongNam
	j ngayTuyetDoi_next
ngayTuyetDoi_t7:
	addi $t0, $zero, 7 	# Gan bien tam t0 = 7 (thang 7)
	bne $t0, $a1, ngayTuyetDoi_t8
	addi $v0, $v0, 181 	# Ket qua = nam * 365 + ngayTuyetDoiTrongNam
	j ngayTuyetDoi_next
ngayTuyetDoi_t8:
	addi $t0, $zero, 8 	# Gan bien tam t0 = 8 (thang 8)
	bne $t0, $a1, ngayTuyetDoi_t9
	addi $v0, $v0, 212 	#Ket qua = nam * 365 + ngayTuyetDoiTrongNam
	j ngayTuyetDoi_next
ngayTuyetDoi_t9:
	addi $t0, $zero, 9 	# Gan bien tam t0 = 9 (thang 9)
	bne $t0, $a1, ngayTuyetDoi_t10
	addi $v0, $v0, 243	# Ket qua = nam * 365 + ngayTuyetDoiTrongNam
	j ngayTuyetDoi_next
ngayTuyetDoi_t10:
	addi $t0, $zero, 10 	# Gan bien tam t0 = 10 (thang 10)
	bne $t0, $a1, ngayTuyetDoi_t11
	addi $v0, $v0, 273 	# Ket qua = nam * 365 + ngayTuyetDoiTrongNam
	j ngayTuyetDoi_next
ngayTuyetDoi_t11:
	addi $t0, $zero, 11 	# Gan bien tam t0 = 11 (thang 11)
	bne $t0, $a1, ngayTuyetDoi_t12
	addi $v0, $v0, 304 	# Ket qua = nam * 365 + ngayTuyetDoiTrongNam
	j ngayTuyetDoi_next
ngayTuyetDoi_t12:
	addi $v0, $v0, 334 	# Ket qua = nam * 365 + ngayTuyetDoiTrongNam
ngayTuyetDoi_next:
	addi $sp, $sp, -8
	sw $ra, 4($sp) 		# Luu $ra
	sw $v0, 0($sp) 		# Luu bien $v0
	jal demSoNamNhuan
	lw $t0, 0($sp)		# Lay lai ket qua = nam * 365 + ngayTuyetDoiTrongNam
	add $v0, $v0, $t0 	# ketqua = nam * 365 + ngayTuyetDoiTrongNam + soNamNhuan
	lw $ra, 4($sp) 		# Tra lai $ra
	addi $sp, $sp, 8
	jr $ra

# Ham tinh thu cua 1 ngay
# so nguyen 1 -> 7 tuong ung chu nhat -> thu 7
# Xac dinh ngay 31/12/1 TCN la thu 7 -> bieu dien boi thu 7
# Khoang cach giua mot ngay bat ki voi ngay 31/12/1 TCN chinh la gia tri ngay tuyet doi cua no
# Cong thuc xac dinh thu cua ngay bat ki
# thuNgayBatKi = (thuNgayCuoiTCN + giaTriNgayTuyetDoi mod 7) mod 7 = (7 + giaTriNgayTuyetDoi mod 7) mod 7
# Neu thu duoc ket qua la 0, ta cong ket qua them cho 7
#	$a0 TIME
xacDinhThu:
	# save to stack
	addi $sp, $sp, -16
	sw $ra, 12($sp)

	jal Year
	sw $v0, 8($sp)		# save Year(TIME)
	jal Month
	sw $v0, 4($sp)		# save Month(TIME)
	jal Day
	sw $v0, 0($sp)		# save Day(TIME)

	lw $a0, 8($sp)		# get Year(TIME)
	lw $a1, 4($sp)		# get Month(TIME)
	lw $a2, 0($sp)		# get Day(TIME)
	jal ngayTuyetDoi	# Tinh gia tri tuyet doi cua ngay, ket qua luu trong $v0
	addi $t0, $zero, 7 	# Gan bien tam t0 = 7
	div $v0, $t0
	mfhi $v0 		# $v0 = giaTriNgayTuyetDoi mod 7
	addi $v0, $v0, 7	# $v0 = giaTriNgayTuyetDoi mod 7 + 7
	div $v0, $t0
	mfhi $v0 		# $v0 = (7 + giaTriNgayTuyetDoi mod 7) mod 7
	bne $v0, $zero, xacDinhThu_next
	addi $v0, $zero, 7	# Neu ket qua bang 0 thi lay ket qua la 7
xacDinhThu_next:
	addi $t0, $zero, 1 	# Gan bien tam t0 bang 1 (Chu nhat)
	bne $v0, $t0, xacDinhThu_thu2
	la $v0, str_Chu_nhat
	j xacDinhThu_end
xacDinhThu_thu2:
	addi $t0, $zero, 2 	# Gan bien tam t0 bang 2 (Thu 2)
	bne $v0, $t0, xacDinhThu_thu3
	la $v0, str_Thu_2
	j xacDinhThu_end
xacDinhThu_thu3:
	addi $t0, $zero, 3 	# Gan bien tam t0 bang 3 (Thu 3)
	bne $v0, $t0, xacDinhThu_thu4
	la $v0, str_Thu_3
	j xacDinhThu_end
xacDinhThu_thu4:
	addi $t0, $zero, 4 	#Gan bien tam t0 bang 4 (Thu 4)
	bne $v0, $t0, xacDinhThu_thu5
	la $v0, str_Thu_4
	j xacDinhThu_end
xacDinhThu_thu5:
	addi $t0, $zero, 5 	#Gan bien tam t0 bang 5 (Thu 5)
	bne $v0, $t0, xacDinhThu_thu6
	la $v0, str_Thu_5
	j xacDinhThu_end
xacDinhThu_thu6:
	addi $t0, $zero, 6 	# Gan bien tam t0 bang 6 (Thu 6)
	bne $v0, $t0, xacDinhThu_thu7
	la $v0, str_Thu_6
	j xacDinhThu_end
xacDinhThu_thu7:
	la $v0, str_Thu_7
xacDinhThu_end:
	# restore from stack
	lw $ra, 12($sp)
	addi $sp, $sp, 16
	jr $ra