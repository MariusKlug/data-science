%% Data Science for Human Factors course - script 13
% Advanced Functions and Debugging
%
% This script is free to use and distribute for anybody!
%
% Author: Marius Klug, 2020, bpn.tu-berlin.de
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% blinkextract

% this is a function to extract blinks from a pupil size dataset. 

%%
load eye_pupil_data
figure(1); clf;
ax1 = subplot(311)
plot(eye_pupil_data)

%%
[newPR,bl] = blinkextract(eye_pupil_data,2);
%%
ax2 = subplot(312)
plot(newPR)
linkaxes([ax1,ax2])

%% -> seems better, but not good. let's have a close look

xlim([348734      384218])

%% add blinks
subplot(311)

hold on
plot(bl*5, 'r')

subplot(312)
hold on
plot(bl*5, 'r')

% let's check out the function!

% there is a hidden function inside that got cheated to have access to some
% of the variables that are in the workspace of the higher function. this
% makes the entire code very obscure and difficult to read and understand.

% it's a prime example of bad variable naming, why global 
% variables are bad, and why badly thought through theory leads to buggy
% code. so let's fix it!

% for a start -> blinks are interpolated linearly inside the function which
% seems to be problematic

%% clean blinks ourselves
cleaned_pupil_data = cleanPDwithblinks(eye_pupil_data, bl);

ax3 = subplot(313)
plot(cleaned_pupil_data)

linkaxes([ax1 ax2 ax3])

% that's much better but there are still many misses.
% -> standard deviation is a bad thing to use if there are so many 0
% outliers! 

std(eye_pupil_data)
mean(eye_pupil_data)


mean(eye_pupil_data) - 2*std(eye_pupil_data)

%% solution: replace low values with NaN, omit nans in computations
eye_pupil_data_NaN = eye_pupil_data;
eye_pupil_data_NaN(eye_pupil_data_NaN < 1) = NaN;

nanstd(eye_pupil_data_NaN)
nanmean(eye_pupil_data_NaN)

% much better! but now 2 SDs are not enough

%%

[newPR,bl] = blinkextract(eye_pupil_data_NaN,3);

% this seems to get stuck in the while loop, add counter to go sure

size(eye_pupil_data_NaN)

% this is where we get stuck
xlim([1375500 1375580])

% just one sample or even fewer seem to be not blinks

% inspect this error exactly
[newPR,bl] = blinkextract(eye_pupil_data_NaN(1375500:1375580),3);

% hmm, no infinite loop, what happenes? 
nanmean(eye_pupil_data_NaN(1375500:1375580))
nanstd(eye_pupil_data_NaN(1375500:1375580))

% start a bit earlier to get good values for mean and std
[newPR,bl] = blinkextract(eye_pupil_data_NaN(1375400:1375580),3);

% infinite loop. but more samples than before?!
xlim([1375400 1375580])
nanmean(eye_pupil_data_NaN(1375400:1375580))
nanstd(eye_pupil_data_NaN(1375400:1375580))

% check the findpeaks part with the debugger
figure; plot(PR)
figure; plot(abs(diblink))

%% EXERCISE
% Apparently the added NaN values destroy the searching, so we make this a
% feature of the function itself instead of doing it manually before. Take
% in regular values, replace low values with NaN, compute mean and std and
% the following threshold, then use that threshold later in the function on
% the full data.

[newPR,bl] = blinkextract(eye_pupil_data,3);

%% plot 
figure(2); clf;
ax1 = subplot(211)
plot(eye_pupil_data)
hold on
plot(bl*5, 'r')

cleaned_pupil_data = cleanPDwithblinks(eye_pupil_data, bl);

ax2 = subplot(212)
plot(cleaned_pupil_data)

linkaxes([ax1 ax2])

%% better! but still, there are some strange misses

xlim([722729      723400])

% the issue arises because the fine grained analysis right boundary is not
% well defined.
% the algorithm searches in a specific search window around samples that
% are lower than the threshold
% inside the fine grained search it uses findpeaks to determine start and
% end of blinks
% then the algorithm just jumps 20 samples ahead, which also includes the
% risk of missing the next blink onset

%% remove +20 and try again

[newPR,bl] = blinkextract(eye_pupil_data,3);

%% plot 
figure(3); clf;
ax1 = subplot(211)
plot(eye_pupil_data)
hold on
plot(bl*5, 'r')

cleaned_pupil_data = cleanPDwithblinks(eye_pupil_data, bl);

ax2 = subplot(212)
plot(cleaned_pupil_data)

linkaxes([ax1 ax2])

%% this seems to look quite good now!
% but if checking the details, irregularities persist, especially
% considering the onset/offset of blinks that are not exactly centered
% around the blinks
xlim([739097      739902])

% -> findpeaks finds every peak that exists, but that includes super small
% peaks
% it looks in a search window of 100 samples around the detected peaks.
% this window masks the wrong detection, because essentially the blink
% edges are the window edges.
% this window is also hard coded so it's impossible to account for
% different sampling rates when just using the function. our sampling rate
% was 250Hz...

% check the peaks with debugger
[newPR,bl] = blinkextract(eye_pupil_data(739097:739902),3);

figure; plot(PR)

figure; plot(abs(diblink))
hold on
scatter(locs,pks)

% this system has room for improvement...
% what we really need is to find the strong peaks, not every peak. so we
% can ignore peaks that occur at low velocities (low abs(diblink))
% we should then change the way the search buffer works, and also have a
% different buffer to apply around the fine grained peaks. this will take a
% while...

%% use completely debugged version

% 15 samples around the detection should be the search buffer, 10 samples
% should be the apply buffer. with a sampling rate of 250Hz this means 60ms
% and 40ms, respectively.

[newPR,bl,threshold] = blinkextract_filled(eye_pupil_data,3,15,10);

%% plot
figure(4); clf;
ax1 = subplot(211)
plot(eye_pupil_data)
hold on
plot(bl*5, 'r')

cleaned_pupil_data = cleanPDwithblinks(eye_pupil_data, bl);

ax2 = subplot(212)
plot(cleaned_pupil_data)

linkaxes([ax1 ax2])

%% nice :)

% also the buffer around the problem zones is working now
xlim([739097      739902])

%% Lesson learned: Only because code is published, doesn't mean it's good!

% The improved function is far from beautiful, it's merely a version I
% consider functionally fixed, many things should be changed and improved
% for clarity and readability!



%% Anonymous Functions
close all
clear

%% a simple anonymous function

% define function: 
% name = @(input) function;

% example:
myfunc = @(x) x^2;

% a different class of variable:
whos
myfunc

% a better function name:
x2fun = @(x) x^2;


% test that it works when you know the answer
x2fun(0)
x2fun(2)
x2fun(4)

% does it work on vector inputs?
x2fun(1:3)

% nope
x2fun = @(x) x.^2;

% embed directly into plot function
x = linspace(-3,3,100);
plot(x,x2fun(x),'s-')

% can also save outputs as new variable like a regular function
y = x2fun(x);

%% multiple inputs

% good function name with multiple inputs
xSquaredWithOffset = @(x,y) x.^2 + y;

% always test with known outputs first!
xSquaredWithOffset(3,0)


% 2D inputs to sample the parameter space
x = linspace(-3,3,50);
[X,Y] = meshgrid(x);

% evaluate the function for both variables
Z = xSquaredWithOffset(X,Y);

% make an image
imagesc(x,x,Z)
xlabel('X')
ylabel('Y (offset)')
title([ 'Function: ' func2str(xSquaredWithOffset) ])


% or plot
plot(x,Z)

%% EXERCISE
% The plot doesn't look right. Fix it.

plot(x,Z')

%% anonymous functions workspaces are version dependent

clear

% different input and function variables
x2fun = @(x) y.^2;

x2fun(0)

% now define the variable in the workspace
y = 3;
% still doesn't work
x2fun(0)
% define the function again, with existing parameters
x2fun = @(x) y.^2;

% works
x2fun(0)

% -> This is dangerous!

%% Input Parser
% instead of passing specific parameters to a function we can let it take a
% variable amount of inputs and parse them.

% -> new sem using an input parser

data = rand(5)
res = sem(data)
res = sem(data,2)
res = sem(data,'dim',2)
res = sem(data,3,1)
res = sem(data,'verbose',1,'dim',3)
res = sem(data,'verbose',1)

% errors
res = sem('oops')
res = sem(data,'foo')
res = sem(data,0.5)
res = sem(data,2,'bar')
res = sem(data,2,0.5)

% -> very flexible and powerful!
% error messages are not very nice though... there's another function we
% can use

validateattributes(data,{'double'},{'scalar'})
validateattributes(data,{'double','single'},{'scalar'})
validateattributes(data,{'numeric'},{})

boolValue = 1:2;
validateattributes(boolValue,{'numeric'},{'scalar','binary'})
boolValue = 0.5;
validateattributes(boolValue,{'numeric'},{'scalar','binary'})
boolValue = 1;
validateattributes(boolValue,{'numeric'},{'scalar','binary'})
boolValue = logical(1);
validateattributes(boolValue,{'numeric'},{'scalar','binary'})
validateattributes(boolValue,{'numeric','logical'},{'scalar','binary'})

% you can specify function (exemplary testfunc here) and variable names and even the variable index

boolValue = 0.5;
validateattributes(boolValue,{'numeric','logical'},{'scalar','binary'},'testfunc')
validateattributes(boolValue,{'numeric','logical'},{'scalar','binary'},'testfunc','verbose')
validateattributes(boolValue,{'numeric','logical'},{'scalar','binary'},'testfunc','verbose',2) % usually not used

%% EXERCISE: improve sem with validateattributes instead of the self-made fuctions
sem_filled(data,2,'bar')
sem_filled(data,2,0.5)

%% one last thing: expected string values
expectedBinaries = {'on','off'};

% works just like validateattributes
validatestring(0.5,expectedBinaries,'sem','verboseString')
validatestring('sdg',expectedBinaries,'sem','verboseString')
validatestring('on',expectedBinaries,'sem','verboseString')

% -> test in sem by adding another optional parameter 'verboseString'
sem_filled(data,'verbosestring',1)
sem_filled(data,'verbosestring','sdf')