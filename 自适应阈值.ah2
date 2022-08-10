SetWorkingDir A_ScriptDir

hOpencv := DllCall("LoadLibrary", "str", "opencv_world455.dll", "ptr")
hOpencvCom := DllCall("LoadLibrary", "str", "autoit_opencv_com455.dll", "ptr")
DllCall("autoit_opencv_com455.dll\DllInstall", "int", 1, "wstr", A_IsAdmin = 0 ? "user" : "", "cdecl")

cv := ComObject("OpenCV.cv")

img := cv.imread("2.png")
img_grey := cv.cvtColor(img, CV_COLOR_BGR2GRAY:=6)
th := cv.adaptiveThreshold(img_grey, 255, CV_ADAPTIVE_THRESH_MEAN_C:=0, 0, 11, 2)

cv.imshow("Image", th)
cv.waitKey()
cv.destroyAllWindows()