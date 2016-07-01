function [erx, ery] = errorbar_xy(sigmax, sigmay, a, background, N);

sigmax = sigmax*a;
sigmay = sigmay*a;

PI = 3.14159;
[n m] = size(background);
% S = Sqr(¡Æ(xn-x²¦)^2 /(n-1))
berr = background;
meanb = sum( sum(berr) )/n/m;
berr = berr - meanb;
berr = berr.^2;

b = sqrt( sum(sum(berr)) /n/m );

erx = sqrt( sigmax^2/N + a^2/12/N + (8*PI*sigmax^4 * b^2) / (a^2 * N*N)  );
ery = sqrt( sigmay^2/N + a^2/12/N + (8*PI*sigmay^4 * b^2) / (a^2 * N*N)  );

