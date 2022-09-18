;##################################################################################################
;# Item: Feather
;# Author: Nintendo
;# Description: Default powerup item for Cape Mario.

;################################################
;# Properties

;# YXPPCCCT properties for this powerup item. Only the CCCT portion is used.
!feather_sprite_prop = $05


;################################################
;# Collected behavior

;# Item overwrites whatever is inside the item box when collected
!feather_overwrite_item_box = !yes

;# Item can be put in the item box
!feather_put_in_box = !yes


;################################################
;# DSS Settings

;# DSS ExGFX ID of the powerup item
!feather_dss_id = !dss_id_feather

;# DSS ExGFX Page of the powerup item
!feather_dss_page = $00


;#######################
;# Mandatory macro (do not touch).

%setup_general_item_defines(!feather_item_num)