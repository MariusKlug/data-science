function [accuracy, confusion_matrix] = compute_classification_accuracy(classes, class_predictions)

% make column vector
classes = classes(:);
class_predictions = class_predictions(:);

k = length(unique(classes));

confusion_matrix = zeros(k);

% fill the matrix
for i_actual_class = 1:k
    
    % find the indices of data points that are in the actual
    % class
    idx_actual_class = classes == i_actual_class;
    
    for i_predicted_class = 1:k
        
        % find the indices of data points that are in the
        % predicted class
        idx_predicted_class = class_predictions == i_predicted_class;
        
        % sum up the amount of matching indices
        confusion_matrix(i_predicted_class,i_actual_class) =...
            sum(idx_actual_class&idx_predicted_class);
        
    end
    
end

% and this is the final result
accuracy = sum(diag(confusion_matrix))/size(classes,1);