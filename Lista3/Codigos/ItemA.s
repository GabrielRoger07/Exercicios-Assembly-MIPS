        .data

buffer: .space      20
msg1:   .asciiz     "Em qual escala(C/F/K) encontra-se a temperatura? "
msg2:   .asciiz     "Para qual escala a temperatura sera convertida? "
msg3:   .asciiz     "Digite o valor da temperatura: "
msg4:   .asciiz     "A temperatura na nova escala tem valor de: "
consts: .double     1.8, 32.0, 273.15, -459.67
consts2:.double     5.0, -160.0, 9.0


        .text
main:

        #Le o primeiro caracter e armazena em $t1
        li      $v0, 8
        la      $a0, buffer
        li      $a1, 3
        syscall
        move    $t0, $a0
        lb		$t1, ($t0)		
        

        #Le o segundo caracter e armazena em $t2
        li      $v0, 8
        la      $a0, buffer
        li      $a1, 3
        syscall
        move    $t0, $a0
        lb		$t2, ($t0)

        #Le o valor da temperatura e armazena em $f0
        li      $v0, 7
        syscall

        #Armazena os valores C, F e K em registradores(t3, t4, t5)
        li      $t3, 'C'
        li      $t4, 'F'
        li      $t5, 'K'

        #Se t1 for diferente de C, ele vai para PrimeiroNaoEhC
        bne     $t1, $t3, PrimeiroNaoEhC

        #Se está aqui, t1 == C
        #Se entrar no primeiro beq, a conversão é C => F
        beq     $t2, $t4, CtoF
        
        #Se está aqui, t2 == K
        j CtoK  	

PrimeiroNaoEhC:
        #Se t1 for diferente de F, ele vai para PrimeiroEhK
        bne     $t1, $t4, PrimeiroEhK

        #Se está aqui, t1 == F
        #Se entrar no primeiro beq, a conversão é F => C
        beq     $t2, $t3, FtoC

        #Se está aqui, t2 == K
        j FtoK

PrimeiroEhK:

        #Se entrar no primeiro beq, a conversão é K => C
        beq     $t2, $t3, KtoC

        #Se está aqui, t2 == F
        j KtoF

CtoF:
        #$f2 = 1.8 e $f4 = 32.0
        la          $t0, consts
        ldc1        $f2, 0($t0)
        ldc1        $f4, 8($t0)

        #Multiplica $f0 e $f2 e depois soma o resultado com $f4
        mul.d   $f0, $f0, $f2
        add.d   $f0, $f0, $f4

        j Exit

CtoK:
        #$f2 = 273.15
        la          $t0, consts
        ldc1        $f2, 16($t0)

        #Soma $f0 com $f2
        add.d   $f0, $f0, $f2
        j Exit

FtoC:
        #$f2 = 5.0, $f4 = -160.0 e $f6 = 9.0
       la          $t0, consts2
       ldc1        $f2, 0($t0)
       ldc1        $f4, 8($t0)
       ldc1        $f6, 16($t0)

       #Multiplica $f0 com $f2 e depois soma o resultado com $f4
       mul.d    $f0, $f0, $f2
       add.d    $f0, $f0, $f4

       #Divide o resultado por $f6
       div.d    $f0, $f0, $f6

        j Exit 

FtoK:
        #$f2 = 5.0, $f4 = -160.0, $f6 = 9.0 e $f8 = 273.15
        la          $t0, consts2
        la          $t1, consts
        ldc1        $f2, 0($t0)
        ldc1        $f4, 8($t0)
        ldc1        $f6, 16($t0)
        ldc1        $f8, 16($t1)

        #multiplica $f0 com $f2 e depois soma o resultado com $f4
        mul.d   $f0, $f0, $f2
        add.d   $f0, $f0, $f4

        #divide o resultado por $f6 e depois soma com $f8
        div.d   $f0, $f0, $f6
        add.d   $f0, $f0, $f8

        j Exit

KtoC:
        #$f2 = 273.15
        la      $t0, consts
        ldc1    $f2, 16($t0)

        #subtrai $f0 com $f2
        sub.d   $f0, $f0, $f2

        j Exit 

KtoF:
        #$f2 = 1.8 e $f4 = -459.67
        la      $t0, consts
        ldc1    $f2, 0($t0)
        ldc1    $f4, 24($t0)

        #multiplica $f0 com $f2 e depois soma o resultado com $f4
        mul.d   $f0, $f0, $f2
        add.d   $f0, $f0, $f4

        j Exit   

Exit:

        #Imprime o resultado
        li      $v0, 3
        mov.d   $f12, $f0
        syscall

        #Encerra o programa
        li      $v0, 10
        syscall

