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

M := cv.moments(cnt)
;M_ji 表示空间矩
;矩 m_00 给出了轮廓的区域，这等价于函数cv2.contourArea()。
m00 := M.m00
m10 := M.m10
m01 := M.m01
m20 := M.m20
m11 := M.m11
m02 := M.m02
m30 := M.m30
m21 := M.m21
m12 := M.m12
m03 := M.m03

;Mu_ji 表示中心矩
mu20 := M.mu20
mu11 := M.mu11
mu02 := M.mu02
mu30 := M.mu30
mu21 := M.mu21
mu12 := M.mu12
mu03 := M.mu03

;Nu_jl 表示归一化中心矩
nu20 := M.nu20
nu11 := M.nu11
nu02 := M.nu02
nu30 := M.nu30
nu21 := M.nu21
nu12 := M.nu12
nu03 := M.nu03

MsgBox("m00:  " m00 "`n" "m10:  " m10 "`n" 
        "m01:  " m01 "`n" "m20:  " m20 "`n" 
        "m11:  " m11 "`n" "m02:  " m02 "`n" 
        "m30:  " m30 "`n" "m21:  " m21 "`n"
        "m12:  " m12 "`n" "m03:  " m03 "`n"
        , "空间矩"
    )

MsgBox("mu20:  " mu20 "`n" "mu11:  " mu11 "`n" 
        "mu02:  " mu02 "`n" "mu30:  " mu30 "`n" 
        "mu21:  " mu21 "`n" "mu12:  " mu12 "`n" 
        "mu03:  " mu03 "`n"
        , "中心矩"
)

MsgBox("nu20:  " nu20 "`n" "nu11:  " nu11 "`n" 
        "nu02:  " nu02 "`n" "nu30:  " nu30 "`n" 
        "nu21:  " nu21 "`n" "nu12:  " nu12 "`n" 
        "nu03:  " nu03 "`n"
        , "归一化中心矩"
)

cx := Integer(M.m10/M.m00)
cy := Integer(M.m01/M.m00)

MsgBox "质心X:  " cx "`n" "质心Y:  " cy

cv.circle(img,ComArrayMake([cx,cy]), 3, ComArrayMake([0,0,255]), -1)

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