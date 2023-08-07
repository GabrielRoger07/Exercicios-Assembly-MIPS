.data

msg: .asciiz "Digite o numero: "
msgSpace: .asciiz " "
msgLinha: .asciiz "\n" 
msgAst: .asciiz "*"
msgTeste: .asciiz "Ate aqui ok\n"
msgFinal: .asciiz "Final chegou fio"

.text
main:
#s0 = num, s1 = i, s2 = comparador, s3 = r, s4 = j, s5 = manipular s1

#ler o numero digitado
li      $v0, 5
syscall
move    $s0, $v0

#inicializar a primeira variavel de loop em 0
add $s1, $zero, 1
add $s7, $s0, 1

#primeiro loop
Loop1:      #verificando se i<=numero
            slt $s2, $s1, $s7
            beq $s2, $zero, ExitPrincipal
            add $s3, $s0, $zero

            
Loop2:      #verificando se r>i
            slt $s2, $s1, $s3
            add $s4, $zero, $zero
            beq $s2, $zero, Loop3
            li          $v0, 4      
            la          $a0, msgSpace   
            syscall   
            addi $s3, $s3, -1
        

            
            j Loop2
Loop3:  
            add $s5, $s1, $zero
            sll	$s5, $s5, 1
            addi $s5, $s5, -1

            slt $s2, $s4, $s5
            beq $s2, $zero, Exit
            li  $v0, 4      
            la  $a0, msgAst   
            syscall 
            addi $s4, $s4, 1 
            j Loop3
             
Exit:       

            addi $s1, $s1, 1
            slt $s2, $s1, $s7
            beq $s2, $zero, ExitPrincipal
            li      $v0, 4
            la      $a0, msgLinha
            syscall

            j Loop1
ExitPrincipal: 



#encerrar o programa
li      $v0, 10
syscall