function [ thold_1, thold_2, sigma, center ] = get_thold( mytrace, thr_1, thr_2 );

bin_s = 50;
x = min(mytrace):bin_s:max(mytrace);
[n xout] = hist(mytrace,x);



std_mytrace = std( mytrace );
% fit the histogram with gaussian function
b10 = double(max(n)); % A
b20 = double(mean(mytrace));     % center2
b30 = double(std_mytrace);   % width
% Fit the data with y=A*exp(  -(x-b)*(x-b)/(2*c^2) )
myfunc=inline('beta(1)*exp(  -0.5*( x-beta(2) ).*( x-beta(2) )/beta(3)/beta(3)  )','beta','x'); 
[beta,Re,j]=nlinfit(xout,n,myfunc,[b10 b20 b30]); 


center = beta( 2 );
sigma = abs( beta(3) );
thold_1 = center + thr_1 * sigma; % 4 times of sigma as threshold
thold_2 = center + thr_2 * sigma; % 4 times of sigma as threshold


% plot(xout,n); hold on
% x = xout;
% n1 = beta(1)*exp(  -0.5*( x-beta(2) ).*( x-beta(2) )/beta(3)/beta(3)  );
% plot(xout,n1); hold off

