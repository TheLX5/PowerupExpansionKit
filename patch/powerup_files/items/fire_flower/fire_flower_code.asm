;##################################################################################################
;# Item: Fire Flower
;# Author: Nintendo
;# Description: Default powerup item for Fire Mario.

;################################################
;# Init code for this item

.init
    jsr ..goal
    inc !C2,x
    jml item_return


;################################################
;# Code for initializing the sprite when carrying an item through the goal tape

..goal
    lda #!fire_flower_acts_like
    sta !9E,x
    jsl init_sprite_tables
    lda.b #!fire_flower_sprite_prop
    sta !15F6,x
    rts


;################################################
;# Main code for this item

.main
    lda !item_roulette_flag,x             ; not a roulette
    bne .do_not_animate
    lda $14
    and #$08
    lsr #3
    sta !item_direction,x
.do_not_animate
    lda #$01
    pha 
    plb 
    jml $01C371|!bank       ; while this may look dumb and slow, it allows easy editing if needed