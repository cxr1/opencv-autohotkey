#NoEnv
SendMode Input
SetWorkingDir %A_ScriptDir%

hOpencv := DllCall("LoadLibrary", "str", "opencv_world455.dll", "ptr")
hOpencvCom := DllCall("LoadLibrary", "str", "autoit_opencv_com455.dll", "ptr")
DllCall("autoit_opencv_com455.dll\DllInstall", "int", 1, "wstr", A_IsAdmin = 0 ? "user" : "", "cdecl")

cv := ComObjCreate("OpenCV.cv")
img := cv.imread("test.png") ;读取图片

cv.line(img, ComArrayMake([0, 0]), ComArrayMake([511,511]), ComArrayMake([255,0,0]), 2) 
;画线
;img代表传入的图像，[0,0]代表起始点坐标，[511,511]代表结束点坐标，[255,0,0]代表颜色RGB值，2代表线或圆等的厚度。如果传 -1 就是像圆的闭合图形，它将填充形状。
cv.rectangle(img,ComArrayMake([384,0]),ComArrayMake([510,128]),ComArrayMake([0,255,0]),2)
;画矩形
cv.circle(img,ComArrayMake([447,63]), 63, ComArrayMake([0,0,255]), -1)
;画圆
cv.ellipse(img,ComArrayMake([256,256]),ComArrayMake([100,50]),0,0,180,255,-1)
;画椭圆

pts := ComObjCreate("OpenCV.VectorOfpoint")
pts.push_back(ComArrayMake([0, 45]))
pts.push_back(ComArrayMake([0, 135]))
pts.push_back(ComArrayMake([85, 175]))
pts.push_back(ComArrayMake([175, 135]))
pts.push_back(ComArrayMake([175, 45]))
pts.push_back(ComArrayMake([85, 0]))
cv.polylines(img, pts, ComObj(0xB, -1), ComArrayMake([0,255,255]), 2)
;画多边形

NumPut(Scale := 3, temp := 0, "double")
Scale := NumGet(temp, "double")
cv.putText(img, "Hello Opencv", ComArrayMake([50, 450]), 0, Scale, ComArrayMake([0, 0, 255]), 2)
;给图像加文字

cv.imwrite("new.png", img)

cv.imshow("Image", img) ;显示图片
cv.waitKey() ;等待按键输入，参数形式为ASCII 数值（例如a键为97）默认接收任意键
cv.destroyAllWindows() ;销毁所有opencv窗口

ComArrayMake(inputArray) ;这个函数用来转换参数，比如函数原来需要(0,0)，调用这个函数ComArrayMake([0,0])就可以转换过去
{
	arr := ComObjArray(VT_VARIANT:=12, inputArray.Length())
	Loop,% inputArray.Length()
	{
		arr[A_Index-1] := inputArray[A_Index]
	}
	return arr
}