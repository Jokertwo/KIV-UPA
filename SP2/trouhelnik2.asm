.data
	souTextA0: .asciiz "Zadejte souradnici A[0]:\n"
	souTextA1: .asciiz "Zadejte souradnici A[1]:\n"

	souTextB0: .asciiz "Zadejte souradnici B[0]:\n"
	souTextB1: .asciiz "Zadejte souradnici B[1]:\n"

	souTextC0: .asciiz "Zadejte souradnici C[0]:\n"
	souTextC1: .asciiz "Zadejte souradnici C[1]:\n"	
	
	vysledek: .asciiz "Obsah trojuhelniku je: "
	
	half: .float 2.0
	
	.text
	.globl main
	
main:	
	####################  nacteni uzivatelskeho vstupu ############################
	la $a0,souTextA0		# argument: string
	jal nactiCislo			# procedura pro nacteni vtupu od uzivatele
	la $a0,souTextA1		# argument: string	
	
	jal nactiCislo			# procedura pro nacteni vtupu od uzivatele
	move $t0,$v0			# ulozeni 1. vstupu od uzivatele
	la $a0,souTextB0		# argument: string
	move $t1,$v0			# ulozeni 2. vstupu od uzivatele
			
	jal nactiCislo			# procedura pro nacteni vtupu od uzivatele
	la $a0,souTextB1		# argument: string
		
	jal nactiCislo			# procedura pro nacteni vtupu od uzivatele
	move $t2,$v0			# ulozeni 3. vstupu od uzivatele		
	la $a0,souTextC0		# argument: string
	move $t3,$v0			# ulozeni 4. vstupu od uzivatele	
	
	jal nactiCislo			# procedura pro nacteni vtupu od uzivatele
	la $a0,souTextC1		# argument: string
	jal nactiCislo			# procedura pro nacteni vtupu od uzivatele
	move $t4,$v0			# ulozeni 5. vstupu od uzivatele
	move $t5,$v0			# ulozeni 6. vstupu od uzivatele

	#################### vypocteni vectoru U ############################
		
	sub $t6,$t2,$t0		
	sub $t7,$t3,$t1
	
	#################### vypocteni vectoru V ############################
	
	sub $t8,$t4,$t0
	sub $t9,$t5,$t1
	 	
  	################## nasobeni vektoru U x V ###############
  	
  	mul $v0,$t6,$t9
	mul $v1,$t7,$t8
  	
  	
  	sub $t6,$v0,$v1
  	ble $t6,$zero,normalizace
  	j deleni

deleni:		nop
		lwc1 $f2,half		# ulozi do $f2 hodnotu 2
		mtc1 $t6,$f0		# ulozi obsah $t6 do coprocesoru na adresu $f0
		cvt.s.w $f0,$f0		# prevede integer na float
  		div.s $f12,$f0,$f2	# vydeli dva floaty
  		j tiskVysledek		# pokracovani na proceduru ktera vytiskne vysledek
  		
tiskVysledek:	nop
		la $a0,vysledek		# nacteni string retezce
		li $v0,4		# syscall 4 (print_str)
		syscall			# zavolani syscall

		li $v0,2		# syscall 2 (print_float)
		syscall			# zavolani syscall
		j exit
 
nactiCislo: 	nop
		li $v0,4		# syscall 4 (print_str)
		syscall			# zavolani syscall
		
		li $v0,5		# sluzba nacti cislo
		syscall			# zavolani syscall
		jr $ra			# navrat z procedury
		
normalizace: 	nop			
		mul $t6,$t6,-1		# pronasobi cislo -1 k dostani kladneho cisla
		j deleni		# pokracovani ve vypoctu

exit: 		nop
		li $v0,10		# oznameni systemu ze program bude koncit
		syscall			# syscall
