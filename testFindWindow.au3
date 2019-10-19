#include <Misc.au3>
#include <MsgBoxConstants.au3>
#include <GUIConstantsEx.au3>
#include "MouseOnEvent.au3"

HotKeySet("{ESC}", "_Quit")

Global $iMouseX = -1
Global $iMouseY = -1

   Func MousePrimaryUp_Event()
	  ToolTip("Mouse Button Detected")
	  $iMouseX = MouseGetPos(0)
	  $iMouseY = MouseGetPos(1)
	  _MouseSetOnEvent($MOUSE_PRIMARYUP_EVENT)
   EndFunc

_MouseSetOnEvent($MOUSE_PRIMARYUP_EVENT, "MousePrimaryUp_Event")

While Not _IsPressed("1B") And $iMouseX=-1
   Sleep(100)
; User must click on the title bar of the window
;   Local $bMousePressed = false
;   If _IsPressed('01') Then
;	  $bMousePressed = true
;   EndIf
;   If $bMousePressed  And Not _IsPressed('01') Then
;	  $iMouseX = MouseGetPos(0)
;	  $iMouseY = MouseGetPos(1)
;	  MsgBox($MB_SYSTEMMODAL, "Test", "Mouse clicked at (" & $iMouseX & ", " & $iMouseY &")="&PixelGetColor($iMouseX, $iMouseY) )
;  EndIf

WEnd
MsgBox($MB_SYSTEMMODAL, "Test", "Mouse clicked at (" & $iMouseX & ", " & $iMouseY &")="&PixelGetColor($iMouseX, $iMouseY) )

; Determine the coordinates of the title bar top/bottom of the window
Local $iBarColor = PixelGetColor($iMouseX, $iMouseY)
; Commented out. Don't need top
;Local $iTop = $iMouseY
;While $iTop>0 And PixelGetColor($iMouseX, $iTop-1)=$iBarColor
;   $iTop=$iTop-1
;WEnd
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
MsgBox($MB_SYSTEMMODAL, "Find Window", "Corner="&$iTop&",Bottom="&$iBottom&",Left="&$iLeft)



