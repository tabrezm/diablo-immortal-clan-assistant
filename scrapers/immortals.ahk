;
; Capture screenshots of Immortal member data. If there are less than 300
; members, this script will generate duplicate screenshots for the last page.
; These screenshots will be de-duped by the data processor. All coordinates are
; calibrated for PC @ 3360x2100 (full-screen, windowed).
;

#SingleInstance, Force
; SendMode Input
SetWorkingDir, %A_ScriptDir%

MemberYCoords := [775, 1000, 1225, 1450, 1675]

F5::

; Loop over members in table.
Loop 300 {
    ; Take screenshot of table every 5 rows
    if (Mod(A_Index - 1, 5) == 0) {
        Send, #{PrintScreen}
        Sleep 500
    }

    if (A_Index = 1) {
        ; Skip first row; opening the profile of the current user is unsupported
        continue
    }

    ; Calculate row coordinates
    i := Mod(A_Index, 5)
    MemberYCoord := i != 0 ? MemberYCoords[i] : MemberYCoords[5]

    ; Click row
    MouseClick, Left, 1500, MemberYCoord
    Sleep 1000

    ; Open and process profile
    MouseClick, Left, 1975, 775 ; player offline
    MouseClick, Left, 1975, 850 ; player online
    Sleep 1000
    gosub ProcessProfile

    ; Scroll table every 5 rows
    if (Mod(A_Index, 5) == 0) {
        ScrollDown(10)
        Sleep 1000
    }
}

return


+F5::
ExitApp


;
; Subroutine for processing a member's profile.
;
ProcessProfile:
; Open skills
Click 2670 790
Sleep 1000

; Take screenshot
Send, #{PrintScreen}
Sleep 500

; Go back
Click 2150 320
Sleep 1000

; Open attributes
Click 2270 790
Sleep 1000

; Take screenshot
Send, #{PrintScreen}
Sleep 500

; Open more attributes (1/4)
Click 2670 1740
Sleep 1000

; Take screenshot
Send, #{PrintScreen}
Sleep 500

; Get more attributes (2/4)
Click 2670 620 0
ScrollDown(10)
Send, #{PrintScreen}
Sleep 500

; Get more attributes (3/4)
ScrollDown(8)
Send, #{PrintScreen}
Sleep 500

; Get more attributes (4/4)
ScrollDown(9)
Sleep 1000 ; extra sleep for scroll bounce
Send, #{PrintScreen}
Sleep 500

; Close profile
Send {Esc}
Sleep 1000

return


;
; Scroll down by num scrolls.
;
ScrollDown(num:=1) {
    Loop % num {
        Send {WheelDown}
        Sleep 500
    }
}
