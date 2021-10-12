%% Data Science for Human Factors course - script 4
% Plotting Introduction, subplots, get, set
%
% This script is free to use and distribute for anybody!
%
% Author: Marius Klug, 2019, bpn.tu-berlin.de
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% A motivating example

% the goals is to produce a Gaussian (normal curve)
x = -1:.01:1;
s = 0.2;

% this is the formula
gaussian = 1/(s*sqrt(2*pi)) * exp( -x.^2 / 2*s^2 );

% plot is the standard plot for x vs y, lines by default
plot(x,gaussian)

% but when plotting, it doesn't look right,
% this is why it's important to visualize your data

%% EXERCISE
% What's the problem in the function? 
% Fix it and plot it.

gaussian = 1/(s*sqrt(2*pi)) * exp( -x.^2 / (2*s^2) );
plot(x,gaussian)

%% Working with the figure

% you can zoom, inspect, drag, ... the figure

% if you want to keep your figures organized, this 
% will open new figures as a docked window and won't 
% clutter your screen
set(0,'DefaultFigureWindowStyle','docked')

% set(0,'DefaultFigureWindowStyle','normal')

%% Figures

figure % opens a new figures

% close the current figure
close

% you can also open and close specific figures
figure(10)
figure(100)
figure(103)

close([100 103])

% clf clears the figure without closing it
clf
clf(1)

% get current figure handle
gcf

%% Plotting creates axes

plot(x,gaussian)
gca

close all

%% We can have several axes in a figure

% plotting like this will always use the same figure and
% make sure it is always empty when starting to plot.
figure(1); clf

% 1 row, 3 columns, make the first subplot active
subplot(1,3,1) 

% if you have one-digit numbers, you can leave the commas
subplot(131)
plot(x,gaussian)

% you need to always enter the geometry of your subplot 
% and then specify the active part, even if it's already 
% split up:
% 1 row, 2 columns, make the second subplot active
subplot(132) 
plot(gaussian,x)

%% You can change the geometry on the fly

% the active window is left-to-right and top-to-bottom, 
% like when reading
subplot(233)

% you will overwrite pre-existing plots, though, so be
% careful
subplot(235)

% you can access several parts of the subplot
subplot(2,3,[2 5])
plot(gaussian,x)

%% Subplots can be inside a loop

figure(2),clf

x2 = -10:0.1:10;

for i_subplot=1:4
    subplot(2,2,i_subplot)
    
    y = x2.^i_subplot;
    
    plot(x2, y)
end

%% EXERCISE 
% Plot the gaussian in a new figure and 
% convert the existing axes into a subplot AFTERWARDS,
% dividing the plot in two horizontal plots.
% Then plot the 4th order polynomial in the other subplot.
% hint: use F1 to get help.

figure(3); clf
plot(x,gaussian)

subplot(2,1,1,gca)
subplot(2,1,2)
plot(x2,y)

%% Now to some more plotting
% let's plot the 4 different functions in one plot

figure(4); clf

for exponent = 1:4
    y_matrix(exponent,:) = x2.^exponent;
end

size(x2)
size(y_matrix)

for i_plot = 1:4
    
    plot(x2,y_matrix(i_plot,:))
    
end

%% This always overwrites the previous plot!
figure(4); clf

% with hold "on|off" you can define whether or not the plot
% should overwrite the previous
hold on

for i_plot = 1:4
    
    plot(x2,y_matrix(i_plot,:))
    
end

%% We can also plot this directly as matrices

figure(4); clf

% X and Y in the plot must be of the same size
plot([x2;x2;x2;x2],y_matrix)

% it might be necessary to transpose your matrix with ' to
% plot it the right way
plot([x2;x2;x2;x2]',y_matrix')

%% Worked, but hard to see. let's edit some properties

figure(5); clf

hold on

% now we copy & paste the plot 4 times and use different
% line styles by setting some flags in the plot function.
% this can't easily be done in a loop and sometimes a script
% is just fine :)

plot(x2,y_matrix(1,:),'k-', 'LineWidth',2)
plot(x2,y_matrix(2,:),'k:', 'LineWidth',2)
plot(x2,y_matrix(3,:),'k--','LineWidth',2)
plot(x2,y_matrix(4,:),'k.', 'LineWidth',2)

% many more options exist for the plot function!

% now since the polynomials are very different in scale, we
% can adjust the x-axis to be more close to 0

xlim([-2 2])

% this works, but using specified get and set would be
% better to avoid confusion. the x-axes property is part of
% the axes of course, so we need to use the axes hande

set(gca,'xlim',[-1.5 1.5])


%% gca always takes the last plotted or clicked on axes
% we'd rather have it specified exactly, so let's creaqte
% some handles

figure(5); clf
% no axes yet, no handles yet

hold on
% ah, axes appear. let's make sure that we draw into the now
% created axes
axes_to_plot = gca

%% Now let's change some more stuff in the axes

% we can specify the axes in the plot function
plot(axes_to_plot,x2,y_matrix(1,:),'k-', 'LineWidth',2)
plot(axes_to_plot,x2,y_matrix(2,:),'k:', 'LineWidth',2)
plot(axes_to_plot,x2,y_matrix(3,:),'k--','LineWidth',2)
plot(axes_to_plot,x2,y_matrix(4,:),'k.', 'LineWidth',2)

% now we can change properties of said axes
set(axes_to_plot, 'xlim', [-2 2])

% let's change the x ticks
set(axes_to_plot, 'xticks', [-1.5 0 1.5])

% hmm let's search for the property
axes_to_plot
% also: Google "matlab axes properties"

set(axes_to_plot, 'XTick', [-1.5 0 1.5])
set(axes_to_plot, 'XTick', [-1.5:0.3:1.5])

% this can be done easier, too
xticks([-1.5 0 1.5])

% let's change the label
set(axes_to_plot, 'XTickLabel',...
	{'minusonepointfive', 'zero', 'plusonepointfive'})

% and again, this can be done easier
xticklabels({'minus one point five', 'zero',...
	'plus one point five'})

% that's hard to read, let's make it angled
xtickangle(20)

%% EXERCISE
% 1) Find the set property and rotate it 60 degrees
% with the set function. 
% 2) Also find the font size and change
% it to 14
% 3) Find a way to change the axes line width to 1.5

set(axes_to_plot,'XTickLabelRotation',60)
set(axes_to_plot,'FontSize',14)
set(axes_to_plot,'linewidth',1.5)

%% Now let's give the axes a label

% working with the current axes
xlabel('X-Axis')
ylabel('Y-Axis')

% set uses a special text object, which we can't easily make
set(axes_to_plot,'XLabel','X Axis')

% fortunately the functions also have a way to pass a handle
xlabel(axes_to_plot,'X Axis')
ylabel(axes_to_plot,'Y Axis')

%% Okay, now we can set properties of the axes
% but what if we want to access properties of the figure or
% the plots themselves?

% figures have handles, too
figure_handle = gcf

figure_handle.Color = 'white'

% it's also possible to use set and get in one line
set(gcf,'Color','blue')

% color are limited (no grey e.g.). 
% colors can also be 3D vectors, sometimes 4D if
% an alpha value (transparency) is included
set(gcf,'Color',[0.9 0.9 0.9])

%% Let's plot a line again and use the same concept

figure(6);clf

plot_handle = plot(x,gaussian)

set(plot_handle,'Color',[0 0 0])

% again, get and set as well as direct access is possible
% it does not make a difference, but sometimes one is easier
% than the other, especially since you can use TAB-complete
% for direct access. 

plot_handle.LineStyle = ':';


%% Last thing: Lines can have markers

% either on all data points
set(plot_handle,'LineWidth',1)

plot_handle.Marker = 'o';

% or for specific indices
% Note: this does not work with older MATLAB versions! 
% It was introduced in R2016b.
marker_indices = plot_handle.MarkerIndices

plot_handle.MarkerIndices = marker_indices(1:10:end);

%% The workaround is to plot twice:

figure(6);clf

plot(x,gaussian,'k:');

hold on

% k means black and o is the marker. linestyle can set both
% in one go
plot(x(1:10:end),gaussian(1:10:end),'ko');

% it would even be possible to set the color, line style,
% and marker at once
plot(x(1:10:end),gaussian(1:10:end),'r--o');