;##################################################################################################
;# Item: Feather
;# Author: Nintendo
;# Description: Default powerup item for Cape Mario.

;################################################
;# Properties

;# YXPPCCCT properties for this powerup item. Only the CCCT portion is used.
!feather_sprite_prop = $05


;################################################
;# DSS Settings

;# DSS ExGFX ID of the powerup item
!feather_dss_id = !dss_id_feather

;# DSS ExGFX Page of the powerup item
!feather_dss_page = $00


;#######################
;# Mandatory macro (do not touch).

%setup_general_item_defines(!feather_item_num)