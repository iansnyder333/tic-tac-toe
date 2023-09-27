;   =============================================================================================
;   ||  ~                 Computer Organisation & Assembly Language (EE2003)                ~  ||
;   ||  ~                                     Fall 2022                                     ~  ||
;   ||  ~                                   Final Project                                   ~  ||
;   ||  ~    National University of Computer & Emerging Sciences (FAST-NUCES), Islamabad    ~  ||
;   =============================================================================================

;   ====================================
;   ||  ~    BRICK BREAKER GAME    ~  ||
;   ====================================

;   ==============================================
;   ||          ~    DEVELOPED BY    ~          ||
;   ==============================================
;   ||    • MUHAMMAD HUZAIFA KHAN (21i-2689)    ||
;   ||    • MARYAM NOOR (21i-2656)              ||
;   ||    • AREEBA RIAZ (21i-1736)              ||
;   ==============================================

EXTERNDELAY=3   ;   Adding an external delay of three seconds to the programme.

.MODEL SMALL
.STACK 100H
.386

;   Declaring all the necessary variables in the data segment.

.data

    WelcomeMessage  DB 0AH, 0DH, "                  ================================"
                    DB 0AH, 0DH, "                  ================================"
                    DB 0AH, 0DH, "                  ======== - WELCOME TO - ========"
                    DB 0AH, 0DH, "                  ================================"
                    DB 0AH, 0DH, "                  ================================"
                    DB 0AH, 0DH, "                  ======= ~ BRICK BREAKER ~ ======"
                    DB 0AH, 0DH, "                  ================================"
                    DB 0AH, 0DH, "                  ================================$"
        
    String2 DB 0AH, 0DH, "=================================================================="
            DB 0AH, 0DH, "=================================================================="
            DB 0AH, 0DH, "======== DEVELOPED BY: ==========================================="
            DB 0AH, 0DH, "=================================================================="
            DB 0AH, 0DH, "=================================================================="
            DB 0AH, 0DH, "======================== MUHAMMAD HUZAIFA KHAN ==================="  
            DB 0AH, 0DH, "============================= MARYAM NOOR ========================"
            DB 0AH, 0DH, "============================= AREEBA RIAZ ========================"
            DB 0AH, 0DH, "=================================================================="
            DB 0AH, 0DH, "==================================================================$"
       
        
    String3 DB 0AH, 0DH, "==================================================================="
            DB 0AH, 0DH, "==================================================================="
            DB 0AH, 0DH, "=== BRICK BREAKER IS A SINGLE-PLAYER GAME IN WHICH YOU HAVE TO ===="
            DB 0AH, 0DH, "=== BREAK ALL THE BRICKS ON THE SCREEN USING AN AUTOMATED BALL ===="
            DB 0AH, 0DH, "====== THAT YOU CONTROL USING A MOVABLE PLATFORM (STRIKER). ======="
            DB 0AH, 0DH, "==== THERE ARE A TOTAL OF THREE LEVELS; YOUR GOAL IS TO SCORE ====="
            DB 0AH, 0DH, "=== ENOUGH TO PROGRESS THROUGH ALL THE LEVELS AND WIN THE GAME ===="
            DB 0AH, 0DH, "======= YOU HAVE A TOTAL OF 3 LIVES, SO USE THEM WISELY! ;) ======="
            DB 0AH, 0DH, "==================================================================="
            DB 0AH, 0DH, "========================== GOOD LUCK! :) =========================="
            DB 0AH, 0DH, "==================================================================="
            DB 0AH, 0DH, "===================================================================$"
       
    String5 DB 0AH, 0DH, "==================================================================="
            DB 0AH, 0DH, "=======================    CONTROLS   ============================="
            DB 0AH, 0DH, "==================================================================="
            DB 0AH, 0DH, 0AH, 0DH
            DB 0AH, 0DH, "==================================================================="
            DB 0AH, 0DH, "=== USE THE LEFT AND RIGHT ARROW KEYS TO MOVE THE STRIKER FROM ===="
            DB 0AH, 0DH, "==================================================================="
            DB 0AH, 0DH, "======= THE CURRENT POSITION TO LEFT OR RIGHT RESPECTIVELY. ======="
            DB 0AH, 0DH, "===================================================================$"   
       
                                                                      
    String6 DB 0AH, 0DH, "                  =============================="
            DB 0AH, 0DH, "                  =============================="
            DB 0AH, 0DH, "                  ====      THANK YOU       ===="
            DB 0AH, 0DH, "                  ====         FOR          ===="
            DB 0AH, 0DH, "                  ==== PLAYING THE GAME! <3 ===="
            DB 0AH, 0DH, "                  =============================="
            DB 0AH, 0DH, "                  ==============================$"
             
    Item0   DB 0AH, 0DH, "                  ==============================="
            DB 0AH, 0DH, "                  ===============================", 0AH, 0DH, '$'
    Item1 DB 'NEW GAME      ======', 0AH, 0DH, '$'
    Item2 DB 'CREDITS       ======', 0AH, 0DH, '$'
    Item3 DB 'ABOUT         ======', 0AH, 0DH, '$'
    Item4 DB 'HIGHSCORES    ======', 0AH, 0DH, '$'
    Item5 DB 'INSTRUCTIONS  ======', 0AH, 0DH, '$'
    Item6 DB 'QUIT GAME     ======', 0AH, 0DH, '$'        
    Item7   DB "                  ==============================="
            DB 0AH, 0DH, "                  ===============================$"
   
    Selected DW 0
    Menu_Count DW 6
    Menu_Up EQU 48H
    Menu_Down EQU 50h

    Items_Array DW Item1, Item2, Item3, Item4, Item5, Item6, Item7
   
    Selector DB '                  ====== ->  $'
    Empty_Selector DB '                  ======     $'

    WinMessage  DB 0AH, 0DH, "     ==============================      "
                DB 0AH, 0DH, "     ==============================      "
                DB 0AH, 0DH, "     ====     YOU WON! :)     =====      "
                DB 0AH, 0DH, "     ==============================      "
                DB 0AH, 0DH, "     ==============================      $"

    LossMessage DB 0AH, 0DH, "     ==============================      "
                DB 0AH, 0DH, "     ==============================      "
                DB 0AH, 0DH, "     ====     YOU LOST! :(     ====      "
                DB 0AH, 0DH, "     ==============================      "
                DB 0AH, 0DH, "     ==============================      $"
    
    Score DB 'Score: $'
    FileName DB "highscores.txt", 0
    Buffer DW ?
    PlayerHighscore DB "Highscore: 34 $"
    UsernamePrompt DB 'WHAT SHOULD WE CALL YOU?$'
    Username DB 64, ?, 64 DUP(?)
    PlayerName DB 'Huzaifa$'
    GameName DB 'Brick Breaker$'
    ScoreCount DW 0
    Lives DB '              Lives: '
    LivesCount DB 51
    Ending DB ' $'
    BallY DW 163
    BallX DW 158
    BallLeft DB 1
    BallUp DB 1
    Colour DB ?
    StartX DW ?
    StartY DW ?
    EndX DW ?
    EndY DW ?
    Begin DB 0
    StrikerX DW 140
    StrikerY DW 170
    InnerDelay DB 0
    BoundaryEnd DW 250
    BoundaryStart DW 30
    Brick1X DW 45
    Brick1Y DW 25
    Brick2X DW 85
    Brick2Y DW 25
    Brick3X DW 125
    Brick3Y DW 25
    Brick4X DW 165
    Brick4Y DW 25
    Brick5X DW 205
    Brick5Y DW 25
    Brick6X DW 245
    Brick6Y DW 25
    Brick7X DW 45
    Brick7Y DW 45
    Brick8X DW 85
    Brick8Y DW 45
    Brick9X DW 125
    Brick9Y DW 45
    Brick10X DW 165
    Brick10Y DW 45
    Brick11X DW 205
    Brick11Y DW 45
    Brick12X DW 245
    Brick12Y DW 45

.code

    ;   Macro to clear the screen of all obstacles/objects.

    Clear_Screen PROC

        PUSH AX
        PUSH DS
        PUSH BX
        PUSH CX
        PUSH DI

        MOV AX, 40H
        MOV DS, AX
        MOV AH, 06H
        MOV AL, 0
        MOV BH, 07
        MOV CH, 0
        MOV CL, 0
        MOV DI, 84H
        MOV DH, [DI]
        MOV DI, 4AH
        MOV DL, [DI]
        DEC DL
        INT 10H

        MOV BH, 0
        MOV DL, 0
        MOV DH, 0
        MOV AH, 02
        INT 10H

        POP DI
        POP CX
        POP BX
        POP DS
        POP AX

        RET

    Clear_Screen ENDP

    ;   Macro to write the highscore into a file.

    Write_Highscore MACRO

        ;   Creating a new file.

        MOV AH, 3CH
        MOV CX, 0
        MOV DX, OFFSET FileName
        INT 21H

        MOV Buffer, AX

        ;   Writing the text into the created file.

        MOV AH, 40H
        MOV BX, Buffer
        MOV DX, OFFSET PlayerHighscore
        MOV CX, LENGTHOF PlayerHighscore
        INT 21H

        ;   Closing the file.

        MOV AH, 3EH
        MOV BX, Buffer
        INT 21H

    ENDM

    ;   Macro to read the highscore from an existing file.

    Read_Highscore MACRO
        
        ;   Opening the existing file.
        
        MOV AH, 3DH
        MOV AL, 02H
        MOV DX, OFFSET FileName
        INT 21H

        MOV Buffer, AX

        ;   Retrieving the text from the file, and displaying it on the screen.

        MOV AH, 3FH
        MOV DX, OFFSET PlayerHighscore
        MOV CX, LENGTHOF PlayerHighscore
        MOV BX, Buffer
        INT 21H
        
        MOV AH, 09H
        INT 21H

        ;   Closing the file.

        MOV AH, 3EH
        MOV BX, Buffer
        INT 21H

    ENDM

    ;   Macro to redraw the striker with a different colour.

    Redraw_Striker MACRO VisibleColour

        MOV Colour, VisibleColour
        CALL Draw_Striker

    ENDM

    ;   Macro to redraw the ball with a different colour.

    Redraw_Ball MACRO VisibleColour

        MOV Colour, VisibleColour
        CALL Draw_Ball

    ENDM

    ;   Macro to draw the bricks at certain coordinates with a certain colour.

    Build_Brick MACRO X, Y, VisibleColour

        PUSH AX
        PUSH BX
        PUSH DX
        MOV AX, X
        MOV BX, Y
        MOV DX, VisibleColour
        CALL Add_Brick
        POP BX
        POP AX

    ENDM

    ;   Macro to destroy (blacken) the bricks at certain coordinates.

    Destroy_Brick MACRO X, Y

        PUSH AX
        PUSH BX
        MOV AX, X
        MOV BX, Y
        CALL Remove_Brick
        CALL Beep_Sound ;   Beeping a sound each time a brick is destroyed.
        INC ScoreCount
        CALL Draw_Lives_Scores
        POP BX
        POP AX

    ENDM

    ;   Macro to determine the collision of the ball with the bricks at certain coordinates.

    Brick_Collision MACRO X, Y
        LOCAL Static_Label  ;   Declaring a local label.

        PUSH AX
        PUSH BX
        PUSH CX
        PUSH DX

        MOV AX, BallY
        MOV BX, BallX
        MOV CX, X
        MOV DX, Y
        
        CMP DX, BallY   ;   Checking if the ball is above the brick or not.
        JL Static_Label
        SUB DX, 7
        
        CMP BallY, DX   ;   Checking if the ball is below the brick or not.
        JL Static_Label

        MOV DX, X
        CMP BallX, DX   ;   Checking if the ball is to the left of the brick or not.
        JL Static_Label
        ADD DX, 30

        CMP DX, BallX   ;   Checking if the ball is to the right of the brick or not.
        JL Static_Label
        
        CALL Switcher
        Destroy_Brick X, Y  ;   If the ball is in contact with the brick, the brick is destroyed.
        MOV Y, 300  ;   Setting the vertical coordinate of the brick to a value outside the bounds to prevent it from being drawn again.

        CMP ScoreCount, 12  ;   Checking if the player has scored enough to move to the second level or not.
        JNE Static_Label
        Write_Highscore
        CALL Clear_Screen
        CALL Level2

        ;   Terminating the programme.

        MOV AH, 4CH
        INT 21H

        ;   Label to jump to if the ball has not come in contact with the brick (yet).
        
        Static_Label:

            POP DX
            POP CX
            POP BX
            POP AX                      
        
    ENDM

    ;   Driver code.

    Main PROC

        ;   Moving all the necessary variables to the data segment.

        MOV AX, @DATA
        MOV DS, AX

        CALL Welcome_Screen
        CALL Main_Menu

        CALL Level1
    
    Main ENDP

        ;   Procedure to display the welcome screen.

        Welcome_Screen PROC

            PUSH AX
            PUSH BX
            PUSH CX
            PUSH DX
                                    
            CALL Clear_Screen
            MOV AH, 9
            LEA DX, WelcomeMessage
            INT 21H
            
            MOV AH, 1
            INT 21H
            
            POP DX
            POP CX
            POP BX
            POP AX

            RET

        Welcome_Screen ENDP

        ;   Procedure to display the main menu and execute the programme according to the player's choice.

        Main_Menu PROC

            PUSH AX
            PUSH BX
            PUSH CX
            PUSH DX

            ;   Label to execute the procedure.

            Start_Label:

                ;   Label to print the main menu.

                Print_Main_Menu:
            
                    CALL Clear_Screen

                    MOV AH, 9
                    LEA DX, Item0
                    INT 21H
                
                    MOV BX, 0
                    MOV CX, Menu_Count

                    ;   Label to display the main menu choices to the player through a loop.

                    Print_Items:

                        MOV AX, BX
                        SHR AX, 1   ;   Dividing the value stored in the register by '2'.
                        CMP AX, Selected    ;   Checking if the current choice is the one selected by the player.
                        JNE Not_Selected
                    
                        LEA DX, Selector
                        MOV AH, 9
                        INT 21H
                        
                        JMP Continue

                        ;   Label to jump to if the player has not selected the current choice.

                        Not_Selected:

                            LEA DX, Empty_Selector
                            MOV AH, 9
                            INT 21H

                        ;   Label to jump to if the player has selected the current choice.

                        Continue:

                            MOV DX, Items_Array[BX]
                            MOV AH, 9
                            INT 21H
                        
                            ADD BX, 2

                    LOOP Print_Items

                    MOV AH, 9
                    LEA DX, Item7
                    INT 21H

            ;   Label to check for key presses from the player.

            Check_For_Key:
           
                MOV AH, 01H ;   Checking for a key press.
                INT 16H
                JZ No_Key
            
                MOV AH, 00H
                INT 16H
            
                CMP AL, 27D ;   Checking if the player has pressed the Escape key.
                JE Not_Enter_Key
            
                CMP AH, Menu_Up ;   Checking if the player has pressed the up-arrow key.
                JNE Not_Menu_Up
                SUB Selected, 1

                ;   Label to check if the player has pressed the down-arrow key.

                Not_Menu_Up:
            
                    CMP AH, Menu_Down   ;   Checking if the player has pressed the down-arrow key.
                    JNE Not_Menu_Down
                    ADD Selected, 1

                ;   Label to check if the player has pressed the up-arrow key.

                Not_Menu_Down:
        
                    CMP AH, 1CH  ;   Checking if the player has pressed the Enter key.
                    JNE Not_Enter_Key
            
                CMP Selected, 0 ;   Checking if the player has selected the first option.
                JNE Not_Item0
                CALL Clear_Screen

                LEA DX, UsernamePrompt
                MOV AH, 9
                INT 21H

                CALL Print_New_Line
                
                MOV AH, 0AH ;   Taking input of the username.
                LEA DX, Username
                INT 21H

                CALL Level1

            ;   Labels defined below to jump to if the player has selected a certain option, and continue the programme accordingly.

            Not_Item0:

                CMP Selected, 1 ;   Checking if the player has selected the second option.
                JNE Not_Item1
                CALL Clear_Screen

                LEA DX, String2
                MOV AH, 9
                INT 21H

                MOV AH, 1   ;   Waiting for the player to press a key.
                INT 21H

                JMP Start_Label

            Not_Item1:

                CMP Selected, 2 ;   Checking if the player has selected the third option.
                JNE Not_Item2
                CALL Clear_Screen

                LEA DX, String3
                MOV AH, 9
                INT 21H

                MOV AH, 1   ;   Waiting for the player to press a key.
                INT 21H

                JMP Start_Label

            Not_Item2:

                CMP Selected, 3 ;   Checking if the player has selected the fourth option.
                JNE Not_Item3
                CALL Clear_Screen
                
                MOV DX, OFFSET PlayerHighscore
                MOV AH, 09H
                INT 21H

                MOV AH, 1   ;   Waiting for the player to press a key.
                INT 21H

                JMP Start_Label

            Not_Item3:

                CMP Selected, 4 ;   Checking if the player has selected the fifth option.
                JNE Not_Item4
                CALL Clear_Screen

                LEA DX, String5
                MOV AH, 9
                INT 21H

                MOV AH, 1   ;   Waiting for the player to press a key.
                INT 21H

                JMP Start_Label

            Not_Item4:

                CMP Selected, 5 ;   Checking if the player has selected the sixth option.
                JNE Not_Item5
                CALL Clear_Screen

                LEA DX, String6
                MOV AH, 9
                INT 21H

                MOV AH, 1   ;   Waiting for the player to press a key.
                INT 21H

                CALL End_Game

            Not_Item5:

                MOV AH, 00   ;   Waiting for the player to press a key.
                INT 16H

            ;   Label to jump to if the player has not pressed any key.

            Not_Enter_Key:

                CMP Selected, -1 ;   Checking if the player has selected an option outside the specified bounds.
                JNLE Label_One
                MOV Selected, 0

                ;   Label to jump to if the player has selected an option outside the specified bounds.

                Label_One:

                    MOV AX, Menu_Count
                    CMP Selected, AX    ;   Checking if the player has selected an option outside the specified bounds.
                    JNGE Label_Two
                    DEC AX
                    MOV Selected, AX

                ;   Label to recursively jump back to label that prints the main menu.

                Label_Two:

                    JMP Print_Main_Menu

                ;   Label to jump to if the player has not pressed a key, to recursively check for a key press again.
            
                No_Key:

                    JMP Check_For_Key
            
            POP DX
            POP CX
            POP BX
            POP AX 
            
            RET

        MAIN_MENU ENDP

        ;   Procedure to draw the first level of the game.

        Level1 PROC

            CALL Set_Video_Mode
            CALL Draw_Boundary
            Build_Brick Brick1X Brick1Y 1
            Build_Brick Brick2X Brick2Y 2
            Build_Brick Brick3X Brick3Y 4
            Build_Brick Brick4X Brick4Y 6
            Build_Brick Brick5X Brick5Y 1
            Build_Brick Brick6X Brick6Y 2
            Build_Brick Brick7X Brick7Y 4
            Build_Brick Brick8X Brick8Y 6
            Build_Brick Brick9X Brick9Y 1
            Build_Brick Brick10X Brick10Y 2
            Build_Brick Brick11X Brick11Y 4
            Build_Brick Brick12X Brick12Y 6
            Redraw_Striker 7
            Redraw_Ball 44
            CALL Draw_Lives_Scores
            CALL Draw_Username
            CALL Draw_Game_Name
            
            CALL Game_Loop

            ;   Terminating the programme.     
            
            MOV AH, 4CH
            INT 21H
    
        Level1 ENDP

        ;   Procedure to draw the second level of the game.

        Level2 PROC

            CALL Clear_Screen

            CALL Set_Video_Mode
            CALL Draw_Boundary

            ;   Changing the coordinates of the bricks for the second level.

            MOV Brick1X, 50
            MOV Brick1Y, 25
            MOV Brick2X, 250
            MOV Brick2Y, 25
            MOV Brick3X, 150
            MOV Brick3Y, 25
            MOV Brick4X, 100
            MOV Brick4Y, 125
            MOV Brick5X, 25
            MOV Brick5Y, 150
            MOV Brick6X, 125
            MOV Brick6Y, 85
            MOV Brick7X, 225
            MOV Brick7Y, 65
            MOV Brick8X, 75
            MOV Brick8Y, 65
            MOV Brick9X, 250
            MOV Brick9Y, 125
            MOV Brick10X, 200
            MOV Brick10Y, 105
            MOV Brick11X, 500
            MOV Brick11Y, 500
            MOV Brick12X, 500
            MOV Brick12Y, 500

            Build_Brick Brick1X Brick1Y 1
            Build_Brick Brick2X Brick2Y 2
            Build_Brick Brick3X Brick3Y 4
            Build_Brick Brick4X Brick4Y 5
            Build_Brick Brick5X Brick5Y 6
            Build_Brick Brick6X Brick6Y 1
            Build_Brick Brick7X Brick7Y 2
            Build_Brick Brick8X Brick8Y 4
            Build_Brick Brick9X Brick9Y 5
            Build_Brick Brick10X Brick10Y 6
            Build_Brick Brick11X Brick11Y 0
            Build_Brick Brick12X Brick12Y 0
            Redraw_Striker 7
            Redraw_Ball 44
            CALL Draw_Lives_Scores
            CALL Draw_Username
            CALL Draw_Game_Name

            CALL Game_Loop

            ;   Terminating the programme.
            
            MOV AH, 4CH
            INT 21H
   
        Level2 ENDP

        Level3 PROC

            CALL Clear_Screen

            CALL Set_Video_Mode
            CALL Draw_Boundary

            ;   Changing the coordinates of the bricks for the third level.

            MOV Brick1X, 40
            MOV Brick1Y, 45
            MOV Brick2X, 145
            MOV Brick2Y, 95
            MOV Brick3X, 250
            MOV Brick3Y, 45
            MOV Brick4X, 40
            MOV Brick4Y, 150
            MOV Brick5X, 145
            MOV Brick5Y, 150
            MOV Brick6X, 250
            MOV Brick6Y, 150
            MOV Brick7X, 40
            MOV Brick7Y, 95
            MOV Brick8X, 250
            MOV Brick8Y, 95
            MOV Brick9X, 145
            MOV Brick9Y, 45
            MOV Brick10X, 145
            MOV Brick10Y, 95
            MOV Brick11X, 25
            MOV Brick11Y, 10
            MOV Brick12X, 200
            MOV Brick12Y, 150

            Build_Brick Brick1X Brick1Y 2
            Build_Brick Brick2X Brick2Y 4
            Build_Brick Brick3X Brick3Y 5
            Build_Brick Brick4X Brick4Y 6
            Build_Brick Brick5X Brick5Y 2
            Build_Brick Brick6X Brick6Y 4
            Build_Brick Brick7X Brick7Y 5
            Build_Brick Brick8X Brick8Y 6
            Build_Brick Brick9X Brick9Y 0
            Build_Brick Brick10X Brick10Y 4
            Build_Brick Brick11X Brick11Y 0
            Build_Brick Brick12X Brick12Y 0
            Redraw_Striker 7
            Redraw_Ball 44
            CALL Draw_Lives_Scores
            CALL Draw_Username
            CALL Draw_Game_Name
            
            CALL Game_Loop

            ;   Terminating the programme.
            
            MOV AH, 4CH
            INT 21H

        Level3 ENDP

        ;   Procedure to draw the name of the game at the top of the screen.

        Draw_Game_Name PROC

            PUSH DX
            PUSH AX

            MOV DH, 0
            MOV DL, 94
            MOV AH, 2 
            INT 10H
            
            LEA DX, GameName
            MOV AH, 9
            INT 21H

            POP AX
            POP DX

            RET

        Draw_Game_Name ENDP

        ;   Procedure to draw the entered username of the player onto the screen.

        Draw_Username PROC
        
            PUSH DX
            PUSH AX

            MOV DH, 125
            MOV DL, 25
            MOV AH, 2
            INT 10H
            
            LEA DX, PlayerName
            MOV AH, 9
            INT 21H

            POP AX
            POP DX

            RET

        Draw_Username ENDP

        ;   Procedure to draw the starting lives and score of the player onto the screen.

        Draw_Lives_Scores PROC

            PUSH DX
            PUSH AX

            MOV DH, 23
            MOV DL, 5
            MOV AH, 2
            INT 10H
            
            LEA DX, Score
            MOV AH, 9
            INT 21H
            
            CALL Print_Score
            
            LEA DX, Lives
            MOV AH, 9
            INT 21H  

            POP AX
            POP DX

            RET

        Draw_Lives_Scores ENDP

        ;   Procedure to print the score of the player onto the screen.

        Print_Score PROC

            PUSH AX
            PUSH BX
            PUSH CX
            PUSH DX
            
            MOV CX, 0
            MOV AX, ScoreCount

            Label1:

                MOV BX, 10
                MOV DX, 0
                DIV BX
                PUSH DX
                INC CX
                CMP AX, 0
                JNE Label1
            
            Label2:

                POP DX
                MOV AH, 2
                ADD DL, '0'
                INT 21H
            
            LOOP Label2
            
            POP DX
            POP CX
            POP BX
            POP AX
            
            RET

        Print_Score ENDP

        ;   Procedure to delay the execution of the programme for a certain amount of time.

        Sleep PROC

            MOV CX, 111111111111111b

            Sleep_Loop:

            LOOP Sleep_Loop

            RET
        
        Sleep ENDP

        ;   Procedure to draw the ball at the starting position of the game.

        Draw_Ball PROC

            PUSH BX

            MOV BX, BallX
            MOV StartX, BX
            ADD BX, 4
            MOV EndX, BX

            MOV BX, BallY
            MOV StartY, BX
            ADD BX, 4
            MOV EndY, BX
                
            POP BX
                
            CALL Drawer

            RET

        Draw_Ball ENDP

        ;   Procedure to detect collision between the ball and the striker, and determine the outcome accordingly.

        Collision_Striker PROC

            PUSH AX
            PUSH BX
            PUSH CX
            PUSH DX
            
            MOV DX, BallY
            CMP DX, 165 ;   Checking if the ball is at the same height as the striker or not.
            JL Run

            CMP DX, 170 ;   Checking if the ball has missed the striker or not.
            JG Fail

            MOV CX, StrikerX   
            MOV AX, BallX   
            CMP AX, CX  ;   Checking if the ball is at the same horizontal position as the striker or not.
            JL Run
            ADD CX, 40

            CMP AX, CX  ;   Checking if the ball has missed the striker or not.
            JG Run
            
            MOV BallUp, 1   ;   Setting the ball to move upwards by one unit.
            JMP Run

            ;   Label to jump to if the ball has missed the striker.

            Fail:

                MOV Begin, 0 
                DEC LivesCount
                CMP LivesCount, 30H ;   Checking if the player has any lives left or not.
                JE End_Level
                PUSH AX
                PUSH BX
                PUSH CX
                PUSH DX
                
                Redraw_Ball 0   ;   Redrawing the ball back at the starting position.
                MOV AX, StrikerX
                MOV BallX, AX
                ADD BallX, 18
                MOV BallY, 163
                Redraw_Ball 44

            MOV BallUp, 1   ;   Setting the ball to move upwards by one unit.
            MOV BallLeft, 0  ;   Setting the ball to not move leftwards.

            POP DX
            POP CX
            POP BX
            POP AX
            
            CALL Draw_Lives_Scores
            JMP Run

            ;   Label to end the game if the player has no remaining lives.

            End_Level:

                CALL Clear_Screen
                CALL Draw_Lives_Scores

                LEA DX, LossMessage
                MOV AH, 9
                INT 21H

                ;   Terminating the programme.

                MOV AH, 4CH
                INT 21H
            
            ;   Label to jump to if the ball has not missed the striker (continue the programme normally).

            Run:  
            
                POP DX
                POP CX
                POP BX
                POP AX

            RET

        ;   Label to jump to if the player has scored enough points to win the game.

        Win_Label:

            CALL Clear_Screen
            CALL Draw_Lives_Scores

            LEA DX, WinMessage
            MOV AH, 9
            INT 21H

            ;   Terminating the programme.

            MOV AH, 4CH
            INT 21H

        Collision_Striker ENDP

        Switcher:

            CMP BallUp, 1   ;   Checking if the ball is moving upwards or not.
            JE Downward
            JNE Upward

            ;   Label to move the ball upwards by one unit.

            Upward:

                INC BallUp

                RET

            ;   Label to move the ball downwards by one unit.

            Downward:

                DEC BallUp

                RET

        ;   Procedure to add a brick onto the screen.

        Add_Brick PROC

            PUSH AX
            PUSH BX
            PUSH DX

            ;   Setting the horizontal and vertical coordinates of the brick, and its colour.

            MOV StartX, AX
            MOV Colour, DL
            MOV AX, BX
            MOV BX, StartX
            ADD BX, 30
            MOV EndX,BX
            
            MOV StartY, AX 
            MOV BX, StartY        
            ADD BX, 7
            MOV EndY, BX
            
            CALL Drawer

            POP DX
            POP BX
            POP AX

            RET

        Add_Brick ENDP

        ;   Procedure to remove a brick from the screen (blacken it).

        Remove_Brick PROC 
    
            PUSH AX
            PUSH BX
            PUSH CX
            PUSH DX

            ;   Setting the horizontal and vertical coordinates of the brick to be removed, and its colour to black.
            
            MOV StartX, AX
            MOV Colour, 0
            MOV AX, BX
            MOV BX, StartX
            ADD BX, 30
            MOV EndX, BX
            
            MOV StartY, AX 
            MOV BX, StartY
            ADD BX, 7
            MOV EndY, BX
            
            CALL Drawer 
            
            POP DX
            POP CX
            POP BX
            POP AX

            RET

        Remove_Brick ENDP

        ;   Procedure to detect collision between the ball and the boundaries of the screen, and determine the movement accordingly.

        Collision_Wall PROC     
    
            MOV BX, BallX
            MOV CX, BallY

            ;   Label to check if the ball is colliding with the horizontal bounds or not.
            
            Check_Horizontal:

                CMP BX, 25  ;   Checking if the ball is at the leftmost edge of the screen or not.
                JL Move_Right

                CMP BX, 290 ;   Checking if the ball is at the rightmost edge of the screen or not.
                JG Move_Left

            JMP Check_Vertical

            ;   Label to move the ball to the right by one unit.

            Move_Right:

                MOV BallLeft, 0 ;   Setting the ball to not move leftwards.
            
            JMP Check_Vertical

            ;   Label to move the ball to the left by one unit.

            Move_Left:

                MOV BallLeft, 1 ;   Setting the ball to move leftwards by one unit.

            Check_Vertical:
            
                CMP CX, 13  ;   Checking if the ball is at the topmost edge of the screen or not.
                JL Move_Down

                CMP CX, 184 ;   Checking if the ball is at the bottommost edge of the screen or not.
                JG Move_Up

            JMP No_Input

            ;   Label to move the ball upwards by one unit.

            Move_Up:

                MOV BallUp, 1   ;   Setting the ball to move upwards by one unit.

            JMP No_Input

            ;   Label to move the ball downwards by one unit.

            Move_Down:

                MOV BallUp, 0   ;   Setting the ball to not move upwards.
        
            RET

        Collision_Wall ENDP

        ;   Procedure to end the game.

        End_Game PROC

            ;   Terminating the programme.
    
            MOV AH, 4CH
            INT 21H

        End_Game ENDP

        ;   Label to return from any procedure.

        Return_Label:

            RET

        ;   Procedure to control the movement of the ball.

        Baller PROC  
    
            INC InnerDelay

            CMP InnerDelay, EXTERNDELAY ;   Checking if the delay has been reached or not.
            JNE Return_Label 
            MOV InnerDelay, 0

            Redraw_Ball 0  
            
            MOV BX, BallX 
            CMP BallLeft, 1 ;   Checking if the ball is moving leftwards or not.
            JE Left
            JNE Right

            ;   Label to move the ball to the left by two units.
            
            Left:

                SUB BX, 2
                JMP Vertical_Movement

            ;   Label to move the ball to the right by two units.

            Right:

                ADD BX, 2
            
            Vertical_Movement:

                MOV BallX, BX   ;   Setting the horizontal coordinate of the ball to the new position.
                MOV BX, BallY
                CMP BallUp, 1   ;   Checking if the ball is moving upwards or not.
                JE Up
                JNE Down

            ;   Label to move the ball upwards by two units.

            Up:

                SUB BX, 2
                JMP Movement_Label

            ;   Label to move the ball downwards by two units.

            Down:

                ADD BX, 2

            ;   Label to set the new vertical coordinate of the ball.
            
            Movement_Label:

                MOV BallY, BX
        
            Redraw_Ball 44
            
            RET

        Baller ENDP

        ;   Label to repeat the programme until otherwise.

        Repeat_Game:

            ;   Label to recursively call the programme continuously.

            Game_Loop:

                CALL Check_Keyboard
                CMP Begin, 1    ;   Checking if the game has begun or not.
                JNE Repeat_Game
                
                CMP ScoreCount, 34   ;   Checking if the player has won the game or not.
                JE Win_Label

                CALL Collision_Wall
                CALL Collision_Striker
                Brick_Collision Brick1X, Brick1Y
                Brick_Collision Brick2X, Brick2Y
                Brick_Collision Brick3X, Brick3Y
                Brick_Collision Brick4X, Brick4Y
                Brick_Collision Brick5X, Brick5Y
                Brick_Collision Brick6X, Brick6Y 
                Brick_Collision Brick7X, Brick7Y
                Brick_Collision Brick8X, Brick8Y
                Brick_Collision Brick9X, Brick9Y
                Brick_Collision Brick10X, Brick10Y
                Brick_Collision Brick11X, Brick11Y
                Brick_Collision Brick12X, Brick12Y
   
                CALL Baller
                CALL Sleep

                CMP ScoreCount, 22  ;   Checking if the player has scored enough to move to the third level or not.
                JNE Game_Loop
                Write_Highscore
                CALL Clear_Screen
                CALL Level3

        ;   Label to exit the game.
    
        Exit:

            ;   Terminating the programme.

            MOV AH, 4CH
            INT 21H

        ;   Procedure to read the keyboard input from the player and determine the movement of the striker accordingly.

        Check_Keyboard PROC
            
            ;   Checking if the player has pressed any key or not.

            MOV AH, 1H
            INT 16H

            JZ No_Input

            MOV AH, 0H
            INT 16H
            CMP AX, 4D00H   ;   Checking if the player has pressed the right-arrow key or not.
            JE Right_Key

            CMP AX, 4B00H   ;   Checking if the player has pressed the left-arrow key or not.
            JE Left_Key

            CMP AL, 27D ;   Checking if the player has pressed the Escape key or not.
            JE Exit

            CMP AX, 3920H   ;   Checking if the player has pressed the space-bar key or not.
            JE Begin_Game
            JNE No_Input

            ;   Label to begin the game.
            
            Begin_Game:

                MOV Begin, 1
            
            ;   Label to jump to if no input is detected.
            
            No_Input:

                RET

            ;   Label to jump to if the player has presses the right-arrow key.

            Right_Key:

                MOV BX, BoundaryEnd
                CMP StrikerX, BX    ;   Checking if the striker is at the rightmost edge of the screen or not.
                JG No_Input
                Redraw_Striker 0

                ADD StrikerX, 5 ;   Moving the striker to the right by five units.
                Redraw_Striker 7

                CMP Begin, 0    ;   Checking if the game has begun or not.
                JZ Move_Ball_Right
                JMP No_Input
            
            ;   Label to jump to if the player has presses the left-arrow key.
            
            Left_Key:

                MOV BX, BoundaryStart
                CMP StrikerX, BX    ;   Checking if the striker is at the leftmost edge of the screen or not.
                JL No_Input
                Redraw_Striker 0

                SUB StrikerX, 5 ;   Moving the striker to the left by five units.
                Redraw_Striker 7

                CMP Begin, 0    ;   Checking if the game has begun or not.
                JZ Move_Ball_Left
                JMP No_Input
            
            ;   Label to move the ball to the left by five units.
            
            Move_Ball_Left:

                Redraw_Ball 0
                SUB BallX, 5    ;   Moving the ball to the left by five units.

                Redraw_Ball 44
                JMP No_Input

            ;   Label to move the ball to the right by five units.
            
            Move_Ball_Right:

                Redraw_Ball 0
                ADD BallX, 5    ;   Moving the ball to the right by five units.
                Redraw_Ball 44
                JMP No_Input

        Check_Keyboard ENDP

        ;   Procedure to draw assets onto the screen.

        Drawer PROC

            PUSH AX
            PUSH CX
            PUSH DX

            ;   Setting the coordinates and colour of the particular asset.
            
            MOV DX, StartY
            MOV CX, StartX
            MOV AH, 0CH
            MOV AL, Colour

            Draw_Label:

                INC CX
                INT 10H
                CMP CX, EndX    ;   Checking if the asset has been drawn completely or not.
                JNE Draw_Label

            MOV CX, StartX
            INC DX
            CMP DX, EndY    ;   Checking if the asset has been drawn completely or not.
            JNE Draw_Label
            
            POP DX
            POP CX
            POP AX

            RET

        Drawer ENDP

        ;   Procedure to draw the striker onto the screen.

        Draw_Striker PROC

            PUSH BX
            PUSH CX
            
            ;   Setting the horizontal and vertical coordinates of the striker.
                
            MOV BX, StrikerX
            MOV CX, StrikerY   
            MOV StartX, BX
            ADD BX, 40
            MOV EndX, BX
            MOV StartY, CX
            MOV EndY, 175

            CALL Drawer
            
            POP CX
            POP BX

            RET
        
        Draw_Striker ENDP

        ;   Procedure to draw the boundaries of the screen.

        Draw_Boundary PROC

            MOV Colour, 3
            
            ;   Drawing the top boundary of the screen.

            MOV StartX, 20
            MOV EndX, 300
            MOV StartY, 5
            MOV EndY, 8

            CALL Drawer
            
            ;   Drawing the right boundary of the screen.

            MOV StartX, 297
            MOV EndX, 300
            MOV StartY, 7
            MOV EndY, 180

            CALL Drawer
            
            ;   Drawing the left boundary of the screen.

            MOV StartX, 20
            MOV EndX, 23
            MOV StartY, 7
            MOV EndY, 180

            CALL Drawer
            
            ;   Drawing the bottom boundary of the screen.

            MOV StartX, 20
            MOV EndX, 300
            MOV StartY, 177
            MOV EndY, 180

            CALL Drawer
        
            RET

        Draw_Boundary ENDP

        ;   Procedure to set the attributes for the display screen of the game.

        Set_Video_Mode PROC
    
            MOV AH, 0   ;   Setting the display mode.
            MOV AL, 13H ;   Setting the resolution of the screen to 320x200 pixels, with 256 colors.
            INT 10H
            
            RET

        Set_Video_Mode ENDP

        ;   Procedure to implement the sound functionality of the game (beep).

        Beep_Sound PROC

            PUSH AX
            PUSH BX
            PUSH CX
            PUSH DX

            MOV AL, 182 ;   Preparing the speaker for the sound.
            OUT 43H, AL
            MOV AX, 400 ;   Setting the frequency of the sound.

            OUT 42H, AL
            MOV AL, AH
            OUT 42H, AL
            IN AL, 61H
            OR AL, 00000011b
            OUT 61H, AL
            MOV BX, 2

            ;   Label to pause the sound for a certain amount of time.

            Pause:

                    MOV CX, 65535

            ;   Label to loop the pause label.

            Pause_Loop:

                    DEC CX
                    JNE Pause_Loop
                    DEC BX
                    JNE Pause

            IN AL, 61H
            AND AL, 11111100b
            OUT 61H, AL

            POP DX
            POP CX
            POP BX
            POP AX

        RET

        Beep_Sound ENDP

        ;   Procedure to print a new line.

        Print_New_Line PROC

            MOV AH, 02H
            MOV DL, 0AH
            INT 21H

            MOV DL, 0DH
            INT 21H

            RET

        Print_New_Line ENDP

    END Main

;   © 2022 Muhammad Huzaifa Khan, Maryam Noor, and Areeba Riaz.
;   All rights reserved.