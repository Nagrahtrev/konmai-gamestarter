#Requires AutoHotkey v2.0
#SingleInstance

; ================= START =================
game := "ahk_class beatmania IIDX 31 EPOLIS main"
device := '"Analog Out 1/2"'
cpl := "ahk_exe BlackLionUsbAudioCpl.exe"
cpl_path := "C:\Program Files\Black Lion Audio\USB Audio Device Driver\x64\BlackLionUsbAudioCpl.exe"

magpie_sc := "!{F11}"

; ================= Audio Settings (Black Lion Audio Interface ) =================
Run(cpl_path)

if WinWait(cpl)
{
    WinActivate
    ; ControlChooseIndex 2, "SysTabControl321", cpl  ;; Sample Rate
    ; ControlChooseIndex 1, "ComboBox1", cpl  ;; 44100 Hz
    ControlChooseIndex 3, "SysTabControl321", cpl  ;; Buffer Size
    ControlChooseIndex 2, "ComboBox1", cpl  ;; 16 Samples
    Sleep 500
    WinClose(cpl)
    ; if WinWait("ahk_exe SoundID Reference.exe", , 3)
    ;     WinHide
}

; ================= Start Game =================
GroupAdd "console", "ahk_exe asphyxia-core-x64.exe"
GroupAdd "console", "ahk_exe spice64.exe ahk_class ConsoleWindowClass"

if !ProcessExist("Magpie.exe")
{
    Run "C:\Program Files\Magpie\Magpie.exe"
    if WinWait("ahk_exe Magpie.exe")
        WinClose
}

Run(A_ComSpec " /c C:\Windows\nircmd.exe setdefaultsounddevice " device)
Run A_ComSpec " /c displayswitch /internal"
Run "F:\KONAMI\IIDX\asphyxia-core\asphyxia-core-x64.exe"
Run "F:\KONAMI\IIDX\contents\spice64.exe", "F:\KONAMI\IIDX\contents"

if WinWait(game)
{
    if WinWait("ahk_group console")
        WinMinimize "ahk_group console"
    Sleep 1000
    WinActivate(game)
    if WinWaitActive(game)
        SendEvent magpie_sc
}

; ================= Exit Game =================
if WinWaitClose(game)
{
    WinClose "ahk_group console"
    Run(cpl_path)
    if WinWait(cpl)
    {
        ; ControlChooseIndex 2, "SysTabControl321", cpl  ;; Sample Rate
        ; ControlChooseIndex 2, "ComboBox1", cpl  ;; 48000 Hz
        ControlChooseIndex 3, "SysTabControl321", cpl  ;; Buffer Size
        ControlChooseIndex 7, "ComboBox1", cpl  ;; 512 Samples
        Sleep 500
        WinClose(cpl)
        ; if WinWait("ahk_exe SoundID Reference.exe")
        ;     WinHide
    }
    Run(A_ComSpec " /c G:\000_Gadgets\MultiMonitorTool\MultiMonitorTool.exe /enable 2 3")
    Run(A_ComSpec ' /c G:\000_Gadgets\MultiMonitorTool\MultiMonitorTool.exe /SetMonitors "Name=\\.\DISPLAY1 Primary=1 Width=3440 Height=1440 DisplayFrequency=120 PositionX=0 PositionY=0" "Name=\\.\DISPLAY2 Width=2560 Height=1440 DisplayFrequency=60 PositionX=455 PositionY=-1440" "Name=\\.\DISPLAY11 Width=2224 Height=1668 DisplayFrequency=60 PositionX=651 PositionY=1440"')
}

; ================= END =================
ExitApp
