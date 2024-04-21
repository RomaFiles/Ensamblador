.model small
.stack 64
; Macro para limpiar ventana
clear_s MACRO
    mov ah, 06h
    mov al, 0      ; borra la pantalla
    xor bh, bh     ; pagina de pantalla a borrar
    mov cx, 0      ; columna
    mov dx, 184Fh  ; fila
    int 10h        ; llamada a BIOS
ENDM
; Macro para menu inicial
menu MACRO params
    mov ah, 09h
    lea dx, msg_bienvenida
    int 21h

    mov ah, 09h
    lea dx, msg_menu_jugar
    int 21h

    mov ah, 09h
    lea dx, msg_menu_salir
    int 21h

ENDM

.data
    msg_bienvenida db 'Bienvenido al juego', 0Dh, 0Ah, '$'
    msg_menu_jugar db 'Jugar', 0Dh, 0Ah, '$'
    msg_menu_salir db 'Salir', 0Dh, 0Ah, '$'

.code

    main proc NEAR
        mov ax, @data
        mov ds, ax

        ; Macro para limpiar terminal
        ;clear_s
        ; Macro para menu inicial
        menu

        ; Salir del DOS
        mov ah, 4Ch
        int 21h
    main ENDP
end main
