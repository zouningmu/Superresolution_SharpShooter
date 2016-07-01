clc; clear;thr_2 = 5;
%%%%%%%%%%%%%%%%%%%%%%%++++++++++++++++++++++++++
% imput moviefile name

moviefile(1) = cellstr('D:\Research\2013 spring\04062012_xczGNR_RZtoRF\Ningmu_50nM_RZ_20120406_Selector0.tif');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
outfile_total='D:\Research\2013 spring\04062012_xczGNR_RZtoRF\DATA\background\50nM\';



bin_on_fr = 100;          % number of frames in on time




Num_Particle=input('How many particles do you want to gain: ');
framesize1 = 6;           % If framesize = 6, the window size is 13 x 13. for fitting
framesize2 = 3;           % for getting trace

num_frames = 10000;      % number of frames in your movie, each segment

% calculation for error bar
g = 300;                   % real gain not software| read from 1 color|check booklet for two
%S = 27.14;                 % CCD sensitivity, please check from Andor booklet   pre-Am  2.5 ==
S = 67.12;                 % CCD sensitivity, please check   pre-Am  1.0

QE = 0.97;                 % quantum efficiency
wavelength1 = 586;         % nm, for your flourescence
realpixelsize = 166.66667;                % nm, per pixel 90 == 166.66667, 60 == 266.66667
% precision modify
filter_iteration = 200;
n_iteration = 5000;
precision = 1e-5;         % precision for interation in function TDgaussfit
k = 10;                % cut grid to smallers , also see TDgaussfit.m
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%% GET Position of Particles
moviename = char( moviefile(1) );
startp = 0;
num = 1000;
while (1)
    a = double(imread(moviename,1+startp));
    if num_frames < num + startp
        for i =2 + startp:num_frames
            a = a + double(imread(moviename,i));
        end
        msgbox('Reach the end of file!');
        break
    else
        for i =2 + startp:num + startp
            a = a + double(imread(moviename,i));
        end
    end
    [awidth alength]=size(a);
    aflip=a;
    
    for p=1:awidth
        for w=1:alength
            aflip(p,w)=a(awidth-p+1,w);
        end    
    end
    
    contour (aflip,20); axis equal;
    
    button = questdlg('Next 500 frame???',...
        'Do you want to','No','Yes','Yes');
    if strcmp(button,'No')
        disp('Continue')
        break
    else
        startp = startp + num;
        clear a;
    end
end
clear a;
[X,Y] = ginput (Num_Particle);
close;
pause(0.01);

for i=1:Num_Particle
centerx(i) = round(X(i));
centery(i) = round(awidth-Y(i)+1);
end

for i=1:Num_Particle
    outfile{i}=[outfile_total 'x' num2str(centerx(i)) 'y' ...
        num2str(centery(i)) 'background' '.txt'];   
end



%% Main Program



% ^^^^^^^^^^^^^^^^^^^ parameter setting ^^^^^^^^^^^^^^^^^^^^^    UP
%              zzzzz    oo     u   u
%                 z    o  o    u   u
%                z     o  o    u   u 
%               z      o  o    u   u
%              zzzzz    oo      uuu
%             
%    
%
% VVVVVVVVVVVVVVVVV        main programme  vvvvvvvvvvvvvvvvvvv  Down

for i=1:length(centerx)
[pol fn] = size(moviefile);
moviename = char( moviefile(1) );
s_c1 = clock;
% get the center positon of bright point
% t_start is the start of trace
% [centerx centery tot_fr] = center(num_frames,moviename, centerx, centery);
% test the center, whether it can form a frame in framesize1
testf(centerx(i), centery(i), moviename, framesize1);
% get the trace from movie, and get the threshold
mytrace = gettrace(centerx(i), centery(i), moviename, framesize2, 1000);
[ thold_2, sigma, center ] = get_thold( mytrace, thr_2 );
% get the initial value for fitting
clear outdata N AN B C D N ;
outdata(1,1:8) = [ 1000, 0.01, 10, 0.01, 0.7, 0.7, 7, 7 ];


n = 1;
bre =0;
shift1 = 0;
AN = 0;
movie_ind = 1;

indexf = 1;
startp = 1;

while (1)
    
    [ ontime_frame, indexf, mytrace, movie_ind, bre, thold_2 ] = ...
        get_ontime_frames( indexf, movie_ind, num_frames, mytrace, thr_2, thold_2, centerx(i), centery(i), moviefile, framesize1, framesize2, bin_on_fr );    
    
    if bre == 1
        break
    end  
    
    if ontime_frame == 0        
        continue        
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
    showprocess( movie_ind, indexf-1, num_frames, erx, ery, sigmax, realpixelsize, sigmay, c1, s_c1 );
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
% fclose('all');plot(mytrace);
% 
% outfile1 = [outfile_total 'x' num2str(centerx(i)) 'y' ...
%         num2str(centery(i)) 'BackgroundTrace' '.txt'];
% fid2=fopen(outfile1,'w');
% fprintf(fid2,'%10.5f\n',mytrace);
% fclose(fid2);


fclose('all');


end

clearvars -except outfile_total outfile Num_Particle centerx centery;

%% Markers (combine all the background files into one)

smoothp = 5; % point for smooth
%%%%%%%%%%%%%%%%%%%%%%%++++++++++++++++++++++++++

for i=1:Num_Particle
   markp(i)=cellstr(outfile{i});    
end


backgroundoutfile =[outfile_total 'total_background.txt'];

error_x = 15.5;   % nm  +/-  x direction  error bar
error_y = 15.5;   % nm  +/-  y direction
%%%%%%%%%%%%%%%%%%%%%%%++++++++++++++++++++++++++
[pol fn] = size(markp);
% outxi(1,240000) = 0;
% outyi(1,240000) = 0;

for j=1:fn;

    infile = char( markp(j) );
    [A, B, C, D, sigmax, sigmay, x0, y0, erx, ery, startp, endp]=textread(infile,'  %f    %f    %f    %f    %f    %f    %f    %f    %f    %f    %f    %f');
    df = endp(1) - startp(1) + 1;   % frames for bin
    erx = abs(erx);
    ery = abs(ery);
    
    [len1 jkjk] = size(A);
    plot(x0,y0); hold on
    
    % filt big error bar
    n = 1;
    for i = 1:len1
        if ( erx(i) <= error_x ) && ( ery(i) <= error_y )
            gx(n) = x0(i);
            gy(n) = y0(i);
            gex(n) = erx(i);
            gey(n) = ery(i);
            gstartp(n) = startp(i);
            gendp(n) = endp(i);
            n = n+1;
        end    
    end
    x0 = gx;
    y0 = gy;
    erx = gex;
    ery = gey;
    startp = gstartp;
    endp = gendp;
    len1 = n-1;
    clear gx gy gex gey gstartp gendp;
    
    % interpolate rare data to get a full view
    xi = startp(1):df:startp(len1)+df;
    yi=interp1(startp,x0,xi);
    y2 = interp1(startp,y0,xi);
    % smooth the full view
    yy = smooth(xi,yi,smoothp);
    yy2 = smooth(xi,y2,smoothp);
    % interpolate smoothed data to each frame
    outxi(j,startp(1):startp(len1)) = startp(1):startp(len1);
    outyi(j,startp(1):startp(len1)) = interp1(xi,yy,outxi(j,startp(1):startp(len1)));     
    outy2(j,startp(1):startp(len1)) = interp1(xi,yy2,outxi(j,startp(1):startp(len1)));

end

[files len2] = size(outxi);
for i = 1:len2
    temy = 0;
    temy2 = 0;
    n = 0;
    for j = 1:files
        if outyi(j,i) > 0
            n = n+1;
            temy = temy + outyi(j,i);
            temy2 = temy2 + outy2(j,i);
        end        
    end
    ave_y(i) = temy/n;
    ave_y2(i) = temy2/n;
end

outdata(1,:) = ave_y;
outdata(2,:) = ave_y2;
plot(ave_y,ave_y2,'color','r'); hold off

result=outdata;
fid2=fopen(backgroundoutfile,'w');
fprintf(fid2,'%10.5f   %10.5f \n',result);
fclose(fid2);

outmsg=['All fittings are finished! Output file is     (' backgroundoutfile ')'];
msgbox(outmsg);  



