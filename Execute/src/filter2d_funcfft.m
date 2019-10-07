function  filter2d_funcfft(img_path, styled_path, disp)
load('bpfil_5_7.mat');
impl = h;
img = imread(img_path);
img = imresize(img, [64 64]);
styled = imread(styled_path);
styled = imresize(styled, [64 64]);

chan = img(:,:,1);
sty_chan = styled(:,:,1);
sty_chan = imresize(sty_chan, [64 64]);
N1 = size(chan, 1); N2 = size(chan, 2); L1 = size(impl, 1); L2 = size(impl, 2);
H = fftshift(fft2(impl, N1+L1-1, N2+L2-1));
A = fftshift(fft2(chan, N1+L1-1, N2+L2-1));
B = fftshift(fft2(sty_chan, N1+L1-1, N2+L2-1));

M = size(A,2);
N = size(A,1); 
[x y] = meshgrid(linspace(-M/2, M/2, M), linspace(-N/2, N/2, N));
FT = B.*H;

if(disp == 1) 
    
    figure('NumberTitle', 'off', 'Name', sprintf('analysis %s ',img_path));
    surf(x*2/M, y*2/N, 20*log10(abs(FT)));
    view(2);
    title('filter out the target band of styled image');
    rotate3d on;

end



