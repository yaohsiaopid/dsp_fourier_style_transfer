% Create 2-D FIR Filter using 1-D Window Method from Mathwork 
% This example shows how to design an approximately circularly symmetric two-dimensional bandpass filter using a 1-D window method.
% Create the frequency range vectors f1 and f2 using freqspace. These vectors have length 21.
close all
clear
sz = 256;
[f1,f2] = freqspace(sz,'meshgrid');

% Compute the distance of each position from the center frequency.
r = sqrt(f1.^2 + f2.^2);

% Create a matrix Hd that contains the desired bandpass response. In this example, the desired passband is between 0.1 and 0.5 (normalized frequency, where 1.0 corresponds to half the sampling frequency, or  radians).
Hd = ones(sz); 
% Hd((r<0.5)|(r>0.7)) = 0;
Hd(r<0.5) = 0;

% Display the ideal bandpass response.
colormap(parula(256))
mesh(f1,f2,Hd)

% Design the 1-D window. This example uses a Hamming window of length 21.
L = 167;
M = L - 1;
alpha = M/2; n = 0:M;
wc = 0.1*pi;
hd = sinc(wc/pi*(n-alpha))*wc/pi; 
win = hd.*hamming(L)';
% win = 0.54 - 0.46*cos(2*pi*(0:20)/20);

% Plot the 1-D window.
figure;
plot(linspace(-1,1,L),win);

% Using the 1-D window, design the filter that best produces this frequency response
h = fwind1(Hd,win);

% Display the actual frequency response of this filter.
freqz2(h*10)
h = h * 10;
save('lp_fil_5_1.mat', 'h');

% view(90,0);
% view(2);

% figure
% freqz(h(84,:));


