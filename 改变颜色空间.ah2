SetWorkingDir A_ScriptDir

hOpencv := DllCall("LoadLibrary", "str", "opencv_world455.dll", "ptr")
hOpencvCom := DllCall("LoadLibrary", "str", "autoit_opencv_com455.dll", "ptr")
DllCall("autoit_opencv_com455.dll\DllInstall", "int", 1, "wstr", A_IsAdmin = 0 ? "user" : "", "cdecl")

cv := ComObject("OpenCV.cv")
img := cv.imread("2.png")

;https://docs.opencv.org/4.x/d8/d01/group__imgproc__color__conversions.html#gga4e0972be5de079fed4e3a10e24ef5ef0a353a4b8db9040165db4dacb5bcefb6ea

img_gray := cv.cvtColor(img, 6) ;cv::COLOR_BGR2GRAY = 6
img_hsv := cv.cvtColor(img, 40) ;cv::COLOR_BGR2HSV = 40
cv.imshow("Image_gray", img_gray)
cv.imshow("Image_hsv", img_hsv)

cv.waitKey()
cv.destroyAllWindows()