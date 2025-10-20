section .data
BP_AXE_NAME: db "Axe",0
BP_AXE_NAME_LEN: equ $-BP_AXE_NAME
BP_AXE_WEIGHT: db 5 ; Axe weighs 5kg 

BP_PISTOL_NAME: db "Pistol",0
BP_PISTOL_NAME_LEN: equ $-BP_PISTOL_NAME
BP_PISTOL_WEIGHT: db 1

section .bss
backpack:         resd 10 ; Backpack memory allocation, 10 items
backpack_offset:  resb 1

section .text

backpack_init:
  ; Init backpack offset
  mov byte [backpack_offset], 0
  
  mov ecx, 9
  lea edi, backpack
  call backpack_clear_all
  ret

backpack_clear_all:
  ; Init all backpack items to 0x00
  mov word [edi], 0x00
  inc edi
  loop backpack_clear_all

  ret

backpack_item_by_name: ; Return address of item by BP_x_NAME
  mov ecx, BP_AXE_NAME_LEN
  mov edi, BP_AXE_NAME
  lea esi, [esp + 4]
  repe cmpsb
  jecxz backpack_item_by_name_equal_axe

  mov ecx, BP_PISTOL_NAME_LEN
  mov edi, BP_PISTOL_NAME
  lea esi, [esp + 4]
  repe cmpsb
  jecxz backpack_item_by_name_equal_pistol

  mov dword [esp + 8], 0x00
  ret

backpack_item_by_name_equal_axe:
  mov dword [esp + 8], BP_AXE_NAME
  ret
backpack_item_by_name_equal_pistol:
  mov dword [esp + 8], BP_PISTOL_NAME
  ret

backpack_add: ; void add(char* item)
  mov ebx, [esp + 4]
  lea eax, backpack 
  add eax, [backpack_offset]
  mov [eax], ebx  
  inc byte [backpack_offset]
  ret
