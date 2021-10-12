% Assignment 12 for the class Data Science for Human Factors:
% 
% Clustering
%
% Team:

scores = 0;

%% 1) 1P
% Compare clustering of the swiss roll further by applying k-means
% clustering in t-SNE space.
% a) 0.75P
% Apply t-SNE to the swiss roll data. Choose a
% useful perplexity value for t-SNE. Add a plot with the results of the 
% k-means clustering in the t-SNE space to the original figure, visualized 
% in the original 3-D space. 
% b) 0.25P
% Add a new figure that visualizes the clusters in t-SNE space. 
% Give your figure proper descriptions!


%% Original Figure

N = 1500;
noise = 0.05;
t = 3*pi/2 * (1 + 2*rand(N,1));
h = 11 * rand(N,1);
X = [t.*cos(t), h, t.*sin(t)] + noise*randn(N,3);

% cluster swiss roll data with 6 cluster
groups_kmeans = kmeans(X,6);

% plot
figure(1); clf; set(gcf,'color','w')
scatter3(X(:,1),X(:,2),X(:,3),[],groups_kmeans,'fill','MarkerEdgeColor','k');
title('K-Means Clustering of the Swiss Roll')
view(-20,5)

% Use Nearest Neighbors to Compute the Linkage
% Compute 40 nearest neighbors
[idx,Dist]=knnsearch(X,X,'k',40);

% Create the adjacency matrix for linkage
D = zeros(size(X,1));
for ii = 1:length(X)
    D(ii,idx(ii,2:end)) = 1;
end

% Cluster the data with structure defined by neighbors
cLinks = linkage(D, 'ward');
groups_linkage = cluster(cLinks, 'maxclust', 6);

% Visualize
subplot(1,3,1,gca)
subplot(132)
scatter3(X(:,1),X(:,2),X(:,3),[],groups_linkage,'fill','MarkerEdgeColor','k');
title('Structured Hierarchical Clustering')
view(-20,5)

%% a)



%% b)



%%
scores(1) = 0

%% 2) 2P
% Three clusters of generated data exist. 
% a) 0.75P
% Cluster the data with k-means (k=3) and visualize the
% result in 3D, including the original means, the new cluster centroids,
% and connecting lines between data points and their cluster centroid.
% c) 1.25P
% Use PCA on the data and cluster only on the first 2
% PCs (in PC1-PC2 space). Visualize the k-means result in PC1-PC2 space, 
% and also in the original 3D space. Centroid locations and lines are not
% necesary.
% Use a 2-by-2 subplot grid for the figure.

%% 

nPerClust = 50;
all_sigmas = 1.5;

% XYZ centroid locations
A = [  1 2  0 ];
B = [ -5 1 -2 ];
C = [  3 5  5 ];

% generate data
a = bsxfun(@plus,randn(nPerClust,3)*all_sigmas,A);
b = bsxfun(@plus,randn(nPerClust,3)*all_sigmas,B);
c = bsxfun(@plus,randn(nPerClust,3)*all_sigmas,C);

% concatanate into a list
data = [a; b; c];

% show the data
figure(3);clf; set(gcf,'color','w')
ax1 = subplot(221);
plot3(data(:,1),data(:,2),data(:,3),'s','markerfacecolor','k')

title('Raw Data')

axis square, grid on
rotate3d on


%% a)



%% b)



%%
scores(2) = 0

%% 3) 1.5P
% The MNIST dataset contains handwritten numbers and is a
% common dataset for evaluation of clustering and
% classification algorithms. 
% a) 0.5P
% Load the data, plot the first
% 9 images in grayscale, titled with their data point # and
% the respective label. 
% b) 0.5P
% Then reshape and transpose the data such
% that it becomes an n_digits x 400 (dimensions) data
% set. Cluster the data on the full feature set (400
% features) with k-means (k=10) using 50 replicates, then 
% use t-SNE and cluster the data with k-means (k=10) in the t-SNE space
% (n_digits x 2) using 50 replicates.
% c) 0.5P
% Plot the data in t-SNE space 1) with original labels, 2)
% with the clusters from the full feature set, 3) with the
% clusters from the t-SNE preprocessing. Give appropriate
% titles and axis descriptions.

% -> The computation will take a while. If it takes too long
% on your Notebook, you can take less digits.

n_digits = 2000;
n_replicates = 50;

%% a)


%% b)


%% c) 


%%
scores(3) = 0

%%
final_score = sum(scores)
