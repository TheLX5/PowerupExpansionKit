;##################################################################################################
;# Powerup: Big Mario
;# Author: Nintendo
;# Description: Default powerup $01 for Mario. Behaves exactly like the original game.

;################################################
;# Internal defines

!hammer_suit_internal_name	= hammer_suit	; Internal name.
						; Referenced in various locations of the patch.

!hammer_suit_powerup_num	= $01		; Internal powerup number.
						; Referenced in various locations of the patch.
						
!hammer_suit_insert		= !yes		; Insert code and data related to this powerup
						; Defines can be referenced anywhere regardless of
						; this setting.

;################################################
;# Customization

;#######################
;# General behavior

!hammer_suit_walk_frames	= 3		; How many walking frames the player will have
						; with this powerup.
						
!hammer_suit_can_spinjump	= !yes		; Enable spinjumping with this powerup.
!hammer_suit_can_duck		= !yes		; Enable ducking with this powerup.
!hammer_suit_can_slide		= !no		; Enable sliding with this powerup.
						
!hammer_suit_powerdown_effect	= Shrink	; Powerdown effect upon being hurt.
						; VALID EFFECTS:
						; Kill
						; Shrink
						; Palette
						; Smoke
						; Custom

!hammer_suit_custom_interaction	= !no		; Enable custom interaction with sprites.

;#######################
;# Powerup item 
;# NOTE: UNUSED FOR THIS POWERUP

!hammer_suit_dynamic_tile	= $08		; Tile number in powerup_items.bin for this
						; powerup item.
						; Unused if Dynamic Powerups are disabled.
						
!hammer_suit_tile		= $FF		; Tile number for this powerup item.
						; NOTE FOR PROGRAMMERS:
						; If using Dynamic Powerups Items, this define
						; gets replaced with: !dynamic_items_tile+$04
						
!hammer_suit_prop		= $08		; YXPPCCCT properties for this powerup item.
						; Only the CCCT portion is used.

;#######################
;# Graphics/Player image
						
!hammer_suit_p1_gfx_index	= $04		; Player 1's graphics index for this powerup.
			
!hammer_suit_p2_gfx_index	= $04		; Player 2's graphics index for this powerup.				

;#######################
;# Mandatory macro (do not touch).

%powerup_number(!hammer_suit_powerup_num,!hammer_suit_internal_name)