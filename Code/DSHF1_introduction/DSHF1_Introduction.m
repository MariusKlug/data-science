%% Data Science for Human Factors course - script 1
%
% Introduction: GUI and basic calculations
% 
% This script is free to use and distribute for anybody!
% 
% Author: Marius Klug, 2020, bpn.tu-berlin.de
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%% Basic calculations

% Type "1+1" into the command window and hit return. 
% Congratulations.
% You can also copy & paste or highlight and press F9

1+1

% +, -, *, /, and ^ are internally recognized operators

15 + 27

85 - 43

14*3

59850/1425

3^3

% which you can also combine obviously
% the order of operations is ^ -> *,/ -> +,-

2*5^2 - 8

% code readability greatly improves with the usage of spaces:

5+6^2*4/5+2

5 + 6^2 * 4/5 + 2

%  and can be changed using parentheses

3^4 + 3/2

(3^4 + 3) / 2

3^4/2 + 1.5

3^(4/2) + 1.5

% of course parentheses can help for readability too

5+6^2*4/5+123/15

5 + (6^2)*(4/5) + (123/15)

% type clc into the command window to clear it

%% EXERCISE
% You win the lottery and invest the one million euros
% with an interest rate of 3%. What will it be worth when 
% Donald Trump finishes his second term on 20th Jan 2025?


%% The colon operator  (:)

% creates a series of numbers 

1:10

10:12

-3:3

% the default skip value is 1, but you can overrride it

1:2:11

0:0.1:1

% what happens here?

10:1 

% so how can we make this run?

10:-1:1

% important: The numbers stay within these boundaries

1:5:10

1:5:11

%% Variables 
% variables are used to store the data in your workspace

% the default variable is "ans"
ans

% assign a variable and use it in calculations
x = 1
y = x + x

% suppress output with a semicolon (;)

a = 3;
b = 5;

c = a*b
d = a^b

c
c;

%% EXERCISE
% Create four variables that are not 0, 1, 10, or 100 
% and combine them mathematically to equal 100. 
% Use all five basic operators. 


%% Inspect present variables

whos

% clear single variables

clear x
whos

% use regular expressions to clear

clear a*
whos

% clear the entire workspace
clear
whos