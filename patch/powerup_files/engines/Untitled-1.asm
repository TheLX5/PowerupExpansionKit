
NumWalkingFrames:				;$00DC78	| Number of walking frames for each of Mario's powerups.
	db $01,$02,$02,$02

DATA_00DC7C:					;$00DC7C	| Animation timers for both Mario's run animation and his cape's fluttering animation.
	db $0A,$08,$06,$04,$03,$02,$01,$01		;  Both use the absolute value of his speed, divided by 8, as a base index.
	db $0A,$08,$06,$04,$03,$02,$01,$01		;  Mario animation adds $13E5 on top of it, which is either 00 in normal levels or 68 in slippery.
	db $0A,$08,$06,$04,$03,$02,$01,$01
	db $08,$06,$04,$03,$02,$01,$01,$01
	db $08,$06,$04,$03,$02,$01,$01,$01
	db $05,$04,$03,$02,$01,$01,$01,$01
	db $05,$04,$03,$02,$01,$01,$01,$01
	db $05,$04,$03,$02,$01,$01,$01,$01
	db $05,$04,$03,$02,$01,$01,$01,$01
	db $05,$04,$03,$02,$01,$01,$01,$01
	db $05,$04,$03,$02,$01,$01,$01,$01
	db $04,$03,$02,$01,$01,$01,$01,$01
	db $04,$03,$02,$01,$01,$01,$01,$01
	db $02,$02,$02,$02,$02,$02,$02,$02		; These 8 are for in slippery levels, still indexed by his speed divided by 8 (it overflows into the next table if you go fast enough).



DATA_00DCEC:					;$00DCEC	| Indices to $00DD32, indexed by $13E0. ORA'd with Mario's direction.
	db $00,$00,$00,$00,$00,$00,$00,$00		; If $19 = #$00 and $13E0 = #$29, an index of #$20 is used instead.
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $02,$04,$04,$04,$0E,$08,$00,$00
	db $00,$00,$00,$00,$00,$00,$08,$08
	db $08,$08,$08,$08,$00,$00,$00,$00
	db $0C,$10,$12,$14,$16,$18,$1A,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$06,$00,$00
	db $00,$00,$00,$0A,$00,$00

DATA_00DD32:					;$00DD32	| Indexes to the position tables for Mario's tiles. Indexed by $00DCEC + Mario's direction.
	db $00,$08,$10,$14,$18,$1E,$24,$24
	db $28,$30,$38,$3E,$44,$4A,$50,$54
	db $58,$58,$5C,$60,$64,$68,$6C,$70
	db $74,$78,$7C,$80

DATA_00DD4E:					;$00DD4E	| X positions of Mario's tiles in various poses. 16-bit, indexed by $00DD32.
	dw $0000,$0000,$0010,$0010	; 8 bytes per entry: head, body, extra tile #1, extra tile #2.
	dw $0000,$0000,$FFF8,$FFF8	; Added to $7E.
	dw $000E,$0006,$FFF2,$FFFA
	dw $0017,$0007,$000F,$FFEA
	dw $FFFA,$FFFA,$0000,$0000
	dw $0000,$0000,$0010,$0010
	dw $0000,$0000,$FFF8,$FFF8
	dw $0000,$FFF8,$0008,$0000
	dw $0008,$FFF8,$0000,$0000
	dw $FFF8,$0000,$0000,$0010
	dw $0002,$0000,$FFFE,$0000
	dw $0000,$0000,$FFFC,$0005
	dw $0004,$FFFB,$FFFB,$0006
	dw $0005,$FFFA,$FFF9,$0009
	dw $0007,$FFF7,$FFFD,$FFFD
	dw $0003,$0003,$FFFF,$0007
	dw $0001,$FFF9        
	dw $000A,$FFF6,$0008,$FFF8	; Cape positions, indexed by $00E21A.
	dw $0008,$FFF8,$0000,$0004
	dw $FFFC,$FFFE,$0002,$000B
	dw $FFF5,$0014,$FFEC,$000E
	dw $FFF3,$0008,$FFF8,$000C
	dw $0014,$FFFD,$FFF4,$FFF4
	dw $000B,$000B,$0003,$0013
	dw $FFF5,$0005,$FFF5,$0009
	dw $0001,$0001,$FFF7,$0007
	dw $0007,$0005,$000D,$000D
	dw $FFFB,$FFFB,$FFFB,$FFFF
	dw $000F,$0001,$FFF9,$0000

DATA_00DE32:					;$00DE32	| Y positions of Mario's tiles in various poses. 16-bit, indexed by $00DD32.
	dw $0001,$0011,$0011,$0019	; 8 bytes per entry: head, body, extra tile #1, extra tile #2.
	dw $0001,$0011,$0011,$0019	; Added to $80.
	dw $000C,$0014,$000C,$0014
	dw $0018,$0018,$0028,$0018
	dw $0018,$0028,$0006,$0016
	dw $0001,$0011,$0009,$0011
	dw $0001,$0011,$0009,$0011
	dw $0001,$0011,$0011,$0001
	dw $0011,$0011,$0001,$0011
	dw $0011,$0001,$0011,$0011
	dw $0001,$0011,$0001,$0011
	dw $0011,$0005,$0004,$0014
	dw $0004,$0014,$000C,$0014
	dw $000C,$0014,$0010,$0010
	dw $0010,$0010,$0010,$0000
	dw $0010,$0000,$0010,$0000
	dw $0010,$0000        
	dw $000B,$000B,$0011,$0011	; Cape positions, indexed by $00E21A.
	dw $FFFF,$FFFF,$0010,$0010
	dw $0010,$0010,$0010,$0010
	dw $0010,$0015,$0015,$0025
	dw $0025,$0004,$0004,$0004
	dw $0014,$0014,$0004,$0014
	dw $0014,$0004,$0004,$0014
	dw $0004,$0004,$0014,$0000
	dw $0008,$0000,$0000,$0008
	dw $0000,$0000,$0010,$0018
	dw $0000,$0010,$0018,$0000
	dw $0010,$0000,$0010,$FFF8



TilesetIndex:					;$00DF16	| Base indices to the tables below to use for Mario, indexed by $19.
	db $00,$46,$83,$46


TileExpansion:					;$00DF1A	| Extra tile index table for each of Mario's poses.
	db $00,$00,$00,$00,$00,$00,$00,$00		; Small
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$28,$00		; Poses 3D-45
	db $00
	db $00,$00,$00,$00,$04,$04,$04,$00		; Big
	db $00,$00,$00,$00,$08,$00,$00,$00
	db $00,$0C,$0C,$0C,$00,$00,$10,$10
	db $14,$14,$18,$18,$00,$00,$1C,$00
	db $00,$00,$00,$20,$00,$00,$00,$00
	db $24,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00
	db $00,$00,$00,$00,$04,$04,$04,$00		; Cape
	db $00,$00,$00,$00,$08,$00,$00,$00
	db $00,$0C,$0C,$0C,$00,$00,$10,$10
	db $14,$14,$18,$18,$00,$00,$1C,$00
	db $00,$00,$00,$20,$00,$00,$00,$00
	db $24,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00


Mario8x8Tiles:					;$00DFDA	| Actual OAM tile numbers for Mario (despite its name, not necessarily 8x8). Each entry is 4 bytes long.
	db $00,$02,$80,$80						;  Byte 0 is Mario's dynamic head tile (always tile 0x00).
	db $00,$02,$0C,$80						;  Byte 1 is Mario's dynamic body tile (always tile 0x02).
	db $00,$02,$1A,$1B						;  Byte 2 is the extra 8x8 tile #1 (scattered throughout SP1).
	db $00,$02,$0D,$80						;  Byte 3 is the extra 8x8 tile #2 (scattered throughout SP1).
	db $00,$02,$22,$23						; The high byte being set indicates the tile shouldn't be drawn.
	db $00,$02,$32,$33
	db $00,$02,$0A,$0B
	db $00,$02,$30,$31
	db $00,$02,$20,$21
	db $00,$02,$7E,$80
	db $00,$02,$02,$80						; Extra tile #1 in this entry (the balloon) is treated as 16x16.
	db $04									; Tile in SP1/SP2 to use as the cape's dynamic tile.
	db $7F									; Tile in SP1/SP2 to use as the cape's misc dynamic tile.
	db $4A,$5B,$4B,$5A						; Miscellaneous static cape tiles.


DATA_00E00C:					;$00E00C	| List of upper tiles for Mario. Bit 3 is page number; see https://media.smwcentral.net/Diagrams/PlayerTiles.png
	db $50,$50,$50,$09,$50,$50,$50,$50		; Small
	db $50,$50,$09,$2B,$50,$2D,$50,$D5
	db $2E,$C4,$C4,$C4,$D6,$B6,$50,$50
	db $50,$50,$50,$50,$50,$C5,$D7,$2A
	db $E0,$50,$D5,$29,$2C,$B6,$D6,$28
	db $E0,$E0,$C5,$C5,$C5,$C5,$C5,$C5
	db $5C,$5C,$50,$5A,$B6,$50,$28,$28
	db $C5,$D7,$28,$70,$C5
	db $70,$1C,$93,$C5,$C5,$0B,$85,$90		; Poses 3D-45
	db $84        
	db $70,$70,$70,$A0,$70,$70,$70,$70		; Big
	db $70,$70,$A0,$74,$70,$80,$70,$84
	db $17,$A4,$A4,$A4,$B3,$B0,$70,$70
	db $70,$70,$70,$70,$70,$E2,$72,$0F
	db $61,$70,$63,$82,$C7,$90,$B3,$D4
	db $A5,$C0,$08,$54,$0C,$0E,$1B,$51
	db $49,$4A,$48,$4B,$4C,$5D,$5E,$5F
	db $E3,$90,$5F,$5F,$C5            
	db $70,$70,$70,$A0,$70,$70,$70,$70		; Cape
	db $70,$70,$A0,$74,$70,$80,$70,$84
	db $17,$A4,$A4,$A4,$B3,$B0,$70,$70
	db $70,$70,$70,$70,$70,$E2,$72,$0F
	db $61,$70,$63,$82,$C7,$90,$B3,$D4
	db $A5,$C0,$08,$64,$0C,$0E,$1B,$51
	db $49,$4A,$48,$4B,$4C,$5D,$5E,$5F
	db $E3,$90,$5F,$5F,$C5

DATA_00E0CC:					;$00E0CC	| List of lower tiles for Mario. Bit 3 is page number; see https://media.smwcentral.net/Diagrams/PlayerTiles.png
	db $71,$60,$60,$19,$94,$96,$96,$A2		; Small
	db $97,$97,$18,$3B,$B4,$3D,$A7,$E5
	db $2F,$D3,$C3,$C3,$F6,$D0,$B1,$81
	db $B2,$86,$B4,$87,$A6,$D1,$F7,$3A
	db $F0,$F4,$F5,$39,$3C,$C6,$E6,$38
	db $F1,$F0,$C5,$C5,$C5,$C5,$C5,$C5
	db $6C,$4D,$71,$6A,$6B,$60,$38,$F1
	db $5B,$69,$F1,$F1,$4E
	db $E1,$1D,$A3,$C5,$C5,$1A,$95,$10		; Poses 3D-45
	db $07        
	db $02,$01,$00,$02,$14,$13,$12,$30		; Big
	db $27,$26,$30,$03,$15,$04,$31,$07
	db $E7,$25,$24,$23,$62,$36,$33,$91
	db $34,$92,$35,$A1,$32,$F2,$73,$1F
	db $C0,$C1,$C2,$83,$D2,$10,$B7,$E4
	db $B5,$61,$0A,$55,$0D,$75,$77,$1E
	db $59,$59,$58,$02,$02,$6D,$6E,$6F
	db $F3,$68,$6F,$6F,$06            
	db $02,$01,$00,$02,$14,$13,$12,$30		; Cape
	db $27,$26,$30,$03,$15,$04,$31,$07
	db $E7,$25,$24,$23,$62,$36,$33,$91
	db $34,$92,$35,$A1,$32,$F2,$73,$1F
	db $C0,$C1,$C2,$83,$D2,$10,$B7,$E4
	db $B5,$61,$0A,$55,$0D,$75,$77,$1E
	db $59,$59,$58,$02,$02,$6D,$6E,$6F
	db $F3,$68,$6F,$6F,$06



MarioPalIndex:					;$00E18C	| X-bit values for Mario's YXPPCCCT, indexed by his direction.
	db $00,$40



DATA_00E18E:					;$00E18E	| Indices to the below data, indexed by $13E0 in cape form.
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$0D,$00,$10
	db $13,$22,$25,$28,$00,$16,$00,$00
	db $00,$00,$00,$00,$00,$08,$19,$1C
	db $04,$1F,$10,$10,$00,$16,$10,$06
	db $04,$08,$2B,$30,$35,$3A,$3F,$43
	db $00,$00,$00,$00,$00,$00,$00,$00
	db $16,$16,$00,$00,$08,$00,$00,$00
	db $00,$00,$00,$10,$04,$00

DATA_00E1D4:					;$00E1D4	| Data on Mario's cape, indexed by values in $00E18E. Each entry is up to 5 bytes long.
	db $06,$00					; 00		;  Byte 0 - MSK - Which tiles to not draw, according to $78 (---- dluc). If bit 7 is set, tile #$7F is skipped, and the main cape tile uses a different OAM index for high priority.
	db $06,$00					; 02		;  Byte 1 - DYN - If less than #$04, used as an index to $00E23A/$00E266; else, it's a 16x16 tile number in GFX32. Uploaded to #$04 in SP1.
	db $86,$02					; 04		;  Byte 2 - POS - Index to $00E21A for the cape's position. Ignored if DYN is less than 04.
	db $06,$03					; 06		;  Byte 3 - Ex1 - 8x8 tile in GFX32 to upload to tile #$7F in SP1. Ignored if MSK has bit 1 (u) set.
	db $06,$01					; 08		;  Byte 4 - Ex2 - Index to $00DFDA to use for the cape's other static misc tile. Ignored if MSK has bit 2 (l) set.
	db $06,$CE,$06				; 0A		;
	db $06,$40,$00				; 0D		; For a more visual table of this data, see here: https://loli.muncher.se/mariocape/
	db $06,$2C,$06				; 10
	db $06,$44,$0E				; 13
	db $86,$2C,$06				; 16
	db $86,$2C,$0A				; 19
	db $86,$84,$08				; 1C
	db $06,$0A,$02				; 1F
	db $06,$AC,$10				; 22
	db $06,$CC,$10				; 25
	db $06,$AE,$10				; 28
	db $00,$8C,$14,$80,$2E		; 2B
	db $00,$CA,$16,$91,$2F		; 30
	db $00,$8E,$18,$81,$30		; 35
	db $00,$EB,$1A,$90,$31		; 3A
	db $04,$ED,$1C,$82			; 3F
	db $06,$92,$1E				; 43

DATA_00E21A:					;$00E21A	| Position indices for the cape, to $00DD4E/$00DE32.
	db $84,$86,$88,$8A,$8C,$8E,$90,$90
	db $92,$94,$96,$98,$9A,$9C,$9E,$A0
	db $A2,$A4,$A6,$A8,$AA,$B0,$B6,$BC
	db $C2,$C8,$CE,$D4,$DA,$DE,$E2,$E2

DATA_00E23A:					;$00E23A	| Tilemap for Mario's cape (16x16). Four bytes per entry, indexed by byte 1 of $00E1D4. Uploaded to tile #$04 in SP1.
	db $0A,$0A,$84,$0A						; The four bytes are standing, croutching, riding Yoshi, and about to use Yoshi's tongue.
	db $88,$88,$88,$88						; With the exception of the first entry though, all 4 bytes are always the same...
	db $8A,$8A,$8A,$8A
	db $44,$44,$44,$44
	db $42,$42,$42,$42
	db $40,$40,$40,$40
	db $22,$22,$22,$22
	db $A4,$A4,$A4,$A4
	db $A6,$A6,$A6,$A6
	db $86,$86,$86,$86
	db $6E,$6E,$6E,$6E

DATA_00E266:					;$00E266	| Offsets to $00E21A for Mario's cape. Four bytes per entry, indexed by byte 1 of $00E1D4.
	db $02,$02,$02,$0C						; The four bytes are standing, croutching, riding Yoshi, and about to use Yoshi's tongue.
	db $00,$00,$00,$00
	db $00,$00,$00,$00
	db $00,$00,$00,$00
	db $00,$00,$00,$00
	db $00,$00,$00,$00
	db $00,$00,$00,$00
	db $04,$12,$04,$04
	db $04,$12,$04,$04
	db $04,$12,$04,$04
	db $04,$12,$04,$04


DATA_00E292:
	db $01,$01,$01,$01,$02,$02,$02,$02
	db $04,$04,$04,$04,$08,$08,$08,$08

DATA_00E2A2:					;$00E2A2	| 16-bit pointers to the palettes for the player.
	db $C8,$B2,$DC,$B2,$C8,$B2,$DC,$B2		; Small M/L, Big M/L
	db $C8,$B2,$DC,$B2,$F0,$B2,$04,$B3		; Cape M/L, Fire M/L

DATA_00E2B2:					;$00E2B2	| Mario's OAM indices for each of powerup.
	db $10,$D4,$10,$E8

DATA_00E2B6:					;$00E2B6	| OAM indices for Mario's extra 8x8 tile, indexed by $13F9.
	db $08,$CC,$08,$E0

DATA_00E2BA:					;$00E2BA	| Priority bits for Mario's YXPPCCCT, indexed by $13F9 minus 1.
	db $10,$10,$30							; Default usage: 1 = nets, 2 = pipes, and 3 = overworld (also after Bowser is killed)


CODE_00E2BD:					;-----------| Mario GFX routine, which also draws Yoshi and handles some other processes as well (e.g. star).
	PHB							;$00E2BD	|
	PHK							;$00E2BE	|
	PLB							;$00E2BF	|
	LDA $78						;$00E2C0	|\ 
	CMP.b #$FF					;$00E2C2	|| Process Yoshi, unless Mario isn't being drawn.
	BEQ CODE_00E2CA				;$00E2C4	||
	JSL CODE_01EA70				;$00E2C6	|/
CODE_00E2CA:					;			|
	LDY.w $149B					;$00E2CA	|\ Branch if Mario is not currently flipping through palettes.
	BNE CODE_00E308				;$00E2CD	|/
	LDY.w $1490					;$00E2CF	|\ Branch if star power is not active.
	BEQ CODE_00E314				;$00E2D2	|/
	LDA $78						;$00E2D4	|\ 
	CMP.b #$FF					;$00E2D6	||
	BEQ CODE_00E2E3				;$00E2D8	|| Decrement the star power timer every 4 frames,
	LDA $14						;$00E2DA	||  unless Mario isn't being drawn.
	AND.b #$03					;$00E2DC	||
	BNE CODE_00E2E3				;$00E2DE	||
	DEC.w $1490					;$00E2E0	|/
CODE_00E2E3:					;			|
	LDA $13						;$00E2E3	|
	CPY.b #$1E					;$00E2E5	|
	BCC CODE_00E30A				;$00E2E7	|
	BNE CODE_00E30C				;$00E2E9	|
	LDA.w $0DDA					;$00E2EB	|
	CMP.b #$FF					;$00E2EE	|
	BEQ CODE_00E308				;$00E2F0	|
	AND.b #$7F					;$00E2F2	|
	STA.w $0DDA					;$00E2F4	|
	TAX							;$00E2F7	|
	LDA.w $14AD					;$00E2F8	|
	ORA.w $14AE					;$00E2FB	|
	ORA.w $190C					;$00E2FE	|
	BEQ CODE_00E305				;$00E301	|
	LDX.b #$0E					;$00E303	|
CODE_00E305:					;			|
	STX.w $1DFB					;$00E305	|
CODE_00E308:					;			|
	LDA $13						;$00E308	|\ 
CODE_00E30A:					;			||
	LSR							;$00E30A	||
	LSR							;$00E30B	||
CODE_00E30C:					;			||
	AND.b #$03					;$00E30C	||| Number of palettes to flash through when Mario has star power.
	INC A						;$00E30E	||
	INC A						;$00E30F	||
	INC A						;$00E310	||
	INC A						;$00E311	|/
	BRA CODE_00E31A				;$00E312	|

CODE_00E314:					;```````````| Mario does not have star power.
	LDA $19						;$00E314	|\ 
	ASL							;$00E316	|| Get the current palette to use for the player.
	ORA.w $0DB3					;$00E317	|/
CODE_00E31A:					;			|
	ASL							;$00E31A	|
	TAY							;$00E31B	|
	REP #$20					;$00E31C	|
	LDA.w DATA_00E2A2,Y			;$00E31E	|\ Store the palette pointer to use for the current player's palette.
	STA.w $0D82					;$00E321	|/
	SEP #$20					;$00E324	|
	LDX.w $13E0					;$00E326	|\ 
	LDA.b #$05					;$00E329	||\ 
	CMP.w $13E3					;$00E32B	||| Branch if Mario is not running sideways on a wall.
	BCS CODE_00E33E				;$00E32E	||/
	LDA.w $13E3					;$00E330	||
	LDY $19						;$00E333	||\ Branch if Mario is small.
	BEQ CODE_00E33B				;$00E335	||/
	CPX.b #$13					;$00E337	||\ If the player's pose is not #$13, branch.
	BNE CODE_00E33D				;$00E339	||/
CODE_00E33B:					;			||
	EOR.b #$01					;$00E33B	|| Basically the whole point of this code is to determine whether
CODE_00E33D:					;			|| to shift Mario's X position within the screen one extra pixel.
	LSR							;$00E33D	||
CODE_00E33E:					;			||
	REP #$20					;$00E33E	||
	LDA $94						;$00E340	||\ 
	SBC $1A						;$00E342	||| Store player X position relative to the screen.
	STA $7E						;$00E344	|//
	LDA.w $188B					;$00E346	|\ 
	AND.w #$00FF				;$00E349	||
	CLC							;$00E34C	||
	ADC $96						;$00E34D	||
	LDY $19						;$00E34F	||
	CPY.b #$01					;$00E351	||
	LDY.b #$01					;$00E353	||
	BCS CODE_00E359				;$00E355	||
	DEC A						;$00E357	||
	DEY							;$00E358	|| Store player Y position relative to the screen.
CODE_00E359:					;			||  Adjust for screen shake, powerup, and walking frame.
	CPX.b #$0A					;$00E359	||
	BCS CODE_00E360				;$00E35B	||
	CPY.w $13DB					;$00E35D	||
CODE_00E360:					;			||
	SBC $1C						;$00E360	||
	CPX.b #$1C					;$00E362	||
	BNE CODE_00E369				;$00E364	||
	ADC.w #$0001				;$00E366	||
CODE_00E369:					;			||
	STA $80						;$00E369	|/
	SEP #$20					;$00E36B	|
	LDA.w $1497					;$00E36D	|
	BEQ CODE_00E385				;$00E370	|
	LSR							;$00E372	|
	LSR							;$00E373	|
	LSR							;$00E374	|
	TAY							;$00E375	|
	LDA.w DATA_00E292,Y			;$00E376	|
	AND.w $1497					;$00E379	|
	ORA $9D						;$00E37C	|
	ORA.w $13FB					;$00E37E	|
	BNE CODE_00E385				;$00E381	|
	PLB							;$00E383	|
	RTL							;$00E384	|

CODE_00E385:
	LDA.b #$C8					;$00E385	|\ 
	CPX.b #$43					;$00E387	|| Set the size of Mario's tiles, 8x8 or 16x16 (hb12 c34-).
	BNE CODE_00E38D				;$00E389	||  (1/2 = extra tile #1/#2, c = cape, 3/4 = cape misc #1/#2)
	LDA.b #$E8					;$00E38B	|| Balloon form sets Ex1 to be 16x16; in all others it's 8x8.
CODE_00E38D:					;			||
	STA $04						;$00E38D	|/
	CPX.b #$29					;$00E38F	|
	BNE CODE_00E399				;$00E391	|
	LDA $19						;$00E393	|
	BNE CODE_00E399				;$00E395	|
	LDX.b #$20					;$00E397	|
CODE_00E399:					;			|
	LDA.w DATA_00DCEC,X			;$00E399	|
	ORA $76						;$00E39C	|
	TAY							;$00E39E	|
	LDA.w DATA_00DD32,Y			;$00E39F	|
	STA $05						;$00E3A2	|
	LDY $19						;$00E3A4	|
	LDA.w $13E0					;$00E3A6	|
	CMP.b #$3D					;$00E3A9	|
	BCS CODE_00E3B0				;$00E3AB	|
	ADC.w TilesetIndex,Y		;$00E3AD	|
CODE_00E3B0:					;			|
	TAY							;$00E3B0	|
	LDA.w TileExpansion,Y		;$00E3B1	|
	STA $06						;$00E3B4	|
	LDA.w DATA_00E00C,Y			;$00E3B6	|\ 
	STA $0A						;$00E3B9	|| Preserve the top/bottom tiles (stored at $00F63A).
	LDA.w DATA_00E0CC,Y			;$00E3BB	||
	STA $0B						;$00E3BE	|/
	LDA $64						;$00E3C0	|\ 
	LDX.w $13F9					;$00E3C2	||
	BEQ CODE_00E3CA				;$00E3C5	||
	LDA.w DATA_00E2BA-1,X		;$00E3C7	||
CODE_00E3CA:					;			||
	LDY.w DATA_00E2B2,X			;$00E3CA	||
	LDX $76						;$00E3CD	||
	ORA.w MarioPalIndex,X		;$00E3CF	||
	STA.w $0303,Y				;$00E3D2	||
	STA.w $0307,Y				;$00E3D5	|| Store Mario's YXPPCCCT to all necessary tiles.
	STA.w $030F,Y				;$00E3D8	||  If set to go behind layers, use standard YXPPCCCT instead of Mario's normal.
	STA.w $0313,Y				;$00E3DB	||
	STA.w $02FB,Y				;$00E3DE	||
	STA.w $02FF,Y				;$00E3E1	||
	LDX $04						;$00E3E4	||
	CPX.b #$E8					;$00E3E6	||
	BNE CODE_00E3EC				;$00E3E8	||
	EOR.b #$40					;$00E3EA	||
CODE_00E3EC:					;			||
	STA.w $030B,Y				;$00E3EC	|/
	JSR CODE_00E45D				;$00E3EF	|\ 
	JSR CODE_00E45D				;$00E3F2	|| Draw main four tiles for Mario into OAM.
	JSR CODE_00E45D				;$00E3F5	||
	JSR CODE_00E45D				;$00E3F8	|/
	LDA $19						;$00E3FB	|\ 
	CMP.b #$02					;$00E3FD	||| Powerup that shows the cape graphic. (all others skip the below code)
	BNE CODE_00E458				;$00E3FF	|/
	PHY							;$00E401	|
	LDA.b #$2C					;$00E402	|\ Base index to $00DFDA for the extra cape tiles.
	STA $06						;$00E404	|/
	LDX.w $13E0					;$00E406	| 
	LDA.w DATA_00E18E,X			;$00E409	|
	TAX							;$00E40C	|
	LDA.w DATA_00E1D4+3,X		;$00E40D	|\ Get dynamic cape tile to upload to tile #$7F.
	STA $0D						;$00E410	|/
	LDA.w DATA_00E1D4+4,X		;$00E412	|\ Get position index for the second static cape tile.
	STA $0E						;$00E415	|/
	LDA.w DATA_00E1D4+1,X		;$00E417	|\ 
	STA $0C						;$00E41A	||
	CMP.b #$04					;$00E41C	||
	BCS CODE_00E432				;$00E41E	||
	LDA.w $13DF					;$00E420	||
	ASL							;$00E423	||
	ASL							;$00E424	||
	ORA $0C						;$00E425	||
	TAY							;$00E427	||
	LDA.w DATA_00E23A,Y			;$00E428	|| Handle the main cape tile, uploaded dynamically to #$04 in SP1.
	STA $0C						;$00E42B	||  Gets the tile number and position offset.
	LDA.w DATA_00E266,Y			;$00E42D	||
	BRA CODE_00E435				;$00E430	||
CODE_00E432:					;			||
	LDA.w DATA_00E1D4+2,X		;$00E432	||
CODE_00E435:					;			||
	ORA $76						;$00E435	||
	TAY							;$00E437	||
	LDA.w DATA_00E21A,Y			;$00E438	||
	STA $05						;$00E43B	|/
	PLY							;$00E43D	|
	LDA.w DATA_00E1D4,X			;$00E43E	|\ Disable any extra cape tiles, if applicable.
	TSB $78						;$00E441	|/
	BMI CODE_00E448				;$00E443	|\ 
	JSR CODE_00E45D				;$00E445	|| Draw the main cape tile (04) and extra dynamic tile (7F).
CODE_00E448:					;			||
	LDX.w $13F9					;$00E448	|| If tile 7F is skipped by the value from $00E1D4,
	LDY.w DATA_00E2B6,X			;$00E44B	||  then the main tile is drawn with a different OAM index (for priority).
	JSR CODE_00E45D				;$00E44E	|/
	LDA $0E						;$00E451	|\ 
	STA $06						;$00E453	|| Draw the static cape tile.
	JSR CODE_00E45D				;$00E455	|/
CODE_00E458:					;			|
	JSR CODE_00F636				;$00E458	| Store the pointers to Mario's graphics for DMA upload later.
	PLB							;$00E45B	|
	RTL							;$00E45C	|