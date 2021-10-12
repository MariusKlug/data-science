function [sumdist, distances] = visualizeClusters(data, k, lineColors, A, B, C)

% cluster 
[groupidx,cents,sumdist,distances] = kmeans(data,k,'Replicates',1,'display','final');

hold on

% now draw the raw data in different colors
for i=1:k
    
    % data points
    plot(data(groupidx==i,1),data(groupidx==i,2),'o','color',[ lineColors(i,:)],'markerface','w')
    
    % and now plot the centroid locations
    plot(cents(i,1),cents(i,2),'ko','markerface',lineColors(i,:),'markersize',10);
end

title([ 'Result of k-means clustering (k=' num2str(k) ')' ])

% connecting lines for clarification
for i=1:length(data)
    % plot with alpha value of 0.3 
   
    plot([ data(i,1) cents(groupidx(i),1) ],[ data(i,2) cents(groupidx(i),2) ],'color',lineColors(groupidx(i),:))
end

% finally, the "ground-truth" centers
plot(A(1),A(2),'kp','linew',2,'markersize',20,'markerfacecolor','y')
plot(B(1),B(2),'kp','linew',2,'markersize',20,'markerfacecolor','y')
plot(C(1),C(2),'kp','linew',2,'markersize',20,'markerfacecolor','y')