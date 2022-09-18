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

;# Item overwrites whatever is inside the item box when collected
!1up_mushroom_overwrite_item_box = !yes

;# Item can be put in the item box
!1up_mushroom_put_in_box = !no


;################################################
;# DSS Settings

;# DSS ExGFX ID of the powerup item
!1up_mushroom_dss_id = !dss_id_mushroom

;# DSS ExGFX Page of the powerup item
!1up_mushroom_dss_page = $00


;#######################
;# Mandatory macro (do not touch).

%setup_general_item_defines(!1up_mushroom_item_num)