% SEM() - Computes the standard error of the mean.
% 
% Input using key-value flags:
%   data        - REQUIRED numerical input
%   dim         - OPTIONAL natural number, dimension of the input to be operated on
%                   If no dim is given, the first dimension with length greater than 1 is used.
%	verbose		- OPTIONAL boolean [0|1] whether or not verbose output
%					should be displayed, default 0
% 
% Output:
%   res         - standard error of the mean of the input in the given dimension
% 
% Example usage:
%   input_matrix = randn(5);
%   dim = 3;
%   res = sem(input_matrix,'dim',dim,'verbose',1)
% 
% Author: Marius Klug, bpn.tu-berlin.de, 2020
%   This function is free for any kind of distribution and usage!

function res = sem(data, varargin)

% if no arguments are entered, print the help and stop
if nargin == 0
    help sem
    return
end

% input parsing settings
p = inputParser;
p.CaseSensitive = false;

% isNaturalNumber = @(x) isnumeric(x) && isscalar(x) && (x > 0) && mod(x,1)==0;
% isBool = @(x) isnumeric(x) && (x==0 || x==1);

% addRequired(p, 'data', @isnumeric); % for this a default function is fine
% addOptional(p, 'dim', 0, isNaturalNumber) % this is still missing some specification!
% addOptional(p, 'verbose', 0, isBool); % islogical would be false if just entered 0 or 1 because these are doubles

addRequired(p, 'data', @(x) validateattributes(x,{'numeric'},{},'sem','data')) % for this a default function is fine
addOptional(p, 'dim', 0,  @(x) validateattributes(x,{'numeric'},{'positive','integer','scalar'},'sem','dim')) % this is still missing some specification!
addOptional(p, 'verbose', 0, @(x) validateattributes(x,{'numeric','logical'},{'scalar','binary'},'sem','verbose')); 

expectedCharArrays = {'on','off'};
addOptional(p, 'verboseString', 'off', @(x) validatestring(x,expectedCharArrays,'sem','verboseString')); 

% parse the input
parse(p,data,varargin{:});

% then set/get all the inputs out of this structure
data = p.Results.data;
dim = p.Results.dim;
verbose = p.Results.verbose;

% finalize dimension input
if dim == 0
	if verbose
		disp('No dim input given, using first non-singleton dimension.')
	end
    dim = find(size(data)~=1,1,'first');
elseif dim > ndims(data)
	if verbose
		disp('dim larger than number of dimensions, reducing to ndims(data).')
	end
	dim = length(size(data));
end

% computation
std_matrix = std(data,[],dim);
size_that_dim = size(data,dim);
res = std_matrix / sqrt(size_that_dim);
