% basicstats(input_vector) - computes mean, SD, and sem of a given vector
% 
% Input:
%   input_vector        - numerical vector
% 
% Output:
%   res_mean            - mean of the vector
%   res_sd              - standard deviation of the vector
%   res_sem             - standard error of the mean of the vector
% 
% Example usage:
%  [res_mean, res_sd, res_sem] = basicstats(input_vector)
% 
% Author: Marius Klug, bpn.tu-berlin.de, 2019
%   This function is free for any kind of distribution and usage!

function [res_mean, res_sd, res_sem] = basicstats(input_vector)

% always a good practise: If no arguments are entered, print the help and stop
if nargin == 0
    help basicstats
    return
end

% input checks
if ~isnumeric(input_vector)
    error('The input must be numeric.')
end

if ~isvector(input_vector)
    error('The input must be a vector.')
end


% computation 
res_mean = mean(input_vector);
res_sd = std(input_vector);
res_sem = sem(input_vector);