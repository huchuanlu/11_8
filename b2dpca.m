function [ UL UR Mu ] = b2dpca(data, dim, iterativeNum)
%%function [ UL UR Mu ] = b2dpca(data, dim, iterativeNum)
%%Calculate B2PCA to obtain 2D basis functions: UL and UR
%%Input:
%%      data: data tensor [row*col*nSample]      
%%      dim:  Reserved Dimensions [dim(1) dim(2)]
%%      iterativeNum: iterative Number
%%Output:
%%      Mu:   mean matrix [row*col]
%%      UL:   left-projection basis  [row*dim(1)]
%%      UR:   right-projection basis [col*dim(2)]
%%      W:    basis functions [nDim*dim]
%%Reference: 
%%      H. Kong, L. Wang, E.K. Teoh, X.C. Li, J.G. Wang, and R.Venkateswarlu. 
%%      Generalized 2D principal component analysis for face image representation and recognition [J]. Neural Networks, 5-6:585-594,2005.
%%Dong Wang, IIAU LAB, DUT, China
%%Version 0.1 2010-09-05

[ row, col, nSample] = size(data);
%%Calculate the Mean Matrix
Mu = zeros(row,col);
for num = 1:nSample
    Mu = Mu + double(data(:,:,num));
end
Mu = Mu/nSample;
%%Normalize the Data
for num = 1:nSample
    data(:,:,num) = data(:,:,num) - Mu;
    data(:,:,num) = data(:,:,num)/norm(data(:,:,num),'fro');
end
%%Bilateral 2D Principal Component Analysis (B2DPCA)
UL = eye(row,row);
UR = eye(col,col);
for num = 1:iterativeNum
    %*****************************************************************************************************
    covMR = zeros(row,row);
    for num = 1:nSample
        covMR = covMR + data(:,:,num)*UR*UR'*data(:,:,num)';
    end
    [eigVector eigValue] = eig(covMR);
    [junk index] = sort(eigValue,'descend');
    eigVector = eigVector(:,index);
    UL = eigVector(:,1:dim(1));
    %*****************************************************************************************************
    covML = zeros(col,col);
    for num = 1:nSample
	    covML = covML + data(:,:,num)'*UL*UL'*data(:,:,num);
    end
    [eigVector eigValue] = eig(covML);
    [junk index] = sort(eigValue,'descend');
    eigVector = eigVector(:,index);
    UR = eigVector(:,1:dim(2));
    %*****************************************************************************************************
end


