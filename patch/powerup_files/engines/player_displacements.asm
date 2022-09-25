;################################################
;# Handles displacing water splashes

pushpc
    org $00FDB4|!bank
        jml expand_water_splash_1
    org $00FDD6|!bank
        jml expand_water_splash_2
pullpc

expand_water_splash_1:
	phx
    rep #$20
	lda !player_powerup
    and #$7F
    asl #2
    ldx !player_in_yoshi
    beq .not_on_yoshi
    ora #$0002
.not_on_yoshi
    rep #$10
    tax 
    sep #$20
    lda !player_y_pos
    clc 
    adc.l water_splash_y_disp,x
    jml $00FDC9|!bank

expand_water_splash_2:
    plp 
    adc.l water_splash_y_disp+$01,x
    sep #$10
    jml $00FDDA|!bank

water_splash_y_disp:
    !i #= 0
    while !i < !max_powerup_num
        %internal_number_to_string(!i)
        if not(stringsequal("!{powerup_!{_num}_path}", "0"))
            dw !{powerup_!{_num}_water_y_disp}
            dw !{powerup_!{_num}_water_y_disp_on_yoshi}
        else
            dw $0010
            dw $0004
        endif
        !i #= !i+1
    endif