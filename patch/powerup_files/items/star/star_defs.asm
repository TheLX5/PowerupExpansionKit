;##################################################################################################
;# Item: Star
;# Author: Nintendo
;# Description: Default item for the star status.

;################################################
;# Properties

;# YXPPCCCT properties for this item. Only the CCCT portion is used.
!star_sprite_prop = $0B

;# Acts like setting for the item. Similar to custom sprites.
;# Might not affect the actual behavior of the item.
;# This should be between $74 and $78.
!star_acts_like = $76


;################################################
;# Collected behavior

;# Powerup number that the item will give the player when collected
;# $FF means that it won't give a powerup
!star_powerup_num = $FF

;# SFX number that will play when the player collects this item
!star_collected_sfx_num = $0A
!star_collected_sfx_port = $1DF9

;# Enables this item to give points
!star_can_give_points = !yes

;# Points that will be given when collecting this item
;# Valid values: https://smwc.me/m/smw/rom/02ACE5
!star_collected_points = $04


;################################################
;# DSS settings

;# DSS ExGFX ID of this item
!star_dss_id = !dss_id_star

;# DSS ExGFX Page of this item
!star_dss_page = $00


;################################################
;# Item box settings

;# Item overwrites whatever is inside the item box when collected
!star_overwrite_item_box = !no

;# Item can be put in the item box
!star_put_in_box = !yes

;# SFX that will play when this item puts another item in the item box
!star_item_box_sfx_num = !powerup_in_item_box_sfx
!star_item_box_sfx_port = !powerup_in_item_box_port


;#######################
;# Mandatory macro (do not touch).

%setup_general_item_defines(!star_item_num)