;##################################################################################################
;# Item: 1up Mushroom
;# Author: Nintendo
;# Description: Default item for giving Mario a 1-up.

;################################################
;# Collected item routine
;# Runs whenever the player touches the powerup item

.collected
    lda #$08
    clc 
    adc !1594,x
    jsl give_points
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