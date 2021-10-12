% Assignment 8 for the class Data Science for Human Factors:
% Plotting 3
%
% Team:

scores = 0;

%% 1) 1.25P
% Climate diagram of Berlin-Tempelhof. First load and prepare the data.

load climate_data.mat

stationID = 1;
all_climate_metadata{stationID}

% easy access of time information
dates = datetime([all_climate_data{stationID}.date],'ConvertFrom','yyyymmdd');
years_in_data = dates(end).Year-dates(1).Year+1; 

% get data
temperature_data = [all_climate_data{stationID}.temperature]; 
temperature_data(temperature_data==-999) = NaN; % remove missing values

precipitation_data = [all_climate_data{stationID}.precipitation];
precipitation_data(precipitation_data==-999) = NaN;

pressure_data = [all_climate_data{stationID}.pressure];
pressure_data(pressure_data==-999) = NaN;

% split the data into monthly information. Per month, take the mean of temperature 
% and pressure data and the sum of precipitation for this. 

temperature_data_split = NaN(years_in_data,12);
precipitation_data_split = NaN(years_in_data,12);
pressure_data_split = NaN(years_in_data,12);

for i_this_year = 1:years_in_data
	
	this_year = dates(1).Year+i_this_year-1;
	
	disp(this_year)
	
	year_dates = dates.Year == this_year;
		
	for i_month = 1:12
		
		month_dates = year_dates & dates.Month == i_month;
		
		temperature_data_split(i_this_year,i_month) = nanmean(temperature_data(month_dates)); 
		pressure_data_split(i_this_year,i_month) = nanmean(pressure_data(month_dates)); 
		precipitation_data_split(i_this_year,i_month) = nansum(precipitation_data(month_dates));
	
	end
end


%% a) 0.75P
% Reproduce the following figure as closely as possible, including the
% size, colors, and the position and width of the bar plot. It's a climate
% diagram of Berlin-Tempelhof, taking the 30-years average starting from
% 1948 (earliest date available).

open('1a.fig')
close

%%
startyear = 1948;
climate_average_duration = 30;


%% b) 0.5P
% Add the 30-year average of the latest available data (1989-2018) to the
% plot and reproduce the figure as closely as possible, including the
% colors. Add the correct new legend entries WITHOUT using the "legend"
% function another time!

open('1b.fig')
close

%%
startyear = 1989;
climate_average_duration = 30;


%%
scores(1) = 0

%% 2) 1.75P
% Plot temperature, precipitation, humidity, and air pressure as moving 
% averages of 30 years. Don't use movmean but compute the averages per year
% yourself, such that the (first) year 1978 contains the average of the
% years 1949 - 1978, the next year 1950 - 1979 etc.
% Plot it per year with changing colors for each year, include a colorbar
% for each different axis.
% Use the following colors to replicate the following figure as closely as
% possible, including the size and the axes limits and ticks.

% Humidity is defined as summed monthly precipitation minus twice the 
% monthly average temperature. It corresponds to the climate chart layout, where
% climates with precipitation visually above the temperature are called "humid" 
% and climates with precipitation falling visually below the temperature are
% called "desert" (ger. "arid"). 

humidity = precipitation_data_split - 2*temperature_data_split;


average_duration = 30;
indices_average_years = average_duration:length(humidity);
plotlength = length(indices_average_years);

cbar_labels = indices_average_years(round(linspace(1,length(indices_average_years),5)));
cbar_labels = cbar_labels + dates(1).Year - 1;

colors_temp = [linspace(0.7,0.9,plotlength); linspace(0.9,0.0,plotlength); linspace(0.0,0.1,plotlength)]';
colors_precipitation = [linspace(0,0.1,plotlength); linspace(0.0,0.6,plotlength); linspace(0.9,0.7,plotlength)]';
colors_humidity = [linspace(0.2,0.9,plotlength); linspace(0.6,0.4,plotlength); linspace(0.0,0.1,plotlength)]';
colors_pressure = [linspace(0.2,0.7,plotlength); linspace(0.2,0.7,plotlength); linspace(0.2,0.7,plotlength)]';

open('2.fig')
close

%%


%%
scores(2) = 0

%% 3) 1P
% Plot the same data in 3D and reproduce the following figure as closely as
% possible, including the size and the orientation of the view, as well as the 
% axes limits. Use the colorscheme of 2) as colormaps in the depicted direction.
% Hint: fliplr()

open('3.fig')
close

%%


%%
scores(3) = 0

%% 4) 0.5P
% Think about the plots. Which elements are good, which can be improved,  
% and why? Would you show them around? Would you use the 2D or 3D version,
% and why? Do you think they are objective, and why or why not? What is
% your take-home message of the data visualization part of the course?

scores(4) = 0

%%
final_score = sum(scores)
% 
