includefrom "powerup.asm"

pushpc
    org $00E3FB|!bank
        autoclean jml cape_image
pullpc

reset bytes

cape_image:
    lda !player_extra_tile_settings
    bmi .cape_image
    lsr
    bcs .custom_tile
.hide_cape
    jml $00E458|!bank
.cape_image
    jml $00E401|!bank
    
.custom_tile
    lsr $78
    bcs .hide_cape
    lda !player_extra_tile_frame
    sta $0C
    lda #$04
    sta $0302|!addr,y
    rep #$20
    lda $80
    clc
    adc !player_extra_tile_offset_y
    pha
    clc
    adc #$0010
    cmp #$0100
    pla
    sep #$20
    bcs .no_draw
    sta $0301|!addr,y
    rep #$20
    lda $7E
    clc
    adc !player_extra_tile_offset_x
    pha
    clc
    adc #$0080
    cmp #$0200
    pla
    sep #$20
    bcs .no_draw
    sta $0300|!addr,y
    xba
    lsr
.no_draw
    php
    tya
    lsr #2
    tax
    rol
    plp
    and #$03
    ora #$02
    sta $0460|!addr,x
.end
    iny #4
    inc $05
    inc $05 
    jml $00E458|!bank