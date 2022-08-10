SetWorkingDir A_ScriptDir

hOpencv := DllCall("LoadLibrary", "str", "opencv_world455.dll", "ptr")
hOpencvCom := DllCall("LoadLibrary", "str", "autoit_opencv_com455.dll", "ptr")
DllCall("autoit_opencv_com455.dll\DllInstall", "int", 1, "wstr", A_IsAdmin = 0 ? "user" : "", "cdecl")

cv := ComObject("OpenCV.cv")
img1 := cv.imread("2.png")
img2 := cv.imread("11.png")

add_img := cv.Add(img2, img1)
cv.imshow("Image1", add_img)

cv.waitKey()
cv.destroyAllWindows()