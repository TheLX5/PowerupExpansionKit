includefrom "powerup.asm"

reset bytes

;################################################
;# Hijacks

pushpc
    org $00E36D|!bank
        autoclean jml player_poses_handler
    warnpc $00E3C0|!bank

    org $00E3E4|!bank
        BRA +
    org $00E3EC|!bank
    +


    org $00E489|!bank
        autoclean jsl player_x_disp_handler

    org $00E471|!bank
        autoclean jsl player_y_disp_handler

    org $00E326|!bank
        autoclean jml player_bopping


    org $00CEB1|!bank
        autoclean jml player_primary_animation_logic
        autoclean jml player_primary_animation_logic_horz_pipe
        cape_spin_interaction:
            phb
            phk 
            plb 
            jsr $D044
            plb 
            rtl
        player_update_speeds:
            phb
            phk 
            plb 
            jsr $DC2D
            plb 
            rtl 
        player_apply_gravity:
            phb
            phk 
            plb 
            jsr $D92E
            plb 
            rtl 

            
    org $00D1A1         ; repoint primary animation logic hijack
        jsl $00CEB5|!bank   



    org $00D193                 ; Fix sprite masks during pipe animation
        db $00,$6F,$1F,$00      ; not sure if it's going to mess anything...
    org $00D1D1
        eor #$10



    org $00CEA1|!bank
        db $00,$00,$01,$01
    org $00CA31|!bank
        autoclean jml player_peace_pose_handler
    org $00CA3A|!bank
        player_peace_pose_handler_return:

    org $00D1A8|!bank
        autoclean jml player_entering_door_pose_handler
    org $00D1B2|!bank
        player_entering_door_pose_handler_return:
    org $00D209|!bank
        autoclean jml player_vertical_pipe_pose_handler
    org $00D20E|!bank
        player_vertical_pipe_pose_handler_return:
    org $00D22A|!bank
        player_vertical_pipe_pose_handler_carry_return:
    org $00D228|!bank
        lda $00

    org $00CDAD|!bank
        autoclean jml player_on_yoshi_pose_handler
    org $00CDC6|!bank
        player_on_yoshi_pose_handler_return:

    org $00D0B8|!bank
        autoclean jml player_death_pose_handler
    org $00D0BD|!bank
        player_death_pose_handler_return:
    org $00D10C|!bank
        autoclean jml player_death_animation_handler
    org $00D11C|!bank
        player_death_animation_handler_return:

    org $00D130|!bank
        autoclean jsl player_grow_shrink_pose_handler

    org $00D181|!bank
        autoclean jml player_grab_flower_pose_handler
    org $00D187|!bank
        player_grab_flower_pose_handler_return:
    
    org $00DA8D|!bank
        autoclean jml player_swimming_pose_handler
    org $00DAA5|!bank
        player_swimming_pose_handler_return:

    org $00DBCA|!bank
        autoclean jml player_climbing_pose_handler
    org $00DBD0|!bank
        player_climbing_pose_handler_return:
    org $00DB78|!bank
        autoclean jml player_climbing_turning_pose_handler
    org $00DB8C|!bank
        autoclean jml player_climbing_punching_pose_handler
    org $00DB92|!bank
        player_climbing_animaitons_handler_return:
    
    org $00CCD8|!bank
        autoclean jsl player_stunned_pose_handler

    org $00CD95|!bank
        autoclean jml player_pballoon_pose_handler
    org $00CDA5|!bank
        player_pballoon_pose_handler_return:



    org $00E18E|!bank
        player_default_cape_table:
            db $00,$00,$00,$00,$00,$00,$00,$00      ;[00-07]
            db $00,$00,$00,$00,$00,$0D,$00,$10      ;[08-0F]
            db $13,$22,$25,$28,$00,$16,$00,$00      ;[10-17]
            db $00,$00,$00,$00,$00,$08,$19,$1C      ;[18-1F]
            db $04,$1F,$10,$10,$00,$16,$10,$06      ;[20-27]
            db $04,$08,$FF,$FF,$FF,$FF,$FF,$43      ;[28-2F]
            db $00,$00,$00,$00,$00,$00,$00,$00      ;[30-37]
            db $16,$16,$00,$00,$08                  ;[38-3C]
            db $00,$00,$00,$00,$00,$00,$10,$04      ;[3D-44]
            db $00                                  ;[45]

    org $00E1D4|!bank                               ;$00E1D4    | Data on Mario's cape, indexed by values in $00E18E. Each entry is up to 5 bytes long.
        db $06,$00,$06,$00,$86,$02,$06,$03	;MASK,DYNAMIC,MASK,DYNAMIC,MASK,DYNAMIC,MASK,DYNAMIC
        db $06,$01,$06,$42,$06,$06,$02,$00	;MASK,DYNAMIC,MASK,DYNAMIC,POSITION,MASK,DYNAMIC,POSITION
        db $06,$0A,$06,$06,$06,$0E,$86,$0A	;MASK,DYNAMIC,POSITION,MASK,DYNAMIC,POSITION,MASK,DYNAMIC
        db $06,$86,$0A,$0A,$86,$20,$08,$06	;POSITION,MASK,DYNAMIC,POSITION,MASK,DYNAMIC,POSITION,MASK
        db $00,$02,$06,$2C,$10,$06,$40,$10	;DYNAMIC,POSITION,MASK,DYNAMIC,POSITION,MASK,DYNAMIC,POSITION
        db $06,$2E,$10,$FF,$FF,$FF,$FF,$FF	;MASK,DYNAMIC,POSITION,MASK,DYNAMIC,POSITION,TILE1,TILE2
        db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF	;MASK,DYNAMIC,POSITION,TILE1,TILE2,MASK,DYNAMIC,POSITION
        db $FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF	;TILE1,TILE2,MASK,DYNAMIC,POSITION,TILE1,TILE2,MASK
        db $FF,$FF,$FF,$06,$0E,$1E		;DYNAMIC,POSITION,TILE1,MASK,DYNAMIC,POSITION
        warnpc $00E21A

    org $00E23A|!bank            ;other cape tiles.
        db $00,$00,$20,$00,$24,$24,$24,$24
        db $26,$26,$26,$26,$06,$06,$06,$06
        db $04,$04,$04,$04,$02,$02,$02,$02
        db $08,$08,$08,$08,$28,$28,$28,$28
        db $2A,$2A,$2A,$2A,$22,$22,$22,$22
        db $0C,$0C,$0C,$0C


    org $00D1AE|!bank ;Animation frame for Mario entering horizontal pipe on Yoshi
        db $1D          ;Remapped from $29 to $1D (Ducking with Item/Ducking on Yoshi)

    org $00DCEC|!bank    ;PosPointPointer
        player_default_data_00DCEC:
            db $00,$00,$00,$00,$00,$00,$00,$00    ;00-07    \
            db $00,$00,$00,$00,$00,$00,$00,$00    ;08-0F    |
            db $04,$02,$02,$02,$00,$00,$00,$00    ;10-17    |
            db $00,$00,$00,$00,$00,$00,$00,$00    ;18-1F    |
            db $00,$00,$00,$00,$00,$00,$00,$00    ;20-27    |Mario's pose number
            db $00,$00,$00,$00,$00,$00,$00,$00    ;28-2F    |
            db $00,$00,$00,$00,$00,$00,$00,$00    ;30-37    |
            db $00,$00,$00,$00,$00,$00,$00,$00    ;38-3F    |
            db $00,$00,$00,$00,$00,$00    ;40-45    /

    org $00DD32|!bank    ;PosPoint
        player_default_disp_index:
            db $00,$08,$10,$18,$20,$28,$00,$00    ;00-07
            db $00,$00,$00,$00,$00,$00,$00,$00    ;08-0F
            db $00,$00,$00,$00,$00,$00,$00,$00    ;10-17
            db $00,$00,$00,$00    ;18-1B

    org $00DD4E|!bank    ;X positions
        player_default_x_disp:
            dw $FFF8,$FFF8,$0008,$0008    ;[00]    Normal (facing left)
            dw $0008,$0008,$FFF8,$FFF8    ;[08]    Normal (facing right)
            dw $0007,$0007,$0017,$0017    ;[10]    Wall running offsets (wall on left)
            dw $FFFA,$FFFA,$FFEA,$FFEA    ;[18]    Wall running offsets (wall on right)
            dw $0005,$0005,$0015,$0015    ;[20]    Wall triangle offsets (^ <-)
            dw $FFFC,$FFFC,$FFEC,$FFEC    ;[28]    Wall triangle offsets (-> ^)
            ;below are free to use
            dw $FFF8,$FFF8,$0008,$0008    ;[30]
            dw $0008,$0008,$FFF8,$FFF8    ;[38]
            dw $FFF8,$FFF8,$0008,$0008    ;[40]
            dw $0008,$0008,$FFF8,$FFF8    ;[48]
            dw $FFF8,$FFF8,$0008,$0008    ;[50]
            dw $0008,$0008,$FFF8,$FFF8    ;[58]
            dw $FFF8,$FFF8,$0008,$0008    ;[60]
            dw $0008,$0008,$FFF8,$FFF8    ;[68]
            dw $FFF8,$FFF8,$0008,$0008    ;[70]
            dw $0008,$0008,$FFF8,$FFF8    ;[78]
            dw $0000,$0000    ;[80]
            ;;;Cape X positions;;;
            dw $000A,$FFF6    ;[84]
            dw $0008,$FFF8,$0008,$FFF8
            dw $0000,$0004,$FFFC,$FFFE
            dw $0002,$000B,$FFF5,$0014
            dw $FFEC,$000E,$FFF3,$0008
            dw $FFF8,$000C,$0014,$FFFD
            dw $FFF4,$FFF4,$000B,$000B
            dw $0003,$0013,$FFF5,$0005
            dw $FFF5,$0009,$0001,$0001
            dw $FFF7,$0007,$0007,$0005
            dw $000D,$000D,$FFFB,$FFFB
            dw $FFFB,$FFFF,$000F,$0001
            dw $FFF9,$0000

    org $00DE32|!bank    ;Y positions
        player_default_y_disp:
            dw $0001,$0011,$0001,$0011    ;[00]    Normal (facing left)
            dw $0001,$0011,$0001,$0011    ;[08]    Normal (facing right)
            dw $000F,$001F,$000F,$001F    ;[10]    Wall running offsets (wall on left)
            dw $000F,$001F,$000F,$001F    ;[18]    Wall running offsets (wall on right)
            dw $0005,$0015,$0005,$0015    ;[20]    Wall triangle offsets (^ <-)
            dw $0005,$0015,$0005,$0015    ;[28]    Wall triangle offsets (-> ^)
            ;below are free to use
            dw $0001,$0011,$0001,$0011    ;[30]
            dw $0001,$0011,$0001,$0011    ;[38]
            dw $0001,$0011,$0001,$0011    ;[40]
            dw $0001,$0011,$0001,$0011    ;[48]
            dw $0001,$0011,$0001,$0011    ;[50]
            dw $0001,$0011,$0001,$0011    ;[58]
            dw $0001,$0011,$0001,$0011    ;[60]
            dw $0001,$0011,$0001,$0011    ;[68]
            dw $0001,$0011,$0001,$0011    ;[70]
            dw $0001,$0011,$0001,$0011    ;[78]
            dw $0000,$0000    ;[80]
            ;;;Cape Y positions;;;
            dw $000B,$000B    ;[84]
            dw $0011,$0011,$FFFF,$FFFF
            dw $0010,$0010,$0010,$0010
            dw $0010,$0010,$0010,$0015
            dw $0015,$0025,$0025,$0004
            dw $0004,$0004,$0014,$0014
            dw $0004,$0014,$0014,$0004
            dw $0004,$0014,$0004,$0004
            dw $0014,$0000,$0008,$0000
            dw $0000,$0008,$0000,$0000
            dw $0010,$0018,$0000,$0010
            dw $0018,$0000,$0010,$0000
            dw $0010,$FFF8

pullpc
    


player_poses_handler:
    lda !player_flash_timer
    beq .not_flashing
    lsr #3
    tax 
    lda.l $00E292|!bank,x
    and !player_flash_timer
    ora !player_frozen
    ora $9D
    bne .not_flashing
    plb 
    rtl 

.not_flashing
    phb
    phk
    plb

    lda #$00
    sta !player_extra_tile_settings         ; Extra graphics settings
    sta !player_extra_tile_offset_x         ; Extra graphics relative X position
    sta !player_extra_tile_offset_x+1
    sta !player_extra_tile_offset_y         ; Extra graphics relative Y position
    sta !player_extra_tile_offset_y+1
    sta !player_extra_tile_frame             ; Extra graphics tile

    jsr global_animations
    jsr powerup_animations
if !ENABLE_POSE_DEBUG == !yes
    jsr debug_pose_viewer
endif
    jsr setup_player_exgfx
    jsr smooth_animations
    jsr tilemap_handling
    jsr setup_player_displacements

    plb
    jml $00E3C0|!bank


;################################################
;# Runs powerup specific pose handling

powerup_animations:
    lda !player_powerup
    rep #$30
    and #$00FF
    asl 
    tax 
    lda.w .powerup_image_pointers,x
    sta $00
    sep #$30
    ldx #$00
    jsr ($0000|!dp,x)
.return_image
    rts 

.powerup_image_pointers
    !i #= 0
    while !i < !max_powerup_num
        %internal_number_to_string(!i)
        if stringsequal("!{powerup_!{_num}_path}", "0")
            dw player_poses_handler_return_image
        else
            dw powerup_!{_num}_image
        endif
        !i #= !i+1
    endif

.powerup_image_codes
    !i #= 0
    while !i < !max_powerup_num
        %internal_number_to_string(!i)
        if not(stringsequal("!{powerup_!{_num}_path}", "0"))
            powerup_!{_num}_image:
                incsrc "../!{powerup_!{_num}_path}/!{powerup_!{_num}_internal_name}_image_code.asm"
        endif
        !i #= !i+1
    endif

;################################################
;# Global animations

    incsrc "../graphics/global_animations.asm"

;################################################
;# Runs graphic set specific tilemap handling code

tilemap_handling:
    lda !player_graphics_index
    rep #$30
    and #$00FF
    asl 
    tax 
    lda.w .tilemap_logic_pointers,x
    sta $00
    sep #$30
    ldx #$00
    jsr ($0000|!dp,x)
.return
    rts

.tilemap_logic_pointers
    !i #= 0
    while !i < !max_gfx_num
        %internal_number_to_string(!i)
        if stringsequal("!{gfx_!{_num}_path}", "0")
            dw tilemap_handling_return
        else
            if !{gfx_!{_num}_tilemap_exist} == 1
                dw gfx_!{_num}_tilemap
            else 
                dw $FFFF
            endif
        endif
        !i #= !i+1
    endif

.tilemap_data
    !i #= 0
    while !i < !max_gfx_num
        %internal_number_to_string(!i)
        if stringsequal("!{gfx_!{_num}_path}", "0")
            dw $FFFF
        else
            if !{gfx_!{_num}_tilemap_exist} == 1
                dw gfx_!{_num}_tilemap_tilemap
            else 
                dw $FFFF
            endif
        endif
        !i #= !i+1
    endif

.tilemap_logic_codes
    !i #= 0
    while !i < !max_gfx_num
        %internal_number_to_string(!i)
        if not(stringsequal("!{gfx_!{_num}_path}", "0"))
            if !{gfx_!{_num}_tilemap_exist} == 1
                gfx_!{_num}_tilemap:
                    incsrc "../!{gfx_!{_num}_path}/!{gfx_!{_num}_internal_name}_tilemap.asm"
            endif
        endif
        !i #= !i+1
    endif

;################################################
;# Prepares player ExGFX data for later usage

setup_player_exgfx:
    lda !player_graphics_bypass
    bne .skip_setting_index
.regular_gfx_rules
    rep #$20
    lda !player_powerup
    and #$00FF
    ldx !player_num
    beq .p1
.p2 
    clc 
    adc.w #!max_powerup_num
.p1 
    rep #$10
    tax 
    sep #$20
    lda.l .index,x
    sta !player_graphics_index
    lda.l .extra_index,x
    sta !player_graphics_extra_index
    sep #$10
.skip_setting_index
    rts 

.index
    !i #= 0
    while !i < !max_powerup_num
        %internal_number_to_string(!i)
        if defined("powerup_!{_num}_p1_gfx_index")
            db !{powerup_!{_num}_p1_gfx_index}
        else
            db $00
        endif
        !i #= !i+1
    endif
    !i #= 0
    while !i < !max_powerup_num
        %internal_number_to_string(!i)
        if defined("powerup_!{_num}_p2_gfx_index")
            db !{powerup_!{_num}_p2_gfx_index}
        else
            db $00
        endif
        !i #= !i+1
    endif

.extra_index
    !i #= 0
    while !i < !max_powerup_num
        %internal_number_to_string(!i)
        if defined("powerup_!{_num}_p1_extra_gfx_index")
            db !{powerup_!{_num}_p1_extra_gfx_index}
        else
            db $00
        endif
        !i #= !i+1
    endif
    !i #= 0
    while !i < !max_powerup_num
        %internal_number_to_string(!i)
        if defined("powerup_!{_num}_p2_extra_gfx_index")
            db !{powerup_!{_num}_p2_extra_gfx_index}
        else
            db $00
        endif
        !i #= !i+1
    endif

;################################################
;# Prepares player displacements for later usage

setup_player_displacements:
    lda !player_graphics_index
    rep #$20
    and #$00FF
    asl 
    tax 
    lda.w player_x_disp_handler_pointers,x
    sta $6B
    lda.w player_y_disp_handler_pointers,x
    sta $6E
    ldx.b #bank(player_x_disp_handler_pointers)
    stx $6D
    ldx.b #bank(player_y_disp_handler_pointers)
    stx $70
    sep #$20
    rts 

;################################################
;# X displacements for the player

player_x_disp_handler:
    pha
    lda !player_graphics_disp_settings
    lsr 
    bcs .ram_table
.rom_table
    pla 
    phy
    txy 
    adc [$6B],y
    ply 
    rtl
.ram_table
    pla 
    clc 
    adc !player_graphics_x_disp,x
    rtl

.pointers
    !i #= 0
    while !i < !max_gfx_num
        %internal_number_to_string(!i)
        if stringsequal("!{gfx_!{_num}_path}", "0")
            dw $FFFF
        else
            if !{gfx_!{_num}_tilemap_exist} == 1
                dw gfx_!{_num}_tilemap_x_disp
            else 
                dw $FFFF
            endif
        endif
        !i #= !i+1
    endif


;################################################
;# Y displacements for the player

player_y_disp_handler:
    pha
    lda !player_graphics_disp_settings
    lsr 
    bcs .ram_table
.rom_table
    pla 
    phy
    txy 
    adc [$6E],y
    ply 
    rtl
.ram_table
    pla 
    clc 
    adc !player_graphics_y_disp,x
    rtl


.pointers
    !i #= 0
    while !i < !max_gfx_num
        %internal_number_to_string(!i)
        if stringsequal("!{gfx_!{_num}_path}", "0")
            dw $FFFF
        else
            if !{gfx_!{_num}_tilemap_exist} == 1
                dw gfx_!{_num}_tilemap_y_disp
            else 
                dw $FFFF
            endif
        endif
        !i #= !i+1
    endif


;################################################
;# Separate the file for animations

    incsrc "animation_logic.asm"

;################################################
;# Debug: Pose viewer

if !ENABLE_POSE_DEBUG == !yes
debug_pose_viewer:
    lda $71
    bne ++
    lda $16
    and #$04
    beq +
    lda !debug_ram
    dec 
    bmi +
    sta !debug_ram
+   
    lda $16
    and #$08
    beq +
    lda !debug_ram
    inc 
    cmp #$80
    bcs +
    sta !debug_ram
+   
    lda !debug_ram
    sta !player_pose_num
++
    rts 
endif


