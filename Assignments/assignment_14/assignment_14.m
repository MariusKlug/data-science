% Assignment 13 for the class Data Science for Human Factors:
% 
% Advanced Functions and Debugging
%
% Team:

scores = 0;

%% 1) 1P
% Create an anonymous function f(x,y) = 2x - sqrt(x)y^2 and use it to plot
% figure 1. 
% a) 0.25P
% Create the anonymous function and test with values x = 4, and y = 2. What
% should this give as output?
% b) 0.5P 
% Augment it to use matrices as inputs. Create appropriate X and Y matrices
% using one command taking x and y in. Pass these matrices to the function
% and plot the results as contours with 20 lines. Make sure x and y axes
% are correct. Use no loops! 
% c) 0.25P
% Make sure to have an appropriate mathematical title for the figure as you
% can see in fig 1.

%%

x = 0:0.01:5;
y = -3:0.01:3;

%%

%%
scores(1) = 0

%% 2) 2.25P 
% Blinkextract:
% The blinkextract version you saw in class was not a good final version.
% a) 1.5P
% Rewrite the hidden function such that it does not use variables of the
% outer function but the code functionality remains intact. Use the
% eye_pupil_data to test and make sure that the same blinks are being found.
% b) 0.75P
% Replace the present linear interpolation of blinkextract such that the final
% cleaned data is identical to the cleaned data we obtained in class using
% our own "cleanPDwithblinks" function.

% Implement your changes in a new blinkextract version "blinkextract_2".
% You don't have to update the help function this time.

%%
load all_eye_pupil_data

%% Test: a) and b)
[newPR,bl,threshold] = blinkextract_2(eye_pupil_data_raw,3,15,10);

try
    assert(all(bl==blinks_for_test))
catch
    figure;
    plot(bl)
    hold on
    plot(blinks_for_test)
    figure;plot(bl-blinks_for_test)
end
assert(all(newPR==cleaned_for_test))

%%
scores(2) = 0

%% 3) 1.25P
% Inputparser:
% a) 0.75P
% Replace the current way of parameter passing for blinkextract using
% the input parser. Make "n" optional with a default of 3, and
% "applybuffer" optional with a default of round(2/3 * searchbuffer). "PR"
% and "searchbuffer" are required. 
% Hint: You have to assign the "applybuffer" default after the parsing.
% b) 0.5P 
% Choose useful variable checks in your parser using "validateattributes"
% including correct specific function and variable names.

% Implement your changes in a new blinkextract version "blinkextract_3".
% You don't have to update the help function this time.

%% Test
[newPR,bl,threshold] = blinkextract_3(eye_pupil_data_raw,15);
assert(all(bl==blinks_for_test))
assert(all(newPR==cleaned_for_test))

blinkextract_3('eye_pupil_data_raw',15);
blinkextract_3(eye_pupil_data_raw,15.1);
blinkextract_3(eye_pupil_data_raw,'foo');
blinkextract_3(eye_pupil_data_raw,0);
blinkextract_3(eye_pupil_data_raw,15,0);
blinkextract_3(eye_pupil_data_raw,15,'three');
blinkextract_3(eye_pupil_data_raw,15,3,10.1);
blinkextract_3(eye_pupil_data_raw,15,3,'bar');


%%
scores(3) = 0

%%
final_score = sum(scores)
