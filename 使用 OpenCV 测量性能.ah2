SetWorkingDir A_ScriptDir

hOpencv := DllCall("LoadLibrary", "str", "opencv_world455.dll", "ptr")
hOpencvCom := DllCall("LoadLibrary", "str", "autoit_opencv_com455.dll", "ptr")
DllCall("autoit_opencv_com455.dll\DllInstall", "int", 1, "wstr", A_IsAdmin = 0 ? "user" : "", "cdecl")

cv := ComObject("OpenCV.cv")
e1 := cv.getTickCount() ;返回参考事件（如机器开启时刻）到调用此函数的时钟周期数

;测试打开一张图片所需的时间
img2 := cv.imread("test.png")
cv.imshow("Image_2", img2)


e2 := cv.getTickCount()
time := 1000*(e2 - e1)/cv.getTickFrequency() ;返回时钟周期的频率，或每秒钟的时钟周期数
MsgBox time "毫秒"


;查看是否启用了优化，返回1则为是
s := cv.useOptimized()
MsgBox s

;禁用优化
cv.setUseOptimized(ComValue(0xB, 0))
s1 := cv.useOptimized()
MsgBox s1