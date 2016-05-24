function thr_sigma = get_thr_sigma(centerx, centery, no_frames, moviename, width, heigth, t_start,framesize1);

nsigama = 3;
ymin = 0.5;
lentime = 1000;
framesize2 = 3; % can be change, also see get_ontime_frames

num = (2* framesize1 + 1) * (2* framesize1 + 1);
num2 = (2* framesize2 + 1) * (2* framesize2 + 1);

counts = no_frames;
if (no_frames - t_start) > lentime
    counts = lentime + t_start;
end

for i = 1 :counts
    a = double(imread(moviename,i));
    
    % get back ground
    gg = a (centery - framesize1:centery + framesize1, centerx - framesize1:centerx + framesize1 );
    n = 1;
    for k = 1: (2* framesize1 + 1)
        for j = 1: (2* framesize1 + 1)
            hb(n) = gg(k,j);
            n = n+1;
        end
    end
    
    for hi = 1:10
        ave = mean(hb);
        stdf =std(hb);
        ha = hb;
        [singk llo] = size(ha);
        mm = 1;
        clear hb;
        for j = 1:llo
            if abs( ave - ha(j) ) > ( nsigama * stdf )
                %             disp(  [num2str(i) ';     ' num2str(a(j)) '   ' num2str(ave)] );
                continue
            end
            hb(mm) = ha(j);
            mm = mm+1;
        end    
    end  
    
    A = num2 * mean(hb);
    
    mm = a (centery - framesize2:centery + framesize2, centerx - framesize2:centerx + framesize2 );
    
    trace(i) = sum(sum(mm)) - A;
    if mod(i,50) == 0
        hj = num2str(i);
        mess = ['Now is frame   ' hj];
        disp(mess);
    end
end

plot(trace);
xmin = 0;
xmax = counts+100;
ymin = ymin*min(trace);
ymax = 1.2*max(trace);
axis([xmin xmax ymin ymax])

disp('--->  select x0, y0');
[X,Y] = ginput (1);
close;
threshold = round(Y);

% shold(1 :counts) = threshold;
% plot(shold); hold on;

