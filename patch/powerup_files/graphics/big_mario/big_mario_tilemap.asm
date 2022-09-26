;##################################################################################################
;# GFX set: Big Mario
;# Author: Nintendo
;# Description: Default set for Big Mario

;################################################
;# Code for handling the tilemap logic
;# Requires filling the following RAM:
;#  $04: Size of the player OAM tiles, usually $F8
;#  $05: Displacement index to use
;#  $06: Always zero
;#  $0A: Tilemap number

    lda #$F8
    sta $04
    lda !player_extended_anim_pose
    tax 
    lda.w .tilemap,x
    sta $0A
    stz $06
    lda.w .index_for_disp_index,x
    ora !player_direction
    tay
    lda.w .disp_index,y
    sta $05
    rts


;################################################
;# Player images table
;# Indexed by the current player pose number ($13E0)
;# Can be expanded up to 127 entries if extra poses are needed

.tilemap
    db $00                  ; [00]      Idle
    db $01,$02              ; [01-02]   Walking
    db $03                  ; [03]      Looking up
    db $04,$05,$06          ; [04-06]   Running
    db $07                  ; [07]      Idle, holding an item
    db $08,$09              ; [08-09]   Walking, holding an item; second byte is also used for Jumping/Falling
    db $0A                  ; [0A]      Looking up, holding an item
    db $0B                  ; [0B]      Jumping
    db $0C                  ; [0C]      Jumping, max speed
    db $0D                  ; [0D]      Braking
    db $0E                  ; [0E]      Kicking item
    db $0F                  ; [0F]      Looking to camera; spinjump pose, going into a pipe pose
    db $10                  ; [10]      Diagonal
    db $11,$12,$13          ; [11-13]   Running in wall
    db $14                  ; [14]      Victory pose, on Yoshi
    db $15                  ; [15]      Climbing
    db $16,$17              ; [16-17]   Swimming Idle; second byte is used for holding an item
    db $18,$19              ; [18-19]   Swimming #1; second byte is used for holding an item
    db $1A,$1B              ; [1A-1B]   Swimming #2; second byte is used for holding an item
    db $1C                  ; [1C]      Sliding
    db $1D                  ; [1D]      Crouching, holding an item
    db $1E                  ; [1E]      Punching a net
    db $1F                  ; [1F]      Turning around on Yoshi, showing back
    db $20                  ; [20]      Mounted on Yoshi
    db $21                  ; [21]      Turning around on Yoshi, facing camera; going into a pipe
    db $22                  ; [22]      Climbing, facing camera
    db $23                  ; [23]      Punching a net, facing camera
    db $24                  ; [24]      Falling
    db $25                  ; [25]      Showing back; spinjump pose
    db $26                  ; [26]      Victory pose
    db $27,$28              ; [27-28]   Commanding Yoshi
    db $29                  ; [29]      Crouching on Yoshi; also used for going into a pipe
    db $2A,$2B              ; [2A-2B]   Flying with cape
    db $2C                  ; [2C]      Slide with cape while flying
    db $2D,$2E,$2F          ; [2D-2F]   Dive with cape
    db $30,$31              ; [30-31]   Burned, cutscene poses
    db $32                  ; [32]      Looking in front, cutscene pose
    db $33,$34              ; [33-34]   Looking at the distance, cutscene pose
    db $35,$36,$37          ; [35-37]   Using a hammer, cutscene pose
    db $38,$39              ; [38-39]   Using a mop, cutscene pose
    db $3A,$3B              ; [3A-3B]   Using a hammer, cutscene pose, most likely unused
    db $3C			        ; [3C]      Crouching
    db $3D                  ; [3D]      Shrinking/Growing
    db $3E                  ; [3E]      Dead
    db $3F                  ; [3F]      Shooting fireball
    db $7F,$7F              ; [40-41]   Unused
    db $2A,$3B              ; [42-43]   Using P-Balloon 
    db $25,$3A,$00          ; [44-46]   Copy of the spinjump poses


;################################################
;# Index for the table of indexes for deciding which set of offsets will be used on the player
;# Indexed by the current player pose number ($13E0)
;# Can be expanded up to 127 entries if extra poses are needed

.index_for_disp_index
    db $00                  ; [00]      Idle
    db $00,$00              ; [01-02]   Walking
    db $00                  ; [03]      Looking up
    db $00,$00,$00          ; [04-06]   Running
    db $00                  ; [07]      Idle, holding an item
    db $00,$00              ; [08-09]   Walking, holding an item; second byte is also used for Jumping/Falling
    db $00                  ; [0A]      Looking up, holding an item
    db $00                  ; [0B]      Jumping
    db $00                  ; [0C]      Jumping, max speed
    db $00                  ; [0D]      Braking
    db $00                  ; [0E]      Kicking item
    db $00                  ; [0F]      Looking to camera; spinjump pose, going into a pipe pose
    db $04                  ; [10]      Diagonal
    db $02,$02,$02          ; [11-13]   Running in wall
    db $00                  ; [14]      Victory pose, on Yoshi
    db $00                  ; [15]      Climbing
    db $00,$00              ; [16-17]   Swimming Idle; second byte is used for holding an item
    db $00,$00              ; [18-19]   Swimming #1; second byte is used for holding an item
    db $00,$00              ; [1A-1B]   Swimming #2; second byte is used for holding an item
    db $00                  ; [1C]      Sliding
    db $00                  ; [1D]      Crouching, holding an item
    db $00                  ; [1E]      Punching a net
    db $00                  ; [1F]      Turning around on Yoshi, showing back
    db $00                  ; [20]      Mounted on Yoshi
    db $00                  ; [21]      Turning around on Yoshi, facing camera; going into a pipe
    db $00                  ; [22]      Climbing, facing camera
    db $00                  ; [23]      Punching a net, facing camera
    db $00                  ; [24]      Falling
    db $00                  ; [25]      Showing back; spinjump pose
    db $00                  ; [26]      Victory pose
    db $00,$00              ; [27-28]   Commanding Yoshi
    db $00                  ; [29]      Crouching on Yoshi; also used for going into a pipe
    db $00,$00              ; [2A-2B]   Flying with cape
    db $00                  ; [2C]      Slide with cape while flying
    db $00,$00,$00          ; [2D-2F]   Dive with cape
    db $00,$00              ; [30-31]   Burned, cutscene poses
    db $00                  ; [32]      Looking in front, cutscene pose
    db $00,$00              ; [33-34]   Looking at the distance, cutscene pose
    db $00,$00,$00          ; [35-37]   Using a hammer, cutscene pose
    db $00,$00              ; [38-39]   Using a mop, cutscene pose
    db $00,$00              ; [3A-3B]   Using a hammer, cutscene pose, most likely unused
    db $00			        ; [3C]      Crouching
    db $00                  ; [3D]      Shrinking/Growing
    db $00                  ; [3E]      Dead
    db $00                  ; [3F]      Shooting fireball
    db $00,$00              ; [40-41]   Unused
    db $00,$00              ; [42-43]   Using P-Balloon 
    db $00,$00,$00          ; [44-46]   Copy of the spinjump poses


;################################################
;# Displacements in the X axis for each player tile
;# The indexes for this table are grabbed from .disp_index
;# Format: UL, DL, UR, DR

.x_disp
    dw $FFF8,$FFF8,$0008,$0008	;[00]	Normal (facing left)
    dw $0008,$0008,$FFF8,$FFF8	;[08]	Normal (facing right)
    dw $0007,$0007,$0017,$0017	;[10]	Wall running offsets (wall on left)
    dw $FFFA,$FFFA,$FFEA,$FFEA	;[18]	Wall running offsets (wall on right)
    dw $0005,$0005,$0015,$0015	;[20]	Wall triangle offsets (^ <-)
    dw $FFFC,$FFFC,$FFEC,$FFEC	;[28]	Wall triangle offsets (-> ^)
    ;below are free to use
    dw $FFF8,$FFF8,$0008,$0008	;[30]
    dw $0008,$0008,$FFF8,$FFF8	;[38]
    dw $FFF8,$FFF8,$0008,$0008	;[40]
    dw $0008,$0008,$FFF8,$FFF8	;[48]
    dw $FFF8,$FFF8,$0008,$0008	;[50]
    dw $0008,$0008,$FFF8,$FFF8	;[58]
    dw $FFF8,$FFF8,$0008,$0008	;[60]
    dw $0008,$0008,$FFF8,$FFF8	;[68]
    dw $FFF8,$FFF8,$0008,$0008	;[70]
    dw $0008,$0008,$FFF8,$FFF8	;[78]
    dw $0000,$0000	;[80]
    ;;;Cape X positions;;;
    dw $000A,$FFF6	;[84]
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


;################################################
;# Displacements in the Y axis for each player tile
;# The indexes for this table are grabbed from .disp_index
;# Format: UL, DL, UR, DR

.y_disp
    dw $0001,$0011,$0001,$0011	;[00]	Normal (facing left)
    dw $0001,$0011,$0001,$0011	;[08]	Normal (facing right)
    dw $000F,$001F,$000F,$001F	;[10]	Wall running offsets (wall on left)
    dw $000F,$001F,$000F,$001F	;[18]	Wall running offsets (wall on right)
    dw $0005,$0015,$0005,$0015	;[20]	Wall triangle offsets (^ <-)
    dw $0005,$0015,$0005,$0015	;[28]	Wall triangle offsets (-> ^)
    ;below are free to use
    dw $0001,$0011,$0001,$0011	;[30]
    dw $0001,$0011,$0001,$0011	;[38]
    dw $0001,$0011,$0001,$0011	;[40]
    dw $0001,$0011,$0001,$0011	;[48]
    dw $0001,$0011,$0001,$0011	;[50]
    dw $0001,$0011,$0001,$0011	;[58]
    dw $0001,$0011,$0001,$0011	;[60]
    dw $0001,$0011,$0001,$0011	;[68]
    dw $0001,$0011,$0001,$0011	;[70]
    dw $0001,$0011,$0001,$0011	;[78]
    dw $0000,$0000	;[80]
    ;;;Cape Y positions;;;
    dw $000B,$000B	;[84]
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

