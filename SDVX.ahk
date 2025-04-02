#Requires AutoHotkey v2.0
#SingleInstance

; ================= START =================
game := 'ahk_class SOUND VOLTEX EXCEED GEAR - Main Screen'
device := '"Analog Out 1/2"'

engIME_sc := '^0'

; ================= Start Game =================
GroupAdd 'console', 'ahk_exe asphyxia-core-x64.exe'
GroupAdd 'console', 'ahk_exe spice64.exe ahk_class ConsoleWindowClass'

Run(A_ComSpec ' /c C:\Windows\nircmd.exe setdefaultsounddevice ' device)
Run A_ComSpec ' /c displayswitch /internal'
Run 'F:\KONAMI\SDVX\asphyxia-core\asphyxia-core-x64.exe'
Run 'F:\KONAMI\SDVX\contents\spice64.exe', 'F:\KONAMI\SDVX\contents'

if WinWait(game) {
    if WinWait('ahk_group console')
        WinMinimize 'ahk_group console'
    Sleep 500
    WinActivate(game)
    if WinWaitActive(game)
        SendEvent engIME_sc
}

; ================= Exit Game =================
if WinWaitClose(game) {
    WinClose 'ahk_group console'
    Run(A_ComSpec ' /c G:\000_Gadgets\MultiMonitorTool\MultiMonitorTool.exe /enable 2 3')
    Run(A_ComSpec ' /c G:\000_Gadgets\MultiMonitorTool\MultiMonitorTool.exe /SetMonitors "Name=\\.\DISPLAY1 Primary=1 Width=3440 Height=1440 DisplayFrequency=120 PositionX=0 PositionY=0" "Name=\\.\DISPLAY2 Width=2560 Height=1440 DisplayFrequency=60 PositionX=455 PositionY=-1440" "Name=\\.\DISPLAY11 Width=2224 Height=1668 DisplayFrequency=60 PositionX=651 PositionY=1440"')
}

; ================= END =================
ExitApp
