close all;
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
for i = 1:5
    fil = sprintf("../img/%s_rs.png", arr(i));
    styl = sprintf("../img/%s_starry.png", arr(i));
    fil = fil{1};
    styl = styl{1};
    if(~(isfile(fil) && isfile(styl)))
        disp(fil);
        disp("fail");
        continue
    end
    filter2d_funcfft(fil, styl, 1);
%     filters = [filters; F(:)'];
%     imgs = [imgs; imgX(:)'];
%     break;
end
