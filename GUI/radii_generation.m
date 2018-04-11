
x_list = [];
y_list = [];
cnt = 0;
for pts = 1:10:101
  cnt=cnt+1;  
  x_radii = linspace(x,circ.XData(pts),10);
  y_radii = linspace(y,circ.YData(pts),10);
  x_list = [x_list x_radii];
  y_list = [y_list y_radii];
%   radii(cnt) =
end

