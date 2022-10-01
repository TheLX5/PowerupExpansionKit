;##################################################################################################
;# Item: Feather
;# Author: Nintendo
;# Description: Default powerup item for Cape Mario.

;################################################
;# Properties

;# YXPPCCCT properties for this item. Only the CCCT portion is used.
!feather_sprite_prop = $05

;# Acts like setting for the item. Similar to custom sprites.
;# Might not affect the actual behavior of the item.
;# This should be between $74 and $78.
!feather_acts_like = $77


;################################################
;# Collected behavior

;# Powerup number that the item will give the player when collected
;# $FF means that it won't give a powerup
!feather_powerup_num = !cape_powerup_num

;# SFX number that will play when the player collects this item
!feather_collected_sfx_num = $0D
!feather_collected_sfx_port = $1DF9

;# Enables this item to give points
!feather_can_give_points = !yes

;# Points that will be given when collecting this item
;# Valid values: https://smwc.me/m/smw/rom/02ACE5
!feather_collected_points = $04

;# Enables this item freezing the screen when playing an animation
!feather_freeze_screen = !yes


;################################################
;# DSS Settings

;# DSS ExGFX ID of this item
!feather_dss_id = !dss_id_feather

;# DSS ExGFX Page of this item
!feather_dss_page = $00


;################################################
;# Item box settings

;# Item overwrites whatever is inside the item box when collected
!feather_overwrite_item_box = !yes

;# Item can be put in the item box
!feather_put_in_box = !yes

;# SFX that will play when this item puts another item in the item box
!feather_item_box_sfx_num = !powerup_in_item_box_sfx
!feather_item_box_sfx_port = !powerup_in_item_box_port


;#######################
;# Mandatory macro (do not touch).

%setup_general_item_defines(!feather_item_num)