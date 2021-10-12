function [linehandles, areahandles] = errorarea(X,Y,errors)

if isvector(X); X = X(:); end;
if isvector(Y); Y = Y(:); end;

linehandles = plot(X,Y,'LineWidth',2);

hold on


for i_line = 1:size(linehandles,1)
    
    filly = [Y(:,i_line) + errors(:,i_line); fliplr([Y(:,i_line) - errors(:,i_line)]')'];
    
    fillx = [X(:,i_line); fliplr(X(:,i_line)')'];
    
    areahandles(i_line) = fill(fillx,filly,[linehandles(i_line).Color]);  
    set(areahandles(i_line), 'edgecolor', 'none');
    set(areahandles(i_line), 'FaceAlpha',0.2);
    
end

xlim([min(min(X)) max(max(X))]);

