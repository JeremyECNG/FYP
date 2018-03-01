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

% Last Modified by GUIDE v2.5 15-Feb-2018 17:35:06

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

if exist('filter.mat')
   load('filter.mat') 
   filter_con.height_on = 0;
   save('filter.mat','filter_con')
end

% cursorMode = datacursormode(gcf)
% datacursormode off

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


range_sel =      getappdata(0,'range_type');
display_flag =  getappdata(0,'disp_flag');
R = 6.378*(10^6); %R is in meters 

if exist('nodesave.mat')
    load('nodesave.mat')
end

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
                     
                     setappdata(0,'range_dist',d_losh)
                     setappdata(0,'long_cordi',node_con(nod_num).node_location.longi); 
                     setappdata(0,'lat_cordi',node_con(nod_num).node_location.lati );
                     handles.losh_plot = range_plot(node_con(nod_num).node_location.longi  ,node_con(nod_num).node_location.lati  ,d_losh,handles.map);
                     
                 elseif strcmp(node_con(nod_num).node_type,'Tower Mounted')
                     

                     
                         if exist('towers.mat')
                            load('towers.mat')
                            if exist('tower_tnt')
                                
                                maxi = numel(tower_tnt);
                                
                                tower_cords = zeros(maxi,2);
                                
                                for elements = 1:maxi
                                    
                                    tower_cords(elements,:) = [tower_tnt(elements).Lon,tower_tnt(elements).Lat];
                                    
                                end

                                user_cords = [node_con(nod_num).node_location.longi  ,node_con(nod_num).node_location.lati];

                                 euclidean_distances = sqrt(sum(bsxfun(@minus, tower_cords, user_cords).^2,2));
                                 closest_tower = tower_cords(find(euclidean_distances==min(euclidean_distances)),:);
                                 
                                 h_bs = tower_tnt(find((ismember(tower_cords,closest_tower )),1)).AntennaHeight; %Height of Closest tower
                                 
                                 d_losh = (sqrt(2*R*h_bs))/(10^3); %answer in km
                                 setappdata(0,'range_dist',d_losh)                    
                                 setappdata(0,'long_cordi',closest_tower(:,1)); 
                                 setappdata(0,'lat_cordi',closest_tower(:,2));
                                 range_plot(closest_tower(:,1)  ,closest_tower(:,2)  ,d_losh,handles.map);
                                 
                            end
                        end
                 end
        
             case 1 %link
        
                user_l_sel = getappdata(0, 'user_link_selection');
                
               if exist('linksave.mat')
                    load('linksave.mat')

                    for linkin = 1:save_ind_link
                        if strcmp(user_l_sel,link_con(linkin).link_name)

                            link_num = linkin;

                        end
                    end
               end
                
               %%%%Code here bruv
               
               switch link_con(link_num).system_params.link_direction
                   
                   case 'Downlink'
                       
                       transmitter = link_con(link_num).node_selection.node1;
                       receiver = link_con(link_num).node_selection.node2;
                       
                       %load node stuff get location plot LOSH range from
                       %TX and  use area inside circle to determine
                       %if rx is in range and display text
                       
                       %insert circle checking to decide if point is within
                       %range circle 
                           for nodein = 1:save_ind
                               if strcmp(transmitter,node_con(nodein).node_name)
                                   tx_num = nodein;
                               end

                               if strcmp(receiver,node_con(nodein).node_name)
                                   rx_num = nodein;
                               end
                           end
                           
                           rx_cords = [node_con(rx_num).node_location.longi  ,node_con(rx_num).node_location.lati ];
                           tx_cords = [node_con(tx_num).node_location.longi  ,node_con(tx_num).node_location.lati ];

                           %%%%%%%%%
                           
                           if strcmp(node_con(tx_num).node_type,'Mobile at Sea')
                     
                                 h_ves = 2; %Vessel selected to be maximum 2m 

                                 d_losh = (sqrt(2*R*h_ves))/(10^3); %answer in km
                                 
                                 setappdata(0,'range_dist',d_losh)
                                 setappdata(0,'long_cordi',node_con(tx_num).node_location.longi); 
                                 setappdata(0,'lat_cordi',node_con(tx_num).node_location.lati);
                                 range_plot(node_con(tx_num).node_location.longi  ,node_con(tx_num).node_location.lati  ,d_losh,handles.map);
                                 
                                 euclidean_los = sqrt(sum(bsxfun(@minus, tx_cords, rx_cords).^2,2)); %find direct distance between tx and rx to find if rx is in range of tx by comparing the link lenght to the LOSH distance(radius) 

                           elseif strcmp(node_con(tx_num).node_type,'Tower Mounted')

     
                               if exist('towers.mat')
                                       
                                   load('towers.mat')
                                        
                                   if exist('tower_tnt')

                                            maxi = numel(tower_tnt);

                                            tower_cords = zeros(maxi,2);

                                            for elements = 1:maxi

                                                tower_cords(elements,:) = [tower_tnt(elements).Lon,tower_tnt(elements).Lat];

                                            end

                                            user_cords = [node_con(tx_num).node_location.longi  ,node_con(tx_num).node_location.lati];

                                             euclidean_distances = sqrt(sum(bsxfun(@minus, tower_cords, user_cords).^2,2));
                                             closest_tower = tower_cords(find(euclidean_distances==min(euclidean_distances)),:);

                                             h_bs = tower_tnt(find((ismember(tower_cords,closest_tower )),1)).AntennaHeight; %Height of Closest tower

                                             d_losh = (sqrt(2*R*h_bs))/(10^3); %answer in km
                                             setappdata(0,'range_dist',d_losh)
                                             setappdata(0,'long_cordi',closest_tower(:,1)); 
                                             setappdata(0,'lat_cordi',closest_tower(:,2));
                                             range_plot(closest_tower(:,1)  ,closest_tower(:,2)  ,d_losh,handles.map);

                                   end
                               end
                           end
 %%%%%
 %if (x-x0)^2 + (y-y0)^2 < r^2, %the point (x,y) is inside the circle
    
                   case 'Uplink'
                       
                       transmitter = link_con(link_num).node_selection.node2;
                       receiver = link_con(link_num).node_selection.node1;
                                   
                       for nodein = 1:save_ind
                              
                           if strcmp(transmitter,node_con(nodein).node_name)
                                   tx_num = nodein;
                           end
                           
                           if strcmp(receiver,node_con(nodein).node_name)
                                   rx_num = nodein;                              
                           end
                       end
               end
         end

        

    case 1 %Power Limited 
        
         switch display_flag
    
             case 0 %node   
                 
             case 1 %link
                 
               user_l_sel = getappdata(0, 'user_link_selection');
                
               if exist('linksave.mat')
                    load('linksave.mat')

                    for linkin = 1:save_ind_link
                        if strcmp(user_l_sel,link_con(linkin).link_name)

                            link_num = linkin;

                        end
                    end
               end
               
               switch link_con(link_num).system_params.link_direction

                    case 'Downlink'

                    transmitter = link_con(link_num).node_selection.node1;
                    receiver = link_con(link_num).node_selection.node2;

                    %load node stuff get location plot LOSH range from
                    %TX and  use area inside circle to determine
                    %if rx is in range and display text

                    %insert circle checking to decide if point is within
                    %range circle 
                    for nodein = 1:save_ind
                       if strcmp(transmitter,node_con(nodein).node_name)
                           tx_num = nodein;
                       end

                       if strcmp(receiver,node_con(nodein).node_name)
                           rx_num = nodein;
                       end
                    end

                    rx_cords = [node_con(rx_num).node_location.longi  ,node_con(rx_num).node_location.lati ];
                    tx_cords = [node_con(tx_num).node_location.longi  ,node_con(tx_num).node_location.lati ];
                    
                   case 'Uplink'
                       
               end
               
               Ptx = node_con(tx_num).equipment_params.tx_pwr;
               Prx = node_con(rx_num).equipment_params.rx_pwr;
               setappdata(0,'prx_display',Prx)
               Gant = node_con(tx_num).equipment_params.tx_ant_gain + node_con(rx_num).equipment_params.rx_ant_gain;
               Cable_losses = node_con(tx_num).equipment_params.tx_cable_loss + node_con(rx_num).equipment_params.rx_cable_loss;
               f = link_con(link_num).system_params.freq;
               switch link_con(link_num).channel.path_loss_model
                   
                   case 'FSPL'
                       
                       Path_Loss = Ptx + Gant - Cable_losses - Prx;
                       
                       plim_distance = 10^((Path_Loss-20*log10(f)-32.44)/20);
                       
                       range_plot(node_con(tx_num).node_location.longi  ,node_con(tx_num).node_location.lati  ,plim_distance,handles.map);
               end
               
             
               
         end
        
end


% user_n_sel = getappdata(0, 'user_node_selection');
% 
% if exist('nodesave.mat')
%     load('nodesave.mat')
% 
%     for nodein = 1:save_ind
%         if strcmp(user_n_sel,node_con(nodein).node_name)
% 
%             nod_num = nodein;
% 
%         end
% 
%     end
% end

user_l_sel = getappdata(0, 'user_link_selection');

if exist('linksave.mat')
    load('linksave.mat')

    for linkin = 1:save_ind_link
        if strcmp(user_l_sel,link_con(linkin).link_name)

            link_num = linkin;

        end
    end
end

tput_modulation = link_con(link_num).system_params.mod_sch;
if strcmp(link_con(link_num).system_params.code_rate,'6x10^-8')
    tput_code_rate = 6*10^-8;
else
    tput_code_rate = str2double(link_con(link_num).system_params.code_rate);
end

switch tput_modulation
    
    case 'QPSK'
        Qm = 2;
        
    case '16QAM'
        Qm = 4;
        
    case '64QAM'
        Qm = 6;
        
    case '256QAM'
        Qm = 8;
                
end

PDSCH_RE_frame = 6352; %Extended CP, CFI = 3, BW = 1.4 MHz
phy_tput_frame = ((PDSCH_RE_frame*Qm)/(10*10^-3))/10^6; %SISO
set(handles.throughput_display_text, 'String',phy_tput_frame) 

set(handles.ber_display_text, 'String',link_con(link_num).node_service.ber) 
set(handles.node_display_text, 'String',link_con(link_num).link_name) 

rxs = getappdata(0,'prx_display');
set(handles.rx_sens_text, 'String',rxs) 

%Resume coding here dude

tput_range = getappdata(0,'tput_on');
tput_value =  getappdata(0,'throughput_flag');
if 1 == tput_range 
    
    switch tput_value
        
        case 1 %Full Range
            throughpt = getappdata(0,'range_dist');
            x = getappdata(0,'long_cordi'); 
            y = getappdata(0,'lat_cordi');
            phy_tput_frame = ((PDSCH_RE_frame*Qm)/(10*10^-3))/10^6; %SISO
            set(handles.throughput_display_text, 'String',phy_tput_frame) 
%             txt = '\rightarrow 50% Range ' ;
%             shift = (x+(throughpt/0.011132)*0.0001);                                                                                                     
%             handles.tput_text = text(shift,y,txt, 'HorizontalAlignment','left');
            handles.tput_plotting = tput_plot(x,y,throughpt,handles.map);
            
        case 2 %75% Range
            throughpt = 0.75*(getappdata(0,'range_dist'));
            
            x = getappdata(0,'long_cordi'); 
            y = getappdata(0,'lat_cordi');
%             txt = '\rightarrow 75% Range ' ;
%             shift = (x+(throughpt/0.011132)*0.0001);
% 
%             handles.tput_text = text(shift,y,txt, 'HorizontalAlignment','left');
            handles.tput_plotting = tput_plot(x,y,throughpt,handles.map);
            
        case 3 %50 Range
            throughpt = 0.5*(getappdata(0,'range_dist'));
            
            x = getappdata(0,'long_cordi'); 
            y = getappdata(0,'lat_cordi');
%             txt = '\rightarrow 50% Range ' ;
%             shift = (x+(throughpt/0.011132)*0.0001);                                                                                                     
%             handles.tput_text = text(shift,y,txt, 'HorizontalAlignment','left');
            handles.tput_plotting = tput_plot(x,y,throughpt,handles.map);
            
        case 4 %25 Range
           
            throughpt = 0.25*(getappdata(0,'range_dist'));
            x = getappdata(0,'long_cordi'); 
            y = getappdata(0,'lat_cordi');
%             txt = '\rightarrow 50% Range ' ;
%             shift = (x+(throughpt/0.011132)*0.0001);                                                                                                     
%             handles.tput_text = text(shift,y,txt, 'HorizontalAlignment','left');
            handles.tput_plotting = tput_plot(x,y,throughpt,handles.map);         
    end
    
end


function circ = range_plot(x,y,r,ax)
hold on
ang = 0:pi/50:2*pi;
% xunit = ((r/1.1132)*0.01) * cos(ang) + x;
% yunit = ((r/1.1132)*0.01) * sin(ang) + y;
xunit = ((r/0.011132)*0.0001) * cos(ang) + x; %decimal coordinates to four decimal places 
yunit = ((r/0.011132)*0.0001) * sin(ang) + y; %decimal coordinates to four decimal places 
circ = plot(ax,xunit, yunit, 'r', 'LineWidth',3); 
hold off

function circl = tput_plot(x,y,r,ax)
hold on
ang = 0:pi/50:2*pi;
% xunit = ((r/1.1132)*0.01) * cos(ang) + x;
% yunit = ((r/1.1132)*0.01) * sin(ang) + y;
xunit = ((r/0.011132)*0.0001) * cos(ang) + x; %decimal coordinates to four decimal places 
yunit = ((r/0.011132)*0.0001) * sin(ang) + y; %decimal coordinates to four decimal places 
circl = plot(ax,xunit, yunit, 'b', 'LineWidth',2); 
hold off

% --- Executes on button press in configure_pushbutton.
function configure_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to configure_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

newnode = (get(handles.new_node_radiobutton, 'Value'));
newlink = (get(handles.new_link_radiobutton, 'Value'));

if (1 == newlink )
%     link_config('main_screen_v5',handles.figure1)
        link_config
elseif (1 == newnode) 
%      node_config('main_screen_v5',handles.figure1)
        node_config
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

if exist('filter.mat')
   load('filter.mat') 
   filter_on = filter_con.height_on;
%    towers_selected = getappdata(0,'towers_selection');
end


if (0 == filter_on && 1 == towers_on) 
    if exist('towers.mat')
        load('towers.mat')
        if exist('tower_tnt')
            
            if isfield(handles,'tower_plot_all')
                set(handles.tower_plot_all, 'Visible', 'on')
                if isfield(handles,'tower_plot_sel')
                set(handles.tower_plot_sel, 'Visible', 'off')
                end
            else

            lon_var = [tower_tnt.Lon];
            lat_var = [tower_tnt.Lat];
            handles.tower_plot_all = plot(handles.map,lon_var,lat_var,'r*');
            
            end
 
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
    
elseif (1 == filter_on && 1 == towers_on) 
    
    if exist('filter.mat')
       load('filter.mat') 
       towers_selected = tower_sel;
%    towers_selected = getappdata(0,'towers_selection');
    end
    
    cng_flag = getappdata(0,'filter_change_flag');
            if (isfield(handles,'tower_plot_sel') && (cng_flag==0))
                set(handles.tower_plot_sel, 'Visible', 'on')
                if isfield(handles,'tower_plot_all')
                set(handles.tower_plot_all, 'Visible', 'off')
                end
            else

            lon_var = [towers_selected.Lon];
            lat_var = [towers_selected.Lat];
            handles.tower_plot_sel = plot(handles.map,lon_var,lat_var,'r*');
            
            end


    setappdata(0,'filter_change_flag',0)
else 
    
    
if isfield(handles,'tower_plot_sel')
set(handles.tower_plot_sel, 'Visible', 'off')
end
if isfield(handles,'tower_plot_all')
set(handles.tower_plot_all, 'Visible', 'off')
end

% set(handles.tower_plot,'Visible','off')

%clear(handles.tower_plot)
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
econ_on = get(hObject,'Value');

if 1 == econ_on 
    if exist('geodata.mat')
        load('geodata.mat')
        if exist('eez')

lon_var = [eez.Lon];
lat_var = [eez.Lat];
handles.econ_plot = plot(handles.map,lon_var,lat_var,'--w','LineWidth',2);
%fill(handles.map,lon_var,lat_var,'w')

        end

    else
        errordlg('No Economic Zone Data Found', 'Data Set Selection')
        return;
    end
    
else 
    delete (handles.econ_plot)
end

guidata(handles.figure1, handles);

% --- Executes on button press in cont_zones_checkbox.
function cont_zones_checkbox_Callback(hObject, eventdata, handles)
% hObject    handle to cont_zones_checkbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cont_zones_checkbox
contig_on = get(hObject,'Value');

if 1 == contig_on 
    if exist('geodata.mat')
        load('geodata.mat')
        if exist('con')

lon_var = [con.Lon];
lat_var = [con.Lat];
handles.contig_plot = plot(handles.map,lon_var,lat_var,'--y','LineWidth',2);
%fill(handles.map,lon_var,lat_var,'y') 


        end

    else
        errordlg('No Contiguous Zone Data Found', 'Data Set Selection')
        return;
    end
    
else 
    delete (handles.contig_plot)
end

guidata(handles.figure1, handles);

% --- Executes on button press in terr_waters_checkbox.
function terr_waters_checkbox_Callback(hObject, eventdata, handles)
% hObject    handle to terr_waters_checkbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of terr_waters_checkbox
terri_on = get(hObject,'Value');

if 1 == terri_on 
    if exist('geodata.mat')
        load('geodata.mat')
        if exist('ter')

lon_var = [ter.Lon];
lat_var = [ter.Lat];
handles.terri_plot = plot(handles.map,lon_var,lat_var,'--m','LineWidth',2);
%fill(handles.map,lon_var,lat_var,'m')

        end

    else
        errordlg('No Territorial Waters Data Found', 'Data Set Selection')
        return;
    end
    
else 
    delete (handles.terri_plot)
end

guidata(handles.figure1, handles);

% --- Executes on button press in tower_filter_pushbutton.
function tower_filter_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to tower_filter_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
data_filter
%close(node_config)
% datacursormode toggle

% dcm_obj = datacursormode(handles.figure1);
% set(dcm_obj,'DisplayStyle','datatip',...
%     'SnapToDataVertex','off','Enable','on','UpdateFcn',@myupdatefcn)
% 
% text(-62,11.8,'Click on desired node location, then press Return.')
% % Wait while the user does this.
% pause 
% 
% c_info = getCursorInfo(dcm_obj);
% 
% showndoec(hObject,eventdata)

guidata(handles.figure1, handles);

% function showndoec(hObject,eventdata)
% h_nodec = findobj('Tag','figure_node');
% if (isempty(h_nodec))
%   % Display Error MEssage 
% else
%   figure(h_nodec);
% end

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

edit_flag =  getappdata(0,'disp_flag');
 
 switch edit_flag
    
    case 0 %node
        
        node_edit


        
    case 1 %link
        
        link_edit
 end

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
    
    case 'los_radiobutton'
%         set(handles.link_popupmenu,'Enable','on')
%         set(handles.node_popupmenu,'Enable','off')
        setappdata(0,'range_type',0)
    case 'pwr_lim_radiobutton'
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
    
    case 'full_radiobutton'

        setappdata(0,'throughput_flag',1)
        
    case 'three_quarter_radiobutton'

        setappdata(0,'throughput_flag',2)
        
    case 'half_radiobutton'

        setappdata(0,'throughput_flag',3)
        
    case 'quarter_radiobutton'

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


% --------------------------------------------------------------------
function data_cursor_uitoggletool_OnCallback(hObject, eventdata, handles)
% hObject    handle to data_cursor_uitoggletool (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
f = 0;

% --------------------------------------------------------------------
function data_cursor_uitoggletool_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to data_cursor_uitoggletool (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on mouse press over axes background.
function map_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to map (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
f = 0;

function output_txt = myfunction(~,data_cursor_uitoggletool)
% ~            Currently not used (empty)
% event_obj    Object containing event data structure
% output_txt   Data cursor text


% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
delete(hObject);

% close(node_config)
% close(link_config)
% close(node_edit)
% close(link_edit)
% close(data_filter)
% close(node_select)
% close (link_select)
% close(node_display)
% close(link_display)
