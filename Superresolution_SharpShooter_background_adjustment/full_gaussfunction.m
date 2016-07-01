function out = full_gaussfunction( coeff,x,y,ontime_frame, k, X1, Y1, n);

A = coeff(1);
B = coeff(2);
C = coeff(3);
D = coeff(4);
sigmax = coeff(5);
sigmay = coeff(6);
x0 = coeff(7);
y0 = coeff(8);

ssx = 2 * sigmax * sigmax;
ssy = 2 * sigmay * sigmay;

fgauss = A*exp( -(X1-x0).^2/ssx - (Y1-y0).^2/ssy ) + D*X1 + B*Y1 + C;

% singlefgauss = zeros(n,n);
for i = 1:n
    for j = 1:n
        singlefgauss(i,j) = sum(    sum(fgauss( (k+1)*(i-1)+2:(k+1)*i, (k+1)*(j-1)+2:(k+1)*j ) )    );
    end
end

douk = k*k;
DIFF = singlefgauss./douk - ontime_frame;
SQ_DIFF = DIFF.^2;

out = sum(sum(SQ_DIFF));

