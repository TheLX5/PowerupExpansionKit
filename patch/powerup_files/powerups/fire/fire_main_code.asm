;##################################################################################################
;# Powerup: Fire Mario
;# Author: Nintendo
;# Description: Default powerup $03 for Mario. Behaves exactly like the original game.
;#
;# This code is run every frame when Mario has this powerup.
    
    lda !player_crouching
    ora !player_climbing        ; skip if ducking, climbing, riding yoshi or floating
    ora !player_in_yoshi    
    ora !player_holding
    ora !player_carrying
    ora !player_wallrunning
    ora !player_crouching_yoshi
    bne .return

    bit $16                     ; check if pressing X/Y
    bvs .shoot_fireball

    lda !player_spinjump        ; check if spin jumping
    beq .return
    inc !player_spinjump_timer  ; spin jump shoot timer
    lda !player_spinjump_timer
    and #$0F
    bne .return                 ; shoot every 16 frames
    tay
    lda !player_spinjump_timer
    and #$10                    ; also change direction every 16 frames
    beq .change_dir
    iny
.change_dir
    sty !player_direction

.shoot_fireball
    ldx.b #!ExtendedSize+2-1
.find_slot
    lda !extended_num,x
    beq .found_slot
    dex
    cpx.b #(!ExtendedSize+2-1-!fireball_limit)
    bne .find_slot
.return
    rts

.found_slot
    lda.b #!fire_shoot_sfx
    sta !fire_shoot_sfx_port|!addr
    
    lda.b #!fire_pose_timer
    sta !player_shoot_pose_timer
    
    lda.b #!fireball_extended_num
    sta !extended_num,x
    lda !player_layer
    sta !extended_behind,x
    stz !extended_table,x

    ; store x/y speeds
    lda #$30
    sta !extended_y_speed,x
    ldy !player_direction
    lda.w .x_speeds,y
    sta !extended_x_speed,x

    ; compute x/y coords
    lda !player_in_yoshi
    beq .skip_disp
    iny #2
    lda $18DC|!addr
    beq .skip_disp
    iny #2
.skip_disp
    lda !player_x_low
    clc 
    adc.w .x_lo_disp,y
    sta !extended_x_low,x
    lda !player_x_high
    adc.w .x_hi_disp,y
    sta !extended_x_high,x
    lda !player_y_low
    clc 
    adc.w .y_lo_disp,y
    sta !extended_y_low,x
    lda !player_y_high
    adc #$00
    sta !extended_y_high,x

    rts

.x_speeds
    db $FD,$03

.x_lo_disp
    db $00,$08              ; Normal
    db $F8,$10              ; On Yoshi
    db $F8,$10              ; On Yoshi and ducking

.x_hi_disp
    db $00,$00              ; Normal
    db $FF,$00              ; On Yoshi
    db $FF,$00              ; On Yoshi and ducking

.y_lo_disp
    db $08,$08              ; Normal
    db $0C,$0C              ; On Yoshi
    db $14,$14              ; On Yoshi and ducking