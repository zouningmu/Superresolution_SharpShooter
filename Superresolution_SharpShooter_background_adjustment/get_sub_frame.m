function [sub_frame, sub_k] = get_sub_frame(temo, framesize1, sub_k, indexf, startp);

sub_n = 5;   % former number
nsigama = 2;

ay = 2*framesize1 + 1;
sub_cons(1,1:ay,1:ay) = 0;
% check the data from recent frames
gho = 0;
for hht = 1:6
    [hx hy hz] = size(temo);
    
    for i = 1:hx
        sum_sub(i) = sum(sum(temo(i,:,:))) ;
    end
    
    ave = mean(temo);
    stdf =std(temo);
    
    for j = 1:hx
        
        if abs( ave - temo(j) ) < ( nsigama * stdf )
            for i = 1:hy
                for kl = 1:hz
                    gho(j,i,kl) = temo(j,i,kl);
                end
            end
        end
        
    end    
    
    sub_cons = gho;
    gho = 0;
    sum_sub = 0;
end

% sub constant background
[hx hy hz] = size(temo);
% check the value
% temo to sub_cons
for hir = 1:hx
    for zx = 1:hy
        for zy = 1:hz
            sub_cons(sub_k,zx,zy) = temo(hir,zx,zy);
        end
    end
    
    sub_k = sub_k+1;
    if sub_k > sub_n                
        sub_k = 1;
    end
end

[ax ay az] = size(sub_cons);
if ax < 2
    sub_cons(2,:,:) = sub_cons(1,:,:);
end

cons1 = mean(sub_cons);

sub_frame(:,:) = (indexf - startp) * cons1(1,:,:);  
