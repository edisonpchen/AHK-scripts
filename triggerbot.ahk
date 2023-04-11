#NoEnv
#Persistent	
#MaxThreadsPerHotkey 2
#KeyHistory 0
ListLines Off
SetBatchLines, -1
SetKeyDelay, -1, -1
SetMouseDelay, -1
SetWinDelay, -1
SetControlDelay, -1
SendMode Input
CoordMode, Pixel, Screen
SoundBeep, 350, 500

key_hold_mode := "\"
key_exit := "]"

key_hold := "RButton"
key_hold2 := "LAlt"

pixel_box_h := 2.2
pixel_sens := 60
yellow := 0xffff00
purp := 0xfe55fe
red := 0xfe2323
magenta := 0xf307f6
colors := "0xfe55fe|0x731185"

leftbound := A_ScreenWidth / 2 - pixel_box_h
rightbound := A_ScreenWidth / 2 + pixel_box_h
topbound := A_ScreenHeight / 2 - pixel_box_h
bottombound := A_ScreenHeight / 2 + pixel_box_h

hotkey, %key_hold_mode%, holdmode
hotkey, %key_exit%, terminate
return
     
terminate:
Sleep 250
SoundBeep, 200, 500
exitapp
return
     
holdmode:
SoundBeep, 500, 500
settimer, loop2, 1
return
     
loop2:
    while GetKeyState(key_hold, "P"){
        flag = 0
        PixelSearch, leftbound, topbound, rightbound, bottombound, purp, pixel_sens, Fast RGB
        if (!ErrorLevel){
            flag = 1
        }
        PixelSearch, A_ScreenWidth / 2 - 3, A_ScreenHeight / 2 - 1, A_ScreenWidth / 2 + 3, A_ScreenHeight / 2 + 1, 0xffffff, 0, Fast RGB
        if (flag && !ErrorLevel){
            Click
            sleep 600
        }
    }
return