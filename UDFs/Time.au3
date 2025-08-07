Func _GetCurrentTime12Hour()
    Local $hour = @HOUR
    Local $minute = @MIN
    Local $second = @SEC
    Local $suffix = "AM"

    If $hour >= 12 Then
        $suffix = "PM"
        If $hour > 12 Then $hour -= 12
    ElseIf $hour = 0 Then
        $hour = 12
    EndIf

    ; Ensure minutes and seconds are zero-padded
    Local $time = StringFormat("%02d:%02d:%02d%s", $hour, $minute, $second, $suffix)
    Return $time
EndFunc