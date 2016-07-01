function [ thr_sigma, trace_c ]= get_thr_sigma( centerx, centery, moviename, thr_1, thr_2);

lentime = 1000;
framesize2 = 3; % can be change, also see get_ontime_frames
bin_s = 50;

for i = 1:lentime
    a = double(imread(moviename,i));
    gg = a (centery - framesize2:centery + framesize2, centerx - framesize2:centerx + framesize2 );
    trace(i) = sum(sum(gg));    
end

% get the histogram
x = min(trace):bin_s:max(trace);
[n xout] = hist(trace,x);

% fit the histogram with gaussian function
b10 = double(max(n)); % A
b20 = double( mean(trace) );     % center2
b30 = double( std(trace) );   % width
% Fit the data with y=A*exp(  -(x-b)*(x-b)/(2*c^2) )
myfunc=inline('beta(1)*exp(  -0.5*( x-beta(2) ).*( x-beta(2) )/beta(3)/beta(3)  )','beta','x'); 
[beta,Re,j] = nlinfit(xout,n,myfunc,[b10 b20 b30]); 

trace_c = beta( 2 );
thr_sigma = abs( beta(3) );


nnn = length( treat_y );
show_t( 1:nnn ) = my_threshold;




