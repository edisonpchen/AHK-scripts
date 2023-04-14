px2(color, variation := 3, x_coor := 0, y_coor := 0, width := 0, height := 0) {

   if !hdc {
   ; struct BITMAPINFOHEADER - https://docs.microsoft.com/en-us/windows/win32/api/wingdi/ns-wingdi-bitmapinfoheader
   hdc := DllCall("CreateCompatibleDC", "ptr", 0, "ptr")
   VarSetCapacity(bi, 40, 0)              ; sizeof(bi) = 40
      NumPut(       40, bi,  0,   "uint") ; Size
      NumPut(A_ScreenWidth, bi,  4,   "uint") ; Width
      NumPut(-A_ScreenHeight, bi,  8,    "int") ; Height - Negative so (0, 0) is top-left.
      NumPut(        1, bi, 12, "ushort") ; Planes
      NumPut(       32, bi, 14, "ushort") ; BitCount / BitsPerPixel
   hbm := DllCall("CreateDIBSection", "ptr", hdc, "ptr", &bi, "uint", 0, "ptr*", pBits:=0, "ptr", 0, "uint", 0, "ptr")
   obm := DllCall("SelectObject", "ptr", hdc, "ptr", hbm, "ptr")
   }

   ; Retrieve the device context for the screen.
   static sdc := DllCall("GetDC", "ptr", 0, "ptr")

   ; Copies a portion of the screen to a new device context.
   DllCall("gdi32\BitBlt"
            , "ptr", hdc, "int", x_coor, "int", y_coor, "int", width, "int", height
            , "ptr", sdc, "int", x_coor, "int", y_coor, "uint", 0x00CC0020) ; SRCCOPY

   ; C source code - https://godbolt.org/z/oocoPndE8
   static bin := 0
   if !bin {
      code := (A_PtrSize == 4)
         ? "VYnlVlNRikUQilUcik0gil0ki3UIiEX3ikUUiEX2ikUYiEX1O3UMcyiKRgI6Rfd3GzpF9nIWikYBOkX1dw440HIKigY4yHcEONhzCIPGBOvTi3UMWonwW15dww=="
         : "VlNEilQkOESKXCRAilwkSECKdCRQSInISDnQcyuKSAJEOMF3HUQ4yXIYikgBRDjRdxBEONlyC4oIONl3BUA48XMJSIPABOvQSInQW17D"
      size := StrLen(RTrim(code, "=")) * 3 // 4
      bin := DllCall("GlobalAlloc", "uint", 0, "uptr", size, "ptr")
      DllCall("VirtualProtect", "ptr", bin, "ptr", size, "uint", 0x40, "uint*", old:=0)
      DllCall("crypt32\CryptStringToBinary", "str", code, "uint", 0, "uint", 0x1, "ptr", bin, "uint*", size, "ptr", 0, "ptr", 0)
   }

   v := variation
   r := ((color & 0xFF0000) >> 16)
   g := ((color & 0xFF00) >> 8)
   b := ((color & 0xFF))

   ; When doing pointer arithmetic, *Scan0 + 1 is actually adding 4 bytes.
   byte := DllCall(bin, "ptr", pBits, "ptr", pBits + (4 * A_ScreenWidth * A_ScreenHeight)
            , "uchar", Min(r+v, 255)
            , "uchar", Max(r-v, 0)
            , "uchar", Min(g+v, 255)
            , "uchar", Max(g-v, 0)
            , "uchar", Min(b+v, 255)
            , "uchar", Max(b-v, 0)
            , "ptr")

   if (byte == pBits + (4 * A_ScreenWidth * A_ScreenHeight))
      return False
   return True
}

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

pixel_box_c := 2
upper_left_x := Floor(A_ScreenWidth / 2 - pixel_box_c)
upper_left_y := Floor(A_ScreenHeight / 2 + pixel_box_c)
width := 7
height := 7

key_hold_mode := "\"
key_exit := "]"

trigger := "RButton"

hotkey, %key_hold_mode%, activate
hotkey, %key_exit%, terminate
return

terminate:
SoundBeep, 200, 500
exitapp
return
     
activate:
SoundBeep, 500, 500
settimer, loop, 1
return

global hdc, hbm, obm, pBits


loop:
	flag = 0
	while GetKeyState(trigger){
      start := A_TickCount
      if (px2(0xfe55fe, 70, upper_left_x, upper_left_y, width, height))
         Click
         ElapsedTime := A_TickCount - start
         msgbox, %ElapsedTime% ms
         Sleep 525
	}
return

