.data
array: .space 40        # Basamaklar� depolamak i�in bo�luk (40 bayt)
msg: .asciiz "Basamaklar: "

.text
.globl main

main:
    # Tam say� girin
    li $t0, 12345       # �zerinde i�lem yap�lacak tam say�

    # Adresi ve indeksi ayarla
    la $t1, array       # Dizinin ba�lang�� adresi
    li $t2, 0           # Dizi indeksi

basamaklari_ayir:
    # Tam say�n�n 10'a b�l�m�nden kalan� al ve diziye ekle
    li $t3, 10
    div $t0, $t3
    mfhi $t4            # Kalan� al (son basamak)
    sb $t4, 0($t1)      # Dizinin bir sonraki adresine yaz
    addi $t1, $t1, 1    # Dizi adresini bir ileri kayd�r
    addi $t2, $t2, 1    # �ndeksi bir art�r

    # Say�y� 10'a b�l
    mflo $t0            # B�l�m (bir sonraki basamak i�in)
    bnez $t0, basamaklari_ayir # Tam say� s�f�r de�ilse devam et

# Diziyi ters �evirme
    li $t5, 0               # Ba�lang�� indeksi
    add $t6, $t2, $zero     # Biti� indeksi (dizideki toplam eleman say�s�)
    sub $t6, $t6, 1         # Dizinin son eleman�na i�aret eden indeksi ayarla

ters_cevir:
    bge $t5, $t6, ters_cevir_son  # Ba�lang�� ve biti� kesi�irse d�ng�y� bitir

    # Ba�lang�� ve biti� elemanlar�n� takas et
    lb $t7, array($t5)      # Dizinin ba�lang��taki eleman�n� al
    lb $t8, array($t6)      # Dizinin sondaki eleman�n� al
    sb $t8, array($t5)      # Sondaki eleman� ba�a yaz
    sb $t7, array($t6)      # Ba�taki eleman� sona yaz

    # �ndeksleri g�ncelle
    addi $t5, $t5, 1        # Ba�lang�� indeksini bir ileri al
    addi $t6, $t6, -1       # Biti� indeksini bir geri al
    j ters_cevir            # D�ng�ye devam et

ters_cevir_son:
    # ��kt�
    li $v0, 4
    la $a0, msg
    syscall

    li $v0, 4
    la $a0, array
    syscall

    # Program� sonland�r
    li $v0, 10
    syscall
