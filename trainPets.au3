#include <AutoItConstants.au3>
#include <Misc.au3>
#include <MsgBoxConstants.au3>
#include "findWindow.au3"

; To run:
; "C:\Program Files (x86)\AutoIt3\AutoIt3.exe" C:\Developer\AutoitScripts\fightAndGetGold.au3
;635D08
HotKeySet("{ESC}", "AbortScript")
Global $iPause = 500
Global $iLongPause = 1000

;FindWindow()
;MsgBox($MB_SYSTEMMODAL, "Find Window", "Found window at ("&$iLeftCorner&","&$iTopCorner&")")
SkipFindWindow(13, 28)

While True

   TrainPets()
   Send("{x}")
   Sleep(10000)

WEnd

Func TrainPets()
   OpenMyPets()

   Local $ixBetweenPets=89
   Local $iPetCenterX=119 ; X Location of first pet (middle of the pet)
   Local $iPetCenterY=114  ; Y Location of first pet (middle of the pet)
   For $iNextX = 0 To 3
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
   Sleep($iLongPause)
EndFunc

Func CloseMyPets()
   MouseClick($MOUSE_CLICK_LEFT, X(772), Y(30), 1, 10)
   Sleep($iLongPause)
EndFunc

Func CanFinishTraining($iPetX, $iPetY)
   ; If there is a yellow exclamation mark, then it can finish training
   Local $iPetNeedsTrainingX=28 ; x distance from center of pet to yellow exclamation
   Local $iPetNeedsTrainingY=23 ; y distance from center of pet to yellow exclamation
   MouseMove(X($iPetX+$iPetNeedsTrainingX), Y($iPetY+$iPetNeedsTrainingY), 10)
   Sleep($iPause)
   Local $bExclamation = SeeColorAt(252, 238, 30, _
	  X($iPetX+$iPetNeedsTrainingX), Y($iPetY+$iPetNeedsTrainingY))
   return $bExclamation
EndFunc

Func FinishTraining($iPetX, $iPetY)
		 MouseClick($MOUSE_CLICK_LEFT, X($iPetX), Y($iPetY), 1, 10)
		 Sleep($iPause)
		 MouseClick($MOUSE_CLICK_LEFT, X(250), Y(560), 1, 10)
		 Sleep($iLongPause)
		 ; Pick the first food an feed it to him
		 MouseClick($MOUSE_CLICK_LEFT, X(150), Y(480), 1, 10)
		 Sleep($iPause)
		 MouseClick($MOUSE_CLICK_LEFT, X(663), Y(560), 1, 10)
   		 Sleep($iPause)
		 ;; Cick Finish
		 MouseClick($MOUSE_CLICK_LEFT, X(390), Y(564), 1, 10)
		 Sleep($iLongPause)
EndFunc

Func IsPetTraining($iPetX, $iPetY)
   ; If there is a white time piece, then it is training
   Local $iTrainingWatchX=-30 ; x distance from center of pet to white watch
   Local $iTrainingWatchY=-26 ; y distance from center of pet to white watch
   MouseMove(X($iPetX+$iTrainingWatchX), Y($iPetY+$iTrainingWatchY), 10)
   Sleep($iPause)
   return SeeColorAt(247, 242, 242, _
	  X($iPetX+$iTrainingWatchX), Y($iPetY+$iTrainingWatchY))
EndFunc

Func IsFacilityOpen($iFacilityX, $iFacilityY)
   ; If there is a yellow lock with a beige hole above the center, then it is locked
   Local $iPetNeedsTrainingX=28 ; x distance from center of pet to yellow exclamation
   Local $iPetNeedsTrainingY=23 ; y distance from center of pet to yellow exclamation
   Local $bLock = SeeColorAt(239, 162, 0, X($iFacilityX), Y($iFacilityY)) And _
	  SeeColorAt(67, 60, 44, X($iFacilityX+11), Y($iFacilityY-11))
   return Not $bLock
EndFunc

Func ClickTrainingFacility()
   Local $iFacilityX = 95
   Local $iFirstFacilityY = 167
   Local $iYBetweenFacilities = 57

   ; Find the best training facility in the list of 6
   Local $iFound = -1
   For $iNext = 5 To 0 Step -1
	  Local $iFacilityY = $iFirstFacilityY + ($iNext * $iYBetweenFacilities)
	  MouseMove(X($iFacilityX), Y($iFacilityY), 10)
	  Sleep($iPause)
	  If IsFacilityOpen($iFacilityX, $iFacilityY) Then
		 ; Click that facility
		 MouseClick($MOUSE_CLICK_LEFT, X($iFacilityX), Y($iFacilityY), 1, 10)
		 Sleep($iLongPause)
		 return $iNext
	  EndIf
   Next
EndFunc

Func TrainAtFacility($iFacility)
		 ; Always click on first training excercise
		 MouseClick($MOUSE_CLICK_LEFT, X(236), Y(164), 1, 10)
		 Sleep($iLongPause)
		 ; Click Train
		 MouseClick($MOUSE_CLICK_LEFT, X(345), Y(246), 1, 10)
		 Sleep($iLongPause)
EndFunc

Func Train($iPetX, $iPetY)
		 ; Click on Pet and click Train
		 MouseClick($MOUSE_CLICK_LEFT, X($iPetX), Y($iPetY), 1, 10)
		 Sleep($iPause)
		 MouseMove(X(250), Y(560), 10)
		 Sleep($iPause)
		 MouseClick($MOUSE_CLICK_LEFT, X(250), Y(560), 1, 10)
		 Sleep($iLongPause)
		 Local $iFacility = ClickTrainingFacility()
		 TrainAtFacility($iFacility)
EndFunc


Func SeeColorAt($iR, $iG, $iB, $iX, $iY, $bDebug=False)
   Local $iSeenColor = PixelGetColor($iX, $iY)
   Local $iSeenR = BitShift($iSeenColor, 16)
   Local $iSeenG = BitShift(Mod($iSeenColor, 256*256), 8)
   Local $iSeenB = Mod($iSeenColor, 256)
   Local $fDistance = Sqrt(($iSeenR - $iR)^2 + ($iSeenG - $iG)^2 + ($iSeenB-$iB)^2)
   Local $bSeen = $fDistance < 20
   If $bDebug Then
	  If $bSeen Then
		 MsgBox($MB_OK, "Test", "Found ")
	  Else
		 MsgBox($MB_OK, "Test", "Not found.  ("&$iSeenR&","&$iSeenG&","&$iSeenB&") is "&$fDistance&" from ("&$iR&","&$iG&","&$iB&")")
	  EndIf
   EndIf
   Return $bSeen
EndFunc

Func AbortScript()
    Exit ; Code for action here, in this case to exit the script (i.e. close the program)
EndFunc
