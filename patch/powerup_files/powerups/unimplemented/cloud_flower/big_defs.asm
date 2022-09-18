;##################################################################################################
;# Powerup: Big Mario
;# Author: Nintendo
;# Description: Default powerup $01 for Mario. Behaves exactly like the original game.

;################################################
;# Internal defines

!big_internal_name		= big		; Internal name.
						; Referenced in various locations of the patch.

!big_powerup_num		= $01		; Internal powerup number.
						; Referenced in various locations of the patch.
						
!big_insert			= !yes		; Insert code and data related to this powerup
						; Defines can be referenced anywhere regardless of
						; this setting.

;################################################
;# Customization

;#######################
;# General behavior

!big_walk_frames		= 3		; How many walking frames the player will have
						; with this powerup.
						
!big_can_spinjump		= !yes		; Enable spinjumping with this powerup.
!big_can_duck			= !yes		; Enable ducking with this powerup.
!big_can_slide			= !yes		; Enable sliding with this powerup.
						
!big_powerdown_effect		= Shrink	; Powerdown effect upon being hurt.
						; VALID EFFECTS:
						; Kill
						; Shrink
						; Palette
						; Smoke
						; Custom

!big_custom_interaction		= !no		; Enable custom interaction with sprites.

;#######################
;# Powerup item 
;# NOTE: UNUSED FOR THIS POWERUP

!big_dynamic_tile		= $00		; Tile number in powerup_items.bin for this
						; powerup item.
						; Unused if Dynamic Powerups are disabled.
						
!big_tile			= $FF		; Tile number for this powerup item.
						; NOTE FOR PROGRAMMERS:
						; If using Dynamic Powerups Items, this define
						; gets replaced with: !dynamic_items_tile+$04
						
!big_prop			= $08		; YXPPCCCT properties for this powerup item.
						; Only the CCCT portion is used.

;#######################
;# Graphics/Player image
						
!big_p1_gfx_index		= $01		; Player 1's graphics index for this powerup.
			
!big_p2_gfx_index		= $01		; Player 2's graphics index for this powerup.				

;#######################
;# Mandatory macro (do not touch).

%powerup_number(!big_powerup_num,!big_internal_name)