##
# @author Clement Moreau
# File_name : fibo.asm
#
# Description : Calcul les n premiers nombres de la suite de Fibonacci, les place
#               dans le tableau FIBS (de taille n) puis imprime le tableau.
#               On suppose FIBS de taille n et n contenu dans le registre $t9
# P.S : Solution partiellement issue du site http://courses.missouristate.edu/KenVollmar/mars/download.htm
##

### Data section ### 
   
.data 
FIBS	:	.word    0 : 12        # Tableau à compléter 
                .eqv 	 FIBS_SIZE 12 # Taille de FIBS  
SPACE	:	.asciiz  " "  

### Text section ###
.text
.globl _main_
### Début du programme ###
_main_ :     
    la   $t0, FIBS          # load address of array       
    la   $t9, FIBS_SIZE       # Chargement taille de FIBS
    li   $t2, 0             # 0 is first and second Fib. number       
    sw   $t2, 0($t0)        # F[0] = 0  
    li   $t2, 1             # 1 is second Fib. number           
    sw   $t2, 4($t0)        # F[1] = 1       
    addi $t1, $t9, -2       # Counter for loop, will execute (size-2) times 
loop : 
    lw   $t3, 0($t0)        # Get value from array F[n]        
    lw   $t4, 4($t0)        # Get value from array F[n+1]       
    add  $t2, $t3, $t4      # $t2 = F[n] + F[n+1]       
    sw   $t2, 8($t0)        # Store F[n+2] = F[n] + F[n+1] in array       
    addi $t0, $t0, 4        # increment address of Fib. number source       
    addi $t1, $t1, -1       # decrement loop counter       
    bgtz $t1, loop          # repeat if not finished yet.       
    
### Sorti du programme ###
fin :
     la   $a0, FIBS         # first argument for print (array)       
     add  $a1, $zero, $t9   # second argument for print (size)   
     jal print_tab
     li $v0, 10
     syscall        

## Routines d’impression ##
# Routine d'impression d'un tableau 
# $a0 contient le tableau et $a1 contient la taille du tableau
##

print_tab : 
    add  $t0, $zero, $a0    # starting address of array       
    add  $t1, $zero, $a1    # initialize loop counter to array size       
out:  
    lw   $a0, 0($t0)        # load fibonacci number for syscall       
    li   $v0, 1             # specify Print Integer service      
    syscall                 # print fibonacci number       
    la   $a0, SPACE         # load address of SPACEr for syscall       
    li   $v0, 4             # specify Print String service       
    syscall                 # output string       
    addi $t0, $t0, 4        # increment address       
    addi $t1, $t1, -1       # decrement loop counter       
    bgtz $t1, out           # repeat if not finished       
    jr   $ra                # return
