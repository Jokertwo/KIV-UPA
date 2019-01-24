.data
	souTextA0: .asciiz "Zadejte souradnici A[0]:\n"
	souTextA1: .asciiz "Zadejte souradnici A[1]:\n"

	souTextB0: .asciiz "Zadejte souradnici B[0]:\n"
	souTextB1: .asciiz "Zadejte souradnici B[1]:\n"

	souTextC0: .asciiz "Zadejte souradnici C[0]:\n"
	souTextC1: .asciiz "Zadejte souradnici C[1]:\n"	
	
	souArrayA: .space 8
	souArrayB: .space 8
	souArrayC: .space 8
	
	uVec: .space 8
	vVec: .space 8
	
	error: .asciiz "Lze zadat cislo pouze od 0-255"
	
	half: .float 2.0
	
	.text
	.globl main
	
main:	la $a0,souTextA0		# argument: string
	jal nactiCislo			# procedura pro nacteni vtupu od uzivatele
	la $a0,souTextA1		# argument: string	
	
	jal nactiCislo			# procedura pro nacteni vtupu od uzivatele
	move $t0,$v0
	la $a0,souTextB0		# argument: string
	move $t1,$v0
			
	jal nactiCislo			# procedura pro nacteni vtupu od uzivatele
	la $a0,souTextB1		# argument: string
		
	jal nactiCislo			# procedura pro nacteni vtupu od uzivatele
	move $t2,$v0		
	la $a0,souTextC0		# argument: string
	move $t3,$v0
	
	jal nactiCislo			# procedura pro nacteni vtupu od uzivatele
	la $a0,souTextC1		# argument: string
	jal nactiCislo			# procedura pro nacteni vtupu od uzivatele
	move $t4,$v0
	move $t5,$v0

	####################  vector U ############################
	#sub $t0,$t0,4			# index do pole = 0
	
	#lw $t1,souArrayA($t0)		# nacteni hodnoty souArrayA[0]
	move $a0,$t0
	#lw $t3,souArrayB($t0)		# nacteni hodnoty souArrayB[0]
	move $a2,$t2
	
	#addi $t0,$t0,4			# index do pole = 4
	
	#lw $t2,souArrayA($t0)		# nacteni hodnoty souArrayA[1]
	move $a1,$t1
	#lw $t4,souArrayB($t0)		# nacteni hodnoty souArrayB[1]
	move $a3,$t3
	
	#move $a0,$t1			# nastaveni argumentu funkce na hodnotu souArrayA[0]
	#move $a1,$t2			# nastaveni argumentu funkce na hodnotu souArrayA[1]
	#move $a2,$t3 			# nastaveni argumentu funkce na hodnotu souArrayB[0]
	#move $a3,$t4 			# nastaveni argumentu funkce na hodnotu souArrayB[1]
	
	jal odectiVector
	nop
	#sub $t0,$t0,4			# index do pole = 0
	
	move $t6,$v0			# ulozeni vektoru u[0]
	#addi $t0,$t0,4			# index do pole = 4
	move $t7,$v1			# ulozeni vektoru u[1]
	####################  vector V ############################
	#sub $t0,$t0,4			# index do pole = 0
	
	move $a2,$t4			# nacteni hodnoty souArrayC[0]
	move $a3,$t5			# index do pole = 4
	
	#lw $t4,souArrayC($t0)		# nacteni hodnoty souArrayC[1]
	
	#move $a2,$t3 			# nastaveni argumentu funkce na hodnotu souArrayC[0]
	#move $a3,$t4 			# nastaveni argumentu funkce na hodnotu souArrayC[1]
	
	jal odectiVector
	nop
  	#sub $t0,$t0,4			# index do pole = 0
  	
  	move $t8,$v0			# ulozeni vektoru v[0]
	#addi $t0,$t0,4			# index do pole = 4
	move $t9,$v1			# ulozeni vektoru v[1]
  	 	
  	################## nasobeni vektoru U x V ###############
  	#sub $t0,$t0,4			# index do pole = 0
	
	#lw $t1,uVec($t0)		# nacteni hodnoty uVec[0]
	#lw $t3,vVec($t0)		# nacteni hodnoty vVec[0]
	
	#addi $t0,$t0,4			# index do pole = 4
	
	#lw $t2,uVec($t0)		# nacteni hodnoty souArrayA[1]
	#lw $t4,vVec($t0)		# nacteni hodnoty souArrayB[1]
		
	move $a0,$t6			# nastaveni argumentu funkce na hodnotu uVec[0]
	move $a1,$t7			# nastaveni argumentu funkce na hodnotu uVec[1]
	move $a2,$t8 			# nastaveni argumentu funkce na hodnotu vVec[0]
	move $a3,$t9 			# nastaveni argumentu funkce na hodnotu vVec[1]
  	
  	
  	jal vynasobVector
  	nop
  	#sub $t0,$t0,4			# index do pole = 0
  	
  	sub $t6,$v0,$v1
  	abs $t6,$t6
  	li $v0,2		# syscall 4 (print_str)
  	lwc1 $f2,half
  	mtc1 $t6,$f0
  	cvt.s.w $f0,$f0
  	div.s $f12,$f0,$f2
  	
  	
  	
  	
	syscall			# zavolani syscall
  	
  	jal exit

 
nactiCislo: 	nop
		li $v0,4		# syscall 4 (print_str)
		syscall			# zavolani syscall
		
		li $v0,5		# sluzba nacti cislo
		syscall			# zavolani syscall
		jr $ra			# navrat z procedury
		

odectiVector: 	nop			# odecte od sebe dve a dve cisla
		sub $v0,$a2,$a0		# vysledek ulozi ve $v0 a $v1
		sub $v1,$a3,$a1
		jr $ra

vynasobVector: 	nop
		mul $v0,$a0,$a3
		mul $v1,$a1,$a2
		jr $ra
			
	
exit: 		nop
		li $v0,10			# ukonceni programu
		syscall				# syscall
