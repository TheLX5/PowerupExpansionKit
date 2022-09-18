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

;# Item overwrites whatever is inside the item box when collected
!fire_flower_overwrite_item_box = !yes

;# Item can be put in the item box
!fire_flower_put_in_box = !yes


;################################################
;# DSS Settings

;# DSS ExGFX ID of the powerup item
!fire_flower_dss_id = !dss_id_fire_flower

;# DSS ExGFX Page of the powerup item
!fire_flower_dss_page = $00


;#######################
;# Mandatory macro (do not touch).

%setup_general_item_defines(!fire_flower_item_num)