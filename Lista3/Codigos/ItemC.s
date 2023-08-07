        .data

msg1:   .asciiz     "Digite o valor do custo de fabrica: "
msg2:   .asciiz     "Digite a porcentagem de lucro: "
msg3:   .asciiz     "Digite a porcentagem de impostos: "
msg4:   .asciiz     "O preco final eh: "
consts: .double      100.0

        .text

main:

        #Le o custo de fabrica
        li      $v0, 7
        syscall

        #Armazena o valor do custo de fabrica em $f2
        mov.d   $f2, $f0

        #Le a porcentagem de lucro
        li      $v0, 7
        syscall

        #Armazena o valor da porcentagem de lucro em $f4
        mov.d   $f4, $f0

        #Le a porcentagem de impostos e armazena em $f0
        li      $v0, 7
        syscall

        #Armazena 100.0 em $f6
        la          $t0, consts
        ldc1        $f6, 0($t0)

        #Divide as porcentagens por 100
        div.d       $f4, $f4, $f6
        div.d       $f0, $f0, $f6

        #Multiplica as porcentagens pelo custo
        mul.d       $f4, $f4, $f2
        mul.d       $f0, $f0, $f2

        #Soma os três
        add.d       $f4, $f4, $f2
        add.d       $f4, $f4, $f0

        #Imprime o resultado
        li          $v0, 3
        mov.d       $f12, $f4
        syscall

        #Encerra o programa
        li          $v0, 10
        syscall