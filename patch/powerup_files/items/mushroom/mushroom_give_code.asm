;##################################################################################################
;# Item: Super Mushroom
;# Author: Nintendo
;# Description: Default powerup item for Big Mario.

;################################################
;# Collected item routine
;# Runs whenever the player touches the powerup item

.collected
    lda !player_powerup
    bne .do_nothing
.not_same
    lda #$02
    sta $71
    lda #$20
    sta !player_animation_timer
    sta $9D
.do_nothing
    lda #$0A
    sta $1DF9|!addr
    lda #$04
    ldy !item_falling,x
    bne .from_item_box
    jsl give_points
.from_item_box
    rts

;################################################
;# Put in item box logic
;# Runs when the player touches a powerup item

.item_box
    lda !player_item_box
    bne .nope
    lda.w .item_id,y
    beq .nope
    sta !player_item_box
    lda.b #!powerup_in_item_box_sfx
    sta !powerup_in_item_box_port|!addr
.nope
    rts 

.item_id
    db $00
    !i #= 1
    while !i < !max_powerup_num
        %internal_number_to_string(!i)
        if not(stringsequal("!{powerup_!{_num}_path}", "0"))
            db !mushroom_item_num+1
        else
            db $00
        endif
        !i #= !i+1
    endif

;################################################
;# Routine to instantly give a powerup without any animation/effect

.quick
    lda #!big_powerup_num
    sta !player_powerup
    rtl