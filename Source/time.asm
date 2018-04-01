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
TIME:
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

        # nhap thang, save in $s0
        addi $v0, $zero, 4      # print str
        la $a0, msg_nhap_thang
        syscall
        addi $v0, $zero, 5      # read int
        syscall
        add $s1, $zero, $v0     # $v0 save read int

        # nhap nam, save in $s0
        addi $v0, $zero, 4      # print str
        la $a0, msg_nhap_nam
        syscall
        addi $v0, $zero, 5      # read int
        syscall
        add $s2, $zero, $v0     # $v0 save read int

        # exit
        addi $v0, $zero, 10
        syscall

# Ham tra ve chuoi TIME theo dinh dang DD/MM/YYYY
Date:
