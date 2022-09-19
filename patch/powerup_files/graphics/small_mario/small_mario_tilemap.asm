
    ; setup tile size
    lda #$F8
    sta $04

    ldx !player_pose_num
    %tilemap_large(.tilemap, .displacement_index, .displacement_index_index)

    rts

.tilemap
    db $00,$01,$01,$03,$04,$05,$05,$07	;1
    db $08,$08,$0A,$0B,$0C,$0D,$0E,$0F	;2
    db $10,$11,$12,$12,$14,$15,$16,$17	;3
    db $18,$19,$1A,$1B,$1C,$1D,$1E,$1F	;4
    db $20,$21,$22,$23,$24,$25,$26,$27	;5
    db $28,$20,$80,$80,$80,$80,$80,$80	;6
    db $30,$31,$32,$33,$34,$35,$36,$37	;7
    db $38,$39,$3A,$3B,$3C	;8
;misc
    db $3D,$3E,$3F
    db $80,$80,$2A,$2A,$2C,$2D,$2E

.displacement_index
    db $00,$08,$10,$18,$20,$28,$00,$00	;00-07
    db $00,$00,$00,$00,$00,$00,$00,$00	;08-0F
    db $00,$00,$00,$00,$00,$00,$00,$00	;10-17
    db $00,$00,$00,$00	;18-1B
    
.displacement_index_index
    db $00,$00,$00,$00,$00,$00,$00,$00	;00-07	\
    db $00,$00,$00,$00,$00,$00,$00,$00	;08-0F	|
    db $04,$02,$02,$02,$00,$00,$00,$00	;10-17	|
    db $00,$00,$00,$00,$00,$00,$00,$00	;18-1F	|
    db $00,$00,$00,$00,$00,$00,$00,$00	;20-27	|Mario's pose number
    db $00,$00,$00,$00,$00,$00,$00,$00	;28-2F	|
    db $00,$00,$00,$00,$00,$00,$00,$00	;30-37	|
    db $00,$00,$00,$00,$00,$00,$00,$00	;38-3F	|
    db $00,$00,$00,$00,$00,$00,$00	;40-46	/

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