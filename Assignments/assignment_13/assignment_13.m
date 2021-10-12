% Assignment 10 for the class Data Science for Human Factors:
% 
% Efficiency and debugging
%
% Team:

scores = 0;

%% 1) 0.3P
% Parentheses are sometimes aesthetic and sometimes not. The three lines of code below produce
% different results simply because the parentheses are in difference positions.
% Explain what is happening in what order, to get the different results.

0:.1:(2>1)

(0:.1:2)>1

(0:.1):2>1

%%
scores(1) = 0

%% 2) 1.5P
% Each line produces an error. First, try to figure out 
% what the error is. Next, run the code in MATLAB and 
% inspect the error message. Finally, fix the error and think
% about how that error message might help you debug in the future.

asdf = linspace(-30:30);
celery = cell(10,1); celery(:) = deal('asdf42')
[m1,m2] = mean([randn(1,10) zeros(5,1)']);
asdf=zeros(3,4); asdF(3,2)
for i=1:3 tmp(i)=i end
bsxfun(@times,randn(5,2),linspace(1,5,4)')
cat(1,zeros(10,2),ones(10,3))
dsearchn(linspace(-10,10,100)',[3 4])
plot(1:10,(1:10).^2,log(1:10))
r=1:10; r(rand)
[randn(1,10) zeros(5,1)]
std(randn(1000,1),2)
imagesc(randn(5,3,2))
q(:,1) = bsxfun(@times,randn(5,2),linspace(1,5,2));
a=rand; clear; c=a;
e = reshape(randn(5,3,4),2,3);
bsxfun(@times,randn(5,2),linspace(1,5,5))
r=1:10; r(round(rand))
for i=-3:3, tmp(i)=i; end
plot(1:5,5:1)

% comment: in many cases it's almost impossible to guess
% what the original intent was. this exercise is more 
% about reading and understanding the error message than
% finding an actual solution to a bug. usually the context
% gives away much more info about the intent...

%%
scores(2) = 0

%% 3) 1.5P
%% a) 1P
% Examine the efficiency of pre-allocation and built-in matrix/vector operations
% in comparison to using loops and no pre-allocation. For this, measure the
% runtime of the calculation of mean, std, and z-scoring for a random
% matrix three times: 

% 1) As a simple built-in matrix/vector multiplication
% 2) in a loop using preallocated result variables, iterating over n, but
% not increasing the size of the result variables each iteration
% 3) in a loop without preallocation

% Plot the nine values in a bar plot. Don't create new random matrices each
% iteration but use the one that is created here.


mu = 2;
SD = 3;
m = 1000;
n = 100000;
random_matrix = randn(m,n)*SD + mu;

means = mean(random_matrix);
SDs = std(random_matrix);
zscored = (random_matrix - means) ./ SDs;

%%


%% b) 0.3P
% Why is the difference with and without preallocation much more prominent
% in the z-scoring than the mean and SD computations?


%% c) 0.2P
% Is a bar plot appropriate here? Why/why not? What could be done to
% improve the analysis that would require a different plot type?


%%
scores(3) = 0

%% 4) 1.2P
% Use the debugger to debug errorarea(). Comment all bugs you found!
% 6 bugs have been inserted. The plot should look like this:

% openfig('errorarea_fig')

figure(2); clf; set(gcf,'color','w')

load data
data_Y = mean(data,3);
data_X = repmat(5:0.5:12,6,1)';
errors = std(data,0,3)/size(data,3);

[linehandles, areahandles] = errorarea(data_X, data_Y, errors);


%%
scores(4) = 0

%%
final_score = sum(scores)
