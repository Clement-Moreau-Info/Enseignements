##
# @author Clément Moreau
# File_name : checksum.asm
# 
# Description : Codage parité φ checksum du contenu du registre $t0 = n et impression de φ(n).
##

##### Data section #####
.data

ESPACE 	:	.asciiz " "
NEWLINE :	.asciiz "\n"

#### Text section #####
.text
.globl _main_

_main_ :	li $a0, 'a'
		move $t0, $a0
		li $t9, 0	     # Registre contenant le nombre de bits à 1.
				    
boucle :	beqz $t0, fin	     # On compte le nombre de bits à 1
    		andi $t1, $t0, 1     
    		add $t9, $t9, $t1    # Peut-être remplacé par : xor $t9, $t9, $t1
    		srl $t0, $t0, 1      # On décale 
		j boucle

    		
fin :		andi $t9, $t9, 1     # Ligne à supprimer si on a remplacé la ligne 24 par un xor.
		sll $a0, $a0, 1          # On décale à gauche pour insérer la parité
		or $a0, $a0, $t9         # On ajoute la parite du nombre
		jal print_int            # On affiche le nombre
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
    		
