#include <AutoItConstants.au3>
#include <Misc.au3>
#include <MsgBoxConstants.au3>
#include "findWindow.au3"

; To run:
; "C:\Program Files (x86)\AutoIt3\AutoIt3.exe" C:\Developer\AutoitScripts\fightAndGetGold.au3

HotKeySet("{ESC}", "_Quit")

FindWindow()
MsgBox($MB_SYSTEMMODAL, "Find Window", "Found window at ("&$iLeftCorner&","&$iTopCorner&")")

While Not _IsPressed("1B")
   ; Every seconds check first if we should hurry the battle along and
   ; second if we should open treasure chests

   CircleMouse();
   ; Click the Done button at the bottom right of the battle if present
   If SeeColorAt(0, 102, 50, X(747), Y(577)) Then
		 MouseClick($MOUSE_CLICK_LEFT, X(747), Y(577), 3)
		 ; Move the mouse away from the button because it affects the color
		 MouseMove(X(100), Y(100), 3)
   EndIf
   ; Click the Backpack full button if present
   If SeeColorAt(0, 214, 16, X(421), Y(387)) Then
		 MouseClick($MOUSE_CLICK_LEFT, X(421), Y(387), 3)
		 ; Move the mouse away from the button because it affects the color
		 MouseMove(X(100), Y(100),3)
   EndIf
   While (CanCollectTreasure())
	  CollectTreasure()
   WEnd
WEnd

Func CircleMouse()
		 MouseMove(X(100), Y(100), 1)
		 MouseMove(X(50), Y(100),10)
		 MouseMove(X(50), Y(50),10)
		 MouseMove(X(100), Y(50),10)
		 MouseMove(X(100), Y(100),10)
EndFunc

Func CanCollectTreasure()
   ; Look for the beige of the "Press X to Open" dialog's background and the
   ; dark blue of the dialog's title bar
   Return SeeColorAt(192, 178, 156, X(343), Y(552)) And _
	  SeeColorAt(33, 32, 49, X(423), Y(516))
EndFunc

Func CollectTreasure()
	  Send("{x}")
	  ; Might popup that your backpack is full
	  Sleep(200)
	  While SeeColorAt(0, 214, 16, X(421), Y(387))
		 MouseClick($MOUSE_CLICK_LEFT, X(421), Y(387), 3)
		 ; Move the mouse away from the button because it affects the color
		 MouseMove(X(100), Y(100),3)
		 Sleep(200)
	  WEnd
EndFunc

Func SeeColorAt($iR, $iG, $iB, $iX, $iY)
   Local $iSeenColor = PixelGetColor($iX, $iY)
   Local $iSeenR = BitShift($iSeenColor, 16)
   Local $iSeenG = BitShift(Mod($iSeenColor, 256*256), 8)
   Local $iSeenB = Mod($iSeenColor, 256)
   Local $fDistance = Sqrt(($iSeenR - $iR)^2 + ($iSeenG - $iG)^2 + ($iSeenB-$iB)^2)
   Local $bSeen = $fDistance < 20
   Return $bSeen
EndFunc

Func ColorTest()
   ;; Backpack full button - Color = 00D610
   Local $iColor = PixelGetColor(423, 416)
   ;; Done button - Color = 228152
   ;Local $iColor = PixelGetColor(747, 597)
   Const $iDRed = 0
   Const $iDGreen = 214
   Const $iDBlue = 16
   Local $iRed = BitShift($iColor, 16)
   Local $iGreen = BitShift(Mod($iColor, 256*256), 8)
   Local $iBlue = Mod($iColor, 256)
   Local $fDistance = Sqrt(($iRed - $iDRed)^2 + ($iGreen - $iDGreen)^2 + ($iBlue-$iDBlue)^2)
   MsgBox($MB_SYSTEMMODAL, "", "The hex color is: " & Hex($iColor, 6))
   MsgBox($MB_SYSTEMMODAL, "", "R: " & $iRed)
   MsgBox($MB_SYSTEMMODAL, "", "G: " & $iGreen)
   MsgBox($MB_SYSTEMMODAL, "", "B: " & $iBlue)
   MsgBox($MB_SYSTEMMODAL, "", "Distance from 00D610: " & $fDistance)
EndFunc