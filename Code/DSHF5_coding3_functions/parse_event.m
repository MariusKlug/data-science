% parse_event() - Parses an experiment event string into a struct.
% The event string must have the structure of 'key:value,key:value',
% the struct will have the fields 'key' with the assigned values.
%
% Input:
%   event_text      - character array input with key:value,key:value pairs
%
% Output:
%   event_info		- struct with the parsed event info as key.value pairs
%
% Example usage:
% event_text = 'play_sound:Hit,type:Target,block:slow narrow,speed:4.999292,angle:29';
% event_info = parse_event(event_text)
%
% Author: Marius Klug, bpn.tu-berlin.de, 2019
%   This function is free for any kind of distribution and usage!

function event_info = parse_event(event_text,verbose)

if ~ischar(event_text)
	error('Event text input must be a character array.')
end

% split into pairs
pairs = strsplit(event_text,',');

% in case nothing is there, just give an empty output
event_info = [];

for i_pair = 1:length(pairs)
	
	% split pairs
	key_value = strsplit(pairs{i_pair},':');
	key = key_value{1};
	value = key_value{2};
	
	% assign the resulting struct
	event_info.(key) = value;
	
end
