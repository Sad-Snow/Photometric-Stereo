function   [K,H,Pmax,Pmin,D1,D2] = surfcurvature(X,Y,Z)
% K AND H ARE THE GAUSSIAN AND MEAN CURVATURES, RESPECTIVELY.
% Pmax AND Pmin ARE THE MINIMUM AND MAXIMUM CURVATURES AT EACH POINT, RESPECTIVELY.
% d1,d2 ARE THE MAIN DIRECTIONS

% First Derivatives
[Xu,Xv] = gradient(X);
[Yu,Yv] = gradient(Y);
[Zu,Zv] = gradient(Z);

% Second Derivatives
[Xuu,Xuv] = gradient(Xu);
[Yuu,Yuv] = gradient(Yu);
[Zuu,Zuv] = gradient(Zu);

[Xuv,Xvv] = gradient(Xv);
[Yuv,Yvv] = gradient(Yv);
[Zuv,Zvv] = gradient(Zv);

% Reshape 2D Arrays into Vectors
Xu = Xu(:);   Yu = Yu(:);   Zu = Zu(:); 
Xv = Xv(:);   Yv = Yv(:);   Zv = Zv(:); 
Xuu = Xuu(:); Yuu = Yuu(:); Zuu = Zuu(:); 
Xuv = Xuv(:); Yuv = Yuv(:); Zuv = Zuv(:); 
Xvv = Xvv(:); Yvv = Yvv(:); Zvv = Zvv(:); 

Xu          =   [Xu Yu Zu];
Xv          =   [Xv Yv Zv];
Xuu         =   [Xuu Yuu Zuu];
Xuv         =   [Xuv Yuv Zuv];
Xvv         =   [Xvv Yvv Zvv];

% First fundamental Coeffecients of the surface (E,F,G)
E           =   dot(Xu,Xu,2);
F           =   dot(Xu,Xv,2);
G           =   dot(Xv,Xv,2);

m           =   cross(Xu,Xv,2);
p           =   sqrt(dot(m,m,2));
n           =   m./[p p p]; 

[s,t] = size(Z);

% [nu,nv] = gradient(reshape(n,s,t,3));
% Nu = reshape(nu,[],3);
% Nv = reshape(nv,[],3);

% Second fundamental Coeffecients of the surface (L,M,N)
L           =   dot(Xuu,n,2);
M           =   dot(Xuv,n,2);
N           =   dot(Xvv,n,2);

% Gaussian Curvature
K = (L.*N - M.^2)./(E.*G - F.^2);
K = reshape(K,s,t);

% Mean Curvature
H = (E.*N + G.*L - 2.*F.*M)./(2*(E.*G - F.^2));
H = reshape(H,s,t);

% Principal Curvatures
Pmax = H + sqrt(H.^2 - K);
Pmin = H - sqrt(H.^2 - K);

% a = (L.*G - M.*F)./(E.*G -F.*F);
% b = (M.*E - L.*F)./(E.*G -F.*F);
% c = (M.*G - N.*F)./(E.*G -F.*F);
% d = (N.*E - M.*F)./(E.*G -F.*F);
% W = permute(reshape([a b c d]',2,2,[]),[2,1,3]);

%MAIN DIRECTIONS
D1=(Pmax(:).*G-N).*Xu+(M-Pmax(:).*F).*Xv;
D2=(Pmin(:).*G-N).*Xu+(M-Pmin(:).*F).*Xv;
nd1 = sqrt(dot(D1,D1,2));
nd2 = sqrt(dot(D2,D2,2));
D1=D1./[nd1 nd1 nd1];
D2=D2./[nd2 nd2 nd2];

D1=reshape(D1,s,t,3);%k1's MAIN DIRECTION
D2=reshape(D2,s,t,3);

% %RETURN
% curvature.k = K;
% curvature.h = H;
% curvature.pmax = Pmax;
% curvature.pmin = Pmin;
% curvature.d1 = D1;
% curvature.d2 = D2;
end

