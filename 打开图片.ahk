#NoEnv ;不检查空变量是否为环境变量(建议所有新脚本使用)。
SendMode Input
;SendInput 和 SendPlay 与 Send 使用相同的语法, 但通常更快更可靠. 此外, 它们缓存了发送期间任何物理的键盘或鼠标活动, 这样避免了在发送时夹杂用户的键击。
SetWorkingDir %A_ScriptDir% ;让脚本无条件使用它所在的文件夹作为工作目录。
hOpencv := DllCall("LoadLibrary", "str", "opencv_world455.dll", "ptr")
MsgBox, % hOpencv
;预加载opencv_world455.dll，避免了 DllCall 内部每次调用 LoadLibrary 和 FreeLibrary 的需要， 预先明确装载它可以显著提高执行效率。
hOpencvCom := DllCall("LoadLibrary", "str", "autoit_opencv_com455.dll", "ptr") ;预加载autoit_opencv_com455.dll。
MsgBox, % hOpencvCom
DllCall("autoit_opencv_com455.dll\DllInstall", "int", 1, "wstr",  "", "cdecl")
cv := ComObjCreate("OpenCV.cv") ;创建 COM 对象。
img := cv.imread("2.png") ;img := cv.imread("2.png")等于img := cv.imread("2.png", 1) 这里的1就是默认参数
/*
读取图片,这里第二个参数的默认参数是1，也就是cv::IMREAD_COLOR = 1，读入一副彩色图片，忽略alpha通道。
cv.imread(filepath,flags)
filepath：要读入图片的完整路径。
flags：读入图片的标志。
cv::IMREAD_UNCHANGED = -1,  如果设置，则按原样返回加载的图像（使用Alpha通道，否则会被裁剪）
cv::IMREAD_GRAYSCALE = 0,  如果设置，则始终将图像转换为单通道灰度图像（编解码器内部转换）。
cv::IMREAD_COLOR = 1,  如果设置，请始终将图像转换为3通道BGR彩色图像。
cv::IMREAD_ANYDEPTH = 2,  如果设置，则在输入具有相应深度时返回16位/ 32位图像，否则将其转换为8位。
cv::IMREAD_ANYCOLOR = 4,  如果设置，则以任何可能的颜色格式读取图像。
cv::IMREAD_LOAD_GDAL = 8,  如果设置，使用gdal驱动程序加载图像
cv::IMREAD_REDUCED_GRAYSCALE_2 = 16,  如果设置，则始终将图像转换为单通道灰度图像，图像尺寸减小1/2。
cv::IMREAD_REDUCED_COLOR_2 = 17,  如果设置，则始终将图像转换为3通道BGR彩色图像，图像尺寸减小1/2。
cv::IMREAD_REDUCED_GRAYSCALE_4 = 32,  如果设置，则始终将图像转换为单通道灰度图像，图像尺寸减小1/4
cv::IMREAD_REDUCED_COLOR_4 = 33,  如果设置，则始终将图像转换为3通道BGR彩色图像，图像尺寸减小1/4
cv::IMREAD_REDUCED_GRAYSCALE_8 = 64,  如果设置，则始终将图像转换为单通道灰度图像，图像尺寸减小1/8。
cv::IMREAD_REDUCED_COLOR_8 = 65,  如果设置，则始终将图像转换为3通道BGR彩色图像，图像尺寸减小1/8。
cv::IMREAD_IGNORE_ORIENTATION = 128  如果设置，请不要根据EXIF的方向标志旋转图像。
cv.imread()函数是以多维数组形式存储的，此时得到的这个三维数组就是一个立方体，三维数组的第一维就是图片的高度，第二维是图片的宽度，第三维就是每个像素点在BGR通道的灰度值
cv.imread()的默认格式为bgr
cv.imread()的默认通道格式HWC
*/
cv.imshow("Image", img)
/*
cv.imshow(winname, mat)
cv.imshow()函数可以在窗口中显示图像。该窗口和图像的原始大小自适应（自动调整到原始尺寸）
winname:  一个窗口名称（也就是我们对话框的名称），它是一个字符串类型。第二个参数是我们的图像。您可以创建任意数量的窗口，但必须使用不同的窗口名称。
mat:  需要显示的图像
*/
cv.waitKey()
/*
cv.waitKey([, delay])
waitKey函数属于cv命名空间
一个int类型的参数，默认值为0，根据delay的名称可以猜测参数值是一个延时值
函数返回值为int类型
此函数的功能是等待一个按键按下
函数 Waitkey 在参数delay为正整数n时，延迟n毫秒,或者无限等待按键事件 (delay≤0时) 。由于操作系统在切换线程之间需要时间, 该函数不会等待完全延迟n ms, 它将等待至少延迟n ms, 这具体取决于当时计算机上运行的其他时间。如果在指定的时间之内没有按下键, 则返回按下的键或-1 的ascii码。函数的返回值是键盘按键键值的ascii码。
此函数是 HighGUI 中唯一可以提取和处理事件的方法, 因此需要定期调用它进行正常的事件处理, 除非在处理事件处理的环境中使用 HighGUI。
该函数仅在至少创建了一个 HighGUI 窗口并且该窗口处于活动状态时才有效。如果有多个 HighGUI 窗口, 则其中任何一个都可以处于活动状态。
延迟延迟以毫秒为单位。0是表示 "永远" 的特殊值。即参数值为0时，waitKey函数等待的时间是无限长。
waitKey函数是一个等待键盘事件的函数，参数值delay<=0时等待时间无限长，delay为正整数n时至少等待n毫秒的时间才结束。在等待的期间按下任意按键时函数结束，返回按键的键值（ascii码），等待时间结束仍未按下按键则返回-1。该函数用在处理HighGUI窗口程序，最常见的便是与显示图像窗口imshow函数搭配使用
*/
cv.destroyAllWindows() ;销毁所有 HighGUI 窗口。