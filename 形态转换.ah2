SetWorkingDir A_ScriptDir

hOpencv := DllCall("LoadLibrary", "str", "opencv_world455.dll", "ptr")
hOpencvCom := DllCall("LoadLibrary", "str", "autoit_opencv_com455.dll", "ptr")
DllCall("autoit_opencv_com455.dll\DllInstall", "int", 1, "wstr", A_IsAdmin = 0 ? "user" : "", "cdecl")

cv := ComObject("OpenCV.cv")
img := cv.imread("j.png")
img_1 := cv.imread("j_1.png")
img_2 := cv.imread("j_2.png")

;腐蚀
kernel := cv.getStructuringElement(CV_MORPH_RECT:=0, ComArrayMake([5,5]))  ;CV_MORPH_RECT结构元素是矩形的
erosion := cv.erode(img,kernel)

;膨胀
dilation := cv.dilate(img,kernel)

;开运算
opening := cv.morphologyEx(img_1, CV_MORPH_OPEN:=2, kernel)

;闭运算
closing := cv.morphologyEx(img_2, CV_MORPH_CLOSE:=3, kernel)

;形态梯度
gradient := cv.morphologyEx(img, CV_MORPH_GRADIENT:=4, kernel)

;顶帽
kernel_1 := cv.getStructuringElement(CV_MORPH_RECT:=0, ComArrayMake([9,9]))
tophat := cv.morphologyEx(img, CV_MORPH_TOPHAT:=5, kernel_1)

;黑帽
blackhat := cv.morphologyEx(img, CV_MORPH_BLACKHAT:=6, kernel_1)

cv.imshow("Original", img)
; cv.imshow("erosion", erosion)
; cv.imshow("dilation", dilation)
; cv.imshow("Original_1", img_1)
; cv.imshow("opening", opening)
; cv.imshow("Original_2", img_2)
; cv.imshow("closing", closing)
; cv.imshow("gradient", gradient)
; cv.imshow("tophat", tophat)
cv.imshow("blackhat", blackhat)

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