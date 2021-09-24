/*
  2020-10-11
  The first real scroll demo made for the
  best friends of the Viskarhultsvägen
  back in the good old days...
*/

.const COLOR_BLACK         = $00
.const COLOR_WHITE         = $01
.const COLOR_RED           = $02
.const COLOR_CYAN          = $03
.const COLOR_PURPLE        = $04
.const COLOR_GREEN         = $05
.const COLOR_BLUE          = $06
.const COLOR_YELLOW        = $07
.const COLOR_ORANGE        = $08
.const COLOR_BROWN         = $09
.const COLOR_PINK          = $0A
.const COLOR_DARK_GREY     = $0B
.const COLOR_GREY          = $0C
.const COLOR_LIGHT_GREEN   = $0D
.const COLOR_LIGHT_BLUE    = $0E
.const COLOR_LIGHT_GREY    = $0F

.const CHARACTER_SPACE     = $20
.const CHARACTER_PERIOD    = $2E
.const CHARACTER_HASH      = $23
.const CHARACTER_PERCENT   = $25

.const CHARACTER_GIANA_FONT_ROUND_1 = $5B
.const CHARACTER_GIANA_FONT_ROUND_2 = $5C
.const CHARACTER_GIANA_FONT_SQUARE_1 = $5D
.const CHARACTER_GIANA_FONT_SQUARE_2 = $5E

.const SYSTEM_IRQ_HANDLER = $ea81


// Assuming Text screen mode
// Assuming using VIC bank 0 (which is default upon C64 start/reset with memory address range $0000-$3FFF thus size $4000=16k bytes). 
// To use character font bank 7, (the last possible font bank) within the current VIC bank, set memory location $D018 bit 1 through 3 to value %111 = #7. 
// Font bitmap data start at address: <VIC bank start address> + (<font bank size> * <font bank>) = $0000 + ($800 * #7) = $3800

.const   constant_font_bank = $0e // %00001110
.const   address_font = $3800
.const   address_font_pointer = $D018
.const   address_font_character_lo_byte = $0A
.const   address_font_character_hi_byte = $0B

.const   address_animated_diamond_delay = $0D
.const   address_animated_diamond_frame = $0E

.const   address_sid_music_init = $1000
.const   address_sid_music_play = address_sid_music_init + 3

.const   constant_pixel_character_active = CHARACTER_GIANA_FONT_ROUND_1
.const   constant_pixel_character_inactive = CHARACTER_SPACE

.const   constant_columns_per_line = 40
.const   constant_top_scroll_line_index  = 23 - 8     // 8 lines of "pixels" for characters in text message with it's top on this line (zero index ed from top) [0-23]
.const   constant_static_text_line_index  = 0         // Static text message with it's top on this line (zero index ed from top) [0-23]

.const   constant_horizontal_scroll_delay = 0        // Scroll delay value constant [0-128]  (unit: rendered frames, 1/50th of a second)
.const   constant_text_color_scroll_delay = 0        // Scroll delay value constant [0-255] (unit: rendered frames, 1/50th of a second)

.const   constant_animated_diamond_delay = 3

.const   address_static_text_colors_offset = $0C

.const   address_border_color = $D020
.const   address_screen_color = $D021
.const   address_horizontal_scroll_register = $D016
.const   address_first_screen_char_color = $D800
.const   address_first_screen_char_character = $0400

.const   address_horizontal_scroll_value = $03                   // Current horizontal pixel scroll value. Stored at zero page

.const   address_horizontal_scroll_delay_counter = $04           // Scroll delay counter. Stored at zero page

.const   address_scroll_message_character_offset = $05           // Character offset in scroll message. Stored at zero page
.const   address_scroll_message_character_pixel_offset = $08     // Scroll message character pixel column offset. Stored at zero page
.const   address_scroll_message_character_font_data = $09        // Scroll message character pixel data start (first/upper line). Stored at zero page

.const   address_text_color_scroll_delay_counter = $06           // Text color scroll delay counter. Stored at zero page
.const   address_text_color_scroll_offset = $07                  // Offset in text color list. Stored at zero page
.const   address_text_color_scroll_line_0 = address_first_screen_char_color + constant_columns_per_line * constant_top_scroll_line_index 
.const   address_text_color_scroll_line_1 = address_text_color_scroll_line_0 + constant_columns_per_line 
.const   address_text_color_scroll_line_2 = address_text_color_scroll_line_1 + constant_columns_per_line 
.const   address_text_color_scroll_line_3 = address_text_color_scroll_line_2 + constant_columns_per_line 
.const   address_text_color_scroll_line_4 = address_text_color_scroll_line_3 + constant_columns_per_line 
.const   address_text_color_scroll_line_5 = address_text_color_scroll_line_4 + constant_columns_per_line 
.const   address_text_color_scroll_line_6 = address_text_color_scroll_line_5 + constant_columns_per_line 
.const   address_text_color_scroll_line_7 = address_text_color_scroll_line_6 + constant_columns_per_line 

.const   address_static_message_text_scr_pos = address_first_screen_char_character + constant_columns_per_line * constant_static_text_line_index 

.const   adress_scroll_line_0 = address_first_screen_char_character + constant_columns_per_line * (constant_top_scroll_line_index  + 0)
.const   adress_scroll_line_1 = address_first_screen_char_character + constant_columns_per_line * (constant_top_scroll_line_index  + 1)
.const   adress_scroll_line_2 = address_first_screen_char_character + constant_columns_per_line * (constant_top_scroll_line_index  + 2)
.const   adress_scroll_line_3 = address_first_screen_char_character + constant_columns_per_line * (constant_top_scroll_line_index  + 3)
.const   adress_scroll_line_4 = address_first_screen_char_character + constant_columns_per_line * (constant_top_scroll_line_index  + 4)
.const   adress_scroll_line_5 = address_first_screen_char_character + constant_columns_per_line * (constant_top_scroll_line_index  + 5)
.const   adress_scroll_line_6 = address_first_screen_char_character + constant_columns_per_line * (constant_top_scroll_line_index  + 6)
.const   adress_scroll_line_7 = address_first_screen_char_character + constant_columns_per_line * (constant_top_scroll_line_index  + 7)

.const   adress_scroll_line_0_last_pos = adress_scroll_line_0 + (constant_columns_per_line - 1)
.const   adress_scroll_line_1_last_pos = adress_scroll_line_1 + (constant_columns_per_line - 1)
.const   adress_scroll_line_2_last_pos = adress_scroll_line_2 + (constant_columns_per_line - 1)
.const   adress_scroll_line_3_last_pos = adress_scroll_line_3 + (constant_columns_per_line - 1)
.const   adress_scroll_line_4_last_pos = adress_scroll_line_4 + (constant_columns_per_line - 1)
.const   adress_scroll_line_5_last_pos = adress_scroll_line_5 + (constant_columns_per_line - 1)
.const   adress_scroll_line_6_last_pos = adress_scroll_line_6 + (constant_columns_per_line - 1)
.const   adress_scroll_line_7_last_pos = adress_scroll_line_7 + (constant_columns_per_line - 1)

*=$0801 "basic program"

        //.byte $01, $08                                          // "File header" (?)
        .byte $0C, $08
        .byte $0A, $00, $9E, $20, $32, $30, $36, $34, $00        // BASIC: 10 SYS 2064      // #2064 = $0810
        .byte $00, $00                                           // end of BASIC program

*=$0810 "main program"

Init:
        
        ldy #0 - 1
        sty address_scroll_message_character_offset // Reset scroll message to first character position
        sty address_text_color_scroll_offset        // Reset text color scroll offset to first color position
	
        ldy #8
        sty address_scroll_message_character_pixel_offset // Reset scroll message pixel offset
        
        ldy #7        
        sty address_horizontal_scroll_value         // Set initial horizontal screen pixel scroll value
        
        ldy #constant_horizontal_scroll_delay
        sty address_horizontal_scroll_delay_counter // Reset scroll delay counter to delay max value
        
        ldy #0
        sty address_static_text_colors_offset
        
        ldy #0 - 1
        sty address_animated_diamond_delay
        ldy #0 - 1
        sty address_animated_diamond_frame
        
        // Set character font pointer to point to demo font
        lda address_font_pointer
        ora #constant_font_bank     
        sta address_font_pointer    
        
        jsr address_sid_music_init
        
        // Set 38 column mode
        lda address_horizontal_scroll_register
        and #%11110111
        sta address_horizontal_scroll_register
        
        jsr clear_screen
        
        lda #COLOR_BLACK       
        sta address_border_color	      // Set screen border color 
        sta address_screen_color	      // Set screen color 

        jsr print_static_message

        sei 
        lda #%01111111
        sta $DC0D	      // "Switch off" interrupts signals from CIA-1

        //lda $D01A      // enable VIC-II Raster Beam IRQ
        //ora #$01
        //sta $D01A

        lda #%00000001
        sta $D01A	      // Enable raster interrupt signals from VIC

        lda $D011
        and #%01111111
        sta $D011	      // Clear most significant bit in VIC's raster register (for raster interrupt on upper part of screen, above line #256)
        
        lda #$00        // Interrupt on this raster line
        sta $D012       // Set the raster line number where interrupt should occur
        
        lda #<irq1
        sta $0314
        lda #>irq1
        sta $0315	      // Set the interrupt vector to point to interrupt service routine below
        
        cli 
        
        //rts              // Initialization done// return to BASIC
no_exit:
    
        jmp no_exit
        
irq1:
        // Turn off (reset) any horizontal scroll        
        lda address_horizontal_scroll_register   
        and #%11111000                          // h-scroll is the lower 3 bits, so mask them off to zero's
        clc                             
        adc #$07                                // add xscroll value (value always fits inside the lower 3 bits)
        sta address_horizontal_scroll_register    

        // Set next raster interrupt (raster interrupt irq2)
        lda #<irq2
        sta $0314
        lda #>irq2
        sta $0315
        
                
        lda #60 // Create raster interrupt at line 60
        sta $d012

        asl $D019	      // "Acknowledge" (asl do both read and write to memory location) the interrupt by clearing the VIC's interrupt flag.
        //jmp $EA31	      // Jump into KERNAL's standard interrupt service routine to handle keyboard scan, cursor display etc.
        jmp SYSTEM_IRQ_HANDLER

irq2:
        // DEBUG: set border color for now        
        //lda #COLOR_BLACK       
        //sta address_border_color	      // Set screen border color 
        //sta address_screen_color	      // Set screen color 

        //jsr rasterline_start
        
        jsr animate_diamond

        jsr scroll_text
        
        jsr text_color_scroll
        
        jsr address_sid_music_play

        jsr flicker_static_text_color

        //jsr rasterline_end

        // Set next raster interrupt (back to raster interrupt irq1)
        lda #<irq1
        sta $0314
        lda #>irq1
        sta $0315

        lda #49         // Interrupt on this raster line
        sta $D012       // Set the raster line number where interrupt should occur

        asl $D019	      // "Acknowledge" (asl do both read and write to memory location) the interrupt by clearing the VIC's interrupt flag.
        //jmp $EA31	      // Jump into KERNAL's standard interrupt service routine to handle keyboard scan, cursor display etc.
        jmp SYSTEM_IRQ_HANDLER
//----------------------------------------------
animate_diamond:
        ldy address_animated_diamond_delay
        cpy #constant_animated_diamond_delay
        beq !+
        iny         
        sty address_animated_diamond_delay
        rts 
!:      ldy #0
        sty address_animated_diamond_delay
        
        ldy address_animated_diamond_frame
        iny 
        cpy #6
        bne !+
        ldy #0
!:      sty address_animated_diamond_frame
        
        tya
        asl
        asl
        asl
        tay
        
        // Store animated diamond data at character #$25 (percent sign '%')
        .const constant_animated_character_index  = CHARACTER_PERCENT
        lda address_diamond_animation_data + 0, Y
        sta address_font + (constant_animated_character_index  * 8) + 0  
        lda address_diamond_animation_data + 1, Y
        sta address_font + (constant_animated_character_index  * 8) + 1  
        lda address_diamond_animation_data + 2, Y
        sta address_font + (constant_animated_character_index  * 8) + 2  
        lda address_diamond_animation_data + 3, Y
        sta address_font + (constant_animated_character_index  * 8) + 3  
        lda address_diamond_animation_data + 4, Y
        sta address_font + (constant_animated_character_index  * 8) + 4  
        lda address_diamond_animation_data + 5, Y
        sta address_font + (constant_animated_character_index  * 8) + 5  
        lda address_diamond_animation_data + 6, Y
        sta address_font + (constant_animated_character_index  * 8) + 6  
        lda address_diamond_animation_data + 7, Y
        sta address_font + (constant_animated_character_index  * 8) + 7  
        
        rts 

//----------------------------------------------
flicker_static_text_color:
        ldy address_static_text_colors_offset
        lda static_text_colors, Y
        cmp #$FF // end of color list marker
        bne !+
        
        // Reset color list
        ldy #$00
        lda static_text_colors, Y

!:      ldx #$00
flicker_static_text_color_loop:
        sta address_first_screen_char_color + constant_columns_per_line * constant_static_text_line_index , X 
        inx
        cpx #constant_columns_per_line
        bne flicker_static_text_color_loop
        
flicker_static_text_color_end:
        iny 
        sty address_static_text_colors_offset
        rts 

static_text_colors:
        .byte COLOR_BROWN, COLOR_DARK_GREY, COLOR_BROWN, COLOR_DARK_GREY
        .byte COLOR_RED
        .byte COLOR_ORANGE
        .byte COLOR_PINK
        .byte COLOR_LIGHT_GREY
        .byte COLOR_LIGHT_GREEN
        .byte COLOR_YELLOW
        .byte COLOR_WHITE, COLOR_WHITE, COLOR_WHITE, COLOR_WHITE, COLOR_WHITE, COLOR_WHITE, COLOR_WHITE, COLOR_WHITE 
        .byte COLOR_WHITE, COLOR_WHITE, COLOR_WHITE, COLOR_WHITE, COLOR_WHITE, COLOR_WHITE, COLOR_WHITE, COLOR_WHITE 
        .byte COLOR_WHITE, COLOR_WHITE, COLOR_WHITE, COLOR_WHITE, COLOR_WHITE, COLOR_WHITE, COLOR_WHITE, COLOR_WHITE 
        .byte COLOR_WHITE, COLOR_WHITE, COLOR_WHITE, COLOR_WHITE, COLOR_WHITE, COLOR_WHITE, COLOR_WHITE, COLOR_WHITE 
        .byte COLOR_WHITE, COLOR_WHITE, COLOR_WHITE, COLOR_WHITE, COLOR_WHITE, COLOR_WHITE, COLOR_WHITE, COLOR_WHITE 
        .byte COLOR_WHITE, COLOR_WHITE, COLOR_WHITE, COLOR_WHITE, COLOR_WHITE, COLOR_WHITE, COLOR_WHITE, COLOR_WHITE 
        .byte COLOR_YELLOW
        .byte COLOR_LIGHT_GREEN
        .byte COLOR_LIGHT_GREY
        .byte COLOR_PINK
        .byte COLOR_ORANGE
        .byte COLOR_RED
        .byte $FF

        .byte COLOR_DARK_GREY,   COLOR_BROWN          //   0   (0)
        .byte COLOR_DARK_GREY,   COLOR_BROWN          //   1   (0)
        .byte COLOR_DARK_GREY,   COLOR_BROWN          //   2   (0)
        .byte COLOR_DARK_GREY,   COLOR_BROWN          //   3   (0)
        .byte COLOR_DARK_GREY,   COLOR_DARK_GREY      //   4   (1)
        .byte COLOR_DARK_GREY,   COLOR_DARK_GREY      //   5   (1)
        .byte COLOR_DARK_GREY,   COLOR_RED            //   6   (2)
        .byte COLOR_DARK_GREY,   COLOR_RED            //   7   (2)
        .byte COLOR_DARK_GREY,   COLOR_PURPLE         //   8   (3)
        .byte COLOR_DARK_GREY,   COLOR_PURPLE         //   9   (3)
        .byte COLOR_PURPLE,      COLOR_PURPLE         //  10   (4)
        .byte COLOR_GREY,        COLOR_PURPLE         //  11   (5)
        .byte COLOR_GREY,        COLOR_GREY           //  12   (6)
        .byte COLOR_GREY,        COLOR_GREY           //  13   (6)
        .byte COLOR_GREY,        COLOR_LIGHT_GREY     //  14   (7)
        .byte COLOR_LIGHT_GREY,  COLOR_LIGHT_GREY     //  15   (8)
        .byte COLOR_LIGHT_GREY,  COLOR_YELLOW         //  16   (9)
        .byte COLOR_LIGHT_GREY,  COLOR_YELLOW         //  17   (9)
        .byte COLOR_YELLOW,      COLOR_YELLOW         //  18   (10)
        .byte COLOR_YELLOW,      COLOR_YELLOW         //  19   (10)
        .byte COLOR_YELLOW,      COLOR_WHITE          //  20   (11)
        .byte COLOR_YELLOW,      COLOR_WHITE          //  21   (11)
        .byte COLOR_WHITE,       COLOR_WHITE          //  22   (12)
        .byte COLOR_WHITE,       COLOR_WHITE          //  23   (12)
        .byte COLOR_WHITE,       COLOR_WHITE          //  24   (12)
        .byte COLOR_WHITE,       COLOR_WHITE          //  25   (12)
        .byte COLOR_WHITE,       COLOR_WHITE          //  26   (12)
        .byte COLOR_WHITE,       COLOR_WHITE          //  27   (12)
        .byte COLOR_WHITE,       COLOR_WHITE          //  28   (12)
        .byte COLOR_YELLOW,      COLOR_WHITE          //  29   (11)
        .byte COLOR_YELLOW,      COLOR_WHITE          //  30   (11)
        .byte COLOR_YELLOW,      COLOR_YELLOW         //  31   (10)
        .byte COLOR_YELLOW,      COLOR_YELLOW         //  32   (10)
        .byte COLOR_LIGHT_GREY,  COLOR_YELLOW         //  33   (9)
        .byte COLOR_LIGHT_GREY,  COLOR_YELLOW         //  34   (9)
        .byte COLOR_LIGHT_GREY,  COLOR_LIGHT_GREY     //  35   (8)
        .byte COLOR_GREY,        COLOR_LIGHT_GREY     //  36   (7)
        .byte COLOR_GREY,        COLOR_GREY           //  37   (6)
        .byte COLOR_GREY,        COLOR_GREY           //  38   (6)
        .byte COLOR_GREY,        COLOR_PURPLE         //  39   (5)
        .byte COLOR_PURPLE,      COLOR_PURPLE         //  40   (4)
        .byte COLOR_DARK_GREY,   COLOR_PURPLE         //  41   (3)
        .byte COLOR_DARK_GREY,   COLOR_PURPLE         //  42   (3)
        .byte COLOR_DARK_GREY,   COLOR_RED            //  43   (2)
        .byte COLOR_DARK_GREY,   COLOR_RED            //  44   (2)
        .byte COLOR_DARK_GREY,   COLOR_DARK_GREY      //  45   (1)
        .byte COLOR_DARK_GREY,   COLOR_DARK_GREY      //  46   (1)
        .byte COLOR_DARK_GREY,   COLOR_BROWN          //  47   (0)
        .byte COLOR_DARK_GREY,   COLOR_BROWN          //  48   (0)
        .byte COLOR_DARK_GREY,   COLOR_BROWN          //  49   (0)       
        .byte $FF
        

// ---------------------------------------------        
// Paint a raster band                            
// ---------------------------------------------        
rasterline_start:
        // rasterline start paint        
        lda #COLOR_YELLOW       
        //sta address_border_color	      // Set screen border color to yellow
        sta address_screen_color	      // Set screen color to yellow
        
        rts 
         
rasterline_end:
        // rasterline stop paint        
        lda #COLOR_BLACK
        sta address_border_color	      // Set screen border color to black
        sta address_screen_color	      // Set screen color to black
        
        rts 
        
        
// ---------------------------------------------        
// Clear screen subroutine                            
// ---------------------------------------------        
clear_screen:
        lda #CHARACTER_SPACE // "Space" character code
        //lda #CHARACTER_HASH // Debug character code
        ldx #0
clear_screen_loop:
        sta $0400,x
        sta $0500,x
        sta $0600,x
        sta $0700,x
        dex 
        bne clear_screen_loop
        
        rts 


// ---------------------------------------------        
// Print static text message                            
// ---------------------------------------------        
print_static_message:
        ldx #$00
        
print_static_message_loop:
        lda static_message_text, x
        cmp #$00  // Have we encountered text message null termination
        beq print_static_message_loop_end
        
        //ora #$80 // Invert character
        
        sta $0400 + constant_columns_per_line * constant_static_text_line_index , x // print static message text data to screen character location 
        
        lda #COLOR_RED
        sta $D800 + constant_columns_per_line * constant_static_text_line_index , x // print static message text data to screen character location 
 
        inx
        cpx #$00
        beq print_static_message_loop_end
        jmp print_static_message_loop
        
print_static_message_loop_end:
        rts 


// ---------------------------------------------        
// Scroll screen text content a pixel                            
// ---------------------------------------------        
scroll_text:

scrolldelaycheck:
        ldx address_horizontal_scroll_delay_counter   
        dex 
        bpl nopixelscroll

        ldx #constant_horizontal_scroll_delay
        stx address_horizontal_scroll_delay_counter
        jmp pixelscroll

nopixelscroll:
        stx address_horizontal_scroll_delay_counter
        jmp endscroll
               
pixelscroll:
        lda address_horizontal_scroll_register   
        and #%11111000                          // h-scroll is the lower 3 bits, so mask them off to zero's
        clc                             
        adc address_horizontal_scroll_value     // add xscroll value (value always fits inside the lower 3 bits)
        sta address_horizontal_scroll_register    
        
        ldy address_horizontal_scroll_value
        cpy #7
        bne no_charpos_scroll
        
message_character_scroll:
        jsr scroll_message_one_char // copy all screen character content one character position to the left  
        jsr add_next_rightmost_scroll_message_char_pixel // Add a new character at the very far right of the line (that will later scroll in to the left)
        
no_charpos_scroll:
        ldy address_horizontal_scroll_value
        dey // Scroll one pixels at a time for smoooth scroll!
        dey // Scroll two pixels at a time for speeeed!
        bmi pixelscrollreset
        sty address_horizontal_scroll_value
        jmp endscroll
        
pixelscrollreset:
        ldy #7 // Move horizontal scroll of screen 7 pixels to the right         
        sty address_horizontal_scroll_value
        jmp endscroll
        
endscroll:
        rts    


// ---------------------------------------------        
// Scroll text color of text message line 1 character position                           
// ---------------------------------------------        
text_color_scroll:
text_color_scroll_delaycheck:
        ldx address_text_color_scroll_delay_counter   
        dex 
        bpl no_text_color_scroll

        ldx #constant_text_color_scroll_delay
        stx address_text_color_scroll_delay_counter
        jmp text_color_scroll_start

no_text_color_scroll:
        stx address_text_color_scroll_delay_counter
        jmp end_text_color_scroll
               
text_color_scroll_start:
        
        ldy #$FF
text_color_scroll_loop:
        iny 
        lda address_text_color_scroll_line_0 + 1, Y
        sta address_text_color_scroll_line_0, Y
        lda address_text_color_scroll_line_1 + 1, Y
        sta address_text_color_scroll_line_1, Y
        lda address_text_color_scroll_line_2 + 1, Y
        sta address_text_color_scroll_line_2, Y
        lda address_text_color_scroll_line_3 + 1, Y
        sta address_text_color_scroll_line_3, Y
        lda address_text_color_scroll_line_4 + 1, Y
        sta address_text_color_scroll_line_4, Y
        lda address_text_color_scroll_line_5 + 1, Y
        sta address_text_color_scroll_line_5, Y
        lda address_text_color_scroll_line_6 + 1, Y
        sta address_text_color_scroll_line_6, Y
        lda address_text_color_scroll_line_7 + 1, Y
        sta address_text_color_scroll_line_7, Y
        cpy #constant_columns_per_line - 2
        bne text_color_scroll_loop

text_color_scroll_new_rightmost_color:
        ldx address_text_color_scroll_offset
        inx
        
        lda scroll_text_colors, X
        cmp #$FF
        bne skip_text_color_scroll_offset_reset
        
        ldx #$00
        
skip_text_color_scroll_offset_reset:
        lda scroll_text_colors, X
        sta address_text_color_scroll_line_0 + constant_columns_per_line - 1
        lda address_text_color_scroll_line_0 + constant_columns_per_line - 2
        sta address_text_color_scroll_line_1 + constant_columns_per_line - 1
        lda address_text_color_scroll_line_1 + constant_columns_per_line - 2
        sta address_text_color_scroll_line_2 + constant_columns_per_line - 1
        lda address_text_color_scroll_line_2 + constant_columns_per_line - 2
        sta address_text_color_scroll_line_3 + constant_columns_per_line - 1
        lda address_text_color_scroll_line_3 + constant_columns_per_line - 2
        sta address_text_color_scroll_line_4 + constant_columns_per_line - 1
        lda address_text_color_scroll_line_4 + constant_columns_per_line - 2
        sta address_text_color_scroll_line_5 + constant_columns_per_line - 1
        lda address_text_color_scroll_line_5 + constant_columns_per_line - 2
        sta address_text_color_scroll_line_6 + constant_columns_per_line - 1
        lda address_text_color_scroll_line_6 + constant_columns_per_line - 2
        sta address_text_color_scroll_line_7 + constant_columns_per_line - 1

        stx address_text_color_scroll_offset
        
end_text_color_scroll:
        rts 
        
address_diamond_animation_data:
    .import binary "diamonds.bin"      // 6 character data that make out an animated gianna sisters diamond
        
address_current_font_character_pixel_data:
        .byte %00000000 
        .byte %00000000 
        .byte %00000000 
        .byte %00000000 
        .byte %00000000 
        .byte %00000000 
        .byte %00000000 
        .byte %00000000 
        
address_rightmost_char_pos_on_screen:
        .const address_scroll_line_top = $0400 + constant_columns_per_line * constant_top_scroll_line_index 

// ---------------------------------------------        
// Scroll message line 1 character pixel position                           
// ---------------------------------------------        
add_next_rightmost_scroll_message_char_pixel:
        dec address_scroll_message_character_pixel_offset
        lda address_scroll_message_character_pixel_offset
        bne skip_copy_new_char
        
        lda #8 // Reset character pixel column counter
        sta address_scroll_message_character_pixel_offset//

        inc address_scroll_message_character_offset // Advance to next character in scroll message text
        ldy address_scroll_message_character_offset // Load character scroll text offset into Y

        lda scroll_text_message, Y // Load character value into A
        bne skip_scroll_message_offset_reset
        
        ldy #$00
        sty address_scroll_message_character_offset
        lda scroll_text_message, Y // Load character value into A
        
skip_scroll_message_offset_reset:
        
        //ldx #COLOR_WHITE
        //stx $D800
        //sta $0400 // DEBUG: Print character in white at top left corner for debug purpose         
        
setup_font_character_indirect_address:
        // Initialize the indirect address of the font character by setting the character value in the adress low byte
        sta address_font_character_lo_byte
        lda #$00
        sta address_font_character_hi_byte
        
        // Multiply character index  with 8 (There are 8 bytes per character. Shift left for 3 bits over two bytes.)
        // Font character offset start byte will be at indirect address (hi and lo byte) 
        asl address_font_character_lo_byte
        rol address_font_character_hi_byte
        asl address_font_character_lo_byte
        rol address_font_character_hi_byte
        asl address_font_character_lo_byte
        rol address_font_character_hi_byte
        clc

        // Add font address $3800 to calculated (indirect address) font character offset 
        // Special case since we use font address $3800 (%00111000 00000000) with bits only set in high byte 
        // (and higher than the 3 least significant bits) we can "add" $3800 to font character offset by just OR in the bits into the high byte
        lda address_font_character_hi_byte
        ora #>address_font   
        sta address_font_character_hi_byte
        
        // The indirect address at $address_font_character_lo_byte do now point to the first pixel data byte of sought the character in the font 
        
        ldy #0
copy_font_char_pixel_data:
        lda (address_font_character_lo_byte), Y            // indirect address hold the first byte (upper line) of character's pixel data
        sta address_current_font_character_pixel_data, Y
        iny 
        cpy #8 
        bne copy_font_char_pixel_data
        
skip_copy_new_char:
        
        // Rotate/Shift in leftmost/highest bit of font character pixel data to rightmost/lowest bit
        // For each of the 8 bytes that make out one charcter in the font
        ldx #0
shift_character_pixel_bytes:
        clc
        asl address_current_font_character_pixel_data, X
        bcc !+
        lda #%00000001
        ora address_current_font_character_pixel_data, X
        sta address_current_font_character_pixel_data, X
!:      inx
        cpx #8 // All 8 pixel bytes of the font character rotated/shifted?
        bne shift_character_pixel_bytes

put_font_character_pixel_column_to_screen:

        lda address_current_font_character_pixel_data + 0          
        jsr get_pixel_character
        sta adress_scroll_line_0_last_pos

        lda address_current_font_character_pixel_data + 1          
        jsr get_pixel_character
        sta adress_scroll_line_1_last_pos

        lda address_current_font_character_pixel_data + 2         
        jsr get_pixel_character
        sta adress_scroll_line_2_last_pos

        lda address_current_font_character_pixel_data + 3         
        jsr get_pixel_character
        sta adress_scroll_line_3_last_pos

        lda address_current_font_character_pixel_data + 4        
        jsr get_pixel_character
        sta adress_scroll_line_4_last_pos

        lda address_current_font_character_pixel_data + 5         
        jsr get_pixel_character
        sta adress_scroll_line_5_last_pos

        lda address_current_font_character_pixel_data + 6         
        jsr get_pixel_character
        sta adress_scroll_line_6_last_pos

        lda address_current_font_character_pixel_data + 7         
        jsr get_pixel_character
        sta adress_scroll_line_7_last_pos

        rts 


// ------------------------
get_pixel_character:
        and #%00000001
        bne pixel_character_active
pixel_character_inactive:
        lda #constant_pixel_character_inactive
        rts 
pixel_character_active:
        lda #constant_pixel_character_active         
        rts 


// ---------------------------------------------        
// Scroll message text line 1 character position to the left                           
// ---------------------------------------------        
scroll_message_one_char:
        ldx #$FF
scroll_line_char_loop:
        inx
        lda adress_scroll_line_0 + 1, x
        sta adress_scroll_line_0, x
        lda adress_scroll_line_1 + 1, x
        sta adress_scroll_line_1, x
        lda adress_scroll_line_2 + 1, x
        sta adress_scroll_line_2, x
        lda adress_scroll_line_3 + 1, x
        sta adress_scroll_line_3, x
        lda adress_scroll_line_4 + 1, x
        sta adress_scroll_line_4, x
        lda adress_scroll_line_5 + 1, x
        sta adress_scroll_line_5, x
        lda adress_scroll_line_6 + 1, x
        sta adress_scroll_line_6, x
        lda adress_scroll_line_7 + 1, x
        sta adress_scroll_line_7, x
        cpx #constant_columns_per_line - 2
        bne scroll_line_char_loop
  
        rts 
        
        
scroll_text_colors:
        .byte COLOR_DARK_GREY, COLOR_DARK_GREY, COLOR_DARK_GREY, COLOR_DARK_GREY, COLOR_DARK_GREY, COLOR_DARK_GREY, COLOR_DARK_GREY
        .byte COLOR_BROWN
        .byte COLOR_RED
        .byte COLOR_ORANGE
        .byte COLOR_PINK
        .byte COLOR_ORANGE
        .byte COLOR_RED
        .byte COLOR_BROWN
        .byte COLOR_DARK_GREY, COLOR_DARK_GREY, COLOR_DARK_GREY
        .byte COLOR_BROWN
        .byte COLOR_RED
        .byte COLOR_ORANGE
        .byte COLOR_RED
        .byte COLOR_BROWN
        .byte COLOR_DARK_GREY, COLOR_DARK_GREY, COLOR_DARK_GREY, COLOR_DARK_GREY, COLOR_DARK_GREY
        .byte COLOR_BROWN
        .byte COLOR_RED
        .byte COLOR_ORANGE
        .byte COLOR_PINK
        .byte COLOR_YELLOW
        .byte COLOR_WHITE 
        .byte COLOR_YELLOW
        .byte COLOR_PINK
        .byte COLOR_ORANGE
        .byte COLOR_RED
        .byte COLOR_BROWN, COLOR_DARK_GREY
        .byte COLOR_DARK_GREY, COLOR_DARK_GREY, COLOR_DARK_GREY, COLOR_DARK_GREY
        .byte COLOR_BROWN, COLOR_DARK_GREY
        .byte COLOR_RED
        .byte COLOR_ORANGE
        .byte COLOR_PINK
        .byte COLOR_LIGHT_GREY
        .byte COLOR_LIGHT_GREEN
        .byte COLOR_YELLOW
        .byte COLOR_WHITE 
        .byte COLOR_YELLOW
        .byte COLOR_LIGHT_GREEN
        .byte COLOR_LIGHT_GREY
        .byte COLOR_PINK
        .byte COLOR_ORANGE
        .byte COLOR_RED
        .byte COLOR_BROWN, COLOR_DARK_GREY
        .byte $FF // Color list termination value
    
        .byte COLOR_DARK_GREY,  COLOR_DARK_GREY 
        .byte COLOR_DARK_GREY,  COLOR_DARK_GREY 
        .byte COLOR_GREY,       COLOR_GREY
        .byte COLOR_DARK_GREY,  COLOR_DARK_GREY 
        .byte COLOR_DARK_GREY,  COLOR_DARK_GREY 
        .byte COLOR_GREY,       COLOR_GREY
        .byte COLOR_DARK_GREY,  COLOR_DARK_GREY 
        .byte COLOR_DARK_GREY,  COLOR_DARK_GREY 
        .byte COLOR_DARK_GREY,  COLOR_DARK_GREY 
        .byte COLOR_DARK_GREY,  COLOR_DARK_GREY 
        .byte COLOR_DARK_GREY,  COLOR_DARK_GREY 
        .byte COLOR_DARK_GREY,  COLOR_DARK_GREY 
        .byte COLOR_GREY,       COLOR_GREY
        .byte COLOR_LIGHT_GREY, COLOR_LIGHT_GREY 
        .byte COLOR_WHITE,      COLOR_WHITE         
        //.byte COLOR_YELLOW,     COLOR_YELLOW         
        .byte COLOR_WHITE,      COLOR_WHITE         
        .byte COLOR_LIGHT_GREY, COLOR_LIGHT_GREY 
        .byte COLOR_GREY,       COLOR_GREY         
        .byte $FF // Color list termination value


// ---------------------------------------------        
// Static message text (null terminated)                            
// ---------------------------------------------
static_message_text:
    .encoding "screencode_mixed"
//  .text "1234567890123456789012345678901234567890"
    .text @"     %  Till Grabbarna p\$60 gatan  %      "
    .byte $00 // Static message text is null terminated
    
    
// ---------------------------------------------        
// Scroll message text (null terminated)                            
// ---------------------------------------------        
scroll_text_message:
    .encoding "screencode_mixed"
//  .text "1234567890123456789012345678901234567890"
//  .text "1234567890123456789012345678901234567890123456789012345678901234"
    .text @"     Hej p\$60 er! \$64ntligen har jag f\$60tt tummen ur att koda maskinkod / assembler."
    .text @" Endast 30 \$60r senare... De varmaste h\$61lsningarna till b\$61sta v\$61nnerna p\$60"
    .text @" Viskarhultsv\$61gen i 54:an och 59:an fr\$60n 51:an."
    .text @" Det \$61r er jag tackar f\$62r s\$60 mycket fr\$60n min barndom.   "
    .byte $00 // Scroll message text is null terminated

    
// ---------------------------------------------        
// SID Music                            
// ---------------------------------------------        
* = address_sid_music_init "music"
        // Player size$0DE0 (3552 bytes)
        // Load address$1000 (4096)
        // Init address$1000 (4096)
        // Play address$1003 (4099)
        // Default subtune1 / 1
    .import binary "sid/Great_Giana_Sisters.sid",$7C + 2


// ---------------------------------------------        
// Text font                            
// ---------------------------------------------        
// More fonts at http://kofler.dot.at/c64/
// Load font to last 2k block of bank 3    
* = address_font "font"
    .import binary "fonts/Giana sisters demo font 03-charset.bin"
//    !bin "fonts/giana_sisters.font.64c",,2
//    !bin "fonts/devils_collection_25_y.64c",,2
//    !bin "fonts/double_char_font.bin"

