function  siggraph(testimg, img1, styled1, disp)
% testimg : the image to be applied with filters
load('lp_fil_5_2.mat');
g = h;
load('lp_fil_5_1.mat');
one_g = h;
% 
% load('lp_fil_5.mat');
% impl = h;

test = imresize(imread(testimg), [256 256]); test = test(:,:,1);
styled = imresize(imread(styled1), [256 256]); styled = styled(:,:,1);
im = imresize(imread(img1), [256 256]); im = im(:,:,1);

N1 = size(im, 1); N2 = size(im, 2); L1 = size(one_g, 1); L2 = size(one_g, 2);
one_G = fftshift(fft2(one_g, N1+L1-1, N2+L2-1)); % 1-G
G = fftshift(fft2(g, N1+L1-1, N2+L2-1));

A = fftshift(fft2(test, N1+L1-1, N2+L2-1));

B = fftshift(fft2(im, N1+L1-1, N2+L2-1));
C = fftshift(fft2(styled, N1+L1-1, N2+L2-1));
%%%%%%
FofIm = C./B;
FofIm = FofIm./abs(FofIm);
%%%%%%
% M = size(A,2);
% N = size(A,1); 
% [x y] = meshgrid(linspace(-M/2, M/2, M), linspace(-N/2, N/2, N));
FT = A.*G+one_G.*FofIm.*A;

if(disp == 1) 
    
    figure('NumberTitle', 'off', 'Name', sprintf('filter from %s ',img1));
    subplot(1,2,1);
    imshow(test);
    title('image to be styled');
    subplot(1,2,2);
    r = round(size(FT, 1)/2);
    c = round(size(FT, 2)/2);
    tmp = uint8(ifft2(ifftshift(FT)));
    h = round(size(test, 1)/2);
    l = round(size(test, 2)/2);
    imshow(tmp(r-h:r+h, c-l:c+l));
    title('after styled');

end



