clc; clear all;
%%%%%%%%%%%%%%%%%%%%%%%++++++++++++++++++++++++++
moviefile(1) = cellstr('H:\gold_nanorod\092910\1_a_p10_rod_200_nM_60mM_H2O2\movie\1_a_p10_rod_200_nM_60mM_H2O2_Selector.tif');
moviefile(2) = cellstr('H:\gold_nanorod\092910\1_a_p10_rod_200_nM_60mM_H2O2\movie\1_a_p10_rod_200_nM_60mM_H2O2_Selector1.tif');
moviefile(3) = cellstr('H:\gold_nanorod\092910\1_a_p10_rod_200_nM_60mM_H2O2\movie\1_a_p10_rod_200_nM_60mM_H2O2_Selector2.tif');
moviefile(4) = cellstr('H:\gold_nanorod\092910\1_a_p10_rod_200_nM_60mM_H2O2\movie\1_a_p10_rod_200_nM_60mM_H2O2_Selector3.tif');
moviefile(5) = cellstr('H:\gold_nanorod\092910\1_a_p10_rod_200_nM_60mM_H2O2\movie\1_a_p10_rod_200_nM_60mM_H2O2_Selector4.tif');
moviefile(6) = cellstr('H:\gold_nanorod\092910\1_a_p10_rod_200_nM_60mM_H2O2\movie\1_a_p10_rod_200_nM_60mM_H2O2_Selector5.tif');
moviefile(7) = cellstr('H:\gold_nanorod\092910\1_a_p10_rod_200_nM_60mM_H2O2\movie\1_a_p10_rod_200_nM_60mM_H2O2_Selector6.tif');
moviefile(8) = cellstr('H:\gold_nanorod\092910\1_a_p10_rod_200_nM_60mM_H2O2\movie\1_a_p10_rod_200_nM_60mM_H2O2_Selector7.tif');
moviefile(9) = cellstr('H:\gold_nanorod\092910\1_a_p10_rod_200_nM_60mM_H2O2\movie\1_a_p10_rod_200_nM_60mM_H2O2_Selector8.tif');
moviefile(10) = cellstr('H:\gold_nanorod\092910\1_a_p10_rod_200_nM_60mM_H2O2\movie\1_a_p10_rod_200_nM_60mM_H2O2_Selector9.tif');
moviefile(11) = cellstr('H:\gold_nanorod\092910\1_b_p10_rod_200_nM_60mM_H2O2\movie\1_b_p10_rod_200_nM_60mM_H2O2_Selector.tif');
moviefile(12) = cellstr('H:\gold_nanorod\092910\1_b_p10_rod_200_nM_60mM_H2O2\movie\1_b_p10_rod_200_nM_60mM_H2O2_Selector1.tif');
moviefile(13) = cellstr('H:\gold_nanorod\092910\1_b_p10_rod_200_nM_60mM_H2O2\movie\1_b_p10_rod_200_nM_60mM_H2O2_Selector2.tif');
moviefile(14) = cellstr('H:\gold_nanorod\092910\1_b_p10_rod_200_nM_60mM_H2O2\movie\1_b_p10_rod_200_nM_60mM_H2O2_Selector3.tif');
moviefile(15) = cellstr('H:\gold_nanorod\092910\1_b_p10_rod_200_nM_60mM_H2O2\movie\1_b_p10_rod_200_nM_60mM_H2O2_Selector4.tif');
moviefile(16) = cellstr('H:\gold_nanorod\092910\1_b_p10_rod_200_nM_60mM_H2O2\movie\1_b_p10_rod_200_nM_60mM_H2O2_Selector5.tif');
moviefile(17) = cellstr('H:\gold_nanorod\092910\1_b_p10_rod_200_nM_60mM_H2O2\movie\1_b_p10_rod_200_nM_60mM_H2O2_Selector6.tif');
moviefile(18) = cellstr('H:\gold_nanorod\092910\1_b_p10_rod_200_nM_60mM_H2O2\movie\1_b_p10_rod_200_nM_60mM_H2O2_Selector7.tif');
moviefile(19) = cellstr('H:\gold_nanorod\092910\1_b_p10_rod_200_nM_60mM_H2O2\movie\1_b_p10_rod_200_nM_60mM_H2O2_Selector8.tif');
moviefile(20) = cellstr('H:\gold_nanorod\092910\1_b_p10_rod_200_nM_60mM_H2O2\movie\1_b_p10_rod_200_nM_60mM_H2O2_Selector9.tif');
moviefile(21) = cellstr('H:\gold_nanorod\092910\1_c_p10_rod_200_nM_60mM_H2O2\movie\1_c_p10_rod_200_nM_60mM_H2O2_Selector.tif');
moviefile(22) = cellstr('H:\gold_nanorod\092910\1_c_p10_rod_200_nM_60mM_H2O2\movie\1_c_p10_rod_200_nM_60mM_H2O2_Selector1.tif');
moviefile(23) = cellstr('H:\gold_nanorod\092910\1_c_p10_rod_200_nM_60mM_H2O2\movie\1_c_p10_rod_200_nM_60mM_H2O2_Selector2.tif');
moviefile(24) = cellstr('H:\gold_nanorod\092910\1_c_p10_rod_200_nM_60mM_H2O2\movie\1_c_p10_rod_200_nM_60mM_H2O2_Selector3.tif');
moviefile(25) = cellstr('H:\gold_nanorod\092910\1_c_p10_rod_200_nM_60mM_H2O2\movie\1_c_p10_rod_200_nM_60mM_H2O2_Selector4.tif');
moviefile(26) = cellstr('H:\gold_nanorod\092910\1_c_p10_rod_200_nM_60mM_H2O2\movie\1_c_p10_rod_200_nM_60mM_H2O2_Selector5.tif');
moviefile(27) = cellstr('H:\gold_nanorod\092910\1_c_p10_rod_200_nM_60mM_H2O2\movie\1_c_p10_rod_200_nM_60mM_H2O2_Selector6.tif');
moviefile(28) = cellstr('H:\gold_nanorod\092910\1_c_p10_rod_200_nM_60mM_H2O2\movie\1_c_p10_rod_200_nM_60mM_H2O2_Selector7.tif');
moviefile(29) = cellstr('H:\gold_nanorod\092910\1_c_p10_rod_200_nM_60mM_H2O2\movie\1_c_p10_rod_200_nM_60mM_H2O2_Selector8.tif');
moviefile(30) = cellstr('H:\gold_nanorod\092910\1_c_p10_rod_200_nM_60mM_H2O2\movie\1_c_p10_rod_200_nM_60mM_H2O2_Selector9.tif');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
outfile_total='D:\Research\2013 spring\XiaochunHeritage\20100929\a-c\linkage\origin\';

%% Must Change EVERYTIME !!
centerx=[240 289 380];
centery=[157 159 126];

% 167

threshold_by_hand = 0;  % 1 or 0; if 1, thr_1 and thr_2 will not work. if 0, thr_1 and thr_2 will work.
thr_1 = 2.5;   % low threshold , need time sigma
thr_2 = 3;     % high threshold


framesize1 = 6;           % If framesize = 6, the window size is 13 x 13. for fitting
framesize2 = 3;           % for getting trace

num_frames = 10000;      % number of frames in your movie, each segment

% calculation for error bar
g = 300;                   % real gain not software| read from 1 color|check booklet for two
S = 27.14;                 % CCD sensitivity, please check from Andor booklet   pre-Am  2.5 ==
%S = 67.12;                 % CCD sensitivity, please check   pre-Am  1.0

QE = 0.97;                 % quantum efficiency
wavelength1 = 586;         % nm, for your flourescence
realpixelsize = 266.66667;                % nm, per pixel 90 == 166.66667, 60 == 266.66667
% precision modify
filter_iteration = 200;
n_iteration = 5000;
precision = 1e-5;         % precision for interation in function TDgaussfit
k = 10;                % cut grid to smallers , also see TDgaussfit.m

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
moviename = char( moviefile(1) );
Num_Particle=length(centerx);
for i=1:Num_Particle
    if centerx(i)>=100 && centery(i)>=100
        xy{i}=['x' num2str(centerx(i)) 'y' ...
            num2str(centery(i))];
    elseif centerx(i)<100 && centery(i)>=100
        xy{i}=['x' '0' num2str(centerx(i)) 'y' ...
            num2str(centery(i))];
    elseif centerx(i)>=100 && centery(i)<100
        xy{i}=['x' num2str(centerx(i)) 'y' ...
            '0' num2str(centery(i))];
    elseif centerx(i)<100 && centery(i)<100
        xy{i}=['x' '0' num2str(centerx(i)) 'y' ...
            '0' num2str(centery(i))];
    end
    
    outfile{i}=[outfile_total xy{i} '.txt'];
end

%%%%%%%%%%%%%%%%%%%%%%%%++++++++++++++++++++++++++++++++++++++++++
% fitting function: z = A * exp( (x-x0)^2/2/sigmax^2  +  (y-y0)^2/2/sigmay^2 ) + D*x + B*y + C
% erx : errorbar of x direction
% ery : errorbar of y direction
% output data format:
% A, B, C, D, sigmax, sigmay, x0, y0, erx; ery; startp; endp
% ^^^^^^^^^^^^^^^^^^^ parameter setting ^^^^^^^^^^^^^^^^^^^^^    UP

%
% zzzzzzzzzzzz         oooooooooo        uu              uu
%          zz         oo        oo       uu              uu
%         zz         oo          oo      uu              uu
%        zz         oo            oo     uu              uu
%       zz         oo              oo    uu              uu
%      zz          oo              oo    uu              uu
%     zz           oo              oo    uu              uu
%    zz             oo            oo     uu              uu
%   zz               oo          oo       uu            uu
%  zz                 oo        oo         uu          uu
% zzzzzzzzzzz          oooooooooo            uuuuuuuuuu

%
% VVVVVVVVVVVVVVVVV        main programme  vvvvvvvvvvvvvvvvvvv  Down
for i=1:length(centerx)
    
    
    [pol fn] = size(moviefile);
    moviename = char( moviefile(1) );
    s_c1 = clock;
    
    % get the center positon of bright point
    % t_start is the start of trace
    % plot( 44,169,'*'); hold on
    % [centerx centery tot_fr] = center( num_frames,moviename, centerx, centery );
    % test the center, whether it can form a frame in framesize1
    testf(centerx(i), centery(i), moviename, framesize1);
    
    % get the trace from movie, and get the threshold
    mytrace = gettrace(centerx(i), centery(i), moviename, framesize2, 1000);
    
    if threshold_by_hand == 1
        [ thr_1, thr_2 ] = get_thr_1_thr_2_by_hand( mytrace );
    end
    
    [ thold_1, thold_2, sigma, center ] = get_thold( mytrace, thr_1, thr_2 );
    % get the initial value for fitting
    clear outdata
    outdata(1,:) = [ 1000, 0.01, 10, 0.01, 0.7, 0.7, 7, 7 ];
    
    %% main programme
    n = 1;
    bre =0;
    shift1 = 0;
    AN = 0;
    movie_ind = 1;
    pause(0.01);
    
    indexf = 1;
    while (1)
        
        [ontime_frame, startp, indexf, sub_frame, mytrace, movie_ind, bre, thold_1, thold_2, center ] = ...
            get_ontime_frames( indexf, movie_ind, num_frames, mytrace, thr_1, thr_2, thold_1, thold_2, center, centerx(i), centery(i), moviefile, framesize1, framesize2 );
        
        ontime_frame = ontime_frame - sub_frame;
        
        if bre == 1
            break
        end
        
        c1 = clock;
        % fit the ontime_frame with 2D gaussion function
        [A, B, C, D, sigmax, sigmay, x0, y0, singlefgauss, jud2] =  ...
            TDgaussfit(ontime_frame, framesize1, precision, k, outdata, n_iteration, filter_iteration, g, S, QE, wavelength1, realpixelsize);
        
        if jud2 == 0
            disp('_______________________________________________________________________________________________________');
            continue
        end
        
        outdata(n,1:8) = [ A B C D sigmax sigmay x0 y0 ];
        
        % error bar
        N = photons( A, B, C, D, sigmax, sigmay, x0, y0, g, S, QE, wavelength1, framesize1,k);  % get the photon number
        background = photo_bg(singlefgauss, ontime_frame, g, S, QE, wavelength1 );
        [erx ery] = errorbar_xy(sigmax, sigmay, realpixelsize, background, N);
        if erx > 2000 || ery > 2000   % error bar is too big to save
            continue
        end
        
        outdata(n,9) = erx;
        outdata(n,10) = ery;
        outdata(n,11) = startp;
        outdata(n,12) = indexf - 1 + ( movie_ind - 1 )*num_frames ;
        AN(n) = N;
        
        n = n+1;
        
        showprocess( movie_ind, indexf, num_frames, erx, ery, sigmax, realpixelsize, sigmay, c1, s_c1 );
        %     break
    end
    
    
    outdata(:,1) = AN';
    outdata(:,5) = outdata(:,5)*realpixelsize;
    outdata(:,6) = outdata(:,6)*realpixelsize;
    outdata(:,7) = ( outdata(:,7) + centerx(i) - framesize1 -1 )*realpixelsize;
    outdata(:,8) = ( outdata(:,8) + centery(i) - framesize1 -1 )*realpixelsize;
    
    
    
    %% output fitting results
    result=outdata';
    fid2=fopen(outfile{i},'w');
    fprintf(fid2,'%8.2f  %8.3f  %8.3f  %7.3f  %8.3f  %8.3f  %9.2f  %9.2f  %6.2f  %6.2f  %7.0f  %7.0f\n',result);
    fclose(fid2);
    
    %% output trace
    plot(mytrace);
    outfile1 = [outfile_total xy{i} 'trace' '.csv'];
    fid2=fopen(outfile1,'w');
    fprintf(fid2,'%10.5f\n',mytrace);
    fclose(fid2);
    pause(0.1);
    outfile2 = [outfile_total xy{i} 'trace'];
    print(gcf,'-dpng',outfile2);
    
    
    
    
end









