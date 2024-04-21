;Abraham Barradas Cortes 21020361
;Diego Ibzan Rodriguez Garcia 21020446
           despliega macro msg
           mov ah, 09H   
           lea dx, msg
           int 21H
           ENDM
           
.model Small
.stack 64
.data

           HT EQU 09
           LF EQU 10
           CR EQU 13
           
           mensaje1 db 'HOLA!!!! como tan?', '$'
           mensaje2 db CR, LF, 'Este soy yo Abrahams', '$'
           
           .code
             
           main proc NEAR
           mov ax, @data
           mov ds, ax
           
           ;------------------------------
             
           despliega mensaje1
           despliega mensaje2
           
           ;--------------------------------
           
       
           
      
           ;-----
           ;SALIR DEL DOS
           ;-----
           mov ax, 4C00H
           int 21H
           
           main ENDP
          end main