vanilla_primary_animation_logic:
.main
    phb 
    lda #$00
    pha 
    plb 
    lda $14A2|!addr
    bne .player_is_cape_spinning
    ldx $13DF|!addr
    lda !player_in_air
    beq .player_on_ground
    ldy #$04
    bit !player_y_speed
    bpl .player_is_falling
    cmp #$0C
    beq .player_is_shot_out_of_pipe
    lda !player_in_water
    bne .player_in_water
    bra .player_is_not_in_water

.player_is_falling
    inx 
    cpx #$05
    bcs +
    ldx #$05
    bra .write_cape_frame
+   
    cpx #$0B
    bcc .write_cape_frame
    ldx #$07
    bra .write_cape_frame

.player_on_ground
    lda !player_x_speed
    bne .player_is_moving
    ldy #$08
.player_is_not_in_water
    txa 
    beq .write_cape_frame
    dex 
    cpx #$03
    bcc .write_cape_frame
    ldx #$02
    bra .write_cape_frame

.player_is_moving
    bpl +
    eor #$FF
    inc
+   
    lsr #3
    tay 
    lda.w $DC7C,y
    tay 
.player_is_shot_out_of_pipe
.player_in_water

.process_cape_flapping_anim
    inx 
    cpx #$03
    bcs +
    ldx #$05
+   
    cpx #$07
    bcc +
    ldx #$03
+   
.write_cape_frame
    stx $13DF|!addr
    tya 
    ldy !player_in_water
    beq ..not_in_water
    asl 
..not_in_water
    sta $14A2|!addr
.player_is_cape_spinning

.process_spinning
    lda !player_spinjump
    ora $14A6|!addr
    beq .not_spinning
    stz $73
    lda $14
    and #$06
    tay 
    lsr 
    tax 
    lda !player_in_air
    beq +
    lda !player_y_speed
    bmi +
    iny 
+   
    lda $CEA9,y
    sta $13DF|!addr 
    lda $CEA1,x
    sta !player_direction
    ldy !player_powerup
    cpy #$02
    bne .no_cape
    jsl cape_spin_interaction
.no_cape
    txy 
    lda [$06],y 
    jmp .write_player_frame

.not_spinning
.process_sliding
    lda !player_sliding
    beq ..not_sliding
    bpl ..player_is_sliding
    lda $13E1|!addr
    lsr #2
    ora $76
    tay 
    lda $CE7F,y
    jmp .write_player_frame
..player_is_sliding
    lda !player_sliding_pose
    jmp .write_player_frame
..not_sliding

.process_crouching
    lda !player_crouching_pose
    ldy !player_holding
    beq ..not_holding_item
    lda !player_crouching_with_item_pose
..not_holding_item
    ldy !player_crouching
    bne .long_write_player_frame

.process_fireball
    lda !player_shoot_pose_timer
    beq .not_shooting_fireball
    lda !player_shooting_fireball_pose
    ldy !player_in_air
    beq ..not_in_ground
    lda !player_shooting_fireball_in_air_pose
..not_in_ground
    jmp .write_player_frame
.not_shooting_fireball

.process_kicking
    lda !player_kicking_pose
    ldy !player_kicking
    beq .not_kicking
.long_write_player_frame
    jmp .write_player_frame
.not_kicking

.process_pickup
    lda !player_pick_up_pose
    ldy !player_picking_up
    bne .long_write_player_frame

.process_facing_screen
    lda !player_facing_screen_pose
    ldy !player_facing_screen
    bne .long_write_player_frame

.process_idle
    lda !player_idle_pose
    ldy !player_in_cloud
    beq +
    jmp .player_is_stationary
+
    ldy !player_in_air
    beq ..player_in_ground
    lda !player_jump_pose
    cpy #$0B
    beq ..force_air_frame
    lda !player_jump_max_speed_pose
    cpy #$0C
    beq ..force_air_frame
    lda !player_falling_pose
    cpy #$24
    beq ..force_air_frame
    tya 
..force_air_frame
    ldy $14A0|!addr
    bne .player_just_jumped
    ldy $1407|!addr
    beq ..player_is_not_flying
    lda $CE79-1,y
..player_is_not_flying
    ldy !player_holding
    beq .long_write_player_frame
    lda !player_jump_carry_pose
    bra .long_write_player_frame
..player_in_ground

.process_in_ground
    lda !player_turning_around
    beq .player_just_jumped
    lda !player_braking_pose
    bra .long_write_player_frame
.player_just_jumped
    lda !player_x_speed
    bpl +
    eor #$FF
    inc 
+   
    tax 
    bne .process_moving
..process_looking_up


    xba 
    lda $15
    and #$08
    beq .player_is_stationary
    lda #$03
    sta !player_looking_up
    bra .player_is_stationary

.process_moving
    lda $86
    beq ..not_slippery
    lda $15
    and #$03
    beq .dont_update_pose
    lda #$68
    sta $13E5|!addr
..not_slippery
    lda $13DB|!addr
    ldy $1496|!addr
    bne .dont_update_pose
    dec 
    bpl ..dont_get_new_frame
    lda !player_walking_frames
    dec 
..dont_get_new_frame
    xba 
    txa 
    lsr #3
    ora $13E5|!addr
    tay 
    lda [$00],y
    sta $1496|!addr
.player_is_stationary
    xba 
.dont_update_pose
    sta $13DB|!addr
    clc 
    adc $13DE|!addr
    tax 
.walking_logic
    lda $13E3|!addr
    bne ..wallrunning
    lda !player_holding
    beq ..no_carry
    lda !player_x_speed
    bne ..no_idle_carry
    lda !player_looking_up
    bne +
    lda !player_idle_carry_pose
    jmp ..idle
+   
    lda !player_looking_up_carry_pose
    jmp ..idle
..no_idle_carry
    txa 
    clc 
    adc !player_walking_frames
    adc !player_walking_frames
    tax 
    jmp ..do_things
..wallrunning
    lda $13E3|!addr
    beq ..wallrunning
    tay 
    and #$01
    sta !player_direction
    lda !player_angled_pose
    cpy #$06
    bcc ..idle
    txa 
    clc 
    adc !player_walking_frames
    adc !player_walking_frames
    adc !player_walking_frames
    tax 
    bra ..do_things
..no_carry
    lda $14A0|!addr
    cmp #$10
    ora $13E4|!addr
    cmp #$70
    bcc ..not_idle
    txa 
    clc 
    adc !player_walking_frames
    tax 
    bra ..do_things
..not_idle
    lda !player_x_speed
    bne ..do_things
    lda !player_looking_up
    bne +
    lda !player_idle_pose
    bra ..idle
+   
    lda !player_looking_up_pose
    bra ..idle
..do_things
    txy 
    lda [$03],y
..idle 
.write_player_frame
    sta !player_pose_num
    plb 
    rts 

.coming_from_horz_pipe
    phb 
    lda #$00
    pha 
    plb 
    jmp .player_just_jumped
