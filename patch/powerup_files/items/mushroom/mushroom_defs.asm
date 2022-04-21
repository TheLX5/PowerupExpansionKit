;##################################################################################################
;# Item: Super Mushroom
;# Author: Nintendo
;# Description: Default powerup item for Big Mario.

;################################################
;# Properties

;# YXPPCCCT properties for this powerup item. Only the CCCT portion is used.
!mushroom_sprite_prop = $09


;################################################
;# DSS Settings

;# DSS ExGFX ID of the powerup item
!mushroom_dss_id = !dss_id_mushroom

;# DSS ExGFX Page of the powerup item
!mushroom_dss_page = $00


;#######################
;# Mandatory macro (do not touch).

%setup_general_item_defines(!mushroom_item_num)