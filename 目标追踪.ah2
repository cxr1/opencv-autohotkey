SetWorkingDir A_ScriptDir

hOpencv := DllCall("LoadLibrary", "str", "opencv_world455.dll", "ptr")
hOpencvCom := DllCall("LoadLibrary", "str", "autoit_opencv_com455.dll", "ptr")
DllCall("autoit_opencv_com455.dll\DllInstall", "int", 1, "wstr", A_IsAdmin = 0 ? "user" : "", "cdecl")

cv := ComObject("OpenCV.cv")
cap := ComObject("OpenCV.cv.VideoCapture")
frame := ComObject("OpenCV.cv.MAT")

cap.open(0)

While True{
    ret := cap.read(frame)
    img_hsv := cv.cvtColor(frame, 40)
    lower_blue := ComArrayMake([110, 50, 50])
    upper_blue := ComArrayMake([130, 255, 255])
    mask := cv.inrange(img_hsv, lower_blue, upper_blue)
    res := cv.bitwise_and(frame, frame, mask := mask)
    cv.imshow("frame", frame)
    cv.imshow("mask", mask)
    cv.imshow("res", res)
}

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