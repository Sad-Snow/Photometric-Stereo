function displayOutput(albedo, height)
% NOTE: h x w is the size of the input images
% albedo: h x w matrix of albedo 
% height: h x w matrix of surface heights

% some cosmetic transformations to make 3D model look better

[hgt, wid] = size(height);
[X,Y] = meshgrid(1:wid, 1:hgt);
H = flipud(fliplr(height));
A = flipud(fliplr(albedo));

figure;
subplot(1,2,1);
title('Albedo');
imshow(albedo,[]);
subplot(1,2,2);
title('Height Map');
imshow(height,[]);

figure;
% H=rescale(H,0,1000);
% mesh(H, X, Y, A);
mesh(H);
axis equal;
xlabel('X')%xlabel('Z')
ylabel('Y')%ylabel('X')
zlabel('Z')%zlabel('Y')
title('Height Map')

% Set viewing direction
% view(-60,20)
% colormap(gray)
set(gca, 'XDir', 'reverse')
set(gca, 'XTick', []);
set(gca, 'YTick', []);
set(gca, 'ZTick', []);

% Calculate the surface DIRECTIONS
[k,h1,P1,P2,D1,D2] = surfcurvature(X, Y, height);
figure;
subplot(2,2,1);
imshow(P1, []); 
title('DIRECTIONS D1');
subplot(2,2,2);
imshow(P2, []); 
title('DIRECTIONS D2');
subplot(2,2,3);
imshow(h1, []); 
title('DIRECTIONS H');
% curvature=(abs(D1(:,:,3))+abs(D2(:,:,3)))/2;
% subplot(1,2,1);
% imshow(curvature, []); 
% title('DIRECTIONS D1');
% subplot(1,2,2);
% imshow(h1, []); 
% title('DIRECTIONS H');

% filtered = filterimage(height, 10, 4);
subplot(2,2,4);
imshow(k, []); 
title('shape');
end

function g = bfilt_gray(f,r,a,b)
% f灰度图；r滤波半径；a全局方差；b局部方差
[x,y] = meshgrid(-r:r);
w1 = exp(-(x.^2+y.^2)/(2*a^2));
% f = tofloat(f);
f = im2double(f);
 
% h = waitbar(0,'Applying bilateral filter...');
% set(h,'Name','Bilateral Filter Progress');
 
[m,n] = size(f);
f_temp = padarray(f,[r r],'symmetric');
g = zeros(m,n);
for i = r+1:m+r
    for j = r+1:n+r
        temp = f_temp(i-r:i+r,j-r:j+r);
        w2 = exp(-(temp-f(i-r,j-r)).^2/(2*b^2));
        w = w1.*w2;
        s = temp.*w;
        g(i-r,j-r) = sum(s(:))/sum(w(:));
    end
%     waitbar((i-r)/m);
end
% g = revertclass(g);
end
