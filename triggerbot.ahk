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

; Define pixel search parameters
pixel_box_c := 2
pixel_sens := 32
pixel_box_w_h := 3
pixel_box_w_v := 1

yellow := 0xfbfb32
; red:dc3232, max yellow:fafa37, max red:d92121 f8f842

; Calculate bounds
leftbound := A_ScreenWidth // 2 - pixel_box_c
rightbound := A_ScreenWidth // 2 + pixel_box_c
topbound := A_ScreenHeight // 2 - pixel_box_c
bottombound := A_ScreenHeight // 2 + pixel_box_c

leftbound_w := A_ScreenWidth // 2 - pixel_box_w_h
rightbound_w := A_ScreenWidth // 2 + pixel_box_w_h
topbound_w := A_ScreenHeight // 2 - pixel_box_w_v
bottombound_w := A_ScreenHeight // 2 + pixel_box_w_v

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
		PixelSearch, , , leftbound, topbound, rightbound, bottombound, yellow, pixel_sens, Fast RGB
		if (!ErrorLevel){
			PixelSearch, , , leftbound_w, topbound_w, rightbound_w, bottombound_w, 0xffffff, , Fast RGB
			if (!ErrorLevel){
				Click
				Sleep 464
			}
		}
	}
return
