SetWorkingDir A_ScriptDir

hOpencv := DllCall("LoadLibrary", "str", "opencv_world455.dll", "ptr")
hOpencvCom := DllCall("LoadLibrary", "str", "autoit_opencv_com455.dll", "ptr")
DllCall("autoit_opencv_com455.dll\DllInstall", "int", 1, "wstr", A_IsAdmin = 0 ? "user" : "", "cdecl")

cv := ComObject("OpenCV.cv")
out := ComObject("OpenCV.cv.MAT")
img := cv.imread("tubao.png")
cv.imshow("Image", img)
img_ray := cv.cvtColor(img, CV_COLOR_BGR2GRAY:=6)

cv.threshold(img_ray, 100, 255, CV_THRESH_BINARY:=0)
ret := cv.extended()[0]
thresh_img := cv.extended()[1]

contours := cv.findContours(thresh_img, CV_RETR_TREE:=3, CV_CHAIN_APPROX_SIMPLE:=2)
hierarchy := cv.extended()[1]
cnt := contours[0]

; epsilon := 0.01*cv.arcLength(cnt, ComValue(0xB, -1))
; approx := cv.approxPolyDP(cnt, epsilon, ComValue(0xB, -1))
hull := cv.convexHull(cnt)

hull1 := cv.convexHull(cnt,,, ComValue(0xB, 0))
defects := cv.convexityDefects(cnt,hull1)

loop(defects.rows)
	{
		r := A_Index
		loop(defects.cols)
		{
			c := A_Index
			loop(defects.channels)
			{
	
				f := numget(data, (r - 1) * (defects.cols * defects.channels * 4) + (c - 1) * defects.channels * 4 + (A_Index - 1) * 4  , "int")
				a .= f "-"
				if(A_Index == 3)
				{
					px := numget(cnt.data, f * 8, "Int") 
					py := numget(cnt.data, f * 8 + 4, "Int")
					MsgBox px py 
				}
			}
			a .= " | "
		}
		a .= "`n"
	}
ComArrayMake(inputArray)
{
	arr := ComObjArray(VT_VARIANT:=12, inputArray.Length)
	Loop inputArray.Length
	{
		arr[A_Index-1] := inputArray[A_Index]
	}
	return arr
}




	
; f := defects[0]
; f1 := defects[1]
; f2 := defects[2]
; f3 := defects[3]
; f4 := defects[4]
; f5 := defects[5]
; f6 := defects[6]
; f7 := defects[7]
; MsgBox f " " f1 " " f2 " " f3 "`n" f4 " " f5 " " f6 " " f7



; cv.circle(img,ComArrayMake([cnt[defects[f]],cnt[defects[f1]]]), 2, ComArrayMake([0,0,255]), -1)

cv.drawContours(img, ComArrayMake([hull]), 0, ComArrayMake([0,0,255]), 2)
cv.imshow("Image1", img)
cv.waitKey()
cv.destroyAllWindows()