#NoEnv
#Include opencv_ahk_lib.ahk
SendMode Input
SetWorkingDir %A_ScriptDir%

hOpencv := DllCall("LoadLibrary", "str", "opencv_world455.dll", "ptr")
hOpencvCom := DllCall("LoadLibrary", "str", "autoit_opencv_com455.dll", "ptr")
DllCall("autoit_opencv_com455.dll\DllInstall", "int", 1, "wstr", A_IsAdmin = 0 ? "user" : "", "cdecl")

cv := ComObjCreate("OpenCV.cv")
img := cv.imread("2.png")

border_default := ComObjCreate("OpenCV.cv.Mat")
border_default := cv.copyMakeBorder(img, 50, 50, 50, 50, 0, ComArrayMake([0, 0, 0]))

cv.imshow("11", border_default)
cv.waitkey()