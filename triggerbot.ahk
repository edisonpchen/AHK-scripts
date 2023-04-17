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

pixel_box_c := 2.4
pixel_sens := 40
pixel_box_w_h := 3
pixel_box_w_v := .5
yellow := 0xffff00
purp := 0xfe55fe
red := 0xfe2323
magenta := 0xf307f6
colors := "0xfe55fe|0x731185"

leftbound := A_ScreenWidth / 2 - pixel_box_c
rightbound := A_ScreenWidth / 2 + pixel_box_c
topbound := A_ScreenHeight / 2 - pixel_box_c
bottombound := A_ScreenHeight / 2 + pixel_box_c

leftbound_w := A_ScreenWidth / 2 - pixel_box_w_h
rightbound_w := A_ScreenWidth / 2 + pixel_box_w_h
topbound_w := A_ScreenHeight / 2 - pixel_box_w_v
bottombound_w := A_ScreenHeight / 2 + pixel_box_w_v

hotkey, %key_hold_mode%, activate
hotkey, %key_exit%, terminate
return
     
terminate:
Sleep 250
SoundBeep, 200, 500
exitapp
return
     
activate:
SoundBeep, 500, 500
settimer, loop, 1
return
     
loop:	
	while GetKeyState(trigger){
		PixelSearch, , , leftbound, topbound, rightbound, bottombound, purp, pixel_sens, Fast RGB
		if (!ErrorLevel){
			PixelSearch, , , leftbound_w, topbound_w, rightbound_w, bottombound_w, 0xffffff, , Fast RGB
			if (!ErrorLevel){
				Click
				Sleep 600
			}
		}
	}
return