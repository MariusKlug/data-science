% c) 1.5P
% 
% read_climate_produkt_file reads in a climate geography produkt file
% and stores the data values for date, air pressure, aur temperature,
% and precipitation in a struct.
% The file must be in the format as can be found by the Deutscher Wetterdienst
% example files can be downloaded here:
%
% https://www.dwd.de/DE/leistungen/klimadatendeutschland/klarchivtagmonat.html
% 
% an explanation of the used abbreviations can be found here:
% 
% https://www.dwd.de/DE/leistungen/klimadatendeutschland/beschreibung_tagesmonatswerte.html?nn=16102&lsbId=526270
%
% ----------------
% INSERT INFORMATION HERE!!! (0.25P)
% ----------------
%
% See also: extract_climate_data

function climate_data = read_climate_produkt_file(filepath)

%-----------------------
% checks (0.25P)
%-----------------------

% we need a check to display the help and if the filepath is correct

% open file

% check if a file was actually found.
% HINT: what does fopen return when no file is found?

%-----------------------
% computation (1P)
%
% we want to loop through each line in the file.
% first we need to find out which columns contain the 
% relevant values for us, then search all following
% lines for the respective content and store this content 
% in a struct array.
%
% relevant info is:
% date, pressure, temperature, and precipitation
% these should also be the fields in your struct!
%-----------------------

% initalize empty cell array
file_data = cell(1,0);

% initalite target columns with 0
date_col = 0;
pressure_col = 0;
temperature_col = 0;
precipitation_col = 0;

% since we know the structure of this file we can for performance 
% reasons already take the info of the first line
% -> no need to test this for each line
aline = fgetl(fid); 
aline_split = strsplit(aline,';');

% find the column which contains the name
% change the following lines to be better prepared for leading 
% whitespaces. make sure it works without them (e.g. it should
% work with 'PM' instead with '  PM')
date_col            = find(strcmpi('MESS_DATUM',aline_split));
pressure_col        = find(strcmpi('  PM',aline_split));
temperature_col     = find(strcmpi(' TMK',aline_split));
precipitation_col   = find(strcmpi(' RSK',aline_split));

% we need a row here, because we store information of many rows
% in a struct array and need to know which index we are at for
% each iteration in the while loop
struct_counter = 1;

% loop through the file until end of file is reached
while ~feof(fid) 
    
    % read a line ("file get line")
    
    % split the line with the right delimiter
    
    % store the result information in the struct
    climate_data(struct_counter).date                = 
    climate_data(struct_counter).pressure            = 
    climate_data(struct_counter).temperature         = 
    climate_data(struct_counter).precipitation       = 
 
    % don't forget to increment the index
end

% don't forget to close the file after you finish it

% check if your loop has actually found a result 
% this means that the climate_data variable must exist.
% throw an error otherwise