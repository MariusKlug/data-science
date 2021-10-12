%% Data Science for Human Factors course - script 13
% Machine Learning 3: Classification & Supervised Learning 
%
% This script is free to use and distribute for anybody!
%
% Author: Marius Klug, 2019, bpn.tu-berlin.de
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

close all; clear

% addendum to last course:
% https://jmonlong.github.io/Hippocamplus/2018/02/13/tsne-and-clustering/

%% create the 3D clusters again

nPerClust = 50;
all_sigmas = 2.5;

% XYZ centroid locations
A = [  1 2  0 ];
B = [ -5 1 -2 ];
C = [  3 5  5 ];

% generate data
a = bsxfun(@plus,randn(nPerClust,3)*all_sigmas,A);
b = bsxfun(@plus,randn(nPerClust,3)*all_sigmas,B);
c = bsxfun(@plus,randn(nPerClust,3)*all_sigmas,C);

% concatanate into a list
data = [a; b; c];

% show the data
figure(1);clf
plot3(data(:,1),data(:,2),data(:,3),'s','markerfacecolor','k')

title('Raw Data')

axis square, grid on
rotate3d on


%% cluster with k-means

k = 3;
[groupidx,cents] = kmeans(data,k);

figure(2);clf
lineColors = [0,0.75,0.75;0.75,0,0.75;0.75,0.75,0];

hold on

% now draw the raw data in different colors
for i=1:k
    
    % data points
    plot3(data(groupidx==i,1),data(groupidx==i,2),...
        data(groupidx==i,3),'o','color',[ lineColors(i,:)],...
        'markerface','w')
    
    % and now plot the centroid locations
    plot3(cents(i,1),cents(i,2),cents(i,3),'ko',...
        'markerface',lineColors(i,:),'markersize',10);
    
end


xlabel('Axis 1'), ylabel('Axis 2')
title(['Result of K-Means Clustering (k=' num2str(k) ')'])

% connecting lines for clarification
for i=1:length(data)
   
    plot3([ data(i,1) cents(groupidx(i),1) ],...
        [ data(i,2) cents(groupidx(i),2)],...
        [ data(i,3) cents(groupidx(i),3) ],...
        'color',[lineColors(groupidx(i),:)])
    
end

% finally, the "ground-truth" centers
plot3(A(1),A(2),A(3),'kp','linew',2,'markersize',20,'markerfacecolor','y')
plot3(B(1),B(2),B(3),'kp','linew',2,'markersize',20,'markerfacecolor','y')
plot3(C(1),C(2),C(3),'kp','linew',2,'markersize',20,'markerfacecolor','y')

axis square, grid on
rotate3d on

%% now we have a dataset that we learned to cluster... 
% we need a test dataset in addition. we generate a new
% (smaller) dataset and classify each data point according
% to the clusters.

nPerClust_tests = 10;

% generate test data
a_test = bsxfun(@plus,randn(nPerClust_tests,3)*all_sigmas,A);
b_test = bsxfun(@plus,randn(nPerClust_tests,3)*all_sigmas,B);
c_test = bsxfun(@plus,randn(nPerClust_tests,3)*all_sigmas,C);

% concatanate into a test list
test_data = [a_test; b_test; c_test];
ground_truth_test_data = [repmat(1,nPerClust_tests,1);...
    repmat(2,nPerClust_tests,1); repmat(3,nPerClust_tests,1)];

%% Classification

% use knnsearch on the test data.
% knnsearch searches for the k nearest data points of a new
% dataset in another one. the outcome is the respective data
% point

% use the nearest cluster centroid for classification. we
% search for the one (default) nearest neighbor in the
% centroid data set for all data points.
classification_knn_centroids = knnsearch(cents,test_data)

% note: we did this last time already by abusing the k-means
% clustering algorithm with only one iteration. sorry,
% k-means!

%% EXERCISE
% there's another way to classify: based on the nearest 
% data points and their assigned cluster. Find a way to do
% this with the five nearest neighbors.

% find the 5 nearest neighbors in the dataset
idx = knnsearch(data,test_data,'K',5);

% take the most often assigned cluster as the classification
classification_knn_data = mode(groupidx(idx),2);

%% compare

[ground_truth_test_data classification_knn_centroids...
    classification_knn_data]

% -> cluster numbers are arbitrary!

%% Supervised Learning

% by now we used classification in a strange way. we just
% had clusters and took the most often assigned cluster as
% the "correct" one for classification of the training and
% test data. now we proceed to use supervised learning, i.e.
% we train a model based on the already present information
% of their respective class.

%% Linear Discriminat Analysis

% LDA attempts to find linear borders between classes. it
% assumes normally distributed data with the same variance
% for all classes (homoscedasticity).
% MATLAB has an LDA implementation in the statistics
% toolbox, but for the purpose of this course we use an
% implementation by Will Dwinnell and Deniz Sevis.

% generate example 2D data: 2 groups, n = 10 and 15, respectively
% one group has mu = [0,0], the other [1.5,1.5]
X = [randn(10,2); randn(15,2) + 1.5];  

% the classes are 0 and 1
Y = [zeros(10,1); ones(15,1)];

% calculate linear discriminant coefficients
W = LDA(X,Y);

% calulcate linear scores for training data
L = [ones(25,1) X] * W';

% calculate class probabilities
P = exp(L) ./ repmat(sum(exp(L),2),[1 2]);

% logical for class 0 or 1
class_prediction = P(:,1)<P(:,2);

% plot
figure(4);clf
scatter(X(:,1),X(:,2),[],Y,'filled')
title('Actual Classes')
subplot(1,2,1,gca)
subplot(1,2,2)
scatter(X(:,1),X(:,2),[],class_prediction,'filled')
title('LDA Predicted Classes')


%% EXERCISE
% create a test dataset (n=5) with mu = [1 1] (a little closer to
% class 1), predict the class of ech data point and plot it
% additionally to the previous plot (hold on) with a size of
% 100


% test set
X_test = [randn(5,2) + 1];

% calulcate linear scores for training data
L = [ones(length(X_test),1) X_test] * W';

% calculate class probabilities
P = exp(L) ./ repmat(sum(exp(L),2),[1 2]);

% logical for class 0 or 1
class_prediction = P(:,1)<P(:,2);

hold on
scatter(X_test(:,1),X_test(:,2),100,class_prediction,'filled')

%% Fishers iris dataset
% LDA was actually originally invented by Fihser (the dude
% with the flowers)

load fisheriris

meas
species

unique_species = unique(species)
n_classes = length(unique_species)

for class = 1:n_classes
    
    classes_fishers(find(strcmp(species,...
        unique_species{class}))) = class;
    
end

% compute linear discriminant coefficients
W_fishers = LDA(meas,classes_fishers);

% predict the classes of the data points using the LDA
% weights
class_predictions_fishers = LDA_predict(meas,W_fishers);

%% visualize with t-SNE
rng default
Y = tsne(meas);

figure(5); clf
subplot(121);
gscatter(Y(:,1),Y(:,2),classes_fishers)
title('Actual Fisher Iris Classes')
subplot(122);
gscatter(Y(:,1),Y(:,2),class_predictions_fishers)
title('LDA Predicted Fisher Iris Classes')


%% evaluate accuracy
% since we know the actual classes and the predicted classes
% the accuracy computation is rather straightforward.
% classification accuracy is the summed true-positive score
% of the confusion matrix, divided by the amount of data 

[accuracy, confusion_matrix] =...
    compute_classification_accuracy(classes_fishers,...
    class_predictions_fishers)

figure(6); clf
visualize_confusion_matrix(confusion_matrix);
xticks(1:3)
xticklabels(unique_species)
yticks(1:3)
yticklabels(unique_species)
title({'Confusion Matrix of LDA Predictions',...
    [' of the Fisher Iris Data (accuracy = '...
    num2str(accuracy*100) '%)']})

%% evaluate statistical significance

% to compute statistical significance confidence intervals,
% we use a permutation-based aproach, written by Laurens
% Krol. it creates an artificial dataset of the same size
% and shuffles the classes 25.000 times to find a
% distribution of randomized correct assignments that we can
% then test against with our classifications

% find the amount of data points in each actual class
classes_n = sum(confusion_matrix)

% the amount of data points in each classified class is this
sum(confusion_matrix,2)
% but we don't need that

alpha_level = 0.01;

pconf = simulateChance(classes_n,alpha_level)

% this means that the chance level is 33% (no surprise) but
% we need at least 43% accuracy (65 correct classifications)
% to be above chance level. also, if we have less than 23% 
% accuracy we have a classifier that is significantly worse 
% than chance level... all in all, our classifier is highly
% accurate! you likely won't encounter an accuracy level 
% this high in real live unfortunately ;)

title({'Confusion Matrix of LDA Predictions',...
    [' of the Fisher Iris Data (accuracy = '...
    num2str(accuracy*100) '%),'],...
    ['significant at \alpha = ' num2str(alpha_level)]})

% note that the chance level depends on the amount of trials
% in each group:

pconf = simulateChance([500 500 500],alpha_level)

pconf = simulateChance([50 50 1000],alpha_level)

%% EXERCISE
% test and plot how the accuracy level necessary for
% alpha=0.05 and 0.01 depends on the number of trials in a
% dataset with 2 and 3 same-sized classes for given Ns

Ns = [20 30 42 70 100 150 200 300 400];
alpha_levels = [0.05 0.01];
significant_accuracy_2 = zeros(2,length(Ns));
significant_accuracy_3 = zeros(2,length(Ns));


for i_n = 1:length(Ns)
    
    for i_alpha_level = 1:length(alpha_levels)
    n = Ns(i_n);
    
    pconf = simulateChance([n n],alpha_levels(i_alpha_level));
    significant_accuracy_2(i_alpha_level,i_n) = pconf(3);
    
    
    pconf = simulateChance([n n n],alpha_levels(i_alpha_level));
    significant_accuracy_3(i_alpha_level,i_n) = pconf(3);
    end
end

figure(7); clf
subplot(121)
plot(Ns,significant_accuracy_2)
legend({'\alpha = 0.05','\alpha = 0.01'})
xlabel('N')
ylabel('Accuracy')
title({'Necessary accuracy level to reach', 'significance (2 same-sized classes)'})

subplot(122)
plot(Ns,significant_accuracy_3)
legend({'\alpha = 0.05','\alpha = 0.01'})
xlabel('N')
ylabel('Accuracy')
title({'Necessary accuracy level to reach', 'significance (3 same-sized classes)'})

%% The MNIST dataset again. 
% Let's compare LDA and knnsearch as classifiers of the MNIST dataset. We
% can also see how they perform if they work not on the full feature data
% set but on the t-SNE reduced data set.

% load data
n_digits = 2000;

[imgs, labels] = readMNIST('train-images.idx3-ubyte', 'train-labels.idx1-ubyte', n_digits, 0);
size(imgs)
size(labels)

% reshape for t-SNE
data = transpose(reshape(imgs,[20*20,n_digits]));
size(data)

% use tsne
Y = tsne(data);

%% use LDA in tsne space

W_MNIST = LDA(Y,labels);

% Beware: The LDA predictions are numbers indicating the
% class, not the actual class label, so we need to
% transform this back into the class label of the MNIST
% dataset to compute the accuracy.
% The predictions just give us classes from 1 to 10, but
% actually we want the class labels. Luckily in this case
% it's simple, just subtract one from the result to get the
% labels 0-9

class_predictions_MNIST = LDA_predict(Y,W_MNIST) - 1;
accuracy_tsne = compute_classification_accuracy(labels,class_predictions_MNIST);

% use LDA in full space

W_MNIST_full = LDA(data,labels);
class_predictions_MNIST_full = LDA_predict(data,W_MNIST_full) - 1;
accuracy_full = compute_classification_accuracy(labels,class_predictions_MNIST_full);

% use knn in t-SNE space

k = 3;
idx = knnsearch(Y,Y,'K',k);

% take the most often assigned cluster as the classification
class_predictions_MNIST_knn_tsne = mode(labels(idx),2);
accuracy_knn_tsne = compute_classification_accuracy(labels,class_predictions_MNIST_knn_tsne);

% use knn in full space
idx = knnsearch(data,data,'K',k);

% take the most often assigned cluster as the classification
class_predictions_MNIST_knn_full = mode(labels(idx),2);
accuracy_knn_full = compute_classification_accuracy(labels,class_predictions_MNIST_knn_full);

% visualize

figure(5); clf
subplot(3,2,[1 2])
gscatter(Y(:,1),Y(:,2),labels)
xlabel('t-SNE 1')
ylabel('t-SNE 2')
title({['Original Labels of MNIST data (n=' num2str(n_digits) ')'],' visualized in t-SNE space'})

subplot(323)
gscatter(Y(:,1),Y(:,2),class_predictions_MNIST)
xlabel('t-SNE 1')
ylabel('t-SNE 2')
title({'LDA classification of MNIST data','in t-SNE space visualized in t-SNE space',...
    ['(accuracy = ' num2str(accuracy_tsne*100) '%)']})

subplot(324)
gscatter(Y(:,1),Y(:,2),class_predictions_MNIST_full)
xlabel('t-SNE 1')
ylabel('t-SNE 2')
title({'LDA classification of MNIST data','in full space visualized in t-SNE space',...
    ['(accuracy = ' num2str(accuracy_full*100) '%)']})

subplot(325)
gscatter(Y(:,1),Y(:,2),class_predictions_MNIST_knn_tsne)
xlabel('t-SNE 1')
ylabel('t-SNE 2')
title({'KNN classification (k=3) of MNIST data','in t-SNE space visualized in t-SNE space',...
    ['(accuracy = ' num2str(accuracy_knn_tsne*100) '%)']})

subplot(326)
gscatter(Y(:,1),Y(:,2),class_predictions_MNIST_knn_full)
xlabel('t-SNE 1')
ylabel('t-SNE 2')
title({'KNN classification (k=3) of MNIST data','in full space space visualized in t-SNE space',...
    ['(accuracy = ' num2str(accuracy_knn_full*100) '%)']})

%% This was not exacly a real performance test of the classifiers

% The classifiers predicted the same data points which they trained on.
% What we should actually do is to apply cross-validation here by splitting
% the data in parts, training on some and test on the other, and switch
% the test data until all data points have been test data points.

size(data)

folds = 1:4;

folds_start_end = [1 500; 501 1000; 1001 1500; 1501 2000]

data_folds = [];
data_folds(1,:,:) = data(1:500,:);
data_folds(2,:,:) = data(501:1000,:);
data_folds(3,:,:) = data(1001:1500,:);
data_folds(4,:,:) = data(1501:2000,:);

size(data_folds)

labels_folds = [];
labels_folds(1,:) = labels(1:500,:);
labels_folds(2,:) = labels(501:1000,:);
labels_folds(3,:) = labels(1001:1500,:);
labels_folds(4,:) = labels(1501:2000,:);

size(labels_folds)
accuracies = [];

for i_fold = folds
    
    % use LDA in full space

    this_folds_data = reshape(data_folds(folds~=i_fold,:,:),1500,400);
    this_folds_labels = reshape(labels_folds(folds~=i_fold,:),1500,1);
    
    W_MNIST_full = LDA(this_folds_data,this_folds_labels);
    class_predictions_MNIST_full = LDA_predict(squeeze(data_folds(i_fold,:,:)),W_MNIST_full) - 1;
    accuracies(i_fold) = compute_classification_accuracy(labels_folds(i_fold,:),class_predictions_MNIST_full);
    
end

accuracies
mean(accuracies)

% -> This is much lower than the previous values when predicting the data
% set the LDA was also trained on! So be aware of this and make sure your
% classifier (and classifiers you get from others) is properly
% cross-validated!
