;##################################################################################################
;# Item: Star
;# Author: Nintendo
;# Description: Default item for the star status.

    lda #$01
    pha 
    plb 
    jml $01C371|!bank       ; while this may look dumb and slow, it allows easy editing if needed