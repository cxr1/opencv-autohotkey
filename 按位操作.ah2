SetWorkingDir A_ScriptDir

hOpencv := DllCall("LoadLibrary", "str", "opencv_world455.dll", "ptr")
hOpencvCom := DllCall("LoadLibrary", "str", "autoit_opencv_com455.dll", "ptr")
DllCall("autoit_opencv_com455.dll\DllInstall", "int", 1, "wstr", A_IsAdmin = 0 ? "user" : "", "cdecl")

cv := ComObject("OpenCV.cv")
img1 := cv.imread("test.png")
img2 := cv.imread("test.png")

cv.rectangle(img1,ComArrayMake([384, 50]),ComArrayMake([510, 178]),ComArrayMake([0, 100, 100]),-1)
cv.imshow("Image_1", img1)

cv.rectangle(img2,ComArrayMake([454, 130]),ComArrayMake([580, 258]),ComArrayMake([0, 0, 255]),-1)
cv.imshow("Image_2", img2)

or_img := cv.bitwise_or(img1, img2)
xor_img := cv.bitwise_xor(img1, img2)
and_img := cv.bitwise_and(img1, img2)
cv.imshow("Image_or", or_img) ;或
cv.imshow("Image_xor", xor_img) ;异或
cv.imshow("Image_and", and_img) ;与

not_img := cv.imread("2.png")
not_img := cv.bitwise_not(not_img)
cv.imshow("Image_not", not_img) ;非

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