clc; clear;
thr_2 = 5;
%%%%%%%%%%%%%%%%%%%%%%%++++++++++++++++++++++++++
moviefile(1) = cellstr('D:\Research\2012 spring\04142012_nzGNR_LaserIntensity_RZ\Ningmu_100nM_RZ_320degree_20120414_Selector1.tif');
moviefile(2) = cellstr('D:\Research\2012 spring\04142012_nzGNR_LaserIntensity_RZ\Ningmu_100nM_RZ_320degree_20120414_Selector1.tif');
moviefile(3) = cellstr('D:\Research\2012 spring\04142012_nzGNR_LaserIntensity_RZ\Ningmu_100nM_RZ_320degree_20120414_Selector2.tif');
moviefile(4) = cellstr('D:\Research\2012 spring\04142012_nzGNR_LaserIntensity_RZ\Ningmu_100nM_RZ_320degree_20120414_Selector3.tif');
moviefile(5) = cellstr('D:\Research\2012 spring\04142012_nzGNR_LaserIntensity_RZ\Ningmu_100nM_RZ_320degree_20120414_Selector4.tif');
moviefile(6) = cellstr('D:\Research\2012 spring\04142012_nzGNR_LaserIntensity_RZ\Ningmu_100nM_RZ_320degree_20120414_Selector5.tif');
moviefile(7) = cellstr('D:\Research\2012 spring\04142012_nzGNR_LaserIntensity_RZ\Ningmu_100nM_RZ_320degree_20120414_Selector6.tif');
moviefile(8) = cellstr('D:\Research\2012 spring\04142012_nzGNR_LaserIntensity_RZ\Ningmu_100nM_RZ_320degree_20120414_Selector7.tif');
moviefile(9) = cellstr('D:\Research\2012 spring\04142012_nzGNR_LaserIntensity_RZ\Ningmu_100nM_RZ_320degree_20120414_Selector8.tif');
moviefile(10) = cellstr('D:\Research\2012 spring\04142012_nzGNR_LaserIntensity_RZ\Ningmu_100nM_RZ_320degree_20120414_Selector9.tif');

centerx = 112; % particle position in your movie
centery = 162; % find the red circle


outfile='D:\Research\2012 spring\04062012_xczGNR_RZtoRF\150nM_auto_threshold\x112y162  background 1.txt';
framesize1 = 6;           % If framesize = 6, the window size is 13 x 13. for fitting
framesize2 = 3;           % for trace

num_frames = 10000;      % number of frames in your movie, each segment
bin_on_fr = 50;          % number of frames in on time
% calculation for error bar
g = 300;                   % real gain not software| read from 1 color|check booklet for two
% S = 27.14;                 % CCD sensitivity, please check from Andor booklet   pre-Am  2.5 ==
S = 67.12;                 % CCD sensitivity, please check   pre-Am  1.0

QE = 0.97;                 % quantum efficiency
wavelength1 = 586;         % nm, for your flourescence
a = 166.66667;                % nm, per pixel 90 == 166.66667, 60 == 266.66667
% precision modify
filter_iteration = 200;
n_iteration = 5000;
precision = 1e-5;         % precision for interation in function TDgaussfit
k = 10;                % cut grid to smallers , also see TDgaussfit.m
%%%%%%%%%%%%%%%%%%%%%%%%++++++++++++++++++++++++++++++++++++++++++
% fitting function: z = A * exp( (x-x0)^2/2/sigmax^2  +  (y-y0)^2/2/sigmay^2 ) + D*x + B*y + C
% erx : errorbar of x direction
% ery : errorbar of y direction
% output data format:
% A, B, C, D, sigmax, sigmay, x0, y0, erx; ery; startp; endp

% ^^^^^^^^^^^^^^^^^^^ parameter setting ^^^^^^^^^^^^^^^^^^^^^    UP
%   |---------------|
%   |       |       |
%   |      -| -     |
%   |    -------    |
%   |     |~~|      |
%   |      ~~       |
%  /                V
%
% VVVVVVVVVVVVVVVVV        main programme  vvvvvvvvvvvvvvvvvvv  Down
[pol fn] = size(moviefile);
moviename = char( moviefile(1) );
s_c1 = clock;
% get the center positon of bright point
% t_start is the start of trace
[centerx centery tot_fr] = center(num_frames,moviename, centerx, centery);
% test the center, whether it can form a frame in framesize1
testf(centerx, centery, moviename, framesize1);
% get the trace from movie, and get the threshold
mytrace = gettrace(centerx, centery, moviename, framesize2, 1000);
[ thold_2, sigma, center ] = get_thold( mytrace, thr_2 );
% get the initial value for fitting
outdata(1,1:8) = [ 1000, 0.01, 10, 0.01, 0.7, 0.7, 7, 7 ];

%% main programme
n = 1;
bre =0;
shift1 = 0;
AN = 0;
movie_ind = 1;

indexf = 1;
startp = 1;

while (1)
    
    [ ontime_frame, indexf, mytrace, movie_ind, bre, thold_2 ] = ...
        get_ontime_frames( indexf, movie_ind, num_frames, mytrace, thr_2, thold_2, centerx, centery, moviefile, framesize1, framesize2, bin_on_fr );    
    
    if bre == 1
        break
    end  
    
    if ontime_frame == 0        
        continue        
    end  
    
    
    
    c1 = clock;
    % fit the ontime_frame with 2D gaussion function
    [A, B, C, D, sigmax, sigmay, x0, y0, singlefgauss, jud2] =  ...
        TDgaussfit(ontime_frame, framesize1, precision, k, outdata, n_iteration, filter_iteration, g, S, QE, wavelength1, a);
    
    if jud2 == 0
        disp('_______________________________________________________________________________________________________');
        continue
    end
    
    outdata(n,1:8) = [ A B C D sigmax sigmay x0 y0 ];
    
    % error bar
    N = photons( A, B, C, D, sigmax, sigmay, x0, y0, g, S, QE, wavelength1, framesize1,k);  % get the photon number
    background = photo_bg(singlefgauss, ontime_frame, g, S, QE, wavelength1 );
    [erx ery] = errorbar_xy(sigmax, sigmay, a, background, N);
    if erx > 100 || ery > 100   % error bar is too big to save
        continue
    end
    
    outdata(n,9) = erx;
    outdata(n,10) = ery;
    outdata(n,12) = indexf - 1 + ( movie_ind - 1 )*num_frames ;
    outdata(n,11) = outdata(n,12) - bin_on_fr + 1;
    
    AN(n) = N;
    
    n = n+1;
    startp = indexf;
    showprocess( movie_ind, indexf-1, num_frames, erx, ery, sigmax, a, sigmay, c1, s_c1 );
%     break
end

outdata(:,1) = AN';
outdata(:,5) = outdata(:,5)*a;
outdata(:,6) = outdata(:,6)*a;
outdata(:,7) = ( outdata(:,7) + centerx - framesize1 -1 )*a;
outdata(:,8) = ( outdata(:,8) + centery - framesize1 -1 )*a;


%% output fitting results
result=outdata';
fid2=fopen(outfile,'w');
fprintf(fid2,'%8.2f  %8.3f  %8.3f  %7.3f  %8.3f  %8.3f  %9.2f  %9.2f  %6.2f  %6.2f  %7.0f  %7.0f\n',result);
fclose(fid2);

%% output trace
plot(mytrace);

outfile1 = [outfile 'backgroundtrace' '.txt'];
fid2=fopen(outfile1,'w');
fprintf(fid2,'%10.5f\n',mytrace);
fclose(fid2);












