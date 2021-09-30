% close all;
img=imread('D:\\Matlab\\MyPhotometricStereo\\Photometric-Stereo\\Matlab\\data\\3\\_Dir270.jpg');% �޸ĳ����ͼ�����ڵĵ�ַ
image_size=size(img);
dimension=numel(image_size);
if dimension==2
    gray=img;
elseif dimension==3
    gray=rgb2gray(img);
else
    error('%s','unkonwn image format');
end
images=double(gray)/255;
logS=log(images);
element=fspecial('gaussian',[351,351],20); 
Dis = imfilter(images, element, 'replicate');
logD=log(Dis);
G=logS-logD;
R=exp(G);
res_out2=double(images)./R;
figure;imshow(images, []),title('ԭʼ����ͼ��');
figure;imshow(R, []),title('��ǿ֮���ͼ��');%
figure;imshow(res_out2, []),title('�ն�');
figure;imshow(Dis, []),title('��˹');








% %���ϴ���
% img=imread('D:\\Matlab\\MyPhotometricStereo\\Photometric-Stereo\\Matlab\\data\\3\\_Dir090.jpg');% �޸ĳ����ͼ�����ڵĵ�ַ
% imgr=double(img(:,:,1));
% imgg=double(img(:,:,2));
% imgb=double(img(:,:,3));
% mr=mat2gray(im2double(imgr)); 
% mg=mat2gray(im2double(imgg)); 
% mb=mat2gray(im2double(imgb));%�������͹�һ�� 
% alf1=200; %�����׼��alf=a^2/2  a=20
% n=351;%ģ��Խ��Խ�ã�161��ʱ�����Ч�����Ǻܺ�
% n1=floor((n+1)/2);%��������
% for i=1:n
%     for j=1:n
%       b(i,j) =exp(-((i-n1)^2+(j-n1)^2)/(4*alf1))/(4*pi*alf1); %���ϵ����֪����û��Ӱ����
%     end
% end % 
% sum1=sum(sum(b));%
% b=b/sum1;% ��һ������
% nr1 = double(imfilter(imgr,b,'conv', 'replicate'));% �˲�������
% ng1 = double(imfilter(imgg,b,'conv', 'replicate'));
% nb1 = double(imfilter(imgb,b,'conv', 'replicate'));%����˲�
% fil=cat(3,nr1,ng1,nb1);% ģ�����
% [h0,w0]=size(imgr); 
% for i=1:h0
%     for j=1:w0      
%         % ͨ��ѭ�����п���
%         if(imgr(i,j)==0)||(nr1(i,j)==0)
%            % ����ط�͸���ʱ�Ȼ��0
%            yr1(i,j)=0;
%         else 
%            yr1(i,j)=(log(imgr(i,j))-log(nr1(i,j)));% ����ط�����Ĳ�׼ȷ��������
%         end        
%         if(imgg(i,j)==0)||(ng1(i,j)==0)
%            % ����ط�͸���ʱ�Ȼ��0
%            yg1(i,j)=0;
%         else 
%            yg1(i,j)=(log(imgg(i,j))-log(ng1(i,j)));
%         end        
%         if(imgb(i,j)==0)||(nb1(i,j)==0)
%            % ����ط�͸���ʱ�Ȼ��0
%            yb1(i,j)=0;
%         else 
%            yb1(i,j)=(log(imgb(i,j))-log(nb1(i,j)));
%         end   
%         % ��֪��ʲô�ط������˴���
%     end
% end
% alf1=5000; %�����׼��alf=a^2/2  a=100
% n=351;%
% n1=floor((n+1)/2);%��������
% for i=1:n
%     for j=1:n
%       b(i,j) =exp(-((i-n1)^2+(j-n1)^2)/(4*alf1))/(4*pi*alf1); %���ϵ����֪����û��Ӱ����
%     end
% end 
% sum1=sum(sum(b));
% b=b/sum1;% 
% nr1 = double(imfilter(imgr,b,'conv', 'replicate'));% �˲�������
% ng1 = double(imfilter(imgg,b,'conv', 'replicate'));
% nb1 = double(imfilter(imgb,b,'conv', 'replicate'));%����˲�
% fil=cat(3,nr1,ng1,nb1);% ����ط�����ģ����û�������
% [h0,w0]=size(imgr); 
% for i=1:h0
%     for j=1:w0      
%         % ͨ��ѭ�����п���
%         if(imgr(i,j)==0)||(nr1(i,j)==0)
%            % ����ط�͸���ʱ�Ȼ��0
%            yr2(i,j)=0;
%         else 
%            yr2(i,j)=(log(imgr(i,j))-log(nr1(i,j)));% 
%         end        
%         if(imgg(i,j)==0)||(ng1(i,j)==0)
%            % ����ط�͸���ʱ�Ȼ��0
%            yg2(i,j)=0;
%         else 
%            yg2(i,j)=(log(imgg(i,j))-log(ng1(i,j)));
%         end        
%         if(imgb(i,j)==0)||(nb1(i,j)==0)
%            % ����ط�͸���ʱ�Ȼ��0
%            yb2(i,j)=0;
%         else 
%            yb2(i,j)=(log(imgb(i,j))-log(nb1(i,j)));
%         end   
%     end
% end
% alf1=45000; %�����׼��alf=a^2/2  a=300
% n=351;%ģ��Ĵ�С����ûʲô���Ӱ��
% n1=floor((n+1)/2);%��������
% for i=1:n
%     for j=1:n
%       b(i,j) =exp(-((i-n1)^2+(j-n1)^2)/(4*alf1))/(4*pi*alf1); %
%     end
% end % 
% sum1=sum(sum(b));% 
% b=b/sum1;% ��һ��
% nr1 = double(imfilter(imgr,b,'conv', 'replicate'));% �˲�������
% ng1 = double(imfilter(imgg,b,'conv', 'replicate'));
% nb1 = double(imfilter(imgb,b,'conv', 'replicate'));%����˲�
% fil=cat(3,nr1,ng1,nb1);%
% [h0,w0]=size(imgr); 
% for i=1:h0
%     for j=1:w0      
%         % ͨ��ѭ�����п���
%         if(imgr(i,j)==0)||(nr1(i,j)==0)
%            % ����ط�͸���ʱ�Ȼ��0
%            yr3(i,j)=0;
%         else 
%            yr3(i,j)=(log(imgr(i,j))-log(nr1(i,j)));% ����ط�����Ĳ�׼ȷ��������
%            % ������������ط�����������
%         end        
%         if(imgg(i,j)==0)||(ng1(i,j)==0)
%            % ����ط�͸���ʱ�Ȼ��0
%            yg3(i,j)=0;
%         else 
%            yg3(i,j)=(log(imgg(i,j))-log(ng1(i,j)));
%         end        
%         if(imgb(i,j)==0)||(nb1(i,j)==0)
%            % ����ط�͸���ʱ�Ȼ��0
%            yb3(i,j)=0;
%         else 
%            yb3(i,j)=(log(imgb(i,j))-log(nb1(i,j)));
%         end   
%         % ��֪��ʲô�ط������˴���
%     end
% end
% imgout_r=(yr1+yr2+yr3)/3;% �����ȥ���죬���Ȼ�ܵ͵�
% imgout_g=(yg1+yg2+yg3)/3;
% imgout_b=(yb1+yb2+yb3)/3;
% 
% mean_r=mean2(imgout_r);% ������Ĥ��ǿ֮���ͼ��������촦��
% mean_g=mean2(imgout_g);
% mean_b=mean2(imgout_b);
% var_r=std2(imgout_r);
% var_g=std2(imgout_g);
% var_b=std2(imgout_b);
% min_r=mean_r-2*var_r;  
% max_r=mean_r+2*var_r;  
% min_g=mean_g-2*var_g;  
% max_g=mean_g+2*var_g; 
% min_b=mean_b-2*var_b;  
% max_b=mean_b+2*var_b;  
% imgoutr=255*(imgout_r-min_r)/(max_r-min_r);
% imgoutg=255*(imgout_g-min_g)/(max_g-min_g);
% imgoutb=255*(imgout_b-min_b)/(max_b-min_b);
% res_out=cat(3,imgoutr,imgoutg,imgoutb);% ʵ��֤����������������ֱ��ͼ��Ч�����񡣡�
% res_out2=double(img)./res_out;
% figure,
% imshow(uint8(img)),title('ԭʼ����ͼ��');
% figure,
% imshow(uint8(res_out)),title('��ǿ֮���ͼ��');%
% figure,
% imshow(res_out2, []),title('�ն�');
% 
% figure,
% subplot(321),imhist(uint8(img(:,:,1))),title('ԭʼͼ��ֱ��ͼR');
% subplot(322),imhist(uint8(res_out(:,:,1))),title('����ͼ��ֱ��ͼR');
% subplot(323),imhist(uint8(img(:,:,2))),title('ԭʼͼ��ֱ��ͼG');
% subplot(324),imhist(uint8(res_out(:,:,2))),title('����ͼ��ֱ��ͼG');
% subplot(325),imhist(uint8(img(:,:,3))),title('ԭʼͼ��ֱ��ͼB');
% subplot(326),imhist(uint8(res_out(:,:,3))),title('����ͼ��ֱ��ͼB');