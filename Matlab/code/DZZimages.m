%% assume that:
% the light source is parallel light and orthogonal acquisition;
% The object has a Lambert surface;
% but:
% the light is definitly not parallel;
% the suface could be affected by mirror surface;

close all;
clear all;
%% vatiables need to be changed
dataDir     = fullfile('..','data/'); % Path to your data directory
subjectName = '3'; %the name of folder
theta = 45.0; % the theta of the light(calculate from middle)
detectArea=[700,1100,4200,4500]; % row and col range to detect[1,3684,800,4500][1,1800,800,2300][700,1100,4200,4500]
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
Ep=ones(size(Ori_imarray))*255;
[Ia,imarray] = preprocess(Ori_imarray,detectArea,30,Ep,false);

%% calculate the normal-vector and reflect rate of surface
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

