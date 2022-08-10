SetWorkingDir A_ScriptDir

hOpencv := DllCall("LoadLibrary", "str", "opencv_world455.dll", "ptr")
hOpencvCom := DllCall("LoadLibrary", "str", "autoit_opencv_com455.dll", "ptr")
DllCall("autoit_opencv_com455.dll\DllInstall", "int", 1, "wstr", A_IsAdmin = 0 ? "user" : "", "cdecl")

cv := ComObject("OpenCV.cv")

img := cv.imread("2.png")
img_grey := cv.cvtColor(img, CV_COLOR_BGR2GRAY:=6)
cv.threshold(img_grey, 100, 255, CV_THRESH_BINARY:=0, img)

cv.imshow("Image", img)
cv.waitKey()
cv.destroyAllWindows()