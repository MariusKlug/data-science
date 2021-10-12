function [linehandles, areahandles] = errorarea(X,Y,errors)

linehandles = plot(X,Y,'Line_width',2);


for i_line = 1:size(linehandles,2)
	
    filly = [Y(:,i_line) + errors(:,i_line); fliplr([Y(:,i_line) + errors(:,i_line)]')'];
    
    fillx = [X(:,i_line); fliplr(X(:,i_line)')'];
    
    fill(fillx,filly,[linehandles(i_line).Color]);  
	
    set(areahandles(i_line), 'edgecolor', 'none');
    set(areahandles(i_line), 'FaceAlpha',0.2);
    
end

xlim([min(X) max(X)]);

