;Abraham Barradas Cortes 21020361
;Diego Ibzan Rodriguez Garcia 21020446
; Definici?n del macro para mostrar mensajes
    despliega macro msg
        mov ah, 09H
        lea dx, msg
        int 21H
    endm

    ; Definici?n del macro para realizar la suma y mostrar el resultado
    sumadora macro numu, numd, msg
        mov bl, numu
        add bl, numd
        
        despliega msg ; Mostrar mensaje de resultado
        
        cmp bl, 10
        jb mostrar_un_digito
        
        ; Restar 10 para obtener el d?gito de las unidades y preparar el de las decenas
        mov ah, 02h
        sub bl, 10          ; Digito de las unidades
        mov dl, '1'         ; Digito de las decenas
        int 21h             ; Mostrar el '1' de las decenas
        
        mov ah, 02h
        add bl, '0'         ; Convertir el digito de las unidades de vuelta a ASCII
        mov dl, bl
        int 21h             ; Mostrar el digito de las unidades
        jmp fin
        
        mostrar_un_digito:
        mov ah, 02h
        add bl, '0' ; Convertir a ASCII
        mov dl, bl
        int 21h
        
    fin:
    endm

.model Small
.stack 64
.data

    HT EQU 09
    LF EQU 10
    CR EQU 13

    mensaje1 db CR, LF, 'Introduce el primer numero', CR, LF, '$'
    mensaje2 db CR, LF, 'Introduce el segundo numero', CR, LF, '$'
    mensaje3 db CR, LF, 'Resultado de la suma: ', CR, LF, '$'

    num1 db ?
    num2 db ?
    result db ?

.code

main proc NEAR
    mov ax, @data
    mov ds, ax

    ;----------------------------------
    despliega mensaje1
    mov ah, 01h
    int 21h
    sub al, '0' ; Convertir el car?cter introducido en n?mero
    mov num1, al

    despliega mensaje2
    mov ah,01h
    int 21h
    sub al, '0' ; Convertir el car?cter introducido en n?mero
    mov num2, al

    sumadora num1, num2, mensaje3

    ;----------------------------------

     ;-----
      ;SALIR DEL DOS
     ;-----
     mov ax, 4C00H
     int 21H
           
main ENDP
end main
