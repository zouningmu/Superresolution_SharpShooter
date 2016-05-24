function [centerx, centery] = recenter(oldcenterx, oldcentery, width, heigth, outdata7, outdata8, framesize1, a , n);

centerx = oldcenterx;
centery = oldcentery;

[num ij] = size(outdata7);
if num > 20
    dn = 20;
else
    dn = num;
end

% get the center data
for i = (num - dn+1):num
    dsB(i+dn-num) = 0;
    for j = (num - dn+1) :num
        dsB(i+dn-num) = dsB(i+dn-num) + abs( outdata7(i,1) - outdata7(j,1) );
    end
end

[minB lb] = min(dsB);
A = outdata7(lb - dn + num,1);

if (A - oldcenterx > 1 ) && ( ( oldcenterx + framesize1 ) < width )
    centerx = oldcenterx + 1;
elseif ( A - oldcenterx < -1 ) && ( ( oldcenterx - framesize1 ) > 1 )
    centerx = oldcenterx - 1;
end


% get the center data

for i = (num - dn+1):num
    dsB(i+dn-num) = 0;
    
    for j = (num - dn+1) :num
        dsB(i+dn-num) = dsB(i+dn-num) + abs( outdata8(i,1) - outdata8(j,1) );
    end
end

[minB lb] = min(dsB);
A = outdata8(lb - dn + num,1);

if (A - oldcentery > 1 ) && ( oldcentery + framesize1 ) < heigth
    centery = oldcentery + 1;
elseif ( A - oldcentery < -1 ) && ( ( oldcentery - framesize1 ) > 1 )
    centery = oldcentery - 1;
end