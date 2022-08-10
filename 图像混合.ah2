SetWorkingDir A_ScriptDir

hOpencv := DllCall("LoadLibrary", "str", "opencv_world455.dll", "ptr")
hOpencvCom := DllCall("LoadLibrary", "str", "autoit_opencv_com455.dll", "ptr")
DllCall("autoit_opencv_com455.dll\DllInstall", "int", 1, "wstr", A_IsAdmin = 0 ? "user" : "", "cdecl")

cv := ComObject("OpenCV.cv")
mat := ComObject("OpenCV.cv.MAT")
img1 := cv.imread("2.png")
img2 := cv.imread("4.png")

arr := ComObjArray(VT_VARIANT:=12, 4)
arr[0] := 100  ;坐标
arr[1] := 300  ;坐标
arr[2] := img2.cols()
arr[3] := img2.rows()
roi := mat.create(img1, arr)

roi := cv.addWeighted(img2, 0.2, roi, 0.8, 0)
;new_img := cv.addWeighted(img1, 0.8, img2, 0.2, 0)
roi.copyTo(ComObject("OpenCV.cv.MAT").create(img1, arr))
cv.imshow("Image", img1)

cv.waitKey()
cv.destroyAllWindows()