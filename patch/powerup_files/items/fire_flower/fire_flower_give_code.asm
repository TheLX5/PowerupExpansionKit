;##################################################################################################
;# Item: Fire Flower
;# Author: Nintendo
;# Description: Default powerup item for Fire Mario.

;################################################
;# Collected item routine
;# Runs whenever the player touches the powerup item

.collected
    lda.b #!fire_flower_powerup_num
    cmp !player_powerup
    bne ..not_same
    jmp do_nothing
..not_same
    sta !player_powerup
    lda #$20
    sta $149B|!addr
    if !fire_flower_freeze_screen == !yes
        sta $9D
    endif
    if !fire_flower_collected_sfx_num != $00
        lda.b #!fire_flower_collected_sfx_num
        sta.w !fire_flower_collected_sfx_port|!addr
    endif
    lda #$04
    sta $71
    if !fire_flower_can_give_points == !yes
        lda.b #!fire_flower_collected_points
        ldy !item_falling,x
        bne ..from_item_box
        jsl give_points
    ..from_item_box
    endif
    rts

;################################################
;# Put in item box logic
;# Runs when the player touches a powerup item

.item_box
    lda.w ..item_id,y
    beq ..nope
    sta !player_item_box
    if !fire_flower_item_box_sfx_num != $00
        lda.b #!fire_flower_item_box_sfx_num
        sta.w !fire_flower_item_box_sfx_port|!addr
    endif
..nope
    rts 

..item_id
    !i #= 0
    while !i < !max_powerup_num
        %internal_number_to_string(!i)
        if not(stringsequal("!{powerup_!{_num}_path}", "0"))
            db !{powerup_!{_num}_item_id}+1
        else
            db $00
        endif
        !i #= !i+1
    endif

;################################################
;# Routine to instantly give a powerup without any animation/effect

.quick
    lda.b #!fire_flower_powerup_num
    sta !player_powerup
    rtl