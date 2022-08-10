SetWorkingDir A_ScriptDir

hOpencv := DllCall("LoadLibrary", "str", "opencv_world455.dll", "ptr")
hOpencvCom := DllCall("LoadLibrary", "str", "autoit_opencv_com455.dll", "ptr")
DllCall("autoit_opencv_com455.dll\DllInstall", "int", 1, "wstr", A_IsAdmin = 0 ? "user" : "", "cdecl")

cv := ComObject("OpenCV.cv")
img := cv.imread("2.png")
img_cat := cv.imread("cat.jpg")

;均值模糊
blur1 := cv.blur(img,ComArrayMake([5,5]))

;高斯模糊
blur2 := cv.GaussianBlur(img,ComArrayMake([5,5]),0)

;中值滤波
median := cv.medianBlur(img_cat,5)

;双边滤波
blur3 := cv.bilateralFilter(img,9,75,75)

cv.imshow("Original", img)
cv.imshow("Blurred1", blur1)
cv.imshow("Blurred2", blur2)
cv.imshow("Original_cat", img_cat)
cv.imshow("median", median)
cv.imshow("Blurred3", blur3)
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


