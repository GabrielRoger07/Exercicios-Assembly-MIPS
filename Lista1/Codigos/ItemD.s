.data

msg1: .asciiz "Digite a capacidade da cabine: "
msg2: .asciiz "Digite o numero de alunos: "
msg3: .asciiz "Numero minimo de viagens: "
msg4: .asciiz "\n"

.text
main:

#printar a mensagem 1 na tela
#li      $v0, 4
#la      $a0, msg1
#syscall

#ler a capacidade da cabine
li      $v0, 5
syscall
move    $s0, $v0

#printar a mensagem 2 na tela
#li      $v0, 4
#la      $a0, msg2
#syscall

#ler a quantidade de alunos
li      $v0 ,5
syscall
move    $s1, $v0

#reduzir a capacidade da cabine em 1
addi $s0, $s0, -1

#inicializar a variavel que armazenara a quantidade de viagens com 0
move $s2, $zero

#loop para contar a quantidade de viagens
Loop:   sub $s1, $s1, $s0
        addi $s2, $s2, 1
        slt $s3, $zero, $s1
        beq $s3, $zero, Exit
        j Loop
Exit:

#printar a quantidade de viagens
li      $v0, 1
move    $a0, $s2
syscall

#encerrar o programa

li      $v0, 10
syscall
