pushpc
    org ($01817D+($74*$02))|!bank
        item_engine_init_hijack:
            dw item_engine_init_jump
            dw item_engine_init_jump
            dw item_engine_init_jump
            dw item_engine_init_jump
            dw item_engine_init_jump

    org ($0185CC+($74*$02))|!bank
        item_engine_main_pointers:
            dw item_engine_main_hijack
            dw item_engine_main_hijack
            dw item_engine_main_hijack
            dw item_engine_main_hijack
            dw item_engine_main_hijack

    org $01C510
        item_engine_init_jump:
            jml item_engine_init

    org $01C353|!bank
        item_engine_main_hijack:
            autoclean jml item_engine_main
    
    org $01C344|!bank
        item_return:

    org $01C538|!bank
        give_item_handler_hijack:
            autoclean jsl give_item_handler
            rts 
    
    org $02894F|!bank
        generate_item_from_blocks_hijack:
            autoclean jsl generate_item_from_blocks

    org $02ACE5|!bank
        give_points:

    org $00FB00|!bank
        goal_tape_hijack:
            autoclean jml goal_tape_item
    org $00FB64|!bank
        goal_tape_return:
    org $07F7D2|!bank
        init_sprite_tables:
    org $07F78B|!bank
        load_tweaker_bytes:
pullpc

item_engine_init:
    lda !extra_bits,x
    and #$04                ; not a custom item
    bne .custom
.not_custom
    lda !9E,x
    sec 
    sbc #$74
    sta !extra_byte_1,x
.custom 
.get_pointer
    lda #$00
    xba 
    lda !extra_byte_1,x
    and #$7F
    cmp.b #!max_item_num+1
    bcc .no_overflow
    lda #$00
.no_overflow
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
    !i #= 0
    while !i < !max_item_num
        %internal_number_to_string(!i)
        if not(stringsequal("!{item_!{_num}_path}", "0"))
            dl item_!{_num}_code_init
        else
            dl $01858B|!bank
        endif
        !i #= !i+1
    endif


item_engine_main:
    lda !item_berry_flag,x
    beq .not_berry
    jml $01C358|!bank

.not_berry
.get_pointer
    lda #$00
    xba 
    lda #$00
    ldy !9E,x
    cpy #$21
    beq .calculate_pointer
    lda !extra_byte_1,x
    and #$7F
    cmp.b #!max_item_num+1
    bcc .no_overflow
    lda #$00
.no_overflow
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
            dl item_!{_num}_code_main
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
            item_!{_num}_code: : incsrc "../!{item_!{_num}_path}/!{item_!{_num}_internal_name}_code.asm"
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
    rtl

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

generate_item_from_blocks:
    sta !9E,x
    sta $0E
    cmp #$74
    bcc .not_an_item
    cmp #$79
    bcs .not_an_item
    txy 
    lda #$00
    xba 
    lda $0E
    sec 
    sbc #$74
    sta !extra_byte_1,x
    jsr goal_tape_item_get_pointer
    rtl 
.not_an_item
    jml init_sprite_tables

goal_tape_item:
    ldx !player_powerup
    rep #$10
    lda !player_star_timer
    beq .no_star
    ldx.w #!max_powerup_num+$01
.no_star
    lda !player_in_yoshi
    beq .no_yoshi
    ldx.w #!max_powerup_num+$02
.no_yoshi
    rep #$20
    lda.w !9E,y
    and #$00FF
    cmp #$002F
    beq .carrying_springboard 
    cmp #$003E
    beq .carrying_pswitch
    cmp #$0080
    beq .carrying_key
    cmp #$002D
    bne .carrying_item
.carrying_baby_yoshi
    txa 
    clc 
    adc.w #!max_powerup_num+$03
    tax 
.carrying_key
    txa 
    clc 
    adc.w #!max_powerup_num+$03
    tax 
.carrying_pswitch
.carrying_springboard
    txa 
    clc 
    adc.w #!max_powerup_num+$03
    tax 
.carrying_item
    sep #$20
    lda !player_item_box
    dec 
    sta $0F
    lda.l .item_pool,x
    cmp $0F
    bne .not_same
    if defined("1up_mushroom_item_num") == $01
        lda.b #!1up_mushroom_item_num
    else 
        lda #$00
    endif
.not_same
    sep #$10
    stz $0F
    cmp #$E0
    bcc .get_sprite
    and #$0F
    sta $0F
    if defined("1up_mushroom_item_num") == $01
        lda.b #!1up_mushroom_item_num
    else 
        lda #$00
    endif
.get_sprite
    sta $0E
    if defined("star_item_num") == $01
        cmp #!star_item_num
        bne .not_star
        inc $13CB|!addr
    .not_star
    endif 
    lda $0F
    pha 
    lda #$74
    sta.w !9E,y
    tyx 
    lda $0E
    sta !extra_byte_1,x
    jsr .goal_codes
    pla 
    sta $0F
    jml goal_tape_return

.goal_codes
    lda #$00
    xba 
    lda !extra_byte_1,x
    and #$7F
    cmp.b #!max_item_num+1
    bcc .no_overflow
    lda #$00
.no_overflow
.get_pointer
    rep #$30
    sta $00
    asl 
    tax 
    lda.l .goal_ptrs,x
    sta $00
    sep #$30
    tyx 
    jmp (!dp)

.goal_ptrs
    !i #= 0
    while !i < !max_item_num
        %internal_number_to_string(!i)
        if not(stringsequal("!{item_!{_num}_path}", "0"))
            dw item_!{_num}_code_init_goal
        else
            dw .default_goal
        endif
        !i #= !i+1
    endif

.default_goal
    lda #$74
    sta !9E,x
    jsl init_sprite_tables
    rts

.item_pool
..any_item
    !i #= 0
    while !i < !max_powerup_num
        %internal_number_to_string(!i)
        if stringsequal("!{powerup_!{_num}_path}", "0")
            db $00
        else
            if !{powerup_!{_num}_item_id} == $FF
                db $00
            else 
                db !{powerup_!{_num}_item_id}
            endif
        endif
        !i #= !i+1
    endif
    if defined("star_item_num") == $01
        db !star_item_num
    else 
        db $00
    endif 
    db $E0
    db $F1      ; Unused data
..springboard_pswitch
    !i #= 0
    while !i < !max_powerup_num
        %internal_number_to_string(!i)
        if stringsequal("!{powerup_!{_num}_path}", "0")
            db $00
        else
            if !{powerup_!{_num}_item_id} == $FF
                db $00
            else 
                db !{powerup_!{_num}_item_id}
            endif
        endif
        !i #= !i+1
    endif
    if defined("star_item_num") == $01
        db !star_item_num
    else 
        db $00
    endif 
    db $E0
    db $F1      ; Unused data
..key
    !i #= 0
    while !i < !max_powerup_num
        db $F0
        !i #= !i+1
    endif
    db $F1
    db $E0
    db $F2      ; Unused data
..baby_yoshi
    !i #= 0
    while !i < !max_powerup_num
        db $E0
        !i #= !i+1
    endif
    db $F1
    db $E0
    db $E4      ; Unused data