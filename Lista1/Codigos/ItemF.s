.data

msgTeste: .asciiz "Chegou no teste\n"
msgFinal: .asciiz "Chegou no final\n"

.text
main:

addi $a1, $zero, 3

jal elemDistintos

# Encerrar o programa
        li          $v0, 10
        syscall


elemDistintos:
	# $t0: $a0 (endereço base do vetor) 
    # $t1: $a1 (quantidade de elementos do vetor)
    # $t2: i
    # $t3: j
    # $t4: numIguais
    # $t5: numDistintos
    # $t6: comparador
    # $t7: -1
    # $t8: v[i]
    # $t9: j[i]
        # 2 - Executa o procedimento

        #inicializar t0 com endereço base

        move $t0, $a0
        #inicializar t1 com quantidade de elementos
        move $t1, $a1
        #inicializar i com 1
        addi $t2, $zero, 1
        #inicializar numDistintos com 1
        addi $t5, $zero, 1
        #inicializar t7 com -1
        addi $t7, $zero, -1
Loop1:
        #i < quantidade de elementos?
        slt $t6, $t2, $t1

        li          $v0, 1             
        move        $a0, $t2         
        syscall

        beq $t6, $zero, Exit

        addi $t2, $t2, 1
        j Loop1
Exit:   
        
        #nao chegou aqui        
        
        #Salvar o resultado no registrador de retorno
        move $v0, $t5 
        #Retornar ao caller
        jr $ra
