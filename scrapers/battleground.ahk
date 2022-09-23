;
; Capture screenshots of Battlegrounds leaderboard data. All coordinates are
; calibrated for PC @ 3360x2100 (full-screen, windowed).
;

#SingleInstance, Force
; SendMode Input
SetWorkingDir, %A_ScriptDir%

F5::
Gosub ProcessClass

; Move to next class
SwitchClass(1530)
Gosub ProcessClass

; Move to next class
SwitchClass(1680)
Gosub ProcessClass

; Move to next class
SwitchClass(1370, 4)
Gosub ProcessClass

; Move to next class
SwitchClass(1530)
Gosub ProcessClass

; Move to next class
SwitchClass(1680)
Gosub ProcessClass

return


+F5::
ExitApp


ProcessClass:
; Move cursor to standing column.
Click 1065 540 0
Sleep 500

; Take screenshot for top 3 and scroll.
Send, #{PrintScreen}
Sleep 500
ScrollDown(6)

; 25 iterations fetches ~100 results.
Loop 25 {
    ; This table doesn't scroll by row height, so we take screenshots that
    ; overlap by 1-2 members and de-dupe in the data processor.
    Send, #{PrintScreen}
    Sleep 500
    ScrollDown(6)
}

return


ScrollDown(num:=1) {
    Loop % num {
        Send {WheelDown}
        Sleep 500
    }
}


SwitchClass(y, numScrolls:=0) {
    ; Open dropdown
    Click 3250 1820
    Sleep 500

    ; Scroll dropdown
    if (numScrolls != 0) {
        Click 3250 1375 0
        Sleep 500
        ScrollDown(numScrolls)
    }

    ; Click dropdown item
    Click 3250 %y%
    Sleep 500
}
