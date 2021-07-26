close all;
clear all;

%% split the images from scaned image
partNum=10; % number of images to split

orignal=imread('E:/lineScane/20210706/test/4.jpg');
splited=splitScan(orignal,partNum);
% figure;
for i=1:partNum
%     subplot(2,4,i);
    figure;imshow(splited(:,:,i),[]);
end



function  images = splitScan(orignalImg,partNum)
    [h w]=size(orignalImg);
    cutted=orignalImg(mod(h,partNum)+1:h,:);
    [h w]=size(cutted);
    for j=1:partNum
        for i=1:h/partNum
            images(i,:,j)=cutted((i-1)*partNum+j,:);
        end
    end
end