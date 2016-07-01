function [centerx, centery, tot_fr] = center(no_frames,moviename, centerx, centery);

g = moviename;

startp = 0;
num = 500;

while (1)
    a = double(imread(g,1+startp));
    if no_frames < num + startp
        for i =2 + startp:no_frames
            a = a + double(imread(g,i));
        end
        msgbox('Reach the end of file!');
        break
    else
        for i =2 + startp:num + startp
            a = a + double(imread(g,i));
        end    
    end
    contour (a,20); axis equal;
    
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

tot_fr = a/num;
hold on
plot( centerx, centery, 'ro' ); hold off
disp('--->  select x0, y0');
[X,Y] = ginput (1);
close;
pause(0.01);
centerx = round(X);
centery = round(Y);
% a
% a(centery,centerx)

t_start = startp+1;





