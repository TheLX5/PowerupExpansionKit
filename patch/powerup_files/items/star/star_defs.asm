;##################################################################################################
;# Item: Star
;# Author: Nintendo
;# Description: Default item for the star status.

;################################################
;# Properties

;# YXPPCCCT properties for this powerup item. Only the CCCT portion is used.
!star_sprite_prop = $0B


;################################################
;# DSS Settings

;# DSS ExGFX ID of the powerup item
!star_dss_id = !dss_id_star

;# DSS ExGFX Page of the powerup item
!star_dss_page = $00


;#######################
;# Mandatory macro (do not touch).

%setup_general_item_defines(!star_item_num)