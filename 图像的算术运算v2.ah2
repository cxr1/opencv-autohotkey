;#Include opencv_ahk_lib.ahk
SetWorkingDir A_ScriptDir

hOpencv := DllCall("LoadLibrary", "str", "opencv_world455.dll", "ptr")
hOpencvCom := DllCall("LoadLibrary", "str", "autoit_opencv_com455.dll", "ptr")
DllCall("autoit_opencv_com455.dll\DllInstall", "int", 1, "wstr", A_IsAdmin = 0 ? "user" : "", "cdecl")

cv := ComObject("OpenCV.cv")
img1 := cv.imread("2.png")
img2 := cv.imread("11.png")

new_img := cv.addWeighted(img1, 0.8, img2, 0.2, 0)
cv.imshow("Image", new_img)
cv.waitKey()
cv.destroyAllWindows()