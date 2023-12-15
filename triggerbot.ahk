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
key_switch := "["
trigger := "RButton"
key_hold2 := "LAlt"

; Define pixel search parameters
pixel_box_c := 2
pixel_sens := 42
pixel_box_w_h := 3
pixel_box_w_v := 1

; yellow := 0xdfdf32
; red:dc3232, max yellow:fafa37, max red:d92121 f8f842 0xfbfb32 0xf1f132

; Calculate bounds
leftbound := (A_ScreenWidth // 2 - pixel_box_c)
rightbound := (A_ScreenWidth // 2 + pixel_box_c)
topbound := (A_ScreenHeight // 2 - pixel_box_c)
bottombound := (A_ScreenHeight // 2 + pixel_box_c)

; MsgBox %leftbound% %rightbound% %topbound% %bottombound%

leftbound_w := floor(A_ScreenWidth / 2 - pixel_box_w_h)
rightbound_w := floor(A_ScreenWidth / 2 + pixel_box_w_h)
topbound_w := floor(A_ScreenHeight / 2 - pixel_box_w_v)
bottombound_w := floor(A_ScreenHeight / 2 + pixel_box_w_v)

; MsgBox %leftbound_w% %rightbound_w% %topbound_w% %bottombound_w%

hotkey, %key_hold_mode%, activate
hotkey, %key_exit%, terminate
hotkey, %key_switch%, switch
return
     
terminate:
SoundBeep, 200, 500
exitapp
return
     
activate:
SoundBeep, 400, 500
yellow := 0xebeb42
; f0f032
settimer, loop, 1
return

switch:
SoundBeep, 500, 500
yellow := 0xffff42
return

; original values were 957, 539, 963, 541

loop:
	while GetKeyState(trigger){
		PixelSearch, , , 957, 533, 963, 539, yellow, pixel_sens, Fast RGB
		if (!ErrorLevel){
			PixelSearch, , , 957, 539, 963, 541, 0xffffff, , Fast RGB
			if (!ErrorLevel){
				SendInput {Blind}l
				Sleep 464
			}
		}
	}
return
