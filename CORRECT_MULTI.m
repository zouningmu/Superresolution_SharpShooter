clc;clear;
sva = 1;smoothp = 5; % point for smooth
%%%%%%%%%%%%%%%%%%%%%%%++++++++++++++++++++++++++


FILEname='D:\Research\2013 spring\SingleMolecule Data\20130521Au-SiO2-RZ 250nM\data\-40V\beforecorrect\';    % file name for original data. ALL TXT FILES SHOULD BE ORIGINAL DATA
marks = 'D:\Research\2013 spring\SingleMolecule Data\20130521Au-SiO2-RZ 250nM\data\-40V\background\total_background.txt'; % position of marks
outFILEname='D:\Research\2013 spring\SingleMolecule Data\20130521Au-SiO2-RZ 250nM\data\-40V\aftercorrect\';  % The place you want to save the data after drift correction




dirname=[FILEname '*txt' ];
file=dir(dirname);
for n=1:length(file)
    nanoparticle{n}=[FILEname,file(n).name];
    outfile{n}=[outFILEname file(n).name];
end




% nanoparticle = 'D:\Research\2012 spring\04062012_xczGNR_RZtoRF\150nM_auto_threshold\x251y149.txt';  % file for nanoparticle
% outfile = 'D:\Research\2012 spring\04062012_xczGNR_RZtoRF\150nM_auto_threshold\x251y149_correct1.txt';


for ii=1:length(file)
clearvars -except sva  smoothp ii FILEname marks outFILEname dirname file nanoparticle outfile cond

error_x =300;   % nm  +/-  x direction  error bar
error_y = 300;   % nm  +/-  y direction

max_rangex = 200;   % nm
%%%%%%%%%%%%%%%%%%%%%%%++++++++++++++++++++++++++
dx = max_rangex/100;
max_rangey = max_rangex;   % nm image range to show. times for distribution range
dy = dx;  %nm
[ave_y ave_y2] = textread(marks,'  %f    %f');
[siy tty] = size(ave_y);

% start correction
[A, B, C, D, sigmax, sigmay, x0, y0, erx, ery, startp, endp]=textread(nanoparticle{ii},'  %f    %f    %f    %f    %f    %f    %f    %f    %f    %f    %f    %f');
erx = abs(erx);
ery = abs(ery);
df = endp(1) - startp(1) + 1;   % frames for bin

[len1 jkjk] = size(A);

% filt big error bar
n = 1;
for i = 1:len1
    if ( erx(i) <= error_x ) && ( ery(i) <= error_y )
        gA(n) = A(i);
        gB(n) = B(i);
        gC(n) = C(i);
        gD(n) = D(i);
        gsigmax(n) = sigmax(i);
        gsigmay(n) = sigmay(i);
        gx(n) = x0(i);
        gy(n) = y0(i);
        gex(n) = erx(i);
        gey(n) = ery(i);
        gstartp(n) = startp(i);
        gendp(n) = endp(i);
        n = n+1;
    end
end
A = gA;
B = gB;
C = gC;
D = gD;
sigmax = gsigmax;
sigmay = gsigmay;
x0 = gx;
y0 = gy;
erx = gex;
ery = gey;
startp = gstartp;
endp = gendp;
len1 = n-1;


% positon correction
% subplot(2,2,1); plot(x0); axis square; hold on
for i = 1:len1
    frame_pos = fix( ( startp(i) + endp(i) )/2 );
    if ( frame_pos > siy )
        tx0(i) = x0(i) - ave_y(siy) + ave_y(fix(siy/2));
        ty0(i) = y0(i) - ave_y2(siy) + ave_y2(fix(siy/2));
        continue
    end
    
    tx0(i) = x0(i) - ave_y(frame_pos) + ave_y(1);
    ty0(i) = y0(i) - ave_y2(frame_pos) + ave_y2(1);
end

% subplot(1,2,1); plot(tx0,'color','r'); axis square; hold off
% save data
outdata(:,1) = A';
outdata(:,2) = B';
outdata(:,3) = C';
outdata(:,4) = D';
outdata(:,5) = sigmax';
outdata(:,6) = sigmay';
outdata(:,7) = tx0';
outdata(:,8) = ty0';
outdata(:,9) = erx';
outdata(:,10) = ery';
outdata(:,11) = startp';
outdata(:,12) = endp';

% show results before and after correction
s_x0(len1) = 0;
for i = 1:len1
    for j = 1:len1
        s_x0(i) = s_x0(i) + abs( x0(i) - x0(j) );
    end
end
[minB lb] = min(s_x0);
center_x = x0(lb);
%%%%%%%%%%%%%%%%
s_y0(len1) = 0;
for i = 1:len1
    for j = 1:len1
        s_y0(i) = s_y0(i) + abs( y0(i) - y0(j) );
    end
end

[minB lb] = min(s_y0);
center_y = y0(lb);

x0 = x0 - center_x;
y0 = y0 - center_y;

% gauss
[X Y] = meshgrid( -max_rangex :dx: max_rangex,  -max_rangey :dy: max_rangey );

suf_sum =  0;

for i = 1:len1
    suf_sum = suf_sum + ( 1/( erx(i)*ery(i)*2*3.1415916 ) )* exp( -( X-x0(i) ).^2/erx(i)/erx(i)/2 - ( Y-y0(i) ).^2/ery(i)/ery(i)/2 );
end

if sva == 1
    hf=figure;
    set(hf,'renderer','Painters');
end


% subplot(1,2,1); surface( X, Y, suf_sum, 'LineStyle', 'none');xlabel('before correction');  axis square

% show corrected one
x0 = tx0;
y0 = ty0;
% show results before and after correction
s_x0 = 0;
s_x0(len1) = 0;
for i = 1:len1
    for j = 1:len1
        s_x0(i) = s_x0(i) + abs( x0(i) - x0(j) );
    end
end
[minB lb] = min(s_x0);
center_x = x0(lb);
%%%%%%%%%%%%%%%%
s_y0 = 0;
s_y0(len1) = 0;
for i = 1:len1
    for j = 1:len1
        s_y0(i) = s_y0(i) + abs( y0(i) - y0(j) );
    end
end

[minB lb] = min(s_y0);
center_y = y0(lb);

x0 = x0 - center_x;
y0 = y0 - center_y;

% gauss
suf_sum =  0;

for i = 1:len1
    suf_sum = suf_sum + ( 1/( erx(i)*ery(i)*2*3.1415916 ) )* exp( -( X-x0(i) ).^2/erx(i)/erx(i)/2 - ( Y-y0(i) ).^2/ery(i)/ery(i)/2 );
    %     subplot(1,2,2); surface( X, Y, suf_sum, 'LineStyle', 'none');axis square
    %     pause(0.01);
end

% subplot(1,2,2); surface( X, Y, suf_sum, 'LineStyle', 'none');xlabel('after correction'); axis square

%output results
result=outdata';
fid2=fopen(outfile{ii},'w');
fprintf(fid2,'%8.2f  %7.3f  %7.3f   %7.3f  %8.3f  %8.3f  %9.2f  %9.2f  %6.2f  %6.2f  %9.1f  %9.1f\n',result);
fclose(fid2);
close all
% outmsg=['All fittings are finished! Output file is     (' outfile ')'];
% msgbox(outmsg);



end

