; coords 120x903 = tip of health
While 1
    ;If Not WinActive("Path of Exile") Then ContinueLoop
    $pHealthColor = PixelGetColor(120, 903)
    If Not $pHealthColor = 9904425 Then
        ConsoleWrite("Health is not full: " & $pHealthColor & @CRLF)
        Send("1")
        Sleep(3000)
    
Else
    ConsoleWrite("Health is full: " & $pHealthColor & @CRLF)
    Sleep(1000)
endif

Wend
