function showprocess( i, indexf, num_frames, erx, ery, sigmax, a, sigmay, c1, s_c1 );

%%%%%%%%%%%%%%%%%%%%%%%%%% display temparory results  %%%%%%%%%%
disp(['Current segment is  ' num2str(i)]);
ap = ['Mission finished:   ' num2str(indexf*100/num_frames) '% in this segment'];
disp(ap);
ap = ['x_error = ' num2str( erx ) ',  y_error = ' num2str( ery ) ',  sigma_x = ' num2str( sigmax*a ) ',  sigma_x = ' num2str( sigmay*a )];
disp(ap);
c2 = clock;
c3 = c2 - c1;
elps = c3(3)*24*3600 + c3(4)*3600 + c3(5)*60 + c3(6);
ap = ['Time cost is    ' num2str( elps ) '   Seconds in this part.'];
disp(ap);

c1 = clock;
c3 = c1 - s_c1;
elps = c3(3)*3600*24 + c3(4)*3600 + c3(5)*60 + c3(6);
ap = ['Total elapsed time is    ' num2str( elps ) '   Seconds.'];
disp(ap);
disp('_______________________________________________________________________________________________________');

%%%%%%%%%%%%%%%%%%%%%%%%%% display temparory results  %%%%%%%%%%










