#pragma once
#include <opencv2\opencv.hpp>
#include <vector>
#include <string>

class splitScan
{
public:
	splitScan();		//���캯��1
	splitScan(std::string _path, int _splitNum=8);		//���캯��2
	splitScan(cv::Mat _orignal, int _splitNum=8);		//���캯��3
	~splitScan();		//��������
	bool splitImages();	//��orignalImg���ָ��splitNum����
	void setPath(std::string _path);	//����·��
	void setNum(int _Num);				//��������
	void setOrignal(cv::Mat _orignal);	//����ԭͼ
	cv::Mat& getOrignal();				//���ԭͼ
	std::vector<cv::Mat>& getSplited();	//��ý��
	void clear();	//���private����

private:
	std::string path;	//ԭͼ·��
	int splitNum;		//��Ҫ�����ͼ������

	std::vector<cv::Mat> splitedImg;	//�����ͼ��
	cv::Mat orignalImg;	//ԭͼ
};



