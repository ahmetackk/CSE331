.data
array: .space 40         # Basamaklar� depolamak i�in bo�luk (40 bayt)
msg: .asciiz "Basamaklar: "

.text
.globl main

main:
    # Tam say� girin
    li $t0, 12345        # �zerinde i�lem yap�lacak tam say�

    # Adresi ve indeksi ayarla
    la $t1, array        # Dizinin ba�lang�� adresi
    li $t2, 0            # Dizi indeksi

basamaklari_ayir:
    # Tam say�n�n 10'a b�l�m�nden kalan� al ve diziye ekle
    li $t3, 10
    div $t0, $t3
    mfhi $t4             # Kalan� al (son basamak)
    sw $t4, 0($t1)       # Dizinin bir sonraki adresine yaz (4 bayt)

    addi $t1, $t1, 4     # Dizi adresini 4 bayt ileri kayd�r
    addi $t2, $t2, 1     # �ndeksi bir art�r

    # Say�y� 10'a b�l
    mflo $t0             # B�l�m (bir sonraki basamak i�in)
    bnez $t0, basamaklari_ayir # Tam say� s�f�r de�ilse devam et

    # Diziyi ters �evirme
    li $t5, 0                # Ba�lang�� indeksi
    sub $t6, $t2, 1          # Dizinin son eleman�na i�aret eden indeksi ayarla

ters_cevir:
    bge $t5, $t6, ters_cevir_son # Ba�lang�� ve biti� kesi�irse d�ng�y� bitir

    # Ba�lang�� ve biti� elemanlar�n� takas et
    mul $t7, $t5, 4           # 4 baytl�k kayd�rma (ba�lang��)
    mul $t8, $t6, 4           # 4 baytl�k kayd�rma (biti�)
    lw $t9, array($t7)        # Dizinin ba�lang��taki eleman�n� al
    lw $t10, array($t8)       # Dizinin sondaki eleman�n� al
    sw $t10, array($t7)       # Sondaki eleman� ba�a yaz
    sw $t9, array($t8)        # Ba�taki eleman� sona yaz

    # �ndeksleri g�ncelle
    addi $t5, $t5, 1          # Ba�lang�� indeksini bir ileri al
    addi $t6, $t6, -1         # Biti� indeksini bir geri al
    j ters_cevir              # D�ng�ye devam et

ters_cevir_son:
    # ��kt�
    li $v0, 4
    la $a0, msg
    syscall

    li $v0, 1               # Basamaklar� tek tek ekrana yazd�rmak i�in d�ng�
    li $t5, 0

print_loop:
    bge $t5, $t2, end       # T�m basamaklar yaz�ld�ysa ��k
    mul $t7, $t5, 4         # 4 baytl�k kayd�rma
    lw $a0, array($t7)      # Diziden say�y� al
    syscall                 # Yazd�r

    addi $t5, $t5, 1        # Sonraki basama�a ge�
    j print_loop            # D�ng�ye devam et

end:
    # Program� sonland�r
    li $v0, 10
    syscall
