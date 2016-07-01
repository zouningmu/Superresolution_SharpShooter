clc;clear;clf;close all
%% sigmadis is the important data
FILEname='D:\Research\2012 spring\05082012 zxcGNR_RztoRF\20120510\310degree\';  % the file name contain the txt files after drift correction
Expecond='310degree';   %Can add the condition of experiment
totalnumofframe=100000;
numofseg=10;



dirname=[FILEname '*.csv' ];
file=dir(dirname);
for n=1:length(file)
    nanoparticle_cor{n}=dlmread([FILEname,file(n).name]);
end

for i=1:length(file)
    
    for ii=1:numofseg
        
        [a{i}{ii},b{i}{ii}]=hist(nanoparticle_cor{i}((ii-1)*totalnumofframe/numofseg+1:ii*totalnumofframe/numofseg),350);
        [sigma{i,1}(ii,1),mu{i,1}(ii,1),A{i,1}(ii,1)]=mygaussfit(b{i}{ii},a{i}{ii});
        %     pause(0.5);       
    end
    
    
    sortsigma{i,1}=sort(sigma{i,1});
    sigmadis{i,1}=round(sigma{i,1});
    sigmadis{i,2}=round(mean(sortsigma{i,1}(1:numofseg-3)));
    sigmadis{i,3}=Expecond;
    sigmadis{i,4}=file(i).name;
    
end

