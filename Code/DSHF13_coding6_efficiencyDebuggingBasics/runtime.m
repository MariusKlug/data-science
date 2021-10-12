% runtime

B = rand(10000);
C = ones(10000);
D = zeros(10000);

initialized = zeros(1,100000000);
clear unititalized
for i = 1:100000000
    unititalized(i)=i;
    initialized(i)=i;
end

for i = 1:100000000
   
end