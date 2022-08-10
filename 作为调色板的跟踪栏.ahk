#NoEnv
#Include opencv_ahk_lib.ahk
SendMode Input
SetWorkingDir %A_ScriptDir%

hOpencv := DllCall("LoadLibrary", "str", "opencv_world455.dll", "ptr")
hOpencvCom := DllCall("LoadLibrary", "str", "autoit_opencv_com455.dll", "ptr")
DllCall("autoit_opencv_com455.dll\DllInstall", "int", 1, "wstr", A_IsAdmin = 0 ? "user" : "", "cdecl")

cv := ComObjCreate("OpenCV.cv")
global img := cv.imread("2.png") ;读取图片

global rows := img.rows()
global cols := img.cols()

cv.namedWindow("Image")
global r := 0
global g := 0
global b := 0
VarSetCapacity(r, 8)
VarSetCapacity(g, 8)
VarSetCapacity(b, 8)
callback_R := RegisterCallback("TheFunc_R", "CDecl")
callback_G := RegisterCallback("TheFunc_G", "CDecl")
callback_B := RegisterCallback("TheFunc_B", "CDecl")

DllCall("opencv_world455.dll\cvCreateTrackbar", "Astr", "R", "Astr", "Image", "ptr", &r, "int", 255,"ptr", callback_R)
DllCall("opencv_world455.dll\cvCreateTrackbar", "Astr", "G", "Astr", "Image", "ptr", &g, "int", 255,"ptr", callback_G)
DllCall("opencv_world455.dll\cvCreateTrackbar", "Astr", "B", "Astr", "Image", "ptr", &b, "int", 255,"ptr", callback_B)

TheFunc_R(v_a, v_b){
    global sR := NumGet(r, 0, "int")
}
TheFunc_G(v_a, v_b){
    global sG := NumGet(g, 0, "int")
}
TheFunc_B(v_a, v_b){
    global sB := NumGet(b, 0, "int")
}

While true{
    sR := NumGet(r, 0, "int")
    sG := NumGet(g, 0, "int")
    sB := NumGet(b, 0, "int")
    cv.imshow("Image", img)
    loop, % rows{
    index_rows := A_Index
    loop, % cols{
        index_cols := A_Index
        img.Vec3b_set_at(index_rows - 1, index_cols - 1, ComArrayMake([sB, sG, sR]))
    }
}

}



cv.waitkey()
cv.destroyAllWindows()