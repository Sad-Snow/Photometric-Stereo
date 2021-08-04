#pragma once
#include <opencv2\opencv.hpp>
#include <vector>
#include <string>

class splitScan
{
public:
	splitScan();		//构造函数1
	splitScan(std::string _path, int _splitNum=8);		//构造函数2
	splitScan(cv::Mat _orignal, int _splitNum=8);		//构造函数3
	~splitScan();		//析构函数
	bool splitImages();	//将orignalImg拆成指定splitNum数量
	void setPath(std::string _path);	//设置路径
	void setNum(int _Num);				//设置数量
	void setOrignal(cv::Mat _orignal);	//设置原图
	cv::Mat& getOrignal();				//获得原图
	std::vector<cv::Mat>& getSplited();	//获得结果
	void clear();	//清空private变量

private:
	std::string path;	//原图路径
	int splitNum;		//需要拆出的图像数量

	std::vector<cv::Mat> splitedImg;	//拆出的图像
	cv::Mat orignalImg;	//原图
};



