function new_edge=topogr(x_list,y_list,tx_height)

setappdata(0,'canceling',0);
wait_time= waitbar(0,'Computing LOSH limit considering topography...','CreateCancelBtn','setappdata(gcbf,''canceling'',1)');
setappdata(wait_time,'canceling',0);

preamble = 'https://api.open-elevation.com/api/v1/lookup';
[rows, max] = size(x_list);
new_edge.x = zeros(rows,1);
new_edge.y = zeros(rows,1);
for ind_out = 1:rows
    location = '';
    for ind_in = 1:max
        %location = [location num2str(x_list(ind_out,ind_in),10) ',' num2str(y_list(ind_out,ind_in),10) '|']; %#ok<AGROW>
        location = [location num2str(y_list(ind_out,ind_in),10) ','  num2str(x_list(ind_out,ind_in),10) '|'];
    end
    location = ['?locations=' location(1:end-1)];
    
    url = [preamble location];
    topo_data = webread(url);
    elevationData = [topo_data.results.elevation];
    loc = find(elevationData>tx_height,1,'first');
    if isempty(loc)
        new_edge.x(ind_out) = x_list(ind_out,ind_in) ;
        new_edge.y(ind_out) = y_list(ind_out,ind_in) ;
    else
        new_edge.x(ind_out) = x_list(ind_out,loc) ;
        new_edge.y(ind_out) = y_list(ind_out,loc) ;
    end
    
    % Check for clicked Cancel button
    if getappdata(wait_time,'canceling')
        setappdata(0,'canceling',1);
       
        break
        
    end
    
    waitbar(ind_out/rows,wait_time,'Computing LOSH limit considering topography...');
end

delete(wait_time)



