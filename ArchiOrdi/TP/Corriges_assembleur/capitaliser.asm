##
# @author Clément Moreau
# File_name : afficher.asm
# 
# Description : Affiche un message MESSAGE dont toutes les lettres sont remplacées par leur équivalent majuscule. 
#               ex : capitaliser("Bonjour !") = "BONJOUR !"
#		On pourra s'aider du document ascii présent dans le TD 1.
##


##### Data section #####
.data

ESPACE 	:	.asciiz " "
MESSAGE :	.asciiz "{Hello world !}"

#### Text section #####
.text
.globl _main_

_main_ :	  la $t0, MESSAGE	         # On charge l'adresse du message	
	
boucle :	  lb $t1, ($t0)              # On charge le caractère courant c_i du message
		      beqz $t1, fin              # Si c_i == NULL ? On est à la fin de la chaine
    		  subi $t3, $t1, 'a'         # On calcule (c_i - 'a') selon les codes ASCII
    		  bltz $t3, non_minuscule	 # Si c_i - 'a' < 0, alors le caractère n'est pas minuscule
    		  subi $t3, $t1, 'z'		 # Si 'a' < c_i < 'z', alors le caractère est minuscule		
    		  bgtz $t3, non_minuscule
    		  add $t1, $t1, -32		     # Le caractère est minuscule, 
    		                             # On décale : c_i = c_i - ('A' - 'a') = c_i = c_i - 32;
    		
non_minuscule :   sb $t1, ($t0)      # On remplace le caractère c_i à l'adresse courrante
	 	  addi $t0, $t0, 1           # On incrémente l'adresse du tableau au caractère c_{i+1}
		  j boucle                   # On reboucle
    		
fin :		  la $a0, MESSAGE        # On charge le message à imprimer
		  jal print_string
		  li $v0, 10
         	  syscall
         	  
## Routines d'impression ##
#
# La routine imprime le contenu du registre $a0
#
##
         	
print_int :	  li $v0, 1
		  syscall
		  jr $ra
		
print_string :	  li $v0, 4
		  syscall
		  jr $ra    		