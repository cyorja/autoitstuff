#include <AutoItConstants.au3>
#include <Misc.au3>
#include <MsgBoxConstants.au3>
#include "findWindow.au3"

FindWindow()
MsgBox($MB_SYSTEMMODAL, "Find Window", "Found window at ("&$iLeftCorner&","&$iTopCorner&")")


; To run:
; "C:\Program Files (x86)\AutoIt3\AutoIt3.exe" C:\Developer\AutoitScripts\fightAndGetGold.au3

TestColorAt(0, 102, 50, X(747), Y(577), "Done Button")
TestColorAt(192, 178, 156, X(343), Y(552), "Press X Dialog")
TestColorAt(33, 32, 49, X(423), Y(516), "Press X Title Bar")
TestColorAt(0, 214, 16, X(421), Y(387), "Bank Full Button")
TestColorAt(25, 180, 37, X(421), Y(387), "Bank Full Button")

Func TestColorAt($iR, $iG, $iB, $iX, $iY, $sLabel)
   MouseMove($iX, $iY, 10)
   Local $iSeenColor = PixelGetColor($iX, $iY)
   Local $iSeenR = BitShift($iSeenColor, 16)
   Local $iSeenG = BitShift(Mod($iSeenColor, 256*256), 8)
   Local $iSeenB = Mod($iSeenColor, 256)
   Local $fDistance = Sqrt(($iSeenR - $iR)^2 + ($iSeenG - $iG)^2 + ($iSeenB-$iB)^2)
   if $fDistance < 20 Then
	  ToolTip("Found " & $sLabel)
	  Sleep(2000)
   Else
	  MsgBox($MB_SYSTEMMODAL, "Test " & $sLabel, "Did not find " & $sLabel & _
		 ".  R=" & $iSeenR & ",G=" & $iSeenG & ",B=" & $iSeenB & " is " & _
		 $fDistance & " from R=" & $iR & ",G=" & $iG & ",B=" & $iB)
   EndIf
EndFunc

