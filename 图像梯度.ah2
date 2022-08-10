SetWorkingDir A_ScriptDir

hOpencv := DllCall("LoadLibrary", "str", "opencv_world455.dll", "ptr")
hOpencvCom := DllCall("LoadLibrary", "str", "autoit_opencv_com455.dll", "ptr")
DllCall("autoit_opencv_com455.dll\DllInstall", "int", 1, "wstr", A_IsAdmin = 0 ? "user" : "", "cdecl")

cv := ComObject("OpenCV.cv")
img := cv.imread("td.png",0)

;核函数的取值范围：1，3，5，7，9
laplacian := cv.Laplacian(img,CV_16U:=2,ksize:=3)
laplacian := cv.convertScaleAbs(laplacian)

;核函数的取值范围：1，3，5，7，9
sobelx := cv.Sobel(img,CV_8U:=0,1,0,ksize:=3)
sobely := cv.Sobel(img,CV_8U:=0,0,1,ksize:=3)

;边缘检测
sobel_X := cv.convertScaleAbs(sobelx)
sobel_Y := cv.convertScaleAbs(sobely)
scharr := cv.addWeighted(sobel_X, 0.5, sobel_Y, 0.5, 0)

cv.imshow("Image", img)
cv.imshow("Image1", laplacian)
cv.imshow("Image2", scharr)
cv.imshow("Image3", sobelx)
cv.imshow("Image4", sobely)
cv.waitKey()
cv.destroyAllWindows()