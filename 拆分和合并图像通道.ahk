#NoEnv
#Include opencv_ahk_lib.ahk
SendMode Input
hOpencv := DllCall("LoadLibrary", "str", "opencv_world455.dll", "ptr")
hOpencvCom := DllCall("LoadLibrary", "str", "autoit_opencv_com455.dll", "ptr")
DllCall("autoit_opencv_com455.dll\DllInstall", "int", 1, "wstr", A_IsAdmin = 0 ? "user" : "", "cdecl")

cv := ComObjCreate("OpenCV.cv")
new_img := ComObjCreate("OpenCV.cv.Mat")
img := cv.imread("2.png")

;cv.namedWindow("Image")
cv.imshow("Image", img)

;拆分图像通道
mv := ComObjCreate("OpenCV.VectorOfMat")
cv.split(img, mv)


cv.imshow("Image_B", mv.at(0))
cv.imshow("Image_G", mv.at(1))
cv.imshow("Image_R", mv.at(2))

;拆分后直接合并图像通道到新矩阵
cv.merge(mv, new_img)
cv.imshow("new_img", new_img)


;把B通道全部置为0，然后合并
newaddchannel := mv.at(0).clone()    
newaddchannel.setTo(ComArrayMake([0]))

new_channels := ComObjCreate("OpenCV.VectorOfMat")
new_channels.push_back(newaddchannel)
new_channels.push_back(mv.at(1))
new_channels.push_back(mv.at(2))
mergedImage := ComObjCreate("OpenCV.cv.Mat")
mergedImage := cv.merge(new_channels, mergedImage)
cv.imshow("hebin", mergedImage)


cv.waitkey()
cv.destroyAllWindows()