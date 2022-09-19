;##################################################################################################
;# Item: 1up Mushroom
;# Author: Nintendo
;# Description: Default powerup item for giving Mario a 1-up.

;################################################
;# Properties

;# YXPPCCCT properties for this powerup item. Only the CCCT portion is used.
!1up_mushroom_sprite_prop = $0B


;################################################
;# Collected behavior

;# Powerup number that the item will give the player when collected
;# $FF means that it won't give a powerup
!1up_mushroom_powerup_num = $FF

;# SFX number that will play when the player collects this item
!1up_mushroom_collected_sfx_num = $00
!1up_mushroom_collected_sfx_port = $1DF9

;# Enables this powerup to give points
!1up_mushroom_can_give_points = !yes

;# Points that will be given when collecting this item
;# Valid values: https://smwc.me/m/smw/rom/02ACE5
!1up_mushroom_collected_points = $04


;################################################
;# DSS Settings

;# DSS ExGFX ID of the powerup item
!1up_mushroom_dss_id = !dss_id_mushroom

;# DSS ExGFX Page of the powerup item
!1up_mushroom_dss_page = $00


;################################################
;# Item box settings

;# Item overwrites whatever is inside the item box when collected
!1up_mushroom_overwrite_item_box = !no

;# Item can be put in the item box
!1up_mushroom_put_in_box = !no


;#######################
;# Mandatory macro (do not touch).

%setup_general_item_defines(!1up_mushroom_item_num)