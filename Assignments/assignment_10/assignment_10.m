% Assignment 10 for the class Data Science for Human Factors:
% 
% Machine Learning 1 - Dimensionality Reduction
%
% Team:

scores = 0;

%% 1) 1P
% Perplexity of t-SNE.

% a) 0.75P
% The perplexity is essentially telling the algorithm how to balance
% attention between local and global aspects of the data. t-SNE is fairly
% stable for perplexity values between 5 and 50 (default is 30), but it
% does have an influence, especially on complex data like the swiss roll.
% Investigating how the perplexity changes your results can be helpful.
%
% Create a loop that runs t-SNE on the swiss roll, with perplexities of [5
% 30 50 80 200] three times each, and plots the results in one figure. Save
% the figure and hand it in with your assignment!

% b) 0.25P 
% What are your conclusions? What is the best perplexity to unwrap
% the swiss roll?

load swiss_roll_data

perplexities = [5 30 50 80 200];

n_repetitions = 3;

figure(1); clf; set(gcf,'color','w');

%% a)

%% b)

%%
scores(1) = 0

%% 2) 3.5P
% More PCA.
% a) 1P
% Analogous to the generated data in the code, do the
% same thing with three blobs of the same size and spread.
% Create 3 clusters of generated data with
% specified nPerClust and sigma around the specified centroid locations. 
% Visuzalize them in 3D including their centroids, as can be seen in the figure.
% b) 1.25P
% Use PCA on the data and plot the explained variance of the PCs as well as
% the data in PC1-PC2 space and in the PC2-PC3 space as subplots.
% c) 1.25P
% Transform the centroids into PC1-PC2 space using the coefficients and plot 
% them over the data points in the PC1-PC2 scatter plot.

rng default
nPerClust = 50;
all_sigmas = 1.5;
figure(2); clf; set(gcf,'color','w'); subplot(221);

% XYZ centroid locations
A = [  1 2  0 ];
B = [ -5 1 -2 ];
C = [  3 5  5 ];

%%
scores(2) = 0

%% 
final_score = sum(scores)
