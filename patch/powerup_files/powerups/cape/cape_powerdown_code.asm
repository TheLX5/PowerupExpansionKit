;##################################################################################################
;# Powerup: Cape Mario
;# Author: Nintendo
;# Description: Default powerup $02 for Mario. Behaves exactly like in the original game.
;#
;# This code will once run whenever Mario gets hurt while using this powerup.
;#
;# Note: In order to use this code, set the powerdown effect to Custom in the defs file.
	
    %powerdown_!{cape_powerdown_action}(!cape_powerdown_power_num, !cape_powerdown_sfx_num, !cape_powerdown_sfx_port)
    rts