pushpc

    org $009079
        item_box_write_hijack:
            %invoke_sa1_powerups(item_box_write)
            rts 

pullpc 

    item_box_write: 
        ldy #$E0 
        bit $0D9B|!addr
        bvc .no_special
        ldy #$00
        lda $0D9B|!addr
        cmp #$C1 
        beq .no_special 
        lda #$F0 
        sta $0201|!addr,y
    .no_special
        ldx $0DC2|!addr
        beq .return
        lda.l item_box_graphics-1,x
        jsl find_and_queue_gfx
        lda !dss_tile_buffer+$00
        sta $0202|!addr,y
        lda.l item_box_props-1,x
        cpx #$03
        bne .not_star
        lda $13
        lsr 
        and #$03
        tax 
        lda.l item_box_star_props,x
    .not_star
        ora #$31
        sta $0203|!addr,y
        lda #$78
        sta $0200|!addr,y
        lda #$0F
        sta $0201|!addr,y
        tya 
        lsr #2
        tay 
        lda #$02
        sta $0420|!addr,y
    .return
        rtl 
    
        item_box_graphics:
            db !dss_id_mushroom
            db !dss_id_fire_flower
            db !dss_id_star
            db !dss_id_feather
        
        item_box_props:
            db $08,$0A,$00,$04
        item_box_star_props:
            db $00,$02,$04,$02