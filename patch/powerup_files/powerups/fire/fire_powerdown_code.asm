;##################################################################################################
;# Powerup: Fire Mario
;# Author: Nintendo
;# Description: Default powerup $03 for Mario. Behaves exactly like the original game.
;#
;# This code will once run whenever Mario gets hurt while using this powerup.
;#
;# Note: In order to use this code, set the powerdown effect to Custom in the defs file.
	
    %powerdown_!{fire_powerdown_action}(!fire_powerdown_power_num, !fire_powerdown_sfx_num, !fire_powerdown_sfx_port)
    rts