function re = funcfft_transfer(img_path, styled_path, test_on, test_gnd)
% clear
% close all;
img = imread(img_path);
styled = imread(styled_path);
test = imread(test_on);

% --------------------------------------------
figure('NumberTitle', 'off', 'Name', sprintf('analysis %s ',img_path));
% f = figure('Visible', 'off');
subplot(1,3,1);
gnd = imread(test_gnd);
imshow(gnd(:,:,1));
chan = img(:,:,1);
sty_chan = styled(:,:,1);
chan_test = test(:,:,1);
% chan = imresize(img(:,:,1), [64 64]);
% sty_chan = imresize(styled(:,:,1), [64 64]);
% chan_test = imresize(test(:,:,1), [64 64]);
N1 = size(chan, 1);
N2 = size(chan, 2);
L1 = size(chan_test, 1);
L2 = size(chan_test, 2);
% A = fftshift(fft2(chan, 64,64));
% B = fftshift(fft2(sty_chan,64,64));
% C = fftshift(fft2(chan_test, 64,64));
A = fftshift(fft2(chan, N1+L1-1, N2+L2-1));
B = fftshift(fft2(sty_chan, N1+L1-1, N2+L2-1));
C = fftshift(fft2(chan_test, N1+L1-1, N2+L2-1));
ang = angle(B(:,:,1))-angle(A(:,:,1));
tmp = ones(size(B,1), size(B,2));
tmp(abs(ang)*180/pi > 10) =  exp(-j*(ang(abs(ang)*180/pi > 10)));
tmp2 = B./A;
idx = abs(20*log10(tmp2)) < 10 ;
tmp2(idx) = tmp2(idx)./abs(tmp2(idx));
final_ = C.*tmp;
% figure('NumberTitle', 'off', 'Name', 'only phase');
final_img = ifft2(ifftshift(final_));
subplot(1,3,2);
imshow(uint8(final_img(1:size(test,1), 1:size(test,2))));
title('only phase');

final = final_ .* tmp2;
re = ifft2(ifftshift(final));
% figure('NumberTitle', 'off', 'Name', 'phase and amp');
subplot(1,3,3);
imshow(uint8(re(1:size(test,1), 1:size(test,2))));
title('phase and amp');
re = uint8(re);
% saveas(gcf, sprintf('../plt/transfer_%s_%s.png', img_path(8:length(img_path)-4), styled_path(8:length(styled_path)-4)));
% figure;
% [x y] = meshgrid(1:size(ang,2), 1:size(ang,1));
% surf(x, y, 180/pi*ang);
% % % count zero
% % idx = (A == 0);
% % cnt = sum(idx(:))
% M = size(B,2);
% N = size(B,1); 
% [x y] = meshgrid(linspace(-M/2, M/2, M), linspace(-N/2, N/2, N));
% 
% subplot(1,1,3);
% tmp = 20*log10(abs(B(:,:,1)./A(:,:,1)));
% % tmp = 20*log10(abs(B(:,:,1)));
% surf(x*2/M, y*2/N, tmp);
% view(2);
% title('styl/im (dB)');
% rotate3d on;
% 
% 
% tmp = 20*log10(abs(B(:,:,1)-A(:,:,1)));
% subplot(1,3,2);
% surf(x*2/M, y*2/N, tmp);
% view(2);
% title('styl- im (dB)');
% rotate3d on;
% 
% ang = angle(B(:,:,1))-angle(A(:,:,1));
% subplot(1,3,3);
% surf(x*2/M, y*2/N, 180*ang/pi);
% view(2);
% title('styl- im angle');
% rotate3d on;




