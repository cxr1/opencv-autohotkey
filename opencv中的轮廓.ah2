SetWorkingDir A_ScriptDir

hOpencv := DllCall("LoadLibrary", "str", "opencv_world455.dll", "ptr")
hOpencvCom := DllCall("LoadLibrary", "str", "autoit_opencv_com455.dll", "ptr")
DllCall("autoit_opencv_com455.dll\DllInstall", "int", 1, "wstr", A_IsAdmin = 0 ? "user" : "", "cdecl")

cv := ComObject("OpenCV.cv")
img := cv.imread("shape.jpg")
cv.imshow("Image", img)
img_ray := cv.cvtColor(img, CV_COLOR_BGR2GRAY:=6)
;这里获取threshold（）的双返回值有三种方法
; 一
; thresh_img := ComObject("OpenCV.cv.MAT")
; ret := cv.threshold(img_ray, 127, 255, CV_THRESH_BINARY:=0, thresh_img)
; contours := cv.findContours(thresh_img, CV_RETR_TREE:=3, CV_CHAIN_APPROX_SIMPLE:=2)

; 二
; ret := cv.threshold(img_ray, 127, 255, CV_THRESH_BINARY:=0)
; thresh_img := cv.extended()[1]
; contours := cv.findContours(thresh_img, CV_RETR_TREE:=3, CV_CHAIN_APPROX_SIMPLE:=2)

; 三
cv.threshold(img_ray, 100, 255, CV_THRESH_BINARY:=0)
ret := cv.extended()[0]
thresh_img := cv.extended()[1]

contours := cv.findContours(thresh_img, CV_RETR_TREE:=3, CV_CHAIN_APPROX_SIMPLE:=2)
hierarchy := cv.extended()[1]
cnt := contours[0]

;轮廓面积
area := cv.contourArea(cnt)
MsgBox "轮廓面积:  " area

;轮廓周长
perimeter := cv.arcLength(cnt, ComValue(0xB, -1)) ;第二个参数给了true
MsgBox perimeter

; 参数
; 在 cv.findContours() 函数中有三个参数，
; 第一个是源图像，
; 第二个是轮廓检索模式，
; 第三个是轮廓逼近方法，并输出轮廓和层次。
; 返回值
; contours：图像轮廓坐标，是一个链表
; hierarchy：[Next, Previous, First Child, Parent]
    ; 如果我们打印出cv.findContours()函数的返回值hierarchy，会发现它是一个包含4个值的数组：[Next, Previous, First Child, Parent]
    ; Next：与当前轮廓处于同一层级的下一条轮廓
    ; 举例来说，前面图中跟0处于同一层级的下一条轮廓是1，所以Next=1；同理，对轮廓1来说，Next=2；那么对于轮廓2呢？没有与它同一层级的下一条轮廓了，此时Next=-1。
    ; Previous：与当前轮廓处于同一层级的上一条轮廓
    ; 跟前面一样，对于轮廓1来说，Previous=0；对于轮廓2，Previous=1；对于轮廓2a，没有上一条轮廓了，所以Previous=-1。
    ; First Child：当前轮廓的第一条子轮廓
    ; 比如对于轮廓2，第一条子轮廓就是轮廓2a，所以First Child=2a；对轮廓3，First Child=3a。
    ; Parent：当前轮廓的父轮廓
    ; 比如2a的父轮廓是2，Parent=2；轮廓2没有父轮廓，所以Parent=-1。

cv.drawContours(img,contours, 0, ComArrayMake([0,0,255]), 3)
cv.imshow("Image1", img)
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