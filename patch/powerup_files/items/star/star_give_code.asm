;##################################################################################################
;# Item: Star
;# Author: Nintendo
;# Description: Default item for the star status.

;################################################
;# Collected item routine
;# Runs whenever the player touches the powerup item

.collected
    jsl $01C580|!bank
    if !star_collected_sfx_num != $00
        lda.b #!star_collected_sfx_num
        sta.w !star_collected_sfx_port|!addr
    endif
    if !star_can_give_points == !yes
        lda.b #!star_collected_points
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
    rts

;################################################
;# Routine to instantly give a powerup without any animation/effect

.quick
    jsl $01C580|!addr
    rtl 