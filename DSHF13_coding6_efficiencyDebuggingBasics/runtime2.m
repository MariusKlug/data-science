% number of elements
N = 5000;
M = 100;

% initialize
data   = randn(M,N);


clear sems
for j=1:N
    tic
    data2 = data';
    sems(j) = std(data(:,j)) / sqrt(M) ;
    t = toc;
    if mod(j,100) == 0
        ETE = t * (N-j);
        disp(['ETE: ' num2str(round(ETE)) 's'])
    end
end

