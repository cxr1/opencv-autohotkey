#NoEnv
SendMode Input
SetWorkingDir %A_ScriptDir%

hOpencv := DllCall("LoadLibrary", "str", "opencv_world455.dll", "ptr")
hOpencvCom := DllCall("LoadLibrary", "str", "autoit_opencv_com455.dll", "ptr")
DllCall("autoit_opencv_com455.dll\DllInstall", "int", 1, "wstr", A_IsAdmin = 0 ? "user" : "", "cdecl")

cv := ComObjCreate("OpenCV.cv")
cap := ComObjCreate("OpenCV.cv.VideoCapture")
frame := ComObjCreate("OpenCV.cv.MAT")
cap.open("test001.avi")

istrue := cap.isOpened() ;返回布尔值，成功打开时值为true，反之为false
;MsgBox, % istrue
While istrue{
    ret := cap.read(frame)
    img_gray := cv.cvtColor(frame, CV_COLOR_BGR2GRAY := 6)
    cv.imshow("Image", img_gray)
}