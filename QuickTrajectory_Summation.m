% This program is use summation to get the simpliest trajectory of particles in single molecule reaction.
% You can use the trajectory to judge if your particle or catalyst is active or not.


clc; clear all;
%%%%%%%%%%%%%%%%%%%%%%%++++++++++++++++++++++++++
moviefile(1) = cellstr('D:\Research\2013 spring\04062012_xczGNR_RZtoRF\Ningmu_150nM_RZ_20120406_Selector0.tif');
% moviefile(2) = cellstr('E:\RESEARCH\2012 Fall\Movies\20121111 RZ Au-SiO2\20121111 RZ Au-SiO2\20121111 65nM rz_Selector1.tif');
% moviefile(3) = cellstr('E:\RESEARCH\2012 Fall\Movies\20121111 RZ Au-SiO2\20121111 RZ Au-SiO2\20121111 65nM rz_Selector2.tif');
% moviefile(4) = cellstr('E:\RESEARCH\2012 Fall\Movies\20121111 RZ Au-SiO2\20121111 RZ Au-SiO2\20121111 65nM rz_Selector3.tif');
% moviefile(5) = cellstr('E:\RESEARCH\2012 Fall\Movies\20121111 RZ Au-SiO2\20121111 RZ Au-SiO2\20121111 65nM rz_Selector4.tif');
% moviefile(6) = cellstr('E:\RESEARCH\2012 Fall\Movies\20121111 RZ Au-SiO2\20121111 RZ Au-SiO2\20121111 65nM rz_Selector5.tif');
% moviefile(7) = cellstr('E:\RESEARCH\2012 Fall\Movies\20121111 RZ Au-SiO2\20121111 RZ Au-SiO2\20121111 65nM rz_Selector6.tif');
% moviefile(8) = cellstr('E:\RESEARCH\2012 Fall\Movies\20121111 RZ Au-SiO2\20121111 RZ Au-SiO2\20121111 65nM rz_Selector7.tif');
% moviefile(9) = cellstr('E:\RESEARCH\2012 Fall\Movies\20121111 RZ Au-SiO2\20121111 RZ Au-SiO2\20121111 65nM rz_Selector8.tif');
% moviefile(10) = cellstr('E:\RESEARCH\2012 Fall\Movies\20121111 RZ Au-SiO2\20121111 RZ Au-SiO2\20121111 65nM rz_Selector9.tif');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
outfile_total='D:\Research\2013 spring\04062012_xczGNR_RZtoRF\DATA\trace\150\';  % The address where you want to save the trajectory and trace plot figure

FirstFrameNo=1;   % The trace plot stating point
LastFrameNo=3000;    % The trace plot ending point

Num_Particle=input('How many particles do you want to gain: ');
framesize1 = 6;           % If framesize = 6, the window size is 13 x 13. for fitting
framesize2 = 3;           % for getting trace

num_frames = 10000;      % number of frames in your movie, each segment


%% \/ \/ \/ \/ \/ \/ \/ \/ \/ \/ \/ \/ \/ \/ \/ \/ \/ \/ \/ \/ \/
%% Here is the calcualtion part.
%% \/ \/ \/ \/ \/ \/ \/ \/ \/ \/ \/ \/ \/ \/ \/ \/ \/ \/ \/ \/ \/
moviename = char( moviefile(1) );

startp = 0;
num = 1000;
%% Name and choose of particle
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
    set(gca,'XTick',[0:20:alength]);
    set(gca,'YTick',[0:20:awidth]);
    
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
    centery(i) = round(awidth-Y(i));
end



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



%% Trace and Plot trace



for particleindex=1:Num_Particle
    for p=1:length(moviefile)
        
        for ii = 1:num_frames
            a = double(imread(moviefile{p},ii));
            mm = a (centery(particleindex) - framesize2:centery(particleindex) + framesize2, centerx(particleindex) - framesize2:centerx(particleindex) + framesize2 );
            index=(p-1)*num_frames+ii;
            trace(index) = sum(sum(mm));
%             disp(index);
        end
        
    end
    
    %% output trace
    
    plot(trace(FirstFrameNo:LastFrameNo));
    outfile1 = [outfile_total xy{particleindex} 'trace' '.csv'];
    fid2=fopen(outfile1,'w');
    fprintf(fid2,'%10.5f\n',trace);
    fclose(fid2);
    pause(0.1);
    outfile2 = [outfile_total xy{particleindex} 'trace' 'frame' num2str(FirstFrameNo) '-' num2str(LastFrameNo)  ];
    print(gcf,'-dpng',outfile2);
    close all
    
    
    
    
end










