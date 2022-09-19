pushpc
    org $01C353|!bank
        item_engine_main_hijack:
            jml item_engine_main
    
    org $01C344|!bank
        item_return:

    org $01C538|!bank
        give_item_handler_hijack:
            jml give_item_handler
    org $01C560|!bank
        give_item_return:

    org $02ACE5|!bank
        give_points:


pullpc

item_engine_main:
    lda !item_berry_flag,x
    beq .not_berry
    jml $01C358|!bank

.not_berry
    lda !item_roulette_flag,x             ; not a roulette
    bne .not_fire_flower
    lda !extra_bits,x
    and #$04                ; nor a custom item
    bne .not_fire_flower
    lda !9E,x
    cmp #$75                ; nor an actual fire flower
    bne .not_fire_flower
.fire_flower
    lda $14
    and #$08
    lsr #3
    sta !item_direction,x
.not_fire_flower

.get_pointer
    lda #$00
    xba 
    lda #$00
    ldy !9E,x
    cpy #$21
    beq .calculate_pointer
    lda !extra_bits,x
    and #$04                ; not a custom item
    beq .not_custom
.custom 
    lda !extra_byte_1,x
    and #$7F
    cmp.b #!max_item_num+1
    bcc .no_overflow
    lda #$00
    bra .calculate_pointer
.no_overflow
    clc 
    adc #$05
    bra .calculate_pointer
.not_custom
    lda !9E,x
    sec 
    sbc #$74
    inc
.calculate_pointer
    rep #$30
    sta $00
    asl 
    clc 
    adc $00
    tax 
    lda.l .ptrs,x
    sta $00
    sep #$20
    lda.l .ptrs+2,x
    sta $02
    pha 
    plb 
    sep #$10
    ldx $15E9|!addr
    jml [!dp]

.ptrs
    dl $01C371|!bank        ; moving coin
    !i #= 0
    while !i < !max_item_num
        %internal_number_to_string(!i)
        if not(stringsequal("!{item_!{_num}_path}", "0"))
            dl item_!{_num}_main
        else
            dl $01C371|!bank
        endif
        !i #= !i+1
    endif

.codes
    !i #= 0
    while !i < !max_item_num
        %internal_number_to_string(!i)
        if not(stringsequal("!{item_!{_num}_path}", "0"))
            item_!{_num}_main: : incsrc "../!{item_!{_num}_path}/!{item_!{_num}_internal_name}_main_code.asm"
        endif
        !i #= !i+1
    endif

give_item_handler:
    lda !extra_bits,x
    and #$04                ; not a custom item
    beq .not_custom
.custom 
    lda !extra_byte_1,x
    and #$7F
    cmp.b #!max_item_num+1
    bcc .no_overflow
    lda #$00
    bra .calculate_pointer
.no_overflow
    clc 
    adc #$05
    bra .calculate_pointer
.not_custom
    lda !9E,x
    sec 
    sbc #$74
.calculate_pointer
    and #$7F
    phb 
    phk 
    plb 
    jsr give_powerup
    plb
    jml give_item_return

default_item:
do_nothing:
    if !default_collected_sfx_num != $00
        lda.b #!default_collected_sfx_num
        sta.w !default_collected_sfx_port|!addr
    endif
    if !default_can_give_points == !yes
        lda.b #!default_collected_points
        ldy !item_falling,x
        bne .from_item_box
        jsl give_points
    .from_item_box
    endif
    rts


give_powerup:
    sta $05                             ; current item number
    rep #$30
    and #$00FF
    asl 
    tax 
    lda.w .main_ptrs,x                  ; get pointer for "give item" routine
    sta $00
    sep #$30
    ldy $05
    lda.w .item_box_put_in_box,y
    beq .skip_box
    rep #$30
    lda $05
    and #$00FF
    asl 
    tax 
    lda.w .item_box_ptrs,x              ; get pointer for "put powerup in item box" routine
    sta $02
    sep #$30
    ldy !player_powerup
    ldx #$00
    jsr ($0002|!dp,x)                   ; run item box code
.skip_box
    ldx $15E9|!addr
    jmp ($0000|!dp)                     ; run "give item" code

.item_box_index
    !i #= 0
    while !i < !max_powerup_num
        %internal_number_to_string(!i)
        if not(stringsequal("!{powerup_!{_num}_path}", "0"))
            db !{powerup_!{_num}_item_id}
        else
            db $FF
        endif
        !i #= !i+1
    endif

.item_box_put_in_box
    !i #= 0
    while !i < !max_item_num
        %internal_number_to_string(!i)
        if not(stringsequal("!{item_!{_num}_path}", "0"))
            db !{item_!{_num}_put_in_box}
        else 
            db !no
        endif
        !i #= !i+1
    endif

.main_ptrs
    !i #= 0
    while !i < !max_item_num
        %internal_number_to_string(!i)
        if not(stringsequal("!{item_!{_num}_path}", "0"))
            dw item_!{_num}_give_collected
        else
            dw do_nothing_from_item_box
        endif
        !i #= !i+1
    endif
.item_box_ptrs
    !i #= 0
    while !i < !max_item_num
        %internal_number_to_string(!i)
        if not(stringsequal("!{item_!{_num}_path}", "0"))
            if !{item_!{_num}_put_in_box} == !yes
                dw item_!{_num}_give_item_box
            else
                dw do_nothing_from_item_box
            endif 
        else
            dw do_nothing_from_item_box
        endif
        !i #= !i+1
    endif

.codes
    !j #= 0
    while !j < !max_item_num
        %internal_number_to_string(!j)
        if not(stringsequal("!{item_!{_num}_path}", "0"))
            item_!{_num}_give: : incsrc "../!{item_!{_num}_path}/!{item_!{_num}_internal_name}_give_code.asm"
        endif
        !j #= !j+1
    endif

