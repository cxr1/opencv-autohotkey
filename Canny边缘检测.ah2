SetWorkingDir A_ScriptDir

hOpencv := DllCall("LoadLibrary", "str", "opencv_world455.dll", "ptr")
hOpencvCom := DllCall("LoadLibrary", "str", "autoit_opencv_com455.dll", "ptr")
DllCall("autoit_opencv_com455.dll\DllInstall", "int", 1, "wstr", A_IsAdmin = 0 ? "user" : "", "cdecl")

cv := ComObject("OpenCV.cv")
img := cv.imread("12.png", 0)
edges := cv.Canny(img, 100, 100)

cv.imshow("Image", img)
cv.imshow("edges_Image", edges)
cv.waitKey()
cv.destroyAllWindows()