function showspec(A)
M = size(A,2);
N = size(A,1); 
[x y] = meshgrid(linspace(-M/2, M/2, M), linspace(-N/2, N/2, N));
figure;
surf(x*2/M, y*2/N, 20*log10(abs(A(:,:,1))));
title("dB");
view(2);
figure;
surf(x*2/M, y*2/N, 180/pi*(angle(A(:,:,1))));
title("degree");
view(2);