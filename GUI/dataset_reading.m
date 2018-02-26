eez.Lon = csvread('MarineRegions-eez_long.csv');
eez.Lat = csvread('MarineRegions-eez_lat.csv');

con.Lon = csvread('MarineRegions-con_long.csv');
con.Lat = csvread('MarineRegions-con_lat.csv');

ter.Lon = csvread('MarineRegions-ter_long.csv');
ter.Lat = csvread('MarineRegions-ter_lat.csv');


save('geodata.mat','eez','con','ter')





%%
towers_on = get(hObject,'Value');

if 1 == towers_on 
    if exist('towers.mat')
        load('towers.mat')
        if exist('tower_tnt')

lon_var = [tower_tnt.Lon];
lat_var = [tower_tnt.Lat];
handles.tower_plot = plot(handles.map,lon_var,lat_var,'r*');
 

        end

    else
        errordlg('No Tower Data Found', 'Tower Data Set Selection')
        return;
    end
    
else 
    delete (handles.tower_plot)
end

guidata(handles.figure1, handles);