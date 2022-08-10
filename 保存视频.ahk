;调用opencv录制视频并且保存为文件

#NoEnv
SendMode Input
SetWorkingDir %A_ScriptDir%

hOpencv := DllCall("LoadLibrary", "str", "opencv_world455.dll", "ptr")
hOpencvCom := DllCall("LoadLibrary", "str", "autoit_opencv_com455.dll", "ptr")
DllCall("autoit_opencv_com455.dll\DllInstall", "int", 1, "wstr", A_IsAdmin = 0 ? "user" : "", "cdecl")

cv  := ComObjCreate("OpenCV.cv")
cap := ComObjCreate("OpenCV.cv.VideoCapture")
out := ComObjCreate("OpenCV.cv.VideoWriter")
codec := out.fourcc(asc("M"), asc("J"), asc("P"), asc("G")) ;这里函数接收char类型数据，所以用Tebayaki建议的asc()函数

NumPut(fps := 30, temp := 0, "double")
fps := NumGet(temp, "double")

; msgbox, % type(fps)

; type(v) {
;     if IsObject(v)
; 	{
; 		if ObjGetCapacity(v)>ObjCount(v)
; 			return "associative array"
; 		else
; 			return "array"
; 	}
;     return v="" || [v].GetCapacity(1) ? "String" : InStr(v,".") ? "Float" : "Integer"
; }

out.open("output.avi", codec, fps, ComArrayMake([640,480]), ComObj(0xB, -1))
frame := ComObjCreate("OpenCV.cv.MAT")
cap.open(0)

ComArrayMake(inputArray)
{
	arr := ComObjArray(VT_VARIANT:=12, inputArray.Length())
	Loop,% inputArray.Length()
	{
		arr[A_Index-1] := inputArray[A_Index]
	}
	return arr
}

While cap.isOpened(){
    ret := cap.read(frame)
	if ret{
		frame := cv.flip(frame, 1) ;0为翻转180度，1不翻转
		out.write(frame)
		cv.imshow("frame", frame)
	}
}
cap.release()
out.release()
cv.destroyAllWindows()