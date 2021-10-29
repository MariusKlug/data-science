%% Data Science for Human Factors course - script 12
% Machine Learning 2: Clustering
%
% This script is free to use and distribute for anybody!
%
% Author: Marius Klug, 2019, bpn.tu-berlin.de
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

close all; clear

%% generate data in 2D with three clusters

nPerClust = 50;

% XY centroid locations
A = [  1 1 ];
B = [ -3 1 ];
C = [  3 3 ];

% generate data (2D)
a = [ A(1)+randn(nPerClust,1) A(2)+randn(nPerClust,1) ];
b = [ B(1)+randn(nPerClust,1) B(2)+randn(nPerClust,1) ];
c = [ C(1)+randn(nPerClust,1) C(2)+randn(nPerClust,1) ];

% concatanate into a list
data = [a; b; c];

% show the data
figure(1);clf
plot(data(:,1),data(:,2),'o','markerfacecolor','k')
title('Raw Data')

%% k-means clustering

k = 3; % how many clusters?

[groupidx,cents,sumdist,distances] = kmeans(data,k);
% for octave: kmeans is in the statistics package

size(data)
% cluster result for each data point
size(groupidx)
% centroid locations
size(cents)
% quality measure
size(sumdist)
% additional info
size(distances)

% visualize
lineColors = [  0,0.75,0.75;
                0.75,0,0.75;
                0.75,0.75,0];

figure(2);clf;

hold on

% now draw the raw data in different colors
for i=1:k
    
    % data points
    plot(data(groupidx==i,1),data(groupidx==i,2),...
        'o','color',[ lineColors(i,:)],'markerface','w')
    
    % and now plot the centroid locations
    plot(cents(i,1),cents(i,2),'ko','markerface',...
        lineColors(i,:),'markersize',10);
end


xlabel('Axis 1'), ylabel('Axis 2')
title('Result of K-Means Clustering')

% connecting lines for clarification
for i=1:length(data)
   
    plot([ data(i,1) cents(groupidx(i),1) ],...
        [ data(i,2) cents(groupidx(i),2) ],'color',...
        [lineColors(groupidx(i),:)])
    
end

% finally, the "ground-truth" centers
plot(A(1),A(2),'kp','linew',2,'markersize',20,'markerfacecolor','y')
plot(B(1),B(2),'kp','linew',2,'markersize',20,'markerfacecolor','y')
plot(C(1),C(2),'kp','linew',2,'markersize',20,'markerfacecolor','y')

%% EXERCISE
% Use k-means to cluster the swiss roll data, then visualize
% it in 3D, using different colors for each group (k=6).
% Plot the data points according to their group, and all
% centroids in black with larger markers. Hint: scatter3

N = 1500;
noise = 0.05;
t = 3*pi/2 * (1 + 2*rand(N,1));
h = 11 * rand(N,1);
X = [t.*cos(t), h, t.*sin(t)] + noise*randn(N,3);


%% Use Nearest Neighbors to Compute the Linkage
% Compute 40 nearest neighbors
[idx, distances] = knnsearch(X,X,'k',40);

size(idx)
idx(1,:)

size(distances)
distances(1,:)

% Create the adjacency matrix for linkage
D = zeros(size(X,1));
for ii = 1:length(X)
    D(ii,idx(ii,2:end)) = 1;
end

size(D)

% Cluster the data with structure defined by neighbors
cLinks = linkage(D, 'ward');
groups = cluster(cLinks, 'maxclust', 6);

size(groups)

% Visualize
subplot(1,2,1,gca)
subplot(122)
scatter3(X(:,1),X(:,2),X(:,3),[],groups,'fill','MarkerEdgeColor','k');
title('Structured Hierarchical Clustering')
view(-20,5)

%% Visualize the Voronoi regions

figure(2)

x_limits = xlim;
y_limits = ylim;

[X,Y] = meshgrid(x_limits(1):0.01:x_limits(2),y_limits(1):0.01:y_limits(2));

full_grid = [X(:),Y(:)];

size(x_limits(1):0.01:x_limits(2))
size(X)
size(full_grid)

idx2Region = kmeans(full_grid,3,'MaxIter',1,'Start',cents);

figure(4); clf
gscatter(full_grid(:,1),full_grid(:,2),idx2Region,...
    [lineColors ],'..');

hold on

% now draw the raw data in different colors
for i=1:k
    
    % data points
    plot(data(groupidx==i,1),data(groupidx==i,2),'o','color',[ lineColors(i,:)],'markerface','w')
    
    % and now plot the centroid locations
    plot(cents(i,1),cents(i,2),'ko','markerface',lineColors(i,:),'markersize',10);
end


xlabel('Axis 1'), ylabel('Axis 2')
title([ 'Voronoi regions of k-means clustering (k=' num2str(k) ')' ])


% finally, the "ground-truth" centers
plot(A(1),A(2),'kp','linew',2,'markersize',20,'markerfacecolor','y')
plot(B(1),B(2),'kp','linew',2,'markersize',20,'markerfacecolor','y')
plot(C(1),C(2),'kp','linew',2,'markersize',20,'markerfacecolor','y')

legend({'A','B','C'})

%% test other k values

figure(5);clf;

lineColors = [0,0.75,0.75;...
    0.75,0,0.75;...
    0.75,0.75,0;...
    0,0.75,0;...
    0,0,0.75;...
    0,0,0;...
    0,1,1;...
    0.75,0.75,0.75;...
    0.75,0,0];

% k = 1 is trivial
k = 1;

this_spread = visualizeClusters(data,k,lineColors,A,B,C);

spread(k) = sum(this_spread);

subplot(3,3,1,gca)

%% EXERCISE
% Create a loop that clusters 7 more times for 
% k = 2:8, visualize it in subplots, save the spread values
% and plot them in the last axis as line with markers


%% Automated knee point detection

% https://www.mathworks.com/matlabcentral/fileexchange/35094-knee-point
% not working that great, if you ask me
likely_n_clust = knee_pt(spread)

% abuse an image processing function i found on the interwebz to find the
% knee point here. works better than the knee_pt function imo.
% https://de.mathworks.com/matlabcentral/answers/483969-find-knee-elbow-of-a-curve
% author is Mark Hayworth!
likely_n_clust = triangle_threshold(spread, 'R', 1)

%% MATLAB k-means example

% The Iris flower data set or Fisher's Iris data set is a 
% multivariate data set introduced by the British 
% statistician and biologist Ronald Fisher in his 1936 
% paper The use of multiple measurements in taxonomic 
% problems as an example of linear discriminant analysis. 
% It is sometimes called Anderson's Iris data set because 
% Edgar Anderson collected the data to quantify the 
% morphologic variation of Iris flowers of three related 
% species. Two of the three species were collected in the 
% Gasp? Peninsula "all from the same pasture, and picked on 
% the same day and measured at the same time by the same 
% person with the same apparatus".

% The data set consists of 50 samples from each of three 
% species of Iris (Iris setosa, Iris virginica and Iris 
% versicolor). Four features were measured from each sample: 
% the length and the width of the sepals and petals, in 
% centimeters. Based on the combination of these four 
% features, Fisher developed a linear discriminant model to 
% distinguish the species from each other. 

% From Wikipedia

load fisheriris

size(meas)

[group_idx] = kmeans(meas(:,1:2),3);

figure(6); clf
subplot(231)
gscatter(meas(:,1),meas(:,2),species);
title({'Fisher''s Iris Data','actual species'});
xlabel 'Sepal Lengths (cm)';
ylabel 'Sepal Widths (cm)';

subplot(232)
gscatter(meas(:,1),meas(:,2),group_idx);

title({'Fisher''s Iris Data','k-means on feature 1&2'});
xlabel 'Sepal Lengths (cm)';
ylabel 'Sepal Widths (cm)';

%% use other features as well

subplot(233)

[group_idx] = kmeans(meas,3);
gscatter(meas(:,1),meas(:,2),group_idx);
xlabel 'Sepal Lengths (cm)';
ylabel 'Sepal Widths (cm)';

title('k-means with all features (n = 4)')

fullFeaturesAxes = gca;

%% PCA

[coeff, score,latent,tsquared,explained,mu] = pca(meas);

figure(7);clf
plot(explained)
title('Explained Variance')

subplot(2,2,1,gca)
subplot(222); plot(score(:,1))
title('PC 1')
subplot(223); plot(score(:,2))
title('PC 2')

subplot(224);scatter(score(:,1),score(:,2))
xlabel('PC 1')
ylabel('PC 2')

% visualize the factor loadings
figure(8);clf
bar(coeff')
title('Factor Loadings')
xlabel('Principal Component')
legend({'Feature 1','Feature 2','Feature 3','Feature 4',})

subplot(2,2,1:2,gca)
subplot(223)
plot(meas(:,3))
title('Feature 3 of the dataset')
xlabel('datapoint')
subplot(224)
plot(score(:,1))
title('PC 1')
xlabel('datapoint')

%% cluster in PC space

% cluster using only the first PC
[group_idx] = kmeans(score(:,1),3);

figure(6);
subplot(234)
gscatter(meas(:,1),meas(:,2),group_idx);

title('k-means with PC 1 only')
xlabel 'Sepal Lengths (cm)';
ylabel 'Sepal Widths (cm)';

subplot(235)
% cluster using only the first and second PC
[group_idx] = kmeans(score(:,[1 2]),3);
gscatter(meas(:,1),meas(:,2),group_idx);
title('k-means with PC 1&2 only')
xlabel 'Sepal Lengths (cm)';
ylabel 'Sepal Widths (cm)';

subplot(236)
% visualize in PC space
gscatter(score(:,1),score(:,2),group_idx);

title({'k-means with PC 1&2 only','in PCA space'})
xlabel('PC 1')
ylabel('PC 2')
