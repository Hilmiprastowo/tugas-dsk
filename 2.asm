org 100h
jmp start       


msg_start:  db      0dh,0ah,"===========================================================$",0dh,0ah,
msg0:       db      0dh,0ah,"============SELAMAT DATANG DI PENGHITUNG VOLUME============$",0dh,0ah,
msg1:       db      0dh,0ah,"===========================================================",0dh,0ah,'$'
pilih:      db      0dh,0ah,"Pilih :",0dh,0ah,'$'
msg:        db      "1-Tabung",0dh,0ah,"2-Kubus",0dh,0ah,"3-Kerucut",0dh,0ah, '$'
msg2:       db      0dh,0ah,"Masukkan Tinggi(cm): $"
msg3:       db      0dh,0ah,"Masukkan panjang(cm): $"
msg4:       db      0dh,0ah,"Kesalahan dalam Pemilihan $" 
msg5:       db      0dh,0ah,"Hasil : $" 
msg6:       db      0dh,0ah ,"TerimaKasih telah menggunakan Penghitung volume ini $", 
msg7:       db      0dh,0ah ,"Tekan ENTER untuk keluar dari Program... $"


start:      
            mov ah,9
            mov dx, offset msg_start
            int 21h
            mov ah,9
            mov dx, offset msg0
            int 21h
            mov ah,9
            mov dx, offset msg1 
            int 21h
            mov ah,9
            mov dx, offset msg 
            int 21h
            mov ah,9
            mov dx, offset pilih 
            int 21h            
            mov ah,0                       
            int 16h  
            cmp al,31h 
            je Tabung
            cmp al,32h
            je Kubus
            cmp al,33h
            je Kerucut
            cmp al,34h
            mov ah,09h
            mov dx, offset msg4
            int 21h
            mov ah,0
            int 16h
            jmp start
        
Tabung:   
            mov ah,9  
            mov dx, offset msg2  
            int 21h
            mov cx,0 
            call InputNo  
            push dx
            mov ah,9
            mov dx, offset msg3
            int 21h 
            mov cx,0
            call InputNo
            pop bx
            add dx,bx
            push dx 
            mov ah,9
            mov dx, offset msg5
            int 21h
            mov cx,10000
            pop dx
            call View 
            jmp Keluar
            
InputNo:    
            mov ah,0
            int 16h   
            mov dx,0  
            mov bx,1 
            cmp al,0dh 
            je FormNo 
            sub ax,30h 
            call ViewNo 
            mov ah,0 
            push ax  
            inc cx   
            jmp InputNo           
   


FormNo:     
            pop ax  
            push dx      
            mul bx
            pop dx
            add dx,ax
            mov ax,bx      
            mov bx,10
            push dx
            mul bx
            pop dx
            mov bx,ax
            dec cx
            cmp cx,0
            jne FormNo
            ret   
       
       
View:       mov ax,dx
            mov dx,0
            div cx 
            call ViewNo
            mov bx,dx 
            mov dx,0
            mov ax,cx 
            mov cx,10
            div cx
            mov dx,bx 
            mov cx,ax
            cmp ax,0
            jne View
            ret


ViewNo:     push ax 
            push dx 
            mov dx,ax 
            add dl,30h 
            mov ah,2
            int 21h
            pop dx  
            pop ax
            ret

                       
Kubus:   
            mov ah,9
            mov dx, offset msg2
            int 21h
            mov cx,0
            call InputNo
            push dx
            mov ah,9
            mov dx, offset msg3
            int 21h 
            mov cx,0
            call InputNo
            pop bx
            mov ax,dx
            mul bx 
            mov dx,ax
            push dx 
            mov ah,9
            mov dx, offset msg5
            int 21h
            mov cx,10000
            pop dx
            call View 
            jmp Keluar 


Kerucut:   
            mov ah,9
            mov dx, offset msg2
            int 21h
            mov cx,0
            call InputNo
            push dx
            mov ah,9
            mov dx, offset msg3
            int 21h 
            mov cx,0
            call InputNo
            pop bx
            sub bx,dx
            mov dx,bx
            push dx 
            mov ah,9
            mov dx, offset msg5
            int 21h
            mov cx,10000
            pop dx
            call View 
            jmp Keluar 
    
            

Keluar:     
            mov ah,9
            mov dx, offset msg6
            int 21h
            mov dx,offset msg7  
            mov ah, 9
            int 21h  
            mov ah, 0
            int 16h
            ret