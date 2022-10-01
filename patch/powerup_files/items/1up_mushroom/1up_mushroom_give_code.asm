;##################################################################################################
;# Item: 1up Mushroom
;# Author: Nintendo
;# Description: Default item for giving Mario a 1-up.

;################################################
;# Collected item routine
;# Runs whenever the player touches the powerup item

.collected
    if !1up_mushroom_collected_sfx_num != $00
        lda #!1up_mushroom_collected_sfx_num
        sta.w !1up_mushroom_collected_sfx_port|!addr
    endif
    if !1up_mushroom_can_give_points == !yes
        lda.b #!1up_mushroom_collected_points
        clc 
        adc !1594,x
        jsl give_points
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
    rtl