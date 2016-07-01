function [A, B, C, D, sigmax, sigmay, x0, y0] = initial_value_from_data(outdata);

N = 50;
error_x = 80;
error_y = 80;

[len param] = size(outdata);
% if the outdata is too big, only get part
if len > N
    here1 = outdata(len-N+1:len,:);
    num = N;
else
    here1 = outdata;
    num = len;
end

if len > 2
    n = 1;
    for i = 1:num
        if ( here1(i,9) <= error_x ) && ( here1(i,10) <= error_y )
            ghe(n,:) = here1(n,:);
            n = n+1;
        end    
    end
    here1 = ghe;
    num = n-1;
end

% get the center data
dsB(num) = 0;
for i = 1:num
    for j = 1:num
        dsB(i) = dsB(i) + abs( here1(i,1) - here1(j,1) );
    end
end

[minB lb] = min(dsB);
A = here1(lb,1);

% get the center data
dsB(num) = 0;
for i = 1:num
    for j = 1:num
        dsB(i) = dsB(i) + abs( here1(i,2) - here1(j,2) );
    end
end

[minB lb] = min(dsB);
B = here1(lb,2);

% get the center data
dsC(num) = 0;
for i = 1:num
    for j = 1:num
        dsC(i) = dsC(i) + abs( here1(i,3) - here1(j,3) );
    end
end

[minC lb] = min(dsC);
C = here1(lb,3);

% get the center data
dsD(num) = 0;
for i = 1:num
    for j = 1:num
        dsD(i) = dsD(i) + abs( here1(i,4) - here1(j,4) );
    end
end

[minD lb] = min(dsD);
D = here1(lb,4);

% get the center data
dssigmax(num) = 0;
for i = 1:num
    for j = 1:num
        dssigmax(i) = dssigmax(i) + abs( here1(i,5) - here1(j,5) );
    end
end

[minsigmax lb] = min(dssigmax);
sigmax = here1(lb,5);

% get the center data
dssigmay(num) = 0;
for i = 1:num
    for j = 1:num
        dssigmay(i) = dssigmay(i) + abs( here1(i,6) - here1(j,6) );
    end
end

[minsigmay lb] = min(dssigmay);
sigmay = here1(lb,6);


% get the center data
dsx0(num) = 0;
for i = 1:num
    for j = 1:num
        dsx0(i) = dsx0(i) + abs( here1(i,7) - here1(j,7) );
    end
end

[minx0 lb] = min(dsx0);
x0 = here1(lb,7);

% get the center data
dsy0(num) = 0;
for i = 1:num
    for j = 1:num
        dsy0(i) = dsy0(i) + abs( here1(i,8) - here1(j,8) );
    end
end

[miny0 lb] = min(dsy0);
y0 = here1(lb,8);



