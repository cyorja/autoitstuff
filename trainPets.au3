#include <AutoItConstants.au3>
#include <Misc.au3>
#include <MsgBoxConstants.au3>
#include "findWindow.au3"

; To run:
; "C:\Program Files (x86)\AutoIt3\AutoIt3.exe" C:\Developer\AutoitScripts\fightAndGetGold.au3

;1, 26
HotKeySet("{ESC}", "_Quit")

FindWindow()
MsgBox($MB_SYSTEMMODAL, "Find Window", "Found window at ("&$iLeftCorner&","&$iTopCorner&")")

;While Not _IsPressed("1B")

   TrainPets()
   Sleep(1000)

;WEnd

Func TrainPets()
   OpenMyPets()

   Local $ixBetweenPets=89
   Local $iPetCenterX=119 ; X Location of first pet (middle of the pet)
   Local $iPetCenterY=114  ; Y Location of first pet (middle of the pet)
   For $iNextX = 2 To 2
	  $iPetX = $iPetCenterX + $iNextX * $ixBetweenPets
	  $iPetY = $iPetCenterY
	  If CanFinishTraining($iPetX, $iPetY) Then
		 FinishTraining($iPetX, $iPetY)
	  EndIf
	  If Not IsPetTraining($iPetX, $iPetY) Then
		 Train($iPetX, $iPetY)
	  EndIf
   Next
   CloseMyPets()
EndFunc

Func OpenMyPets()
   Send("{i}")
   Sleep(1000)
EndFunc

Func CloseMyPets()
   MouseClick($MOUSE_CLICK_LEFT, X(772), Y(30), 3)
EndFunc

Func CanFinishTraining($iPetX, $iPetY)
   ; If there is a yellow exclamation mark, then it can finish training
   Local $iPetNeedsTrainingX=28 ; x distance from center of pet to yellow exclamation
   Local $iPetNeedsTrainingY=31 ; y distance from center of pet to yellow exclamation
   return SeeColorAt(252, 238, 30, X($iPetX+$iPetNeedsTrainingX), Y($iPetY+$iPetNeedsTrainingY))
EndFunc

Func FinishTraining($iPetX, $iPetY)
		 MouseClick($MOUSE_CLICK_LEFT, X($iPetX), Y($iPetY), 3)
		 Sleep(200)
		 MouseClick($MOUSE_CLICK_LEFT, X(250), Y(560), 3)
		 Sleep(200)
		 ; Pick the first food an feed it to him
		 MouseClick($MOUSE_CLICK_LEFT, X(150), Y(480), 3)
		 Sleep(200)
		 MouseClick($MOUSE_CLICK_LEFT, X(663), Y(560), 3)
   		 Sleep(200)
		 ;; Cick Finish
		 MouseClick($MOUSE_CLICK_LEFT, X(390), Y(564), 3)
		 Sleep(500)
EndFunc

Func IsPetTraining($iPetX, $iPetY)
   ; If there is a white time piece, then it is training
   Local $iTrainingWatchX=-30 ; x distance from center of pet to white watch
   Local $iTrainingWatchY=-26 ; y distance from center of pet to white watch
   return SeeColorAt(247, 242, 242, X($iPetX+$iTrainingWatchX), Y($iPetY+$iTrainingWatchY))
EndFunc

Func Train($iPetX, $iPetY)
		 ; Click on Pet and click Train
		 MouseClick($MOUSE_CLICK_LEFT, X($iPetX), Y($iPetY), 3)
		 Sleep(200)
		 MouseMove(X(250), Y(560), 3)
		 Sleep(1000)
		 MouseClick($MOUSE_CLICK_LEFT, X(250), Y(560), 3)
		 Sleep(500)
		 ; Click on Training Facility
		 MouseClick($MOUSE_CLICK_LEFT, X(236), Y(164), 3)
		 Sleep(200)
		 ; Click on Training and click Train
		 MouseClick($MOUSE_CLICK_LEFT, X(236), Y(164), 3)
		 Sleep(200)
		 MouseClick($MOUSE_CLICK_LEFT, X(345), Y(246), 3)
		 Sleep(200)
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

