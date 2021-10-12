##
# @author Clément Moreau
# File_name : min_max.asm
#
# Description : Affiche le min et le max d'un ensemble de trois nombres a, b, et c contenus dans $t0, $t1 
#               et $t2 respectivement.
#               Le min sera placé dans le registre $a2 et le max dans le registre $a1.
##
### Data section ### 
.data
MIN : .asciiz "min = "
MAX : .asciiz " et max = "
 
### Text section ###
.text
.globl _main_
### Début du programme ###
_main_ :
	li  $t0, -3 # a
	li  $t1, -1 # b
	li  $t2, -8 # c
	bgt $t0, $t1, max # $t0 > $t1 ? branchement à max
	move $a1, $t1     # $t1 est le max a priori
	move $a2, $t0     # $t0 est le min a priori
	j suite
max :   
	move $a1, $t0   # $t0 est le max a priori
	move $a2, $t1   # $t1 est le min a priori
suite : 
	bgt $a1, $t2, min  # On regarde si le nombre restant est plus grand que le max enregistré
	move  $a1, $t2     # $t2 > $a1 > $a2, donc $t2 est le max et le min enregistré est exacte
	j fin
min :  
    blt $a2, $t2, fin     # $a1 est exacte, on regarde si $a2 < $t2
	move $a2, $t2         # $t2 < $a2 < $a1, on met à jour le minimum.

### Sorti du programme ###
fin :
     jal print_min_max
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
     jr $ra
print_string :
     li $v0, 4
     syscall
     jr $ra
print_min_max :
     la $a0, MIN
     jal print_string
     move $a0, $a2
     jal print_int
     la $a0, MAX
     jal print_string
     move $a0, $a1
     jal print_int