#NoEnv ;不检查空变量是否为环境变量(建议所有新脚本使用)。
SendMode Input
;SendInput 和 SendPlay 与 Send 使用相同的语法, 但通常更快更可靠. 此外, 它们缓存了发送期间任何物理的键盘或鼠标活动, 这样避免了在发送时夹杂用户的键击。
SetWorkingDir %A_ScriptDir% ;让脚本无条件使用它所在的文件夹作为工作目录。
hOpencv := DllCall("LoadLibrary", "str", "opencv_world455.dll", "ptr")
;预加载opencv_world455.dll，避免了 DllCall 内部每次调用 LoadLibrary 和 FreeLibrary 的需要， 预先明确装载它可以显著提高执行效率。
hOpencvCom := DllCall("LoadLibrary", "str", "autoit_opencv_com455.dll", "ptr") ;预加载autoit_opencv_com455.dll。
DllCall("autoit_opencv_com455.dll\DllInstall", "int", 1, "wstr", A_IsAdmin = 0 ? "user" : "", "cdecl")
cv := ComObjCreate("OpenCV.cv") ;创建 COM 对象。
cap := ComObjCreate("OpenCV.cv.VideoCapture") ;创建 COM 对象,后面要用到open()方法来打开摄像头
/*
在opencv中关于视频的读操作是通过VideoCapture类来完成的；关于视频的写操作是通过VideoWriter类来实现的。
VideoCapture既支持从视频文件(.avi ， .mpg格式)读取，也支持直接从摄像机(比如电脑自带摄像头)中读取。
*/
frame := ComObjCreate("OpenCV.cv.MAT") ;创建 COM 对象,后面将视频帧读取到Mat矩阵中
/*
默认构造函数，生成一个矩阵并由OpenCV提供的函数(一般是Mat::create() 和 cv::imread() )来分配储存空间。
Mat类可以分为两个部分：矩阵头和指向像素数据的矩阵指针
矩阵头 包括数字图像的矩阵尺寸、存储方法、存储地址和引用次数等，矩阵头的大小是一个常数，不会随着图像的大小而改变，
但是保存图像像素数据的矩阵则会随着图像的大小而改变，通常数据量会很大，比矩阵头大几个数量级。这样，在图像复制和传递过程中，
主要的开销是由存放图像像素的矩阵而引起的。因此，OpenCV使用了引用次数，当进行图像复制和传递时，不再复制整个Mat数据，而只是复制矩阵头和指向像素矩阵的指针
*/
cap.open(0) 
/*
bool VideoCapture::open(const string& filename);  
bool VideoCapture::open(int device);  
功能：打开一个视频文件或者打开一个捕获视频的设备（也就是摄像头）
参数:
filename – 打开的视频文件名。
device – 打开的视频捕获设备id ，如果只有一个摄像头可以填0，表示打开默认的摄像头。
*/
;result := cap.isOpened() ;为了程序的健壮性，我们一般在获取摄像头初始化之后，检验摄像头是否初始化成功。如果打开成功则返回布尔值true，反之为false

While True{ ;建立一个死循环不断的执行下面的操作
    ret := cap.read(frame) ;将视频帧读取到Mat矩阵中
    /*
    cap.read()按帧读取视频，ret是获cap.read()方法的两个返回值。
    ret就是每一帧的图像，是个三维矩阵。
    */
    img_grey := cv.cvtColor(frame, CV_COLOR_BGR2GRAY := 6) ;这里的参数为一和三，输出为img_grey
    /*
    第一个参数SRC:输入图像：8位无符号，16位无符号（CV_16UC ...）或单精度浮点。
    第二个参数DST:输出与src相同大小和深度的图像。
    第三个参数code:颜色空间转换的标识符，opencv cvtcolor支持的空间转发code放在下面文中
    第四个参数dstCn:目标图像的通道数，若该参数是0，表示目标图像取源图像的通道数
    */
    cv.imshow("Image", img_grey)
    /*
    cv.imshow(winname, mat)
    cv.imshow()函数可以在窗口中显示图像。该窗口和图像的原始大小自适应（自动调整到原始尺寸）
    winname:  一个窗口名称（也就是我们对话框的名称），它是一个字符串类型。第二个参数是我们的图像。您可以创建任意数量的窗口，但必须使用不同的窗口名称。
    mat:  需要显示的图像
    */
}
