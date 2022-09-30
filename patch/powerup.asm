;##################################################################################################
;# Powerup expansion kit - Made by lx5

    print ""
    print "Powerup expansion kit v1.0 - Made by lx5"
    print "Readme & documentation: later lol"
    print ""

;################################################
; Defines, do not edit these

    incsrc "powerup_defs.asm"

if !i_read_the_readme == 0
    print "Nothing was inserted."
    print "Please read the GitHub wiki."
else

if !SA1 = 1
    sa1rom
endif

if !_error_detected == 0

    if !ENABLE_VERBOSE
        print "Verbose: ON"
        print ""
    endif 

;#########################################################################
;# Insert everything

	freecode

	!i = 0
	!j = 0
	while !i < !max_gfx_num
		%internal_number_to_string(!i)
		if not(stringsequal("!{gfx_!{_num}_path}", "0"))
            if !{gfx_!{_num}_gfx_exist} != 0
                if !j == 0
                    !protected_data := "gfx_!{_num}_graphics"
                    !j #= 1
                else
                    !protected_data := "!protected_data, gfx_!{_num}_graphics"
                endif
            endif
            if !{gfx_!{_num}_extra_gfx_exist} != 0
                if !j == 0
                    !protected_data := "gfx_!{_num}_extra_graphics"
                    !j #= 1
                else
                    !protected_data := "!protected_data, gfx_!{_num}_extra_graphics"
                endif
            endif
		endif
		!i #= !i+1
	endif

	prot !protected_data

;################################################
;# Engines handler

    %insert_file("engines/main_engine.asm")
    %insert_file("engines/image_engine.asm")
    %insert_file("engines/initializer.asm")
    %insert_file("engines/palette_engine.asm")
    %insert_file("engines/dma_engine.asm")
    %insert_file("engines/player_exgfx_engine.asm")
    %insert_file("engines/extra_tile_engine.asm")
    %insert_file("engines/interaction_engine.asm")
    %insert_file("engines/player_flags.asm")
    %insert_file("engines/player_displacements.asm")
    %insert_file("engines/powerdown_engine.asm")
    %insert_file("engines/item_engine.asm")
    %insert_file("engines/item_box_engine.asm")
    %insert_file("engines/controller_mask.asm")

;#########################################################################
;# End

    if !_warn_detected == 1
        print "WARNINGS DETECTED. Read the console for more information."
        print ""
    endif
        print "Total insert size: ", freespaceuse, " bytes"
    else 
    if !_warn_detected == 1
        print "WARNINGS DETECTED. Read the console for more information."
        print ""
    endif
        print "Nothing was inserted."
    endif

endif