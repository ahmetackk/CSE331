.data
prompt: .asciiz "Bir sayi girin: "
palindrome_msg: .asciiz "Sayi bir palindromdur.\n"
not_palindrome_msg: .asciiz "Sayi bir palindrom degildir.\n"

.text
.globl main

main:
    # Kullan�c�dan say� al
    li $v0, 4               # Print string sistem �a�r�s�
    la $a0, prompt          # prompt mesaj�n� y�kle
    syscall

    li $v0, 5               # Read integer sistem �a�r�s�
    syscall
    move $t0, $v0           # Say�y� $t0 register�na kaydet

    # Say�n�n tersini al
    move $t1, $t0           # Say�y� $t1 register�na kopyala (orijinal say�y� saklamak i�in)
    li $t2, 0               # Tersi saklamak i�in $t2'yi s�f�rla
    li $t3, 10              # 10 say�s�n� $t3'e y�kle (mod i�lemi i�in)

reverse_loop:
    beq $t1, 0, check_palindrome # E�er $t1 s�f�rsa d�ng�den ��k
    div $t1, $t3            # $t1'i 10'a b�l (kalan ve b�l�m)
    mfhi $t4                # Kalan� $t4'e y�kle
    mflo $t1                # B�l�m� $t1'e y�kle
    mul $t2, $t2, $t3       # $t2'yi 10 ile �arp
    add $t2, $t2, $t4       # $t2'ye $t4 ekle (ters say�y� olu�tur)

    j reverse_loop          # D�ng�n�n ba��na d�n

check_palindrome:
    # Say�n�n tersini orijinaliyle kar��la�t�r
    beq $t0, $t2, is_palindrome   # E�er say� ve tersi ayn�ysa palindromdur
    j not_palindrome

is_palindrome:
    li $v0, 4               # Print string sistem �a�r�s�
    la $a0, palindrome_msg   # palindrome_msg mesaj�n� y�kle
    syscall
    j end

not_palindrome:
    li $v0, 4               # Print string sistem �a�r�s�
    la $a0, not_palindrome_msg # not_palindrome_msg mesaj�n� y�kle
    syscall

end:
    li $v0, 10              # Program� sonland�r
    syscall
