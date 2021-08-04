#include <iostream>
#include "splitScan.h"

using namespace std;

int main()
{
	string orignal_path = "D:\\Matlab\\PhotometricStereo\\data\\photometricStereo\\20210728线扫分区\\3\\Orignal.jpg";
	cv::Mat orign = cv::imread(orignal_path, cv::IMREAD_GRAYSCALE);
	splitScan tools(orign, 10);
	vector<cv::Mat> splited=tools.getSplited();
	for (int i = 0; i < splited.size(); i++)
	{
		cv::Mat temp = splited[i].clone();
		string save_path = "D:\\Matlab\\PhotometricStereo\\data\\photometricStereo\\20210728线扫分区\\4/splited_" + to_string(i) + ".jpg";
		imwrite(save_path, temp);
	}

	return 0;
}