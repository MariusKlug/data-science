%% Data Science for Human Factors course - script 6
% Plotting 2: Descriptive plots
%
% This script is free to use and distribute for anybody!
% 
% Author: Marius Klug, 2019, bpn.tu-berlin.de
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Legends

% our beautiful gaussian again

figure(1); clf

x = -1:.01:1;

s = 0.2;
gaussian1 = 1/(s*sqrt(2*pi)) * exp( -x.^2 / (2*s^2) );

gauss1_handle = plot(x,gaussian1);

hold on

s = 0.1;
mu = 0.2;
gaussian2 = 1/(s*sqrt(2*pi)) * exp( -(x - mu).^2 / (2*s^2) );

gauss2_handle = plot(x,gaussian2);

% greek letters or other special characters can be used!
legend_handle = legend({'{\sigma} = 0.2, {\mu} = 0',...
    '{\sigma} = 0.1, {\mu} = 0.2'});

%% let's adjust the legend a bit

legend_handle.FontSize = 14;
legend_handle.Location = 'north';
legend_handle.Location = 'best'
legend_handle.Orientation = 'horizontal'
legend_handle.Orientation = 'vertical'

% we can also adjust this manually
legend_handle.Position = [0.4 0.7 0.35 0.2]

%% EXERCISE
% What do the position values represent? Find it out by
% playing around with it and/or using the doc.

%% Let's plot some more stuff

figure(2); clf

idx_peak1 = gaussian1==max(gaussian1);
idx_peak2 = gaussian2==max(gaussian2);

gauss1_peak_handle1 = plot(x(idx_peak1),...
    gaussian1(idx_peak1),'ko');
hold on
gauss1_peak_handle2 = plot(x(idx_peak2),...
    gaussian2(idx_peak2),'ko');

gauss1_handle = plot(x,gaussian1);
gauss2_handle = plot(x,gaussian2);

% just using legends always creates the legend in the order
% of plotting
legend_handle = legend({'{\sigma} = 0.04, {\mu} = 0',...
    '{\sigma} = 0.1, {\mu} = 0.2','Peaks'});

% since we have the handles, we can assign the legends to
% their plots
legend_handle = legend(...
    [gauss1_handle gauss2_handle gauss1_peak_handle1],...
    {'{\sigma} = 0.04, {\mu} = 0',...
    '{\sigma} = 0.1, {\mu} = 0.2','Peaks'});

%% Two axes in one (left and right)

f=figure(3); set(gcf,'color','w'); clf

x = 0:0.01:20;
y1 = 200*exp(-0.05*x).*sin(x);
y2 = 0.8*exp(-0.5*x).*sin(10*x);

plot(x,y1);
hold on
plot(x,y2);

% this is hardly useful because we can not evaluate the
% second line. so we want to have two different scales for
% the plots

clf

% switching to the left-hand scale
yyaxis left
hLine1 = plot(x,y1,'--');
ylabel('y_1')

% switching to the right-hand scale
yyaxis right
plot(x,y2);
ylabel('y_2')

xlabel('x')

% changing color properties is possible with handles
set(hLine1,'color','r')

% but it does not change the color of the axes themselves

% changing the color of the axes is possible as a default
set(gcf,'defaultaxescolororder',[0.4 0.4 0.4; 0.8 0.8 0.8])
% this needs to be run before plotting and it will remain even with clf. If
% you want to get back the normal colors, you need to close the figure.

% rerun this section to see the new colors


%% yyaxis was introduced in 2016
% older versions need to run this
clf


[hAx,hLine1,hLine2] = plotyy(x,y1,x,y2);

ylabel(hAx(1), 'y1')
ylabel(hAx(2), 'y2')
xlabel('x')

%% now we know which line is scaled how, so we need the
% legend in addition

legend({'200*exp(-0.05*x).*sin(x)',...
    '0.8*exp(-0.5*x).*sin(10*x)'})

% set a grid that makes the plot easier to read
grid on

% some more tweaks for fontsize and background color
set(gca,'fontsize',14)
f.Color = [1 1 1];

%% Annotations in a plot

figure(4); clf

% just plot a straight line
plot(1:10)
title('Plot with annotations')

% using text(), we can write text in our plots 
text(4,3.5,'This is a text!','Color','r','FontSize',15);

% with annotations we can do a bit more fancy tings like
% arrows
x = [0.3 0.5];
y = [0.6 0.5];
a=annotation('textarrow',x,y,'String','y = x ')

% if you want to draw rectangles around significant regions
% for example, you can use the rectangle annpotation
dim = [.3 .68 .2 .2];
annotation('rectangle',dim,'Color','red')

% and as usual, you can change features of the annotation
dim2 = [.74 .56 .1 .1];
annotation('rectangle',dim2,'FaceColor','blue','FaceAlpha',.2)

% You can also have a text in a box if you want to have your
% own specific legend for example
dim = [0.15 0.6 0.3 0.2];
str = {'Straight Line Plot','from 1 to 10'};
annotation('textbox',dim,'String',str,'FitBoxToText','off');

%% Scatter plots

figure(5);clf;

% first, let's greate some dots by clicking on the figure
hold on;
axis([0 2 0 2]);
allXs=0.5;
allYs=0.5;
plot(allXs,allYs,'x');


button=1;

% continue as long as the pressed button is 1 (left mouse)
while (button==1)
    
    % ginput raises crosshairs in the current axes to for 
    % you to identify points in the figure, positioning the 
    % cursor with the mouse.
    [x,y,button]=ginput(1);
    
    % the x and y position are plot and stored
    plot(x,y,'x');
    allXs(end+1) = x;
    allYs(end+1) = y;
end


%% EXERCISE
% plot this data as a scatterplot in a separate figure. There are two ways
% this can be done!

figure(6);clf

scatter(allXs, allYs)
axis([0 2 0 2]);

% a scatterplot is essentially a plot with just the markers
% without any connecting lines
plot(allXs, allYs,'ko')
axis([0 2 0 2]);

%% Descriptive statistics plots

figure(7); clf

% generate some data sets. they are generated such that they
% have the same mean and SD but are in fact quite different.

rng default  % for reproducibility
m = 20;
v = 10;
n = 10000;
ylimits = [-30 100];

% normally distributed data
data1 = (randn(n,1)*v)+m;

% bimodal data
data2 = [randn(n/2,1)+m-v; randn(n/2,1)+m+v];

% lognormally distributed data
v = v^2;
mu = log((m^2)/sqrt(v+m^2));
sigma = sqrt(log(v/(m^2)+1));
data3 = lognrnd(mu,sigma,n,1);

% bar plots, the classics
subplot(3,3,1)
bar(1,mean(data1),0.5)
hold on
% errorbar to visalize the standard deviation
errorbar(mean(data1),std(data1))
ylim(ylimits)
title(['{\mu} = ' num2str(mean(data1)) ', {\sigma} = '...
    num2str(std(data1))])

subplot(3,3,2)
bar(1,mean(data2),0.5)
hold on
errorbar(mean(data2),std(data2))
ylim(ylimits)
title(['{\mu} = ' num2str(mean(data2)) ', {\sigma} = '...
    num2str(std(data2))])

subplot(3,3,3)
bar(1,mean(data3),0.5)
hold on
errorbar(mean(data3),std(data3))
ylim(ylimits)
title(['{\mu} = ' num2str(mean(data3)) ', {\sigma} = '...
    num2str(std(data3))])

% bar plots are widely used in papers, but they are actually
% horrible. it's really nothing more than the mean and
% standard deviation, and this only correctly descibes a
% data set if it is normally distributed. even then there
% are better ways to display more information. 

% one step further is the box plot. box plots visualize the
% median, 25% amd 75% quantiles and the whiskers for
% outlier detection. boxplot draws points as outliers if 
% they are greater than q3 + whisker_length * (q3 - q1) or less than 
% q1 - whisker_length * (q3 - q1). q1 and q3 are the 25th and 75th 
% percentiles of the sample data, respectively. default is
% whisker_length = 1.5, approximately +/-2.7 sigma and 
% 99.3 percent coverage if the data are normally distributed.

subplot(334)
boxplot(data1)
ylim(ylimits)
title(['Median = ' num2str(median(data1))])

subplot(335)
boxplot(data2)
ylim(ylimits)
title(['Median = ' num2str(median(data2))])

subplot(336)
boxplot(data3)
ylim(ylimits)
title(['Median = ' num2str(median(data3))])

% we can already see clear differences in our datasets, as
% we should... but for example the bimodal dataset still
% does not properly get visualized

% histograms are a nice way to actually visualize the
% distribution with more accuracy

nbins = 50;
subplot(337)
histogram(data1,nbins)
subplot(338)
histogram(data2,nbins)
subplot(339)
histogram(data3,nbins)

% Better! Always remember this example when you see bar 
% plots. Friends don't let friends make bar plots :)

%% One last thing about box plots:

% plotstyle compact is sometimes the better choice,
% depending on the amount of plots you have in your figure

figure(8);clf
boxplot(randn(50),'plotstyle','compact','color',...
    [0.2 0.2 0.2])
hold on
plot(get(gca,'xlim'),[0 0],'k')