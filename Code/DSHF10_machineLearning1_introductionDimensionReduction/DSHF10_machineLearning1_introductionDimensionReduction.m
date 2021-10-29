%% Data Science for Human Factors course - script 11
% Machine Learning 1: Dimensionality Reduction
%
% This script is free to use and distribute for anybody!
%
% Author: Marius Klug, 2018, bpn.tu-berlin.de
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% First, create some 3D data

% parameters
n = 200;
mu_x = 2;
mu_y = 1;
mu_z = 3;
sigma_x = 5;
sigma_y = 1;
sigma_z = 2;

%% EXERCISE
% generate the 3D data using the respective parameters and
% plot it in 3D using the same axis limits for all three
% dimension.


%% rotate data
% using a rotation matrix we can rotate the data around x
% and y

R_x = [1.0000         0         0
    0           0.8660   -0.5000
    0           0.5000    0.8660];

data2 = data*R_x;

figure(2); clf
plot3(data2(:,1),data2(:,2),data2(:,3),'o','markerfacecolor','k')
xlim([-15 15])
ylim([-15 15])
zlim([-15 15])
rotate3d on
grid on

R_y = [0.7071         0      0.7071
    0          1.0000         0
    -0.7071         0      0.7071];

data3 = data2*R_y;

% final dataset that has correlating variables
figure(3); clf
plot3(data3(:,1),data3(:,2),data3(:,3),'o','markerfacecolor','k')
xlim([-15 15])
ylim([-15 15])
zlim([-15 15])
rotate3d on
grid on

%% Principal Component Analysis

% it's really just one line...
[coeff, score,latent,tsquared,explained,mu] = pca(data);

figure(4); clf
bar(explained)
title('Variance explained (%)')
set(gca,'Xticklabels',{'PC 1','PC 2','PC 3'})

% The coefficient matrix is p-by-p.
% Each column of coeff contains coefficients for one PC
coeff

% the data can be reconstructed by multiplying the score with the
% coefficients and adding the means
data
score*coeff'+repmat(mu,length(data),1)

figure(5); clf
bar(coeff')
set(gca,'Xticklabels',{'PC 1','PC 2','PC 3'})
title('Factor Loadings')
legend({'X','Y','Z'})

% sigma_x = 5;
% sigma_y = 1;
% sigma_z = 2;

% now plot only the first two PCs

figure(6); clf
plot(score(:,1),score(:,2),'o','markerfacecolor','k')
xlabel('PC 1')
ylabel('PC 2')

xlim([-15 15])
ylim([-15 15])

%% The Swiss Roll Problem
% Generate Swiss Roll Data
N = 1500;
noise = 0.05;
t = 3*pi/2 * (1 + 2*rand(N,1));
h = 11 * rand(N,1);
swiss_roll_data = [t.*cos(t), h, t.*sin(t)] + noise*randn(N,3);

% plot
figure(7); clf
scatter3(swiss_roll_data(:,1),swiss_roll_data(:,2),swiss_roll_data(:,3),[],'fill','MarkerEdgeColor','k');
view(-20,5)
title('A yummy swiss roll')

%% Use PCA
[coeff, score,latent,tsquared,explained,mu] = pca(swiss_roll_data);

figure(8); clf
plot(explained)

figure(9); clf
plot(score(:,1))

% plot(score(:,1),randn(length(score(:,1))),'o')

figure(10); clf
plot(score(:,1),score(:,2),'o','markerfacecolor','k')
xlabel('PC 1')
ylabel('PC 2')
title('Dimensionality Reduction with PCA')

%% Use t-Distributed Stochastic Neighbor Embedding (t-SNE)

Y = tsne(swiss_roll_data);
figure(11); clf
scatter(Y(:,1),Y(:,2))
title('Dimensionality Reduction with t-SNE')
xlabel('t-SNE 1')
ylabel('t-SNE 2')

% do it again
Y = tsne(swiss_roll_data);
figure(12); clf
scatter(Y(:,1),Y(:,2))
title('Dimensionality Reduction with t-SNE 2')
xlabel('t-SNE 1')
ylabel('t-SNE 2')

