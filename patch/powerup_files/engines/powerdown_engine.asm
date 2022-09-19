includefrom "powerup.asm"

pushpc

    org $00F5F3|!bank
        autoclean jsl powerdown
        rtl

pullpc

macro powerdown_shrink(power_num, sfx_num, sfx_port)
    lda.b #<sfx_num>
    sta.w <sfx_port>|!addr
    lda #$2F
    sta !player_animation_timer
    sta $9D
    lda #$01
    sta $71
    lda.b #<power_num>
    sta !player_powerup
    jsr redraw_player
endmacro

macro powerdown_smoke(power_num, sfx_num, sfx_port)
    lda.b #<sfx_num>
    sta.w <sfx_port>|!addr
    jsl $01C5AE|!bank
    inc $9D
    lda.b #<power_num>
    sta !player_powerup
    jsr hide_mario
endmacro

macro powerdown_palette(power_num, sfx_num, sfx_port)
    lda #$20
    sta $149B|!addr
    sta $9D
    lda #$04
    sta $71
    lda.b #<sfx_num>
    sta.w <sfx_port>|!addr
    stz $1407|!addr
    lda #$7F
    sta $1497|!addr
    lda.b #<power_num>
    sta !player_powerup
    jsr redraw_player
endmacro

reset bytes

hide_mario:
    phy
    lda #$FF
    sta $78
    jsl $00E2BD
    ply
    rts

redraw_player:
    phy
    jsl $00E2BD
    ply
    rts


powerdown:
    phx
    jsl $028008|!bank
    lda $19
    beq .return
    asl 
    tax 
    jsr (.actions,x)
.return
    plx 
    rtl

.actions
    !i #= 0
    while !i < !max_powerup_num
        %internal_number_to_string(!i)
        if stringsequal("!{powerup_!{_num}_path}", "0")
            dw powerdown_return
        else
            dw powerup_!{_num}_powerdown
        endif
        !i #= !i+1
    endif
    
.codes
    !i #= 0
    while !i < !max_powerup_num
        %internal_number_to_string(!i)
        if not(stringsequal("!{powerup_!{_num}_path}", "0"))
            powerup_!{_num}_powerdown:
                incsrc "../!{powerup_!{_num}_path}/!{powerup_!{_num}_internal_name}_powerdown_code.asm"
        endif
        !i #= !i+1
    endif
