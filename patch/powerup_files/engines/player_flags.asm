;################################################
;# Handles disabling crouching

pushpc
    org $00D600|!bank
        jsl crouching_flag
pullpc 

crouching_flag:
	phx 
	ldx !player_powerup
	lda.l .global_flags,x 
	plx
	eor !player_toggle_crouch
	beq .cant_crouch
    lda #$00
    sta !player_toggle_crouch
	lda $15
	and #$04
.cant_crouch
	rtl

.global_flags
    !i #= 0
    while !i < !max_powerup_num
        %internal_number_to_string(!i)
        if not(stringsequal("!{powerup_!{_num}_path}", "0"))
            db !{powerup_!{_num}_can_crouch}
        else
            db $01
        endif
        !i #= !i+1
    endif


;################################################
;# Handles disabling sliding

pushpc
    org $00EEF2|!bank
        jsl slide_flag
pullpc

slide_flag:
	phx 
	ldx !player_powerup
	lda.l .global_flags,x 
	plx
	eor !player_toggle_slide
	beq .cant_slide
    lda #$00
    sta !player_toggle_slide
    lda $15
    and #$04
.cant_slide
	rtl

.global_flags
    !i #= 0
    while !i < !max_powerup_num
        %internal_number_to_string(!i)
        if not(stringsequal("!{powerup_!{_num}_path}", "0"))
            db !{powerup_!{_num}_can_slide}
        else
            db $01
        endif
        !i #= !i+1
    endif


;################################################
;# Handles disabling spinjumping

pushpc
    org $00EA89|!bank
		JSL spinjump_flag
        BRA +
        NOP #3
    +
    org $00D645|!bank
		JSL spinjump_flag
        BRA +
        NOP #3
    +
pullpc


spinjump_flag:
	phx	
	ldx !player_powerup
	lda.l .global_flags,x
	eor !player_toggle_spinjump
	beq +
	sta !player_spinjump
	lda #$04
	sta $1DFC|!addr
	bra ++
+	
	lda #$00
	sta !player_toggle_spinjump
    rep #$20
    lda $00D65E+$02+$01     ; sfx port for jumping
    sta $00
    sep #$20
    lda $00D65E+$01         ; sfx num for jumping
    sta ($00)
++		
	plx
	rtl	

.global_flags
    !i #= 0
    while !i < !max_powerup_num
        %internal_number_to_string(!i)
        if not(stringsequal("!{powerup_!{_num}_path}", "0"))
            db !{powerup_!{_num}_can_spinjump}
        else
            db $01
        endif
        !i #= !i+1
    endif


;################################################
;# Handles disabling riding Yoshi

pushpc
    org $01ED38|!bank
        jml ride_yoshi_flag
pullpc

ride_yoshi_flag:
	phx 
	ldx !player_powerup
	lda.l .global_flags,x 
	plx 
    eor !player_toggle_ride_yoshi
    beq .force_end_code
    lda #$00
    sta !player_toggle_ride_yoshi
    lda !player_in_air
    beq .force_end_code
    jml $01ED3C|!bank
.force_end_code		
    jml $01ED70|!bank

.global_flags
    !i #= 0
    while !i < !max_powerup_num
        %internal_number_to_string(!i)
        if not(stringsequal("!{powerup_!{_num}_path}", "0"))
            db !{powerup_!{_num}_can_ride_yoshi}
        else
            db $01
        endif
        !i #= !i+1
    endif
