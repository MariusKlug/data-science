% Assignment 6 for the class Data Science for Human Factors:
% Plotting 2
%
% Team:

scores = 0;

%% Plotting some climate data
% This is a real data set of climate data from three stations in Germany.
% The climate data in its raw form is not very informative.
% This should be changed in the following plots.

load climate_data.mat

all_climate_data
all_climate_metadata

%% 1) 2P
% Compute moving averages of all three temperature data sets
% using movmean. Use a 30-day-average, a one-year-average,
% a 10-y-average, and a 30-y. Make three plot columns with
% 5 rows each for the three climate datasets, containing
% the original daily data, then the four moving averages.
% Make sure to have appropriate descriptions.
% Replace -999 values with NaN and use the nanflag in
% movmean. Using the following combination you can set the 
% x-ticks to the years. It's a bit misleading because it 
% does not mark the actual start of the year but it will do. 
% Just be aware that this is the case!

% date_data = [all_climate_data{i_dataset}.date];
% years_data = round(date_data/10000);
% xlim([1 length(years_data)])
% set(gca,'XTick',round(linspace(1, length(years_data), 7)))
% set(gca,'XTickLabel',years_data(round(linspace(1, length(years_data), 7))))

% The figure should look like this:

openfig('moving_averages')

%%

%%
scores(1) = 2

%% 2) 1.5P
% Compute the 10-year moving average of temperature and precipitation
% (Freudenstadt only) and plot both, 10-y temperature and precipitation of
% the Freudenstadt station in one plot using two separate y-axes. Make an
% appropriate legend. Use the left axis for precipitation and the right for
% temperature. The figure should look like this:

openfig('Freudenstadt_temp_precipitation')

%%


%%
scores(2) = 1.5

%% 3) 1P
% The moving window average shortens the window at the
% edges because no more data is available. Make an annotation
% in the figure of b) where the moving window becomes
% unreliable both to the left and right of the figure. Read
% the movmean help formore information. Draw a vertical line
% at the precise positions and then a textbox with two
% arrows pointing towards these lines. 

% The figure should look like this:

openfig('Freudenstadt_temp_prec_boundaries')

%%


%%
scores(3) = 1

%%
final_score = sum(scores)
