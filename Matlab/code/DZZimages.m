close all;

% % vatiables need to be changed
dataDir     = fullfile('..','data/'); % Path to your data directory (rename this to where you download the data)
subjectName = '3'; %debug, yaleB01, yaleB02, yaleB05, yaleB07, RH
theta = 30.0; % the theta of the light(calculate from middle)
theta2 = 5.7; % the theta of the light(calculate from edge)
% [500,1500,650,1650][115,3345,1180,4500][910,1120,1110,1300][2750,3600,3600,4500]570,1800,1250,2500
detectArea=[1,3684,1,4912]; % row and col range to detect
numImages   = 4; % Total images for each surface
writeOutput = false; % If true then the output will be written to output 
outputDir   = fullfile('..','output/photometricStereo');
imageDir    = fullfile(dataDir, subjectName);
integrationMethod = 'solve2';


%% image light from all direction
filename = fullfile(imageDir, 'full.jpg');
allDirection=imread(filename);
image_size=size(allDirection);
dimension=numel(image_size);
if dimension==2
    gray=allDirection;
elseif dimension==3
    gray=rgb2gray(allDirection);
else
    error('%s','未知格式图像');
end
% gray=rescale(gray);
allDirection_gray=double(gray);
% allDirection_gray=filter2(fspecial('average',15),allDirection_gray);
[h, w] = size(allDirection_gray);

%% detection images light from single direction
d = dir(fullfile(imageDir,'_Dir*.jpg'));
filenames = {d(:).name};
total_images = numel(filenames);

if numImages ~= total_images
   error('Total available images is not specified.\n wanted 4 but get %d images.\n', total_images)
end

Ori_imarray=zeros(h, w, total_images);
for j = 1 : total_images
	m = findstr(filenames{j},'Dir')+3;
	Ang = str2num(filenames{j}(m:(m+3)));
	singleDirection=imread(fullfile(imageDir,filenames{j}));
    image_size=size(singleDirection);
    dimension=numel(image_size);
    if dimension==2
        singleDirection_gray=singleDirection;
    elseif dimension==3
        singleDirection_gray=rgb2gray(singleDirection);
    else
        error('%s','未知格式图像');
    end
    %
%     singleDirection_gray=rescale(singleDirection_gray); 
	Ori_imarray(:,:,(Ang/90+1)) = double(singleDirection_gray);
%     imarray(:,:,(Ang/90+1))=filter2(fspecial('average',15),imarray(:,:,(Ang/90+1)));
end

%% standard images, light from single direction
d = dir(fullfile(dataDir,'base_1*.jpg'));
filenames = {d(:).name};
total_images = numel(filenames);

if numImages ~= total_images
   error('Total available standard images is not specified.\n wanted 4 but get %d images.\n', total_images)
end

% base_imarray=zeros(h, w, total_images);
% for j = 1 : total_images
% 	m = findstr(filenames{j},'_1_')+3;
% 	Ang = str2num(filenames{j}(m:(m+3)));
% 	singleDirection=imread(fullfile(dataDir,filenames{j}));
%     image_size=size(singleDirection);
%     dimension=numel(image_size);
%     if dimension==2
%         singleDirection_gray=singleDirection;
%     elseif dimension==3
%         singleDirection_gray=rgb2gray(singleDirection);
%     else
%         error('%s','未知格式图像');
%     end
%     %
% %     [maxPointY maxPointX]=find(singleDirection_gray==max(max(singleDirection_gray)));
% %     singleDirection_gray=rescale(singleDirection_gray); 
% %     singleDirection_gray=filter2(fspecial('average',201),singleDirection_gray);
% 	base_imarray(:,:,(Ang/90+1)) = double(singleDirection_gray)/255;
% %     imarray(:,:,(Ang/90+1))=filter2(fspecial('average',15),imarray(:,:,(Ang/90+1)));
% end

%% ROI and per-process
Ia=(Ori_imarray(:,:,1)+Ori_imarray(:,:,2)+Ori_imarray(:,:,3)+Ori_imarray(:,:,4))/4;
% Ia=allDirection_gray;


h=detectArea(2)-detectArea(1);
w=detectArea(4)-detectArea(3);
imarray=zeros(h,w, total_images);
ROI_mask=im2bw(Ia/255,30/255);
se=strel('square',11);
ROI_mask=imdilate(ROI_mask,se);
ROI_mask = imfill(ROI_mask, 'holes');
Ia(ROI_mask==0)=0;
for i=1:size(imarray,3)
    temp=Ori_imarray(:,:,i);
    temp(ROI_mask==0)=0;
    if i==3
        weight=1.0;
    else
        weight=1.0;
    end 
%     temp=double(temp)-filter2(fspecial('average',21),temp);
%     temp=double(temp)./(base_imarray(:,:,i)*weight);
%     temp=double(temp)./filter2(fspecial('average',71),temp);
    temp(isnan(temp))=0;temp(isinf(temp))=0;
    temp=double(temp(detectArea(1):detectArea(2)-1,detectArea(3):detectArea(4)-1))/255; 
    imarray(:,:,i)=temp;
end

% IMG_imhist = imhist(imarray(:,:,1));%产生规定化模板
% imarray(:,:,2) = histeq(imarray(:,:,2),IMG_imhist);%直方图规定化
% imarray(:,:,3) = histeq(imarray(:,:,3),IMG_imhist);%直方图规定化
% IMG_imhist = imhist(imarray(:,:,2));%产生规定化模板
% imarray(:,:,4) = histeq(imarray(:,:,4),IMG_imhist);%直方图规定化

Ia=imarray(:,:,1)+imarray(:,:,2)+imarray(:,:,3)+imarray(:,:,4);
% Ia(ROI_mask==0)=0;
% Ia=Ia(detectArea(1):detectArea(2)-1,detectArea(3):detectArea(4)-1);

% thetaMap=zeros(h,w);
% for i=h/2:-1:1
%     [i_vec,j_vec] = meshgrid(1:w,1:h) ;
%     c = find(((i_vec-h/2).^2+(j_vec-w/2).^2) <=(i^2)) ;
%     theta_now=-(theta-theta2)/(h/2-1)*(i-1)+theta;
%     thetaMap(c) = tan(pi*theta_now/180) ;
% end

%% calculate the normal-vector of the surface
Ip=(double(imarray(:,:,1))-double(imarray(:,:,3)))./double(Ia);
Iq=(double(imarray(:,:,2))-double(imarray(:,:,4)))./double(Ia);
Ip(isnan(Ip))=0;Ip(isinf(Ip))=0;
Iq(isnan(Iq))=0;Iq(isinf(Iq))=0;
% Ip=rescale(Ip,-1,1);
% Iq=rescale(Iq,-1,1);

surfaceNormals=zeros(h,w,3);
albedoImage=zeros(h,w);

surfaceNormals(:,:,1)=(2*Ip)/tan(pi*theta/180);
surfaceNormals(:,:,2)=(2*Iq)/tan(pi*theta/180);
% surfaceNormals(:,:,1)=(2*Ip)./thetaMap;
% surfaceNormals(:,:,2)=(2*Iq)./thetaMap;
surfaceNormals(:,:,3)=ones(h,w);

%% calculate the reflect rate of the surface
for i = 1:h
    for j = 1:w
        reflect_rate=sqrt(surfaceNormals(i,j,1)^2 + surfaceNormals(i,j,2)^2 + surfaceNormals(i,j,3)^2); 
%         if reflect_rate-1<0.1
%             reflect_rate=1;
%             surfaceNormals(i,j,1)=0;
%             surfaceNormals(i,j,2)=0;
%         end
        albedoImage(i,j)=reflect_rate;
    end
end

surfaceNormals(:,:,1)=surfaceNormals(:,:,1)./albedoImage;
surfaceNormals(:,:,2)=surfaceNormals(:,:,2)./albedoImage;
surfaceNormals(:,:,3)=surfaceNormals(:,:,3)./albedoImage;

% Vx=surfaceNormals(:,:,1);
% Vy=surfaceNormals(:,:,2);
% surfaceNormals(:,:,1)=Vx*cos(pi*20/180)-Vy*sin(pi*20/180);
% surfaceNormals(:,:,2)=Vx*sin(pi*20/180)+Vy*cos(pi*20/180);

enhanced=(abs(surfaceNormals(:,:,1))+abs(surfaceNormals(:,:,2)))/2;
figure;
title("for Detection")
imshow(albedoImage,[]);

[G,h1,P1,P2] = surfcurvature2(surfaceNormals(:,:,2), surfaceNormals(:,:,1), surfaceNormals(:,:,3));
figure;
subplot(2,2,1);
imshow(P1, []); 
title('Max');
subplot(2,2,2);
imshow(P2, []); 
title('Min');
subplot(2,2,3);
imshow(h1, []); 
title('Average');
subplot(2,2,4);
imshow(G, []); 
title('Gauss');

%% Compute height from normals by integration along paths
heightMap = getSurface(surfaceNormals, integrationMethod);

%% Display the output
displayOutput(enhanced, heightMap);
plotSurfaceNormals(surfaceNormals);

