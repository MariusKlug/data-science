function class_predictions = LDA_predict(data, W)


% Calulcate linear scores for training data
L2 = [ones(size(data,1),1) data] * W';

% Calculate class probabilities
P = exp(L2) ./ repmat(sum(exp(L2),2),[1 size(W,1)]);

% predict class
[~, class_predictions] = max(P,[],2);