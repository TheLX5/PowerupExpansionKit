;##################################################################################################
;# GFX set: Big Mario
;# Author: Nintendo
;# Description: Default set for Big Mario

;################################################
;# Walk frames config

;# How many frames for walking this GFX has
;# This define also controls the length of each entry under the .walk_animations
;# table in the tilemap file. You may need to edit that file to properly expand
;# the walking frames of this GFX set.
!big_mario_walk_frames = $03

;################################################
;# Pose numbers for specific actions
;# Those values are the indexes used for the tilemap table

;# Idle pose numbers
!big_mario_idle_pose = $00
!big_mario_idle_carry_pose = $07

;# Jumping pose numbers
!big_mario_jump_pose = $0B
!big_mario_jump_carry_pose = $09
!big_mario_jump_max_speed_pose = $0C

;# Falling pose number
!big_mario_falling_pose = $24

;# Braking/Turning around poses
!big_mario_braking_pose = $0D

;# Stunned pose number
!big_mario_stunned_pose = $0F

;# Angled pose number
!big_mario_angled_pose = $10

;# Looking up pose numbers
!big_mario_looking_up_pose = $03
!big_mario_looking_up_carry_pose = $0A

;# Crouching pose numbers
!big_mario_crouching_pose = $3C
!big_mario_crouching_with_item_pose = $1D

;# Sliding pose number
!big_mario_sliding_pose = $1C

;# Kicking something pose number
!big_mario_kicking_pose = $0E

;# Picking up something number
!big_mario_pick_up_pose = $1D

;# Shooting a fireball while swimming pose numbers
;# The game has a check for carrying something and give it a different pose... dunno why.
!big_mario_swimming_shooting_fireball_pose = $29
!big_mario_swimming_shooting_fireball_carry_pose = $29

;# Climbing a net pose numbers
;# The "back" one refers to the player showing their back to the camera
;# while "front" refers to the player showing their face to the camera
!big_mario_climbing_back_pose = $15
!big_mario_climbing_front_pose = $22

;# Facing the screen pose number
;# Used when the player turns around with an item and enters a vertical pipe
;# Kinda makes "enter_vertical_pipe_pose" redundant lol
!big_mario_facing_screen_pose = $0F

;# Entering a door or a horizontal pipe pose numbers
!big_mario_enter_door_pipe_pose = $00
!big_mario_enter_door_pipe_on_yoshi_pose = $00

;# Entering a vertical pipe pose numbers
!big_mario_enter_vertical_pipe_up_pose = $0F
!big_mario_enter_vertical_pipe_down_pose = $0F
!big_mario_exit_vertical_pipe_up_pose = $0F
!big_mario_exit_vertical_pipe_down_pose = $0F
!big_mario_enter_vertical_pipe_up_carry_pose = $0F
!big_mario_enter_vertical_pipe_down_carry_pose = $0F
!big_mario_exit_vertical_pipe_up_carry_pose = $0F
!big_mario_exit_vertical_pipe_down_carry_pose = $0F
!big_mario_enter_vertical_pipe_up_on_yoshi_pose = $21
!big_mario_enter_vertical_pipe_down_on_yoshi_pose = $21
!big_mario_exit_vertical_pipe_up_on_yoshi_pose = $21
!big_mario_exit_vertical_pipe_down_on_yoshi_pose = $21

;# Yoshi related poses
!big_mario_on_yoshi_idle_pose = $20
!big_mario_on_yoshi_turning_pose = $21
!big_mario_on_yoshi_crouching_pose = $1D
!big_mario_on_yoshi_spitting_tongue_1_pose = $27
!big_mario_on_yoshi_spitting_tongue_2_pose = $28

;# Shooting fireball pose numbers
!big_mario_shooting_fireball_pose = $3F
!big_mario_shooting_fireball_in_air_pose = $16

;# P-Balloon pose numbers
!big_mario_pballoon_pose = $42
!big_mario_pballoon_transition_pose = $0F

;# Peace pose numbers
!big_mario_peace_pose = $26
!big_mario_peace_on_yoshi_pose = $14

;# Death pose number
;# Note that this will only work on powerup $00 unless you disable it from happening with an external patch
!big_mario_death_pose = $3E

;# Player grabbing a Fire Flower pose number
;# Note: This animation didn't exist in the original game, but it can handle giving the player a specific a pose.
!big_mario_grab_flower_pose = $00

;################################################
;# Mandatory macro (do not touch).

%setup_general_gfx_defines(!big_mario_gfx_num)