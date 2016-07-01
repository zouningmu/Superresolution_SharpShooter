clc;clear all;close all;

%% for single particle
% input=textread('D:\Research\2013 fall\SingleMolecule data\20130818Au-SiO2-9Nitrite\data\97_174_42_fit_corrected1.txt');

%% for many particles
FILEname='D:\Research\2013 fall\SingleMolecule data\20130818Au-SiO2-9Nitrite\data\try\';   % file name for data AFTER Correct.
dirname=[FILEname '*txt' ];
file=dir(dirname);
for n=1:length(file)
    nanoparticle_cor{n}=[FILEname,file(n).name];
end
frameseg=10000;
framenumber=600000;

segnum=framenumber/frameseg;
eventcell=zeros(segnum,length(nanoparticle_cor));
for ii=1:length(nanoparticle_cor)
% [A, B, C, D, sigmax, sigmay, x0, y0, erx, ery, startp, endp]=textread(nanoparticle_cor{ii},'  %f    %f    %f    %f    %f    %f    %f    %f    %f    %f    %f    %f');
clear input totalevent cellindex
input=textread(nanoparticle_cor{ii});
[totalevent,inp12]=size(input);


for i=1:totalevent
    cellindex=ceil(input(i,12)/frameseg);
    eventcell(cellindex,ii)=eventcell(cellindex,ii)+1;
    
end
hold on
plot(1:segnum,eventcell(:,ii),'.b')
end