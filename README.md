# Photometric-Stereo
A MATLAB/C++ Implementation of the Photometric Stereo Algorithm

only matlab vision available, c++ vision is on the way;

run from ./Matlab/DZZimages.m

use lights from 4 directions: lower\right\up\left, named as _Dir000.jpg \\ _Dir090.jpg \\ _Dir180.jpg \\ _Dir270.jpg

use lights from all directions, named as full.jpg

it will be uptodated soon!

20210726


some result and light correct related code added;

you can get such calibration pictures by take photos for a flat board with Lambert surface; 
additional light sources infomation needed;

for now, you can choose two ways to calculate the surface normal Surface normal vector; 'minus' will not consider lights, like in DZZimages.m; 'divide' will consider lights, like in DZZimage2.m.

light source can be point or circle, choose the type you need;

when run all image area, it will take a few minutes(4 min in my computer)!

20210825


more results added

cause of the vignetting effect, some result still needed to be improved

20210910
