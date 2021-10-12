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

_main_ :	la $t0, TAB.     # Chargement du tableau TAB
		la $s0, TAB_CODE.    # Chargement du tableau TAB_CODE
		li $a1, 0            # Registre du la parité longitudinale
		la $t9, TAB_SIZE     # Taille du tableau TAB

boucle_1 : 	lw $t1, ($t0)  	     # Chargement de l'élément courant TAB[i]
		beqz $t9, fin            # Si on est à la fin du tableau : Branchement à fin
		li $t3, 0		         # Calcul de la parité de TAB[i]
boucle_2 :	beqz $t1, fin_boucle_2	     # Calcul du checksum de TAB[i]
    		andi $t2, $t1, 1
    		xor $t3, $t3, $t2 
    		srl $t1, $t1, 1
		j boucle_2
    		
fin_boucle_2 :	lw $a0, ($t0)		
		sll $a0, $a0, 1
		or $a0, $a0, $t3
		xor $a1, $a1, $a0     # On met à jour le registre du la parité longitudinale
		sw $a0, ($s0)         # On a calculé le checksum de la ligne i 
		add $t0, $t0, 4       # On incrémente le tableau de 32 bits (4 octets)
		add $s0, $s0, 4
		sub $t9, $t9, 1.      # On décrémente la taille du tableau
		j boucle_1

fin :      	sw $a1, ($s0)     # On rempli TAB_CODE[n] = $a1
		la $a0, TAB_CODE      # On donne l'adresse à la routine d'impression
		la $a1, TAB_SIZE      # On donne la taille à la routine d'impression
		add $a1, $a1, 1
    		jal print_tab     # On imprime TAB_CODE
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
    divi $t1, $t1, 2    
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