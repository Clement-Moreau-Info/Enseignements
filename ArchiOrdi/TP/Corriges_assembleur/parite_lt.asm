##
# @author Clément Moreau
# File_name : codageParite_lt.asm
# 
# Description : Codage parité φ longitudinale et transversale du contenu de TAB et impression de φ(TAB) = TAB_CODE.
##

##### Data section #####
.data

SPACE 		:	.asciiz " "
NEWLINE 	:	.asciiz "\n"
TAB		: 	.word 	12, 'a', 'Z', 3, 1 	# Tableau d'éléments
	 	 	.eqv 	TAB_SIZE 5	   
TAB_CODE 	:	.word   0:6	# La taille doit être égale à 0:(TAB_SIZE + 1)

#### Text section #####
.text

.globl _main_

_main_ :	la $t0, TAB      # Chargement de TAB
		la $s0, TAB_CODE     # Chargement de TAB_CODE
		li $a1, 0            # Parité longitudinale
		la $t9, TAB_SIZE

boucle_1 : 	lw $t1, ($t0)  	     # Chargement de TAB[i]
		beqz $t9, fin
		li $t3, 0		     # Calcul du checksum de TAB[i]
boucle_2 :	beqz $t1, fin_boucle_2	     
    		andi $t2, $t1, 1
    		xor $t3, $t3, $t2 
    		srl $t1, $t1, 1
		j boucle_2
    		
fin_boucle_2 :	lw $a0, ($t0)		
		sll $a0, $a0, 1
		or $a0, $a0, $t3
		xor $a1, $a1, $a0      # Mise à jour de TAB_CODE[n] : parite longitudinale
		sw $a0, ($s0)          # On place TAB[i] codé dans le TAB_CODE[i]
		add $t0, $t0, 4        # Incrément de TAB d'un mot (soit 4 octets) : on se place à TAB[i+1]
		add $s0, $s0, 4        # Incrément de TAB_CODE d'un mot (soit 4 octets)
		sub $t9, $t9, 1        # On décrémente la taille
		j boucle_1

fin :      	sw $a1, ($s0)   # On place TAB_CODE[n] = $a1 
		la $a0, TAB_CODE    # Chargement de l'adresse du tableau pour impression
		la $a1, TAB_SIZE    # Chargement de la taille du tableau pour impression
		add $a1, $a1, 1
    		jal print_tab   # Impression de TAB_CODE
     		li $v0, 10
     		syscall   
		
## Routines d’impression ##
#
# Routine d'impression d'un tableau 
# $a0 contient le tableau et $a1 contient la taille du tableau
#
##

print_int :	li $v0, 1
		syscall
		jr $ra

print_tab : 
    add  $t0, $zero, $a0       
    add  $t1, $zero, $a1        
out:  
    lw   $a0, 0($t0)           
    li   $v0, 1              
    syscall                  
    la   $a0, SPACE             
    li   $v0, 4                
    syscall                      
    addi $t0, $t0, 4           
    addi $t1, $t1, -1           
    bgtz $t1, out              
    jr   $ra    