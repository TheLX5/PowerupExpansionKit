;################################################
;# Edit amount of walking poses

player_primary_animation_logic:
    phb 
    phk 
    plb 
    lda !player_graphics_index 
    tax
    lda.w .walk_frames,x
    inc 
    sta !player_walking_frames                  ; This is extremely wrong, should be rewritten at some point lol
    lda.w .idle_pose,x 
    sta !player_idle_pose
    lda.w .idle_carry_pose,x
    sta !player_idle_carry_pose
    lda.w .angled_pose,x 
    sta !player_angled_pose
    lda.w .looking_up_pose,x 
    sta !player_looking_up_pose
    lda.w .looking_up_carry_pose,x 
    sta !player_looking_up_carry_pose
    lda.w .crouching_pose,x
    sta !player_crouching_pose
    lda.w .crouching_with_item_pose,x
    sta !player_crouching_with_item_pose
    lda.w .shooting_fireball_pose,x
    sta !player_shooting_fireball_pose
    lda.w .shooting_fireball_in_air_pose,x
    sta !player_shooting_fireball_in_air_pose
    lda.w .kicking_pose,x
    sta !player_kicking_pose
    lda.w .pick_up_pose,x
    sta !player_pick_up_pose
    lda.w .facing_screen_pose,x
    sta !player_facing_screen_pose
    lda.w .jump_carry_pose,x
    sta !player_jump_carry_pose
    lda.w .jump_pose,x
    sta !player_jump_pose
    lda.w .jump_max_speed_pose,x
    sta !player_jump_max_speed_pose
    lda.w .falling_pose,x
    sta !player_falling_pose
    lda.w .braking_pose,x
    sta !player_braking_pose
    lda.w .sliding_pose,x
    sta !player_sliding_pose
    rep #$20
    lda !player_graphics_index 
    and #$00FF
    asl 
    tax 
    lda.w .animation_logic_ptrs,x
    sta $0E
    lda.w .spin_anim_ptrs,x
    sta $06
    lda.w .walk_timer_ptrs,x
    sta $00
    lda.w .walk_anim_ptrs,x
    sta $03
    sep #$30
    phk 
    pla 
    sta $02
    sta $05
    sta $08
    plb 
    ldx #$00
    jsr ($000E|!dp,x)
.return 
    rtl 

.horz_pipe
    phb 
    phk 
    plb 
    rep #$20
    lda !player_graphics_index 
    and #$00FF
    asl 
    tax 
    lda.w .animation_logic_ptrs,x
    clc 
    adc #$0003
    sta $0E
    lda.w .walk_timer_ptrs,x
    sta $00
    lda.w .walk_anim_ptrs,x
    sta $03
    sep #$30
    phk 
    pla 
    sta $02
    sta $05
    plb 
    ldx #$00
    jsr ($000E|!dp,x)
    rtl 


.animation_logic_ptrs
    !i #= 0
    while !i < !max_gfx_num
        %internal_number_to_string(!i)
        if stringsequal("!{gfx_!{_num}_path}", "0")
            dw .return
        else
            if !{gfx_!{_num}_tilemap_exist} == 1
                dw gfx_!{_num}_tilemap_animation_logic
            else 
                dw .return
            endif
        endif
        !i #= !i+1
    endif

.walk_anim_ptrs
    !i #= 0
    while !i < !max_gfx_num
        %internal_number_to_string(!i)
        if stringsequal("!{gfx_!{_num}_path}", "0")
            dw $FFFF
        else
            if !{gfx_!{_num}_tilemap_exist} == 1
                dw gfx_!{_num}_tilemap_walk_animations
            else 
                dw $FFFF
            endif
        endif
        !i #= !i+1
    endif
    
.walk_timer_ptrs
    !i #= 0
    while !i < !max_gfx_num
        %internal_number_to_string(!i)
        if stringsequal("!{gfx_!{_num}_path}", "0")
            dw $FFFF
        else
            if !{gfx_!{_num}_tilemap_exist} == 1
                dw gfx_!{_num}_tilemap_walk_timers
            else 
                dw $FFFF
            endif
        endif
        !i #= !i+1
    endif

.spin_anim_ptrs
    !i #= 0
    while !i < !max_gfx_num
        %internal_number_to_string(!i)
        if stringsequal("!{gfx_!{_num}_path}", "0")
            dw $FFFF
        else
            if !{gfx_!{_num}_tilemap_exist} == 1
                dw gfx_!{_num}_tilemap_spin_animation
            else 
                dw $FFFF
            endif
        endif
        !i #= !i+1
    endif

.walk_frames
    !i #= 0
    while !i < !max_gfx_num
        %internal_number_to_string(!i)
        if stringsequal("!{gfx_!{_num}_path}", "0")
            db $02
        else 
            if defined("gfx_!{_num}_walk_frames")
                db !{gfx_!{_num}_walk_frames}-1
            else
                db $02
            endif
        endif
        !i #= !i+1
    endif

    
.idle_pose
    !i #= 0
    while !i < !max_gfx_num
        %internal_number_to_string(!i)
        if stringsequal("!{gfx_!{_num}_path}", "0")
            db $00
        else 
            if defined("gfx_!{_num}_idle_pose")
                db !{gfx_!{_num}_idle_pose}
            else
                db $00
            endif
        endif
        !i #= !i+1
    endif

.idle_carry_pose
    !i #= 0
    while !i < !max_gfx_num
        %internal_number_to_string(!i)
        if stringsequal("!{gfx_!{_num}_path}", "0")
            db $07
        else 
            if defined("gfx_!{_num}_idle_carry_pose")
                db !{gfx_!{_num}_idle_carry_pose}
            else
                db $07
            endif
        endif
        !i #= !i+1
    endif

.looking_up_pose
    !i #= 0
    while !i < !max_gfx_num
        %internal_number_to_string(!i)
        if stringsequal("!{gfx_!{_num}_path}", "0")
            db $03
        else 
            if defined("gfx_!{_num}_looking_up_pose")
                db !{gfx_!{_num}_looking_up_pose}
            else
                db $03
            endif
        endif
        !i #= !i+1
    endif
.looking_up_carry_pose
    !i #= 0
    while !i < !max_gfx_num
        %internal_number_to_string(!i)
        if stringsequal("!{gfx_!{_num}_path}", "0")
            db $0A
        else 
            if defined("gfx_!{_num}_looking_up_carry_pose")
                db !{gfx_!{_num}_looking_up_carry_pose}
            else
                db $0A
            endif
        endif
        !i #= !i+1
    endif

.angled_pose
    !i #= 0
    while !i < !max_gfx_num
        %internal_number_to_string(!i)
        if stringsequal("!{gfx_!{_num}_path}", "0")
            db $10
        else 
            if defined("gfx_!{_num}_angled_pose")
                db !{gfx_!{_num}_angled_pose}
            else
                db $10
            endif
        endif
        !i #= !i+1
    endif


.crouching_pose
    !i #= 0
    while !i < !max_gfx_num
        %internal_number_to_string(!i)
        if stringsequal("!{gfx_!{_num}_path}", "0")
            db $3C
        else 
            if defined("gfx_!{_num}_crouching_pose")
                db !{gfx_!{_num}_crouching_pose}
            else
                db $3C
            endif
        endif
        !i #= !i+1
    endif

.crouching_with_item_pose
    !i #= 0
    while !i < !max_gfx_num
        %internal_number_to_string(!i)
        if stringsequal("!{gfx_!{_num}_path}", "0")
            db $1D
        else 
            if defined("gfx_!{_num}_crouching_with_item_pose")
                db !{gfx_!{_num}_crouching_with_item_pose}
            else
                db $1D
            endif
        endif
        !i #= !i+1
    endif
    
.shooting_fireball_pose
    !i #= 0
    while !i < !max_gfx_num
        %internal_number_to_string(!i)
        if stringsequal("!{gfx_!{_num}_path}", "0")
            db $3F
        else 
            if defined("gfx_!{_num}_shooting_fireball_pose")
                db !{gfx_!{_num}_shooting_fireball_pose}
            else
                db $3F
            endif
        endif
        !i #= !i+1
    endif

.shooting_fireball_in_air_pose
    !i #= 0
    while !i < !max_gfx_num
        %internal_number_to_string(!i)
        if stringsequal("!{gfx_!{_num}_path}", "0")
            db $16
        else 
            if defined("gfx_!{_num}_shooting_fireball_in_air_pose")
                db !{gfx_!{_num}_shooting_fireball_in_air_pose}
            else
                db $16
            endif
        endif
        !i #= !i+1
    endif
    
.kicking_pose
    !i #= 0
    while !i < !max_gfx_num
        %internal_number_to_string(!i)
        if stringsequal("!{gfx_!{_num}_path}", "0")
            db $0E
        else 
            if defined("gfx_!{_num}_kicking_pose")
                db !{gfx_!{_num}_kicking_pose}
            else
                db $0E
            endif
        endif
        !i #= !i+1
    endif
    
.pick_up_pose
    !i #= 0
    while !i < !max_gfx_num
        %internal_number_to_string(!i)
        if stringsequal("!{gfx_!{_num}_path}", "0")
            db $1D
        else 
            if defined("gfx_!{_num}_pick_up_pose")
                db !{gfx_!{_num}_pick_up_pose}
            else
                db $1D
            endif
        endif
        !i #= !i+1
    endif
    
.facing_screen_pose
    !i #= 0
    while !i < !max_gfx_num
        %internal_number_to_string(!i)
        if stringsequal("!{gfx_!{_num}_path}", "0")
            db $0F
        else 
            if defined("gfx_!{_num}_facing_screen_pose")
                db !{gfx_!{_num}_facing_screen_pose}
            else
                db $0F
            endif
        endif
        !i #= !i+1
    endif

.jump_carry_pose
    !i #= 0
    while !i < !max_gfx_num
        %internal_number_to_string(!i)
        if stringsequal("!{gfx_!{_num}_path}", "0")
            db $09
        else 
            if defined("gfx_!{_num}_jump_carry_pose")
                db !{gfx_!{_num}_jump_carry_pose}
            else
                db $09
            endif
        endif
        !i #= !i+1
    endif

.jump_pose
    !i #= 0
    while !i < !max_gfx_num
        %internal_number_to_string(!i)
        if stringsequal("!{gfx_!{_num}_path}", "0")
            db $0B
        else 
            if defined("gfx_!{_num}_jump_pose")
                db !{gfx_!{_num}_jump_pose}
            else
                db $0B
            endif
        endif
        !i #= !i+1
    endif

.jump_max_speed_pose
    !i #= 0
    while !i < !max_gfx_num
        %internal_number_to_string(!i)
        if stringsequal("!{gfx_!{_num}_path}", "0")
            db $0C
        else 
            if defined("gfx_!{_num}_jump_max_speed_pose")
                db !{gfx_!{_num}_jump_max_speed_pose}
            else
                db $0C
            endif
        endif
        !i #= !i+1
    endif

.falling_pose
    !i #= 0
    while !i < !max_gfx_num
        %internal_number_to_string(!i)
        if stringsequal("!{gfx_!{_num}_path}", "0")
            db $24
        else 
            if defined("gfx_!{_num}_falling_pose")
                db !{gfx_!{_num}_falling_pose}
            else
                db $24
            endif
        endif
        !i #= !i+1
    endif

.braking_pose
    !i #= 0
    while !i < !max_gfx_num
        %internal_number_to_string(!i)
        if stringsequal("!{gfx_!{_num}_path}", "0")
            db $0D
        else 
            if defined("gfx_!{_num}_braking_pose")
                db !{gfx_!{_num}_braking_pose}
            else
                db $0D
            endif
        endif
        !i #= !i+1
    endif

.sliding_pose
    !i #= 0
    while !i < !max_gfx_num
        %internal_number_to_string(!i)
        if stringsequal("!{gfx_!{_num}_path}", "0")
            db $1C
        else 
            if defined("gfx_!{_num}_sliding_pose")
                db !{gfx_!{_num}_sliding_pose}
            else
                db $1C
            endif
        endif
        !i #= !i+1
    endif

    incsrc "vanilla_primary_animation_logic.asm"

;################################################
;# Player peace pose handler

player_peace_pose_handler:
    phx 
    lda !player_graphics_index 
    tax
    lda.l .peace_pose,x
    ldy !player_in_yoshi
    beq .not_on_yoshi
    lda.l .peace_on_yoshi_pose,x
.not_on_yoshi
    plx 
    jml player_peace_pose_handler_return
    
.peace_pose
    !i #= 0
    while !i < !max_gfx_num
        %internal_number_to_string(!i)
        if stringsequal("!{gfx_!{_num}_path}", "0")
            db $26
        else 
            if defined("gfx_!{_num}_peace_pose")
                db !{gfx_!{_num}_peace_pose}
            else
                db $26
            endif
        endif
        !i #= !i+1
    endif

.peace_on_yoshi_pose
    !i #= 0
    while !i < !max_gfx_num
        %internal_number_to_string(!i)
        if stringsequal("!{gfx_!{_num}_path}", "0")
            db $14
        else 
            if defined("gfx_!{_num}_peace_on_yoshi_pose")
                db !{gfx_!{_num}_peace_on_yoshi_pose}
            else
                db $14
            endif
        endif
        !i #= !i+1
    endif

;################################################
;# In Yoshi animations

player_on_yoshi_pose_handler:
    lda !player_graphics_index 
    tax
    lda.l .on_yoshi_idle_pose,x
    sta $01
    lda.l .on_yoshi_turning_pose,x
    sta $02
    lda.l .on_yoshi_spitting_tongue_1_pose,x
    sta $03
    lda.l .on_yoshi_spitting_tongue_2_pose,x
    sta $04
    lda.l .on_yoshi_crouching_pose,x
    sta $00
    ldx $14A3|!addr
    beq +
    ldy #$03
    cpx #$0C
    bcs +
    ldy #$04
+   
    lda $0000|!dp,y
    dey 
    bne +
    ldy !player_crouching
    beq +
    lda $00
+   
    jml player_on_yoshi_pose_handler_return
    

.on_yoshi_idle_pose
    !i #= 0
    while !i < !max_gfx_num
        %internal_number_to_string(!i)
        if stringsequal("!{gfx_!{_num}_path}", "0")
            db $20
        else 
            if defined("gfx_!{_num}_on_yoshi_idle_pose")
                db !{gfx_!{_num}_on_yoshi_idle_pose}
            else
                db $20
            endif
        endif
        !i #= !i+1
    endif

.on_yoshi_turning_pose
    !i #= 0
    while !i < !max_gfx_num
        %internal_number_to_string(!i)
        if stringsequal("!{gfx_!{_num}_path}", "0")
            db $21
        else 
            if defined("gfx_!{_num}_on_yoshi_turning_pose")
                db !{gfx_!{_num}_on_yoshi_turning_pose}
            else
                db $21
            endif
        endif
        !i #= !i+1
    endif

.on_yoshi_crouching_pose
    !i #= 0
    while !i < !max_gfx_num
        %internal_number_to_string(!i)
        if stringsequal("!{gfx_!{_num}_path}", "0")
            db $1D
        else 
            if defined("gfx_!{_num}_on_yoshi_crouching_pose")
                db !{gfx_!{_num}_on_yoshi_crouching_pose}
            else
                db $1D
            endif
        endif
        !i #= !i+1
    endif

.on_yoshi_spitting_tongue_1_pose
    !i #= 0
    while !i < !max_gfx_num
        %internal_number_to_string(!i)
        if stringsequal("!{gfx_!{_num}_path}", "0")
            db $27
        else 
            if defined("gfx_!{_num}_on_yoshi_spitting_tongue_1_pose")
                db !{gfx_!{_num}_on_yoshi_spitting_tongue_1_pose}
            else
                db $27
            endif
        endif
        !i #= !i+1
    endif

.on_yoshi_spitting_tongue_2_pose
    !i #= 0
    while !i < !max_gfx_num
        %internal_number_to_string(!i)
        if stringsequal("!{gfx_!{_num}_path}", "0")
            db $28
        else 
            if defined("gfx_!{_num}_on_yoshi_spitting_tongue_2_pose")
                db !{gfx_!{_num}_on_yoshi_spitting_tongue_2_pose}
            else
                db $28
            endif
        endif
        !i #= !i+1
    endif


;################################################
;# Death pose & animation

player_death_pose_handler:
    phx 
    lda !player_graphics_index 
    tax 
    lda.l .death_pose,x
    sta !player_pose_num
    plx
    jml player_death_pose_handler_return
    
.death_pose
    !i #= 0
    while !i < !max_gfx_num
        %internal_number_to_string(!i)
        if stringsequal("!{gfx_!{_num}_path}", "0")
            db $3E
        else 
            if defined("gfx_!{_num}_death_pose")
                db !{gfx_!{_num}_death_pose}
            else
                db $3E
            endif
        endif
        !i #= !i+1
    endif

player_death_animation_handler:
    phx 
    rep #$20
    lda !player_graphics_index 
    and #$00FF
    asl 
    tax 
    lda.l .death_logic_ptrs,x
    sta $0E
    sep #$20
    ldx #$00
    jsr ($000E|!dp,x)
.return2
    plx 
    jml player_death_animation_handler_return

.death_logic_ptrs
    !i #= 0
    while !i < !max_gfx_num
        %internal_number_to_string(!i)
        if stringsequal("!{gfx_!{_num}_path}", "0")
            dw .return2
        else
            if !{gfx_!{_num}_tilemap_exist} == 1
                dw gfx_!{_num}_tilemap_death_animation
            else 
                dw .return2
            endif
        endif
        !i #= !i+1
    endif

vanilla_death_animation:
    stz !player_x_speed
    jsl player_update_speeds
    jsl player_apply_gravity
    lda $13
    lsr #2
    and #$01
    sta !player_direction
    rts 

;################################################
;# Growing/Shrink animation poses
    
player_grow_shrink_pose_handler:
    phb
    phk 
    plb 
    phx 
    tay 
    rep #$20
    lda !player_graphics_index 
    and #$00FF
    asl 
    tax 
    lda.w .growing_shrinking_animation_ptrs,x
    sta $00
    sep #$20
    lda ($00),y
    plx 
    plb 
    rtl

.growing_shrinking_animation_ptrs
    !i #= 0
    while !i < !max_gfx_num
        %internal_number_to_string(!i)
        if stringsequal("!{gfx_!{_num}_path}", "0")
            dw $FFFF
        else
            if !{gfx_!{_num}_tilemap_exist} == 1
                dw gfx_!{_num}_tilemap_growing_shrinking_animation
            else 
                dw $FFFF
            endif
        endif
        !i #= !i+1
    endif


;################################################
;# Flower animation pose

player_grab_flower_pose_handler:
    sta $13ED|!addr
    phx 
    lda !player_graphics_index 
    tax 
    lda.l .grab_flower_pose,x
    sta !player_pose_num
    plx
    jml player_grab_flower_pose_handler_return
    
.grab_flower_pose
    !i #= 0
    while !i < !max_gfx_num
        %internal_number_to_string(!i)
        if stringsequal("!{gfx_!{_num}_path}", "0")
            db $00
        else 
            if defined("gfx_!{_num}_grab_flower_pose")
                db !{gfx_!{_num}_grab_flower_pose}
            else
                db $00
            endif
        endif
        !i #= !i+1
    endif

    
;################################################
;# Entering a door pose

player_entering_door_pose_handler:
    lda !player_in_yoshi
    beq .ignore
    phx 
    lda !player_graphics_index 
    tax 
    lda.l .enter_door_pipe_on_yoshi,x
    sta !player_pose_num
    plx
.ignore
    jml player_entering_door_pose_handler_return

.enter_door_pipe_on_yoshi
    !i #= 0
    while !i < !max_gfx_num
        %internal_number_to_string(!i)
        if stringsequal("!{gfx_!{_num}_path}", "0")
            db $00
        else 
            if defined("gfx_!{_num}_enter_door_pipe_on_yoshi_pose")
                db !{gfx_!{_num}_enter_door_pipe_on_yoshi_pose}
            else
                db $00
            endif
        endif
        !i #= !i+1
    endif
    
;################################################
;# Entering a vertical pipe pose

player_vertical_pipe_pose_handler:
    lda !player_graphics_index 
    tax
    lda $89
    and #$03
    cmp #$02
    beq .go_up
.go_down
    lda $89
    and #$04
    beq ..entering
..exiting
    lda.l .exit_vertical_pipe_down_on_yoshi_pose,x
    sta $00
    lda.l .exit_vertical_pipe_down_carry_pose,x
    sta $01
    lda.l .exit_vertical_pipe_down_pose,x
    bra .end
..entering
    lda.l .enter_vertical_pipe_down_on_yoshi_pose,x
    sta $00
    lda.l .enter_vertical_pipe_down_carry_pose,x
    sta $01
    lda.l .enter_vertical_pipe_down_pose,x
    bra .end
.go_up
    lda $89
    and #$04
    beq ..entering
..exiting
    lda.l .exit_vertical_pipe_up_on_yoshi_pose,x
    sta $00
    lda.l .exit_vertical_pipe_up_carry_pose,x
    sta $01
    lda.l .exit_vertical_pipe_up_pose,x
    bra .end
..entering
    lda.l .enter_vertical_pipe_up_on_yoshi_pose,x
    sta $00
    lda.l .enter_vertical_pipe_up_carry_pose,x
    sta $01
    lda.l .enter_vertical_pipe_up_pose,x
.end
    ldy !player_holding
    bne +
    ldy !player_in_yoshi
    jml player_vertical_pipe_pose_handler_return
+   
    lda $01
    jml player_vertical_pipe_pose_handler_carry_return

.enter_vertical_pipe_up_pose
    !i #= 0
    while !i < !max_gfx_num
        %internal_number_to_string(!i)
        if stringsequal("!{gfx_!{_num}_path}", "0")
            db $0F
        else 
            if defined("gfx_!{_num}_enter_vertical_pipe_up_pose")
                db !{gfx_!{_num}_enter_vertical_pipe_up_pose}
            else
                db $0F
            endif
        endif
        !i #= !i+1
    endif
.enter_vertical_pipe_down_pose
    !i #= 0
    while !i < !max_gfx_num
        %internal_number_to_string(!i)
        if stringsequal("!{gfx_!{_num}_path}", "0")
            db $0F
        else 
            if defined("gfx_!{_num}_enter_vertical_pipe_down_pose")
                db !{gfx_!{_num}_enter_vertical_pipe_down_pose}
            else
                db $0F
            endif
        endif
        !i #= !i+1
    endif
.exit_vertical_pipe_up_pose
    !i #= 0
    while !i < !max_gfx_num
        %internal_number_to_string(!i)
        if stringsequal("!{gfx_!{_num}_path}", "0")
            db $0F
        else 
            if defined("gfx_!{_num}_exit_vertical_pipe_up_pose")
                db !{gfx_!{_num}_exit_vertical_pipe_up_pose}
            else
                db $0F
            endif
        endif
        !i #= !i+1
    endif
.exit_vertical_pipe_down_pose
    !i #= 0
    while !i < !max_gfx_num
        %internal_number_to_string(!i)
        if stringsequal("!{gfx_!{_num}_path}", "0")
            db $0F
        else 
            if defined("gfx_!{_num}_exit_vertical_pipe_down_pose")
                db !{gfx_!{_num}_exit_vertical_pipe_down_pose}
            else
                db $0F
            endif
        endif
        !i #= !i+1
    endif


    
.enter_vertical_pipe_up_on_yoshi_pose
    !i #= 0
    while !i < !max_gfx_num
        %internal_number_to_string(!i)
        if stringsequal("!{gfx_!{_num}_path}", "0")
            db $28
        else 
            if defined("gfx_!{_num}_enter_vertical_pipe_up_on_yoshi_pose")
                db !{gfx_!{_num}_enter_vertical_pipe_up_on_yoshi_pose}
            else
                db $2B
            endif
        endif
        !i #= !i+1
    endif
.enter_vertical_pipe_down_on_yoshi_pose
    !i #= 0
    while !i < !max_gfx_num
        %internal_number_to_string(!i)
        if stringsequal("!{gfx_!{_num}_path}", "0")
            db $28
        else 
            if defined("gfx_!{_num}_enter_vertical_pipe_down_on_yoshi_pose")
                db !{gfx_!{_num}_enter_vertical_pipe_down_on_yoshi_pose}
            else
                db $2B
            endif
        endif
        !i #= !i+1
    endif
.exit_vertical_pipe_up_on_yoshi_pose
    !i #= 0
    while !i < !max_gfx_num
        %internal_number_to_string(!i)
        if stringsequal("!{gfx_!{_num}_path}", "0")
            db $28
        else 
            if defined("gfx_!{_num}_exit_vertical_pipe_up_on_yoshi_pose")
                db !{gfx_!{_num}_exit_vertical_pipe_up_on_yoshi_pose}
            else
                db $2B
            endif
        endif
        !i #= !i+1
    endif
.exit_vertical_pipe_down_on_yoshi_pose
    !i #= 0
    while !i < !max_gfx_num
        %internal_number_to_string(!i)
        if stringsequal("!{gfx_!{_num}_path}", "0")
            db $28
        else 
            if defined("gfx_!{_num}_exit_vertical_pipe_down_on_yoshi_pose")
                db !{gfx_!{_num}_exit_vertical_pipe_down_on_yoshi_pose}
            else
                db $2B
            endif
        endif
        !i #= !i+1
    endif
    


.enter_vertical_pipe_up_carry_pose
    !i #= 0
    while !i < !max_gfx_num
        %internal_number_to_string(!i)
        if stringsequal("!{gfx_!{_num}_path}", "0")
            db $0F
        else 
            if defined("gfx_!{_num}_enter_vertical_pipe_up_carry_pose")
                db !{gfx_!{_num}_enter_vertical_pipe_up_carry_pose}
            else
                db $0F
            endif
        endif
        !i #= !i+1
    endif
.enter_vertical_pipe_down_carry_pose
    !i #= 0
    while !i < !max_gfx_num
        %internal_number_to_string(!i)
        if stringsequal("!{gfx_!{_num}_path}", "0")
            db $0F
        else 
            if defined("gfx_!{_num}_enter_vertical_pipe_down_carry_pose")
                db !{gfx_!{_num}_enter_vertical_pipe_down_carry_pose}
            else
                db $0F
            endif
        endif
        !i #= !i+1
    endif
.exit_vertical_pipe_up_carry_pose
    !i #= 0
    while !i < !max_gfx_num
        %internal_number_to_string(!i)
        if stringsequal("!{gfx_!{_num}_path}", "0")
            db $0F
        else 
            if defined("gfx_!{_num}_exit_vertical_pipe_up_carry_pose")
                db !{gfx_!{_num}_exit_vertical_pipe_up_carry_pose}
            else
                db $0F
            endif
        endif
        !i #= !i+1
    endif
.exit_vertical_pipe_down_carry_pose
    !i #= 0
    while !i < !max_gfx_num
        %internal_number_to_string(!i)
        if stringsequal("!{gfx_!{_num}_path}", "0")
            db $0F
        else 
            if defined("gfx_!{_num}_exit_vertical_pipe_down_carry_pose")
                db !{gfx_!{_num}_exit_vertical_pipe_down_carry_pose}
            else
                db $0F
            endif
        endif
        !i #= !i+1
    endif

;################################################
;# Swimming poses

player_swimming_pose_handler:
    phx 
    lda !player_graphics_index 
    tax
    lda.l .swimming_shooting_fireball_pose,x
    sta $06
    lda.l .swimming_shooting_fireball_carry_pose,x
    sta $07
    rep #$20
    lda !player_graphics_index 
    asl 
    tax 
    lda.l .swimming_pose_ptrs,x
    sta $00
    lda.l .swimming_carry_pose_ptrs,x
    sta $03
    sep #$20
    phk
    pla 
    sta $02
    sta $05
    ldy !player_shoot_pose_timer
    bne .shooting
    lda $1496|!addr
    beq .idle
    lsr #2
    and #$03
    inc 
.idle
    tay 
    lda [$00],y
    ldx !player_holding
    beq .write
    lda [$03],y
    bra .write
.shooting
    lda $06
    ldx !player_holding
    beq .write
    lda $07
.write
    plx 
    jml player_swimming_pose_handler_return

.swimming_pose_ptrs
    !i #= 0
    while !i < !max_gfx_num
        %internal_number_to_string(!i)
        if stringsequal("!{gfx_!{_num}_path}", "0")
            dw $FFFF
        else
            if !{gfx_!{_num}_tilemap_exist} == 1
                dw gfx_!{_num}_tilemap_swimming_animation
            else 
                dw $FFFF
            endif
        endif
        !i #= !i+1
    endif
    
.swimming_carry_pose_ptrs
    !i #= 0
    while !i < !max_gfx_num
        %internal_number_to_string(!i)
        if stringsequal("!{gfx_!{_num}_path}", "0")
            dw $FFFF
        else
            if !{gfx_!{_num}_tilemap_exist} == 1
                dw gfx_!{_num}_tilemap_swimming_carry_animation
            else 
                dw $FFFF
            endif
        endif
        !i #= !i+1
    endif
    
.swimming_shooting_fireball_pose
    !i #= 0
    while !i < !max_gfx_num
        %internal_number_to_string(!i)
        if stringsequal("!{gfx_!{_num}_path}", "0")
            db $28
        else 
            if defined("gfx_!{_num}_swimming_shooting_fireball_pose")
                db !{gfx_!{_num}_swimming_shooting_fireball_pose}
            else
                db $28
            endif
        endif
        !i #= !i+1
    endif
    
.swimming_shooting_fireball_carry_pose
    !i #= 0
    while !i < !max_gfx_num
        %internal_number_to_string(!i)
        if stringsequal("!{gfx_!{_num}_path}", "0")
            db $28
        else 
            if defined("gfx_!{_num}_swimming_shooting_fireball_carry_pose")
                db !{gfx_!{_num}_swimming_shooting_fireball_carry_pose}
            else
                db $28
            endif
        endif
        !i #= !i+1
    endif
    
;################################################
;# Climbing poses

player_climbing_pose_handler:
    phx 
    phy 
    txy 
    lda !player_graphics_index 
    tax 
    lda.l .climbing_back_pose,x
    cpy #$00
    beq .show_back
    lda.l .climbing_front_pose,x
.show_back
    sta !player_pose_num
    ply 
    plx 
    jml player_climbing_pose_handler_return

.climbing_back_pose
    !i #= 0
    while !i < !max_gfx_num
        %internal_number_to_string(!i)
        if stringsequal("!{gfx_!{_num}_path}", "0")
            db $15
        else 
            if defined("gfx_!{_num}_climbing_back_pose")
                db !{gfx_!{_num}_climbing_back_pose}
            else
                db $15
            endif
        endif
        !i #= !i+1
    endif

.climbing_front_pose
    !i #= 0
    while !i < !max_gfx_num
        %internal_number_to_string(!i)
        if stringsequal("!{gfx_!{_num}_path}", "0")
            db $22
        else 
            if defined("gfx_!{_num}_climbing_front_pose")
                db !{gfx_!{_num}_climbing_front_pose}
            else
                db $22
            endif
        endif
        !i #= !i+1
    endif

player_climbing_turning_pose_handler:
    phx 
    rep #$20
    lda !player_graphics_index 
    and #$00FF
    asl 
    tax 
    lda.l .climbing_turning_animation_ptrs,x
    sta $00
    sep #$20
    phk 
    pla 
    sta $02
    lda [$00],y
    plx 
    jml player_climbing_animaitons_handler_return
    
.climbing_turning_animation_ptrs
    !i #= 0
    while !i < !max_gfx_num
        %internal_number_to_string(!i)
        if stringsequal("!{gfx_!{_num}_path}", "0")
            dw $FFFF
        else
            if !{gfx_!{_num}_tilemap_exist} == 1
                dw gfx_!{_num}_tilemap_climbing_turning_animation
            else 
                dw $FFFF
            endif
        endif
        !i #= !i+1
    endif

player_climbing_punching_pose_handler:
    jsl cape_spin_interaction
    phx 
    phy 
    txy 
    rep #$20
    lda !player_graphics_index 
    and #$00FF
    asl 
    tax 
    lda.l .climbing_punching_animation_ptrs,x
    sta $00
    sep #$20
    phk 
    pla 
    sta $02
    lda [$00],y
    ply 
    plx 
    jml player_climbing_animaitons_handler_return

.climbing_punching_animation_ptrs
    !i #= 0
    while !i < !max_gfx_num
        %internal_number_to_string(!i)
        if stringsequal("!{gfx_!{_num}_path}", "0")
            dw $FFFF
        else
            if !{gfx_!{_num}_tilemap_exist} == 1
                dw gfx_!{_num}_tilemap_climbing_punching_animation
            else 
                dw $FFFF
            endif
        endif
        !i #= !i+1
    endif

;################################################
;# Stunned poie handler

player_stunned_pose_handler:
    stz !player_x_speed
    lda !player_graphics_index 
    tax 
    lda.l .stunned_pose,x
    rtl 
    
.stunned_pose
    !i #= 0
    while !i < !max_gfx_num
        %internal_number_to_string(!i)
        if stringsequal("!{gfx_!{_num}_path}", "0")
            db $00
        else 
            if defined("gfx_!{_num}_stunned_pose")
                db !{gfx_!{_num}_stunned_pose}
            else
                db $00
            endif
        endif
        !i #= !i+1
    endif
    
;################################################
;# P-Balloon poses

player_pballoon_pose_handler:
    phx
    lda !player_graphics_index 
    tax 
    lda.l .pballoon_pose,x
    dey 
    beq +
    sty $13F3|!addr
    lda.l .pballoon_transition_pose,x
+   
    plx
    jml player_pballoon_pose_handler_return

.pballoon_pose
    !i #= 0
    while !i < !max_gfx_num
        %internal_number_to_string(!i)
        if stringsequal("!{gfx_!{_num}_path}", "0")
            db $42
        else 
            if defined("gfx_!{_num}_pballoon_pose")
                db !{gfx_!{_num}_pballoon_pose}
            else
                db $42
            endif
        endif
        !i #= !i+1
    endif

.pballoon_transition_pose
    !i #= 0
    while !i < !max_gfx_num
        %internal_number_to_string(!i)
        if stringsequal("!{gfx_!{_num}_path}", "0")
            db $0F
        else 
            if defined("gfx_!{_num}_pballoon_transition_pose")
                db !{gfx_!{_num}_pballoon_transition_pose}
            else
                db $0F
            endif
        endif
        !i #= !i+1
    endif


;################################################
;# Handles player bopping

player_bopping:
    lda !player_graphics_index 
    asl 
    tax 
    ldy !player_pose_num
    rep #$20
    lda.l .bopping_ptrs,x
    sta $06
    sep #$20
    phk 
    pla 
    sta $08
    stz $02
    lda [$06],y
    rol #2
    and #$01
    sta $01
    lda [$06],y
    and #$7F
    sta $00

.horizontal_bopping
    lda #$05
    cmp !player_wallrunning
    bcs ..no_bop
    ldx $00
    cpx #$03
    bne ..may_bop
..might_bop
    eor #$01
..may_bop
    lsr 
..no_bop
    rep #$20
    lda !player_x_pos
    sbc $1A
    sta $7E

.vertical_bopping
    lda $188B|!addr
    and #$00FF
    clc 
    adc !player_y_pos
    ldy $01
    cpy #$01
    ldy #$01
    bcs ..may_bop
    dec 
    dey 
..may_bop
    ldx $00
    cpx #$01
    sec 
    bne ..not_in_range
    cpy $13DB|!addr
..not_in_range
    sbc $1C
    cpx #$04
    bne ..not_sliding
    adc #$0001
..not_sliding
    sta $80
    sep #$20
    jml $00E36D
.bopping_ptrs
    !i #= 0
    while !i < !max_gfx_num
        %internal_number_to_string(!i)
        if stringsequal("!{gfx_!{_num}_path}", "0")
            dw $FFFF
        else
            if !{gfx_!{_num}_tilemap_exist} == 1
                dw gfx_!{_num}_tilemap_bopping_index
            else 
                dw $FFFF
            endif
        endif
        !i #= !i+1
    endif

;################################################
;# Smooth animations handler

smooth_animations:
    lda !player_graphics_index
    tay 
    lda.w smooth_anim_enable,y
    bne .enabled
    lda !player_pose_num
    sta !player_extended_anim_pose
    rts 

.enabled
    lda !player_pose_num
    cmp !player_previous_pose_num
    beq .not_new_animation
    sta !player_previous_pose_num
    tay 

    lda !player_graphics_index
    asl 
    tax 
    rep #$20
    lda.w smooth_anim_index_ptrs,x
    sta $00
    sep #$20

    lda ($00),y
    sta !player_extended_anim_num
    beq .abort
    lda #$FF
    sta !player_extended_anim_index
    bra .next_smooth_frame

.not_new_animation
    lda !player_extended_anim_num
    beq .return

    lda !player_extended_anim_timer
    beq .next_smooth_frame
    dec 
    sta !player_extended_anim_timer
    rts 

.abort
    tya 
    sta !player_extended_anim_pose
    rts 

.next_smooth_frame
    lda !player_extended_anim_index
    inc 
    sta !player_extended_anim_index

    lda !player_extended_anim_index
    asl 
    pha
    lda !player_extended_anim_num
    dec 
    asl 
    tay 
    lda !player_graphics_index
    asl 
    tax 
    rep #$20
    lda.w smooth_anim_pointers_ptrs,x
    sta $00
    lda ($00),y
    sta $00
    ply 
    lda ($00),y
    sep #$20
    sta !player_extended_anim_pose
    xba 
    sta !player_extended_anim_timer
    cmp #$FF
    beq .end_animation
    cmp #$FE
    beq .loop_animation
    cmp #$FD
    beq .jump_to_animation
.return
    rts 
.jump_to_animation
    xba 
    sta !player_extended_anim_num
.loop_animation
    lda #$FF
    sta !player_extended_anim_index
    jmp .next_smooth_frame
.end_animation
    stz !player_extended_anim_num
    rts 

smooth_anim_enable:
    !i #= 0
    while !i < !max_gfx_num
        %internal_number_to_string(!i)
        if stringsequal("!{gfx_!{_num}_path}", "0")
            db $00
        else
            db !{gfx_!{_num}_animations_exist} 
        endif
        !i #= !i+1
    endif

smooth_anim_index_ptrs:
    !i #= 0
    while !i < !max_gfx_num
        %internal_number_to_string(!i)
        if stringsequal("!{gfx_!{_num}_path}", "0")
            dw $FFFF
        else
            if !{gfx_!{_num}_animations_exist} == 1
                dw gfx_!{_num}_smooth_anim_index
            else 
                dw $FFFF
            endif
        endif
        !i #= !i+1
    endif

smooth_anim_pointers_ptrs:
    !i #= 0
    while !i < !max_gfx_num
        %internal_number_to_string(!i)
        if stringsequal("!{gfx_!{_num}_path}", "0")
            dw $FFFF
        else
            if !{gfx_!{_num}_animations_exist} == 1
                dw gfx_!{_num}_smooth_anim_animations
            else 
                dw $FFFF
            endif
        endif
        !i #= !i+1
    endif

smooth_anim_tables:
    !i #= 0
    while !i < !max_gfx_num
        %internal_number_to_string(!i)
        if not(stringsequal("!{gfx_!{_num}_path}", "0"))
            if !{gfx_!{_num}_animations_exist} == 1
                gfx_!{_num}_smooth_anim:
                    incsrc "!{gfx_!{_num}_path}/!{gfx_!{_num}_internal_name}_animations.asm"
            endif
        endif
        !i #= !i+1
    endif