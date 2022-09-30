;##################################################################################################
;# Powerup: Fire Flower Mario
;# Author: Nintendo
;# Description: Default powerup $03 for Mario. Behaves exactly like the original game.

;################################################
;# General behavior

;# Enable spinjumping with this powerup.
!fire_can_spinjump = !yes

;# Enable climbing with this powerup.
!fire_can_climb = !yes

;# Enable crouching with this powerup.
!fire_can_crouch = !yes

;# Enable sliding with this powerup.
!fire_can_slide = !yes

;# Enable carrying items with this powerup.
!fire_can_carry_items = !yes

;# Enable riding Yoshi with this powerup.
!fire_can_ride_yoshi = !yes


;################################################
;# Powerdown

;# Which animation will be used when being hurt
;# Available:
;#   - "shrink": Plays the powerup shrinking animation
;#   - "palette": Cycles through some palettes
;#   - "smoke": Leaves a smoke particle while making the player invisible
;# Note that if this powerup uses custom code and not macros this setting will be ignored.
!fire_powerdown_action = "shrink"

;# Which powerup number the player will have after being hurt
!fire_powerdown_power_num = $00

;# SFX number & port when getting hurt while using this powerup
!fire_powerdown_sfx_num = $04
!fire_powerdown_sfx_port = $1DF9


;################################################
;# Item ID

;# Item ID associated to this powerup.
!fire_item_id = $01


;################################################
;# Graphics/Player image

;# Player 1's graphics index for this powerup.
!fire_p1_gfx_index = $01

;# Player 2's graphics index for this powerup.
!fire_p2_gfx_index = $01

;# Player 1's EXTRA graphics index for this powerup.
!fire_p1_extra_gfx_index = $00

;# Player 2's EXTRA graphics index for this powerup.
!fire_p2_extra_gfx_index = $00		


;################################################
;# Player palette

;# Player 1's palette index
!fire_p1_palette_index = $03

;# Player 2's palette index
!fire_p2_palette_index = $07


;################################################
;# Graphical options

;# Determines the Y displacement where the water splash will appear in relation to the player
;# This is affected by collision data
!fire_water_y_disp = $0010

;# Same as above, but when the player is riding Yoshi
!fire_water_y_disp_on_yoshi = $0004


;################################################
;# Hitbox, interaction & collision options

;# Player's hitbox X displacement from player's origin
!fire_hitbox_x_disp = $0002

;# Player's hitbox width
!fire_hitbox_width = $0C

;# Player's hitbox Y displacement from player's origin
!fire_hitbox_y_disp = $0006

;# Player's hitbox height
!fire_hitbox_height = $1A

;# Player's hitbox Y displacement from player's origin while crouching
!fire_hitbox_y_disp_crouching = $0014

;# Player's hitbox height while crouching
!fire_hitbox_height_crouching = $0C

;# Player's hitbox Y displacement from player's origin while mounted on Yoshi
!fire_hitbox_y_disp_on_yoshi = $0010

;# Player's hitbox height while mounted on Yoshi
!fire_hitbox_height_on_yoshi = $0020

;# Player's hitbox Y displacement from player's origin while crouching and mounted on Yoshi
!fire_hitbox_y_disp_crouching_on_yoshi = $0018

;# Player's hitbox height while crouching and mounted on Yoshi
!fire_hitbox_height_crouching_on_yoshi = $18


;################################################
;# Powerup-specific customization

;# Enable the player being able to shoot fireballs upwards by pressing UP + X or Y.
!fire_shoot_up = !yes

;# Enable the player being able to shoot fireballs when spinjumping.
!fire_shoot_spin = !yes

;# Amount of frames to wait to be able to shoot another fireball. If 0, the check is completely disabled.
!fire_shoot_delay = 10

;# Amount of frames the player will display the "shooting fireball" pose
!fire_pose_timer = $08

;# Sound effect that will play when shooting fireballs. If $00, the current SFX won't be interrupted.
!fire_shoot_sfx = $06

;# Port for the sound effect above.
!fire_shoot_sfx_port	= $1DFC		

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

%setup_general_defines(!fire_powerup_num)