% a) 1.25P
%
% extract_climate_data extracts climate data and metadata of a given filepath 
% and gives the result as structs. 
% The files must be in the format as can be found by the Deutscher Wetterdienst
% example files can be downloaded here:
% https://www.dwd.de/DE/leistungen/klimadatendeutschland/klarchivtagmonat.html
%
% ----------------
% INSERT INFORMATION HERE!!! (0.5P)
% ----------------
%
% See also: read_climate_geography_file, read_climate_produkt_file

function [climate_data, climate_metadata] = extract_climate_data(filepath)

%-----------------------
% checks (0.5P)
%-----------------------

% check if inputs are given and display the help otherwise

% insert input check

% scan for all files in the filepath

% also check that there are actually files in the filepath 
% and the list is not empty (hint: what does dir return on empty folders
% and what on wrong filepaths?)

%-----------------------
% computation (0.25P)
%-----------------------

% first extract the metadata.
% it can be found in the files containing 'Geographie' in the name,
% so find a way to find this relevant file in all files.
% it's very similar to what you've seen previously...
geography_file  = 
% the rest of the metadata is not important for us.

% the files are separated with the ';' delimiter and contain
% both numeric and string values, so we need the complex
% file reading. Inspect the file in Notepad++!

% wrap this in a function:
climate_metadata = ...
    read_climate_geography_file(fullfile(geography_file.folder, geography_file.name));

% now we need to do the same thing with the numeric data
produkt_file  = 

climate_data = ...
    read_climate_produkt_file(fullfile(produkt_file.folder, produkt_file.name));




