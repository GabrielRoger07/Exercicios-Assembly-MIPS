        .data

consts: .float      0.0

        .text
main:

        #Lê a quantidade de números que serão inseridos
        li      $v0, 5
        syscall
        move 	$t0, $v0

        #Inicializa o contador, o total e a soma dos pesos em 0
        move    $t1, $zero
        la      $t4, consts
        lwc1    $f3, 0($t4)
        lwc1    $f10, 0($t4)

Loop:
        #Compara o contador com a quantidade n
        slt		$t2, $t1, $t0
        beq		$t2, $zero, LoopExit

        #Lê o float digitado(retorno em $f0)
        li      $v0, 6
        syscall

        #Armazena o numero em f1
        mov.s   $f1, $f0

        #Lê o float digitado(retorno em $f0)
        li      $v0, 6
        syscall

        #Multiplica o numero com seu peso e soma no total
        mul.s   $f2, $f1, $f0
        add.s   $f3, $f3, $f2

        #Incrementa o valor do peso no valor total
        add.s   $f10, $f10, $f1

        #Incrementa o contador e volta ao inicio do loop
        addi	$t1, $t1, 1	
        j Loop		
        
        
LoopExit:

        #Divide o resultado pela soma dos pesos
        div.s   $f3, $f3, $f10
        
        #Imprime o resultado na tela
        li      $v0, 2
        mov.s   $f12, $f3
        syscall

        #Encerra o programa
        li      $v0, 10
        syscall
