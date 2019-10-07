% tmp = imread('../img/van_gogh.jpg');
% A = fftshift(fft2(tmp,  64, 64));
% M = size(A,2);
% N = size(A,1);
% [x y] = meshgrid(linspace(-M/2, M/2, M), linspace(-N/2, N/2, N));
% figure; surf(x*2/M, y*2/N, 180/pi*(angle(A(:,:,1))));
% figure; surf(x*2/M, y*2/N, 20*log10(abs(A(:,:,1))));
% close
arr = ["000000000139",
"000000000632",
"000000298396",
"000000298697",
"000000299609",
"000000319935",
"000000419201",
"000000529568",
"000000529966",
"car1",
"car2",
"chicago",
"foggysf1",
"foosball",
"golden_gate",
"hoovertowernight",
"john-reed-727447-unsplash",
"micromarket",
"mit",
"photo-1558446007-a2e07be0b0c4",
"tomasz-filipek-1175510-unsplash",
"toysflash",
"trailer",
"tubingen"];
filters = [];
imgs = [];
for i = 1:length(arr)
    fil = sprintf("../img/%s_rs.png", arr(i));
    styl = sprintf("../img/%s_starry.png", arr(i));
    fil = fil{1};
    styl = styl{1};
    if(~(isfile(fil) && isfile(styl)))
        disp(fil);
        disp("fail");
        continue
    end
    fil
    [F imgX] = funcfft(fil, styl, 1);
    filters = [filters; F(:)'];
    imgs = [imgs; imgX(:)'];
end

figure('NumberTitle', 'off', 'Name', 'amplitude');
for t = 1:12
    idx = randi(4096);
    tx = imgs(:, idx);
    ty = filters(:, idx);
    idx = (abs(ty - mean(ty)) < 2*std(ty));
    ty = ty(idx);
    tx = tx(idx);
    sss = std(ty);
    tx = (tx-mean(tx))/std(tx);
    ty = (ty-mean(ty))/std(ty);
    subplot(4,3,t);
    scatter(tx, ty);
    [ft, gof, output] = fit(tx, ty, 'poly1');
    
    hold on;
    plot(ft, tx, ty);
    title(sprintf("%f | %f | %d", gof.rsquare, sss, sum(idx(:))));
end
