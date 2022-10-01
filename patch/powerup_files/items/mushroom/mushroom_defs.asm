;##################################################################################################
;# Item: Super Mushroom
;# Author: Nintendo
;# Description: Default powerup item for Big Mario.

;################################################
;# Properties

;# YXPPCCCT properties for this item. Only the CCCT portion is used.
!mushroom_sprite_prop = $09

;# Acts like setting for the item. Similar to custom sprites.
;# Might not affect the actual behavior of the item.
;# This should be between $74 and $78.
!mushroom_acts_like = $74


;################################################
;# Collected behavior

;# Powerup number that the item will give the player when collected
;# $FF means that it won't give a powerup
!mushroom_powerup_num = !big_powerup_num

;# SFX number that will play when the player collects this item
!mushroom_collected_sfx_num = $0A
!mushroom_collected_sfx_port = $1DF9

;# Enables this powerup to give points
!mushroom_can_give_points = !yes

;# Points that will be given when collecting this item
;# Valid values: https://smwc.me/m/smw/rom/02ACE5
!mushroom_collected_points = $04

;# Enables this item freezing the screen when playing an animation
!mushroom_freeze_screen = !yes


;################################################
;# DSS Settings

;# DSS ExGFX ID of the powerup item
!mushroom_dss_id = !dss_id_mushroom

;# DSS ExGFX Page of the powerup item
!mushroom_dss_page = $00


;################################################
;# Item box settings

;# Item overwrites whatever is inside the item box when collected
!mushroom_overwrite_item_box = !no

;# Item can be put in the item box
!mushroom_put_in_box = !yes

;# SFX that will play when this item puts another item in the item box
!mushroom_item_box_sfx_num = !powerup_in_item_box_sfx
!mushroom_item_box_sfx_port = !powerup_in_item_box_port


;#######################
;# Mandatory macro (do not touch).

%setup_general_item_defines(!mushroom_item_num)