pushpc
    org $0086C1|!bank
        jsl controller_mask
pullpc

controller_mask:
	lda $0DA8|!addr,x
	sta $18
	lda !player_disable_controller_15       ; disable certain buttons
	trb $15
	trb $16
	lda !player_disable_controller_17       ; disable certain buttons
	trb $17
	trb $18
	lda #$00
	sta !player_disable_controller_15       ; reset the flag
	sta !player_disable_controller_17
	rtl	