#NoEnv
SendMode Input
SetWorkingDir %A_ScriptDir%

hOpencv := DllCall("LoadLibrary", "str", "opencv_world455.dll", "ptr")
hOpencvCom := DllCall("LoadLibrary", "str", "autoit_opencv_com455.dll", "ptr")
DllCall("autoit_opencv_com455.dll\DllInstall", "int", 1, "wstr", A_IsAdmin = 0 ? "user" : "", "cdecl")

global cv := ComObjCreate("OpenCV.cv")
img := cv.imread("test.png") ;读取图片
global showImg := img.clone()
cv.namedWindow("Image")
proc := RegisterCallback("drawcircle", "F")
DllCall("opencv_world455.dll\cvSetMouseCallback", "Astr", "Image", "ptr", proc, "ptr", 0)

drawcircle(event, x, y, flag, param){
    ToolTip, % event "`n" x " " y "`n" flag
    If (event == 1){ ;鼠标左键按下
        cv.circle(showImg, ComArrayMake([x,y]), 100, ComArrayMake([255,0,0]), 0) ;画圆
    }
}

While true{
    cv.imshow("Image", showImg)
}

ComArrayMake(inputArray) ;这个函数用来转换参数，比如函数原来需要(0,0)，调用这个函数ComArrayMake([0,0])就可以转换过去
{
	arr := ComObjArray(VT_VARIANT:=12, inputArray.Length())
	Loop,% inputArray.Length()
	{
		arr[A_Index-1] := inputArray[A_Index]
	}
	return arr
}