function txt = myupdatefcn(empt,event_obj)
% Customizes text of data tips

pos = get(event_obj,'Position');

txt = {['Longitude: ',num2str(pos(1))],...
	      ['Latitude: ',num2str(pos(2))]};