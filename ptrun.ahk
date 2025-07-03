#SingleInstance, Force
SendMode Input

;-----------------------------------------;
; Winkey PowerToys Run                    ;
;-----------------------------------------;
; Use PowerToysRun as a replacement for Start Menu

LockKey := "Scrolllock"
; Important: Allows Win Key Hotkeys to work
LWin & ScrollLock::
Return

*LWin::SendInput, {Blind}{vk00}{Lwin Down} ; Added {Blind} so it doesn't force release keys to push down, just a safety precaution
Return

*LWin Up::
    if (!A_PriorKey = "LWin") { ; This code runs if user inputs a shortcut
        if GetKeyState("LWin" "P") {
            SendInput, {Blind}{vk00}{Lwin Down} ; If user still pressing win, stay down
        } Else {
            SendInput, {Blind}{vk00}{Lwin Up} ; Else, the release adds a null({vk00}) key to prevent the start menu from opening.
        }
        return
    }

    ;opening ptrun
    if (!WinActive("ahk_exe Microsoft.CmdPal.UI.exe") && !WinActive("ahk_exe PowerToys.PowerLauncher.exe")) {
        WinGetClass, windowClass, A
    	WinActivate, ahk_class Progman
    }
    ; closing ptrun
    else {
        WinActivate, ahk_class windowClass
        SendInput {vk00}{LWin Down}{%LockKey% Down}{vk00}{LWin Up}{%LockKey% Up} ; Launch PowerRun
        SendInput, {vk00}{LWin Up}
        return
    }
    SendInput {vk00}{LWin Down}{%LockKey% Down}{vk00}{LWin Up}{%LockKey% Up} ; Launch PowerRun
    SendInput, {vk00}{LWin Up}

    Return
