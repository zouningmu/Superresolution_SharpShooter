clc;clear all;clf;close all


FILEname='  ';  % the file name contain the txt files after drift correction
Expecond=' ';   %Can add the condition of experiment


%% some parameters can be changed

explosuretime=30;     % USE (ms) AS UNIT
range=600;
minidealsigma=100; % can modify--to remove the unreasonable small sigma for PSF of a single fluorescent
maxidealsigma=600; % can modify--to remove the unreasonable small sigma for PSF of a single fluorescent



%%

dirname=[FILEname '*.exe' ];
file=dir(dirname);
for n=1:length(file)
    nanoparticle_cor{n}=dlmread([FILEname,file(n).name]);
end

for i=1:length(file)
    
    sigmax{i}=nanoparticle_cor{i}(:,5);
    sigmay{i}=nanoparticle_cor{i}(:,6);
    xcor{i}=nanoparticle_cor{i}(:,7);
    ycor{i}=nanoparticle_cor{i}(:,8);
    tonstart{i}=nanoparticle_cor{i}(:,11);
    toffstart{i}=nanoparticle_cor{i}(:,12);
end
%
number_of_event=zeros(length(file));
mkdir([FILEname 'histogramoftaoon']);
mkdir([FILEname 'sigmadistri&SRR']);


for i=1:length(file)
    for j=1:length(sigmax{i})
        if sigmax{i}(j)>=minidealsigma && sigmay{i}(j)>=minidealsigma &&...
                sigmax{i}(j)<=maxidealsigma && sigmax{i}(j)<=maxidealsigma
            number_of_event(i)=number_of_event(i)+1;
            ton{i}(number_of_event(i))=nanoparticle_cor{i}(j,12)-nanoparticle_cor{i}(j,11)+1;
            
        end
        
    end
    
    if number_of_event(i)==0
        ton{i}=0;
        continue
    end
    
    cellnumber_of_event_taoon{i,1}=number_of_event(i);
    cellnumber_of_event_taoon{i,2}=ton{i};
    cutton{i}=sort(ton{i});
    cutton_for_origin{i}=cutton{i}';
    cellnumber_of_event_taoon{i,3}=mean(cutton{i}(3:length(cutton{i})-2));
    %     hist(ton{1,i},max(ton{1,i}));
    %     pause(1);
    cellnumber_of_event_taoon{i,4}=cellnumber_of_event_taoon{i,3}*explosuretime;
    cellnumber_of_event_taoon{i,5}=file(i).name;
    cellnumber_of_event_taoon{i,6}=Expecond;
    cellnumber_of_event_taoon{i,7}='--> # of events';
    cellnumber_of_event_taoon{i,8}=number_of_event(i);
    cellnumber_of_event_taoon{i,9}=file(i).name;
    cellnumber_of_event_taoon{i,10}=Expecond;
    
    %% hist of tao_on
    if length(cutton{i})<5
        continue
    end
    
    hist(cutton{i}(3:length(cutton{i})-2),(0:1:cutton{i}(length(cutton{i})-2)));
    title(['histogram of ' file(i).name]);
    xlabel('Tao on duration frames');
    ylabel('appearence frequency');
    lengthofFILEname(i)=length(file(i).name);
    histopath=[FILEname 'histogramoftaoon' '\' file(i).name(1:lengthofFILEname(i)-4)];
    print(gcf,'-dpng',histopath);
    close all;
    
    
    %     %% hist of sigmax & sigmay
    %     %pause(0.1);
    %     subplot(2,2,1);
    %     scatter(sigmax{i},sigmay{i},'.');axis equal;
    %
    %     subplot(2,2,2);
    %     hist(sigmax{i},15);
    %     xlabel('sigma x');
    %     title(['sigma x distribution ' file(i).name]);
    %
    %     subplot(2,2,3);
    %     hist(sigmay{i},15);
    %     xlabel('sigma y');
    %     title(['sigma y distribution ' file(i).name]);
    %
    %     sigmadistripath=[FILEname 'sigmadistri' '\' file(i).name(1:lengthofFILEname(i)-4)];
    %     print(gcf,'-dpng',sigmadistripath);
    %     close;
    
end

%% Plot signal positions to get superresolution image
dirname=[FILEname '*.txt' ];
file=dir(dirname);
for n=1:length(file)
    nanoparticle_cor{n}=[FILEname,file(n).name];
end

mkdir([FILEname 'SRR image']);

for ii=1:length(nanoparticle_cor)
    clearvars -except nanoparticle_cor  pixels_per_nm SEMrange minidealsigma maxidealsigma nanometerperpixel range ii file Expecond FILEname...
        cellnumber_of_event_taoon sigmax sigmay;
    [A, B, C, D, sigmax2, sigmay2, x0, y0, erx, ery, startp, endp]=textread(nanoparticle_cor{ii},'  %f    %f    %f    %f    %f    %f    %f    %f    %f    %f    %f    %f');
    erx = abs(erx);
    ery = abs(ery);
    totalnum=size(x0);
    
    
    
    k=1;
    for i=1:totalnum
        if sigmax2(i)>=minidealsigma && sigmay2(i)>=minidealsigma &&...       % can modify
                sigmax2(i)<=maxidealsigma && sigmay2(i)<=maxidealsigma &&...
                x0(i)<=median(x0)+600 && x0(i)>=median(x0)-600 &&...    % can modify
                y0(i)<=median(y0)+600 && y0(i)>=median(y0)-600    % can modify
            xfil(k)=x0(i);
            yfil(k)=y0(i);
            k=k+1;
        end
    end
    
    
    if exist('xfil')==0
        continue
    end
    
    
    for t=1:length(xfil)
        xsca(t)=xfil(t)-mean(xfil);
        ysca(t)=yfil(t)-mean(yfil);
    end
    
    
    
    
    figure(ii);
    plot(xsca,ysca,'.');xlabel('after translation motion (nm)');
    title([file(ii).name ' ' Expecond]);
    axis([-range range -range range]) ;
    axis square ;
    
    lengthofFILEname(ii)=length(file(ii).name);
    SRR_imagepath=[FILEname 'SRR image' '\' file(ii).name(1:lengthofFILEname(ii)-4) ' ' Expecond];
    print(gcf,'-dpng',SRR_imagepath);
    close;
    
    %% hist of sigmax & sigmay
    %pause(0.1);
    figure(ii)
    subplot(2,2,1);
    scatter(sigmax{ii},sigmay{ii},'.');axis equal;
    
    subplot(2,2,3);
    hist(sigmax{ii},15);
    xlabel('sigma x');
    title(['sigma x distribution ' file(ii).name]);
    
    p22=subplot(2,2,2);
    hist(sigmay{ii},15);
    %     camroll(270);
    xlabel('sigma y');
    title(['sigma y distribution ' file(ii).name]);
    
    
    
    
    subplot(2,2,4);
    plot(xsca,ysca,'.');xlabel('after translation motion (nm)');
    title([file(ii).name ' ' Expecond]);
    axis([-range range -range range]) ;
    axis square ;
    
    sigmadistripath=[FILEname 'sigmadistri&SRR' '\' file(ii).name(1:lengthofFILEname(ii)-4)];
    print(gcf,'-dpng',sigmadistripath);
    close;
    
    
    
end








