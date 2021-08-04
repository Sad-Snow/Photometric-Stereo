#include "splitScan.h"

using namespace std;
using namespace cv;

splitScan::splitScan()
{
	path = "";
	splitNum = 8;
}

splitScan::splitScan(std::string _path, int _splitNum)
{
	setPath(_path);
	setNum(_splitNum);
}

splitScan::splitScan(Mat _orignal, int _splitNum)
{
	setOrignal(_orignal);
	setNum(_splitNum);
}

splitScan::~splitScan()
{
}

bool splitScan::splitImages()
{
	Mat gray_img = getOrignal();
	if (gray_img.empty())
	{
		cout << "splitImages error: No image to split! Please identify the path or image." << endl;
		splitedImg.clear();
		return false;
	}
	if (splitNum < 1)
	{
		cout << "splitImages error: splited images number must be bigger than 0" << endl;
		splitedImg.clear();
		return false;
	}
	Size orignalsize = gray_img.size();
	int redundance_lines = orignalsize.height % splitNum;
	Rect cut_rect(Point(0, 0), Point(orignalsize.width, orignalsize.height - redundance_lines));
	Mat cutted = gray_img(cut_rect);
	Mat blank = Mat::zeros(cutted.rows / splitNum, cutted.cols, CV_8UC1);
	for (int i = 0; i < splitNum; i++)
	{
		splitedImg.push_back(blank.clone());
	}
	for (int i = 0; i < cutted.rows; i++) {
		(gray_img.row(i)).copyTo((splitedImg[(i%splitNum)].row((i / splitNum))));
		//cout << i << "\t";
	}
	return true;

}

void splitScan::setPath(string _path)
{
	path = _path;
	orignalImg = imread(path, IMREAD_GRAYSCALE);
}

void splitScan::setNum(int _Num)
{
	if (_Num < 1)
	{
		cout << "setNum error: set number must be bigger than 0! Setted to default(8)" << endl;
		splitNum = 8;
	}
	else
		splitNum = _Num;
}

void splitScan::setOrignal(cv::Mat _orignal)
{
	if (_orignal.channels() == 3)
	{
		Mat gray_img;
		cvtColor(_orignal, gray_img, CV_BGR2GRAY);
		orignalImg = gray_img.clone();
	}
	else if (_orignal.channels() == 1)
		orignalImg = _orignal.clone();
	else
		cout << "setOrignal error: Unknown format of image! RGB or Gray format only" << endl;
}

cv::Mat & splitScan::getOrignal()
{
	if (orignalImg.empty())
	{
		if (!path.empty())
			orignalImg = imread(path, IMREAD_GRAYSCALE);
		else
		{
			cout << "getOrignal error: No image to split! Please identify the path or image." << endl;
			splitedImg.clear();
		}
	}
	return orignalImg;
}

std::vector<cv::Mat>& splitScan::getSplited()
{
	if (splitedImg.empty())
	{
		splitImages();
	}
	return splitedImg;
}

void splitScan::clear()
{
	splitNum = 8;
	path.clear();
	splitedImg.clear();
	orignalImg.release();

}