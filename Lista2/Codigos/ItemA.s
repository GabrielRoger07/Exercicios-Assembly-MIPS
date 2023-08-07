        .data

msg1:   .asciiz "Digite o primeiro numero: "
msg2:   .asciiz "Digite o segundo numero: "
msg3:   .asciiz "\nlo: "
msg4:   .asciiz "\nhi: "
msg5:   .asciiz "\nt0: "
msg6:   .asciiz "\nt1: "
msg7:   .asciiz "\nprimeiro numero nao eh positivo\n"
msg8:   .asciiz "\nsegundo numero nao eh positivo\n"
msg9:   .asciiz "\nt6: "
msg10:  .asciiz "\nt7: "

        .text
main:
        #Imprimindo a msg1 na tela
        li          $v0, 4
        la          $a0, msg1
        syscall
        
        #Lendo o primeiro numero e armazenando em s0
        li          $v0, 5
        syscall
        move        $s0, $v0

        #Imprimindo a msg2 na tela
        li          $v0, 4
        la          $a0, msg2
        syscall

        #Lendo o segundo numero e armazenando em s1
        li          $v0, 5
        syscall
        move        $s1, $v0

        #Salvando os valores nos argumentos
        move        $a0, $s0
        move        $a1, $s1

        #Chamando a função
        jal         multfac

        # (c) - salva o retorno da funcao
        mfhi        $s1
        mflo        $s0

        #Imprimindo msg3 na tela
        li          $v0, 4
        la          $a0, msg3
        syscall

        #Imprimindo lo na tela  
        li          $v0, 1
        move        $a0, $s0
        syscall

        #Imprimindo msg4 na tela
        li          $v0, 4
        la          $a0, msg4
        syscall

        #Imprimindo lo na tela  
        li          $v0, 1
        move        $a0, $s1
        syscall

        li          $v0, 10
        syscall

multfac:

        #Colocando os parametros em outras variaveis
        move        $t0, $a0
        move        $t1, $a1
        move        $t2, $zero
        move        $t3, $zero
        addi        $t4, $zero, 32
    

        #t0 => M
        #t1 => lo
        #t2 => hi
        #t3 => contador(0 a 31)
        #t4 => 32 (comparador para contador)
        #t5 => variável para armazenar resultados de ifs, comparadores e ands
        #t6 => variável para verificar sinal de t0
        #t7 => variável para verificar sinal de t1

        ##verificar se o sinal de t0 e t1 é o mesmo
        #(a)verificar o sinal de t0
        #t6 recebe 0 se for negativo
        slt         $t6, $zero, $t0

        #(b)verificar o sinal de t1
        #t7 recebe 0 se for negativo
        slt         $t7, $zero, $t1

        #se t6 != t7, então eles possuem sinais diferentes

        #transformar t1 e t0 em inteiros sem sinal
        bne         $t6, $zero, PrimeiroPositivo

        #invertendo os bits de t0(mudando de 0 para 1 e vice-versa)
        nor		    $t0, $t0, $zero		
        #somando 1 ao t0
        addi        $t0, $t0, 1

PrimeiroPositivo:
        bne         $t7, $zero, SegundoPositivo

        #invertendo os bits de t1(mudando de 0 para 1 e vice-versa)
        nor		    $t1, $t1, $zero		
        #somando 1 ao t1
        addi        $t1, $t1, 1

SegundoPositivo:
        
Loop1:  #verificar se contador = 32
        beq         $t3, $t4, Exit
        #and para verificar se P[0] == 1
        andi        $t5, $t1, 1
        #verificar se o resultado da and deu 1. Se for 1, P[0] == 1
        beq         $t5, $zero, NaoEhUm
        #se está aqui, P[0] == 1. Então, hi = hi + t0
        add         $t2, $t2, $t0
NaoEhUm:
        #verificar se P[32](bit menos significativo do registrador mais significativo) é 1
        andi        $t5, $t2, 1
        #fazer deslocamento à direita(srl) de hi e lo
        srl         $t1, $t1, 1
        srl         $t2, $t2, 1
        #se P[32] antes do deslocamento fosse 1(se $t5 != 0), então P[31] == 1
        beq         $t5, $zero, NaoEh1
        ori         $t1, $t1, -2147483648
NaoEh1:
        addi        $t3, $t3, 1
        j Loop1
Exit:

        #(c)se t6 != t7, então t0 e t1 possuem sinais diferentes
        #então, será necessário fazer o complemento a dois no produto(t1 e t2)
        beq         $t6, $t7, ExitPrincipal



        ##invertendo os bits de t1(mudando de 0 para 1 e vice-versa)
        nor		    $t1, $t1, $zero		
        ##somando 1 ao t1
        addi        $t1, $t1, 1

        #invertendo os bits de t2(mudando de 0 para 1 e vice-versa)
        #nor		    $t2, $t2, $zero		
        #somando 1 ao t2

        #verificar se hi é maior que 0
        #se for, faz complemento de 2 

        slt         $t5, $zero, $t2
        beq         $t5, $zero, HiNaoEhPositivo

        ##invertendo os bits de t2(mudando de 0 para 1 e vice-versa)
        nor		    $t2, $t2, $zero		
        ##somando 1 ao t2
        addi        $t2, $t2, 1


HiNaoEhPositivo:
        addi        $t2, $t2, -1

ExitPrincipal:
        mthi $t2
        mtlo $t1

        jr $ra