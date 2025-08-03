; Replace with actual process name
Local $processName = "PathOfExile.exe"
Local $processID = ProcessExists($processName)

If $processID = 0 Then
    MsgBox(0, "Error", "Process not found!")
    Exit
EndIf

; Open process with read permissions
Local $hProcess = DllCall("kernel32.dll", "handle", "OpenProcess", _
    "dword", 0x10, _ ; PROCESS_VM_READ
    "int", False, _
    "dword", $processID)

If @error Or Not $hProcess[0] Then
    MsgBox(0, "Error", "Failed to open process.")
    Exit
EndIf

; Define address to read (must be known & valid)
Local $address = 0x28712785EB8 ; Change this!
Local $buffer = DllStructCreate("int")

Local $read = DllCall("kernel32.dll", "int", "ReadProcessMemory", _
    "handle", $hProcess[0], _
    "ptr", $address, _
    "ptr", DllStructGetPtr($buffer), _
    "dword", DllStructGetSize($buffer), _
    "dword*", 0)

If $read[0] Then
    MsgBox(0, "Value Read", DllStructGetData($buffer, 1))
Else
    MsgBox(0, "Error", "Failed to read memory.")
EndIf

; Close handle
DllCall("kernel32.dll", "int", "CloseHandle", "handle", $hProcess[0])
