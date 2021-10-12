##
# @author 	Clément Moreau
# File_name : 	erathostene.asm
# 
# Description : Exécution du crible d'Erathosthène jusqu'à l'entier n contenu dans $t9.
#               On précise que TAB doit être de taille 0:n
##

##### Data section #####
.data

SPACE 	 	: .asciiz 	" "
newline 	: .asciiz 	"\n"
TAB		: .byte 0:100    # Tableau initialement rempli de 0 de 0 -> 100

#### Text section #####
.text
.globl _main_

# Début du programme
_main_ :	
    li $t9, 100           # On charge n (la taille du tableau)
	li $t0, 2             # compteur de 2 -> n
loop : 
	la $t1, TAB           # On charge TAB
	move $t3, $t0         # $t3 = compteur
	add $t1, $t1, $t0     # On se place à 0 + compteur
 	lb $t2, ($t1)         # On charge l'emplacement du tableau
	bnez $t2, raye        # Si $t2 != 0, alors $t2 a été rayé, il n'est pas premier
	move $a0, $t0         # Sinon, compteur est premier, on l'imprime
	jal print_int
raye : 
	add $t3, $t3, $t0     # On va rayer tous les multiples de compteur 
	bgt $t3, $t9, suite   # Si on dépasse la taille du tableau, on a rayé tous les nombres
	la $t1, TAB
	add $t1, $t1, $t3
	li $t4, 1
	sb $t4, ($t1)         # On raye 
	blt $t3, $t9, raye  
suite :
	add $t0, $t0, 1       # On incrémente le compteur (compteur++)
	blt $t0, $t9, loop    # Si compteur < taille ? On continue à rayer, on reboucle
# Sorti du programme
fin :  
    li $v0, 10                                      
    syscall  	 		
 
## Routines d'impression ##
#
# La routine imprime le contenu du registre $a0
#
##
print_int :   
    li $v0, 1                                           
    syscall
    la $a0, newline 
    li $v0, 4                                          
    syscall  
    jr $ra   
