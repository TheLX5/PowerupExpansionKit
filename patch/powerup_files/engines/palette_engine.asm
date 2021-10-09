includefrom "powerup.asm"

pushpc
org $00E31A|!bank
    autoclean jml custom_palettes

org $00E30C|!bank
    autoclean jml custom_palettes_star

org $00E326|!bank
    custom_palettes_return:
pullpc

reset bytes

custom_palettes:
    lda !player_palette_bypass
    bne .bypass
.regular_colors
    rep #$20
    lda !player_powerup
    and #$00FF
    ldx !player_num
    beq .p1
    clc 
    adc.w #!max_powerup_num
.p1 
    rep #$10
    tax 
    sep #$20
    lda.l custom_palettes_indexes,x
    cmp #$FF
    bne +
    lda !player_graphics_index
+   
    sta !player_palette_index
.bypass
    rep #$30
    lda !player_palette_index
    and #$00FF
    sta $00
    asl 
    clc 
    adc $00
    tax
    lda.l custom_palettes_pointers,x
    sta !player_palette_pointer
    lda.l custom_palettes_pointers+1,x
.end
    sta !player_palette_pointer+1
    sep #$30
    jml custom_palettes_return

.star
    and #$03
    sta $00
    asl 
    clc 
    adc $00
    tax
    rep #$20
    lda.l custom_star_palettes_pointers,x
    sta !player_palette_pointer
    lda.l custom_star_palettes_pointers+1,x
    bra .end

custom_palettes_pointers:
    !i #= 0
    while !i < !max_gfx_num
        %internal_number_to_string(!i)
        if stringsequal("!{gfx_!{_num}_path}", "0")
            dl custom_palettes_data
        else
            if !{gfx_!{_num}_palette_exist} == 1
                dl gfx_!{_num}_palette
            else
                dl custom_palettes_data
            endif
        endif
        !i #= !i+1
    endif

custom_palettes_data:
    !i #= 0
    while !i < !max_gfx_num
        %internal_number_to_string(!i)
        if not(stringsequal("!{gfx_!{_num}_path}", "0"))
            if !{gfx_!{_num}_palette_exist} == 1
                gfx_!{_num}_palette:
                    incbin "../!{gfx_!{_num}_path}/!{gfx_!{_num}_internal_name}.mw3":(!palette_transfer_start*2)-(1+!palette_transfer_end*2)
            endif
        endif
        !i #= !i+1
    endif

custom_palettes_indexes:
.player_1
    !i #= 0
    while !i < !max_powerup_num
        %internal_number_to_string(!i)
        if not(stringsequal("!{powerup_!{_num}_path}", "0"))
            db !{powerup_!{_num}_p1_palette_index}
        else
            db $FF
        endif
        !i #= !i+1
    endif
.player_2
    !i #= 0
    while !i < !max_powerup_num
        %internal_number_to_string(!i)
        if not(stringsequal("!{powerup_!{_num}_path}", "0"))
            db !{powerup_!{_num}_p2_palette_index}
        else
            db $FF
        endif
        !i #= !i+1
    endif

custom_star_palettes_pointers:
    dl star_palette_frame_0
    dl star_palette_frame_1
    dl star_palette_frame_2
    dl star_palette_frame_3

custom_star_palettes_data:
    star_palette_frame_0:
;        incbin "star_palette_frame_0.bin":(!palette_transfer_start*2)-(1+!palette_transfer_end*2)
    star_palette_frame_1:
;        incbin "star_palette_frame_1.bin":(!palette_transfer_start*2)-(1+!palette_transfer_end*2)
    star_palette_frame_2:
;        incbin "star_palette_frame_2.bin":(!palette_transfer_start*2)-(1+!palette_transfer_end*2)
    star_palette_frame_3:
;        incbin "star_palette_frame_3.bin":(!palette_transfer_start*2)-(1+!palette_transfer_end*2)
