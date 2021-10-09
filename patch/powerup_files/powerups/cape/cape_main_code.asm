;##################################################################################################
;# Powerup: Cape Mario
;# Author: Nintendo
;# Description: Default powerup $02 for Mario. Behaves exactly like in the original game.
;#
;# This code is run every frame when Mario has this powerup.

	bit $16				; checks if x/y pressed
	bvc .return
		
	lda !player_crouching
	ora !player_climbing
	ora !player_in_yoshi
	ora !player_spinjump
	ora !player_sliding
	ora !player_crouching_yoshi
	ora !player_wallrunning
	bne .return
	
	lda.b #!cape_spin_frames
	sta !cape_spin_timer
	lda #!cape_spin_sfx
	sta !cape_spin_sfx_port|!addr
	
.return		
	rts