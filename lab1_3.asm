# lab 1_3 quicksort
# lab1_3.asm
# this program will detect -1 as lagerst number as -1 show as 0xffffffff 
# i had tried my best to solve it but cant
# other function is function well

.globl _start

.data
a: .word -1 22 8 35 5 4 11 2 1 78

.text
_start:
	la a1, a
	li a2, 0
	li a3, 9
	jal ra, quicksort
	
	quicksort:
	# array a at a1
	# lo at a2
	# hi at a3
		ble a3, a2  quicksort_exit    # if lo >= hi
		
		
		addi s10, a2, 0   # save lo at s10
		addi s11, a3, 0   # save hi at s11
		
		jal ra, partation
		
		# save pivot at s9
		addi s9, a0, 0
		
		addi a2, s10, 0  # lo = lo
		addi a3, s9,  -1  # hi = pivot -1
		jal ra, quicksort   # quicksort(a1, lo, pivot -1)
		
		addi a2, s9,  1 # lo = pivot +1
		addi a3, s11, 0 # hi = hi
		jal ra quicksort   # quicksort(a1, p+1, hi)
		
		
		
		quicksort_exit:
		ret
		
	partation:
	# a0 <- pivot
		# set pivot to the number in a3th , and load the value of pivot into t0
		slli a4, a3, 2
		add a4, a1, a4
		lw t0 0(a4)
	
		addi t2, a2, -1  # i
		addi t6, a2, 0   # j
		addi t5, a3, -1  # hi -1
		
		forloop:
			bgt t6,t5, forloopend   # if j > hi-1, end for loop
			# load address of a[j] into t1
			slli  s11, t6, 2
			add s11, a1, s11
			lw t1, 0(s11)
			
			bgtu t1, t0, skip   # if a[j] > pivot, skip
			addi t2, t2, 1   # i++
			# load address of  a[i] into t3
			slli s10, t2, 2
			add s10, a1, s10
			lw t3, 0(s10)
			#swap a[i] and a[j]
			sw t3, 0(s11)
			sw t1, 0(s10)
			
			skip:
				addi t6, t6, 1 #j++
				j forloop
		
		forloopend:
			addi a0,t2, 1 # return i+1
			#load address of  a[i+1] to s10
			slli s10, a0, 2
			add s10, a1, s10
			lw t2, 0(s10)
			#load address of a[pivot] to s11
			slli s11, a3, 2
			add s11, a1, s11
			lw t3, 0(s11)
			# swap
			sw t2, 0(s11)
			sw t3, 0(s10)	
			addi s10, a2, 0
			addi s11, a3, 0
			
			
		partationret:
		ret	
	
	exit1:	#save and exit
		lw ra, 16(sp)
		lw s3, 12(sp)
		lw s2,  8(sp)
		lw s1,  4(sp)
		lw s0,  0(sp)
		addi sp, sp, 20
