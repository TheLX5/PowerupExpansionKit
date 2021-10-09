;##################################################################################################
;# Powerup: Cape Mario
;# Author: Nintendo
;# Description: Default powerup $02 for Mario. Behaves exactly like in the original game.
;# 
;# This code will handle any extra animations or poses Mario will have when using this powerup.

.extra_tile_player
	lda.b #!cape_p2_extra_gfx_index
	ldy !player_num
	bne ..player_2
	lda.b #!cape_p1_extra_gfx_index
..player_2 
	sta !player_graphics_extra_index
	lda #$81
	sta !player_extra_tile_settings
	rts