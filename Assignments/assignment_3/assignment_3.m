% Assignment 3 for the class Data Science for Human Factors:
% Control statements and loops
% 
% Team: 

scores = 0;

%% 1) (0.75P)

% a) This code is awful in many ways. Count the problems and fix them. (0.35P)
for i=1:6;i=3;multiplied(i)=i*43;end

% Problems: 


% b) Rewrite the complete following code to get the same result without a
% loop in one single command instruction (no ";" or ","). In general, you
% should always see whether it's possible to avoid loops and use efficient
% matrix computation when programming in MATLAB. (0.4P)

nums = round(logspace(1,3,15));
numlogs = zeros(size(nums));
for numi=1:length(nums)
numlogs(numi) = log(nums(numi));
end


%%
scores(1) = 0

%% 2) (1.25P)
% The following line waits for a user input and saves it in a variable:
number = input('Enter number greater than zero: '); 

% a) The "task" variable is a text containing the task of b).
% Convert the following task to one line of readable character array text. (0.75P)
% Hint: Look for resources to Convert from Numeric Values to Character Array 
load task


% b) Use a while loop to repeat the input question until the number is actually greater. (0.5P)


%%
scores(2) = 0

%% 3) (2.5P)
% a) Create a 25-element vector of normally distributed random numbers. 
% Test whether each element is greater than 1 and print 
% out the result. (1P)
% The display output should be, for example:
% 
% ...
% The 3rd element is -2.435 and is not greater than 1.
% ...
% The 15th element is 1.581 and is greater than 1.
% ...
% 
% b) Make sure your code has exceptions to print 1st, 12th, 23rd, etc. 
% instead of 1th, 12nd, 23th, etc. (1.5P)
% 
% You can make everything in one go, I will check whether or not b) is
% correct! You can assume that no vector with more than two digits will be
% used. Hints: take a detour over strings to check for the last digit.
% any/all can make it easier

n = 25;


%%
scores(3) = 0

%%
final_score = sum(scores)

