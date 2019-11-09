#include <Misc.au3>
#include <MsgBoxConstants.au3>
#include <GUIConstantsEx.au3>
#include "MouseOnEvent.au3"

   Func MousePrimaryUp_Event()
	  ToolTip("Mouse Button Detected")
	  $iMouseX = MouseGetPos(0)
	  $iMouseY = MouseGetPos(1)
	  _MouseSetOnEvent($MOUSE_PRIMARYUP_EVENT)
   EndFunc

   Func FindWindow()

	  Global $iMouseX = -1
	  Global $iMouseY = -1
	  _MouseSetOnEvent($MOUSE_PRIMARYUP_EVENT, "MousePrimaryUp_Event")
	  While $iMouseX=-1
		 Sleep(100)
	  WEnd
	  ToolTip("Mouse clicked at (" & $iMouseX & ", " & $iMouseY &")="&PixelGetColor($iMouseX, $iMouseY) )

	  ; Determine the coordinates of the title bar top/bottom of the window
	  Local $iBarColor = PixelGetColor($iMouseX, $iMouseY)
	  Local $iBottom = $iMouseY
	  While $iBottom<$iMouseY+100 And PixelGetColor($iMouseX, $iBottom+1)=$iBarColor
		 $iBottom=$iBottom+1
	  WEnd
	  Global $iLeft = $iMouseX
	  While $iLeft>0 And PixelGetColor($iLeft-1, $iBottom)=$iBarColor
		 $iLeft=$iLeft-1
	  WEnd

	  Global $iLeftCorner=$iLeft
	  Global $iTopCorner=$iBottom+1

   EndFunc

   Func X($ix)
	  Return $iLeftCorner+$ix
   EndFunc

   Func Y($iy)
	  Return $iTopCorner+$iy
   EndFunc

   Func SkipFindWindow($iSetX, $iSetY)
	  Global $iLeftCorner=$iSetX
	  Global $iTopCorner=$iSetY
	  MouseClick($MOUSE_CLICK_LEFT, X(400), Y(-5), 1, 3)
	  Sleep(200)
   EndFunc

