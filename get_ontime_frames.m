function     [ontime_frame, indexf, mytrace, movie_ind, bre, thold_2 ] = ...
    get_ontime_frames( indexf, movie_ind, num_frames, mytrace, thr_2, thold_2, centerx, centery, moviefile, framesize1, framesize2, bin_on_fr );

no_frames = num_frames;
bre = 0;
[pol fn] = size(moviefile);
si = no_frames*(movie_ind-1);
N = 1000;
ontime_frame = 0;

for i = 1:bin_on_fr
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
    if mod( cur_ind, N ) == 1 && cur_ind > 1
        trace = mytrace( cur_ind - N+1 :cur_ind );
        [ thold_2, sigma, center ] = get_thold( trace, thr_2 );
    end

    abs_h = mytrace( cur_ind );
    
    if abs_h < thold_2
        ontime_frame = ontime_frame + crop_m;
    end
    
    if fn == movie_ind && indexf == no_frames
        ontime_frame = 0;
        startp = 0;
        mytrace = mytrace;
        indexf = 0;
        movie_ind = 0;
        bre = 1;
        return
    end
    
    indexf = indexf+1;
end


















