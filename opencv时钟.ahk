#NoEnv
#Include opencv_ahk_lib.ahk
SendMode Input
SetWorkingDir %A_ScriptDir%
hOpencv := DllCall("LoadLibrary", "str", "opencv_world455.dll", "ptr")
hOpencvCom := DllCall("LoadLibrary", "str", "autoit_opencv_com455.dll", "ptr")
DllCall("autoit_opencv_com455.dll\DllInstall", "int", 1, "wstr", A_IsAdmin = 0 ? "admin" : "", "cdecl")
cv := ComObjCreate("OpenCV.cv")
global img := cv.imread("3.png")
margin   := 5
radius   := 220
center_x := 225
center_y := 225
cv.circle(img,OpencvAHK_Point([center_x,center_y]), radius, OpencvAHK_ConstScalar([0,0,0]), margin)
i := 1
Loop, 60{
    x1 := center_x + (radius - margin) * Cos(i*6*3.14/180)
    y1 := center_y + (radius - margin) * Sin(i*6*3.14/180)
    x2 := center_x + (radius - 15) * Cos(i*6*3.14/180)
    y2 := center_y + (radius - 15) * Sin(i*6*3.14/180)
    cv.line(img, OpencvAHK_Point([x1, y1]), OpencvAHK_Point([x2,y2]), OpencvAHK_ConstScalar([0,0,0]), 2)
    i += 1
}
i := 1
Loop, 12{
    x  := center_x + (radius - 5) * Cos(i*30*3.14/180)
    y  := center_y + (radius - 5) * Sin(i*30*3.14/180)
    x3 := center_x + (radius - 20) * Cos(i*30*3.14/180)
    y3 := center_x + (radius - 20) * Sin(i*30*3.14/180)
    cv.line(img, OpencvAHK_Point([x3, y3]), OpencvAHK_Point([x,y]), OpencvAHK_ConstScalar([0,0,0]), 5)
    i += 1
}
While, true{
    hour   := A_Hour
    minute := A_Min
    second := A_Sec
    temp   := img.copy()
    if (second <= 15)
        sec_angle := second*6+270
    Else
        sec_angle := (second-15)*6
    sec_x  := center_x + (radius - margin) * Cos(sec_angle*3.14/180)
    sec_y  := center_y + (radius - margin) * Sin(sec_angle*3.14/180)
    cv.line(temp, OpencvAHK_Point([225, 225]), OpencvAHK_Point([sec_x,sec_y]), OpencvAHK_ConstScalar([255,0,0]), 2)
    if (minute <= 15)
        min_angle := minute*6+270
    Else
        min_angle := (minute-15)*6
    min_x  := center_x + (radius - 35) * Cos(min_angle*3.14/180)
    min_y  := center_y + (radius - 35) * Sin(min_angle*3.14/180)
    cv.line(temp, OpencvAHK_Point([225, 225]), OpencvAHK_Point([min_x,min_y]), OpencvAHK_ConstScalar([0,255,0]), 8)
    if (hour <= 3)
        hour_angle := hour*30+270
    Else
        hour_angle := (hour-3)*30
    hour_x  := center_x + (radius - 75) * Cos(hour_angle*3.14/180)
    hour_y  := center_y + (radius - 75) * Sin(hour_angle*3.14/180)
    cv.line(temp, OpencvAHK_Point([225, 225]), OpencvAHK_Point([hour_x,hour_y]), OpencvAHK_ConstScalar([0,0,255]), 20)
    NumPut(Scale := 1, temp1 := 0, "double")
    time_str = %A_YYYY%/%A_MM%/%A_DD%
    cv.putText(temp, time_str, ComArrayMake([135, 275]), 0, Scale, ComArrayMake([0, 0, 0]), 2)
    cv.imshow("OpenCV clock", temp)
}
cv.waitKey()
cv.destroyAllWindows()