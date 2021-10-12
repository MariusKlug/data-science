% Assignment 14 for the class Data Science for Human Factors:
% 
% Supervised Learning and Classification
%
% Team:

scores = 0;

%% 1) 1P
% We use the previously created test dataset with 3 gaussian
% clusters in 3D to investigate LDA in 3D.
% a) 0.75P
% Train LDA weights on the training dataset.
% Create a test dataset with n=10 datapoints per cluster,
% predict the class of each point using LDA, visualize each
% point in the previous plot (hold on), using the correct
% color also for the markerface. Repeating the segment
% should create, classify, and plot another test dataset
% into the previous plot.
% b) 0.25P 
% Compute and plot the confusion matrix of the last test
% dataset in the second subplot, title it with the accuracy.

% The figure should look like this:

openfig('1');
close

%% our beloved example dataset

nPerClust_training = 50;
all_sigmas = 4;

% XYZ centroid locations
A = [  1 2  0 ];
B = [ -5 1 -2 ];
C = [  3 5  5 ];

% generate data
a = bsxfun(@plus,randn(nPerClust_training,3)*all_sigmas,A);
b = bsxfun(@plus,randn(nPerClust_training,3)*all_sigmas,B);
c = bsxfun(@plus,randn(nPerClust_training,3)*all_sigmas,C);

% concatenate into a list
training_data = [a; b; c];

% ground truth of the training data
ground_truth_training_data = [repmat(1,nPerClust_training,1);...
    repmat(2,nPerClust_training,1); repmat(3,nPerClust_training,1)];

% show the data
figure(1);clf
subplot(121)
lineColors = [0,0.75,0.75;0.75,0,0.75;0.75,0.75,0];

hold on

% now draw the raw data in different colors
for i=1:length(unique(ground_truth_training_data))
    
    % data points
    plot3(training_data(ground_truth_training_data==i,1),...
        training_data(ground_truth_training_data==i,2),...
        training_data(ground_truth_training_data==i,3),'o','color',...
        [ lineColors(i,:)],'markerface','w')
    
end

title({['Raw Data with Labels']})

legend({'Class 1','Class 2','Class 3'})

axis square, grid on
view([50.0000 21.2000])
set(gcf,'position',[358 726 1104 494])
rotate3d on

%% a) 


%% b)


%%
scores(1) = 0

%% 2) 2.25P
% a) 1.5P
% We want to investigate the variability of the test
% error in dependency of the number of test samples. Create
% a loop that generates new test samples with Ns ranging
% from 1 to 500 in steps of 10, repetitively 1000 times per
% n, and then computes the accuracy and stores it in a
% matrix. Compute mean accuracy (in %) and std for each n,
% and use errorarea to plot it. Be sure to have appropriate 
% xticks, axis labels and a title.
% b) 0.75P
% Instead of classifying with LDA, use knnsearch. Classify
% the last test sample (n=500 per class) using knnsearch
% with varying k (1:1:150) in a loop, plot the resulting
% accuracies. Use the mode of the training data class of the 
% k nearest neighbors as classification. Appropriate figure 
% descriptions, bla, you should know it by now ;)

% The figure should look like this:

openfig('2');
close

%% a)
figure(2);clf;set(gcf,'position',[349 745 892 568])
subplot(211)

%% b)
subplot(212)

%%
scores(2) = 0

%% 3) 1.25P
% Fisher's iris dataset again. Use t-SNE to visualize the
% dataset in 2D t-SNE space three times. Once color coded
% with the actual classes, once with the classes classified
% by LDA in full 4D space, and once with the classes
% classified by LDA in the t-SNE 2D space. Compute the
% accuracies of the two classifications and show it in the
% title.

% The figure should look like this:

openfig('3');
close

%%
load fisheriris
figure(3); clf; set(gcf,'position',[8 853 1798 492])
subplot(131);

%%
scores(3) = 0

%%
final_score = sum(scores)
