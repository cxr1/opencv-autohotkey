#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
; register com
hOpencv := DllCall("LoadLibrary", "str", "opencv_world455.dll", "ptr")
hOpencvCom := DllCall("LoadLibrary", "str", "autoit_opencv_com455.dll", "ptr")
DllCall("autoit_opencv_com455.dll\DllInstall", "int", 1, "wstr", A_IsAdmin = 0 ? "user" : "", "cdecl")

cv := ComObjCreate("OpenCV.cv")
mat := ComObjCreate("OpenCV.cv.Mat")
img := cv.imread("2.png")
img_grey := cv.cvtColor(img, CV_COLOR_BGR2GRAY := 6)
cv.threshold(img_grey, 127, 255, CV_THRESH_BINARY := 0)
thresh := cv.extended.1
contours := cv.findContours(thresh, CV_RETR_TREE := 3, CV_CHAIN_APPROX_SIMPLE := 2)
arr := ComObjArray(VT_VARIANT := 12, 4) 
arr[0] := 0
arr[1] := 0
arr[2] := 255
arr[3] := 0
cv.drawContours(img, contours, -1, arr, 2)

For k,v in contours{
    i := cv.boundingRect(k)
    x := i[0]
    y := i[1]
    w := i[2]
    h := i[3]
    img := cv.rectangle(img
    , ComArrayMake([x, y])
	, ComArrayMake([x + w, y + h])
	, ComArrayMake([255, 0, 0])
	, 2)
}

ComArrayMake(inputArray)
{
	arr := ComObjArray(VT_VARIANT:=12, inputArray.Length())
	Loop,% inputArray.Length()
	{
		arr[A_Index-1] := inputArray[A_Index]
	}
	return arr
}
;MsgBox, x%x%,y%y%,w%w%,h%h%



;cv.boundingRect(img_grey)
cv.imshow("Image", img)
cv.waitKey()
cv.destroyAllWindows()