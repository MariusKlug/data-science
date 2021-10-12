%% Data Science for Human Factors course - script 8
% Plotting 3: distribution plots & 3D plots
%
% This script is free to use and distribute for anybody!
%
% Author: Marius Klug, 2019, bpn.tu-berlin.de
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Violin plots
% a violin plot is essentially a box plot with a density
% plot around it, to give additional information

% create some data
data = [randn(30,1); 5+randn(30,1)];

figure(1);clf
subplot(131)
plot(data)
subplot(132)
boxplot(data)
% the boxplot is not a good representation of this dataset!

subplot(133)
histogram(data,10)
% a histogram is better, but because of the binning it is
% dependent on a sufficient amount of data points

% compute the density
figure(2);clf
subplot(131)
[density,density_x] = ksdensity(data);
plot(density_x,density)

% the automatic kernel width choice is assuming a normally
% distributed dataset, so it might be necessary to adjust
% this
subplot(132)
[density,density_x] = ksdensity(data,'bandwidth',0.8);
plot(density_x,density)

% you can also overdo it...
subplot(133)
[density,density_x] = ksdensity(data,'bandwidth',0.1);
plot(density_x,density)

% the density is not normalized
sum(density)

% okay, so now we have the density, let's plot it vertically
% on both directions
[density,density_x] = ksdensity(data,'bandwidth',0.8);

figure(3); clf
plot(density,density_x,'k');
hold on
plot(-density,density_x,'k');

% now the box
hold on
boxplot(data)

% okay we make our own box

figure(3); clf
plot(density,density_x,'k');
hold on
plot(-density,density_x,'k');

% now the box
hold on
meanline = plot([-max(density)/3 max(density)/3],...
    [mean(data) mean(data)],'r','Linewidth',2);

% we actually want the median
medianline = plot([-max(density)/3 max(density)/3],...
    [median(data) median(data)],'k','Linewidth',2);

% now the quantiles
quantile(data,[0.25 0.75])

h_errorbar=errorbar(0,median(data),...
    median(data)-quantile(data,0.25),...
    quantile(data,0.75)-median(data),'k');

legend([meanline medianline h_errorbar],...
    'mean','median','25% & 75% quantiles')

title('violin plot')

%% compare

figure(4); clf

% generate data

rng default  % for reproducibility
m = 20;
v = 10;
n = 10000;
ylimits = [-30 100];

data1 = (randn(n,1)*v)+m;

data2 = [randn(n/2,1)+m-v; randn(n/2,1)+m+v];

v = v^2;
mu = log((m^2)/sqrt(v+m^2));
sigma = sqrt(log(v/(m^2)+1));
data3 = lognrnd(mu,sigma,n,1);

% bar plots

subplot(4,3,1)
bar(1,mean(data1),0.5)
hold on
errorbar(mean(data1),std(data1))
ylim(ylimits)
title(['{\mu} = ' num2str(mean(data1)) ', {\sigma} = '...
    num2str(std(data1))])

subplot(4,3,2)
bar(1,mean(data2),0.5)
hold on
errorbar(mean(data2),std(data2))
ylim(ylimits)
title(['{\mu} = ' num2str(mean(data2)) ', {\sigma} = '...
    num2str(std(data2))])

subplot(4,3,3)
bar(1,mean(data3),0.5)
hold on
errorbar(mean(data3),std(data3))
ylim(ylimits)
title(['{\mu} = ' num2str(mean(data3)) ', {\sigma} = '...
    num2str(std(data3))])

% box plots

subplot(434)
boxplot(data1)
ylim(ylimits)
title(['Median = ' num2str(median(data1))])

subplot(435)
boxplot(data2)
ylim(ylimits)
title(['Median = ' num2str(median(data2))])

subplot(436)
boxplot(data3)
ylim(ylimits)
title(['Median = ' num2str(median(data3))])

% histograms

nbins = 50;
subplot(437)
histogram(data1,nbins)
subplot(438)
histogram(data2,nbins)
subplot(439)
histogram(data3,nbins)

% violin plots
[density1,density_x1] = ksdensity(data1,'BandWidth',0.5);
subplot(4,3,10)
densityline = plot(density1,density_x1,'k');
hold on
plot(-density1,density_x1,'k');
meanline = plot([-max(density1)/2 max(density1)/2],...
    [mean(data1) mean(data1)],'r','Linewidth',2);
medianline = plot([-max(density1)/2 max(density1)/2],...
    [median(data1) median(data1)],'k','Linewidth',2);
errorbar(0,median(data1),...
    median(data1)-quantile(data1,0.25),...
    quantile(data1,0.75)-median(data1),'k');
ylim(ylimits)
xlim([-max(density1)*4 max(density1)*4])

[density2,density_x2] = ksdensity(data2,'BandWidth',0.5);
subplot(4,3,11)
densityline = plot(density2,density_x2,'k');
hold on
plot(-density2,density_x2,'k');
meanline = plot([-max(density2)/2 max(density2)/2],...
    [mean(data2) mean(data2)],'r','Linewidth',2);
medianline = plot([-max(density2)/2 max(density2)/2],...
    [median(data2) median(data2)],'k','Linewidth',2);
errorbar(0,median(data2),...
    median(data2)-quantile(data2,0.25),...
    quantile(data2,0.75)-median(data2),'k');
ylim(ylimits)
xlim([-max(density2)*4 max(density2)*4])

subplot(4,3,12)
[density3,density_x3] = ksdensity(data3,'BandWidth',0.5);
densityline = plot(density3,density_x3,'k');
hold on
plot(-density3,density_x3,'k');
meanline = plot([-max(density3)/2 max(density3)/2],...
    [mean(data3) mean(data3)],'r','Linewidth',2);
medianline = plot([-max(density3)/2 max(density3)/2],...
    [median(data3) median(data3)],'k','Linewidth',2);
errorbar(0,median(data3),...
    median(data3)-quantile(data3,0.25),...
    quantile(data3,0.75)-median(data3),'k');
ylim(ylimits)
xlim([-max(density3)*4 max(density3)*4])

%% EXERCISE:
% this would be a good point to make the violin_plot a
% function to not copy it all the time!

% optional upgrades: draw a box instead of the errorbar,
% make the mean line a mean dot, allow a data matrix to be
% entered and plotted in one axis like with boxplots

figure(5); clf
data = [data1 data2 data3];
boxplot(data)
clf;
violin_plot(data)

%% raincloud plots
% violin plots waste space by plotting the density twice.
% also: https://xkcd.com/1967/
% rainclouds are an even better solution!

figure(6); clf

% plot normally distributed rain clouds
[handles] = raincloud_plot(data,'color',...
    [0.7 0 0; 0 0.7 0; 0 0 0.7],...
    'band_width',[1 0.5 0.8],'box_dodge',1,'box_alpha',0.2,...
    'alpha',0.5,'plot_width',0.3,...
    'dot_alpha',0.01);

hold on

data = data+50;
% plot uniformly distributed rain clouds
[handles] = raincloud_plot(data,'color',...
    [0.7 0 0; 0 0.7 0; 0 0 0.7],...
    'band_width',[1 0.5 0.8],'box_dodge',1,'box_alpha',0.2,...
    'alpha',0.5,'plot_width',0.3,...
    'dot_alpha',0.01,'dot_random_distribution','uniform');

% adjust axes
ax=gca;
set(gca,'ytick',[1 2 3])
ax.YTickLabel ={'normal','bimodal','lognormal'};
title('Raincloud plot for different distributions')
set(gca,'FontSize',16)

%% raincloud plots with connecting lines
figure(7); clf

% generate data with less data points (more realistic for
% our purposes)
m = 2;
sd = 2;
n = 40;

data1 = sort((randn(n,1)*sd)+m);

data2 = sort([randn(n/2,1)+m-sd; randn(n/2,1)+m+sd]);

v = sd^2;
mu = log((m^2)/sqrt(v+m^2));
sigma = sqrt(log(v/(m^2)+1));
data3 = sort(lognrnd(mu,sigma,n,1));

data = [data1 data2 data3];

[handles] = raincloud_plot(data,'color',...
    [0.7 0 0; 0 0.7 0; 0 0 0.7],...
    'band_width',[1 0.5 0.8],'box_dodge',1,...
    'connecting_lines',1,'box_alpha',0.2,'alpha',0.5,...
    'y_values',[0.8 1.8 2.8],'plot_width',0.1);

hold on
data = data+15;
raincloud_plot(data,'color',[0.7 0 0; 0 0.7 0; 0 0 0.7],...
    'band_width',[1 0.5 0.8],'box_dodge',1,'connecting_lines',1,...
    'box_alpha',0.2,'alpha',0.5,'y_values',[1.1 2.1 3.1],...
    'plot_width',0.1,'range_dots',0);

data = data+20;
[h, bw, d] = raincloud_plot(data,'color',...
    [0.7 0 0; 0 0.7 0; 0 0 0.7],...
    'band_width',[1 0.5 0.8],'box_dodge',0,...
    'connecting_lines',1,'box_alpha',0.2,'alpha',0.5,...
    'y_values',[0.85 1.85 2.85],'plot_width',0.3,...
    'range_dots',1,'box_width',0.3);

set(gca,'FontSize',16)
ax=gca;
set(gca,'ytick',[1 2 3])
ax.YTickLabel ={'normal','bimodal','lognormal'};
title('Lines for (simulated sorted) paired samples')

%% vertically plotted

figure(8);clf

[h, bw, d] = raincloud_plot(data,'color',...
    [0.7 0 0; 0 0.7 0; 0 0 0.7],...
    'band_width',[1 0.5 0.8],'box_dodge',0,...
    'connecting_lines',1,'box_alpha',0.2,'alpha',0.5,...
    'plot_width',0.05,...
    'range_dots',1,'box_width',10,'y_values',[0.2 0.4 0.8],...
    'cloud_edge_col','none','box_dodge',1,...
    'distance_drops', 0.01);

hold on

[h, bw, d] = raincloud_plot(data,'plot_vertical',1,...
    'color',[0.7 0 0; 0 0.7 0; 0 0 0.7],...
    'band_width',[1 0.5 0.8],'box_dodge',0,...
    'connecting_lines',1,'box_alpha',0.2,'alpha',0.5,...
    'plot_width',0.05,...
    'range_dots',1,'box_width',1,'y_values',[1.2 1.4 1.8],...
    'cloud_edge_col','none');

set(gca,'FontSize',16)
title('View turned to vertical, with specified y values')

%% Exercise
% Take some time to understand the raincloud_plot function.
% Play around with the different settings and think about
% what could still be improved.

%% images

% you can plot a matrix as an image
% the input determines the color of each pixel 
f_handle = figure(9);clf
f_handle.Color = [1 1 1];

imagesc(randn(100))

% as with other plotting functions, imagesc can take x and y
% axis inputs as the first and second input
imagesc(1:1:100,0:.01:1,randn(100))

% let's plot our beloved gaussian, this time in 2D
xyrange = -1.5:.01:1.5;

% we need to have a full grid of x and y values, since each
% of these values has to go through the function
[X,Y] = meshgrid(xyrange);

% what is it actually?
imagesc(X)
imagesc(Y)

% compute the 2D gaussian
gauss2d = exp(-(X.^2 + Y.^2));

imagesc(gauss2d)

% make sure the axis is always a square
axis square

% plot a colorbar in addition to visualize what the colors
% mean
colorbar

% you can use different colormaps for the plots. standard is
% jet, many scientific papers use this
colormap jet

% other colormaps exist as well and can be found in the doc
doc colormap

% grayscale is always a good idea to see how it will look
% with a grayscale print
colormap gray

% the jet colormap has a lot of downsides, very clearly the
% color does not give a smooth visual percept of the
% actually smooth curve.
% for scientific visualization there should either
% unipolar or bipolar diverging maps be used, depending on
% the kind of data
colormap jet
colormap spring

% beautiful, but maybe not exactly what we need
myCmap = diverging_map([1:256]/256, [0.230, 0.299, 0.754],...
    [0.706, 0.016, 0.150]);
colormap(myCmap)

% much better! my standard colormap. you can use this
% command in your startup file to always have this colormap
% by default:
set(0,'DefaultFigureColormap',myCmap)

subplot(2,2,1,gca)
title('function: imagesc')
colorbar('off')
set(gca,'fontsize',14)

subplot(222)
contour(xyrange,xyrange,gauss2d)
title('function: contour')
axis square
set(gca,'fontsize',14)

subplot(223)
contourf(xyrange,xyrange,gauss2d)
axis square


contourf(xyrange,xyrange,gauss2d,20,...
    'linecolor',[0.3 0.3 0.3])
title('function: contourf')
axis square
set(gca,'fontsize',14)

%% finally: 3D plots!

subplot(224)
surf(xyrange,xyrange,gauss2d)
title('function: surf')
rotate3d on

% it's all black because the meshgrid is actually part of
% the plot. we can get rid of it with this
shading interp
axis square

% if you don't want the axis, just disable it
axis off
set(gca,'fontsize',14)

%% akin to the normal plot function, there's the same in 3D

n = 30;
dataX = rand(1,n);
dataY = randn(1,n);
dataZ = rand(1,n)*10;

figure(10), clf
plot3(dataX,dataY,dataZ)

% nice features
grid on
rotate3d on

% like before, you can also label the axes
xlabel('X-axis')
ylabel('Y-axis')
zlabel('Z-axis')

% and of course you can add and change markers
plot3(dataX,dataY,dataZ,'ko','linew',3,'markerface',...
    'm','markersize',10)
grid on
rotate3d on


% you have to have the three vectors separately, a matrix
% can not be used instead
plot3([dataX;dataY;dataZ])

%% Play around with surf a bit more

figure(11);clf

data = randn(50);
surf(data)
shading interp

hold on

surf(zeros(50))
rotate3d on

shading interp
%% EXERCISE
% create a plane at z=0 in black as a specified color
% instead of using the colormap


%% last but not least: exporting figures

print(f_handle,'print','-dpng') % creates png
print(f_handle,'print','-depsc') % creates eps
print(f_handle,'print','-dpdf') % creates pdf
print(f_handle,'print','-dtiff') % creates tif
savefig(f_handle, 'export') % saves the fig itself

% the built-in functions work well, but there are
% better ways with more specifications, like transparent
% background and antialiasing
export_fig(f_handle, 'exported', '-png', '-tif', '-p0.05',...
    '-a4', '-q101', '-transparent')

