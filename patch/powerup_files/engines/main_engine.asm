includefrom "powerup.asm"

pushpc
    org $00D062|!bank
        autoclean jml main_engine
    main_engine_end:
        rts
pullpc

reset bytes

main_engine:
    ; reset a bunch of flags
.reset
    lda #$00
    sta !player_hitbox_flag                 ; Custom hitbox/hurtbox with sprites flag
    sta !player_collision_flag              ; Custom collision box with layer 1/2

.handle
    lda $19
    cmp #!max_powerup_num                   ; Force powerup number if the player exceeds the max amount
    bcc +                                   ; of powerups
    lda #!max_powerup_num
+	
    phb
    phk
    plb
    rep #$30
    and #$00FF                              ; prepare an indirect jump to the code
    asl
    tax
    lda.w powerup_code_pointers,x
    sta $00
    sep #$30
    ldx #$00
    jsr ($0000|!dp,x)
.return
    plb
    jml main_engine_end
    
powerup_code_pointers:
    !i #= 0
    while !i < !max_powerup_num
        %internal_number_to_string(!i)
        if stringsequal("!{powerup_!{_num}_path}", "0")
            dw main_engine_return
        else
            dw powerup_!{_num}_main
        endif
        !i #= !i+1
    endif
    
    !i #= 0
    while !i < !max_powerup_num
        %internal_number_to_string(!i)
        if not(stringsequal("!{powerup_!{_num}_path}", "0"))
            powerup_!{_num}_main: : incsrc "../!{powerup_!{_num}_path}/!{powerup_!{_num}_internal_name}_main_code.asm"
        endif
        !i #= !i+1
    endif
