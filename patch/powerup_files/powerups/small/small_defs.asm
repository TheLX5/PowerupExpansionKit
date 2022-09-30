;##################################################################################################
;# Powerup: Small Mario
;# Author: Nintendo
;# Description: Default powerup $00 for Mario. Behaves exactly like in the original game.

;################################################
;# General behavior

;# Enable spinjumping with this powerup.
!small_can_spinjump = !yes

;# Enable climbing with this powerup.
!small_can_climb = !yes

;# Enable crouching with this powerup.
!small_can_crouch = !yes

;# Enable sliding with this powerup.
!small_can_slide = !yes

;# Enable carrying items with this powerup.
!small_can_carry_items = !yes

;# Enable riding Yoshi with this powerup.
!small_can_ride_yoshi = !yes


;################################################
;# Powerdown
;# This powerup doesn't have anything related to powerdown.


;################################################
;# Item ID

;# Item ID associated to this powerup.
!small_item_id = $FF


;################################################
;# Graphics/Player image

;# Player 1's graphics index for this powerup.
!small_p1_gfx_index = $00

;# Player 2's graphics index for this powerup.
!small_p2_gfx_index = $00

;# Player 1's EXTRA graphics index for this powerup.
!small_p1_extra_gfx_index = $00

;# Player 2's EXTRA graphics index for this powerup.
!small_p2_extra_gfx_index = $00


;################################################
;# Player palette

;# Player 1's palette index
!small_p1_palette_index = $FF

;# Player 2's palette index
!small_p2_palette_index = $04


;################################################
;# Graphical options

;# Determines the Y displacement where the water splash will appear in relation to the player
;# This is affected by collision data
!small_water_y_disp = $0008

;# Same as above, but when the player is riding Yoshi
!small_water_y_disp_on_yoshi = $FFFC


;################################################
;# Hitbox, interaction & collision options

;# Player's hitbox X displacement from player's origin
!small_hitbox_x_disp = $0002

;# Player's hitbox width
!small_hitbox_width = $0C

;# Player's hitbox Y displacement from player's origin
!small_hitbox_y_disp = $0014

;# Player's hitbox height
!small_hitbox_height = $0C

;# Player's hitbox Y displacement from player's origin while crouching
!small_hitbox_y_disp_crouching = $0014

;# Player's hitbox height while crouching
!small_hitbox_height_crouching = $0C

;# Player's hitbox Y displacement from player's origin while mounted on Yoshi
!small_hitbox_y_disp_on_yoshi = $0018

;# Player's hitbox height while mounted on Yoshi
!small_hitbox_height_on_yoshi = $18

;# Player's hitbox Y displacement from player's origin while crouching and mounted on Yoshi
!small_hitbox_y_disp_crouching_on_yoshi = $0018

;# Player's hitbox height while crouching and mounted on Yoshi
!small_hitbox_height_crouching_on_yoshi = $18


;################################################
;# Mandatory macro (do not touch).

%setup_general_defines(!small_powerup_num)