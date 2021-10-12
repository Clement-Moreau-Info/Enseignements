##
# @author Hector Plasma 
# File_name : affSigne.asm
# 
# Description : Affiche le signe d'un entier contenu dans le registre $t0
##

##### Data section #####
.data

ESPACE 	:	.asciiz " "
NEWLINE :	.asciiz "\n"
POSITIF	: 	.asciiz		"Positif"
NUL	:  	.asciiz 	"Nul"
NEGATIF	:  	.asciiz 	"Negatif"

#### Text section #####
.text

.globl _main_

_main_ :	jal read_int
		move $t0, $v0
		li $t0, 42              # Nombre n 
		bgt $t0, $zero, positif    # Si n > 0 : Branchement à positif
		beqz $t0, nul               # Si n == 0 : Branchement à nul
		la $a0, NEGATIF             # n est  < 0, on charge la chaine NEGATIF           
		j fin
	
nul : 	la $a0, NUL                 # On charge la chaine NUL
		j fin
	
positif : 	la $a0, POSITIF         # On charge la chaine POSITIF
				
fin :		jal print_string        # On appelle la routine d'impression 
            li $v0, 10
         	syscall

## Routines d'impression ##
#
# La routine imprime le contenu du registre $a0
#
##
print_int :	li $v0, 1
		syscall
		jr $ra
		
print_string :	li $v0, 4
		syscall
		jr $ra

read_int :	li $v0, 5
		syscall
		jr $ra
		
