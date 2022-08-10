SetWorkingDir A_ScriptDir

hOpencv := DllCall("LoadLibrary", "str", "opencv_world455.dll", "ptr")
hOpencvCom := DllCall("LoadLibrary", "str", "autoit_opencv_com455.dll", "ptr")
;DllCall("autoit_opencv_com455.dll\DllInstall", "int", 1, "wstr", A_IsAdmin = 0 ? "user" : "", "cdecl")

cv := ComObject("OpenCV.cv")
t_mat := ComObject("OpenCV.cv.MAT")
point2f0 := ComObject("OpenCV.VectorOfPoint2f")
point2f1 := ComObject("OpenCV.VectorOfPoint2f")
point2f2 := ComObject("OpenCV.VectorOfPoint2f")
point2f3 := ComObject("OpenCV.VectorOfPoint2f")

img := cv.imread("2.png")

;缩放
;img_resize := cv.resize(img, ComArrayMake([150, 150]))
img_resize := cv.resize(img, ComArrayMake([0, 0]), 0.5, 0.3, 2) ;如果第二个参数都为0，则按比例缩放,最后一个参数cv::INTER_CUBIC = 2

;平移变换
t_mat := t_mat.zeros(2, 3, 5)
t_mat.float_set_at(0, 0, 1)
t_mat.float_set_at(0, 2, 50)
t_mat.float_set_at(1, 1, 1)
t_mat.float_set_at(1, 2,50)
img_warpAffine := cv.warpAffine(img, t_mat, img.size())

;旋转
rows := img.rows()
cols := img.cols()
m0 := cv.getRotationMatrix2D(ComArrayMake([(cols-1)/2,(rows-1)/2]),90,1)
img_revolve := cv.warpAffine(img, m0, img.size())

;仿射变换
point2f0.push_back(ComArrayMake([0, 0]))
point2f0.push_back(ComArrayMake([cols-1, 0]))
point2f0.push_back(ComArrayMake([0, rows-1]))

point2f1.push_back(ComArrayMake([10, 100]))
point2f1.push_back(ComArrayMake([200, 50]))
point2f1.push_back(ComArrayMake([100, 200]))
m1 := cv.getAffineTransform(point2f0, point2f1)
img_getAffine := cv.warpAffine(img, m1, img.size())

;透视变换
point2f2.push_back(ComArrayMake([40, 50]))
point2f2.push_back(ComArrayMake([100, 190]))
point2f2.push_back(ComArrayMake([200, 50]))
point2f2.push_back(ComArrayMake([300, 190]))

point2f3.push_back(ComArrayMake([50, 60]))
point2f3.push_back(ComArrayMake([120, 200]))
point2f3.push_back(ComArrayMake([200, 50]))
point2f3.push_back(ComArrayMake([300, 190]))
m2 := cv.getPerspectiveTransform(point2f2, point2f3)
img_getPerspective := cv.warpPerspective(img, m2, img.size())


cv.imshow("Image", img)
cv.imshow("Image_resize", img_resize)
cv.imshow("Image_warpAffine", img_warpAffine)
cv.imshow("Img_revolve", img_revolve)
cv.imshow("img_getAffine", img_getAffine)
cv.imshow("img_getPerspective", img_getPerspective)

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