clc;clear;smoothp = 5; % point for smooth
%%%%%%%%%%%%%%%%%%%%%%%++++++++++++++++++++++++++
markp(1) = cellstr('D:\Research\2013 spring\20130329 AuSiO2-44-RZ 160nM\DATA\background\x116y167background.txt');
markp(2) = cellstr('D:\Research\2013 spring\20130329 AuSiO2-44-RZ 160nM\DATA\background\x156y17background.txt');
markp(3) = cellstr('D:\Research\2013 spring\20130329 AuSiO2-44-RZ 160nM\DATA\background\x305y152background.txt');
markp(4) = cellstr('D:\Research\2013 spring\20130329 AuSiO2-44-RZ 160nM\DATA\background\x381y78background.txt');
% markp(4) = cellstr('D:\Research\2012 spring\05082012 zxcGNR_RztoRF\20120509\310degree\background\x336y43background.txt');
% markp(5) = cellstr('D:\Research\2012 spring\05082012 zxcGNR_RztoRF\20120509\310degree\background\x324y156background.txt');


outfile = 'D:\Research\2013 spring\20130329 AuSiO2-44-RZ 160nM\DATA\background.txt';

error_x = 15.5;   % nm  +/-  x direction  error bar
error_y = 15.5;   % nm  +/-  y direction
%%%%%%%%%%%%%%%%%%%%%%%++++++++++++++++++++++++++
[pol fn] = size(markp);
% outxi(1,240000) = 0;
% outyi(1,240000) = 0;

for j=1:fn;

    infile = char( markp(j) );
    [A, B, C, D, sigmax, sigmay, x0, y0, erx, ery, startp, endp]=textread(infile,'  %f    %f    %f    %f    %f    %f    %f    %f    %f    %f    %f    %f');
    df = endp(1) - startp(1) + 1;   % frames for bin
    erx = abs(erx);
    ery = abs(ery);
    
    [len1 jkjk] = size(A);
    plot(x0,y0); hold on
    
    % filt big error bar
    n = 1;
    for i = 1:len1
        if ( erx(i) <= error_x ) && ( ery(i) <= error_y )
            gx(n) = x0(i);
            gy(n) = y0(i);
            gex(n) = erx(i);
            gey(n) = ery(i);
            gstartp(n) = startp(i);
            gendp(n) = endp(i);
            n = n+1;
        end    
    end
    x0 = gx;
    y0 = gy;
    erx = gex;
    ery = gey;
    startp = gstartp;
    endp = gendp;
    len1 = n-1;
    clear gx gy gex gey gstartp gendp;
    
    % interpolate rare data to get a full view
    xi = startp(1):df:startp(len1)+df;
    yi=interp1(startp,x0,xi);
    y2 = interp1(startp,y0,xi);
    % smooth the full view
    yy = smooth(xi,yi,smoothp);
    yy2 = smooth(xi,y2,smoothp);
    % interpolate smoothed data to each frame
    outxi(j,startp(1):startp(len1)) = startp(1):startp(len1);
    outyi(j,startp(1):startp(len1)) = interp1(xi,yy,outxi(j,startp(1):startp(len1)));     
    outy2(j,startp(1):startp(len1)) = interp1(xi,yy2,outxi(j,startp(1):startp(len1)));

end

[files len2] = size(outxi);
for i = 1:len2
    temy = 0;
    temy2 = 0;
    n = 0;
    for j = 1:files
        if outyi(j,i) > 0
            n = n+1;
            temy = temy + outyi(j,i);
            temy2 = temy2 + outy2(j,i);
        end        
    end
    ave_y(i) = temy/n;
    ave_y2(i) = temy2/n;
end

outdata(1,:) = ave_y;
outdata(2,:) = ave_y2;
plot(ave_y,ave_y2,'color','r'); hold off

result=outdata;
fid2=fopen(outfile,'w');
fprintf(fid2,'%10.5f   %10.5f \n',result);
fclose(fid2);

outmsg=['All fittings are finished! Output file is     (' outfile ')'];
msgbox(outmsg);  




