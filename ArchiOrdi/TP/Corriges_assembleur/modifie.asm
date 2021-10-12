##
# @author Hector Plasma 
# File_name : afficher.asm
# 
# Description : Affiche un message MESSAGE dans lequel chaque caractère c1 est remplacé par le caractère c2.
#    		On considère que c1 et c2 sont stockés dans les registres respectifs $t8 et $t9. 
##


##### Data section #####
.data

ESPACE 	:	.asciiz " "
MESSAGE :	.asciiz "Hello world !"

#### Text section #####
.text

.globl _main_

_main_ :	la $t0, MESSAGE  # On charge le message
		li $t8, ' '         # On charge c1
		li $t9, '-'        # On charge c2
	
boucle :	lb $t1, ($t0)   # On charge le caractère c_i courant
		beqz $t1, fin       # S'il est nul, on a fini
    		sub $t3, $t1, $t8  # On calcule c_i - c1
    		bnez $t3, suivant   # Si (c_i - c1) !=0 : Alors le caractère n'est pas à changer
    		sb $t9, ($t0)       # Sinon, on le remplace par c2
suivant : 	addi $t0, $t0, 1    # On incrémente le caractère courant c_i
		j boucle               # On reboucle
    		
fin :		la $a0, MESSAGE     # On imprime le message
		jal print_string
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


    		