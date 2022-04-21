includefrom "powerup_defs.asm"

;##################################################################################################
;# This absurdly convoluted script handles the powerup list file.
;# It automatically creates and assigns values to defines based on the list.
;# In other words, it's the heart of the defines file.


;# Current position in the list file
!_position = 0

;# Current line being parsed
!_line = 1

!_error_msg = ""

!max_powerup_num = 0

macro setup_error_msg(msg)
    !_error_msg := "<msg>"
    !_error_detected #= 1
    !_position #= $FFFFFE
    !_exit #= 1
endmacro

macro setup_warn_msg(msg)
    warn "<msg>"
    !_warn_detected #= 1
endmacro


print "Detected powerups:"

;# Initialize defines
!i #= 0
while !i != 128
    %internal_number_to_string(!i)
    !{powerup_!{_num}_internal_name} := "0"
    !{powerup_!{_num}_path} := "0"
    !i #= !i+1
endif

;# Loop until EOF
while readfile1("!powerup_list_path", !_position, $FF) != $FF
    ;# Process number
        !_powerup_num = ""
        %hex_2_ascii(readfile1("!powerup_list_path", !_position, $FF))
        if !_result_hex == $20
            %setup_error_msg("Line !_line: The powerup numbers shouldn't contain leading spaces.")
        elseif !_result_hex < $30 || !_result_hex >= $67
            %setup_error_msg("Line !_line: Invalid powerup number.")
        elseif !_result_hex >= $3A && !_result_hex <= $40
            %setup_error_msg("Line !_line: Invalid powerup number.")
        elseif !_result_hex >= $47 && !_result_hex <= $60
            %setup_error_msg("Line !_line: Invalid powerup number.")
        else
            !_position #= !_position+1
            !_powerup_num += !_result
            !_powerup_num := !_powerup_num
        endif

        if !_error_detected == 0
            !_result_hex = readfile1("!powerup_list_path", !_position, $FF)
            if !_result_hex == $20
                %setup_error_msg("Line !_line: The powerup numbers should be 2 digits long.")
            elseif !_result_hex < $30 || !_result_hex >= $67
                %setup_error_msg("Line !_line: Invalid powerup number.")
            elseif !_result_hex >= $3A && !_result_hex <= $40
                %setup_error_msg("Line !_line: Invalid powerup number.")
            elseif !_result_hex >= $47 && !_result_hex <= $60
                %setup_error_msg("Line !_line: Invalid powerup number.")
            else
                %hex_2_ascii(readfile1("!powerup_list_path", !_position, $FF))
                !_position #= !_position+1
                !_powerup_num += !_result
                !_powerup_num := !_powerup_num
            endif
        endif

    ;# Check if it's a duplicated powerup number
        !_exit = 0
        if !_error_detected == 1
            !_position #= $FFFFFE
            !_exit = 1
        else
            if not(stringsequal("!{powerup_!{_powerup_num}_path}", "0"))
                %setup_error_msg("Line !_line: Duplicated powerup number.")
                !_position #= $FFFFFE
                !_exit = 1
            endif
        endif

    ;# Detect proper spacing
        if !_exit == 0
            !_result_hex = readfile1("!powerup_list_path", !_position, $FF)
            if !_result_hex != $20
                %setup_error_msg("Line !_line: Invalid list entry.")
                !_position #= $FFFFFE
                !_exit = 1
            endif 
        endif

    ;# Process powerup name
        !_position #= !_position+1
        !_powerup_name = ""

        while !_exit != 1
            %hex_2_ascii(readfile1("!powerup_list_path", !_position, $FF))
            if !_result_hex == $FF
                !_exit = 1
            elseif !_result_hex == $0D
                !_position #= !_position+1
                if readfile1("!powerup_list_path", !_position, $FF) == $0A
                    !_position #= !_position+1
                endif
                !_exit = 1
            elseif !_result_hex == $0A
                !_position #= !_position+1
                !_exit = 1
            elseif !_result_hex == $20
                %setup_error_msg("Line !_line: Spaces in powerup names aren't supported.")
                !_position #= $FFFFFF
                !_exit = 1
            elseif !_result_hex == $FE
                %setup_error_msg("Line !_line: Unsupported character detected.")
                !_position #= $FFFFFF
                !_exit = 1
            else
                !_powerup_name += !_result
                !_powerup_name := !_powerup_name
                !_position #= !_position+1
            endif
        endif

    ;# Create defines
        !{powerup_!{_powerup_num}_internal_name} := !_powerup_name
        !{powerup_!{_powerup_num}_path} := "./powerups/!_powerup_name"
        !{!{_powerup_name}_powerup_num} := !_powerup_num
        !{!{_powerup_name}_powerup_num_string} := "!_powerup_num"

        if !_powerup_num >= !max_powerup_num
            !max_powerup_num #= !_powerup_num+1
        endif

        if !_position < $FFFFFE
            print "   Powerup !{!{_powerup_name}_powerup_num}: !{powerup_!{_powerup_num}_internal_name}"
            ;print "         Path: !{powerup_!{_powerup_num}_path}"
        endif

    ;# Restore
        !_powerup_num = ""
        !_powerup_name = ""
        !_exit = 0
        !_line #= !_line+1

endif

if !_position >= $FFFFFE
    print ""
    print "!!!!! ERROR !!!!!"
    print "!_error_msg"
    print ""

else

    print ""
    ;!max_powerup_num = !_line-2

    ;# !powerup_XX_internal_name = Nombre del powerup
    ;# !YYYY_powerup_num = Numero del powerup
    ;# !YYYY_powerup_num_string = Numero del powerup, version string
    ;# !powerup_XX_path = Direccion del powerup a insertar

endif 

;##################################################################################
;# Items


if !_error_detected == 0
;# Initialize defines
!i #= 0
while !i != 128
    %internal_number_to_string(!i)
    !{item_!{_num}_internal_name} := "0"
    !{item_!{_num}_path} := "0"
    !i #= !i+1
endif

!max_item_num = 0

;# Current position in the list file
!_position #= 0

;# Current line being parsed
!_line = 1

print "Detected powerup items:"

;# Loop until EOF
while readfile1("!item_list_path", !_position, $FF) != $FF
    ;# Process number
        !_item_num = ""
        %hex_2_ascii(readfile1("!item_list_path", !_position, $FF))
        if !_result_hex == $20
            %setup_error_msg("Line !_line: The item numbers shouldn't contain leading spaces.")
        elseif !_result_hex < $30 || !_result_hex >= $67
            %setup_error_msg("Line !_line: Invalid item number.")
        elseif !_result_hex >= $3A && !_result_hex <= $40
            %setup_error_msg("Line !_line: Invalid item number.")
        elseif !_result_hex >= $47 && !_result_hex <= $60
            %setup_error_msg("Line !_line: Invalid item number.")
        else
            !_position #= !_position+1
            !_item_num += !_result
            !_item_num := !_item_num
        endif

        if !_error_detected == 0
            !_result_hex = readfile1("!item_list_path", !_position, $FF)
            if !_result_hex == $20
                %setup_error_msg("Line !_line: The item numbers should be 2 digits long.")
            elseif !_result_hex < $30 || !_result_hex >= $67
                %setup_error_msg("Line !_line: Invalid item number.")
            elseif !_result_hex >= $3A && !_result_hex <= $40
                %setup_error_msg("Line !_line: Invalid item number.")
            elseif !_result_hex >= $47 && !_result_hex <= $60
                %setup_error_msg("Line !_line: Invalid item number.")
            else
                %hex_2_ascii(readfile1("!item_list_path", !_position, $FF))
                !_position #= !_position+1
                !_item_num += !_result
                !_item_num := !_item_num
            endif
        endif

    ;# Check if it's a duplicated item number
        !_exit = 0
        if !_error_detected == 1
            !_position #= $FFFFFE
            !_exit = 1
        else
            if not(stringsequal("!{item_!{_item_num}_path}", "0"))
                %setup_error_msg("Line !_line: Duplicated item number.")
                !_position #= $FFFFFE
                !_exit = 1
            endif
        endif

    ;# Detect proper spacing
        if !_exit == 0
            !_result_hex = readfile1("!item_list_path", !_position, $FF)
            if !_result_hex != $20
                %setup_error_msg("Line !_line: Invalid list entry.")
                !_position #= $FFFFFE
                !_exit = 1
            endif 
        endif

    ;# Process item name
        !_position #= !_position+1
        !_item_name = ""

        while !_exit != 1
            %hex_2_ascii(readfile1("!item_list_path", !_position, $FF))
            if !_result_hex == $FF
                !_exit = 1
            elseif !_result_hex == $0D
                !_position #= !_position+1
                if readfile1("!item_list_path", !_position, $FF) == $0A
                    !_position #= !_position+1
                endif
                !_exit = 1
            elseif !_result_hex == $0A
                !_position #= !_position+1
                !_exit = 1
            elseif !_result_hex == $20
                %setup_error_msg("Line !_line: Spaces in item names aren't supported.")
                !_position #= $FFFFFF
                !_exit = 1
            elseif !_result_hex == $FE
                %setup_error_msg("Line !_line: Unsupported character detected.")
                !_position #= $FFFFFF
                !_exit = 1
            else
                !_item_name += !_result
                !_item_name := !_item_name
                !_position #= !_position+1
            endif
        endif

    ;# Create defines
        !{item_!{_item_num}_internal_name} := !_item_name
        !{item_!{_item_num}_path} := "./items/!_item_name"
        !{!{_item_name}_item_num} := !_item_num
        !{!{_item_name}_item_num_string} := "!_item_num"

        if !_item_num >= !max_item_num
            !max_item_num #= !_item_num+1
        endif

        if !_position < $FFFFFE
            print "      Item !{!{_item_name}_item_num}: !{item_!{_item_num}_internal_name}"
        endif

    ;# Restore
        !_item_num = ""
        !_item_name = ""
        !_exit = 0
        !_line #= !_line+1

endif


if !_position >= $FFFFFE
    print ""
    print "!!!!! ERROR !!!!!"
    print "!_error_msg"
    print ""

else

    print ""
endif
endif

;##################################################################################
;# Graphics

if !_error_detected == 0
;# Initialize defines
!i #= 0
while !i != 128
    %internal_number_to_string(!i)
    !{gfx_!{_num}_internal_name} := "0"
    !{gfx_!{_num}_path} := "0"
    !i #= !i+1
endif

!max_gfx_num = 0

;# Current position in the list file
!_position #= 0

;# Current line being parsed
!_line = 1

print "Detected graphics:"
while readfile1("!gfx_list_path", !_position, $FF) != $FF
    ;# Process number
        !_gfx_num = ""
        %hex_2_ascii(readfile1("!gfx_list_path", !_position, $FF))
        if !_result_hex == $20
            %setup_error_msg("Line !_line: The GFXs numbers shouldn't contain leading spaces.")
        elseif !_result_hex < $30 || !_result_hex >= $67
            %setup_error_msg("Line !_line: Invalid GFX number.")
        elseif !_result_hex >= $3A && !_result_hex <= $40
            %setup_error_msg("Line !_line: Invalid GFX number.")
        elseif !_result_hex >= $47 && !_result_hex <= $60
            %setup_error_msg("Line !_line: Invalid GFX number.")
        else
            !_position #= !_position+1
            !_gfx_num += !_result
            !_gfx_num := !_gfx_num
        endif

        if !_error_detected == 0
            !_result_hex = readfile1("!gfx_list_path", !_position, $FF)
            if !_result_hex == $20
                %setup_error_msg("Line !_line: The GFX numbers should be 2 digits long.")
            elseif !_result_hex < $30 || !_result_hex >= $67
                %setup_error_msg("Line !_line: Invalid GFX number.")
            elseif !_result_hex >= $3A && !_result_hex <= $40
                %setup_error_msg("Line !_line: Invalid GFX number.")
            elseif !_result_hex >= $47 && !_result_hex <= $60
                %setup_error_msg("Line !_line: Invalid GFX number.")
            else
                %hex_2_ascii(readfile1("!gfx_list_path", !_position, $FF))
                !_position #= !_position+1
                !_gfx_num += !_result
                !_gfx_num := !_gfx_num
            endif
        endif

    ;# Check if it's a duplicated GFX number
        !_exit = 0
        if !_error_detected == 1
            !_position #= $FFFFFE
            !_exit = 1
        else
            if not(stringsequal("!{gfx_!{_gfx_num}_path}", "0"))
                %setup_error_msg("Line !_line: Duplicated GFX number.")
                !_position #= $FFFFFE
                !_exit = 1
            endif
        endif

    ;# Detect proper spacing
        if !_exit == 0
            !_result_hex = readfile1("!gfx_list_path", !_position, $FF)
            if !_result_hex != $20
                %setup_error_msg("Line !_line: Invalid list entry.")
                !_position #= $FFFFFE
                !_exit = 1
            endif 
        endif

    ;# Process GFX name
        !_position #= !_position+1
        !_gfx_name = ""

        while !_exit != 1
            %hex_2_ascii(readfile1("!gfx_list_path", !_position, $FF))
            if !_result_hex == $FF
                !_exit = 1
            elseif !_result_hex == $0D
                !_position #= !_position+1
                if readfile1("!gfx_list_path", !_position, $FF) == $0A
                    !_position #= !_position+1
                endif
                !_exit = 1
            elseif !_result_hex == $0A
                !_position #= !_position+1
                !_exit = 1
            elseif !_result_hex == $20
                %setup_error_msg("Line !_line: Spaces in GFX names aren't supported.")
                !_position #= $FFFFFF
                !_exit = 1
            elseif !_result_hex == $FE
                %setup_error_msg("Line !_line: Unsupported character detected.")
                !_position #= $FFFFFF
                !_exit = 1
            else
                !_gfx_name += !_result
                !_gfx_name := !_gfx_name
                !_position #= !_position+1
            endif
        endif

    ;# Create defines
        !{gfx_!{_gfx_num}_internal_name} := !_gfx_name
        !{gfx_!{_gfx_num}_path} := "./graphics/!_gfx_name"
        !{!{_gfx_name}_gfx_num} := !_gfx_num

        if !_position < $FFFFFE
            print "       GFX !{!{_gfx_name}_gfx_num}: !{gfx_!{_gfx_num}_internal_name}"
            ;print "         Path: !{gfx_!{_gfx_num}_path}"
        endif

    ;# Test files
    
        !{gfx_!{_gfx_num}_gfx_exist} = 0
        !{gfx_!{_gfx_num}_extra_gfx_exist} = 0
        !{gfx_!{_gfx_num}_x_disp_exist} = 0
        !{gfx_!{_gfx_num}_y_disp_exist} = 0
        !{gfx_!{_gfx_num}_tilemap_exist} = 0
        !{gfx_!{_gfx_num}_palette_exist} = 0
        !_path := "graphics/!{_gfx_name}"
        if canreadfile1("!_path/!_gfx_name.bin", 0)
            ; regular gfx exist, expecting disp, tilemap and palettes for it
            !{gfx_!{_gfx_num}_gfx_exist} = 1
            if canreadfile1("!_path/!{_gfx_name}_tilemap.asm", 0)
                !{gfx_!{_gfx_num}_tilemap_exist} = 1
            else
                %setup_error_msg("GFX !{_gfx_num} (!{_gfx_name}) is missing a file: !{_gfx_name}_tilemap.asm")
            endif
            if canreadfile1("!_path/!{_gfx_name}.mw3", 0)
                !{gfx_!{_gfx_num}_palette_exist} = 1
            else
                %setup_error_msg("GFX !{_gfx_num} (!{_gfx_name}) is missing a palette file: !{_gfx_name}.mw3")
            endif
            if canreadfile1("!_path/!{_gfx_name}_extra.bin", 0)
                !{gfx_!{_gfx_num}_extra_gfx_exist} = 1
            endif
        else 
            ; regular gfx doesn't exist, only extra gfx should exist and throw warning for unneeded files
            if canreadfile1("!_path/!{_gfx_name}_extra.bin", 0) != 0
                !{gfx_!{_gfx_num}_extra_gfx_exist} = 1
                if canreadfile1("!_path/!{_gfx_name}_tilemap.asm", 0)
                    !{gfx_!{_gfx_num}_tilemap_exist} = 1
                    %setup_warn_msg("GFX !{_gfx_num} (!{_gfx_name}) may have unnecesary files: !{_gfx_name}_tilemap.asm")
                endif
                if canreadfile1("!_path/!{_gfx_name}.mw3", 0)
                    !{gfx_!{_gfx_num}_palette_exist} = 1
                    %setup_warn_msg("GFX !{_gfx_num} (!{_gfx_name}) may have unnecesary files: !{_gfx_name}.mw3")
                endif
            else
                ; extra gfx doesn't exist, check for palette files
                if canreadfile1("!_path/!{_gfx_name}.mw3", 0) != 0
                    !{gfx_!{_gfx_num}_palette_exist} = 1
                    if canreadfile1("!_path/!{_gfx_name}_tilemap.asm", 0)
                        !{gfx_!{_gfx_num}_tilemap_exist} = 1
                        %setup_warn_msg("GFX !{_gfx_num} (!{_gfx_name}) may have unnecesary files: !{_gfx_name}_tilemap.asm")
                    endif
                else
                    %setup_error_msg("GFX !{_gfx_num} (!{_gfx_name}) is missing a file to be a valid entry: !{_gfx_name}_extra.bin or !{_gfx_name}.mw3")
                endif
            endif
        endif

        if !_gfx_num >= !max_gfx_num
            !max_gfx_num #= !_gfx_num+1
        endif

    ;# Restore
        !_gfx_num = ""
        !_gfx_name = ""
        !_exit = 0
        !_line #= !_line+1

endif

if !_position >= $FFFFFE
    print ""
    print "!!!!! ERROR !!!!!"
    print "!_error_msg"
    print ""

else

    print ""
endif
endif