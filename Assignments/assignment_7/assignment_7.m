% Assignment 7 for the class Data Science for Human Factors:
% Input/Output Basics
%
% Team:

scores = 0;

%% 1) 0.25P
% Create a 2x3 matrix of random numbers in a variable randmat. Evaluate the following two lines of code,
% and compare the output files in a text editor. What is the difference and why did it happened?

dlmwrite('test1.txt', randmat ,' ')
dlmwrite('test2.txt','randmat',' ')

%%
scores(1) = 0;

%% 2) 0.5P

dataoutname = 'data4me';
a = 5:50;
b = linspace(1,2,46);
data4me = [a;b];

% These next lines contain errors. Find and fix them. 

% the following three lines lead to only one solution, the other  
% lines require their own solutions.
save(dataoutname;'a';'b')
save(dataoutname,'a';'b')
save(dataoutname '.mat','a','b')

dlmwrite('file.txt')

xlswrite('file.xls','data4me')

data = load("data4me.mat");

data = load({ 'data' num2str(4) 'me.mat' });

%%
scores(2) = 0;

%% 3) 3.75P
% we're reading a few data files which we will use later in the course. 
% these are actual weather data files of the "Deutscher Wetterdienst", 
% which can be downloaded on their website:

% https://www.dwd.de/DE/leistungen/klimadatendeutschland/klarchivtagmonat.html

% The goal is to automatically scan the folder for all folders that contain 
% this kind of climate data and store it all such that we can plot it later.

% make sure your current folder is the one that has the asiignment and 
% klarchiv subfolders in it
folder_to_scan = fullfile(pwd,'climate_data');
all_files = dir(folder_to_scan)

% regexp searches for a string regular experession in another string.
% .* is a wildcard for "insert anything here" and gives a cell array
% with the indices where to find the expression. If the expression was not
% found, it returns an empty list

% cellfun applies a given function (i.e. "isempty") to a cell array

% -> these expressions search for entries that have somehwere 'klarchiv',
% and somewhere behind that 'his'/'akt'. These indices are being used to 
% select only the relevant files from all files.
% there are as many historic datasets (data until 2017) as current (17 and 18).

% take a close look at what happens in each stage here!
historic_data = all_files(~cellfun(@isempty, regexp({all_files.name},'klarchiv.*his')));
current_data = all_files(~cellfun(@isempty, regexp({all_files.name},'klarchiv.*akt')));

% initialize dataset:
% it will be a cell array of struct arrays, which are going to be created
% for the historical data of different weater stations and the filled up 
% with the latest data. each struct array will contain an entry for each day with  
% weather information.

all_climate_data = cell(length(historic_data),1);
all_climate_metadata = cell(length(historic_data),1);

% search all historical datasets to build the respective data struct array
for i_file = 1:length(historic_data)
    
    fprintf('File #%d\n',i_file)
    
    complete_path = fullfile(historic_data(i_file).folder, historic_data(i_file).name);
        
	% subtasks can be found inside the premade functions
    [all_climate_data{i_file}, all_climate_metadata{i_file}] =...
        extract_climate_data(complete_path);
    
end

%% plot for testing purposes only
figure(1);clf;plot([all_climate_data{1}.date],[all_climate_data{1}.temperature])

%%
scores(3) = 0;

%% 4) Extra, if you're bored (no points!)

% search all current datasets to add the latest data to the respective data struct array.
% beware: the historical data is until end of 2017, but the current data has parts of 2017
% as well. only copy the dates into all_climate_data that are actually new! 

% first, we need to transform the cell array into a struct array by indexing
% the entire cell array with {:} and wrapping the expression with [].
% this is possible because the cell array contains structs with identical fiels
all_climate_metadata_struct = [all_climate_metadata{:}];
    
for i_file = 1:length(current_data)
    
    fprintf('File #%d\n',i_file)
    
    % extract the current data with the same function as above.
    % no need to store it in a cell here, since you'll use the info 
    % and copy it directly into the previous data
	
	complete_path = 
	
	[climate_data_current, climate_metadata_current] =...
        extract_climate_data(complete_path);
    
    % find the index in the previous cell of the matching station ID
    % hint: take all ID values of the climate metadata wrapped with []
    % to get a vector, and compare this vector with the current ID, 
    % then find the one that gave a "1" response
    matching_index = 
    
    % extract all the date info of the current data (use [] again), 
    % find the indices of dates that are younger than 20181231
    dates = 
    dates_2019 = 
    
    % append the all_climate_data struct of the matching index 
    % with the current information using [];    
    all_climate_data{matching_index} = 
    
end

%% plot for testing purposes only
figure(2);clf;plot([all_climate_data{1}.date],[all_climate_data{1}.temperature])
dates = [all_climate_data{1}.date];
assert(length(dates) == 26230)
assert(isequal(dates(25933:25934), [20181231 20190101]))
assert(dates(end) == 20191024)

%%
final_score = sum(scores)
