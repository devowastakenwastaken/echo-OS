[org 0x7c00]
    xor ax, ax      ; Clear ax
    mov ds, ax      ; Set data segment to 0
    mov es, ax      ; Set extra segment to 0
    mov si, msg     ; Set si to point to the message
    call print      ; Call print function
    jmp $           ; Infinite loop

print:
    lodsb           ; Load character from si into al
    or al, al       ; Check for null terminator
    jz done         ; If null terminator, jump to done
    mov ah, 0x0e    ; Set teletype mode
    int 0x10        ; Call BIOS interrupt to print character
    jmp print       ; Loop back to print next character
done:
    ret

msg:
    db "Hello, World!", 0 ; Null-terminated message string

times 510-($-$$) db 0 ; Fill the rest of the sector with 0s
dw 0xaa55 ; Boot signature

; To run, do:
; nasm -f bin bootloader.asm -o bootloader.bin
; dd if=bootloader.bin of=bootdisk.img bs=512 count=1 conv=notrunc
; qemu-system-x86_64 -drive format=raw,file=bootloader.bin
