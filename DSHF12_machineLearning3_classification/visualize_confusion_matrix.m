function visualize_confusion_matrix(confusion_matrix)

% plot the confusion matrix as image
imagesc(confusion_matrix)
% xticks(1:3)
% yticks(1:3)
xlabel('Actual Class')
ylabel('Predicted Class')

% add the numbers as info on the picture
N=size(confusion_matrix,1);

% generate x and y coordinates
x = repmat(1:N,N,1); 
y = x'; 

% Generate Labels
t = cellfun(@num2str, num2cell(confusion_matrix), 'UniformOutput', false);
text(x(:), y(:), t, 'HorizontalAlignment', 'Center')

% just cause i think it's prettier
set(gca,'fontsize', 16)