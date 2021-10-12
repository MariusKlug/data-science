% basicstats(input_matrix, dim) - computes means, SDs, and sems of a given matrix
% 
% Input:
%   input_matrix        - numerical matrix
% 
% Output:
%   res_mean            - means of the matrix
%   res_sd              - standard deviations of the matrix
%   res_sem             - standard errors of the means of the matrix
% 
% Example usage:
%	randmat = normrnd(mu, sigma, n_randvec, n_repetitions);
%	dim = 2;
%	[res_mean, res_sd, res_sem] = basicstats(randmat,dim)
% 
% Author: Marius Klug, bpn.tu-berlin.de, 2019
%   This function is free for any kind of distribution and usage!

function [res_mean, res_sd, res_sem] = basicstats(input_matrix, dim)

% always a good practise: If no arguments are entered, print the help and stop
if nargin == 0
    help basicstats
    return
end

% input checks
if ~isnumeric(input_matrix)
    error('The input must be numeric.')
end

% it's possible to not enter the second input. 
% in that case use the first dimension that has more than 1 entry.
if ~exist('dim','var')
    dim = find(size(input_matrix)~=1,1,'first');
end

% this input check has to come after the previous check, 
% otherwise there would be an error if dim has not been entered.
if dim > ndims(input_matrix)
    error('The dimension must be equal to or smaller than the number of dimensions in the input.')
end


% computation 
res_mean = mean(input_matrix,dim);
res_sd = std(input_matrix,[],dim);
res_sem = sem(input_matrix,dim);