;##################################################################################################
;# Powerup: Fire Flower Mario
;# Author: Nintendo
;# Description: Default powerup $03 for Mario. Behaves exactly like the original game.

;################################################
;# General behavior

;# Enable spinjumping with this powerup.
!fire_flower_can_spinjump = !yes

;# Enable crouching with this powerup.
!fire_flower_can_crouch = !yes

;# Enable sliding with this powerup.
!fire_flower_can_slide = !yes
                        
;# Enable custom interaction with sprites.
!fire_flower_custom_interaction = !no


;################################################
;# Powerdown

;# Which animation will be used when being hurt
;# Available:
;#   - "shrink": Plays the powerup shrinking animation
;#   - "palette": Cycles through some palettes
;#   - "smoke": Leaves a smoke particle while making the player invisible
!fire_flower_powerdown_action = "palette"

;# Which powerup number the player will have after being hurt
!fire_flower_powerdown_power_num = $00

;# SFX number & port when getting hurt while using this powerup
!fire_flower_powerdown_sfx_num = $0C
!fire_flower_powerdown_sfx_port = $1DF9


;################################################
;# Powerup item 
;# NOTE: UNUSED FOR THIS POWERUP

;# YXPPCCCT properties for this powerup item. Only the CCCT portion is used.
!fire_flower_item_prop = $0B

;# DSS ExGFX ID of the powerup item
!fire_flower_dss_id = !dss_id_fire_flower

;# DSS ExGFX Page of the powerup item
!fire_flower_dss_page = $00


;################################################
;# Graphics/Player image

;# Player 1's graphics index for this powerup.
!fire_flower_p1_gfx_index = $01

;# Player 2's graphics index for this powerup.
!fire_flower_p2_gfx_index = $01

;# Player 1's EXTRA graphics index for this powerup.
!fire_flower_p1_extra_gfx_index = $00

;# Player 2's EXTRA graphics index for this powerup.
!fire_flower_p2_extra_gfx_index = $00		


;################################################
;# Player palette

;# Player 1's palette index
!fire_flower_p1_palette_index = $03

;# Player 2's palette index
!fire_flower_p2_palette_index = $07


;################################################
;# Powerup-specific customization

;# Enable the player being able to shoot fireballs upwards by pressing UP + X or Y.
!fire_flower_shoot_up = !yes

;# Enable the player being able to shoot fireballs when spinjumping.
!fire_flower_shoot_spin = !yes

;# Amount of frames to wait to be able to shoot another fireball. If 0, the check is completely disabled.
!fire_flower_shoot_delay = 10

;# Amount of frames the player will display the "shooting fireball" pose
!fire_flower_pose_timer = $08

;# Sound effect that will play when shooting fireballs. If $00, the current SFX won't be interrupted.
!fire_flower_shoot_sfx = $06

;# Port for the sound effect above.
!fire_flower_shoot_sfx_port	= $1DFC		

;# How many fireballs is the player allowed to have on screen at the same time.
;# NOTE: If you select more than 2 they will start using some Extended Sprites slots which are
;#       used by various projectiles in the game.
!fireball_limit = 2

;# Extended sprite number of the fireball
!fireball_extended_num = $05


;################################################
;# Fireball behavior

;# Enables fireballs being able to activate ON/OFF blocks upon contact.
!fireball_activate_on_off = !no

;# Enables fireballs being able to activate turn blocks upon contact.
;# Set to !break to break the block instead of activating it.
!fireball_activate_turn_block = !no

;# Enables fireballs being able to break throw blocks upon contact.
!fireball_activate_throw_block = !no

;# Enables fireballs being able to activate glass blocks upon contact.
!fireball_activate_glass_block = !no

;# Enables fireballs being able to collect coins.
!fireball_collect_coins = !no


;#######################
;# Mandatory macro (do not touch).

%setup_general_defines(!fire_flower_powerup_num)