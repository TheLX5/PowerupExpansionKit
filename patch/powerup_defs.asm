include 
;##################################################################################################
;# Customization

;################################################
;# Option helper
;# You shouldn't touch these

; Used for options below.
!yes = 1
!no = 0

; Special option for the defines related to sprite remapping
; It basically undoes the hex edits.
!recover = 2

;################################################
;# Readme confirmation

;# Set it to !yes to be able to insert the patch. 
;# I hope you did read the readme & wiki.

!i_read_the_readme = !yes



;################################################
;#  DEBUG

;# Enables debugging features:
;#  - Change powerup with L/R while in the overworld.
!ENABLE_DEBUG = !no

;# Prints extra information in the console
!ENABLE_VERBOSE = !no



;################################################
;# Paths
;# Working directory at this point is at ./powerup_files/
;# Do not include a slash (/) at the end

;# Sets up a default path for the powerup_defs.asm file
!powerup_files_path ?= "./powerup_files"

;# This is included in case someone wants to change the location of the list file
!powerup_list_path ?= "../powerup_list.asm"

;# This is included in case someone wants to change the location of the list file
!gfx_list_path ?= "../graphics_list.asm"

;# DSS defines for easy usage in powerup items
!dss_defines_file_path ?= "../../pixi/asm/ExtraDefines/dynamic_spritesets_defines.asm"



;################################################
;# Free RAM blocks

;# Free BW-RAM used in SA-1 ROMs. Needs at least 478 consecutive bytes.
!powerup_ram_block = $404000    



;################################################
;# Miscelaneous customization

;# Color number of where the player palette will START being uploaded to
!palette_transfer_start    = $86

;# Color number of where the player palette will END being uploaded to
!palette_transfer_end = $8F

;# Enables clearing $7E2000, clearing Mario GFX from there completely... except for some graphics
!clear_7E2000 = !no


!dma_channel = 2

;################################################
;# Item box global configuration

;# Disables the item box
!disable_item_box = !no

;# Play the Item Box drop sound effect    
!item_box_sfx = $0C

;# Play the powerup sound effect
!powerup_sfx = $0B

;# X position of the item in the Item Box
!item_box_item_x_pos = $78

;# Y position of the item in the Item Box
!item_box_item_y_pos = $0F

;# X position where the item falling from the Item Box will spawn
!item_box_spawn_x_pos = $78 

;# Y position where the item falling from the Item Box will spawn
!item_box_spawn_y_pos = $20
                    
;# If enabled, the reserve item will NOT drop if you get hurt. Using SELECT still drops tie item.
!disable_drop_item = !no

;# If enabled, the item will always drop when Mario gets hurt regardless of his status.
;# NOTE: !disable_drop_item needs to be enabled in order to get this one to work.
!drop_item_if_big = !yes



;##################################################################################################
;# Macros & global defines.
;# Nothing past this point should be modified at all unless you know what you're doing.

if read1($00FFD5) == $23		; check if the rom is sa-1
    if read1($00FFD7) == $0D ; full 6/8 mb sa-1 rom
		!fullsa1 = 1
	else
		!fullsa1 = 0
	endif
	!sa1 = 1
	!SA1 = 1
	!SA_1 = 1
	!Base1 = $3000
	!Base2 = $6000
	!dp = $3000
	!addr = $6000
	
	!BankA = $400000
	!BankB = $000000
	!bank = $000000
	
	!Bank8 = $00
	!bank8 = $00
	
	!SprSize = $16
else
	!sa1 = 0
	!SA1 = 0
	!SA_1 = 0
	!Base1 = $0000
	!Base2 = $0000
	!dp = $0000
	!addr = $0000

	!BankA = $7E0000
	!BankB = $800000
	!bank = $800000
	
	!Bank8 = $80
	!bank8 = $80
	
	!SprSize = $0C
endif

;#########################################################################
;# Macros

	!_error_detected = 0
	!_warn_detected = 0
    incsrc "!powerup_files_path/weird_macros.asm"
    incsrc "!powerup_files_path/list_parser.asm"

;################################################
;# Setup for powerups defines.
;# Input:
;#    <num> - Powerup number to process
;#        
;# Output:
;#         A bunch of defines with generic names to make everything work automatically

macro setup_general_defines(num)
    !_name := !powerup_<num>_internal_name

    !powerup_<num>_item_prop := !{!{_name}_item_prop}
    !powerup_<num>_dss_id := !{!{_name}_dss_id}
    !powerup_<num>_dss_page := !{!{_name}_dss_page}
    
    !powerup_<num>_p1_gfx_index := !{!{_name}_p1_gfx_index}
    !powerup_<num>_p1_extra_gfx_index := !{!{_name}_p1_extra_gfx_index}
    !powerup_<num>_p1_palette_index := !{!{_name}_p1_palette_index}
    !powerup_<num>_p2_gfx_index := !{!{_name}_p2_gfx_index}
    !powerup_<num>_p2_extra_gfx_index := !{!{_name}_p2_extra_gfx_index}
    !powerup_<num>_p2_palette_index := !{!{_name}_p2_palette_index}
    
    !powerup_<num>_can_spinjump := !{!{_name}_can_spinjump}
    !powerup_<num>_can_slide := !{!{_name}_can_slide}
    !powerup_<num>_can_crouch := !{!{_name}_can_crouch}
    
endmacro

macro setup_general_gfx_defines(num)
    !_name := !gfx_<num>_internal_name

    !gfx_<num>_walk_frames := !{!{_name}_walk_frames}
endmacro

;################################################
;# Insert engine
;# Includes an asm file and calculates its insert size

macro insert_file(file_path)
    if !_error_detected != 1
        if !ENABLE_VERBOSE
            print "Processed: !powerup_files_path/<file_path>"
            print "Location: $", pc
        endif
        incsrc "!powerup_files_path/<file_path>"
        if !ENABLE_VERBOSE
            print "Insert size: ", bytes," bytes."
            print ""
        endif
    endif
endmacro

;################################################
;# Tilemap helpers

macro tilemap_original(tilemap_top, tilemap_bottom, tilemap_extra, tile_index, data_00DCEC)
    lda.w <data_00DCEC>,x
    ora $76
    tay
    lda.w <tile_index>,y
    sta $05
    ldy $13E0|!addr
    lda.w <tilemap_extra>,y
    sta $06
    lda.w <tilemap_top>,y
    sta $0A
    lda.w <tilemap_bottom>,y
    sta $0B
endmacro

macro tilemap_large(tilemap, tile_index, data_00DCEC)
    lda.w <data_00DCEC>,x
    ora $76
    tay
    lda.w <tile_index>,y
    sta $05
    ldy $13E0|!addr
    lda.w <tilemap>,y
    sta $0A
    stz $06
endmacro

;################################################
;# Build SA-1 defines

macro define_sprite_table_powerups(name, addr, addr_sa1)
	if !SA1 == 0
		!<name> ?= <addr>
	else
		!<name> ?= <addr_sa1>
	endif
endmacro

macro define_base2_address_powerups(name, addr)
	if !SA1 == 0
		!<name> ?= <addr>
	else
		!<name> ?= <addr>|!Base2
	endif
endmacro

;############################################################
;# DSS inclusion

if !_error_detected == 0
    if read3($01DF78|!bank) != $535344
        !_error_msg = "DSS isn't present on the ROM. Please insert DSS before the Powerup expansion kit."
        !_error_detected = 1
    else
        if read2($01DF7B|!bank) != 0200
            !_error_msg = "DSS versions prior to 2.00 aren't supported by the Powerup expansion kit."
            !_error_detected = 1
        else
            if not(canreadfile1("!dss_defines_file_path", 0))
                !_error_msg = "DSS' defines file can't be read. Please check if the \!dss_defines_file_path is properly set up."
                !_error_detected = 1
            else
                incsrc "!dss_defines_file_path"
            endif
        endif
    endif
    if !_error_detected == 1
        print "!!!!! ERROR !!!!!"
        print "!_error_msg"
        print ""
    endif
endif

;################################################
;# Powerup specific defines

    if !_error_detected == 0
        !i #= 0
        while !i < !max_powerup_num
            %internal_number_to_string(!i)
            if not(stringsequal("!{powerup_!{_num}_path}", "0"))
                incsrc "!powerup_files_path/!{powerup_!{_num}_path}/!{powerup_!{_num}_internal_name}_defs.asm"
            endif
            !i #= !i+1
        endif
        !i #= 0
        while !i < !max_gfx_num
            %internal_number_to_string(!i)
            if not(stringsequal("!{gfx_!{_num}_path}", "0"))
                incsrc "!powerup_files_path/!{gfx_!{_num}_path}/!{gfx_!{_num}_internal_name}_defs.asm"
            endif
            !i #= !i+1
        endif
    endif

;################################################
;# Internal defines
;# Nothing from here should be changed unless you remapped these RAMs to somewhere else.

!player_x_pos                   = $94
!player_x_low                   = $94
!player_x_high                  = $95
!player_y_pos                   = $96
!player_y_low                   = $96
!player_y_high                  = $97
!player_x_speed                 = $7B
!player_y_speed                 = $7D

!player_powerup                 = $19
!player_num                     = $0DB3|!addr

!player_in_air                  = $72
!player_blocked_status          = $77
!player_in_ground               = $13EF|!addr
!player_climbing                = $74
!player_crouching               = $73
!player_crouching_yoshi         = $18DC|!addr
!player_in_water                = $75
!player_in_yoshi                = $187A|!addr
!player_wallrunning             = $13E3|!addr
!player_in_slope                = $13EE|!addr
!player_spinjump                = $140D|!addr
!player_sliding                 = $13ED|!addr

!player_item_box                = $0DBC|!addr
!player_coins                   = $0DBF|!addr
!player_lives                   = $0DBE|!addr

!player_layer                   = $13F9|!addr
!player_behind                  = !player_layer

!player_direction               = $76
!player_pose_num                = $13E0|!addr
!player_walk_pose               = $13DB|!addr
!player_cape_pose_num           = $13DF|!addr
!player_extra_tile_num          = !player_cape_pose_num

!player_invulnerability_timer   = $1497|!addr
!player_flash_timer             = !player_invulnerability_timer
!player_spinjump_timer          = $13E2|!addr
!player_star_timer              = $1490|!addr
!player_dash_timer              = $13E4|!addr
!player_shoot_pose_timer        = $149C|!addr

!cape_interaction_flag          = $13E8|!addr
!cape_interaction_x_pos         = $13E9|!addr
!cape_interaction_y_pos         = $13EB|!addr
!cape_spin_timer                = $14A6|!addr

!player_holding                 = $148F|!addr
!player_carrying                = $1470|!addr
!player_disable_collision       = $185C|!addr
!player_stomp_count             = $18D2|!addr
!player_frozen                  = $13FB|!addr

!level_water_flag               = $85
!level_slippery_flag            = $86


;################################################
;# Free RAM allocation
;# Everything is handled automatically.

!player_graphics_index          = !powerup_ram_block
!player_graphics_pointer        = !player_graphics_index+1
!player_graphics_bypass         = !player_graphics_pointer+3
!player_graphics_extra_index    = !player_graphics_bypass+1
!player_graphics_disp_settings  = !player_graphics_extra_index+1
!player_graphics_x_disp         = !player_graphics_disp_settings+1
!player_graphics_y_disp         = !player_graphics_x_disp+256

!player_palette_pointer         = !player_graphics_y_disp+256
!player_palette_bypass          = !player_palette_pointer+3
!player_palette_index           = !player_palette_bypass+1

!player_extra_tile_settings     = !player_palette_index+1
!player_extra_tile_offset_x     = !player_extra_tile_settings+1
!player_extra_tile_offset_y     = !player_extra_tile_offset_x+2
!player_extra_tile_frame        = !player_extra_tile_offset_y+2

!player_hitbox_flag             = !player_extra_tile_frame+2
!player_hitbox_width            = !player_hitbox_flag+1
!player_hitbox_height           = !player_hitbox_width+1
!player_hitbox_disp_x           = !player_hitbox_height+1
!player_hitbox_disp_y           = !player_hitbox_disp_x+1

!player_collision_flag          = !player_hitbox_disp_y+1
!player_collision_index         = !player_collision_flag+1
!player_collision_pointer_x     = !player_collision_index+1
!player_collision_pointer_y     = !player_collision_pointer_x+3
!player_collision_data_x        = !player_collision_pointer_y+3
!player_collision_data_y        = !player_collision_data_x+128

!player_disable_crouch          = !player_collision_data_y+128
!player_disable_slide           = !player_disable_crouch+1
!player_disable_spinjump        = !player_disable_slide+1
!player_disable_ride_yoshi      = !player_disable_spinjump+1
!player_disable_controller_15   = !player_disable_ride_yoshi+1
!player_disable_controller_17   = !player_disable_controller_15+1
!player_disable_extended_hurt   = !player_disable_controller_17+1
!player_disable_itembox         = !player_disable_extended_hurt+1

!player_backup_blocked_status   = !player_disable_itembox+1
!player_backup_slippery_status  = !player_backup_blocked_status+1

!extra_sprite_ram               = !SprSize*4
!extra_extended_ram             = !Extendedsize*5

!extended_gfx                   = !extra_extended_ram+(!ExtendedSize*0)
!extended_flags                 = !extra_extended_ram+(!ExtendedSize*1)
!extended_dir                   = !extra_extended_ram+(!ExtendedSize*2)
!extended_prev                  = !extra_extended_ram+(!ExtendedSize*3)
!extended_index                 = !extra_extended_ram+(!ExtendedSize*4)

;################################################
;# SA-1 compatibility defines.

!GenStart ?= $D0
!ClusterOffset  ?= $09
!ExtendedOffset ?= $13
!MinorExtendedOffset ?= $0C
!SmokeOffset ?= $06
!SpinningCoinOffset ?= $02
!BounceOffset = $08
!ScoreOffset = $16
;!QuakeOffset = $03

!ExtendedSize ?= $08
!MinorExtendedSize ?= $0C
!SmokeSize ?= $04
!SpinningCoinSize ?= $04
!BounceSize ?= $04
!ScoreSize ?= $06
;!QuakeSize = $04


;sprite tool / pixi defines
%define_sprite_table_powerups("7FAB10",$7FAB10,$6040)
%define_sprite_table_powerups("7FAB1C",$7FAB1C,$6056)
%define_sprite_table_powerups("7FAB28",$7FAB28,$6057)
%define_sprite_table_powerups("7FAB34",$7FAB34,$606D)
%define_sprite_table_powerups("7FAB9E",$7FAB9E,$6083)
%define_sprite_table_powerups("7FAB40",$7FAB40,$6099)
%define_sprite_table_powerups("7FAB4C",$7FAB4C,$60AF)
%define_sprite_table_powerups("7FAB58",$7FAB58,$60C5)
%define_sprite_table_powerups("7FAB64",$7FAB64,$60DB)

%define_sprite_table_powerups("7FAC00",$7FAC00,$60F1)
%define_sprite_table_powerups("7FAC08",$7FAC08,$6030)
%define_sprite_table_powerups("7FAC10",$7FAC10,$6038)

%define_sprite_table_powerups("extra_bits",$7FAB10,$6040)
%define_sprite_table_powerups("new_code_flag",$7FAB1C,$6056)
%define_sprite_table_powerups("extra_prop_1",$7FAB28,$6057)
%define_sprite_table_powerups("extra_prop_2",$7FAB34,$606D)
%define_sprite_table_powerups("new_sprite_num",$7FAB9E,$6083)
%define_sprite_table_powerups("extra_byte_1",$7FAB40,$6099)
%define_sprite_table_powerups("extra_byte_2",$7FAB4C,$60AF)
%define_sprite_table_powerups("extra_byte_3",$7FAB58,$60C5)
%define_sprite_table_powerups("extra_byte_4",$7FAB64,$60DB)

%define_sprite_table_powerups("shooter_extra_byte_1",$7FAC00,$60F1)
%define_sprite_table_powerups("shooter_extra_byte_2",$7FAC08,$6030)
%define_sprite_table_powerups("shooter_extra_byte_3",$7FAC10,$6038)

;%define_sprite_table_powerups(shoot_misc,$7FAB64,$4000DB)

;shooter defines
%define_base2_address_powerups(shoot_num,$1783)		; shooter number -#$BC, also has the extra bit in #$40
%define_base2_address_powerups(shoot_y_low,$178B)
%define_base2_address_powerups(shoot_y_low,$178B)
%define_base2_address_powerups(shoot_y_high,$1793)
%define_base2_address_powerups(shoot_x_low,$179B)
%define_base2_address_powerups(shoot_x_high,$17A3)
%define_base2_address_powerups(shoot_timer,$17AB)


;cluster defines
%define_base2_address_powerups(cluster_num,$1892)
%define_base2_address_powerups(cluster_y_low,$1E02)
%define_base2_address_powerups(cluster_y_high,$1E2A)
%define_base2_address_powerups(cluster_x_low,$1E16)
%define_base2_address_powerups(cluster_x_high,$1E3E)

;extended defines
%define_base2_address_powerups(extended_num,$170B)
%define_base2_address_powerups(extended_y_low,$1715)
%define_base2_address_powerups(extended_y_high,$1729)
%define_base2_address_powerups(extended_x_low,$171F)
%define_base2_address_powerups(extended_x_high,$1733)
%define_base2_address_powerups(extended_x_speed,$1747)
%define_base2_address_powerups(extended_y_speed,$173D)
%define_base2_address_powerups(extended_table,$1765)
%define_base2_address_powerups(extended_timer,$176F)
%define_base2_address_powerups(extended_behind,$1779)

;minor extended defines
%define_base2_address_powerups(minor_extended_num,$17F0)
%define_base2_address_powerups(minor_extended_y_low,$17FC)
%define_base2_address_powerups(minor_extended_y_high,$1814)
%define_base2_address_powerups(minor_extended_x_low,$1808)
%define_base2_address_powerups(minor_extended_x_high,$18EA)
%define_base2_address_powerups(minor_extended_x_speed,$182C)
%define_base2_address_powerups(minor_extended_y_speed,$1820)
%define_base2_address_powerups(minor_extended_x_fraction,$1844)
%define_base2_address_powerups(minor_extended_y_fraction,$1838)
%define_base2_address_powerups(minor_extended_timer,$1850)

;smoke sprite defines
%define_base2_address_powerups(smoke_num,$17C0)
%define_base2_address_powerups(smoke_y_low,$17C4)
%define_base2_address_powerups(smoke_x_low,$17C8)
%define_base2_address_powerups(smoke_timer,$17CC)

;spinning coin sprite defines
%define_base2_address_powerups(spinning_coin_num,$17D0)
%define_base2_address_powerups(spinning_coin_y_low,$17D4)
%define_base2_address_powerups(spinning_coin_y_speed,$17D8)
%define_base2_address_powerups(spinning_coin_y_bits,$17DC)
%define_base2_address_powerups(spinning_coin_x_low,$17E0)
%define_base2_address_powerups(spinning_coin_layer,$17E4)
%define_base2_address_powerups(spinning_coin_y_high,$17E8)
%define_base2_address_powerups(spinning_coin_x_high,$17EC)

;score sprite defines
%define_base2_address_powerups(score_num,$16E1)
%define_base2_address_powerups(score_y_low,$16E7)
%define_base2_address_powerups(score_x_low,$16ED)
%define_base2_address_powerups(score_x_high,$16F3)
%define_base2_address_powerups(score_y_high,$16F9)
%define_base2_address_powerups(score_y_speed,$16FF)
%define_base2_address_powerups(score_layer,$1705)

;bounce sprite defines
%define_base2_address_powerups(bounce_num,$1699)
%define_base2_address_powerups(bounce_init,$169D)
%define_base2_address_powerups(bounce_y_low,$16A1)
%define_base2_address_powerups(bounce_x_low,$16A5)
%define_base2_address_powerups(bounce_y_high,$16A9)
%define_base2_address_powerups(bounce_x_high,$16AD)
%define_base2_address_powerups(bounce_y_speed,$16B1)
%define_base2_address_powerups(bounce_x_speed,$16B5)
%define_base2_address_powerups(bounce_x_bits,$16B9)
%define_base2_address_powerups(bounce_y_bits,$16BD)
%define_base2_address_powerups(bounce_map16_tile,$16C1)
%define_base2_address_powerups(bounce_timer,$16C5)
%define_base2_address_powerups(bounce_table,$16C9)
%define_base2_address_powerups(bounce_properties,$1901)

;quake sprite defines
; %define_base2_address_powerups(quake_num,$16CD)
; %define_base2_address_powerups(quake_x_low,$16D1)
; %define_base2_address_powerups(quake_x_high,$16D5)
; %define_base2_address_powerups(quake_y_low,$16D9)
; %define_base2_address_powerups(quake_y_high,$16DD)
; %define_base2_address_powerups(quake_timer,$18F8)

;overworld defines
; %define_sprite_table_powerups(ow_num,     $0DE5, $3200)
; %define_sprite_table_powerups(ow_x_pos,     $9E, $3230)
; %define_sprite_table_powerups(ow_y_pos,     $9E, $3260)
; %define_sprite_table_powerups(ow_z_pos,     $9E, $3290)
; %define_sprite_table_powerups(ow_x_speed, $0E95, $32C0)
; %define_sprite_table_powerups(ow_y_speed, $0EA5, $32F0)
; %define_sprite_table_powerups(ow_z_speed, $0EB5, $3320)

; %define_sprite_table_powerups(ow_misc1,   $0DF5, $3350)
; %define_sprite_table_powerups(ow_misc2,   $0E05, $3380)
; %define_sprite_table_powerups(ow_misc3,     $9E, $33B0)
; %define_sprite_table_powerups(ow_misc4,     $9E, $33E0)
; %define_sprite_table_powerups(ow_misc5,     $9E, $3410)
; %define_sprite_table_powerups(ow_timer1,  $0E15, $3440)
; %define_sprite_table_powerups(ow_timer2,  $0E25, $3470)
; %define_sprite_table_powerups(ow_timer3,    $9E, $34A0)
; %define_sprite_table_powerups(ow_extra,     $9E, $34D0)

; %define_sprite_table_powerups(ow_x_speed_acc, $9E, $3500)
; %define_sprite_table_powerups(ow_y_speed_acc, $9E, $3500)
; %define_sprite_table_powerups(ow_z_speed_acc, $9E, $3500)

;normal sprite defines
%define_sprite_table_powerups(sprite_num, $9E, $3200)
%define_sprite_table_powerups(sprite_speed_y, $AA, $9E)
%define_sprite_table_powerups(sprite_speed_x, $B6, $B6)
%define_sprite_table_powerups(sprite_misc_c2, $C2, $D8)
%define_sprite_table_powerups(sprite_y_low, $D8, $3216)
%define_sprite_table_powerups(sprite_x_low, $E4, $322C)
%define_sprite_table_powerups(sprite_status, $14C8, $3242)
%define_sprite_table_powerups(sprite_y_high, $14D4, $3258)
%define_sprite_table_powerups(sprite_x_high, $14E0, $326E)
%define_sprite_table_powerups(sprite_speed_y_frac, $14EC, $74C8)
%define_sprite_table_powerups(sprite_speed_x_frac, $14F8, $74DE)
%define_sprite_table_powerups(sprite_misc_1504, $1504, $74F4)
%define_sprite_table_powerups(sprite_misc_1510, $1510, $750A)
%define_sprite_table_powerups(sprite_misc_151c, $151C, $3284)
%define_sprite_table_powerups(sprite_misc_1528, $1528, $329A)
%define_sprite_table_powerups(sprite_misc_1534, $1534, $32B0)
%define_sprite_table_powerups(sprite_misc_1540, $1540, $32C6)
%define_sprite_table_powerups(sprite_misc_154c, $154C, $32DC)
%define_sprite_table_powerups(sprite_misc_1558, $1558, $32F2)
%define_sprite_table_powerups(sprite_misc_1564, $1564, $3308)
%define_sprite_table_powerups(sprite_misc_1570, $1570, $331E)
%define_sprite_table_powerups(sprite_misc_157c, $157C, $3334)
%define_sprite_table_powerups(sprite_blocked_status, $1588, $334A)
%define_sprite_table_powerups(sprite_misc_1594, $1594, $3360)
%define_sprite_table_powerups(sprite_off_screen_horz, $15A0, $3376)
%define_sprite_table_powerups(sprite_misc_15ac, $15AC, $338C)
%define_sprite_table_powerups(sprite_slope, $15B8, $7520)
%define_sprite_table_powerups(sprite_off_screen, $15C4, $7536)
%define_sprite_table_powerups(sprite_being_eaten, $15D0, $754C)
%define_sprite_table_powerups(sprite_obj_interact, $15DC, $7562)
%define_sprite_table_powerups(sprite_oam_index, $15EA, $33A2)
%define_sprite_table_powerups(sprite_oam_properties, $15F6, $33B8)
%define_sprite_table_powerups(sprite_misc_1602, $1602, $33CE)
%define_sprite_table_powerups(sprite_misc_160e, $160E, $33E4)
%define_sprite_table_powerups(sprite_index_in_level, $161A, $7578)
%define_sprite_table_powerups(sprite_misc_1626, $1626, $758E)
%define_sprite_table_powerups(sprite_behind_scenery, $1632, $75A4)
%define_sprite_table_powerups(sprite_misc_163e, $163E, $33FA)
%define_sprite_table_powerups(sprite_in_water, $164A, $75BA)
%define_sprite_table_powerups(sprite_tweaker_1656, $1656, $75D0)
%define_sprite_table_powerups(sprite_tweaker_1662, $1662, $75EA)
%define_sprite_table_powerups(sprite_tweaker_166e, $166E, $7600)
%define_sprite_table_powerups(sprite_tweaker_167a, $167A, $7616)
%define_sprite_table_powerups(sprite_tweaker_1686, $1686, $762C)
%define_sprite_table_powerups(sprite_off_screen_vert, $186C, $7642)
%define_sprite_table_powerups(sprite_misc_187b, $187B, $3410)

%define_sprite_table_powerups(sprite_load_table, $7FAF00, $418A00)

%define_sprite_table_powerups(sprite_tweaker_190f, $190F, $7658)
%define_sprite_table_powerups(sprite_misc_1fd6, $1FD6, $766E)
%define_sprite_table_powerups(sprite_cape_disable_time, $1FE2, $7FD6)

%define_sprite_table_powerups("9E", $9E, $3200)
%define_sprite_table_powerups("AA", $AA, $9E)
%define_sprite_table_powerups("B6", $B6, $B6)
%define_sprite_table_powerups("C2", $C2, $D8)
%define_sprite_table_powerups("D8", $D8, $3216)
%define_sprite_table_powerups("E4", $E4, $322C)
%define_sprite_table_powerups("14C8", $14C8, $3242)
%define_sprite_table_powerups("14D4", $14D4, $3258)
%define_sprite_table_powerups("14E0", $14E0, $326E)
%define_sprite_table_powerups("14EC", $14EC, $74C8)
%define_sprite_table_powerups("14F8", $14F8, $74DE)
%define_sprite_table_powerups("1504", $1504, $74F4)
%define_sprite_table_powerups("1510", $1510, $750A)
%define_sprite_table_powerups("151C", $151C, $3284)
%define_sprite_table_powerups("1528", $1528, $329A)
%define_sprite_table_powerups("1534", $1534, $32B0)
%define_sprite_table_powerups("1540", $1540, $32C6)
%define_sprite_table_powerups("154C", $154C, $32DC)
%define_sprite_table_powerups("1558", $1558, $32F2)
%define_sprite_table_powerups("1564", $1564, $3308)
%define_sprite_table_powerups("1570", $1570, $331E)
%define_sprite_table_powerups("157C", $157C, $3334)
%define_sprite_table_powerups("1588", $1588, $334A)
%define_sprite_table_powerups("1594", $1594, $3360)
%define_sprite_table_powerups("15A0", $15A0, $3376)
%define_sprite_table_powerups("15AC", $15AC, $338C)
%define_sprite_table_powerups("15B8", $15B8, $7520)
%define_sprite_table_powerups("15C4", $15C4, $7536)
%define_sprite_table_powerups("15D0", $15D0, $754C)
%define_sprite_table_powerups("15DC", $15DC, $7562)
%define_sprite_table_powerups("15EA", $15EA, $33A2)
%define_sprite_table_powerups("15F6", $15F6, $33B8)
%define_sprite_table_powerups("1602", $1602, $33CE)
%define_sprite_table_powerups("160E", $160E, $33E4)
%define_sprite_table_powerups("161A", $161A, $7578)
%define_sprite_table_powerups("1626", $1626, $758E)
%define_sprite_table_powerups("1632", $1632, $75A4)
%define_sprite_table_powerups("163E", $163E, $33FA)
%define_sprite_table_powerups("164A", $164A, $75BA)
%define_sprite_table_powerups("1656", $1656, $75D0)
%define_sprite_table_powerups("1662", $1662, $75EA)
%define_sprite_table_powerups("166E", $166E, $7600)
%define_sprite_table_powerups("167A", $167A, $7616)
%define_sprite_table_powerups("1686", $1686, $762C)
%define_sprite_table_powerups("186C", $186C, $7642)
%define_sprite_table_powerups("187B", $187B, $3410)
%define_sprite_table_powerups("190F", $190F, $7658)

%define_sprite_table_powerups("1938", $1938, $418A00)
%define_sprite_table_powerups(sprite_load_table, $1938, $418A00)

%define_sprite_table_powerups("1FD6", $1FD6, $766E)
%define_sprite_table_powerups("1FE2", $1FE2, $7FD6)