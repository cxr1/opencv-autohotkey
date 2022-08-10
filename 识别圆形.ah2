SetWorkingDir A_ScriptDir

hOpencv := DllCall("LoadLibrary", "str", "opencv_world455.dll", "ptr")
hOpencvCom := DllCall("LoadLibrary", "str", "autoit_opencv_com455.dll", "ptr")
DllCall("autoit_opencv_com455.dll\DllInstall", "int", 1, "wstr", A_IsAdmin = 0 ? "user" : "", "cdecl")

cv := ComObject("OpenCV.cv")
img := cv.imread("new.png")

img_gray := cv.cvtColor(img, 6) ;cv::COLOR_BGR2GRAY = 6
circles := cv.HoughCircles(img_gray, 3, 1, 20, 50, 30, 0, 0)
loop  circles.MaxIndex() + 1
	{
	   data := circles[A_Index-1].data
	   loop  circles[A_Index-1].dims*circles[A_Index-1].rows
		  a .= numget(data+0, (A_Index-1)*4, "int") "-"
	   a := SubStr(a, 1, -1) "`n"
	}
	msgbox  a


;cv.circle(img,ComArrayMake([447,63]), 63, ComArrayMake([0,0,255]), -1)

cv.imshow("Image", img)
cv.imshow("Image_hsv", img_gray)


cv.waitKey()
cv.destroyAllWindows()
ComArrayMake(inputArray)
{
	arr := ComObjArray(VT_VARIANT:=12, inputArray.Length)
	Loop inputArray.Length
	{
		arr[A_Index-1] := inputArray[A_Index]
	}
	return arr
}