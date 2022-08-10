#NoEnv ;不检查空变量是否为环境变量(建议所有新脚本使用)。
#Include opencv_ahk_lib.ahk
SendMode Input
hOpencv := DllCall("LoadLibrary", "str", "opencv_world455.dll", "ptr")
hOpencvCom := DllCall("LoadLibrary", "str", "autoit_opencv_com455.dll", "ptr")
DllCall("autoit_opencv_com455.dll\DllInstall", "int", 1, "wstr", A_IsAdmin = 0 ? "user" : "", "cdecl")

cv := ComObjCreate("OpenCV.cv") ;创建 COM 对象。
img := cv.imread("2.png") ;img := cv.imread("2.png")等于img := cv.imread("2.png", 1) 这里的1就是默认参数

;图像宽度 矩阵的行数
rows := img.rows()

;图像高度 矩阵的列数
cols := img.cols()

;矩阵元素拥有的通道数，例如常见的彩色图像，每一个像素由RGB三部分组成，则channels = 3
channels := img.channels()

;访问中心点像素值
B := img.Vec3b_at(rows/2, cols/2)[0]
G := img.Vec3b_at(rows/2, cols/2)[1]
R := img.Vec3b_at(rows/2, cols/2)[2]
MsgBox, 宽度：%rows%`n高度：%cols%`n颜色通道数：%channels%`nB通道颜色值：%B%`nG通道颜色值：%G%`nR通道颜色值：%R%

;uchar型的指针。Mat类分为了两个部分:矩阵头和指向矩阵数据部分的指针，data就是指向矩阵数据的指针。
data := img.data()

;矩阵的维度，例如5*6矩阵是二维矩阵，则dims=2，三维矩阵dims=3.
dims := img.dims()

;矩阵的大小，size(cols,rows),如果矩阵的维数大于2，则是size(-1,-1)
size_cols := img.size()[0]
size_rows := img.size()[1]

;下面的几个属性是和Mat中元素的数据类型相关的。

type := img.type()
;表示了矩阵中元素的类型以及矩阵的通道个数，它是一系列的预定义的常量，其命名规则为CV_(位数）+（数据类型）+（通道数）。具体的有以下值：
; CV_8UC1	CV_8UC2	    CV_8UC3	    CV_8UC4
; CV_8SC1	CV_8SC2	    CV_8SC3	    CV_8SC4
; CV_16UC1	CV_16UC2	CV_16UC3	CV_16UC4
; CV_16SC1	CV_16SC2	CV_16SC3	CV_16SC4
; CV_32SC1	CV_32SC2	CV_32SC3	CV_32SC4
; CV_32FC1	CV_32FC2	CV_32FC3	CV_32FC4
; CV_64FC1	CV_64FC2	CV_64FC3	CV_64FC4
; 这里U（unsigned integer）表示的是无符号整数，S（signed integer）是有符号整数，F（float）是浮点数。
; 例如：CV_16UC2，表示的是元素类型是一个16位的无符号整数，通道为2.
; C1，C2，C3，C4则表示通道是1,2,3,4
; type一般是在创建Mat对象时设定，如果要取得Mat的元素类型，则无需使用type，使用下面的depth
depth := img.depth()
; 矩阵中元素的一个通道的数据类型，这个值和type是相关的。例如 type为 CV_16SC2，一个2通道的16位的有符号整数。那么，depth则是CV_16S。depth也是一系列的预定义值，
; 将type的预定义值去掉通道信息就是depth值:
; CV_8U CV_8S CV_16U CV_16S CV_32S CV_32F CV_64F
elemSize := img.elemSize()
;矩阵一个元素占用的字节数，例如：type是CV_16SC3，那么elemSize = 3 * 16 / 8 = 6 bytes
elemSize1 := img.elemSize1()
;矩阵元素一个通道占用的字节数，例如：type是CV_16CS3，那么elemSize1 = 16  / 8 = 2 bytes = elemSize / channels

MsgBox, dims: %dims%`nsize_cols: %size_cols%`nsize_rows: %size_rows%`ntype: %type%`ndepth: %depth%`nelemSize: %elemSize%`nelemSize: %elemSize1%

; ;修改像素值
; loop, % rows{
;     index_rows := A_Index
;     loop, % cols{
;         index_cols := A_Index
;         img.Vec3b_set_at(index_rows - 1, index_cols - 1, ComArrayMake([255, 0, 0])) ;这里的三个参数对应B，G，R三个颜色通道
;     }
; }
cv.split()

cv.imshow("Image", img)
cv.waitKey()
cv.destroyAllWindows()