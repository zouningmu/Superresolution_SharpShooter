function  background = photo_bg(singlefgauss, ontime_frame, g, S, QE, wavelength1 );

h = 6.626e-34;  % Plank constant
c = 299792458;  % light rate

cts = singlefgauss - ontime_frame;

hht = (1/g) * (S/QE) * 3.65;
ev = cts * hht;

background = (wavelength1*1e-9 * ev * 1.602e-19) / ( h*c);




