function [ thr_1, thr_2 ] = get_thr_1_thr_2_by_hand( mytrace );

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


plot( mytrace );

xlabel(' Get the low threshold ');
[ tx1 ty1 ] = ginput(1);
thr_1 = ( ty1 - center ) / sigma;

xlabel(' Get the high threshold ');
[ tx2 ty2 ] = ginput(1);
thr_2 = ( ty2 - center ) / sigma;





