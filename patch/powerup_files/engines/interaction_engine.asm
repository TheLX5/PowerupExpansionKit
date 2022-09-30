pushpc
    org $01A832|!bank
        autoclean jml sprite_custom_interaction
        
    org $03B664|!bank
        autoclean jml player_hitbox

    org $00EB77|!bank
        autoclean jml collision_ground
    org $00EB22|!bank
        autoclean jml collision_wallrun
        nop 
    org $00EBA7|!bank
        autoclean jsl collision_body_inside_fix
    org $00F453|!bank
        autoclean jsl collision_x_coords
    org $00F45B|!bank
        autoclean jsl collision_y_coords
pullpc

;################################################
;# Handles custom interaction code between sprites and specific powerup states

sprite_custom_interaction:
    phx
    lda !player_powerup
    asl    
    tax    
    rep #$20
    lda.l .powerup_custom_interaction_pointers,x
    sta $0E
    sep #$20
    plx 
    jmp ($000E|!dp)
        
.run_vanilla
    lda !167A,x
    bpl .default_interaction
.return_with_contact
    jml $01A837|!bank

.default_interaction
    jml $01A83B|!bank

.return_no_contact
    jml $01A7F5|!bank

.activate_custom

.powerup_custom_interaction_pointers
    !i #= 0
    while !i < !max_powerup_num
        %internal_number_to_string(!i)
        if stringsequal("!{powerup_!{_num}_path}", "0")
            dw .run_vanilla
        else
            dw powerup_!{_num}_sprite_custom_interaction
        endif
        !i #= !i+1
    endif

.powerup_custom_interaction_codes
    !i #= 0
    while !i < !max_powerup_num
        %internal_number_to_string(!i)
        if not(stringsequal("!{powerup_!{_num}_path}", "0"))
            powerup_!{_num}_sprite_custom_interaction:
                incsrc "../!{powerup_!{_num}_path}/!{powerup_!{_num}_internal_name}_sprite_interaction.asm"
        endif
        !i #= !i+1
    endif


;################################################
;# 

player_hitbox:
    lda !player_hitbox_flag
    beq .regular_logic
.custom_logic
    lda $94
    clc 
    adc !player_hitbox_disp_x+$00
    sta $00
    lda $95
    adc !player_hitbox_disp_x+$01
    sta $08
    lda $96
    clc 
    adc !player_hitbox_disp_y+$00
    sta $01
    lda $97
    adc !player_hitbox_disp_y+$01
    sta $09
    lda !player_hitbox_width
    sta $02
    lda !player_hitbox_height
    sta $03
    rtl 
.regular_logic
    phx
    phy
    rep #$30
    lda !player_powerup
    and #$007F
    asl #4
    tax
    tay  
    sep #$20
    lda $94
    clc 
    adc.l .hitbox_data,x
    sta $00
    lda $95
    adc.l .hitbox_data+$01,x
    sta $08
    lda.l .hitbox_data+$02,x
    sta $02
    lda !player_crouching
    beq .not_crouching
    inx #2
    iny  
.not_crouching
    lda !player_in_yoshi
    beq .not_in_yoshi
    inx #4
    iny #2
.not_in_yoshi
    lda $96
    clc 
    adc.l .hitbox_data+$03,x
    sta $01
    lda $97
    adc.l .hitbox_data+$04,x
    sta $09
    tyx 
    lda.l .hitbox_data+$03+$08,x
    sta $03
    sep #$10
    ply
    plx
    rtl
    
.hitbox_data
    !i #= 0
    while !i < !max_powerup_num
        %internal_number_to_string(!i)
        if stringsequal("!{powerup_!{_num}_path}", "0")
            dw $0002            ; X displacement
            db $0C              ; Width
            dw $0006            ; Y displacement
            dw $0014            ; Y displacement, crouching
            dw $0010            ; Y displacement, on Yoshi
            dw $0018            ; Y displacement, crouching on Yoshi
            db $1A              ; Height
            db $0C              ; Height, crouching
            db $20              ; Height, on Yoshi
            db $18              ; Height, crouching on Yoshi
            db $FF              ; Invalid data, do not use
        else
            dw !{powerup_!{_num}_hitbox_x_disp}                     ; X displacement
            db !{powerup_!{_num}_hitbox_width}                      ; Width
            dw !{powerup_!{_num}_hitbox_y_disp}                     ; Y displacement
            dw !{powerup_!{_num}_hitbox_y_disp_crouching}           ; Y displacement, crouching
            dw !{powerup_!{_num}_hitbox_y_disp_on_yoshi}            ; Y displacement, on Yoshi
            dw !{powerup_!{_num}_hitbox_y_disp_crouching_on_yoshi}  ; Y displacement, crouching on Yoshi
            db !{powerup_!{_num}_hitbox_height}                     ; Y displacement
            db !{powerup_!{_num}_hitbox_height_crouching}           ; Y displacement, crouching
            db !{powerup_!{_num}_hitbox_height_on_yoshi}            ; Y displacement, on Yoshi
            db !{powerup_!{_num}_hitbox_height_crouching_on_yoshi}  ; Y displacement, crouching on Yoshi
            db $FF                                                  ; Invalid data, do not use
        endif
        !i #= !i+1
    endif


;################################################
;# Custom collision between Mario<->Layers.

collision_ground:
    lda !player_collision_flag
    bne +
    ldx #$00
    lda !player_powerup
    jml $00EB7B|!bank
+    
    lda !player_collision_index
    tax 
    cmp #$FF
    bne .return
    inx
    lda !player_crouching
    beq +
    txa 
    clc
    adc #$18
    tax    
+        
    jml $00EB83|!bank   
.return    
    jml $00EBAF|!bank


;################################################
;# 
  
collision_wallrun:
    lda !player_collision_flag
    bne .custom
.original_code    
    ldx #$60
    tya                    ;Recover original code
    beq .return
    ldx #$66
.return    
    jml $00EB29|!bank
.custom    
    lda !player_collision_index
    tax 
    cmp #$FF                ;Check if we are using the built in routine
    bne .return
    bra .original_code


;################################################
;# 

collision_body_inside_fix:
    pha    
    lda !player_collision_flag            ;Are we using a custom collision?
    bne .handle_custom
    pla 
    clc    
    adc.w $E8A4,x
    rtl
.handle_custom    
    cmp #$FF
    beq .handle_indirect        ;Are we using indirect loading?
    pla
    clc
    adc.l !player_collision_data_y-$02+$08,x    ;Handle RAM tables.
    rtl
.handle_indirect
    lda !player_collision_pointer_y
    clc
    adc #$08
    sta $00
    lda !player_collision_pointer_y+$01
    adc #$00
    sta $01
    lda !player_collision_pointer_y+$02
    sta $02
    txy
    pla 
    clc 
    adc [$00],y
    rtl


;################################################
;# Get collision data for the X coordinates
        
collision_x_coords:    
    pha
    lda !player_collision_flag            ;Are we using a custom collision?
    and #$00FF
    bne .handle_custom
    pla                 ;Recover original code.
    clc
    adc.w $E830,x
    rtl
.handle_custom    
    cmp #$00FF
    beq .handle_indirect        ;Are we using indirect loading?
    pla 
    clc
    adc.l !player_collision_data_x-$02,x    ;Handle RAM tables.
    rtl 
.handle_indirect
    sty $03
    lda !player_collision_pointer_x
    sta $00
    lda !player_collision_pointer_x+$01
    sta $01
    txy 
    pla
    clc 
    adc [$00],y
    ldy $03
    rtl


;################################################
;# Get collision data for the Y coordinates
        
collision_y_coords:
    pha    
    lda !player_collision_flag            ;Are we using a custom collision?
    and #$00FF
    bne .handle_custom
    pla 
    clc    
    adc.w $E89C,x
    rtl
.handle_custom    
    cmp #$00FF
    beq .handle_indirect        ;Are we using indirect loading?
    pla
    clc
    adc.l !player_collision_data_y-$02,x    ;Handle RAM tables.
    rtl
.handle_indirect
    sty $03
    lda !player_collision_pointer_y
    sta $00
    lda !player_collision_pointer_y+$01
    sta $01
    txy
    pla 
    clc 
    adc [$00],y
    ldy $03
    rtl

