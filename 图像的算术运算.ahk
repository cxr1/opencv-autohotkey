#NoEnv
#Include opencv_ahk_lib.ahk
SendMode Input
SetWorkingDir %A_ScriptDir%

hOpencv := DllCall("LoadLibrary", "str", "opencv_world455.dll", "ptr")
hOpencvCom := DllCall("LoadLibrary", "str", "autoit_opencv_com455.dll", "ptr")
DllCall("autoit_opencv_com455.dll\DllInstall", "int", 1, "wstr", A_IsAdmin = 0 ? "user" : "", "cdecl")

cv := ComObjCreate("OpenCV.cv")
img1 := cv.imread("2.png")
img2 := cv.imread("11.png")

sigma := 0.5
alfa := 1-sigma

new_img := cv.addWeighted(img1, sigma, img2, alfa, 0)
cv.imshow("Image", new_img)
cv.waitKey()
cv.destroyAllWindows()


; ;double类型
; OpencvAHK_double(Number)
; {
;     NumPut(num := Number, temp := 0, "double")
;     Return num := NumGet(temp, "double")
; }