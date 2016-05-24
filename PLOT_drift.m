clc;clear all;close all;

FILEname='D:\Research\2013 spring\SingleMolecule Data\20130505AuSiO2-299-1-RZ 300nM\SMdata\data\voltage\background\';    % File which contains the drift motion for position makers
marks='D:\Research\2013 spring\SingleMolecule Data\20130505AuSiO2-299-1-RZ 300nM\SMdata\data\voltage\background\total_background.txt';  % The position of total-position maker
driftrange=500; % The possible range of drift during experiment,300nm-500nm is a tolerable range.  

[ave_y ave_y2] = textread(marks,'  %f    %f');

dirname=[FILEname '*.txt' ];
file=dir(dirname);
for n=1:length(file)
    nanoparticle{n}=[FILEname,file(n).name];
end


for ii=1:length(file)
  [A, B, C, D, sigmax, sigmay, x0{ii}, y0{ii}, erx, ery, startp, endp]=textread(nanoparticle{ii},'  %f    %f    %f    %f    %f    %f    %f    %f    %f    %f    %f    %f');  
    for iii=1:length(x0{ii})
        x0{ii}(iii,2)=x0{ii}(iii,1)-x0{ii}(1,1);
        y0{ii}(iii,2)=y0{ii}(iii,1)-y0{ii}(1,1);  
    end
    
    
end

for p=1:length(file)
 figure(1); subplot(2,3,p)  
plot((1:length(x0{p})),x0{p}(:,2));axis([0 length(x0{p}) -driftrange driftrange])
ylabel('nm');xlabel('# of segments');
 figure(2); subplot(2,3,p)  
plot((1:length(y0{p})),y0{p}(:,2));axis([0 length(y0{p}) -driftrange driftrange])
ylabel('nm');xlabel('# of segments');
end

figure(3);
for l1=1:length(ave_y)
    ave_y(l1,2)=ave_y(l1,1)-ave_y(1,1);
    ave_y2(l1,2)=ave_y2(l1,1)-ave_y2(1,1);
end
% plot(ave_y, ave_y2)
subplot(1,2,1) ;
plot((1:length(ave_y)), ave_y(:,2));axis([0 length(ave_y) -driftrange driftrange]);ylabel('nm');xlabel('# of frames');
subplot(1,2,2) ;
plot((1:length(ave_y2)), ave_y2(:,2));axis([0 length(ave_y2) -driftrange driftrange]);ylabel('nm');xlabel('# of frames');
