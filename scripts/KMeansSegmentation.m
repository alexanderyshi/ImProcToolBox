%% Colour Segmentation via K-means
clear all;
close all;
clc;

mydir  = pwd;
idcs   = strfind(mydir,'/');
newdir = mydir(1:idcs(end)-1);

peppers     = imread([newdir '/images/peppers.png']);
peppers     = im2double(peppers); % necessary to prevent kmeans '+' operator complaint
% figure,imshow(peppers, []);

peppers_lab = rgb2lab(peppers);
% peppers_lab = applycform(peppers, makecform('srgb2lab'));
peppers_ab  = peppers_lab(:,:,2:3);

nrows = size(peppers_ab,1);
ncols = size(peppers_ab,2);
peppers_ab = reshape(peppers_ab,nrows*ncols,2);

K = 5; % !----- NUMBER OF MEANS -----!
col = [155   110   400   280   60    470   ]; % X
row = [55    130   200   180   220   280   ]; % Y


% purple curtain, light green pepper, red pepper,  yellow
% pepper, orange pepper, white garlic
row = row(1:K);
col = col(1:K);

% Convert (r,c) indexing to 1D linear indexing.
idx = sub2ind([size(peppers,1) size(peppers,2)], row, col);
% Vectorize starting coordinates
for k = 1:K
    mu(k,:) = peppers_ab(idx(k),:);
end

[idx, centroids] = kmeans(peppers_ab, K, 'Start', cat(3,mu,mu,mu), 'distance','sqEuclidean','Replicates',3);
av_Luma = mean(reshape(peppers_lab(:,:,1), nrows*ncols,1));
centroids = [ones(K, 1)*av_Luma centroids];
centroids = lab2rgb(centroids);
rgbOutput = reshape(peppers_lab,nrows*ncols,3);
for i = 1:length(idx)
   rgbOutput(i,:) = centroids(idx(i),:);
end

idxOutput = reshape(idx,nrows,ncols);
rgbOutput = reshape(rgbOutput,nrows,ncols,3);
% rgbOutput(1:5, 1:5, :)

figure('Name', 'Peppers K-Means Indexes');
imshow(idxOutput, []); colorbar; colormap('jet');
figure('Name', 'Peppers K-Means Regions with Colour');
imshow(rgbOutput, []); colorbar;