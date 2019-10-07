function  siggraph_2(testimg, styled1, disp)
% testimg : the image to be applied with filters
load('lp_fil_5_2.mat');
g = h;
load('lp_fil_5_1.mat');
one_g = h;
test = imresize(imread(testimg), [256 256]); test = test(:,:,1);
styled = imresize(imread(styled1), [256 256]); styled = styled(:,:,1);
N1 = size(test, 1); N2 = size(test, 2); L1 = size(one_g, 1); L2 = size(one_g, 2);
one_G = fftshift(fft2(one_g, N1+L1-1, N2+L2-1)); % 1-G
G = fftshift(fft2(g, N1+L1-1, N2+L2-1));
A = fftshift(fft2(test, N1+L1-1, N2+L2-1));

C = fftshift(fft2(styled, N1+L1-1, N2+L2-1));
% freqz2(G);
FT = A.*G + one_G.*C;

if(disp == 1) 
    
    figure('NumberTitle', 'off', 'Name', sprintf('filter from %s ',styled1));
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
%     imshow(tmp);
    title('after styled');

end



