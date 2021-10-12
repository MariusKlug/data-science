%% Data Science for Human Factors course - script 4
% Functions
%
% This script is free to use and distribute for anybody!
%
% Author: Marius Klug, 2019, bpn.tu-berlin.de
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% FUNCTIONS
% viewing functions

% most functions are also viewable, e.g.
edit linspace

% some are compiled
edit sum

% and of course the internet...

%% Finding basic statistical values of a given dataset

sigma = 2;
mu = 5;
n_randvec = 100;

randvec1 = normrnd(mu, sigma, n_randvec, 1);

randvec_mean = mean(randvec1)
randvec_std = std(randvec1)

% let's build our first function:
which sem
addpath(genpath(pwd))

randvec_sem = sem(randvec1)

% have a second to test
randvec2 = normrnd(mu, sigma, n_randvec, 1);
randvec2_mean = mean(randvec2)
randvec2_std = std(randvec2)
randvec2_sem = sem(randvec2)

% that was copy and waste, we should not do that, 
% so let's wrap it in a function:
which basicstats

clear MEANs SDs SEMs
[MEANs, SDs, SEMs] = basicstats(randvec1)
[MEANs(2), SDs(2), SEMs(2)] = basicstats(randvec2)


%% This actually has not resolved our problem
% just wrapped 3 lines into 1 and we still 
% copy and waste a line, so we need to make a loop.
% with this loop we can test whether our sem computation 
% actually estimates the SD of the means.

sigma = 2;
mu = 5;
n_randvec = 100;
n_repetitions = 100000;
randvecs = zeros(n_repetitions,n_randvec);

for i_randvec = 1:n_repetitions
    randvecs(i_randvec,:) = normrnd(mu, sigma, n_randvec, 1);
    
    [MEANs(i_randvec), SDs(i_randvec), SEMs(i_randvec)] =...
        basicstats(randvecs(i_randvec,:));
end

% output with fprint is a bit more powerful than disp
% %d entries are being replaced by the following double values,
% adding .2 in between rounds it to two digits after the comma.
% note the \n in the end to indicate a linebreak.
fprintf(...
	'The mean of means is %.2d and the mean of SDs is %.2d.\n',...
    mean(MEANs),mean(SDs))

% mean of SEMS should be same as SD of means
fprintf(...
	'The mean of SEMs is %.2d and the SD of the means is %.2d.\n',...
    mean(SEMs),std(MEANs))

% What's inefficient in this script? 

%% EXERCISE
% The function "basicstats" recreates this functionality without a loop.
% Improve it to let the user choose the dimension to operate on.

randmat = normrnd(mu, sigma, n_randvec, n_repetitions);
dim = 2;
[MEANs2, SDs2, SEMs2] = basicstats_filled(randmat,dim);

fprintf(...
	'The mean of means is %.2d and the mean of SDs is %.2d.\n',...
    mean(MEANs2),mean(SDs2))

fprintf(...
	'The mean of SEMs is %.2d and the SD of the means is %.2d.\n',...
    mean(SEMs2),std(MEANs2))

%% Fun with strings

% let's pretend we have events in our experiment which 
% carry some information in this kind of key:value pairs

event_text =...
	'play_sound:Hit,type:Target,block:slow narrow,speed:4.999292';

% we want to parse them to get a struct

% create a key:value parsing function
which parse_event

event_info = parse_event(event_text)

% nice. now these are actual events in my own experiment
% as a real life example:

load EEG_events

hit_event = EEG_events(5002).type
event_info = parse_event(hit_event)

% Index exceeds matrix dimensions.
% -> The events have flawed structure that needs to be accounted for

% Invalid field name.
% -> Same. No special characters are allowed

[N modified] = matlab.lang.makeValidName('1.0')
[N modified] = matlab.lang.makeValidName('test')

event_info = parse_event_filled(hit_event)
verbose = true;
event_info = parse_event_filled(hit_event,verbose)

%% Count hits/misses/FAs

% parse all events
event_structs = cell(1,length(EEG_events));
for i_event = 1:length(EEG_events)
    if mod(i_event,100)==0; disp(i_event); end
    
    event_structs{i_event} =...
		parse_event_filled(EEG_events(i_event).type,false);
    
end

% count
[hits, misses, false_alarms] = deal(0);
idxnewgazed = [];
for i_event = 1:length(event_structs)
    
    if isfield(event_structs{i_event},'play_sound')
        switch event_structs{i_event}.play_sound
            case 'Hit'
                hits = hits+1;
            case 'Miss'
                misses = misses+1;
            case 'FalseAlarm'
                false_alarms = false_alarms + 1;
            otherwise
                warning(['Sound not recognized: '...
					event_structs{i_event}.play_sound])
        end % end switch play_sound
    elseif isfield(event_structs{i_event},'value')
        idxnewgazed = [idxnewgazed i_event];
    else
        event_structs{i_event}
    end % end if isfield play_sound    
end

hits
misses
false_alarms
