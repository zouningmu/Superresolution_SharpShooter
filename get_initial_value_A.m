function out = get_initial_value_A( coeff,x,y,ontime_frame, k, B, C, D, x0, y0 );

A = coeff(1);
sigmax = coeff(2);
sigmay = coeff(3);

[n, m] = size(x);
dxy = 1/(k+1);  % step size 
% increase the dimension
[X Y]= meshgrid( 0:dxy:n, 0:dxy:n );

fgauss = A*exp( -(X-x0).^2/sigmax/sigmax/2 - (Y-y0).^2/sigmay/sigmay/2 ) + D*X + B*Y + C;

singlefgauss = zeros(n,n);
for i = 1:n
    for j = 1:n
        singlefgauss(i,j) = sum(    sum(fgauss( (k+1)*(i-1)+2:(k+1)*i, (k+1)*(j-1)+2:(k+1)*j ) )    );
    end
end


DIFF = singlefgauss./k/k - ontime_frame;
SQ_DIFF = DIFF.^2;

out = sum(sum(SQ_DIFF));

