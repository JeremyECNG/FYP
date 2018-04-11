% x_radii = [circ.XData(1) x circ.XData(11) x circ.XData(21) x circ.XData(31) x circ.XData(41) x circ.XData(51) x circ.XData(61) x circ.XData(71) x circ.XData(81) x circ.XData(91) x ];
% y_radii = [circ.YData(1) y circ.YData(11) y circ.YData(21) y circ.YData(31) y circ.YData(41) y circ.YData(51) y circ.YData(61) y circ.YData(71) y circ.YData(81) y circ.YData(91) y ];
% % radii = line(ax,x_radii ,y_radii );
% cnt = 0;
% for ind = 1:2:20
%     
%     cnt = cnt+1;
%     radii(cnt) = line(ax,[x_radii(ind) x_radii(ind+1)] ,[y_radii(ind) y_radii(ind+1)] );
% 
%     
% 
% end

% x_radii = linspace(x,circ.XData(1),10);
% y_radii = linspace(y,circ.YData(1),10);
% radii = plot(ax,x_radii,y_radii);

% cnt = 0;
% for pts = 1:10:101
%   cnt=cnt+1;  
%   x_radii(cnt) = linspace(x,circ.XData(pts),10);
%   y_radii(cnt) = linspace(y,circ.YData(pts),10);
%   
% end
% 
% radii = plot(ax,x_radii(1),y_radii(1));


cnt = 0;
for pts = 1:10:101
  cnt=cnt+1;  
  x_radii = linspace(x,circ.XData(pts),10);
  y_radii = linspace(y,circ.YData(pts),10);
  radii = plot(ax,x_radii,y_radii);
end

radii_1,radii_2,radii_3,radii_4,radii_5,radii_6,radii_7,radii_8,radii_9,radii_10

x_radii = linspace(x,circ.XData(1),10);
y_radii = linspace(y,circ.YData(1),10);
radii_1 = plot(ax,x_radii,y_radii);


x_radii = linspace(x,circ.XData(11),10);
y_radii = linspace(y,circ.YData(11),10);
radii_2 = plot(ax,x_radii,y_radii);

x_radii = linspace(x,circ.XData(21),10);
y_radii = linspace(y,circ.YData(21),10);
radii_3 = plot(ax,x_radii,y_radii);

x_radii = linspace(x,circ.XData(31),10);
y_radii = linspace(y,circ.YData(31),10);
radii_4 = plot(ax,x_radii,y_radii);

x_radii = linspace(x,circ.XData(41),10);
y_radii = linspace(y,circ.YData(41),10);
radii_5 = plot(ax,x_radii,y_radii);

x_radii = linspace(x,circ.XData(51),10);
y_radii = linspace(y,circ.YData(51),10);
radii_6 = plot(ax,x_radii,y_radii);

x_radii = linspace(x,circ.XData(61),10);
y_radii = linspace(y,circ.YData(61),10);
radii_7 = plot(ax,x_radii,y_radii);

x_radii = linspace(x,circ.XData(71),10);
y_radii = linspace(y,circ.YData(71),10);
radii_8 = plot(ax,x_radii,y_radii);

x_radii = linspace(x,circ.XData(81),10);
y_radii = linspace(y,circ.YData(81),10);
radii_9 = plot(ax,x_radii,y_radii);

x_radii = linspace(x,circ.XData(91),10);
y_radii = linspace(y,circ.YData(91),10);
radii_10 = plot(ax,x_radii,y_radii);



%%
randx = rand(min(circ.XData),max(circ.XData));
randy = rand(min(circ.YData),max(circ.YData));
scat_pts = scatter(randx,randy);

inpolygon(-61.15,10.58,circ.XData,circ.YData);

%%
% 
% x_radii = linspace(x,circ.XData(1),10);
% y_radii = linspace(y,circ.YData(1),10);
% % radii_1 = [x_radii;y_radii];
% radii(1) = plot(ax,x_radii,y_radii);
% % new_edg1 = topogr(radii_1,tx_height);
% % if any(new_edg1~=0)
% %     circ.XData(1) = new_edg1(1);
% %     circ.YData(1) = new_edg1(2);
% % end
% 
% x_radii = linspace(x,circ.XData(11),10);
% y_radii = linspace(y,circ.YData(11),10);
% % radii_2 =  [x_radii;y_radii];
% radii(2) = plot(ax,x_radii,y_radii);
% 
% x_radii = linspace(x,circ.XData(21),10);
% y_radii = linspace(y,circ.YData(21),10);
% radii_3 =  [x_radii;y_radii];
% 
% x_radii = linspace(x,circ.XData(31),10);
% y_radii = linspace(y,circ.YData(31),10);
% radii_4 =  [x_radii;y_radii];
% 
% x_radii = linspace(x,circ.XData(41),10);
% y_radii = linspace(y,circ.YData(41),10);
% radii_5 =  [x_radii;y_radii];
% 
% x_radii = linspace(x,circ.XData(51),10);
% y_radii = linspace(y,circ.YData(51),10);
% radii_6 =  [x_radii;y_radii];
% 
% x_radii = linspace(x,circ.XData(61),10);
% y_radii = linspace(y,circ.YData(61),10);
% radii_7 =  [x_radii;y_radii];
% 
% x_radii = linspace(x,circ.XData(71),10);
% y_radii = linspace(y,circ.YData(71),10);
% radii_8 = [x_radii;y_radii];
% 
% x_radii = linspace(x,circ.XData(81),10);
% y_radii = linspace(y,circ.YData(81),10);
% radii_9 =  [x_radii;y_radii];
% 
% x_radii = linspace(x,circ.XData(91),10);
% y_radii = linspace(y,circ.YData(91),10);
% radii_10 =  [x_radii;y_radii];

% radii = plot(ax,x_radii(1),y_radii(1));

% randx = randi([round(min(circ.XData)) round(max(circ.XData))],1,100);
% randy = randi([round(min(circ.YData)) round(max(circ.YData))],1,100);
% randx = randi([min(circ.XData) max(circ.XData)],1,100);
% randy = randi([min(circ.YData) max(circ.YData)],1,100);
% scat_pts = scatter(randx,randy);
% 
% inpolygon(scat_pts.XData,scat_pts.YData,circ.XData,circ.YData);
