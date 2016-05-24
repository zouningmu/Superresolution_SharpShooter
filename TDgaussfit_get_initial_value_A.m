function [A, B, C, D, sigmax, sigmay, x0, y0] =  TDgaussfit_get_initial_value_A(ontime_frame, framesize, sigmax, sigmay);

% average circle value
acv = sum(sum(ontime_frame)) - sum(sum(ontime_frame(2:2*framesize, 2:2*framesize)));
acv = acv/8/framesize;
% peak value
backg = (2*framesize + 1)^2 * acv;

a = sum(sum(ontime_frame)) - backg;
A = a/( sigmax*sigmay*2*3.1415916);
