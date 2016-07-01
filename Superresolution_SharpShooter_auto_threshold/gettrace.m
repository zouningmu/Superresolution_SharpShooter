function trace = gettrace( centerx, centery, moviename, framesize2, counts );

for i = 1 :counts
    a = double(imread(moviename,i));
    mm = a (centery - framesize2:centery + framesize2, centerx - framesize2:centerx + framesize2 );
    trace(i) = sum(sum(mm));
    if mod(i,50) == 0
        hj = num2str(i);
        mess = ['Now is frame   ' hj];
        disp(mess);
    end
end


