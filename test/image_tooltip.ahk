
#InstallKeyBDHook
#SingleInstance Force
;#NoTrayIcon
ScrollLock::
Suspend
Return

Capslock::
{
KeyWait, CapsLock, T.3
If errorlevel
{
SetCapsLockState Off
SplashImage, Off
run, %Image%
Sleep, 100
Clipboard =
Hotkey, MButton, Off
Sleep, 1500
Hotkey, MButton, On
Return
}
Else
{
SetCapsLockState, Off
}
KeyWait, CapsLock
}

Clipboard =
SplashImage, Off

MButton::
MouseGetPos,,,win
WinActivate, ahk_id %win%
Sleep, 50
Send {LButton Down}
Sleep, 50
Send {LButton Up}
Sleep, 50
Send {Mbutton Up}
{
KeyWait, MButton, T.175
If ErrorLevel
{
Send ^c
Clipwait 10
Image = %Clipboard%
Sleep, 100
SplashImage, %Image%, B
While GetKeyState("MButton","P")
{
}
SplashImage, Off
Clipboard =
}
Else
{
SplashImage, Off
Hotkey, MButton, Off
Send {MButton Down}
sleep, 10
send {MButton Up}
hotkey, MButton, On
}
KeyWait, MButton
}

KeyWait, Capslock, T120
If ErrorLevel
Return

