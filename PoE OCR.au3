#include "./UDFs/Tesseract.au3"
_TesseractTempPathSet(@ScriptDir & "\temp")
Sleep(5000)
$Test = _TesseractScreenCapture()
ConsoleWrite("Test: " & $Test & @CRLF)