.data
array: .space 40         # Basamaklarý depolamak için boþluk (40 bayt)
msg: .asciiz "Basamaklar: "

.text
.globl main

main:
    # Tam sayý girin
    li $t0, 12345        # Üzerinde iþlem yapýlacak tam sayý

    # Adresi ve indeksi ayarla
    la $t1, array        # Dizinin baþlangýç adresi
    li $t2, 0            # Dizi indeksi

basamaklari_ayir:
    # Tam sayýnýn 10'a bölümünden kalaný al ve diziye ekle
    li $t3, 10
    div $t0, $t3
    mfhi $t4             # Kalaný al (son basamak)
    sw $t4, 0($t1)       # Dizinin bir sonraki adresine yaz (4 bayt)

    addi $t1, $t1, 4     # Dizi adresini 4 bayt ileri kaydýr
    addi $t2, $t2, 1     # Ýndeksi bir artýr

    # Sayýyý 10'a böl
    mflo $t0             # Bölüm (bir sonraki basamak için)
    bnez $t0, basamaklari_ayir # Tam sayý sýfýr deðilse devam et

    # Diziyi ters çevirme
    li $t5, 0                # Baþlangýç indeksi
    sub $t6, $t2, 1          # Dizinin son elemanýna iþaret eden indeksi ayarla

ters_cevir:
    bge $t5, $t6, ters_cevir_son # Baþlangýç ve bitiþ kesiþirse döngüyü bitir

    # Baþlangýç ve bitiþ elemanlarýný takas et
    mul $t7, $t5, 4           # 4 baytlýk kaydýrma (baþlangýç)
    mul $t8, $t6, 4           # 4 baytlýk kaydýrma (bitiþ)
    lw $t9, array($t7)        # Dizinin baþlangýçtaki elemanýný al
    lw $t10, array($t8)       # Dizinin sondaki elemanýný al
    sw $t10, array($t7)       # Sondaki elemaný baþa yaz
    sw $t9, array($t8)        # Baþtaki elemaný sona yaz

    # Ýndeksleri güncelle
    addi $t5, $t5, 1          # Baþlangýç indeksini bir ileri al
    addi $t6, $t6, -1         # Bitiþ indeksini bir geri al
    j ters_cevir              # Döngüye devam et

ters_cevir_son:
    # Çýktý
    li $v0, 4
    la $a0, msg
    syscall

    li $v0, 1               # Basamaklarý tek tek ekrana yazdýrmak için döngü
    li $t5, 0

print_loop:
    bge $t5, $t2, end       # Tüm basamaklar yazýldýysa çýk
    mul $t7, $t5, 4         # 4 baytlýk kaydýrma
    lw $a0, array($t7)      # Diziden sayýyý al
    syscall                 # Yazdýr

    addi $t5, $t5, 1        # Sonraki basamaða geç
    j print_loop            # Döngüye devam et

end:
    # Programý sonlandýr
    li $v0, 10
    syscall
