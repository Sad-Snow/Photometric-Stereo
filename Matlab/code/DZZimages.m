close all;

%% vatiables need to be changed
dataDir     = fullfile('..','data/'); % Path to your data directory
subjectName = '3'; %the name of folder
theta = 30.0; % the theta of the light(calculate from middle)
detectArea=[2000,3000,1000,2000]; % row and col range to detect[1,3684,1,4912]
numImages   = 4; % Total images for each surface
imageDir    = fullfile(dataDir, subjectName);
integrationMethod = 'solve2';


%% image light from all direction
allDirection_gray=getImages(imageDir,'full.jpg','full',1);

%% detection images light from single direction
% Ori_imarray=zeros(h, w, numImages);
Ori_imarray=getImages(imageDir,'_Dir*.jpg','4dir',numImages);

%% standard images light from single direction
% std_imarray=getImages(dataDir,'base_1*.jpg','standard',numImages);

%% ROI and per-process
[Ia,imarray] = preprocess(Ori_imarray,detectArea,30);

%% calculate the normal-vector and reflect rate of surface
% Ip=(double(imarray(:,:,1))-double(imarray(:,:,3)))./double(Ia);
% Iq=(double(imarray(:,:,2))-double(imarray(:,:,4)))./double(Ia);
% Ip(isnan(Ip))=0;Ip(isinf(Ip))=0;
% Iq(isnan(Iq))=0;Iq(isinf(Iq))=0;
% 
% surfaceNormals=zeros(h,w,3); %vector of the surface
% albedoImage=zeros(h,w); %reflection rate of the surface
% 
% surfaceNormals(:,:,1)=(2*Ip)/tan(pi*theta/180);
% surfaceNormals(:,:,2)=(2*Iq)/tan(pi*theta/180);
% surfaceNormals(:,:,3)=ones(h,w);
% 
% for i = 1:h
%     for j = 1:w
%         reflect_rate=sqrt(surfaceNormals(i,j,1)^2 + surfaceNormals(i,j,2)^2 + surfaceNormals(i,j,3)^2); 
%         albedoImage(i,j)=reflect_rate;
%     end
% end
% surfaceNormals(:,:,1)=surfaceNormals(:,:,1)./albedoImage;
% surfaceNormals(:,:,2)=surfaceNormals(:,:,2)./albedoImage;
% surfaceNormals(:,:,3)=surfaceNormals(:,:,3)./albedoImage;
lightCorrect=tan(pi*theta/180);
[albedoImage,surfaceNormals] = getNormalVec(imarray,Ia,lightCorrect,'minus');

%% display curvature 
[G,h1,P1,P2] = surfcurvature2(surfaceNormals(:,:,2), surfaceNormals(:,:,1), surfaceNormals(:,:,3));
figure;subplot(2,2,1);imshow(P1, []); title('Max');
subplot(2,2,2);imshow(P2, []); title('Min');
subplot(2,2,3);imshow(h1, []); title('Average');
subplot(2,2,4);imshow(G, []); title('Gauss');

%% Compute height from normals by integration along paths
heightMap = getSurface(surfaceNormals, integrationMethod);

%% Display the output
displayOutput(albedoImage, heightMap);
plotSurfaceNormals(surfaceNormals);

