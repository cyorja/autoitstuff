#include <AutoItConstants.au3>
#include <Misc.au3>
#include <MsgBoxConstants.au3>
#include "findWindow.au3"

; To run:
; "C:\Program Files (x86)\AutoIt3\AutoIt3.exe" C:\Developer\AutoitScripts\fightAndGetGold.au3
; 9, 95
FindWindow()
MsgBox($MB_SYSTEMMODAL, "Find Window", "Found window at ("&$iLeftCorner&","&$iTopCorner&")")

While Not _IsPressed("1B")
   ; Every seconds check first if we should hurry the battle along and
   ; second if we should open treasure chests

   CircleMouse()
   DismissBackpackFull()
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
   Return SeeColorAt(192, 178, 156, X(342), Y(555)) And SeeColorAt(33, 32, 49, X(424), Y(519))
EndFunc

Func CollectTreasure()
	  Send("{x}")
	  ; Might popup that your backpack is full
	  DismissBackpackFull()
EndFunc

Func DismissBackpackFull()
	  Sleep(200)
	  While SeeColorAt(0, 214, 16, X(422), Y(390)) Or SeeColorAt(0, 208, 16, X(422), Y(402))
		 MouseClick($MOUSE_CLICK_LEFT, X(422), Y(390), 3)
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
