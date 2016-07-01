function  N = photons( A, B, C, D, sigmax, sigmay, x0, y0, g, S, QE, wavelength1, framesize1, k);

n = 2*framesize1 +1;
h = 6.626e-34;  % Plank constant
c = 299792458;  % light rate
dxy = 1/(k+1);  % step size 
% increase the dimension
[X Y]= meshgrid( 0:dxy:n, 0:dxy:n );

fgauss = A*exp( -(X-x0).^2/sigmax/sigmax/2 - (Y-y0).^2/sigmay/sigmay/2 );

singlefgauss = zeros(n,n);
for i = 1:n
    for j = 1:n
        singlefgauss(i,j) = sum(    sum(fgauss( (k+1)*(i-1)+2:(k+1)*i, (k+1)*(j-1)+2:(k+1)*j ) )    );
    end
end

singlefgauss = singlefgauss/k/k;
cts = sum(sum(singlefgauss));

ev = (cts/g) * (S/QE) * 3.65;

N = (wavelength1*1e-9 * ev * 1.602e-19) / ( h*c);

if N <= 0
    N = 0.0001;
end



