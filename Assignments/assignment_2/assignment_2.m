% Assignment 2 for the class Data Science for Human Factors:
% Scripts, style, and variable classes
% 
% Write the code in the sections below and, if necessary, your final answer
% as a comment.

% The filename should be assignment_2_team_<x>

% Team: 

scores = 0;

%% 1) (2P)
n = 5;
m = 10;
randmat = randn(m,n);

colmin = min(randmat,[],1)
rowmin = min(randmat,[],2)
totalmax = max(randmat(:))

% a) Create code that finds the minimum of each row and of each column 
% of your random matrix using using the sort() function instead of max/min. (0.5P)


% b) Find the closest value to zero of the entire matrix. 
% Remember that negative values can be close to zero, too... 
% (1P)


% c) Put the scripts of b) in one line of code, as in one command, without
% using the ";" or "," separators. (0.5P)

%%
scores(1) = 2

%% 2) (1.75P)
% Create a random rowvector of 100 only one-digit whole numbers in the [-9 9] 
% interval, find the amount of positive even numbers in the random matrix 
% using the mod() function. 


%%
scores(2) = 1.75

%% 3) (0.75P)
% Find and fix the errors on the following lines of code. 

zeromat = ones(10, int8);


name = [ 'My name ' 4 ' today is ' "Mudd" ];


asdf = [1:.2:4 3:-2/3:-1]; asdf(.2)


%%
scores(3) = 0.75

%%

final_score = sum(scores)

