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
#           Notes personnelles
#
#   Eight 8-bits registers (AL, AH, BL, BH, CL, CH, DL, DH)
#   32-bits registers      (EAX, EBX, ECX, EDX, ESI, EDI)

        #init
movl  8(%ebp),  %edx    #T_
movl 12(%ebp),  %edi    #left
movl 16(%ebp),  %esi    #right
movl 12(%ebp),  %ebx    #i
movl 16(%ebp),  %ecx    #k
dec %ecx                #ligne 70

addl  CUTOFF, %edi      #left += 2
cmp     %esi, %edi      #(left + 2) vs right
jg retour               #si tab possede moins de 2 elem, bye
subl  CUTOFF, %edi      #left -= 2

pushl %esi
pushl %edi  #empile les args
pushl %edx

call medianOfThree  #Appel medianOfThree avec les param

popl %edx
popl %edi   #replace la pile
popl %esi

#movl 8(%ebp), %eax     #pivot = eax

while1:
    inc %ebx
    cmpl %eax, (%edx, %ebx, 4) # i < pivot
    jl while1

while2:
    dec %ecx
    cmpl %eax, (%edx, %ecx, 4) # k > pivot
    jg while2

cmpl %ecx, %ebx
jg skip

pushl %ecx
pushl %ebx
pushl %edx

call swapRefs

popl %edx #tableau
popl %ebx #i
popl %ecx #k

jmp retour

skip:
##########
dec %esi
pushl %eax
pushl %esi #right
pushl %ebx #i
pushl %edx #tableau

call swapRefs

popl %edx
popl %ebx
popl %esi
popl %eax
inc  %esi

##########

dec   %ebx
pushl %eax
pushl %ebx
pushl %edi #left
pushl %edx

call quicksort_s

popl %edx
popl %edi
popl %ebx
popl %eax
inc  %ebx

##########

inc   %ebx
pushl %eax
pushl %esi
pushl %ebx
pushl %edx

call quicksort_s

popl %edx
popl %ebx
popl %esi
popl %eax
dec  %ebx
##########

#   swapRefs(T_, i, right - 1);  // Permuter T[i] et pivot
#   quicksort(T_, left, i - 1);  // Trier les elements sous le pivot
#   quicksort(T_, i + 1, right); // Trier les elements en haut du pivot

# FIN
# NE RIEN MODIFIER APRES CETTE LIGNE
retour:   
popl %ebx
leave
ret
