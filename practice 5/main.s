##################################
# Рябцев Даниил, КИ22-16/1б, В20 #
##################################


.global _start


_start:
        la a0, prompt
        li a7, 4
        ecall

        li a7, 5
        ecall
        mv s0, a0
        li a7, 5
        ecall
        mv s1, a0

		# a == 0 ? return
        beqz s1, _end

        # s2 = counter s3 = max_iterations
        addi s2, x0, 0
        addi s3, x0, 10

        loop:
        	# a < x ?
        	blt s1, s0, if1
        	else1:
        		# y1(s4) = a
        		addi s4, s1, 0
        		beq x0, x0, endif1
        	if1:
        		# y1(s4) = x mod 4
                        addi t1, x0, 4
                        rem s4, s0, t1
        	endif1:

        	# t1 = 3; t0 = x mod 3
        	addi t1, x0, 3
        	rem t0, s0, t1

        	# a + a + a < x ?
                add t0, s1, s1
                add t0, t0, s1
        	blt t0, s0, if2
        	else2:
        		# y2(s5) = x
        		add s5, x0, s0
        		beq x0, x0, endif2
        	if2:
        		# y2(s5) = a * x
        		addi t3, x0, 0
        		addi t0, x0, 0
        		bltz s1, for_multiply_minus
        		for_multiply:
        			add t0, t0, s0
        			addi t3, t3, 1
        			blt t3, s1, for_multiply
        			beq t3, s1, for_multiply_end
        			
        		for_multiply_minus:
        			add t0, t0, s0
        			addi t3, t3, -1
        			blt t3, s1, for_multiply_minus
        			beq t3, s1, for_multiply_end
        		
        		for_multiply_end:
        		add s5, x0, t0
		endif2:
		# y(s6) = y1 + y2
		add s6, s4, s5

		la a0, part1
        	li a7, 4
        	ecall

        	mv a0, s0
        	li a7, 1
        	ecall

        	la a0, part2
        	li a7, 4
        	ecall

        	mv a0, s4
        	li a7, 1
        	ecall

        	la a0, part3
        	li a7, 4
        	ecall

        	mv a0, s5
        	li a7, 1
        	ecall

        	la a0, part4
        	li a7, 4
        	ecall

        	mv a0, s6
        	li a7, 1
        	ecall

        	la a0, newline
        	li a7, 4
        	ecall

        	# x++
        	addi s0, s0, 1        	

        	addi s2, s2, 1
        	blt s2, s3, loop


        addi    a0, x0, 0
        addi    a7, x0, 93
        ecall
_end:

.data
prompt:		.asciz "Enter X and A\n"
part1:          .asciz "X = "
part2:          .asciz " y1 = "
part3:          .asciz " y2 = "
part4:          .asciz " y = "
newline:        .asciz "\n"
