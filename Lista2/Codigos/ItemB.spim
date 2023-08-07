divfac:

        # (a) - Alocar espaco na pilha:
        addi        $sp, $sp, -4
        
        # (b) - Salva o dado na pilha
        sw          $s0, 4($sp)

        #Colocando os parâmetros em outras variaveis
        move        $t0, $a0
        move        $t1, $a1
        add         $t2, $zero, $zero
        addi        $t3, $zero, 1
        addi        $t4, $zero, 33

        #t0 => Dividendo (R[31...0])
        #t1 => Divisor
        #t2 => R[63...32]
        #t3 => Contador que vai até 32
        #t4 => variável que armazena 32(limite do loop)
        #t5 => variável para armazenar as subtrações entre t2 e t1
        #t6 => variável para armazenar o complemento de 2 do divisor
        #t7 => guardará resultados de slts
        #t8 => guardará resultados de ands
        #s0 => variável para verificar sinal de t0
        #s1 => variável para verificar sinal de t1

        ##verificar se o sinal de t0 e t1 é o mesmo
        #(a)verificar o sinal de t0
        #s0 recebe 0 se for negativo
        slt         $s0, $zero, $t0

        #(b)verificar o sinal de t1
        #s1 recebe 0 se for negativo
        slt         $s1, $zero, $t1

        #se s0 != s1, então eles possuem sinais diferentes

        #transformar t1 e t0 em inteiros sem sinal
        bne         $s0, $zero, PrimeiroPositivo

        #invertendo os bits de t0(mudando de 0 para 1 e vice-versa)
        nor		    $t0, $t0, $zero		
        #somando 1 ao t0
        addi        $t0, $t0, 1

PrimeiroPositivo:
        bne         $s1, $zero, SegundoPositivo

        #invertendo os bits de t1(mudando de 0 para 1 e vice-versa)
        nor		    $t1, $t1, $zero		
        #somando 1 ao t1
        addi        $t1, $t1, 1

SegundoPositivo:

        #Para iniciar, shift à esquerda na parte menos significativa do resto(t0)
        sll	    $t0, $t0, 1	
		
Loop:
        #verificar se o contador é igual a 32
        beq         $t3, $t4, Exit
        #Calcular R[63...32] - Divisor (t2 - t1)
        #(a) Fazer o complemento de 2 de divisor para encontrar: -t1

                ##invertendo os bits de t1(mudando de 0 para 1 e vice-versa)
        nor         $t6, $t1, $zero		
                ##somando 1 ao t1
        addi        $t6, $t6, 1

        #(b) - Realizar t2 + (-t1)
        add         $t5, $t2, $t6

        #se t5 for menor que 0, t2 não recebe t5
        #porém , se t5 não for menor que 0, t2 recebe t5

        slt         $t7, $t5, $zero

        #se t7 for , t2 = t5 
        bne         $t7, $zero, NaoAlteraT2 
        #se entrou aqui, t5 é maior ou igual a 0, logo, t2 recebe t5
        move        $t2, $t5     

NaoAlteraT2:
        #antes de dar o shift, verificar se R[31] == 1
        #se R[31] == 1, então t8 = 1
        andi        $t8, $t0, -2147483648
        #se t8 for 1, R[32] receberá 1

        #shift a esquerda em R[63...32] e R[31...0]

        sll         $t0, $t0, 1
        sll         $t2, $t2, 1

        #Se t8 for igual a 1, R[32] receberá 1
        beq         $t8, $zero, NaoHaPassagem
        ori         $t2, $t2, 1

NaoHaPassagem:

        #Se t7 for 0 significa que a subtração não deu negativo, ou seja, R[0] = 1
        bne         $t7, $zero, SubtracaoDeuNegativo
        addi        $t0, $t0, 1

SubtracaoDeuNegativo:

        #Contador++
        addi        $t3, $t3, 1
        j Loop

Exit:

        #após o loop acabar deve haver um shift a direita em R[63...32]

        srl         $t2, $t2, 1

        #O resto precisa ter o mesmo sinal que o dividendo, portanto se o dividendo for negativo
        #é necessário fazer complemento a dois no resto

        bne         $s0, $zero, RestoTaSafe
        #invertendo os bits de t2(mudando de 0 para 1 e vice-versa)
        nor         $t2, $t2, $zero		
        #somando 1 ao t2
        addi        $t2, $t2, 1

RestoTaSafe:

        #se o sinal do dividendo e do divisor forem diferentes, é necessário fazer complemento a dois
        #no quociente
        beq         $s0, $s1, ExitPrincipal
        #invertendo os bits de t0(mudando de 0 para 1 e vice-versa)
        nor         $t0, $t0, $zero		
        #somando 1 ao t2
        addi        $t0, $t0, 1

ExitPrincipal:

        #hi recebe resto(t2)
        #lo recebe quociente(t0)

        mthi $t2
        mtlo $t0

        # 4 - Restaura os dados de pilha

        # (a) - Restaurar o dado da pilha
        lw          $s0, 4($sp)         # $s0 = conteudo_endereco($sp + 4)

        # (b) - Desalocar o espaco da pilha
        addi        $sp, $sp, 4

        jr $ra