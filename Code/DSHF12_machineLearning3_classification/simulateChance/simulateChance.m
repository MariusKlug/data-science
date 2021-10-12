% pconf = simulateChance(ntrials, alpha[, nsims])
%
%       Gives a simulated estimation of the chance level and its confidence
%       interval for a classifier's accuracy, given a certain number of
%       trials per class and a significance level.
%
%       Based on procedure published in
%           Mueller-Putz, G. R., Scherer, R., Brunner, C., Leeb, R., &
%           Pfurtscheller, G. (2008). Better than random? A closer look on
%           BCI results. International Journal of Bioelectromagnetism,
%           10(1), 52-55.
%
% In:
%       ntrials - 1-by-n matrix containing number of trials for each class
%       alpha - the significance level (between 0 and 1)
%
% Optional:
%       nsims - the number of simulations (default: 25000)
%
% Out:
%       pconf - 1-by-4 matrix containing the lower bound of the confidence
%               interval, chance level, the upper bound of the confidence
%               interval, and the minimum number of correct trials to reach
%               significance (i.e. upper bound * number of all trials)
%
% Usage example:
%       >> pconf = simulateChance([250, 50], .025);
% 
%                    Copyright 2017 Laurens R Krol
%                    Team PhyPA, Biological Psychology and Neuroergonomics,
%                    Berlin Institute of Technology

% 2017-05-08 lrk
%   - Caught error when numel(ntrials) == 1
% 2017-04-26 First version

% This program is free software: you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation, either version 3 of the License, or
% (at your option) any later version.
%
% This program is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
%
% You should have received a copy of the GNU General Public License
% along with this program.  If not, see <http://www.gnu.org/licenses/>.

function pconf = simulateChance(ntrials, alpha, nsims)

if numel(ntrials) == 1
    warning('only one class given; assuming two balanced classes');
    ntrials = [ntrials, ntrials];
end
if ~exist('nsims', 'var'), nsims = 25000; end
sumtrials = sum(ntrials);
alpha = alpha * 100;

ps = zeros(1, nsims);
for s = 1:nsims
    % initialising trial array
    X = [];
    for t = 1:length(ntrials), X = [X, repmat(t, 1, ntrials(t))]; end
    
    % getting random prediction array
    Y = X(randperm(length(X)));
    
    % saving percentage of randomly correct trials
    ps(s) = sum(X==Y) / sumtrials;
end

% getting mean and confidence interval
pconf = [prctile(ps, alpha/2), mean(ps), prctile(ps, 100-alpha/2), ...
         ceil(prctile(ps, 100-alpha/2)*sumtrials)];

fprintf(['with %d classes (%s%s), chance level is at %0.2f%%.\n', ...
         'with alpha = %0.2f%%, significance is reached at %0.2f%%, ', ...
         'or %d correct classifications.\n'], ...
        length(ntrials), ...
        sprintf('n%d=%d, ', [1:numel(ntrials)-1; ntrials(1:end-1)]), ...
        sprintf('n%d=%d', numel(ntrials), ntrials(end)), pconf(2)*100, ...
        alpha, pconf(3)*100, pconf(4));

end