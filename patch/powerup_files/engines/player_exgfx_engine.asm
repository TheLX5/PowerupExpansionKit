includefrom "powerup.asm"

pushpc
    org $00F636|!bank			;Mario ExGFX code.
        autoclean jml player_exgfx
    org $00E3E4|!bank
        BRA +
    org $00E3EC|!bank
    +
    org $00DFDA|!bank	;Mario8x8Tiles
        db $00,$20,$02,$22
pullpc

reset bytes

player_exgfx:
.compute_pointer
    rep #$30
    lda !player_graphics_index
    and #$00FF
    sta $00
    asl 
    clc 
    adc $00
    tax 
    lda $09
    clc 
    adc.l player_exgfx_pointers,x
    and #$0300
    sec 
    ror 
    pha 
    lda $09
    clc 
    adc.l player_exgfx_pointers,x
    and #$3C00
    asl 
    ora $01,s
    sta $0D85|!addr
    lda.l player_exgfx_pointers+2,x
    and #$00FF
    tay 
    bit $09
    bvc ..page_0
..page_1
    iny 
..page_0
    sty $0D87|!addr
    pla

    lda !player_graphics_extra_index
    and #$00FF
    sta $00
    asl 
    clc 
    adc $00
    tax 
    lda $0B
    and #$FF00
    lsr #3
    clc 
    adc.l player_extra_exgfx_pointers,x
    sta $0D89|!addr
    clc 
    adc #$0200
    sta $0D93|!addr
    sep #$30
    lda.l player_extra_exgfx_pointers+2,x
    sta $0D88|!addr

    lda #$0A
    sta $0D84|!addr

    jml $00F635|!bank
    
player_exgfx_pointers:
    !i #= 0
    while !i < !max_gfx_num
        %internal_number_to_string(!i)
        if stringsequal("!{gfx_!{_num}_path}", "0")
            dl player_exgfx_data
        else
            if !{gfx_!{_num}_gfx_exist} == 1
                dl gfx_!{_num}_graphics
            else
                dl player_exgfx_data
            endif
        endif
        !i #= !i+1
    endif

player_exgfx_data:
    !i #= 0
    while !i < !max_gfx_num
        %internal_number_to_string(!i)
        if not(stringsequal("!{gfx_!{_num}_path}", "0"))
            if !{gfx_!{_num}_gfx_exist} == 1
                incbin "../!{gfx_!{_num}_path}/!{gfx_!{_num}_internal_name}.bin" -> gfx_!{_num}_graphics
            endif
        endif
        !i #= !i+1
    endif

player_extra_exgfx_pointers:
    !i #= 0
    while !i < !max_gfx_num
        %internal_number_to_string(!i)
        if stringsequal("!{gfx_!{_num}_path}", "0")
            dl player_exgfx_extra_data
        else
            if !{gfx_!{_num}_extra_gfx_exist} == 1
                dl gfx_!{_num}_extra_graphics
            else
                dl player_exgfx_extra_data
            endif
        endif
        !i #= !i+1
    endif

player_exgfx_extra_data:
    !i #= 0
    while !i < !max_gfx_num
        %internal_number_to_string(!i)
        if not(stringsequal("!{gfx_!{_num}_path}", "0"))
            if !{gfx_!{_num}_extra_gfx_exist} == 1
                pushpc
                freedata
                    gfx_!{_num}_extra_graphics:
                        incbin "../!{gfx_!{_num}_path}/!{gfx_!{_num}_internal_name}_extra.bin"
                pullpc
            endif
        endif
        !i #= !i+1
    endif