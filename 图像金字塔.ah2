SetWorkingDir A_ScriptDir

hOpencv := DllCall("LoadLibrary", "str", "opencv_world455.dll", "ptr")
hOpencvCom := DllCall("LoadLibrary", "str", "autoit_opencv_com455.dll", "ptr")
DllCall("autoit_opencv_com455.dll\DllInstall", "int", 1, "wstr", A_IsAdmin = 0 ? "user" : "", "cdecl")

cv := ComObject("OpenCV.cv")
img := cv.imread("2.png")

Down := cv.pyrDown(img)
Down_up := cv.pyrUp(Down)

img_1 := cv.absdiff(img, Down_up)

cv.imshow("Image", img)
cv.imshow("Image1", img_1)
cv.waitKey()
cv.destroyAllWindows()