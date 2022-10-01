pushpc

    org $009079
        item_box_write_hijack:
            if !disable_item_box == !no
                %invoke_sa1(item_box_write)
            endif
            rts 

    org $028008
        item_box_drop_hijack:
            if !disable_item_box == !no
                autoclean jsl item_box_drop_main
            endif
            rtl
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

item_box_drop_main:
    lda !player_item_box
    bne .item
.no_item
    rtl
.item 
    phb 
    phk 
    plb 
    phx 
    dec 
    sta $0E
    stz $0F
    if !item_box_drop_sfx != $00
        lda.b #!item_box_drop_sfx
        sta !item_box_drop_port|!addr
    endif
    jsr .process
    stz !player_item_box
    plx 
    plb 
    rtl 

.process
    rep #$30
    lda $0E
    and #$007F
    asl 
    tay 
    lda.w .item_ptrs,y
    sta $00
    sep #$30
    jmp (!dp)

.return
    rts 

.item_ptrs
    !i #= 0
    while !i < !max_item_num
        %internal_number_to_string(!i)
        if not(stringsequal("!{item_!{_num}_path}", "0"))
            dw item_!{_num}_give_item_box_drop
        else
            dw item_box_drop_main_return
        endif
        !i #= !i+1
    endif

find_and_queue_gfx:
    phx
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
    plx
    jml [!dp]

spawn_item:
    jsr find_sprite_slot
    phx 
    txy 
    lda #$00
    xba 
    lda $0E
    sta !extra_byte_1,x
    jsr goal_tape_item_get_pointer
    plx
    lda #$08
    sta !14C8,x 
    lda.b #!item_box_spawn_x_pos
    clc 
    adc $1A
    sta !E4,x
    lda $1B
    adc #$00
    sta !14E0,x
    lda.b #!item_box_spawn_y_pos
    clc
    adc $1C
    sta !D8,x
    lda $1D
    adc #$00
    sta !14D4,x
    rts 


find_sprite_slot:
    ldx.b #!SprSize-1
.loop
    lda !14C8,x
    beq .found_slot
    dex 
    bpl .loop
    dec $1861|!addr
    bpl .force_slot
    lda #$01
    sta $1861|!addr
.force_slot
    lda $1861|!addr
    clc 
    adc #$0A
    tax 
    lda !9E,x
    cmp #$7D
    bne .found_slot
    lda !14C8,x
    cmp #$0B
    bne .found_slot
    stz $13F3|!addr
.found_slot
    rts 