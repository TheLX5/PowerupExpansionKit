;##################################################################################################
;# Powerup: Small Mario
;# Author: Nintendo
;# Description: Default powerup $00 for Mario. Behaves exactly like in the original game.

;################################################
;# General behavior
                        
;# Enable spinjumping with this powerup.
!small_can_spinjump = !yes

;# Enable crouching with this powerup.
!small_can_crouch = !yes

;# Enable sliding with this powerup.
!small_can_slide = !yes

;# Enable custom interaction with sprites.
!small_custom_interaction = !no


;################################################
;# Powerdown
;# This powerup doesn't have anything related to powerdown.


;################################################
;# Powerup item
;# NOTE: UNUSED FOR THIS POWERUP

;# YXPPCCCT properties for this powerup item. Only the CCCT portion is used.
!small_item_prop = $FF

;# DSS ExGFX ID of the powerup item
!small_dss_id = $FF

;# DSS ExGFX Page of the powerup item
!small_dss_page = $FF


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
;# Mandatory macro (do not touch).

%setup_general_defines(!small_powerup_num)