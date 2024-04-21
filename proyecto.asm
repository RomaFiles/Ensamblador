.model small
.stack 64

.data
    posicion_menu db 1  ; Variable para almacenar la posición actual en el menú

    msg_bienvenida db 'Bienvenido al juego', 0Dh, 0Ah, '$'
    msg_menu_jugar db 'Jugar', 0Dh, 0Ah, '$'
    msg_menu_salir db 'Salir', 0Dh, 0Ah, '$'
    msg_menu_jugar_resaltado db '> Jugar', 0Dh, 0Ah, '$'  ; Opción resaltada para "Jugar"
    msg_menu_salir_resaltado db '> Salir', 0Dh, 0Ah, '$'  ; Opción resaltada para "Salir"

.code
    ; Subrutina para limpiar ventana
    ;clear_s PROC
    ;    mov ah, 06h
    ;    mov al, 0      ; borra la pantalla
    ;    xor bh, bh     ; pagina de pantalla a borrar
    ;    mov cx, 0      ; columna
    ;    mov dx, 184Fh  ; fila
    ;    int 10h        ; llamada a BIOS
    ;    ret
    ;clear_s ENDP

    ; Subrutina para imprimir el menú según la posición actual
    imprimir_menu PROC
        ;call clear_s

        mov ah, 09h
        lea dx, msg_bienvenida
        int 21h

        ; Verificar la posición actual y resaltar la opción correspondiente
        cmp posicion_menu, 1
        je imprimir_jugar
        jmp imprimir_salir

    imprimir_jugar:
        mov ah, 09h
        lea dx, msg_menu_jugar_resaltado
        int 21h
        jmp fin_imprimir_menu

    imprimir_salir:
        mov ah, 09h
        lea dx, msg_menu_salir_resaltado
        int 21h

    fin_imprimir_menu:
        ret
    imprimir_menu ENDP

    ; Subrutina para procesar la tecla presionada
    procesar_tecla PROC
        mov ah, 00h
        int 16h   ; Leer tecla presionada

        cmp al, 48h  ; Tecla de flecha arriba
        je mover_arriba
        cmp al, 50h  ; Tecla de flecha abajo
        je mover_abajo
        ret

    mover_arriba:
        cmp posicion_menu, 1
        jne no_cambiar_posicion_arriba
        jmp fin_procesar_tecla

    no_cambiar_posicion_arriba:
        dec posicion_menu
        jmp fin_procesar_tecla

    mover_abajo:
        cmp posicion_menu, 2
        jne no_cambiar_posicion_abajo
        jmp fin_procesar_tecla

    no_cambiar_posicion_abajo:
        inc posicion_menu

    fin_procesar_tecla:
        ret
    procesar_tecla ENDP

    ; Subrutina para mostrar el menú y manejar la interacción
    menu_principal PROC
        mov ax, @data
        mov ds, ax

        ; Mostrar el menú al inicio
        call imprimir_menu

        bucle_menu:
            ; Procesar la tecla presionada
            call procesar_tecla

            ; Volver a imprimir el menú después de procesar la tecla
            call imprimir_menu

            ; Salir del bucle si se presionó la tecla "Salir" (posición_menu = 2)
            cmp posicion_menu, 2
            je fin_menu

            jmp bucle_menu

        fin_menu:
            ret
    menu_principal ENDP

    main PROC
        ; Llamar a la subrutina que maneja el menú principal
        call menu_principal

        ; Salir del programa
        mov ah, 4Ch
        int 21h
    main ENDP

end main
