#ajout de la constante CUTOFF
.data
CUTOFF:
.int 2
#fin de l'ajout
.text
.globl quicksort_s
quicksort_s:
pushl %ebp
movl %esp, %ebp
pushl %ebx
# DEBUT
        #init
movl  8(%ebp),  %edx    #T_
movl 12(%ebp),  %ebx    #left
movl 16(%ebp),  %ecx    #right

addl  CUTOFF, %ebx      #left += 2
cmp     %ecx, %ebx      #(left + 2) vs right

jg retour               #si tab possede moins de 2 elem, bye
subl  CUTOFF, %ebx      #left -= 2

pushl %ecx
pushl %ebx  #empile les args
pushl %edx

call medianOfThree  #Appel medianOfThree avec les param

popl %edx
popl %ebx   #replace la pile
popl %ecx

#pivot = eax

dec %ecx                #right -= 1
while1:
    inc %ebx
    cmpl %eax, (%edx, %ebx, 4) # i < pivot
    jl while1

while2:
    dec %ecx
    cmpl %eax, (%edx, %ecx, 4) # k > pivot
    jg while2


cmpl %ecx, %ebx     # i < k

jg skip

pushl %eax
pushl %ecx
pushl %ebx
pushl %edx

call swapRefs

popl %edx #tableau
popl %ebx #i
popl %ecx #k
popl %eax

jmp while1

skip:
##########

movl 12(%ebp),  %esi #left
movl 16(%ebp),  %edi #right

dec %edi #right - 1
pushl %edi #right
pushl %ebx #i
pushl %edx #tableau

call swapRefs

popl %edx
popl %ebx
popl %edi
inc %edi #right + 1

##########

dec   %ebx
pushl %ebx
pushl %esi #left
pushl %edx

call quicksort_s

popl %edx
popl %esi
popl %ebx
inc  %ebx

##########

inc   %ebx # i + 1
pushl %edi #right
pushl %ebx #i
pushl %edx #tableau

call quicksort_s

popl %edx #tableau
popl %ebx #i
popl %esi #right
dec  %ebx # i -

##########
# FIN
# NE RIEN MODIFIER APRES CETTE LIGNE
retour:   
popl %ebx
leave
ret
