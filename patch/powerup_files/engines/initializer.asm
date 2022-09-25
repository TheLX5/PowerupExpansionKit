includefrom "powerup.asm"

pushpc
    org $0093BB|!bank
        autoclean jml init_ram
    org $0093C0|!bank
        init_ram_end:
pullpc

init_ram:
    lda #$AA            ; restore code
    sta $0400|!addr

    lda #$00
    sta !player_graphics_bypass
    sta !player_graphics_index
    sta !player_graphics_extra_index
    sta !player_graphics_disp_settings
    sta !player_extra_tile_settings
    sta !player_palette_bypass
    sta !player_collision_flag
    sta !player_hitbox_flag
    sta !player_toggle_crouch
    sta !player_toggle_slide
    sta !player_toggle_spinjump
    sta !player_toggle_ride_yoshi
    sta !player_toggle_extended_hurt
    sta !player_disable_itembox
    sta !player_backup_blocked_status
    sta !player_backup_slippery_status
    sta !mask_controller_15
    sta !mask_controller_17

    jml init_ram_end