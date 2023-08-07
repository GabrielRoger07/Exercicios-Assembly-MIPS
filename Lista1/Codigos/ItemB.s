.data

.text
main:

#ler o primeiro numero
li      $v0, 5
syscall
move    $s0, $v0

#ler o segundo numero
li      $v0, 5
syscall
move    $s1, $v0

#realizar a soma
add $t0, $s0, $s1

#printar o resultado
li      $v0, 1
move    $a0, $t0
syscall

#encerrar o programa
li      $v0, 10
syscall