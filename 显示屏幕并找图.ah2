#include Gdip_All.ahk
#include cv2.ah2
SetWorkingDir A_ScriptDir
cv := ComObject("OpenCV.cv")
mat := ComObject("OpenCV.cv.Mat")

e1 := cv.getTickCount() ;返回参考事件（如机器开启时刻）到调用此函数的时钟周期数
;需要查找的图片
img_tmpl := cv.imread("121.png")

wid := A_ScreenWidth
hei := A_ScreenHeight
pBits:=0x00000000
pToken := Gdip_StartUp()
chdc := CreateCompatibleDC(GetDC(0))
hbm := CreateDIBSection(wid, hei, chdc, 24, &pBits)
obm := SelectObject(chdc, hbm)
hhdc := GetDC(0)
BitBlt(chdc, 0, 0, wid, hei, hhdc, 0, 0, 0xCC0020)
val:= (wid * 3 + 3) & -4

img_haystack := mat.create(hei, wid, 16, pBits, val) 
img_haystack := cv.flip(img_haystack, 0)

img_display := img_haystack.copyTo()

;cv.TM_SQDIFF_NORMED  try other methods
method := cv2.CV_TM_SQDIFF_NORMED

res := cv.matchTemplate(img_haystack, img_tmpl, method)
cv.minMaxLoc(res)
exts := cv.extended

minVal := exts[0] ,maxVal := exts[1] ,minLoc := exts[2] ,maxLoc := exts[3]

if(method == cv2.CV_TM_SQDIFF || method == cv2.CV_TM_SQDIFF_NORMED)
    matchLoc := minLoc
else
	matchLoc := maxLoc

x := matchLoc[0]
y := matchLoc[1]

matchRect := ComArrayMake([matchLoc[0], matchLoc[1], img_tmpl.width, img_tmpl.height])
cv.rectangle(img_display, matchRect, ComArrayMake([0, 255, 0]), 2, 8, 0)
;cv.imshow("rest", img_display)

e2 := cv.getTickCount()
time := 1000*(e2 - e1)/cv.getTickFrequency() ;返回时钟周期的频率，或每秒钟的时钟周期数
MsgBox time "毫秒"

cv.waitKey()
cv.destroyAllWindows()
SelectObject(chdc, obm)
ReleaseDC(hhdc)    
DeleteObject(hbm)
DeleteDC(chdc)
Gdip_Shutdown(pToken)

ComArrayMake(inputArray)
{
	arr := ComObjArray(VT_VARIANT:=12, inputArray.Length)
	Loop inputArray.Length
	{
		arr[A_Index-1] := inputArray[A_Index]
	}
	return arr
}