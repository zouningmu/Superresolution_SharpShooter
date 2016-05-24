function testf(centerx, centery, moviename, framesize1);

testframe = imread(moviename,1); 
[ heigth width ] = size(testframe);

if centerx + framesize1 > width || centery + framesize1 > heigth || centery - framesize1 < 1 || centerx - framesize1 < 1 
    error('The center is out of range! Please modify the center or framesize.');
end


