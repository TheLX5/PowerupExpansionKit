;##################################################################################################
;# Powerup: Big Mario
;# Author: Nintendo
;# Description: Default powerup $01 for Mario. Behaves exactly like the original game.

;################################################
;# General behavior

;# Enable spinjumping with this powerup.
!big_can_spinjump = !yes

;# Enable climbing with this powerup.
!big_can_climb = !yes

;# Enable crouching with this powerup.
!big_can_crouch = !yes

;# Enable sliding with this powerup.
!big_can_slide = !yes

;# Enable carrying items with this powerup.
!big_can_carry_items = !yes

;# Enable riding Yoshi with this powerup.
!big_can_ride_yoshi = !yes



;################################################
;# Powerdown

;# Which animation will be used when being hurt
;# Available:
;#   - "shrink": Plays the powerup shrinking animation
;#   - "palette": Cycles through some palettes
;#   - "smoke": Leaves a smoke particle while making the player invisible
;# Note that if this powerup uses custom code and not macros this setting will be ignored.
!big_powerdown_action = "shrink"

;# Which powerup number the player will have after being hurt
!big_powerdown_power_num = $00

;# SFX number & port when getting hurt while using this powerup
!big_powerdown_sfx_num = $04
!big_powerdown_sfx_port = $1DF9


;################################################
;# Item ID

;# Item ID associated to this powerup.
!big_item_id = $00


;################################################
;# Graphics/Player image

;# Player 1's graphics index for this powerup.
!big_p1_gfx_index = $01

;# Player 2's graphics index for this powerup.
!big_p2_gfx_index = $01

;# Player 1's EXTRA graphics index for this powerup.
!big_p1_extra_gfx_index = $00

;# Player 2's EXTRA graphics index for this powerup.
!big_p2_extra_gfx_index = $00


;################################################
;# Player palette

;# Player 1's palette index
!big_p1_palette_index = $FF

;# Player 2's palette index
!big_p2_palette_index = $04


;################################################
;# Graphical options

;# Determines the Y displacement where the water splash will appear in relation to the player
;# This is affected by collision data
!big_water_y_disp = $0010

;# Same as above, but when the player is riding Yoshi
!big_water_y_disp_on_yoshi = $0004


;################################################
;# Hitbox, interaction & collision options

;# Player's hitbox X displacement from player's origin
!big_hitbox_x_disp = $0002

;# Player's hitbox width
!big_hitbox_width = $0C

;# Player's hitbox Y displacement from player's origin
!big_hitbox_y_disp = $0006

;# Player's hitbox height
!big_hitbox_height = $1A

;# Player's hitbox Y displacement from player's origin while crouching
!big_hitbox_y_disp_crouching = $0014

;# Player's hitbox height while crouching
!big_hitbox_height_crouching = $0C

;# Player's hitbox Y displacement from player's origin while mounted on Yoshi
!big_hitbox_y_disp_on_yoshi = $0010

;# Player's hitbox height while mounted on Yoshi
!big_hitbox_height_on_yoshi = $0020

;# Player's hitbox Y displacement from player's origin while crouching and mounted on Yoshi
!big_hitbox_y_disp_crouching_on_yoshi = $0018

;# Player's hitbox height while crouching and mounted on Yoshi
!big_hitbox_height_crouching_on_yoshi = $18


;################################################
;# Mandatory macro (do not touch).

%setup_general_defines(!big_powerup_num)