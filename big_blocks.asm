; Tell Relaunch64 editor what start address there is for the program
; start=$0810

COLOR_BLACK         = $00
COLOR_WHITE         = $01
COLOR_RED           = $02
COLOR_CYAN          = $03
COLOR_PURPLE        = $04
COLOR_GREEN         = $05
COLOR_BLUE          = $06
COLOR_YELLOW        = $07
COLOR_ORANGE        = $08
COLOR_BROWN         = $09
COLOR_PINK          = $0A
COLOR_DARK_GREY     = $0B
COLOR_GREY          = $0C
COLOR_LIGHT_GREEN   = $0D
COLOR_LIGHT_BLUE    = $0E
COLOR_LIGHT_GREY    = $0F

CHARACTER_SPACE     = $20
CHARACTER_PERIOD    = $2E
CHARACTER_HASH      = $23
CHARACTER_PERCENT   = $25

CHARACTER_GIANA_FONT_ROUND_1 = $5B;
CHARACTER_GIANA_FONT_ROUND_2 = $5C;
CHARACTER_GIANA_FONT_SQUARE_1 = $5D;
CHARACTER_GIANA_FONT_SQUARE_2 = $5E;

!addr   SYSTEM_IRQ_HANDLER = $ea81


; Assuming Text screen mode
; Assuming using VIC bank 0 (which is default upon C64 start/reset with memory address range $0000-$3FFF thus size $4000=16k bytes). 
; To use character font bank 7, (the last possible font bank) within the current VIC bank, set memory location $D018 bit 1 through 3 to value %111 = #7. 
; Font bitmap data start at address: <VIC bank start address> + (<font bank size> * <font bank>) = $0000 + ($800 * #7) = $3800

constant_font_bank = $0e 
!addr   address_font = $3800
!addr   address_font_pointer = $D018
!addr   address_font_character_lo_byte = $0A
!addr   address_font_character_hi_byte = $0B

!addr   address_animated_diamond_delay = $0D
!addr   address_animated_diamond_frame = $0E

!addr   address_sid_music_init = $1000
!addr   address_sid_music_play = address_sid_music_init + 3

constant_pixel_character_active = CHARACTER_GIANA_FONT_ROUND_1
constant_pixel_character_inactive = CHARACTER_SPACE

constant_columns_per_line = 40
constant_top_scroll_line_index = 23 - 8     ; 8 lines of "pixels" for characters in text message with it's top on this line (zero indexed from top) [0-23]
constant_static_text_line_index = 0         ; Static text message with it's top on this line (zero indexed from top) [0-23]

constant_horizontal_scroll_delay = 0        ; Scroll delay value constant [0-128]  (unit: rendered frames, 1/50th of a second)
constant_text_color_scroll_delay = 0        ; Scroll delay value constant [0-255] (unit: rendered frames, 1/50th of a second)

constant_animated_diamond_delay = 3

!addr   address_static_text_colors_offset = $0C

!addr   address_border_color = $D020
!addr   address_screen_color = $D021
!addr   address_horizontal_scroll_register = $D016
!addr   address_first_screen_char_color = $D800
!addr   address_first_screen_char_character = $0400

!addr   address_horizontal_scroll_value = $03                   ; Current horizontal pixel scroll value. Stored at zero page

!addr   address_horizontal_scroll_delay_counter = $04           ; Scroll delay counter. Stored at zero page

!addr   address_scroll_message_character_offset = $05           ; Character offset in scroll message. Stored at zero page
!addr   address_scroll_message_character_pixel_offset = $08     ; Scroll message character pixel column offset. Stored at zero page
!addr   address_scroll_message_character_font_data = $09        ; Scroll message character pixel data start (first/upper line). Stored at zero page

!addr   address_text_color_scroll_delay_counter = $06           ; Text color scroll delay counter. Stored at zero page
!addr   address_text_color_scroll_offset = $07                  ; Offset in text color list. Stored at zero page
!addr   address_text_color_scroll_line_0 = address_first_screen_char_color + constant_columns_per_line * constant_top_scroll_line_index
!addr   address_text_color_scroll_line_1 = address_text_color_scroll_line_0 + constant_columns_per_line 
!addr   address_text_color_scroll_line_2 = address_text_color_scroll_line_1 + constant_columns_per_line 
!addr   address_text_color_scroll_line_3 = address_text_color_scroll_line_2 + constant_columns_per_line 
!addr   address_text_color_scroll_line_4 = address_text_color_scroll_line_3 + constant_columns_per_line 
!addr   address_text_color_scroll_line_5 = address_text_color_scroll_line_4 + constant_columns_per_line 
!addr   address_text_color_scroll_line_6 = address_text_color_scroll_line_5 + constant_columns_per_line 
!addr   address_text_color_scroll_line_7 = address_text_color_scroll_line_6 + constant_columns_per_line 

!addr   address_static_message_text_scr_pos = address_first_screen_char_character + constant_columns_per_line * constant_static_text_line_index

!addr   adress_scroll_line_0 = address_first_screen_char_character + constant_columns_per_line * (constant_top_scroll_line_index + 0)
!addr   adress_scroll_line_1 = address_first_screen_char_character + constant_columns_per_line * (constant_top_scroll_line_index + 1)
!addr   adress_scroll_line_2 = address_first_screen_char_character + constant_columns_per_line * (constant_top_scroll_line_index + 2)
!addr   adress_scroll_line_3 = address_first_screen_char_character + constant_columns_per_line * (constant_top_scroll_line_index + 3)
!addr   adress_scroll_line_4 = address_first_screen_char_character + constant_columns_per_line * (constant_top_scroll_line_index + 4)
!addr   adress_scroll_line_5 = address_first_screen_char_character + constant_columns_per_line * (constant_top_scroll_line_index + 5)
!addr   adress_scroll_line_6 = address_first_screen_char_character + constant_columns_per_line * (constant_top_scroll_line_index + 6)
!addr   adress_scroll_line_7 = address_first_screen_char_character + constant_columns_per_line * (constant_top_scroll_line_index + 7)

!addr   adress_scroll_line_0_last_pos = adress_scroll_line_0 + (constant_columns_per_line - 1)
!addr   adress_scroll_line_1_last_pos = adress_scroll_line_1 + (constant_columns_per_line - 1)
!addr   adress_scroll_line_2_last_pos = adress_scroll_line_2 + (constant_columns_per_line - 1)
!addr   adress_scroll_line_3_last_pos = adress_scroll_line_3 + (constant_columns_per_line - 1)
!addr   adress_scroll_line_4_last_pos = adress_scroll_line_4 + (constant_columns_per_line - 1)
!addr   adress_scroll_line_5_last_pos = adress_scroll_line_5 + (constant_columns_per_line - 1)
!addr   adress_scroll_line_6_last_pos = adress_scroll_line_6 + (constant_columns_per_line - 1)
!addr   adress_scroll_line_7_last_pos = adress_scroll_line_7 + (constant_columns_per_line - 1)

*=$0801

        ;!byte $01, $08                                          ; "File header" (?)
        !byte $0C, $08                                                          
        !byte $0A, $00, $9E, $20, $32, $30, $36, $34, $00        ; BASIC: 10 SYS 2064      ; #2064 = $0810
        !byte $00, $00                                           ; end of BASIC program

*=$0810

Init    
        
        LDY #0 - 1
        STY address_scroll_message_character_offset ; Reset scroll message to first character position
        STY address_text_color_scroll_offset        ; Reset text color scroll offset to first color position
	
        LDY #8
        STY address_scroll_message_character_pixel_offset ; Reset scroll message pixel offset
        
        LDY #7        
        STY address_horizontal_scroll_value         ; Set initial horizontal screen pixel scroll value
        
        LDY #constant_horizontal_scroll_delay
        STY address_horizontal_scroll_delay_counter ; Reset scroll delay counter to delay max value
        
        LDY #0
        STY address_static_text_colors_offset
        
        LDY #0 - 1
        STY address_animated_diamond_delay
        LDY #0 - 1
        STY address_animated_diamond_frame
        
        ; Set character font pointer to point to demo font
        LDA address_font_pointer
        ORA #constant_font_bank     
        STA address_font_pointer    
        
        JSR address_sid_music_init
        
        ; Set 38 column mode
        LDA address_horizontal_scroll_register
        AND #%11110111
        STA address_horizontal_scroll_register
        
        JSR clear_screen
        
        LDA #COLOR_BLACK       
        STA address_border_color	      ; Set screen border color 
        STA address_screen_color	      ; Set screen color 

        JSR print_static_message

        SEI
        LDA #%01111111
        STA $DC0D	      ; "Switch off" interrupts signals from CIA-1

        ;LDA $D01A      ; enable VIC-II Raster Beam IRQ
        ;ORA #$01
        ;STA $D01A

        LDA #%00000001
        STA $D01A	      ; Enable raster interrupt signals from VIC

        LDA $D011
        AND #%01111111
        STA $D011	      ; Clear most significant bit in VIC's raster register (for raster interrupt on upper part of screen, above line #256)
        
        LDA #$00        ; Interrupt on this raster line
        STA $D012       ; Set the raster line number where interrupt should occur
        
        LDA #<irq1
        STA $0314
        LDA #>irq1
        STA $0315	      ; Set the interrupt vector to point to interrupt service routine below
        
        CLI
        
        ;RTS             ; Initialization done; return to BASIC
no_exit        
    
        jmp no_exit
        
irq1	
        ; Turn off (reset) any horizontal scroll        
        LDA address_horizontal_scroll_register   
        AND #%11111000                          ; h-scroll is the lower 3 bits, so mask them off to zero's
        CLC                             
        ADC #$07                                ; add xscroll value (value always fits inside the lower 3 bits)
        STA address_horizontal_scroll_register    

        ; Set next raster interrupt (raster interrupt irq2)
        lda #<irq2
        sta $0314
        lda #>irq2
        sta $0315
        
                
        lda #60 ; Create raster interrupt at line 60
        sta $d012

        ASL $D019	      ; "Acknowledge" (ASL do both read and write to memory location) the interrupt by clearing the VIC's interrupt flag.
        ;JMP $EA31	      ; Jump into KERNAL's standard interrupt service routine to handle keyboard scan, cursor display etc.
        JMP SYSTEM_IRQ_HANDLER

irq2	
        ; DEBUG: set border color for now        
        ;LDA #COLOR_BLACK       
        ;STA address_border_color	      ; Set screen border color 
        ;STA address_screen_color	      ; Set screen color 

        ;jsr rasterline_start
        
        JSR animate_diamond

        JSR scroll_text
        
        JSR text_color_scroll
        
        JSR address_sid_music_play

        JSR flicker_static_text_color

        ;jsr rasterline_end

        ; Set next raster interrupt (back to raster interrupt irq1)
        lda #<irq1
        sta $0314
        lda #>irq1
        sta $0315

        LDA #49         ; Interrupt on this raster line
        STA $D012       ; Set the raster line number where interrupt should occur

        ASL $D019	      ; "Acknowledge" (ASL do both read and write to memory location) the interrupt by clearing the VIC's interrupt flag.
        ;JMP $EA31	      ; Jump into KERNAL's standard interrupt service routine to handle keyboard scan, cursor display etc.
        JMP SYSTEM_IRQ_HANDLER
;----------------------------------------------
animate_diamond
        LDY address_animated_diamond_delay
        CPY #constant_animated_diamond_delay
        BEQ +
        INY        
        STY address_animated_diamond_delay
        RTS
+       LDY #0
        STY address_animated_diamond_delay
        
        LDY address_animated_diamond_frame
        INY
        CPY #6
        BNE +
        LDY #0
+       STY address_animated_diamond_frame         
        
        TYA
        ASL
        ASL
        ASL
        TAY
        
        ; Store animated diamond data at character #$25 (percent sign '%')
        constant_animated_character_index = CHARACTER_PERCENT 
        LDA address_diamond_animation_data + 0, Y
        STA address_font + (constant_animated_character_index * 8) + 0  
        LDA address_diamond_animation_data + 1, Y
        STA address_font + (constant_animated_character_index * 8) + 1  
        LDA address_diamond_animation_data + 2, Y
        STA address_font + (constant_animated_character_index * 8) + 2  
        LDA address_diamond_animation_data + 3, Y
        STA address_font + (constant_animated_character_index * 8) + 3  
        LDA address_diamond_animation_data + 4, Y
        STA address_font + (constant_animated_character_index * 8) + 4  
        LDA address_diamond_animation_data + 5, Y
        STA address_font + (constant_animated_character_index * 8) + 5  
        LDA address_diamond_animation_data + 6, Y
        STA address_font + (constant_animated_character_index * 8) + 6  
        LDA address_diamond_animation_data + 7, Y
        STA address_font + (constant_animated_character_index * 8) + 7  
        
        RTS

;----------------------------------------------
flicker_static_text_color
        LDY address_static_text_colors_offset
        LDA static_text_colors, Y
        CMP #$FF ; end of color list marker
        BNE +
        
        ; Reset color list
        LDY #$00
        LDA static_text_colors, Y

+       LDX #$00
.flicker_static_text_color_loop 
        STA address_first_screen_char_color + constant_columns_per_line * constant_static_text_line_index, X 
        INX
        CPX #constant_columns_per_line
        BNE .flicker_static_text_color_loop
        
.flicker_static_text_color_end        
        INY
        STY address_static_text_colors_offset
        RTS

static_text_colors
        !byte COLOR_BROWN, COLOR_DARK_GREY, COLOR_BROWN, COLOR_DARK_GREY
        !byte COLOR_RED
        !byte COLOR_ORANGE
        !byte COLOR_PINK
        !byte COLOR_LIGHT_GREY
        !byte COLOR_LIGHT_GREEN
        !byte COLOR_YELLOW
        !byte COLOR_WHITE, COLOR_WHITE, COLOR_WHITE, COLOR_WHITE, COLOR_WHITE, COLOR_WHITE, COLOR_WHITE, COLOR_WHITE 
        !byte COLOR_WHITE, COLOR_WHITE, COLOR_WHITE, COLOR_WHITE, COLOR_WHITE, COLOR_WHITE, COLOR_WHITE, COLOR_WHITE 
        !byte COLOR_WHITE, COLOR_WHITE, COLOR_WHITE, COLOR_WHITE, COLOR_WHITE, COLOR_WHITE, COLOR_WHITE, COLOR_WHITE 
        !byte COLOR_WHITE, COLOR_WHITE, COLOR_WHITE, COLOR_WHITE, COLOR_WHITE, COLOR_WHITE, COLOR_WHITE, COLOR_WHITE 
        !byte COLOR_WHITE, COLOR_WHITE, COLOR_WHITE, COLOR_WHITE, COLOR_WHITE, COLOR_WHITE, COLOR_WHITE, COLOR_WHITE 
        !byte COLOR_WHITE, COLOR_WHITE, COLOR_WHITE, COLOR_WHITE, COLOR_WHITE, COLOR_WHITE, COLOR_WHITE, COLOR_WHITE 
        !byte COLOR_YELLOW
        !byte COLOR_LIGHT_GREEN
        !byte COLOR_LIGHT_GREY
        !byte COLOR_PINK
        !byte COLOR_ORANGE
        !byte COLOR_RED
        !byte $FF

        !byte COLOR_DARK_GREY,   COLOR_BROWN          ;   0   (0)
        !byte COLOR_DARK_GREY,   COLOR_BROWN          ;   1   (0)
        !byte COLOR_DARK_GREY,   COLOR_BROWN          ;   2   (0)
        !byte COLOR_DARK_GREY,   COLOR_BROWN          ;   3   (0)
        !byte COLOR_DARK_GREY,   COLOR_DARK_GREY      ;   4   (1)
        !byte COLOR_DARK_GREY,   COLOR_DARK_GREY      ;   5   (1)
        !byte COLOR_DARK_GREY,   COLOR_RED            ;   6   (2)
        !byte COLOR_DARK_GREY,   COLOR_RED            ;   7   (2)
        !byte COLOR_DARK_GREY,   COLOR_PURPLE         ;   8   (3)
        !byte COLOR_DARK_GREY,   COLOR_PURPLE         ;   9   (3)
        !byte COLOR_PURPLE,      COLOR_PURPLE         ;  10   (4)
        !byte COLOR_GREY,        COLOR_PURPLE         ;  11   (5)
        !byte COLOR_GREY,        COLOR_GREY           ;  12   (6)
        !byte COLOR_GREY,        COLOR_GREY           ;  13   (6)
        !byte COLOR_GREY,        COLOR_LIGHT_GREY     ;  14   (7)
        !byte COLOR_LIGHT_GREY,  COLOR_LIGHT_GREY     ;  15   (8)
        !byte COLOR_LIGHT_GREY,  COLOR_YELLOW         ;  16   (9)
        !byte COLOR_LIGHT_GREY,  COLOR_YELLOW         ;  17   (9)
        !byte COLOR_YELLOW,      COLOR_YELLOW         ;  18   (10)
        !byte COLOR_YELLOW,      COLOR_YELLOW         ;  19   (10)
        !byte COLOR_YELLOW,      COLOR_WHITE          ;  20   (11)
        !byte COLOR_YELLOW,      COLOR_WHITE          ;  21   (11)
        !byte COLOR_WHITE,       COLOR_WHITE          ;  22   (12)
        !byte COLOR_WHITE,       COLOR_WHITE          ;  23   (12)
        !byte COLOR_WHITE,       COLOR_WHITE          ;  24   (12)
        !byte COLOR_WHITE,       COLOR_WHITE          ;  25   (12)
        !byte COLOR_WHITE,       COLOR_WHITE          ;  26   (12)
        !byte COLOR_WHITE,       COLOR_WHITE          ;  27   (12)
        !byte COLOR_WHITE,       COLOR_WHITE          ;  28   (12)
        !byte COLOR_YELLOW,      COLOR_WHITE          ;  29   (11)
        !byte COLOR_YELLOW,      COLOR_WHITE          ;  30   (11)
        !byte COLOR_YELLOW,      COLOR_YELLOW         ;  31   (10)
        !byte COLOR_YELLOW,      COLOR_YELLOW         ;  32   (10)
        !byte COLOR_LIGHT_GREY,  COLOR_YELLOW         ;  33   (9)
        !byte COLOR_LIGHT_GREY,  COLOR_YELLOW         ;  34   (9)
        !byte COLOR_LIGHT_GREY,  COLOR_LIGHT_GREY     ;  35   (8)
        !byte COLOR_GREY,        COLOR_LIGHT_GREY     ;  36   (7)
        !byte COLOR_GREY,        COLOR_GREY           ;  37   (6)
        !byte COLOR_GREY,        COLOR_GREY           ;  38   (6)
        !byte COLOR_GREY,        COLOR_PURPLE         ;  39   (5)
        !byte COLOR_PURPLE,      COLOR_PURPLE         ;  40   (4)
        !byte COLOR_DARK_GREY,   COLOR_PURPLE         ;  41   (3)
        !byte COLOR_DARK_GREY,   COLOR_PURPLE         ;  42   (3)
        !byte COLOR_DARK_GREY,   COLOR_RED            ;  43   (2)
        !byte COLOR_DARK_GREY,   COLOR_RED            ;  44   (2)
        !byte COLOR_DARK_GREY,   COLOR_DARK_GREY      ;  45   (1)
        !byte COLOR_DARK_GREY,   COLOR_DARK_GREY      ;  46   (1)
        !byte COLOR_DARK_GREY,   COLOR_BROWN          ;  47   (0)
        !byte COLOR_DARK_GREY,   COLOR_BROWN          ;  48   (0)
        !byte COLOR_DARK_GREY,   COLOR_BROWN          ;  49   (0)       
        !byte $FF
        

; ---------------------------------------------        
; Paint a raster band                            
; ---------------------------------------------        
rasterline_start
        ; rasterline start paint        
        LDA #COLOR_YELLOW       
        ;STA address_border_color	      ; Set screen border color to yellow
        STA address_screen_color	      ; Set screen color to yellow
        
        RTS
         
rasterline_end
        ; rasterline stop paint        
        LDA #COLOR_BLACK
        STA address_border_color	      ; Set screen border color to black
        STA address_screen_color	      ; Set screen color to black
        
        RTS
        
        
; ---------------------------------------------        
; Clear screen subroutine                            
; ---------------------------------------------        
clear_screen                                    
        LDA #CHARACTER_SPACE ; "Space" character code
        ;LDA #CHARACTER_HASH ; Debug character code
        LDX #0
.clear_screen_loop   
        sta $0400,x
        sta $0500,x
        sta $0600,x
        sta $0700,x
        dex
        bne .clear_screen_loop
        
        rts


; ---------------------------------------------        
; Print static text message                            
; ---------------------------------------------        
print_static_message        
        LDX #$00
        
.print_static_message_loop 
        LDA static_message_text, x
        CMP #$00  ; Have we encountered text message null termination
        BEQ .print_static_message_loop_end 
        
        ;ORA #$80 ; Invert character
        
        STA $0400 + constant_columns_per_line * constant_static_text_line_index, x ; print static message text data to screen character location 
        
        LDA #COLOR_RED
        STA $D800 + constant_columns_per_line * constant_static_text_line_index, x ; print static message text data to screen character location 
 
        INX
        CPX #$00
        BEQ .print_static_message_loop_end
        JMP .print_static_message_loop
        
.print_static_message_loop_end        
        RTS


; ---------------------------------------------        
; Scroll screen text content a pixel                            
; ---------------------------------------------        
scroll_text

.scrolldelaycheck
        LDX address_horizontal_scroll_delay_counter   
        DEX
        BPL .nopixelscroll

        LDX #constant_horizontal_scroll_delay
        STX address_horizontal_scroll_delay_counter
        JMP .pixelscroll

.nopixelscroll
        STX address_horizontal_scroll_delay_counter
        JMP .endscroll
               
.pixelscroll        
        LDA address_horizontal_scroll_register   
        AND #%11111000                          ; h-scroll is the lower 3 bits, so mask them off to zero's
        CLC                             
        ADC address_horizontal_scroll_value     ; add xscroll value (value always fits inside the lower 3 bits)
        STA address_horizontal_scroll_register    
        
        LDY address_horizontal_scroll_value
        CPY #7
        BNE .no_charpos_scroll
        
.message_character_scroll        
        JSR scroll_message_one_char ; copy all screen character content one character position to the left  
        JSR add_next_rightmost_scroll_message_char_pixel ; Add a new character at the very far right of the line (that will later scroll in to the left)
        
.no_charpos_scroll
        LDY address_horizontal_scroll_value
        DEY ; Scroll one pixels at a time for smoooth scroll!
        DEY ; Scroll two pixels at a time for speeeed!
        BMI .pixelscrollreset
        STY address_horizontal_scroll_value
        JMP .endscroll
        
.pixelscrollreset        
        LDY #7 ; Move horizontal scroll of screen 7 pixels to the right         
        STY address_horizontal_scroll_value
        JMP .endscroll
        
.endscroll        
        RTS   


; ---------------------------------------------        
; Scroll text color of text message line 1 character position                           
; ---------------------------------------------        
text_color_scroll
.text_color_scroll_delaycheck
        LDX address_text_color_scroll_delay_counter   
        DEX
        BPL .no_text_color_scroll

        LDX #constant_text_color_scroll_delay
        STX address_text_color_scroll_delay_counter
        JMP .text_color_scroll

.no_text_color_scroll
        STX address_text_color_scroll_delay_counter
        JMP .end_text_color_scroll
               
.text_color_scroll        
        
        LDY #$FF
.text_color_scroll_loop        
        INY
        LDA address_text_color_scroll_line_0 + 1, Y
        STA address_text_color_scroll_line_0, Y
        LDA address_text_color_scroll_line_1 + 1, Y
        STA address_text_color_scroll_line_1, Y
        LDA address_text_color_scroll_line_2 + 1, Y
        STA address_text_color_scroll_line_2, Y
        LDA address_text_color_scroll_line_3 + 1, Y
        STA address_text_color_scroll_line_3, Y
        LDA address_text_color_scroll_line_4 + 1, Y
        STA address_text_color_scroll_line_4, Y
        LDA address_text_color_scroll_line_5 + 1, Y
        STA address_text_color_scroll_line_5, Y
        LDA address_text_color_scroll_line_6 + 1, Y
        STA address_text_color_scroll_line_6, Y
        LDA address_text_color_scroll_line_7 + 1, Y
        STA address_text_color_scroll_line_7, Y
        CPY #constant_columns_per_line - 2
        BNE .text_color_scroll_loop   

.text_color_scroll_new_rightmost_color
        LDX address_text_color_scroll_offset
        INX
        
        LDA scroll_text_colors, X
        CMP #$FF
        BNE .skip_text_color_scroll_offset_reset
        
        LDX #$00
        
.skip_text_color_scroll_offset_reset        
        LDA scroll_text_colors, X
        STA address_text_color_scroll_line_0 + constant_columns_per_line - 1
        LDA address_text_color_scroll_line_0 + constant_columns_per_line - 2
        STA address_text_color_scroll_line_1 + constant_columns_per_line - 1
        LDA address_text_color_scroll_line_1 + constant_columns_per_line - 2
        STA address_text_color_scroll_line_2 + constant_columns_per_line - 1
        LDA address_text_color_scroll_line_2 + constant_columns_per_line - 2
        STA address_text_color_scroll_line_3 + constant_columns_per_line - 1
        LDA address_text_color_scroll_line_3 + constant_columns_per_line - 2
        STA address_text_color_scroll_line_4 + constant_columns_per_line - 1
        LDA address_text_color_scroll_line_4 + constant_columns_per_line - 2
        STA address_text_color_scroll_line_5 + constant_columns_per_line - 1
        LDA address_text_color_scroll_line_5 + constant_columns_per_line - 2
        STA address_text_color_scroll_line_6 + constant_columns_per_line - 1
        LDA address_text_color_scroll_line_6 + constant_columns_per_line - 2
        STA address_text_color_scroll_line_7 + constant_columns_per_line - 1

        STX address_text_color_scroll_offset
        
.end_text_color_scroll        
        RTS
        
address_diamond_animation_data        
    !bin "diamonds.bin"      ; 6 character data that make out an animated gianna sisters diamond      
        
address_current_font_character_pixel_data       
        !byte %00000000 
        !byte %00000000 
        !byte %00000000 
        !byte %00000000 
        !byte %00000000 
        !byte %00000000 
        !byte %00000000 
        !byte %00000000 
        
address_rightmost_char_pos_on_screen
        address_scroll_line_top = $0400 + constant_columns_per_line * constant_top_scroll_line_index

; ---------------------------------------------        
; Scroll message line 1 character pixel position                           
; ---------------------------------------------        
add_next_rightmost_scroll_message_char_pixel
        DEC address_scroll_message_character_pixel_offset  
        LDA address_scroll_message_character_pixel_offset
        BNE .skip_copy_new_char
        
        LDA #8 ; Reset character pixel column counter
        STA address_scroll_message_character_pixel_offset;

        INC address_scroll_message_character_offset ; Advance to next character in scroll message text
        LDY address_scroll_message_character_offset ; Load character scroll text offset into Y

        LDA scroll_text_message, Y ; Load character value into A
        BNE .skip_scroll_message_offset_reset 
        
        LDY #$00
        STY address_scroll_message_character_offset
        LDA scroll_text_message, Y ; Load character value into A
        
.skip_scroll_message_offset_reset        
        
        ;LDX #COLOR_WHITE
        ;STX $D800
        ;STA $0400 ; DEBUG: Print character in white at top left corner for debug purpose         
        
.setup_font_character_indirect_address        
        ; Initialize the indirect address of the font character by setting the character value in the adress low byte
        STA address_font_character_lo_byte
        LDA #$00
        STA address_font_character_hi_byte
        
        ; Multiply character index with 8 (There are 8 bytes per character. Shift left for 3 bits over two bytes.)
        ; Font character offset start byte will be at indirect address (hi and lo byte) 
        ASL address_font_character_lo_byte
        ROL address_font_character_hi_byte
        ASL address_font_character_lo_byte
        ROL address_font_character_hi_byte
        ASL address_font_character_lo_byte
        ROL address_font_character_hi_byte
        CLC

        ; Add font address $3800 to calculated (indirect address) font character offset 
        ; Special case since we use font address $3800 (%00111000 00000000) with bits only set in high byte 
        ; (and higher than the 3 least significant bits) we can "add" $3800 to font character offset by just OR in the bits into the high byte
        LDA address_font_character_hi_byte
        ORA #>address_font   
        STA address_font_character_hi_byte
        
        ; The indirect address at $address_font_character_lo_byte do now point to the first pixel data byte of sought the character in the font 
        
        LDY #0
.copy_font_char_pixel_data        
        LDA (address_font_character_lo_byte), Y            ; indirect address hold the first byte (upper line) of character's pixel data
        STA address_current_font_character_pixel_data, Y
        INY
        CPY #8 
        BNE .copy_font_char_pixel_data
        
.skip_copy_new_char        
        
        ; Rotate/Shift in leftmost/highest bit of font character pixel data to rightmost/lowest bit
        ; For each of the 8 bytes that make out one charcter in the font
        LDX #0
.shift_character_pixel_bytes        
        CLC
        ASL address_current_font_character_pixel_data, X
        BCC +
        LDA #%00000001
        ORA address_current_font_character_pixel_data, X
        STA address_current_font_character_pixel_data, X
+       INX
        CPX #8 ; All 8 pixel bytes of the font character rotated/shifted?
        BNE .shift_character_pixel_bytes

.put_font_character_pixel_column_to_screen

        LDA address_current_font_character_pixel_data + 0          
        JSR get_pixel_character
        STA adress_scroll_line_0_last_pos

        LDA address_current_font_character_pixel_data + 1          
        JSR get_pixel_character
        STA adress_scroll_line_1_last_pos

        LDA address_current_font_character_pixel_data + 2         
        JSR get_pixel_character
        STA adress_scroll_line_2_last_pos

        LDA address_current_font_character_pixel_data + 3         
        JSR get_pixel_character
        STA adress_scroll_line_3_last_pos

        LDA address_current_font_character_pixel_data + 4        
        JSR get_pixel_character
        STA adress_scroll_line_4_last_pos

        LDA address_current_font_character_pixel_data + 5         
        JSR get_pixel_character
        STA adress_scroll_line_5_last_pos

        LDA address_current_font_character_pixel_data + 6         
        JSR get_pixel_character
        STA adress_scroll_line_6_last_pos

        LDA address_current_font_character_pixel_data + 7         
        JSR get_pixel_character
        STA adress_scroll_line_7_last_pos

        RTS

!scr "test .#end"


; ------------------------
get_pixel_character
        AND #%00000001
        BNE .pixel_character_active
.pixel_character_inactive        
        LDA #constant_pixel_character_inactive
        RTS
.pixel_character_active        
        LDA #constant_pixel_character_active         
        RTS


; ---------------------------------------------        
; Scroll message text line 1 character position to the left                           
; ---------------------------------------------        
scroll_message_one_char
        LDX #$FF
.scroll_line_char_loop        
        INX
        LDA adress_scroll_line_0 + 1, x
        STA adress_scroll_line_0, x
        LDA adress_scroll_line_1 + 1, x
        STA adress_scroll_line_1, x
        LDA adress_scroll_line_2 + 1, x
        STA adress_scroll_line_2, x
        LDA adress_scroll_line_3 + 1, x
        STA adress_scroll_line_3, x
        LDA adress_scroll_line_4 + 1, x
        STA adress_scroll_line_4, x
        LDA adress_scroll_line_5 + 1, x
        STA adress_scroll_line_5, x
        LDA adress_scroll_line_6 + 1, x
        STA adress_scroll_line_6, x
        LDA adress_scroll_line_7 + 1, x
        STA adress_scroll_line_7, x
        CPX #constant_columns_per_line - 2
        BNE .scroll_line_char_loop   
  
        RTS
        
        
scroll_text_colors        
        !byte COLOR_DARK_GREY, COLOR_DARK_GREY, COLOR_DARK_GREY, COLOR_DARK_GREY, COLOR_DARK_GREY, COLOR_DARK_GREY, COLOR_DARK_GREY
        !byte COLOR_BROWN
        !byte COLOR_RED
        !byte COLOR_ORANGE
        !byte COLOR_PINK
        !byte COLOR_ORANGE
        !byte COLOR_RED
        !byte COLOR_BROWN
        !byte COLOR_DARK_GREY, COLOR_DARK_GREY, COLOR_DARK_GREY
        !byte COLOR_BROWN
        !byte COLOR_RED
        !byte COLOR_ORANGE
        !byte COLOR_RED
        !byte COLOR_BROWN
        !byte COLOR_DARK_GREY, COLOR_DARK_GREY, COLOR_DARK_GREY, COLOR_DARK_GREY, COLOR_DARK_GREY
        !byte COLOR_BROWN
        !byte COLOR_RED
        !byte COLOR_ORANGE
        !byte COLOR_PINK
        !byte COLOR_YELLOW
        !byte COLOR_WHITE 
        !byte COLOR_YELLOW
        !byte COLOR_PINK
        !byte COLOR_ORANGE
        !byte COLOR_RED
        !byte COLOR_BROWN, COLOR_DARK_GREY
        !byte COLOR_DARK_GREY, COLOR_DARK_GREY, COLOR_DARK_GREY, COLOR_DARK_GREY
        !byte COLOR_BROWN, COLOR_DARK_GREY
        !byte COLOR_RED
        !byte COLOR_ORANGE
        !byte COLOR_PINK
        !byte COLOR_LIGHT_GREY
        !byte COLOR_LIGHT_GREEN
        !byte COLOR_YELLOW
        !byte COLOR_WHITE 
        !byte COLOR_YELLOW
        !byte COLOR_LIGHT_GREEN
        !byte COLOR_LIGHT_GREY
        !byte COLOR_PINK
        !byte COLOR_ORANGE
        !byte COLOR_RED
        !byte COLOR_BROWN, COLOR_DARK_GREY
        !byte $FF ; Color list termination value
    
        !byte COLOR_DARK_GREY,  COLOR_DARK_GREY 
        !byte COLOR_DARK_GREY,  COLOR_DARK_GREY 
        !byte COLOR_GREY,       COLOR_GREY
        !byte COLOR_DARK_GREY,  COLOR_DARK_GREY 
        !byte COLOR_DARK_GREY,  COLOR_DARK_GREY 
        !byte COLOR_GREY,       COLOR_GREY
        !byte COLOR_DARK_GREY,  COLOR_DARK_GREY 
        !byte COLOR_DARK_GREY,  COLOR_DARK_GREY 
        !byte COLOR_DARK_GREY,  COLOR_DARK_GREY 
        !byte COLOR_DARK_GREY,  COLOR_DARK_GREY 
        !byte COLOR_DARK_GREY,  COLOR_DARK_GREY 
        !byte COLOR_DARK_GREY,  COLOR_DARK_GREY 
        !byte COLOR_GREY,       COLOR_GREY
        !byte COLOR_LIGHT_GREY, COLOR_LIGHT_GREY 
        !byte COLOR_WHITE,      COLOR_WHITE         
        ;!byte COLOR_YELLOW,     COLOR_YELLOW         
        !byte COLOR_WHITE,      COLOR_WHITE         
        !byte COLOR_LIGHT_GREY, COLOR_LIGHT_GREY 
        !byte COLOR_GREY,       COLOR_GREY         
        !byte $FF ; Color list termination value


; ---------------------------------------------        
; Static message text (null terminated)                            
; ---------------------------------------------        
static_message_text    
;   !scr "1234567890123456789012345678901234567890"                       
    !scr "     %  Till Grabbarna på gatan  %      "                       
    !byte $00 ; Static message text is null terminated
    
    
; ---------------------------------------------        
; Scroll message text (null terminated)                            
; ---------------------------------------------        
scroll_text_message
;   !scr "1234567890123456789012345678901234567890"                       
;   !scr "1234567890123456789012345678901234567890123456789012345678901234"                       
    !scr "     Hej på er! Äntligen har jag fått tummen ur och gjort min mjukscroll ... "
    !scr "30 år senare... De varmaste hälsningarna till bästa kompisarna på" 
    !scr " Viskarhultsvägen i 54:an och 59:an från 51:an."
    !scr " Det är er jag tackar för så mycket från min barndom.   "
    !byte $00 ; Scroll message text is null terminated

    
; ---------------------------------------------        
; SID Music                            
; ---------------------------------------------        
* = address_sid_music_init    
        ; Player size$0DE0 (3552 bytes)
        ; Load address$1000 (4096)
        ; Init address$1000 (4096)
        ; Play address$1003 (4099)
        ; Default subtune1 / 1
    !bin "sid/Great_Giana_Sisters.sid",,$7C + 2


; ---------------------------------------------        
; Text font                            
; ---------------------------------------------        
; More fonts at http://kofler.dot.at/c64/
; Load font to last 2k block of bank 3    
* = address_font    
    !bin "fonts/Giana sisters demo font 02.bin"
;    !bin "fonts/giana_sisters.font.64c",,2
;    !bin "fonts/devils_collection_25_y.64c",,2
;    !bin "fonts/double_char_font.bin"

