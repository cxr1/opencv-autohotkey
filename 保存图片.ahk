#NoEnv
SendMode Input
SetWorkingDir %A_ScriptDir%
hOpencv := DllCall("LoadLibrary", "str", "opencv_world455.dll", "ptr")
hOpencvCom := DllCall("LoadLibrary", "str", "autoit_opencv_com455.dll", "ptr")
DllCall("autoit_opencv_com455.dll\DllInstall", "int", 1, "wstr", A_IsAdmin = 0 ? "user" : "", "cdecl")
cv := ComObjCreate("OpenCV.cv")
img := cv.imread("2.png")
cv.imwrite("new.png", img)
/*
cv.imwrite(filename, img, params)
filename：需要保存图像的文件名，要保存图片为哪种格式，就带什么后缀。
img：要保存的图像。
params：表示为特定格式保存的参数编码。它针对特定的格式：对于JPEG，其表示的是图像的质量，用0 - 100的整数表示，默认95;对于png ,第三个参数表示的是压缩级别，默认为3。
  cv::IMWRITE_JPEG_QUALITY = 1, 对于JPEG，它可以是从0到100的质量（越高越好）。默认值为95。
  cv::IMWRITE_JPEG_PROGRESSIVE = 2, 启用JPEG功能，0或1，默认为False。
  cv::IMWRITE_JPEG_OPTIMIZE = 3, 启用JPEG功能，0或1，默认为False。
  cv::IMWRITE_JPEG_RST_INTERVAL = 4, JPEG重启间隔，0 - 65535，默认为0 - 无重启。
  cv::IMWRITE_JPEG_LUMA_QUALITY = 5, 单独的亮度质量等级，0 - 100，默认为0 - 不使用。
  cv::IMWRITE_JPEG_CHROMA_QUALITY = 6, 单独的色度质量等级，0 - 100，默认为0 - 不使用。
  cv::IMWRITE_PNG_COMPRESSION = 16, 对于PNG，它可以是从0到9的压缩级别。值越高意味着更小的尺寸和更长的压缩时间。如果指定，则策略更改为IMWRITE_PNG_STRATEGY_DEFAULT（Z_DEFAULT_STRATEGY）。默认值为1（最佳速度设置）。
  cv::IMWRITE_PNG_STRATEGY = 17, 其中一个品种:: ImwritePNGFlags，默认为IMWRITE_PNG_STRATEGY_RLE。
  cv::IMWRITE_PNG_BILEVEL = 18, 二进制级别PNG，0或1，默认为0。
  cv::IMWRITE_PXM_BINARY = 32, 对于PPM，PGM或PBM，它可以是二进制格式标志，0或1.默认值为1。
  cv::IMWRITE_EXR_TYPE = (3 << 4) + 0,
  cv::IMWRITE_EXR_COMPRESSION = (3 << 4) + 1,
  cv::IMWRITE_WEBP_QUALITY = 64, 覆盖EXR存储类型（默认为FLOAT（FP32））对于WEBP，它可以是1到100的质量（越高越好）。默认情况下（不带任何参数），如果质量高于100，则使用无损压缩。
  cv::IMWRITE_PAM_TUPLETYPE = 128, 对于PAM，将TUPLETYPE字段设置为为格式定义的相应字符串值。
  cv::IMWRITE_TIFF_RESUNIT = 256, 对于TIFF，用于指定要设置的DPI分辨率单位; 请参阅libtiff文档以获取有效值。
  cv::IMWRITE_TIFF_XDPI = 257, 对于TIFF，用于指定X方向DPI。
  cv::IMWRITE_TIFF_YDPI = 258, 对于TIFF，用于指定Y方向DPI。
  cv::IMWRITE_TIFF_COMPRESSION = 259, 对于TIFF，用于指定图像压缩方案。请参阅libtiff以获取与压缩格式对应的整数常量。注意，对于深度为CV_32F的图像，仅使用libtiff的SGILOG压缩方案。对于其他支持的深度，可以通过此标志指定压缩方案; LZW压缩是默认值。
  cv::IMWRITE_JPEG2000_COMPRESSION_X1000 = 272, 对于JPEG2000，用于指定目标压缩率（乘以1000）。该值可以是0到1000.默认值是1000。
*/
cv.imshow("Image", img)
cv.waitKey()
cv.destroyAllWindows()