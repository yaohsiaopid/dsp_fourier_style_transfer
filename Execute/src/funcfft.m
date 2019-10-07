function [filter, org] = funcfft(img_path, styled_path, disp)
load('bpfil_5_7.mat');
impl = 10*h;
img = imread(img_path);
img = imresize(img, [64 64]);
styled = imread(styled_path);
styled = imresize(styled, [64 64]);
chan = img(:,:,1);
sty_chan = styled(:,:,1);
sty_chan = imresize(sty_chan, [64 64]);
% chan_test = test(:,:,1);
A = fftshift(fft2(chan, 64, 64));
B = fftshift(fft2(sty_chan, 64, 64));
% N1 = size(chan, 1); N2 = size(chan, 2); L1 = size(impl, 1); L2 = size(impl, 2);
% H = fftshift(fft2(impl, N1+L1-1, N2+L2-1));
% A = fftshift(fft2(chan, N1+L1-1, N2+L2-1));
% B = fftshift(fft2(sty_chan, N1+L1-1, N2+L2-1));
% N1+L1-1
% ang = angle(B(:,:,1))-angle(A(:,:,1));
% tmp = B./A;
% tmp(abs(20*log10(tmp)) < 10) = 1;
% final = C.*tmp;
% imshow(uint8(ifft2(ifftshift(final))));
% % % count zero
% % idx = (A == 0);
% % cnt = sum(idx(:))
M = size(B,2);
N = size(B,1); 
[x y] = meshgrid(linspace(-M/2, M/2, M), linspace(-N/2, N/2, N));
% 

org = abs(A(:,:,1));
filter = abs(B(:,:,1)./A(:,:,1));
% org = (B(:,:,1)./A(:,:,1));
% filter = (angle(B(:,:,1)) - angle(A(:,:,1)))*180/pi;
tmp = 20*log10(abs(B(:,:,1)./A(:,:,1)));
org = (abs(A(:)));
filter = abs(B(:,:,1)./A(:,:,1));
% tmp = 20*log10(abs(A.*H));
% tmp = 20*log10(abs(B(:,:,1)));
% ---------- downsample -------------
% FT = A.*H;
% ft_re = ifft2(ifftshift(FT));
% ft_re = ft_re(1:8:size(ft_re,1), 1:8:size(ft_re,2));
% tmp_decimated = 20*log10(abs(fftshift(fft2(ft_re))));
% dec = FT(1:8:size(FT,1), 1:8:size(FT,2));
% M_tm = size(dec,2);
% N_tm = size(dec,1); 
% [tmx tmy] = meshgrid(linspace(-M_tm/2, M_tm/2, M_tm), linspace(-N_tm/2, N_tm/2, N_tm));
% ----------------------------
if(disp == 1) 
%     f = figure('visible', 'off');
    
    
    figure('NumberTitle', 'off', 'Name', sprintf('analysis %s ',img_path));
%     figure;
    subplot(1,3,2);
    surf(x*2/M, y*2/N, tmp);
%     surf(tmx*2/M_tm, tmy*2/N_tm, 20*log10(abs(dec)));
%     hold on;
%     surf(tmx*2/M_tm, tmy*2/N_tm, 20*log10(abs(A(1:8:size(A,1), 1:8:size(A,2)))));
%     surf(x*2/M, y*2/N, 20*log10(abs(A)));
    view(2);
    title('styl/im (dB)');
    rotate3d on;
%     figure;

%     tmp = 20*log10(abs(B(:,:,1)-A(:,:,1)));
    subplot(1,3,1);
    hist(20*log10(abs(A(:))));
    mn = mean(20*log10(abs(A(:))))
    stdd = std(20*log10(abs(A(:))))
    title('in image hist of spectral');
%     surf(x*2/M, y*2/N, tmp);
%     view(2);
%     title('styl- im (dB)');
%     rotate3d on;

    ang = angle(B(:,:,1))-angle(A(:,:,1));
    subplot(1,3,3);
%     hist(tmp);
    surf(x*2/M, y*2/N, 180*ang/pi);
%     surf(tmx*2/M_tm, tmy*2/N_tm, (180/pi*angle(dec)));
    view(2);
    title('styl- im angle');
%     rotate3d on;
%     saveas(gcf, sprintf('../plt/fft_%s.png', img_path(8:length(img_path)-4)));
%     close;
end



