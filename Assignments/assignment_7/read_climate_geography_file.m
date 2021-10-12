% b) 1.75P
%
% read_climate_geography_file reads in a climate geography metatada file
% and stores station ID, name, latitude, and longitude in a struct.
% The file must be in the format as can be found by the Deutscher Wetterdienst
% example files can be downloaded here:
% https://www.dwd.de/DE/leistungen/klimadatendeutschland/klarchivtagmonat.html
%
% ----------------
% INSERT INFORMATION HERE!!! (0.25P)
% ----------------
%
% See also: extract_climate_data

function climate_metadata = read_climate_geography_file(filepath)

%-----------------------
% checks (0.5P)
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
% relevant values for us, then search the next line for 
% the content and store it in a struct to return.
%
% relevant info is:
% name, ID, latitude, and longitude
% these should also be the fields in your struct!
%-----------------------

% initialize target columns with 0
id_col = 0;
name_col = 0;
lat_col = 0;
long_col = 0;

% loop through the file until end of file is reached
while ~feof(fid) 
    
    % read a line ("file get line")
    
    % split the line with the right delimiter
    
    % check if the line contains a name, id, latitude, and longitude
    % the information is in german so you need to check it and see
    % how they wrote it exactly. it's okay to hard code here 
    % because this function is specific for this kind of file.
    if any(strcmpi('Stationsname',aline_split)) && ...
            % this statement is incomplete.
            % repeat with the other relevant columns!
        
        % find the column which contains the name
        
        % find the column which contains the id
        
        % find the column which contains the latitude
        
        % find the column which contains the longitude
       
    else
        % check if all columns are not 0
        % -> that means we know where to look and can store the information
        
        % this overwrites all the time, such that only the last line is
        % stored in the end. that's not exactly perfect, but given the
        % structure of the file, the relevant values do not change
        % appreciatively, so it is fine. check the file if you want to see
        % for yourself!
        if all([id_col name_col lat_col long_col])
            
            % store the result information, convert to numbers where applicable
            % Hint: strtrim removes leading and trailing whitespaces
            % strtrim is not necessary before str2num
            climate_metadata.ID             = 
            climate_metadata.name           = 
            climate_metadata.latitude       = 
            climate_metadata.longitude      = 
            
        end
        
    end
end

% don't forget to close the file after you finish it

% check if your loop has actually found a result 
% this means that the climate_metadata variable must exist.
% throw an error otherwise