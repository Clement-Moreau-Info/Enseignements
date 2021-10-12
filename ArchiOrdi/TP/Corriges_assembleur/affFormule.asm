##
# @author Hector Plasma 
# File_name : affFormule.asm
# 
# Description : Affiche la somme de tous les termes de 1 à n où n est contenu dans $t0
#               On rappelle la formule n(n+1)/2
##

##### Data section #####
.data

ESPACE 	:	 .asciiz " "
NEWLINE :	 .asciiz "\n"

#### Text section #####
.text

.globl _main_

_main_ :	li $t0, 100
		add $t1, $t0, 1         # (n+1)
		mul $t0, $t0, $t1       # n(n+1)            
		div $t0, $t0, 2         # n(n+1)/2
		move $a0, $t0           # On déplace le résultat dans le registre d'affichage
		jal print_int           # Appel de la routine
				
fin :		li $v0, 10
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
