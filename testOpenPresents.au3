#include <AutoItConstants.au3>
#include <Misc.au3>
#include <MsgBoxConstants.au3>
; To run:
; "C:\Program Files (x86)\AutoIt3\AutoIt3.exe" C:\Developer\AutoitScripts\fightAndGetGold.au3


CircleMouse()
DismissBackpackFull()
While (CanCollectTreasure())
   CollectTreasure()
WEnd

Func CircleMouse()
		 MouseMove(100, 100, 1)
		 MouseMove(50, 100,10)
		 MouseMove(50, 50,10)
		 MouseMove(100, 50,10)
		 MouseMove(100, 100,10)
EndFunc


Func CanCollectTreasure()
   Return SeeColorAt(192, 178, 156, 345, 581) And SeeColorAt(33, 32, 49, 425, 545)
EndFunc

Func CollectTreasure()
	  Send("{x}")
	  ; Might popup that your backpack is full
	  DismissBackpackFull()
EndFunc

Func DismissBackpackFull()
	  Sleep(200)
	  TestColorAt(0, 214, 16, 423, 416, "Backpack Full Button")
	  TestColorAt(0, 208, 16, 423, 428, "Backpack Full Button")
	  While SeeColorAt(0, 214, 16, 423, 416) Or SeeColorAt(0, 208, 16, 423, 428)
		 MouseMove(423, 416, 3)
		 ; Move the mouse away from the button because it affects the color
		 MouseMove(100, 100,3)
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

Func TestColorAt($iR, $iG, $iB, $iX, $iY, $sLabel)
   Local $iSeenColor = PixelGetColor($iX, $iY)
   Local $iSeenR = BitShift($iSeenColor, 16)
   Local $iSeenG = BitShift(Mod($iSeenColor, 256*256), 8)
   Local $iSeenB = Mod($iSeenColor, 256)
   Local $fDistance = Sqrt(($iSeenR - $iR)^2 + ($iSeenG - $iG)^2 + ($iSeenB-$iB)^2)
   if $fDistance < 20 Then
	  MsgBox($MB_SYSTEMMODAL, "Test " & $sLabel, "Found " & $sLabel)
   Else
	  MsgBox($MB_SYSTEMMODAL, "Test " & $sLabel, "Failed.  " & $sLabel & " at distance " & $fDistance)
   EndIf
EndFunc
