function main_function
clear all;
clc;

%%Collect Image Patches
if  ~exist('data.mat','file')
    %%Radom Collect Image Patches
    path = './images/';
    fileExt = '.png';
    blockSize = [ 128 128 ];
    N = 30;
    data = random_collect_patches(path, blockSize, N, fileExt);
    %%Gaussian Attenuation
    guassianTemplate = calculateGuassianTemplate(blockSize,[20 20]);
    for num = 1:size(data,3)
    data(:,:,num) = data(:,:,num).*guassianTemplate;
    end
    save data.mat data
else
    load data.mat
end

%%1D-PCs:
if  ~exist('PCs(1D).mat','file')
    dataV = zeros(size(data,1)*size(data,2),size(data,3));
    for num = 1:size(data,3)
        dataV(:,num) = reshape(data(:,:,num),[size(data,1)*size(data,2),1]);
    end
    pcaDim = 36;
    [W mu] = pca(dataV, pcaDim);
    save PCs(1D).mat W mu
else
    load PCs(1D).mat
end

%%Display 1D-PCs:
figure(1);
blockSize = [128 128];
for ii = 1:6
    for jj = 1:6
        num = jj+(ii-1)*6;
        temp = reshape(W(:,num),[blockSize(1) blockSize(2)])';
        temp = 255*(temp-min(min(temp)))/(max(max(temp))-min(min(temp)));
        subplot(6,6,num,'align');
        imshow(uint8(temp));
        title(['[1DPCs] ' num2str(num)]);
    end
end

%%2D-PCs:
if  ~exist('PCs(2D).mat','file')
    b2dpcaDim = [ 6 6 ];
    iterativeNum = 10;
    [ UL UR Mu ] = b2dpca(data, b2dpcaDim, iterativeNum);
    save PCs(2D).mat UL UR Mu
else
    load PCs(2D).mat
end

%%Display 2D-PCs:
figure(2);
for ii = 1:6
    for jj = 1:6
        num = jj+(ii-1)*6;
        temp = UL(:,ii)*UR(:,jj)';
        temp = 255*(temp-min(min(temp)))/(max(max(temp))-min(min(temp)));
        subplot(6,6,num,'align');
        imshow(uint8(temp));
        title(['[2DPCs] ' num2str(ii)  '-' num2str(jj)]);
    end
end




