;##################################################################################################
;# Item: Fire Flower
;# Author: Nintendo
;# Description: Default powerup item for Cape Mario.

;################################################
;# Properties

;# YXPPCCCT properties for this powerup item. Only the CCCT portion is used.
!fire_flower_sprite_prop = $0B


;################################################
;# Collected behavior

;# Powerup number that the item will give the player when collected
;# $FF means that it won't give a powerup
!fire_flower_powerup_num = !fire_powerup_num

;# SFX number that will play when the player collects this item
!fire_flower_collected_sfx_num = $0A
!fire_flower_collected_sfx_port = $1DF9

;# Enables this item to give points
!fire_flower_can_give_points = !yes

;# Points that will be given when collecting this item
;# Valid values: https://smwc.me/m/smw/rom/02ACE5
!fire_flower_collected_points = $04

;# Enables this item freezing the screen when playing an animation
!fire_flower_freeze_screen = !yes


;################################################
;# DSS Settings

;# DSS ExGFX ID of this item
!fire_flower_dss_id = !dss_id_fire_flower

;# DSS ExGFX Page of this item
!fire_flower_dss_page = $00


;################################################
;# Item box settings

;# Item overwrites whatever is inside the item box when collected
!fire_flower_overwrite_item_box = !yes

;# Item can be put in the item box
!fire_flower_put_in_box = !yes

;# SFX that will play when this item puts another item in the item box
!fire_flower_item_box_sfx_num = !powerup_in_item_box_sfx
!fire_flower_item_box_sfx_port = !powerup_in_item_box_port


;#######################
;# Mandatory macro (do not touch).

%setup_general_item_defines(!fire_flower_item_num)