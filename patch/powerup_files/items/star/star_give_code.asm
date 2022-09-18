;##################################################################################################
;# Item: Star
;# Author: Nintendo
;# Description: Default item for the star status.

;################################################
;# Collected item routine
;# Runs whenever the player touches the powerup item

.collected
    jsl $01C580|!addr
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
    rts

;################################################
;# Routine to instantly give a powerup without any animation/effect

.quick
    rtl 