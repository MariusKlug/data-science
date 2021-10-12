% Assignment 4 for the class Data Science for Human Factors:
% Functions
%
% Team:

scores = 0;

%% 1) 1.5P

% a) 0.75P
% Make a function compare_SEMs that does compare basicstats as in the script.
% The function should take inputs n_randvec, 
% n_repetitions, mu, and sigma, and and give the
% random matrix, MEANs, SDs, and SEMs vectors as output, 
% and display mean of SEMS and SD of means. 

[randmat, MEANs, SDs, SEMs] = compare_SEMs(100, 100000, 5, 2);

% The mean of means is 5.00e+00 and the mean of SDs is 2.00e+00.
% The mean of SEMs is 2.00e-01 and the SD of the means is 1.99e-01.

% b) 0.75P
% Make sure to have proper help text and input checks. 

compare_SEMs
compare_SEMs('hundred');
compare_SEMs(-100);
compare_SEMs(100.5);
compare_SEMs(100);
compare_SEMs(100, 'hundredthousand');
compare_SEMs(100, -100000);
compare_SEMs(100, 100000.5);
compare_SEMs(100, 100000);
compare_SEMs(100, 100000, 'zero');
compare_SEMs(100, 100000, [0 2]);
compare_SEMs(100, 100000, 5);
compare_SEMs(100, 100000, 5, 'two');
compare_SEMs(100, 100000, 5, 0);
compare_SEMs(100, 100000, 5, -10);
compare_SEMs(100, 100000, 5, [1 2]);
compare_SEMs(100, 100000, 5, 2);

%%
scores(1) = 0

%% 2) 1.25P

% Augment exercise 3) in assignment 3 with the following:

% a) 0.75P
% Make additional exceptions for 11, 12, 13 by checking for the last 2 digits. 
% Test by using a 1025-element vector. 

n = 125;

%% b) 0.5P
% Wrap the script into a function with meaningful help, an input for 
% the length, mu, and sigma, input checks, 
% and the created random vector as an output. 
% Make sure to have proper help text and input checks!

randvec = test_greater_than_one(125, 0.5, 3);

%%
scores(2) = 0

%% 3) 0.5P

% The median is the center of a distribution. Write a function my_median
% to compute the median of a vector of input numbers. To find the median, 
% you need to sort the data and then take the middle value.
% If there is an even number of elements, then you take the average of the two middle values. 
% How does the output of your function compare to the MATLAB median function? 
% Make sure to have proper help text and input checks!

randvec = randn(100,1);

% assert is a nice way to make sure that your code runs as expected. 
% essentially it wraps an if-else statement with an error in the 
% else part into one function
assert(my_median(randvec) == median(randvec),'Functions are not equal for even length.') 

randvec = randn(101,1);
assert(my_median(randvec) == median(randvec),'Functions are not equal for odd length.')  

%%
scores(3) = 0

%% 4) 1.25P

% a) The experimental marker data contains informations from four different
% blocks. The block name info is available in the parsed struct. Create a
% function signalDetectionStats that takes the entire event struct array
% and the number of blocks as an input, parses all events, calculates the
% number of hits/misses/FAs for each block separately, and gives three
% vectors of hits/misses/FAs as well as a cell array of block names as an
% output. Do not give block names as an imput or hard code them inside the
% function. You don't have to create input checks here, but a proper help
% text!
%
% Hint: Use and look at the "parse_event" function of the lecture. Check
% the block entry of the event. Use strcmp, not "==".

load EEG_events

EEG_events(5).type

n_blocks = 4;
[hits, misses, FAs, block_names] = signalDetectionStats(EEG_events, n_blocks)

assert(length(hits)==4)
assert(all(hits<600&hits>0))
assert(length(misses)==4)
assert(length(FAs)==4)
assert(length(block_names)==4)

% If you want to think a bit: (no points!) The number of stimuli for the
% first two blocks were 300 targets and 300 distractors, double this for
% the third and fourth block. To compute reasonable event-related
% potentials (ERPs), I need at least 60 trials of each condition to plot
% (e.g. hits/misses/FAs for each block). Do you think the experiment can be
% used as is? Why?


%%
scores(4) = 0

%%
final_scores = sum(scores)