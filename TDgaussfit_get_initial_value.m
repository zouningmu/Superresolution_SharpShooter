function [A, B, C, D, sigmax, sigmay, x0, y0] =  TDgaussfit_get_initial_value(ontime_frame, framesize);

% average circle value
acv = sum(sum(ontime_frame)) - sum(sum(ontime_frame(2:2*framesize, 2:2*framesize)));
acv = acv/8/framesize;
% peak value
peakv = 0;
for i = 1:2*framesize+1
    for j = 1:2*framesize+1
        if ontime_frame(i,j) > peakv
            peakv = ontime_frame(i,j);
        end
    end
end

% get the initial value
%% initial value of base
C = acv;
%% initial value of plat surface
D = 0.01;
B = 0.01;
%% initial value of peak amplitude
A = peakv - C;
%% initial value of x direction
[mb mc] = max(ontime_frame);
[me mf] = max(mb);

x0 = mf;
y0 = mc(mf);
sigmax = 0.7;
sigmay = 0.7;


