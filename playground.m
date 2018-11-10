%%Image Processing Playground

clear all;
close all;
clc;

addpath('./scripts');
addpath('./images');

lena_fname = 'lena.tiff';
lena = imread(lena_fname);
lena_gray = im2double(rgb2gray(lena));

figure('Name', 'Lena Gray');
imshow(lena_gray);

red = [1 0 0];
green = [0 1 0];
blue = [0 0 1];
colored_edges = ColoredEdges(lena_gray, red, blue, green);

figure('Name', 'Lena Edges Colored');
imshow(colored_edges); colorbar;