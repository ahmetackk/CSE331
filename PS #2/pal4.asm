.data
prompt: .asciiz "Bir sayi girin: "
palindrome_msg: .asciiz "Sayi bir palindromdur.\n"
not_palindrome_msg: .asciiz "Sayi bir palindrom degildir.\n"

.text
.globl main

main:
    # Kullanýcýdan sayý al
    li $v0, 4               # Print string sistem çaðrýsý
    la $a0, prompt          # prompt mesajýný yükle
    syscall

    li $v0, 5               # Read integer sistem çaðrýsý
    syscall
    move $t0, $v0           # Sayýyý $t0 registerýna kaydet

    # Sayýnýn tersini al
    move $t1, $t0           # Sayýyý $t1 registerýna kopyala (orijinal sayýyý saklamak için)
    li $t2, 0               # Tersi saklamak için $t2'yi sýfýrla
    li $t3, 10              # 10 sayýsýný $t3'e yükle (mod iþlemi için)

reverse_loop:
    beq $t1, 0, check_palindrome # Eðer $t1 sýfýrsa döngüden çýk
    div $t1, $t3            # $t1'i 10'a böl (kalan ve bölüm)
    mfhi $t4                # Kalaný $t4'e yükle
    mflo $t1                # Bölümü $t1'e yükle
    mul $t2, $t2, $t3       # $t2'yi 10 ile çarp
    add $t2, $t2, $t4       # $t2'ye $t4 ekle (ters sayýyý oluþtur)

    j reverse_loop          # Döngünün baþýna dön

check_palindrome:
    # Sayýnýn tersini orijinaliyle karþýlaþtýr
    beq $t0, $t2, is_palindrome   # Eðer sayý ve tersi aynýysa palindromdur
    j not_palindrome

is_palindrome:
    li $v0, 4               # Print string sistem çaðrýsý
    la $a0, palindrome_msg   # palindrome_msg mesajýný yükle
    syscall
    j end

not_palindrome:
    li $v0, 4               # Print string sistem çaðrýsý
    la $a0, not_palindrome_msg # not_palindrome_msg mesajýný yükle
    syscall

end:
    li $v0, 10              # Programý sonlandýr
    syscall
