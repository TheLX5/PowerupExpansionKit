;##################################################################################################
;# File in charge of making every define used by the Powerup expansion kit patch available
;# in every sprite file.
;# If you're here you must know what you're doing, otherwise you should leave this file alone.

if canreadfile1("../../powerup_defs_path.asm",0)
    incsrc "../../powerup_defs_path.asm"
    if canreadfile1("!powerup_defs_path", 0)
        !_external_call = 1
        incsrc "!powerup_defs_path"
    else
        error "Please provide a proper path for powerup_defs.asm file that comes with the Powerup expansion kit patch."
    endif
else 
    error "Can't read powerup_defs_path.asm in PIXI's root folder."
endif

if not(canreadfile1("dynamic_spritesets_defines.asm",0))
    error "This patch requires the Dynamic Spritesets System patch to work properly with some of its features."
endif