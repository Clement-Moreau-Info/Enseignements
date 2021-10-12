##
# @author Clément Moreau
# File_name : lister.asm
# 
# Description : Liste les n premiers élément d'un tableau Tab de word. On considère que si n > size(Tab).
#               On affichera le tableau complet. On suppose n stocké dans le registre $t0
##

##### Data section #####
.data


TAB1	 	: .float 	0.0, 1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0 	# Tableau 
TAB2	 	: .float 	1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0, 1.0 	# Tableau 
	 	  .eqv 		TAB_SIZE 10			# Constante de taille du tableau
CONST		: .float        0.1
SPACE 	 	: .asciiz 	" "
newline 	: .asciiz 	"\n"

#### Text section #####
.text

.globl _main_

_main_ :	li $t8, 0
		la $t0, TAB1
		la $t1, TAB2
		la $t3, TAB_SIZE
		l.s $f0, CONST
boucle : 	beq $t8, $t3, fin
		l.s $f1, ($t0)
		l.s $f2, ($t1)
		mul.s $f3, $f1, $f0
		add.s $f2, $f3, $f2
		s.s $f2, ($t1)
		addi $t0, $t0, 4
		addi $t1, $t1, 4
		addi $t8, $t8, 1
		j boucle

fin :         	la $a0, TAB2
		la $a1, TAB_SIZE
		jal print_tab
		li $v0, 10                                      
              	syscall  	 		
    		
print_int :     li $v0, 1                                           
        	syscall  
        	jr $ra
        	
print_string :  li $v0, 4                                          
        	syscall  
        	jr $ra    

print_tab : 
    add  $t0, $zero, $a0    # starting address of array       
    add  $t1, $zero, $a1    # initialize loop counter to array size       
out:  
    l.s   $f12, ($t0)        # load fibonacci number for syscall       
    li   $v0, 2             # specify Print Integer service      
    syscall                 # print fibonacci number       
    la   $a0, SPACE         # load address of SPACEr for syscall       
    li   $v0, 4             # specify Print String service       
    syscall                 # output string       
    addi $t0, $t0, 4        # increment address       
    addi $t1, $t1, -1       # decrement loop counter       
    bgtz $t1, out           # repeat if not finished       
    jr   $ra                # return
