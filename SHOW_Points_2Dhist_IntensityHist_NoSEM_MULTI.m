clc;clear;clf;close all



%% For Multi Particles

%FILEname='D:\Research\2012 spring\Xiaochun movie nanorods\Auto threshould\aftercorrect\';    % file name for data AFTER Correct.

FILEname='D:\Research\2013 spring\SingleMolecule Data\20130521Au-SiO2-RZ 250nM\data\40V\aftercorrect\';   % file name for data AFTER Correct.
Expecond='2D-Hist ';
binnumber=60;    % The bin number of 2d-hist

dirname=[FILEname '*.txt' ];
file=dir(dirname);
for n=1:length(file)
    nanoparticle_cor{n}=[FILEname,file(n).name];
end

%% For Single Particle
% nanoparticle_cor{1}='D:\Research\2012 spring\Xiaochun movie nanorods\Auto threshould\aftercorrect\x155y114 correct 1.txt'


%% \/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\\/\/\/\/\/\/\/\/\/
%%\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\\/\/\/\/\/\/\/\/\/
%%\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\\/\/\/\/\/\/\/\/\/
%%\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\\/\/\/\/\/\/\/\/\/




for ii=1:length(nanoparticle_cor)
    clearvars -except nanoparticle_cor  pixels_per_nm SEMrange minsigma maxsigma nanometerperpixel range ii file Expecond FILEname binsize binnumber;
    [A, B, C, D, sigmax, sigmay, x0, y0, erx, ery, startp, endp]=textread(nanoparticle_cor{ii},'  %f    %f    %f    %f    %f    %f    %f    %f    %f    %f    %f    %f');
    erx = abs(erx);
    ery = abs(ery);
    % figure(ii); subplot(1,3,1); plot(x0,y0,'.');xlabel('before correction (nm)');  axis square;
    totalnum=size(x0);
    
    initialrange=1000;
    minsigma=100; % can modify--to remove the unreasonable small sigma for PSF of a single fluorescent
    maxsigma=600;
    
    k=1;
    
    for i=1:totalnum
        if sigmax(i)>=minsigma && sigmay(i)>=minsigma &&...       % can modify
                sigmax(i)<=maxsigma && sigmay(i)<=maxsigma &&...
                x0(i)<=median(x0)+ initialrange && x0(i)>=median(x0)- initialrange &&...    % can modify
                y0(i)<=median(y0)+ initialrange && y0(i)>=median(y0)- initialrange    % can modify
            xfil(k)=x0(i);
            yfil(k)=y0(i);
            tauon(k)=endp(i)-startp(i)+1;
            intensity(k)=A(i)/tauon(k);
            k=k+1;
        end
    end
    
    if exist('xfil')==0
        continue
    end
    
    exactrange=max((max(xfil)-min(xfil)),(max(yfil)-min(yfil)));
    range=ceil(exactrange/100)*100;
    binsize=range/binnumber;
    
    % figure(ii);subplot(1,3,2); plot(xfil,yfil,'.');xlabel('filt sigma x&y (nm)');axis square;
    
    if exist('xfil')==0
        continue
    end
    
    
    intensitymatrix=zeros(binnumber,binnumber);
    eventsmatrix=ones(binnumber,binnumber)/1000;
    intensity2dhist=zeros(binnumber,binnumber);
    
    for t=1:length(xfil)
        xsca(t)=xfil(t)-mean(xfil);
        ysca(t)=yfil(t)-mean(yfil);
        xintensity(t)=ceil((xsca(t)+range/2)/binsize);
        yintensity(t)=ceil((ysca(t)+range/2)/binsize);
        
        
        if xintensity(t)<1
            xintensity(t)=1;
        end
        
        if xintensity(t)>binnumber
            xintensity(t)=binnumber;
        end
        
        if yintensity(t)>binnumber
            yintensity(t)=binnumber;
        end
        
        if yintensity(t)<1;
            yintensity(t)=1;
        end
        
        
        intensitymatrix(xintensity(t),yintensity(t))=intensity(t)+intensitymatrix(xintensity(t),yintensity(t));
        eventsmatrix(xintensity(t),yintensity(t))=eventsmatrix(xintensity(t),yintensity(t))+1;
    end
    % figure(ii);subplot(1,3,3); plot(xsca,ysca,'.');xlabel('after translation motion (nm)');axis([-range range -range range]) ;
    % axis square ;
    for j=1:binnumber
        for k=1:binnumber
            intensity2dhist(j,k)=intensitymatrix(j,k)/eventsmatrix(j,k);
        end
    end
    intensity2dhist=intensity2dhist';
    
    
    
    figure(ii);
    screen_size = get(0, 'ScreenSize');
    set(figure(ii), 'Position', [0 0 screen_size(3) screen_size(4)]);
    
    subplot(1,2,1);
    plot(xsca,ysca,'.','MarkerSize',4);title('after translation motion (nm)');
    titletext=([(file(ii).name) ' ' Expecond]);
    xlabel(titletext);
    h = get(gca, 'xlabel');
    set(h, 'FontName', 'Times')
    
    
    axis([-range/2 range/2 -range/2 range/2]) ;
    axis square ;
    
    subplot(1,2,2);
    mYX = rand(length(xsca),2);
    mYX(:,1)=ysca'/range+0.5;
    mYX(:,2)=xsca'/range+0.5;
    vXEdge = linspace(0,1,binnumber);
    vYEdge = linspace(0,1,binnumber);
    mHist2d = hist2d(mYX,vYEdge,vXEdge);
    Plot2dHist(mHist2d, vXEdge*range, vYEdge*range, 'nm', 'nm', 'Density of events');
    axis square ;
    colorbar;
    
    
    %     subplot(2,2,3);
    %     vintenXEdge = linspace(0,1,binnumber+1);
    %     vintenYEdge = linspace(0,1,binnumber+1);
    %     Plot2dHist(intensity2dhist, vintenXEdge*range, vintenYEdge*range, 'nm', 'nm', 'Signal intensity distribution');
    %
    %
    %
    %     axis square ;
    %     colorbar;
    
    
    
    outfile2 = [FILEname file(ii).name ' ' Expecond '.png'];
    print(gcf,'-dpng',outfile2);
    
    
    
    close all;
end










