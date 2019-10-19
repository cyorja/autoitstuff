; To run:
; "C:\Program Files (x86)\AutoIt3\AutoIt3.exe" C:\Developer\AutoitScripts\simpleTest.au3

   ; Go first to skull island, and then home
   ;MouseMove (195, 588, 25) ; Place an X
   ;MouseClick ("left", 195, 588, 1, 0)
   MouseMove (26, 588, 25) ; Skull Island
   MouseClick ("left", 26, 588, 1, 0)
   Sleep(60000)
   MouseMove (152, 588, 25) ; Go to Home
   MouseClick ("left", 108, 588, 1, 0)
