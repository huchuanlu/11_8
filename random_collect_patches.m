function data = random_collect_patches(path, blockSize, N, fileExt)
%%function data = random_collect_patches(path, blockSize, N, fileExt)
%%random collect image patches for training 1D-PCs and 2D-PCs
%%Input:
%%      path:       image path
%%      blockSize:  [blockSize(1) blockSize(2)]
%%      N:          random collect N image patches from each image
%%      fileExt:    image type, such as '.png', '.jpg', '.bmp',...
%%Output:
%%      data:       [blockSize(1)*blockSize(2)*patchNum]
%%
%%Dong Wang, IIAU LAB, DUT, China
%%Version 0.1 2010-09-05

dirPath = dir([path,'*',fileExt]);
imageNum = length(dirPath);
sampleNum = N*imageNum;
data = zeros(blockSize(1),blockSize(2),sampleNum);
%% random collect image patches
patchNum = 1;
for num = 1:imageNum                                   
   I = imread([path,dirPath(num).name]);
   I = rgb2gray(I); 
   t_x = size(I,1)-blockSize(1);      
   t_y = size(I,2)-blockSize(2);       
   for m=1:N  
        while 1                             
            x = fix(rand(1)*t_x);
            if(x>0) break; end
        end
        while 1
            y = fix(rand(1)*t_y);
            if(y>0) break; end
        end
        data(:,:,patchNum) = I(x+1:x+blockSize(1), y+1:y+blockSize(2));
        patchNum = patchNum + 1;
    end
end