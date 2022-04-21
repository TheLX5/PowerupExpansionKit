pushpc

    org $009079
        item_box_write_hijack:
            if !disable_item_box == !no
                %invoke_sa1(item_box_write)
            endif
            rts 

pullpc 

if !disable_item_box == !no
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
        lda.l item_box_page-1,x
        xba 
        lda.l item_box_graphics-1,x
        jsl find_and_queue_gfx
        bcc .return
        ldx $0DC2|!addr
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
        lda #!item_box_item_x_pos
        sta $0200|!addr,y
        lda #!item_box_item_y_pos
        sta $0201|!addr,y
        tya 
        lsr #2
        tay 
        lda #$02
        sta $0420|!addr,y
    .return
        rtl 
    
    item_box_graphics:
    !i #= 0
    while !i < !max_item_num
        %internal_number_to_string(!i)
        if not(stringsequal("!{item_!{_num}_path}", "0"))
            db !{item_!{_num}_dss_id}
        else
            db $FF
        endif
        !i #= !i+1
    endif

    item_box_page:
    !i #= 0
    while !i < !max_item_num
        %internal_number_to_string(!i)
        if not(stringsequal("!{item_!{_num}_path}", "0"))
            db !{item_!{_num}_dss_page}
        else
            db $FF
        endif
        !i #= !i+1
    endif

    item_box_props:
        !i #= 0
        while !i < !max_item_num
            %internal_number_to_string(!i)
            if not(stringsequal("!{item_!{_num}_path}", "0"))
                db !{item_!{_num}_sprite_prop}
            else
                db $FF
            endif
            !i #= !i+1
        endif

    item_box_star_props:
        db $00,$02,$04,$02

endif

find_and_queue_gfx:
    pha 
    xba
    and #$01
    beq +
    lda #$03
+   
    tax 
    lda.l $01DF78+3+2,x
    sta $00
    lda.l $01DF78+3+2+1,x
    sta $01
    lda.l $01DF78+3+2+2,x
    sta $02
    pla 
    jml [!dp]