## 
# @author N°étudiant ... 
# File_name : syracuse.asm 
# Description : Calcul du premier rang k tel que S_k=1 où (S_n) 
#               est la suite de Syracuse.
##

### Data section (Vous pouvez déclarer ici d'autres données et constantes) ###

.data
RANG   : .asciiz "k = "

 
### Text section ### 

.text 
.globl _main_

### Début du programme (à compléter) ###

_main_ : 
    li $t0, N # S_0=N (à définir)
    ## 
    # TO DO 
    ##

### Sorti du programme ###

fin : 
    li $v0, 10 
    syscall 

## Routines d'impression ## 

# print_int et print_string impriment le contenu du registre $a0

## 

print_int : 
    li $v0, 1 
    syscall 
    jr $ra 

print_string :	
    li $v0, 4 		
    syscall 		
    jr $ra