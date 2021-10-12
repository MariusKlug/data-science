% sem() - Computes the standard error of the mean.
% 
% Input:
%   input       - numerical input
%   dim         - OPTIONAL: dimension of the input to be operated on
%                   If no dim is given, the first dimension with size greater than 1 is used.
% 
% Output:
%   res         - standard error of the mean of the input in the given dimension
% 
% Example usage:
%   input_matrix = randn(5);
%   dim = 2;
%   res = sem(input_matrix,dim)
% 
% Author: Marius Klug, bpn.tu-berlin.de, 2018
%   This function is free for any kind of distribution and usage!

function res = sem(input, dim)

% input checks
if ~isnumeric(input)
    error('The input must be numeric.')
end

% it's possible to not enter the second input. 
% in that case use the first dimension that has more than 1 entry.
if ~exist('dim','var')
    dim = find(size(input)~=1,1,'first');
end

% this input check has to come after the previous check, 
% otherwise there would be an error if dim has not been entered.
if dim > ndims(input)
    error('The dimension must be equal to or smaller than the number of dimensions in the input.')
end

% computation
std_matrix = std(input,[],dim);
size_that_dim = size(input,dim);
res = std_matrix / sqrt(size_that_dim);


