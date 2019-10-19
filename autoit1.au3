While True
   OpenCompanionControl()
   For $i = 1 to 3
	  FinishOrder($i)
	  OrderPlunderin($i)
   Next
   CloseCompanionControl()
   Wait(20)
WEnd

Func Wait($vMinutes)
   Local $iMsPerMinute = 60000
   Local $iMaxSleep = 6
   Local $iThereAndBack = 2
   ; If waiting less than two minutes, just wait.
   Local $iMinutesLeft = $vMinutes
   While $iMinutesLeft > 0
	  If $iMinutesLeft < $iThereAndBack Then
		 Sleep($vMinutes * $iMsPerMinute)
		 $iMinutesLeft = 0
	  ElseIf $iMinutesLeft < 2 * $iThereAndBack Then
		 ; Wait and go once
		 Sleep(($iMinutesLeft-$iThereAndBack) * $iMsPerMinute)
		 GoToSkullIslandAndBack()
		 $iMinutesLeft = 0
	  ElseIf $iMinutesLeft < $iMaxSleep + 2 * $iThereAndBack Then
		 ; Go, wait, go again, and we're done
		 GoToSkullIslandAndBack()
		 Sleep(($iMinutesLeft-(2*$iThereAndBack)) * $iMsPerMinute)
		 GoToSkullIslandAndBack()
		 $iMinutesLeft = 0
	  ElseIf $iMinutesLeft < $iMaxSleep + 3 * $iThereAndBack Then
		 ; Go, wait, go again, and immeditealy go a third time and done
		 GoToSkullIslandAndBack()
		 Sleep(($iMinutesLeft-(3*$iThereAndBack)) * $iMsPerMinute)
		 GoToSkullIslandAndBack()
		 GoToSkullIslandAndBack()
		 $iMinutesLeft = 0
	  Else
		 ; Go, wait, and repeat the loop
		 GoToSkullIslandAndBack()
		 Sleep($iMaxSleep * $iMsPerMinute)
		 $iMinutesLeft = $iMinutesLeft - $iMaxSleep - $iThereAAndBack
	  EndIf
   WEnd
EndFunc

Func GoToSkullIslandAndBack()
   MouseMove (26, 588, 25) ; Skull Island
   Sleep(250)
   MouseClick ("left", 26, 588, 1, 0)
   Sleep(60000)
   MouseMove (108, 588, 25) ; Go to Home
   MouseClick ("left", 108, 588, 1, 0)
   Sleep(60000)
EndFunc

Func OpenCompanionControl()
   ; Opens My Companions panel from top dropdown
   ; assumes My Companions is not currently open

   MouseMove (400, 44, 25) ; Pull down top drop down
   MouseMove (260, 66, 25) ; Hook (Information about your character)
   Sleep(250)
   MouseClick ("left", 260, 66, 1, 0)
   MouseMove (255, 302, 15) ; My Companions
   Sleep(250)
   MouseClick ("left", 255, 302, 1, 0)
   Sleep(1000)
EndFunc

Func OrderPlunderin($vCompanionNum)
   ; Gives a companion orders to plunder
   ; assumes companion panel is up and companion has no other orders
   Local $iCompanionX = 128
   Local $iCompanionY = 158
   Local $iCompanionXDiff = 96

   Local $iX = $iCompanionX + $vCompanionNum * $iCompanionXDiff
   MouseMove ($iX, $iCompanionY, 50) ; Click on companion
   Sleep(250)
   MouseClick ("left", $iX, $iCompanionY, 1, 0)
   MouseMove (518, 587, 50) ; Click on New Orders
   Sleep(250)
   MouseClick ("left", 518, 587, 1, 0)
   Sleep(250)
   MouseMove (611, 260, 50) ; Click on Plunderin'
   Sleep(250)
   MouseClick ("left", 611, 260, 1, 0)
   Sleep(250)
   MouseMove (621, 587, 50) ; Click on Begin
   Sleep(250)
   MouseClick ("left", 621, 587, 1, 0)
   Sleep(250)

EndFunc

Func FinishOrder($vCompanionNum)
   ; Complete orders for a companion so they are ready for new orders
   ; Assumes companion panel is up and companion has had time to complete orders
   Local $iCompanionX = 128
   Local $iCompanionCollectY = 196
   Local $iCompanionXDiff = 96

   Local $iX = $iCompanionX + $vCompanionNum * $iCompanionXDiff
   MouseMove ($iX, $iCompanionCollectY, 50) ; Collect bar on the companion
   Sleep(250)
   MouseClick ("left", $iX, $iCompanionCollectY, 1, 0)
   Sleep(8750)

EndFunc

Func CloseCompanionControl()
   ; Closed the My Companions panel and the whole top dropdown
   ; assumes the My Companions panel is open
   MouseMove (774, 57, 25) ; Close the Companion Window
   Sleep(250)
   MouseClick ("left", 774, 57, 1, 0)
   Sleep(250)
EndFunc

