#NoEnv
#Persistent	
#MaxThreadsPerHotkey 2
#KeyHistory 0
ListLines Off
SetBatchLines, -1
SetKeyDelay, -1, -1
SetMouseDelay, -1
SetDefaultMouseSpeed, 0
SetWinDelay, -1
SetControlDelay, -1
SendMode Input
CoordMode, Pixel, Screen
SoundBeep, 350, 500

key_hold_mode := "\"
key_exit := "]"

key_hold := "RButton"
key_hold2 := "XButton2"

pixel_box := 1.6
pixel_sens := 80
color := 0xffff00
purp := 0xfe55fe
red := 0xfe2323
colors := "0xffff16|0xbcbd39"

leftbound := A_ScreenWidth / 2 - pixel_box
rightbound := A_ScreenWidth / 2 + pixel_box
topbound := A_ScreenHeight / 2 - pixel_box
bottombound := A_ScreenHeight / 2 + pixel_box

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
		PixelSearch, FoundX, FoundY, leftbound, topbound, rightbound, bottombound, purp, pixel_sens, Fast RGB
    			if !(ErrorLevel){
				click
				sleep 500
			}
    }
    return