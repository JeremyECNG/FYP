function varargout = main_screen_v5(varargin)
% MAIN_SCREEN_V5 MATLAB code for main_screen_v5.fig
%      MAIN_SCREEN_V5, by itself, creates a new MAIN_SCREEN_V5 or raises the existing
%      singleton*.
%
%      H = MAIN_SCREEN_V5 returns the handle to a new MAIN_SCREEN_V5 or the handle to
%      the existing singleton*.
%
%      MAIN_SCREEN_V5('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MAIN_SCREEN_V5.M with the given input arguments.
%
%      MAIN_SCREEN_V5('Property','Value',...) creates a new MAIN_SCREEN_V5 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before main_screen_v5_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to main_screen_v5_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help main_screen_v5

% Last Modified by GUIDE v2.5 09-Feb-2018 12:07:32

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @main_screen_v5_OpeningFcn, ...
                   'gui_OutputFcn',  @main_screen_v5_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before main_screen_v5 is made visible.
function main_screen_v5_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to main_screen_v5 (see VARARGIN)

% Choose default command line output for main_screen_v5
handles.output = hObject;

% set(handles.node_popupmenu,'Enable','on') 
% set(handles.link_popupmenu,'Enable','off')

% set(handles.prx_equip_radiobutton,'Enable','off') 
% set(handles.prx_comp_radiobutton,'Enable','off') 
% set(handles.prx_popupmenu,'Enable','off')
% set(handles.prx_text,'Enable','off')
     
%Take this from here and use it buddy dont forget

% if exist('nodesave.mat')
%     load('nodesave.mat')
%       node_choices= {node_con.node_name}; 
% 
% 
% %     for nodein = 1:save_ind
% %     node_choices(nodein + 1) = node_con(nodein).node_name;
% %     end
% %     node_choices(1) = 'Select';
%     
% % setappdata(0,'nodes_list',node_choices)
% set(handles.node_popupmenu, 'String', node_choices);
% set(handles.node_popupmenu, 'Value', 1);
% end


% if exist('linksave.mat')
%     load('linksave.mat')
%       link_choices= {link_con.link_name}; 
% 
% 
% %     for nodein = 1:save_ind
% %     node_choices(nodein + 1) = node_con(nodein).node_name;
% %     end
% %     node_choices(1) = 'Select';
%     
% % setappdata(0,'nodes_list',node_choices)
% set(handles.link_popupmenu, 'String', link_choices);
% set(handles.link_popupmenu, 'Value', 1);
% end

% setappdata(0, 'node_selec', 'Select');
setappdata(0,'range_type',0)
setappdata(0,'tput_on',0)
setappdata(0,'throughput_flag',1)

setappdata(0,'disp_flag',0)

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes main_screen_v5 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = main_screen_v5_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in run_pushbutton.
function run_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to run_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
tput_range = getappdata(0,'tput_on');
tput_value =  getappdata(0,'throughput_flag')
if 1 == tput_range 
    
    switch tput_value
        
        case 0 %Full Range
            
        case 1 %75% Range
            
        case 2 %50 Range
            
        case 3 %25 Range
            
    end
    
end

range_sel =      getappdata(0,'range_type');
display_flag =  getappdata(0,'disp_flag');
R = 6.378*(10^6); %R is in meters 

switch range_sel
    
    case 0 %LOS
        
         switch display_flag
    
             case 0 %node

%Resume coding here

                user_n_sel = getappdata(0, 'user_node_selection');
                
                if exist('nodesave.mat')
                    load('nodesave.mat')

                    for nodein = 1:save_ind
                        if strcmp(user_n_sel,node_con(nodein).node_name)

                            nod_num = nodein;

                        end

                    end
                end
                
                 if strcmp(node_con(nod_num).node_type,'Mobile at Sea')
                     
                     h_ves = 2; %Vessel selected to be maximum 2m 
                     
                     d_losh = (sqrt(2*R*h_ves))/(10^3); %answer in km
                     
                     range_plot(node_con(nod_num).node_location.longi  ,node_con(nod_num).node_location.lati  ,d_losh,handles.map)
                     
                 elseif strcmp(node_con(nod_num).node_type,'Tower Mounted')
                     
                     
                 end
        
             case 1 %link
        
                user_l_sel = getappdata(0, 'user_link_selection');
         end

        

    case 1 %Power Limited 
        
end


function circ = range_plot(x,y,r,ax)
hold on
ang = 0:pi/50:2*pi;
xunit = r * cos(ang) + x;
yunit = r * sin(ang) + y;
circ = plot(ax,xunit, yunit, 'r', 'LineWidth',3); 
hold off

% --- Executes on button press in configure_pushbutton.
function configure_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to configure_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

newnode = (get(handles.new_node_radiobutton, 'Value'));
newlink = (get(handles.new_link_radiobutton, 'Value'));

if (1 == newlink )
    link_config('main_screen_v5',handles.figure1) 
elseif (1 == newnode) 
     node_config('main_screen_v5',handles.figure1) 
end

guidata(handles.figure1, handles);



% --- Executes on button press in new_node_radiobutton.
function new_node_radiobutton_Callback(hObject, eventdata, handles)
% hObject    handle to new_node_radiobutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of new_node_radiobutton

%set(handles.new_node_radiobutton, 'UserData', handles.new_node_radiobutton.Value);

% --- Executes on button press in new_link_radiobutton.
function new_link_radiobutton_Callback(hObject, eventdata, handles)
% hObject    handle to new_link_radiobutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of new_link_radiobutton


% --- Executes on selection change in country_popupmenu.
function country_popupmenu_Callback(hObject, eventdata, handles)
% hObject    handle to country_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns country_popupmenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from country_popupmenu

contents = cellstr(get(hObject,'String'));
country = contents{get(hObject,'Value')};
set(handles.country_popupmenu, 'UserData', country);

guidata(handles.figure1, handles);


% --- Executes during object creation, after setting all properties.
function country_popupmenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to country_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in map_pushbutton.
function map_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to map_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
country = (get(handles.country_popupmenu, 'UserData'));
if (isempty(country))
    country = 'Grenada';
end
grenada = 'Grenada';
dominica = 'Dominica';
stlucia = 'St. Lucia';
stvincent = 'St. Vincent';
stkitts = 'St. Kitts';
trinidad = 'Trinidad & Tobago'; 

if (strcmp(grenada,country))
     sel = 1;
elseif (strcmp(dominica,country))
     sel = 2;
elseif (strcmp(stlucia,country))
    sel = 3;
elseif (strcmp(stvincent,country))
    sel = 4;
elseif (strcmp(stkitts,country))
    sel = 5;
elseif (strcmp(trinidad,country))
    sel = 6;
else 
    sel = 7;
end

handles.datacursor = datacursormode;
datacursormode off

switch sel
    case 1 

        set(handles.map, 'XLim', [-62.2,-61.2]);
        set(handles.map, 'YLim', [11.7,12.5]);
    case 2

        set(handles.map, 'XLim', [-62,-60.8]);
        set(handles.map, 'YLim', [14.9,15.8]);
    case 3

        set(handles.map, 'XLim', [-61.6,-60.3]);
        set(handles.map, 'YLim', [13.4,14.4]);
    case 4

        set(handles.map, 'XLim', [-61.8,-60.6]);
        set(handles.map, 'YLim', [12.8,13.7]);
    case 5

        set(handles.map, 'XLim', [-63.2,-62.3]);
        set(handles.map, 'YLim', [17,17.8]);
    case 6

        set(handles.map, 'XLim', [-62.5,-60]);
        set(handles.map, 'YLim', [9.5,12]);
    otherwise
        errordlg('Country not Found', 'Country Error')
        return;
end

xlabel(handles.map,'Longitude')
ylabel(handles.map,'Latitude')
grid(handles.map,'on')
plot_google_map('Axis',handles.map,'maptype','satellite');
hold on
guidata(handles.output, handles);

% --- Executes on selection change in link_popupmenu.
function link_popupmenu_Callback(hObject, eventdata, handles)
% hObject    handle to link_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns link_popupmenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from link_popupmenu
% contents = cellstr(get(hObject,'String'));
% linkselec = contents{get(hObject,'Value')};
% setappdata(0, 'link_selec', linkselec);


% --- Executes during object creation, after setting all properties.
function link_popupmenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to link_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in node_popupmenu.
function node_popupmenu_Callback(hObject, eventdata, handles)
% hObject    handle to node_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns node_popupmenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from node_popupmenu

% contents = cellstr(get(hObject,'String'));
% nodeselec = contents{get(hObject,'Value')};
% setappdata(0, 'node_selec', nodeselec);

   %sindisnd
   
% function setnodepop()
%         
% if exist('nodesave.mat')
%     load('nodesave.mat')
%      node_choices= {node_con.node_name}   ;   
% %     for nodein = 1:save_ind
% %     node_choices(nodein) = node_con(nodein).node_name;
% %     end
% set(handles.node_popupmenu, 'String', node_choices);
% set(handles.node_popupmenu, 'Value', 1);
% end
        

% 
% if exist('nodesave.mat')
%     load('nodesave.mat')
%             
%     for nodein = 1:save_ind
%     node_choices(save_ind) = node_con(save_ind).node_name;
%     end
% set(handles.node_popupmenu, 'String', node_choices);
% end




% --- Executes during object creation, after setting all properties.
function node_popupmenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to node_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in load_node_radiobutton.
function load_node_radiobutton_Callback(hObject, eventdata, handles)
% hObject    handle to load_node_radiobutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of load_node_radiobutton

% set(handles.node_popupmenu,'Enable','on') 
% set(handles.link_popupmenu,'Enable','off')
% 
% guidata(handles.figure1, handles);






% --- Executes on button press in load_link_radiobutton.
function load_link_radiobutton_Callback(hObject, eventdata, handles)
% hObject    handle to load_link_radiobutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of load_link_radiobutton

% set(handles.link_popupmenu,'Enable','on')
% set(handles.node_popupmenu,'Enable','off') 
%  
% guidata(handles.figure1, handles);

% --- Executes on button press in towers_checkbox.
function towers_checkbox_Callback(hObject, eventdata, handles)
% hObject    handle to towers_checkbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of towers_checkbox
towers_on = get(hObject,'Value');

if 1 == towers_on 
    if exist('towers.mat')
        load('towers.mat')
        if exist('tower_tnt')

%              jgeoshow(tower_tnt,'DisplayType','point')
%            geoshow(handles.map,tower_tnt,'DisplayType','point')
         %  geoshow(handles.map,10.6763,-61.5303,'DisplayType','point')
%             axesm('mapprojection','mercator')
%               geoshow(handles.map,tower_tnt,'DisplayType','point') 
lon_var = [tower_tnt.Lon];
lat_var = [tower_tnt.Lat];
 plot(handles.map,lon_var,lat_var,'r*')
 
% geoshow(tower_tnt.Lat,tower_tnt.Lon,'DisplayType', 'surface') 
% plotm(tower_tnt.Lat,tower_tnt.Lon)   
 %scatterplot(tower_tnt.Lat,tower_tnt.Lon) 
%   scatter(tower_tnt.Lat,tower_tnt.Lon) 
%plot(tower_tnt.Lat,tower_tnt.Lon,'*')
        end

    else
        errordlg('No Tower Data Found', 'Tower Data Set Selection')
        return;
    end
    
else 
    clear tower_tnt
end

guidata(handles.figure1, handles);

% --- Executes on button press in gmdss_checkbox.
function gmdss_checkbox_Callback(hObject, eventdata, handles)
% hObject    handle to gmdss_checkbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of gmdss_checkbox


% --- Executes on button press in fish_zones_checkbox.
function fish_zones_checkbox_Callback(hObject, eventdata, handles)
% hObject    handle to fish_zones_checkbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of fish_zones_checkbox


% --- Executes on button press in econ_zones_checkbox.
function econ_zones_checkbox_Callback(hObject, eventdata, handles)
% hObject    handle to econ_zones_checkbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of econ_zones_checkbox


% --- Executes on button press in cont_zones_checkbox.
function cont_zones_checkbox_Callback(hObject, eventdata, handles)
% hObject    handle to cont_zones_checkbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cont_zones_checkbox


% --- Executes on button press in terr_waters_checkbox.
function terr_waters_checkbox_Callback(hObject, eventdata, handles)
% hObject    handle to terr_waters_checkbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of terr_waters_checkbox


% --- Executes on button press in tower_filter_pushbutton.
function tower_filter_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to tower_filter_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
data_filter

guidata(handles.figure1, handles);

% --- Executes on button press in ber_checkbox.
function ber_checkbox_Callback(hObject, eventdata, handles)
% hObject    handle to ber_checkbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of ber_checkbox


% --- Executes on button press in throughput_checkbox.
function throughput_checkbox_Callback(hObject, eventdata, handles)
% hObject    handle to throughput_checkbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of throughput_checkbox
throughput_on = get(hObject,'Value');

setappdata(0,'tput_on',1)

% --- Executes on button press in full_radiobutton.
function full_radiobutton_Callback(hObject, eventdata, handles)
% hObject    handle to full_radiobutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of full_radiobutton


% --- Executes on button press in three_quarter_radiobutton.
function three_quarter_radiobutton_Callback(hObject, eventdata, handles)
% hObject    handle to three_quarter_radiobutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of three_quarter_radiobutton


% --- Executes on button press in half_radiobutton.
function half_radiobutton_Callback(hObject, eventdata, handles)
% hObject    handle to half_radiobutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of half_radiobutton


% --- Executes on button press in quarter_radiobutton.
function quarter_radiobutton_Callback(hObject, eventdata, handles)
% hObject    handle to quarter_radiobutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of quarter_radiobutton


% --- Executes on button press in range_checkbox.
function range_checkbox_Callback(hObject, eventdata, handles)
% hObject    handle to range_checkbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of range_checkbox


% --- Executes on button press in pwr_lim_radiobutton.
function pwr_lim_radiobutton_Callback(hObject, eventdata, handles)
% hObject    handle to pwr_lim_radiobutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of pwr_lim_radiobutton


% --- Executes on button press in los_radiobutton.
function los_radiobutton_Callback(hObject, eventdata, handles)
% hObject    handle to los_radiobutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of los_radiobutton


% --- Executes on selection change in prx_popupmenu.
function prx_popupmenu_Callback(hObject, eventdata, handles)
% hObject    handle to prx_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns prx_popupmenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from prx_popupmenu


% --- Executes during object creation, after setting all properties.
function prx_popupmenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to prx_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes when selected object is changed in load_selection.
function load_selection_SelectionChangedFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in load_selection 
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

switch eventdata.Source.SelectedObject.Tag
    
    case 'load_link_radiobutton'
%         set(handles.link_popupmenu,'Enable','on')
%         set(handles.node_popupmenu,'Enable','off')
        setappdata(0,'disp_flag',1)
    case 'load_node_radiobutton'
%         set(handles.node_popupmenu,'Enable','on') 
%         set(handles.link_popupmenu,'Enable','off')
        setappdata(0,'disp_flag',0)
    otherwise
        errordlg('Error Selecting Loading Source', 'Load Selection')
    return;
end
        

guidata(handles.figure1, handles);


% --- Executes when selected object is changed in range_selection.
function range_selection_SelectionChangedFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in range_selection 
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

switch eventdata.Source.SelectedObject.Tag
    
    case 'los_radiobutton'
%         set(handles.prx_equip_radiobutton,'Enable','off') 
%         set(handles.prx_comp_radiobutton,'Enable','off') 
%         set(handles.prx_popupmenu,'Enable','off')
%         set(handles.prx_text,'Enable','off')

    case 'pwr_lim_radiobutton'
%         set(handles.prx_equip_radiobutton,'Enable','on') 
%         set(handles.prx_comp_radiobutton,'Enable','on') 
%         set(handles.prx_popupmenu,'Enable','on')
%         set(handles.prx_text,'Enable','on')
    otherwise
        errordlg('Error Selecting Range Type', 'Range Selection')
    return;
end
        

guidata(handles.figure1, handles);


% --- Executes on button press in display_pushbutton.
function display_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to display_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
 display_flag =  getappdata(0,'disp_flag');
 
 switch display_flag
    
    case 0 %node
        
        node_display 


        
    case 1 %link
        
        link_display
 end

% 
% switch display_flag
%     
%     case 0
%         
%         nodesel = getappdata(0, 'node_selec');
% 
%         switch  nodesel
% 
%             case 'Select'
% 
%             errordlg('No Node Selected', 'Node Edit')
%             return;
% 
%             otherwise
% 
%              node_display   
% 
%         end
%         
%     case 1
%         
%                 linksel = getappdata(0, 'link_selec');
% 
%         switch  linksel
% 
%             case 'Select'
% 
%             errordlg('No Link Selected', 'Link Edit')
%             return;
% 
%             otherwise
% 
%                 link_display
% 
%         end
% end

% --- Executes on button press in edit_pushbutton.
function edit_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to edit_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% nodesel = getappdata(0, 'node_selec');
% 
% switch  nodesel
%     
%     case 'Select'
%         
%     errordlg('No Node Selected', 'Node Edit')
%     return;
%         
%     otherwise
%         
%         node_edit
%         
% end

% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over node_popupmenu.
function node_popupmenu_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to node_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
f = 0;


% --- Executes on key press with focus on node_popupmenu and none of its controls.
function node_popupmenu_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to node_popupmenu (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
f = 0;


% --- Executes when selected object is changed in range_uibuttongroup.
function range_uibuttongroup_SelectionChangedFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in range_uibuttongroup 
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

switch eventdata.Source.SelectedObject.Tag
    
    case 'LOS to Horizon Limited'
%         set(handles.link_popupmenu,'Enable','on')
%         set(handles.node_popupmenu,'Enable','off')
        setappdata(0,'range_type',0)
    case 'Power Limited'
%         set(handles.node_popupmenu,'Enable','on') 
%         set(handles.link_popupmenu,'Enable','off')
        setappdata(0,'range_type',1)
    otherwise
        errordlg('Error Selecting Range Type', 'Range Type Selection')
    return;
end

% --- Executes when selected object is changed in throughput_uibuttongroup.
function throughput_uibuttongroup_SelectionChangedFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in throughput_uibuttongroup 
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

switch eventdata.Source.SelectedObject.Tag
    
    case 'Full Range'

        setappdata(0,'throughput_flag',1)
        
    case '75% Range'

        setappdata(0,'throughput_flag',2)
        
    case '50% Range'

        setappdata(0,'throughput_flag',3)
        
    case '25% Range'

        setappdata(0,'throughput_flag',4)
        

    otherwise
        errordlg('Error Selecting Range', 'Throughput Range Selection')
    return;
end


% --- Executes on button press in select_pushbutton.
function select_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to select_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

 display_flag =  getappdata(0,'disp_flag');
 
 switch display_flag
    
    case 0 %node
        
        node_select 


        
    case 1 %link
        
        link_select
 end
