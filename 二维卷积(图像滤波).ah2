SetWorkingDir A_ScriptDir

hOpencv := DllCall("LoadLibrary", "str", "opencv_world455.dll", "ptr")
hOpencvCom := DllCall("LoadLibrary", "str", "autoit_opencv_com455.dll", "ptr")
DllCall("autoit_opencv_com455.dll\DllInstall", "int", 1, "wstr", A_IsAdmin = 0 ? "user" : "", "cdecl")

cv := ComObject("OpenCV.cv")
img := cv.imread("2.png")

kernel := cv.getStructuringElement(CV_MORPH_RECT:=0, ComArrayMake([1,2]))  ;CV_MORPH_RECT结构元素是矩形的
dst := cv.filter2D(img,-1,kernel)

cv.imshow("Original", img)
cv.imshow("Image", dst)
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