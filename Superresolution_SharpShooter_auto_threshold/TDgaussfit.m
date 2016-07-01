function [A, B, C, D, sigmax, sigmay, x0, y0, singlefgauss, jud2] =  ...
    TDgaussfit(ontime_frame, framesize1, precision, k, outdata, n_iteration, filter_iteration, g, S, QE, wavelength1, a);

[x,y] = meshgrid(1:2*framesize1+1,1:2*framesize1+1);  %Create plot mesh
% fit the data, get the initial value of former part
[ng oko] = size(outdata);

if ng < 5
    [A, B, C, D, sigmax, sigmay, x0, y0] =  TDgaussfit_get_initial_value(ontime_frame, framesize1);
    A = A * 1.9363;
else
    [A B C D sigmax sigmay x0 y0] = initial_value_from_data( outdata );
    A = TDgaussfit_get_initial_value_A(ontime_frame, framesize1,sigmax, sigmay);
end

% A
% B
% C
% D
% sigmax
% sigmay
% x0
% y0

dxy = 1/(k+1);  % step size 
n = 2*framesize1+1;
dxy = 1/(k+1);  % step size 
% increase the dimension
[X Y]= meshgrid( 0:dxy:n, 0:dxy:n );

[X1 Y1]= meshgrid( 0:dxy:n, 0:dxy:n );

% check the data
options = optimset('TolX',precision,'MaxFunEvals', 1e8, 'MaxIter', filter_iteration);
% coeff = fminsearch( 'full_gaussfunction',[A B C D sigmax sigmay x0 y0],options,x,y,ontime_frame(:,:),k, X1, Y1, n);
lowb = [1 -200 100 -200 0.01 0.01 1 1 ];
highb = [1e8 200 1e6 200 5 5 2*framesize1+1 2*framesize1+1 ];
coeff = fmincon( 'full_gaussfunction',[A B C D sigmax sigmay x0 y0],[],[],[],[],lowb,highb,[], options,x,y,ontime_frame(:,:),k, X1, Y1, n );


A = coeff(1);
B = coeff(2);
C = coeff(3);
D = coeff(4);
sigmax = coeff(5);
sigmay = coeff(6);
x0 = coeff(7);
y0 = coeff(8);
% error bar

fgauss = A*exp( -(X-x0).^2/sigmax/sigmax/2 - (Y-y0).^2/sigmay/sigmay/2 ) + D*X + B*Y + C;

singlefgauss = zeros(n,n);
for i = 1:n
    for j = 1:n
        singlefgauss(i,j) = sum(    sum(fgauss( (k+1)*(i-1)+2 :(k+1)*i, (k+1)*(j-1)+2:(k+1)*j ) )    );
    end
end
singlefgauss = singlefgauss./k/k;

N = photons( A, B, C, D, sigmax, sigmay, x0, y0, g, S, QE, wavelength1, framesize1,k);  % get the photon number
background = photo_bg(singlefgauss, ontime_frame, g, S, QE, wavelength1);
[erx ery] = errorbar_xy(sigmax, sigmay, a, background, N);

jud2 = 2;
if (erx > 500) || (ery > 500)
    jud2 = 0;
    return
end

% continue calculation
options = optimset('TolX',precision,'MaxFunEvals', 1e8, 'MaxIter', n_iteration);
% coeff = fminsearch( 'full_gaussfunction',[A B C D sigmax sigmay x0 y0],options,x,y,ontime_frame(:,:),k, X1, Y1, n);
coeff = fmincon( 'full_gaussfunction',[A B C D sigmax sigmay x0 y0],[],[],[],[],lowb,highb,[], options,x,y,ontime_frame(:,:),k, X1, Y1, n );

A = coeff(1);
B = coeff(2);
C = coeff(3);
D = coeff(4);
sigmax = coeff(5);
sigmay = coeff(6);
x0 = coeff(7);
y0 = coeff(8);

%get singlegauss
fgauss = A*exp( -(X-x0).^2/sigmax/sigmax/2 - (Y-y0).^2/sigmay/sigmay/2 ) + D*X + B*Y + C;

singlefgauss = zeros(n,n);
for i = 1:n
    for j = 1:n
        singlefgauss(i,j) = sum(    sum(fgauss( (k+1)*(i-1)+2 :(k+1)*i, (k+1)*(j-1)+2:(k+1)*j ) )    );
    end
end
singlefgauss = singlefgauss./k/k;

