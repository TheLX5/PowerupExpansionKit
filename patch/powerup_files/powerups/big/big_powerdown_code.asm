;##################################################################################################
;# Powerup: Big Mario
;# Author: Nintendo
;# Description: Default powerup $01 for Mario. Behaves exactly like the original game.
;#
;# This code will once run whenever Mario gets hurt while using this powerup.
;#
;# Note: In order to use this code, set the powerdown effect to Custom in the defs file.
    
    %powerdown_!{big_powerdown_action}(!big_powerdown_power_num, !big_powerdown_sfx_num, !big_powerdown_sfx_port)
    rts