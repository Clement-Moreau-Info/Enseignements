##
# @author Clément Moreau 
# File_name : affDist2.asm
# 
# Description : Affiche la distance au carré (x_b - x_a)^2 + (y_b - y_a)^2 entre deux points A=(x_a, y_a) et B=(x_b, y_b)
#              On assume que x_a est dans le registre $t0, y_a dans $t1, x_b dans $t2 et y_b dans $t3
##

##### Data section #####
.data

SPACE 	 	: .asciiz 	" "
newline 	: .asciiz 	"\n"

#### Text section #####
.text

.globl _main_

_main_ :	li $t0, 0
		li $t1, 0
		li $t2, 1
		li $t3, 1
    		sub $t2, $t2, $t0 #(x_b - x_a)
    		mul $t2, $t2, $t2 #(x_b - x_a)^2
    		sub $t3, $t3, $t1 #(y_b - y_a)
    		mul $t3, $t3, $t3 #(y_b - y_a)^2
    		add $a0, $t2, $t3 #(x_b - x_a)^2 + (y_b - y_a)^2
    		jal print_int 
    		
fin :         	li $v0, 10                                      
              	syscall  	 		

## Routines d'impression ##
#
# La routine imprime le contenu du registre $a0
#
##

print_int :     li $v0, 1                                           
        	syscall  
        	jr $ra
        	
print_string :  li $v0, 4                                          
        	syscall  
        	jr $ra   