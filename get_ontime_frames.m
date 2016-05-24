function [ontime_frame, startp, indexf, sub_frame, mytrace, movie_ind, bre, thold_1, thold_2, center ] = ...
    get_ontime_frames( indexf, movie_ind, no_frames, mytrace, thr_1, thr_2, thold_1, thold_2, center, centerx, centery, moviefile, framesize1, framesize2 );

former_n = 5;  % former number for averaging the sub constant value
bre = 0;
[pol fn] = size(moviefile);
si = no_frames*(movie_ind-1);
sub_n = 1;
N = 1000;
jud_on = 0;
ontime_frame = 0;
sub_k = 0;

while (1)
    
    if indexf > no_frames
        indexf = 1;
        movie_ind = movie_ind+1;
        si = no_frames*(movie_ind-1);
    end
    cur_ind = si + indexf;
    
    moviename = char( moviefile(movie_ind) );
    rr = double(imread(moviename,indexf));
    crop_m =  rr(  centery - framesize1:centery + framesize1, centerx - framesize1:centerx + framesize1);
    h1 = rr(  centery - framesize2:centery + framesize2, centerx - framesize2:centerx + framesize2);
    
    mytrace( cur_ind ) = sum( sum( h1 ) );
    
    if mod( cur_ind, N ) == 1 && jud_on == 0 && cur_ind > 1
        trace = mytrace( cur_ind - N+1 :cur_ind );
        [ thold_1, thold_2, sigma, center ] = get_thold( trace, thr_1, thr_2 );
    end
    
    abs_h = mytrace( cur_ind );
    if abs_h > thold_1 && jud_on == 0
        ontime_frame = crop_m;
        startp = cur_ind;
        jud_on = 1;
        
    elseif abs_h > thold_1 && jud_on == 1
        ontime_frame = ontime_frame + crop_m;
    elseif abs_h < thold_1 && jud_on == 1
        sum_h = sum( mytrace( startp:cur_ind-1 ) ) - center*( cur_ind - startp );
        
        if sum_h + center > thold_2
            
            %             if mod( cur_ind, N ) <= 5
            %                 cur_ind=cur_ind+5; temo( 1,:,: ) = rr(  centery - framesize1:centery + framesize1, centerx - framesize1:centerx + framesize1);
            %             end
            
            if sub_k == 1
                if cur_ind<=10 && movie_ind==1
                    rrnew = double(imread(moviename,5));
                    temonew( 1,:,: ) =rrnew(  centery - framesize1:centery + framesize1, centerx - framesize1:centerx + framesize1);
                    sub_frame=temonew;
                else
                    sub_frame = ( cur_ind - startp ) * squeeze( temo );
                end
            else
                if cur_ind<=10 && movie_ind==1
                    rrnew = double(imread(moviename,5));
                    temonew( 1,:,: ) =rrnew(  centery - framesize1:centery + framesize1, centerx - framesize1:centerx + framesize1);
                    sub_frame=squeeze(temonew);
                else
                sub_frame = ( cur_ind - startp ) * squeeze( sum( temo ) )/sub_k;
                end
            end
            
            
            
            
            
            return
        else
            ontime_frame = 0;
            clear temo;
            temo( 1,:,: ) = rr(  centery - framesize1:centery + framesize1, centerx - framesize1:centerx + framesize1);
            sub_k = 1;
            sub_n = 2;
            jud_on = 0;
        end
    elseif abs_h < thold_1 && jud_on == 0
        temo( sub_n,:,: ) = rr(  centery - framesize1:centery + framesize1, centerx - framesize1:centerx + framesize1);
        sub_n = sub_n + 1;
        
        if sub_n > former_n
            sub_n = 1;
        end
        
        if sub_k < former_n
            sub_k = sub_k+1;
        end
        
    end
    
    if ( fn == movie_ind && indexf == no_frames ) || fn < movie_ind
        sub_frame = 0;
        ontime_frame = 0;
        startp = 0;
        indexf = 0;
        temo = 0;
        mytrace = mytrace;
        movie_ind = 0;
        bre = 1;
        return
    end
    
    indexf = indexf+1;
end


















