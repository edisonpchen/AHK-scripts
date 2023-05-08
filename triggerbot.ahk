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

SoundBeep, 300, 500

key_hold_mode := "\"
key_exit := "]"

trigger := "RButton"
key_hold2 := "LAlt"

pixel_box_c := 2
pixel_sens := 40
pixel_box_w_h := 3
pixel_box_w_v := 1

red := 0xd92121

leftbound := floor(A_ScreenWidth / 2 - pixel_box_c)
rightbound := floor(A_ScreenWidth / 2 + pixel_box_c)
topbound := floor(A_ScreenHeight / 2 - pixel_box_c)
bottombound := floor(A_ScreenHeight / 2 + pixel_box_c)

leftbound_w := floor(A_ScreenWidth / 2 - pixel_box_w_h)
rightbound_w := floor(A_ScreenWidth / 2 + pixel_box_w_h)
topbound_w := floor(A_ScreenHeight / 2 - pixel_box_w_v)
bottombound_w := floor(A_ScreenHeight / 2 + pixel_box_w_v)

; MsgBox, %leftbound%, %rightbound%, %topbound%, %bottombound%, %leftbound_w%, %rightbound_w%, %topbound_w%, %bottombound_w%

hotkey, %key_hold_mode%, activate
hotkey, %key_exit%, terminate
return
     
terminate:
SoundBeep, 200, 500
exitapp
return
     
activate:
SoundBeep, 400, 500
settimer, loop, 1
return

loop:	
	while GetKeyState(trigger){
		PixelSearch, , , leftbound, topbound, rightbound, bottombound, red, pixel_sens, Fast RGB
		if (!ErrorLevel){
			PixelSearch, , , leftbound_w, topbound_w, rightbound_w, bottombound_w, 0xffffff, , Fast RGB
			if (!ErrorLevel){
				Click
				Sleep 550
			}
		}
	}
return