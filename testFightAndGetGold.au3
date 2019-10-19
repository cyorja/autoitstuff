#include <AutoItConstants.au3>
#include <Misc.au3>
#include <MsgBoxConstants.au3>
; To run:
; "C:\Program Files (x86)\AutoIt3\AutoIt3.exe" C:\Developer\AutoitScripts\fightAndGetGold.au3

TestColorAt(0, 102, 50, 749, 606, "Done Button")
TestColorAt(192, 178, 156, 345, 581, "Press X Dialog")
TestColorAt(33, 32, 49, 425, 545, "Press X Title Bar")
TestColorAt(0, 214, 16, 423, 416, "Backpack Full Button")

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

