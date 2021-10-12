%% Data Science for Human Factors course - script 7
% Input / output
%
% This script is free to use and distribute for anybody!
%
% Author: Marius Klug, 2019, bpn.tu-berlin.de
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% .txt files
% The simplest way to read in text data is if all data in the next are
% numbers (no text). Open a text editor and make a small matrix (say, 3x4).
% Next, type: 
data = load('txt_datafile.txt')

% slightly more advanced:
[file_name,file_path] = uigetfile('*.txt'); % ui = user-interface
data = load([ file_path file_name ])

%% MATLAB-format .mat files

% save a variable from workspace into .mat file
save mat_datafile data

% load directly into the workspace
clear
load('mat_datafile.mat')
% or
load mat_datafile
data
whos


% or load as fields into a structure
clear
datastruct = load('mat_datafile.mat')
whos

% we must select the struct content to get the original variable
data = datastruct.data
whos

%% Export with delimiter

% comma-separated values
csvwrite('csv_datafile.csv',data)

% other-separated-values (default is also comma)
% -> this gives us the original txt file again
dlmwrite('dlm_datafile.txt',data,' ')

%% Export to Excel

xlswrite('xls_datafile',data)

%% Load the different file types

% you can also read in data from excel files, but BE CAREFUL because this
% function can act in unexpected ways, e.g., by removing empty columns and
% rows without warning (this can be seen in comparing "numberdata" to "raw_data"). 
% Therefore, it might be best to use the "raw" data output. 

clear

data_import = importdata('xls_datafile.xls');

[numberdata,textdata,raw_data] = xlsread('xls_datafile');

dlm_data = load('dlm_datafile.txt')
dlm_data2 = dlmread('dlm_datafile.txt',' ')

csv_data = load('csv_datafile.csv')
dlm_data2 = csvread('csv_datafile.csv')

%% Exercise

% try loading the file 'mixed_file.txt' with the different loading functions.
% can we load this kind of information easily? search for a way to 
% read tables like this one.


%% advanced importing text data

% Here we borrow from C language to flexibly read in mixed data. Let's say
% you have some poorly organized behavioral data files to read in, but at 
% least you know what text strings to look for: 

fid = fopen(fullfile(pwd,'headache-data.txt'),'r');
% fid is a pointer to a location on the physical hard disk (similar to how
% we used variables as handles to axes when plotting). The 'r' means read
% (later we'll use 'w' for write).

% In this particular example, we will extract the trial number, subject
% choice, reaction time (RT), and accuracy for each trial. Fields are separated by tabs.

% initialize... we can't initialize the full matrix, because we don't know how big this will be.
behavioral_data = []; 

% The following code will remain inside a loop, reading in and processing new
% lines of data, until we reach the end of the file. We need to store the
% read data in a matrix for which we need an index.
% This index is not the line index of the file, but the one of our matrix!
row = 1;

while ~feof(fid) % feof tests whether we're at the end of the file.
    
    % read a line ("file get line")
    % this function automatically counts upwards after each call,
    % no need to have your own iterator!
    aline = fgetl(fid); 
    % the line is just a string that we can now parse
    
    aline_split = strsplit(aline,'\t')
    
    % regexp could also be used to cut data according to delimiters. 
    % aline_split = regexp(aline,'\t','split')
    
    % here we use strcmpi to compare strings. The "i" means to ignore case.
    if ~any(strcmpi('trial',aline_split))
        % continue means to skip to the next iteration of the loop.
        continue 
    end
    
    % this part of the code can only be reached if a trial was found in the line
    % because otherwise "continue" would have been called.
    
    % find the actual matching values in the line
    trial_column    = find(strcmpi('trial',   aline_split));
    choice_column   = find(strcmpi('choice',  aline_split));
    rt_column       = find(strcmpi('rt',      aline_split));
    accuracy_column = find(strcmpi('accuracy',aline_split));
    
    behavioral_data(row,1) = str2double(aline_split{trial_column+1});      
    behavioral_data(row,2) = str2double(aline_split{choice_column+1});      
    behavioral_data(row,3) = str2double(aline_split{rt_column+1});         
    behavioral_data(row,4) = str2double(aline_split{accuracy_column+1});   
    
    % Note that we didn't initialize the size of the variable 
    % "behavioral_data" so matlab gives a warning.
    % If the variable is relatively small, it doesn't matter.
    % If the variable is large, however, it's best to initialize 
    % it to something really big, and then cut it down to size afterwards.
    
    % increment matrix row
    row = row+1;
end

% don't forget to close the file after you finish it
fclose(fid); 

%% advanced writing out data

fid = fopen('data_output4spreadsheet.txt','w');

% we want the first row to be variable labels, then rows of mixed string-number data

% variable labels
variable_labels = {'name';'trial';'choice';'rt';'accuracy'};

% let's add subject names
subject_names = {'alice';'bob'};

% write out header row
for i_variable=1:length(variable_labels)
    fprintf(fid,'%s\t',variable_labels{i_variable});
    % the %s is for string
end

% insert a new-line character
fprintf(fid,'\n');

for i_row=1:size(behavioral_data,1)
    
    % print subject name
    fprintf(fid,'%s\t',subject_names{i_row});
    
    % now loop through columns (variables)
    for i_col=1:size(behavioral_data,2)
        fprintf(fid,'%g\t',behavioral_data(i_row,i_col));
    end
    
    % new line 
    fprintf(fid,'\n'); 
    
    % Note that if you omit the first argument to fprintf, it puts the output
    % in the command instead of the text file, as in the final line of this for-loop.
    fprintf('Finished writing line %g of %g\n',i_row,size(behavioral_data,1));
end

fclose(fid);

