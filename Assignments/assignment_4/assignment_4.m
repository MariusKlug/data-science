% Assignment 4 for the class Data Science for Human Factors:
% Plotting 1
%
% Team:

%% 1) 2.25P
% Recreate this figure as close as possible, including the position.

openfig('gaussian.fig')

%%


%%
scores(1) = 0

%% 2) 1.5P
% A straight line is just a plot from one point to another.
% Draw a figure with three subplots in a 2x2 geometry: 
% One spanning the entire first line, that one should be 
% filled with the gaussian. The second line should be 
% divided and contain a square (left) and a hexagon (right).
% Your figure should look like this:

openfig('subplots_square_hexagon')

% example of a straight line
fig_handle_2 = figure(3); clf
plot([0 1],[-4 5],'k')

%%
clf

%%
scores(2) = 0

%% 3) 0.75P
% a) 0.5P
% Draw two lines with a width of 0.5 and the color [0.5 0.5 0.5] at x=0 and
% y=0 spanning the entire axes into figure 2 (the gaussian that you created
% yourself). To do so, use the get function to find the x and y axis
% limits. Plot into the existing axes, do not create a new figure! Do not
% use hard coded figure numbers, use handles for this. The figure should
% look like this:

openfig('gaussian_axes.fig')

%%


% b) 0.25P
% What is your conclusion about the order of plotting within an axis? Why?



%%
scores(3) = 0

%% 4) If you want to plot some more (no points!)
% Plot the climate data into one figure. Choose settings to
% your liking to follow the guidelines and make as much
% relevant information accessible. There's no clear solution
% here, find your own way and style!

load climate_data.mat


%%
final_score = sum(scores)

