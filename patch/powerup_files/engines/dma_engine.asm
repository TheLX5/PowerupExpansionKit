includefrom "powerup.asm"

pushpc
    org $00A300|!bank
        autoclean jml dma_engine
    if read1($00A304|!bank) != $5C
        rts
    endif
    
    org $0FFB9C|!bank
        autoclean jml skip_player_gfx
    
    org $0FFC94|!bank
        autoclean jml fix_player_palette
pullpc

reset bytes

dma_engine:
    lda $0D84|!addr
    bne .run
    jml $00A304|!bank

.run
    rep #$20
    phd 
    lda #$4300
    tcd 

.palette_dma
    ldy.b #!palette_transfer_start
    sty $2121
    lda.w #(($1+!palette_transfer_end-!palette_transfer_start)*2)
    sta.b $05|(!dma_channel*$10)
    lda #$2200
    sta.b $00|(!dma_channel*$10)
    lda !player_palette_pointer
    sta.b $02|(!dma_channel*$10)
    lda !player_palette_pointer+1
    sta.b $03|(!dma_channel*$10)
    ldy.b #(1<<!dma_channel)
    sty $420B

.setup
    ldx #$80
    stx $2115
    lda #$1801
    sta.b $00|(!dma_channel*$10)

.misc_tiles
    ldx #$7E
    stx.b $04|(!dma_channel*$10)
    ldx #$06
    cpx $0D84
    bcs ..skip
    lda #$6060
    sta $2116
..loop_top
    lda $0D85|!addr,x
    sta.b $02|(!dma_channel*$10)
    lda #$0040
    sta.b $05|(!dma_channel*$10)
    sty $420B
    inx #2
    cpx $0D84|!addr
    bcc ..loop_top

    lda #$6160
    sta $2116
    ldx #$06
..loop_bot
    lda $0D8F|!addr,x
    sta.b $02|(!dma_channel*$10)
    lda #$0040
    sta.b $05|(!dma_channel*$10)
    sty $420B
    inx #2
    cpx $0D84|!addr
    bcc ..loop_bot
..skip


.5th_tile
    lda !player_extra_tile_settings
    lsr 
    bcc ..skip
    ldx $0D88|!addr
    stx.b $04|(!dma_channel*$10)

    lda #$6040
    sta $2116
    lda $0D89|!addr
    sta.b $02|(!dma_channel*$10)
    lda #$0040
    sta.b $05|(!dma_channel*$10)
    sty $420B

    lda #$6140
    sta $2116
    lda $0D93|!addr
    sta.b $02|(!dma_channel*$10)
    lda #$0040
    sta.b $05|(!dma_channel*$10)
    sty $420B
..skip


.player
    ldx $0D87|!addr
    stx.b $04|(!dma_channel*$10)
    lda $0D86|!addr
    pha
    ldx #$06
..loop
    lda.l .vramtbl,x
    sta $2116
    lda #$0080
    sta.b $05|(!dma_channel*$10)
    lda $0D85|!addr
    sta.b $02|(!dma_channel*$10)
    sty $420B
    inc $0D86|!addr
    inc $0D86|!addr
    dex #2
    bpl ..loop
    pla 
    sta $0D86|!addr
    pld 
    sep #$20
	jml $00A304|!bank

.vramtbl
	dw $6300,$6200,$6100,$6000


skip_player_gfx:
	ldx #$0140
	stx $4325
	plx
	stx $2116
	sta $420B
	
	ldy #$B180
	sty $4322
	ldx #$0180
	stx $4325
	ldx #$6240
	stx $2116
	sta $420B
	
	ldy #$B380
	sty $4322
	ldx #$0980
	stx $4325
	ldx #$6340
	jml $0FFBA3|!bank

fix_player_palette:
	phx
	ldy.b #$86
	sty $2121
	rep #$10
	ldx.w #(9*2)
	ldy.w #$86*2
-	
	lda $213B
	sta $0703|!addr,y
	lda $213B
	sta $0704|!addr,y
	iny #2
	dex #2
	bpl -
	sep #$10
	plx
	stz $2121
	rep #$30
	lda #$0200
	jml $0FFC99|!bank