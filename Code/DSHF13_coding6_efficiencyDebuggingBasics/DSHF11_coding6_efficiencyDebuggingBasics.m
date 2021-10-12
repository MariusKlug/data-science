%% Data Science for Human Factors course - script 11
% Efficiency and Debugging
%
% This script is free to use and distribute for anybody!
%
% Author: Marius Klug, 2019, bpn.tu-berlin.de
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Code runtime with tic/toc

tic
B = rand(10000);
t(1) = toc;
% t is given in seconds

tic
C = ones(10000);
t(2) = toc;

tic
D = zeros(10000);
t(3) = toc;

figure(1); clf
bar(t)

% you can also use tic/toc to display an
% ETE for your large computations!

%% The profiler

profile on
runtime
profile viewer;

%% EXERCISE
% use the profiler to optimize this code. play around with
% the profiler and tic/toc using different matlab and own
% functions!

profile on
runtime2
profile viewer;

%% Live Debugging of traps I layed to myself some years ago

folder_to_scan = fullfile(pwd,'debugging');
all_files = dir(folder_to_scan);

historic_data = all_files(~cellfun(@isempty,...
    regexp({all_files.name},'klarchiv.*his')));
current_data = all_files(~cellfun(@isempty,...
    regexp({all_files.name},'klarchiv.*akt')));

all_climate_data = cell(length(historic_data),1);
all_climate_metadata = cell(length(historic_data),1);

for i_file = 1:length(historic_data)
    
    fprintf('File #%d\n',i_file)
    
    complete_path = fullfile(folder_to_scan,historic_data(i_file).name);
        
    [all_climate_data{i_file}, all_climate_metadata{i_file}] =...
        extract_climate_data(complete_path);
    
end

%% EXERCISE
% Go back through your own code and try to debug the parts
% that you might not have understood back then, using the
% tools you now know. 


%% TRY-CATCH
% used to ignore errors but collect information about the error 

vec = [2 3 4];

for index_attempt = 5:-1:1
    vec(index_attempt)
end

%% catch the error
for index_attempt = 5:-1:1
    disp(['Index attempt: ' num2str(index_attempt)])
    try
        vec(index_attempt)
    catch ME
        warning(ME.message)
    end
end

%% execute other code and rethrow the error
for index_attempt = 5:-1:1
    disp(['Attempt: ' num2str(index_attempt)])
    try
        vec(index_attempt)
        
        % ME is just a convention, you can also rename the variable
        % but it's better to stick to the convention...
    catch you
        warning(you.message)
        vec = [];
        throw(you)
    end
end

%% Hidden bug

% just some loop with i as looping index
n = 4;
d = zeros(n,1);
for i=1:n
    d(i) = i^2 - log(i);
end

% create complex sine wave
fs = 1000;
t  = -2:1/fs:2;
s1 = exp(2*i*pi*t);


figure(1), clf
subplot(211)
plot(t,real(s1),'linew',3)
xlabel('Time (s)'), ylabel('Amplitude')
title('First try (wrong!)')

%% EXERCISE: What's wrong here? Correct it!

fs = 1000;
t  = -2:1/fs:2;
s1 = exp(2*1i*pi*t);

subplot(212)
plot(t,real(s1),'linew',3)
xlabel('Time (s)'), ylabel('Amplitude')
title('Second try with 1i')
