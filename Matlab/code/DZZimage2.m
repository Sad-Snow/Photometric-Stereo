%% assume that:
% the light source is parallel light and orthogonal acquisition
% The object has a Lambert surface
% but:
% the light is definitly not parallel, we will try to correct it here
% the suface could be affected by mirror surface
close all;

%% vatiables need to be changed
%images informatiion
dataDir     = fullfile('..','data/'); % Path to your data directory
subjectName = '3'; %the name of folder
theta = 30.0; % the theta of the light(calculate from middle)
detectArea=[2000,3000,1000,2000]; % row and col range to detect[1,3684,1,4912]
numImages   = 4; % Total images for each surface
imageDir    = fullfile(dataDir, subjectName);
integrationMethod = 'solve2'; % ways to calculate
%light source information
resolution = 0.0175; % the resolution of the camera
lightCircle = 77; % half Direction of the light
lightHeight = 53; % height of light
cameraHeight = 230; % height of camera






