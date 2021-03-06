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

% Last Modified by GUIDE v2.5 10-Apr-2018 18:21:33

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
setappdata(0,'tower_on_flag',0)
setappdata(0, 'user_node_selection', []);
setappdata(0, 'user_link_selection', []);
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

set(handles.pwr_lim_radiobutton,'Enable','off')
set(handles.prev_lim_radiobutton,'Enable','off')

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
R = 6.378*(10^6); %Radius of the earth in meters

switch display_flag %Variable for determining whether a node or link is to be displayed

 case 0 %Node is selected
     
     
     %Obtain user selection 
     user_n_sel = getappdata(0, 'user_node_selection');
     if isempty(user_n_sel) 
         errordlg('No node selected', 'Run')
     end
     
     %Load saved node information and initialize index
     if exist('nodesave.mat')
         load('nodesave.mat') 
         
         for nodein = 1:save_ind
             if strcmp(user_n_sel,node_con(nodein).node_name)
                 nod_num = nodein;
             end
         end
         
     else
         errordlg('No node information available', 'Run')
     end
     
     set(handles.node_display_text, 'String',node_con(nod_num).node_name)
     
     
     
     switch range_sel %Variable for determining whether a LOS or Power Limited range is to be plotted
         
         case 0 %LOS
             switch node_con(nod_num).node_type
                 
                 case 'Mobile at Sea' 
                     
                     h_ves = 2; %Vessel selected to be maximum 2m 
                     
                     tx_height = h_ves;
                     d_losh = (sqrt(2*R*h_ves))/(10^3); %answer in km

                     setappdata(0,'range_dist',d_losh)
                     setappdata(0,'long_cordi',node_con(nod_num).node_location.longi); 
                     setappdata(0,'lat_cordi',node_con(nod_num).node_location.lati );
                     handles.losh_plot = range_plot(node_con(nod_num).node_location.longi  ,node_con(nod_num).node_location.lati  ,d_losh,handles.map,tx_height);
                     label = ['\rightarrow'  (num2str(node_con(nod_num).node_name)) ' LOSH Plot ' num2str(round(d_losh)) 'km'];
                     handles.plot_label1 = text(handles.losh_plot.XData(1),handles.losh_plot.YData(1),label, 'HorizontalAlignment','left','Color','white','FontSize',14);
                     
                     h = findobj('Tag','gmap');
                     h = h(2);
                     makedatatip(h,[node_con(nod_num).node_location.longi node_con(nod_num).node_location.lati])
                     
                 case 'Tower Mounted' 
                     
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

                             tx_height = h_bs ;
                             d_losh = (sqrt(2*R*h_bs))/(10^3); %answer in km
                             setappdata(0,'range_dist',d_losh)                    
                             setappdata(0,'long_cordi',closest_tower(:,1)); 
                             setappdata(0,'lat_cordi',closest_tower(:,2));
                            handles.losh_plot = range_plot(closest_tower(:,1)  ,closest_tower(:,2)  ,d_losh,handles.map,tx_height);
                            label = ['\rightarrow'  (num2str(node_con(nod_num).node_name)) ' LOSH Plot ' num2str(round(d_losh)) 'km'];
                            handles.plot_label2 = text(handles.losh_plot.XData(1),handles.losh_plot.YData(1),label, 'HorizontalAlignment','left','Color','white','FontSize',14);
                            
                            h = findobj('Tag','gmap');
                            h = h(2);
                            makedatatip(h,[closest_tower(:,1)  closest_tower(:,2)])

                         end
                     end
                     
             end
             set(handles.range_display_text, 'String',d_losh)
             set(handles.rx_sens_text, 'String','N/A')
             set(handles.ber_display_text, 'String','N/A')
             set(handles.node_display_text, 'String',node_con(nod_num).node_name)
             set(handles.path_loss_disp_text, 'String', 'N/A');
             
             %set(handles.techno_disp_text, 'String',node_con(nod_num).equipment_params.technology )
             set(handles.service_disp_text, 'String','N/A' )
             set(handles.techno_disp_text, 'String','N/A' )
             set(handles.throughput_display_text, 'String','N/A')
             set(handles.freq_disp_text, 'String', 'N/A');
             set(handles.interf_disp_text, 'String', 'N/A');
             set(handles.fade_disp_text, 'String', 'N/A');
             
             %create legend
             i_am_legend = legend(handles.map,[handles.losh_plot],{'Node LOSH'},'Location','best');
             title(i_am_legend,'Line of Sight to Horizon Limit')
             
             
             
             
         case 1 %Power Limited
             
             errordlg('Range and Throughput cannot be computed for this configuration', 'Run')
             
             
         case 2 %Prevailing Limit
             errordlg('Range and Throughput cannot be computed for this configuration', 'Run')
                          
     end
     
     

 case 1 %Link is selected
          
     if exist('nodesave.mat')
         load('nodesave.mat') 
     end
     %Obtain user selection 
     user_l_sel = getappdata(0, 'user_link_selection');
     if isempty(user_l_sel) 
         errordlg('No link selected', 'Run')
     end    
     
     %Load saved link information and initialize index
     if exist('linksave.mat')
         load('linksave.mat') 
         
         for linkin = 1:save_ind_link
             if strcmp(user_l_sel,link_con(linkin).link_name)
                 link_num = linkin;
             end
         end
         
     else
         errordlg('No link information available', 'Run')
     end
     
     set(handles.node_display_text, 'String',link_con(link_num).link_name)
     
     %Determine if uplink or downlink
     
     switch link_con(link_num).system_params.link_direction
         
         case 'Downlink'
             transmitter = link_con(link_num).node_selection.node1;
             receiver = link_con(link_num).node_selection.node2;                       
             
         case 'Uplink'
             transmitter = link_con(link_num).node_selection.node2;
             receiver = link_con(link_num).node_selection.node1;
             
     end
     
     %Find receiver index and transmitter index
     for nodein = 1:save_ind
         if strcmp(transmitter,node_con(nodein).node_name)
             tx_num = nodein;
         end
         
         if strcmp(receiver,node_con(nodein).node_name)
             rx_num = nodein;
         end
     end
     
     %Extract transmitter and receiver coordinates 
     rx_cords = [node_con(rx_num).node_location.longi  ,node_con(rx_num).node_location.lati ];
     tx_cords = [node_con(tx_num).node_location.longi  ,node_con(tx_num).node_location.lati ];
          
         

      switch range_sel %Variable for determining whether a LOS or Power Limited range is to be plotted
         
         case 0 %LOS
             
             %Ascertain whether the transmitter is tower mounted or mobile at sea 
             switch node_con(tx_num).node_type
                 
                 case 'Mobile at Sea'
                     
                     h_ves = 2; %Vessel selected to be maximum 2m 
                     
                     %Plot Datatips for transmitter 
                     h = findobj('Tag','gmap');
                     h = h(2);
                     makedatatip(h,[node_con(tx_num).node_location.longi  node_con(tx_num).node_location.lati])
                     
                     switch node_con(rx_num).node_type
                         
                         case 'Mobile at Sea'
                             
                             h_2 = h_ves ;
                             
                             %Plot Datatips for receiver
                             h = findobj('Tag','gmap');
                             h = h(2);
                             makedatatip(h,[node_con(rx_num).node_location.longi  node_con(rx_num).node_location.lati]) 
                             
                             
                         case 'Tower Mounted'
                             
                             if exist('towers.mat')
                         
                                 load('towers.mat')
                         
                                 if exist('tower_tnt')

                                     maxi = numel(tower_tnt);

                                     tower_cords = zeros(maxi,2);

                             for elements = 1:maxi

                                 tower_cords(elements,:) = [tower_tnt(elements).Lon,tower_tnt(elements).Lat];
                             end
                             
                             user_cords = [node_con(rx_num).node_location.longi  ,node_con(rx_num).node_location.lati];

                                euclidean_distances = sqrt(sum(bsxfun(@minus, tower_cords, user_cords).^2,2));
                                closest_tower = tower_cords(find(euclidean_distances==min(euclidean_distances)),:);

                                h_2 = tower_tnt(find((ismember(tower_cords,closest_tower )),1)).AntennaHeight; %Height of Closest tower 
                                
                                %Plot Datatips for receiver
                                h = findobj('Tag','gmap');
                                h = h(2);
                                makedatatip(h,[closest_tower(:,1)  closest_tower(:,2)])
                                 end
                             end
                     end
                     
                     tx_height = h_ves ;
                     d_losh = (sqrt(2*R*h_ves)+sqrt(2*R*h_2))/(10^3); %answer in km

                     setappdata(0,'range_dist',d_losh)
                     setappdata(0,'long_cordi',node_con(tx_num).node_location.longi); 
                     setappdata(0,'lat_cordi',node_con(tx_num).node_location.lati);
                     plotted_range = range_plot(node_con(tx_num).node_location.longi  ,node_con(tx_num).node_location.lati  ,d_losh,handles.map,tx_height);
                     label = ['\rightarrow '  (num2str(link_con(link_num).link_name)) ' LOSH Plot ' num2str(round(d_losh)) 'km'];
                     handles.plot_label1 = text(plotted_range.XData(1),plotted_range.YData(1),label, 'HorizontalAlignment','left','Color','white','FontSize',14);

                     euclidean_los = sqrt(sum(bsxfun(@minus, tx_cords, rx_cords).^2,2)); %find direct distance between tx and rx to find if rx is in range of tx by comparing the link lenght to the LOSH distance(radius)
                     if euclidean_los<d_losh
                         range_flag = 1;   %Signal if in range or out of range                      
                     end

                    
                     
                 case 'Tower Mounted'
                     
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
                                h_ves = 2; 
                                tx_height = h_bs ;

                                d_losh = (sqrt(2*R*h_bs)+sqrt(2*R*h_ves))/(10^3); %answer in km
                                setappdata(0,'range_dist',d_losh)
                                setappdata(0,'long_cordi',closest_tower(:,1)); 
                                setappdata(0,'lat_cordi',closest_tower(:,2));
                                plotted_range = range_plot(closest_tower(:,1)  ,closest_tower(:,2)  ,d_losh,handles.map,tx_height);
                                label = ['\rightarrow '  (num2str(link_con(link_num).link_name)) ' LOSH Plot', num2str(round(d_losh)) 'km'];
                                handles.plot_label1 = text(plotted_range.XData(1),plotted_range.YData(1),label, 'HorizontalAlignment','left','Color','white','FontSize',14);
                         end
                     end
                     
                     %Plot Datatips for receiver
                     h = findobj('Tag','gmap');
                     h = h(2);
                     makedatatip(h,[node_con(rx_num).node_location.longi  node_con(rx_num).node_location.lati]) 
                     %Plot Datatips for transmitter 
                     h = findobj('Tag','gmap');
                     h = h(2);
                     makedatatip(h,[closest_tower(:,1)  closest_tower(:,2)])
                     
                     %create legend
                     i_am_legend = legend(handles.map,[plotted_range],{'Link LOSH'},'Location','best');
                     title(i_am_legend,'Line of Sight to Horizon Limit')
                     
                     set(handles.range_display_text, 'String',d_losh)
                     set(handles.rx_sens_text, 'String','N/A')
                     set(handles.ber_display_text, 'String','N/A')
                     set(handles.node_display_text, 'String',link_con(link_num).link_name)
                     set(handles.path_loss_disp_text, 'String', 'N/A');
                     
                     %set(handles.techno_disp_text, 'String',node_con(nod_num).equipment_params.technology )
                     set(handles.service_disp_text, 'String','N/A' )
                     set(handles.techno_disp_text, 'String','N/A' )
                     set(handles.throughput_display_text, 'String','N/A')
                     set(handles.freq_disp_text, 'String', 'N/A');
                     set(handles.interf_disp_text, 'String', 'N/A');
                     set(handles.fade_disp_text, 'String', 'N/A');
                     
                     %Compute Throughput
             end
             
             set(handles.range_display_text, 'String',d_losh)
             
             
         case 1 %Power Limited
             
             switch node_con(tx_num).node_type
                 
                 case 'Mobile at Sea'
                     ht = 2;
                     ht_cords = [node_con(tx_num).node_location.longi  ,node_con(tx_num).node_location.lati];
                     
                 case 'Tower Mounted'
                     
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

                                ht = tower_tnt(find((ismember(tower_cords,closest_tower )),1)).AntennaHeight; %Height of Closest tower
                                ht_cords = [closest_tower(:,1)  ,closest_tower(:,2)]; 


                         end
                     end
                     
             end
                     
                     

             
             switch node_con(rx_num).node_type
                 
                 case 'Mobile at Sea'
                     hr = 2;
                     hr_cords = [node_con(rx_num).node_location.longi  ,node_con(rx_num).node_location.lati];
                     
                     
                 case 'Tower Mounted'
                     
                     if exist('towers.mat')
                         load('towers.mat')
                         
                         if exist('tower_tnt')

                             maxi = numel(tower_tnt);

                             tower_cords = zeros(maxi,2);

                             for elements = 1:maxi

                                 tower_cords(elements,:) = [tower_tnt(elements).Lon,tower_tnt(elements).Lat];

                             end
                             
                             user_cords = [node_con(rx_num).node_location.longi  ,node_con(rx_num).node_location.lati];

                                euclidean_distances = sqrt(sum(bsxfun(@minus, tower_cords, user_cords).^2,2));
                                closest_tower = tower_cords(find(euclidean_distances==min(euclidean_distances)),:);

                                hr = tower_tnt(find((ismember(tower_cords,closest_tower )),1)).AntennaHeight; %Height of Closest tower
                                hr_cords = [closest_tower(:,1)  ,closest_tower(:,2)];


                         end
                     end
                     
             end
             
             %Plot Datatips for receiver
             h = findobj('Tag','gmap');
             h = h(2);
             makedatatip(h,[hr_cords(1), hr_cords(2)]) 

             %Plot Datatips for transmitter 
             h = findobj('Tag','gmap');
             h = h(2);
             makedatatip(h,[ht_cords(1), ht_cords(2)])
             
             
             set(handles.service_disp_text, 'String', link_con(link_num).node_service.service);
             set(handles.ber_display_text, 'String',link_con(link_num).node_service.ber)
             switch link_con(link_num).node_service.ber
                 
                 case '10^-2'
                     ber_target = 10^-2;
                     
                 case '10^-3'
                     ber_target = 10^-3;
                     
                 case '10^-5' 
                     ber_target = 10^-5;
                     
                 case '10^-6' 
                     ber_target = 10^-6;
                     
                 case '6x10^-8'
                     ber_target = 6*10^-8;
                     
             end
             
              channel_type = link_con(link_num).channel.channel_type;%channel type variable from configuration

             
             %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
             switch link_con(link_num).technology 
    
                 case 'DSC'
                     Qm = 2;
                     datarate = 100; 

                     Rb = datarate ; 

                     B_noise = link_con(link_num).receiver.rx_bandwidth*10^6;
                     mod_sch = 'FSK';
                     EbN0 = EbN0_value(ber_target,mod_sch,channel_type);
                     SINR = EbN0*(Rb/B_noise);
                     SINR_db = 10*log10(SINR);
                     Nf = node_con(rx_num).equipment_params.noise_fig;
                     k = physconst('Boltzmann');
                     T = link_con(link_num).receiver.temperature;
                     Nt = k*T*B_noise;
                     Nt_db =  10*log10(Nt)+30;   
    
                 case 'LTE-A'
                     B_sys = link_con(link_num).system_params.system_bandwidth;
                     set(handles.freq_disp_text, 'String', link_con(link_num).system_params.freq);
                     
                     B_sys = num2str(B_sys);
                     switch B_sys

                         case '1.4'
                             RE_frame = 8640; %Extended CP, CFI = 3, BW = 1.4 MHz

                         case '3'
                             RE_frame = 21600; %Extended CP, CFI = 3

                         case '5'
                             RE_frame = 36000; %Extended CP, CFI = 3

                         case '10'
                             RE_frame = 72000; %Extended CP, CFI = 3

                         case '15'
                             RE_frame = 108000; %Extended CP, CFI = 3

                         case '20'
                             RE_frame = 144000; %Extended CP, CFI = 3

                     end

                     Qm = 2;
                     phy_datarate_frame = ((RE_frame*Qm)/(10*10^-3)); %SISO

                     Rb = phy_datarate_frame ; 

                     B_noise = link_con(link_num).receiver.rx_bandwidth*10^6;
                     mod_sch = 'QPSK';
                     EbN0 = EbN0_value(ber_target,mod_sch,channel_type);
                     SINR = EbN0*(Rb/B_noise);
                     SINR_db = 10*log10(SINR);
                     Nf = node_con(rx_num).equipment_params.noise_fig;
                     k = physconst('Boltzmann');
                     T = link_con(link_num).receiver.temperature;
                     Nt = k*T*B_noise;
                     Nt_db =  10*log10(Nt)+30;      
           

                 case 'NWR'
                     B_sys = link_con(link_num).system_params.system_bandwidth;
                     set(handles.freq_disp_text, 'String', link_con(link_num).system_params.freq);
                     
                     %set(handles.freq_disp_text, 'String', link_con(link_num).system_params.freq);
                     %set(handles.freq_disp_text, 'String', link_con(link_num).system_params.freq);

                     Qm = 2;
                     datarate = 520.83; 

                     Rb = 520.83; 

                     B_noise = link_con(link_num).receiver.rx_bandwidth*10^6;
                     mod_sch = 'FSK';
                     EbN0 = EbN0_value(ber_target,mod_sch,channel_type);
                     SINR = EbN0*(Rb/B_noise);
                     SINR_db = 10*log10(SINR);
                     Nf = node_con(rx_num).equipment_params.noise_fig;
                     k = physconst('Boltzmann');
                     T = link_con(link_num).receiver.temperature;
                     Nt = k*T*B_noise;
                     Nt_db =  10*log10(Nt)+30;    
   
                 case 'Generic'    
                     B_sys = link_con(link_num).system_params.system_bandwidth;
                     set(handles.freq_disp_text, 'String', link_con(link_num).system_params.freq);
                     B_sys = num2str(B_sys);
                     switch B_sys

                         case '1.4'
                             RE_frame = 8640; %Extended CP,  BW = 1.4 MHz

                         case '3'
                             RE_frame = 21600; %Extended CP 

                         case '5'
                             RE_frame = 36000; %Extended CP
                             
                         case '10'
                             RE_frame = 72000; %Extended CP 

                         case '15'
                             RE_frame = 108000; %Extended CP 

                         case '20'
                             RE_frame = 144000; %Extended CP 

                     end

                     Qm = 2;
                     phy_datarate_frame = ((RE_frame*Qm)/(10*10^-3)); %SISO
                     Rb = phy_datarate_frame;

                     B_noise = link_con(link_num).receiver.rx_bandwidth*10^6;
                     mod_sch = 'QPSK';
                     EbN0 = EbN0_value(ber_target,mod_sch,channel_type);
                     SINR = EbN0*(Rb/B_noise);
                     SINR_db = 10*log10(SINR);
                     Nf = node_con(rx_num).equipment_params.noise_fig;
                     k = physconst('Boltzmann');
                     T = link_con(link_num).receiver.temperature;
                     Nt = k*T*B_noise;
                     Nt_db =  10*log10(Nt)+30;                                
                     
             end
             

             
             %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
             If_margin = link_con(link_num).channel.interference_margin;
             set(handles.interf_disp_text, 'String', If_margin);
             fad_margin = link_con(link_num).channel.fading_margin;
             set(handles.fade_disp_text, 'String', fad_margin);
             
             Interf_Noise = Nt_db+Nf+If_margin+fad_margin;
             
             Pr_min = SINR_db + Interf_Noise;
             
             set(handles.rx_sens_text, 'String',Pr_min)
             set(handles.ber_display_text, 'String',link_con(link_num).node_service.ber) 
             set(handles.node_display_text, 'String',link_con(link_num).link_name) 
             
%              fad_margin = link_con(link_num).channel.fading_margin;
%              set(handles.fade_disp_text, 'String', fad_margin);
                          

             Ptx = node_con(tx_num).equipment_params.tx_pwr;
%              Prx = node_con(rx_num).equipment_params.rx_pwr;
%              setappdata(0,'prx_display',Prx)
             G_ant = node_con(tx_num).equipment_params.tx_ant_gain + node_con(rx_num).equipment_params.rx_ant_gain;
             Cable_losses = node_con(tx_num).equipment_params.tx_cable_loss + node_con(rx_num).equipment_params.rx_cable_loss;
             
             PL_target = Ptx + G_ant - Cable_losses - Pr_min;
             
             freq = link_con(link_num).system_params.freq;

               switch link_con(link_num).channel.path_loss_model
                   
                   case 'FSPL'
                       set(handles.path_loss_disp_text, 'String', link_con(link_num).channel.path_loss_model);
                       %Path_Loss = Ptx + G_ant - Cable_losses - Prx;
                       
                       plim_distance = 10^((PL_target-20*log10(freq)-32.44)/20);
                       
%                        plotted_range = range_plot(ht_cords(1), ht_cords(2)  ,plim_distance,handles.map);
                       
                   case '2-Ray'
                       set(handles.path_loss_disp_text, 'String', link_con(link_num).channel.path_loss_model);

                       plim_distance =two_ray(PL_target, ht, hr, freq)*10^-3;
                       
%                        plotted_range = range_plot(ht_cords(1), ht_cords(2)  ,plim_distance,handles.map);                       
        

        
                   case '3-Ray'
                       set(handles.path_loss_disp_text, 'String', link_con(link_num).channel.path_loss_model);
                       
                       plim_distance =three_ray(PL_target, ht, hr, freq)*10^-3;
                       
%                        plotted_range = range_plot(ht_cords(1), ht_cords(2)  ,plim_distance,handles.map);       


                   case 'Sea Radio-Wave Propagation Loss'
                       set(handles.path_loss_disp_text, 'String', link_con(link_num).channel.path_loss_model);
                       
                       plim_distance = srwpl(PL_target, ht, hr, freq)*10^-3;
        
%                        plotted_range = range_plot(ht_cords(1), ht_cords(2)  ,plim_distance,handles.map);
               end
               
               set(handles.range_display_text, 'String',plim_distance) 
               set(handles.techno_disp_text, 'String',link_con(link_num).technology ) 
               
                switch link_con(link_num).technology 

                    case 'DSC'
                         Qm = 2;
                         datarate = 100; 

                         Rb = datarate ; 

                         mod_sch = 'FSK';
                         EbN0 = EbN0_value(ber_target,mod_sch,channel_type);
                         SINR = EbN0*(Rb/B_noise);
                         SINR_db = 10*log10(SINR);
                         Pr_min = SINR_db + Interf_Noise;
                         PL_target = Ptx + G_ant - Cable_losses - Pr_min;
                         x = ht_cords(1);  
                         y = ht_cords(2);
                         
                         dsc_throughput = 100; %bps
                         set(handles.throughput_display_text, 'String',(dsc_throughput*10^-6)) 

                         switch link_con(link_num).channel.path_loss_model

                                     case 'FSPL'

                                         tput_distance = 10^((PL_target-20*log10(freq)-32.44)/20);

                                         colour = 'b';
                                         handles.tput_plot1 = tput_plot(x,y,tput_distance ,handles.map,colour);
                                         txt1 = [ num2str(dsc_throughput) ' bps' ' (FSK) ' num2str(round(tput_distance)) 'km']; 
                                         i_am_legend = legend(handles.map,[handles.tput_plot1],{txt1},'Location','best');
                                         title(i_am_legend,'DSC Throuput per Mod. Sch.') 
                                         
                                         set(handles.range_display_text, 'String',tput_distance)
                                         
                                         label = ['\rightarrow'  (num2str(link_con(link_num).link_name)) ' P. Lim. Plot'];
                                         handles.plot_label1 = text(handles.tput_plot1.XData(1),handles.tput_plot1.YData(1),label, 'HorizontalAlignment','left','Color','white','FontSize',14);


                                     case '2-Ray'

                                         tput_distance = two_ray(PL_target, ht, hr, freq);
                                         tput_distance = tput_distance*10^-3;

                                         colour = 'b';
                                         handles.tput_plot1 = tput_plot(x,y,tput_distance ,handles.map,colour);
                                         txt1 = [ num2str(dsc_throughput) ' bps' ' (FSK) ' num2str(round(tput_distance)) 'km']; 
                                         i_am_legend = legend(handles.map,[handles.tput_plot1],{txt1},'Location','best')
                                         title(i_am_legend,'DSC Throuput per Mod. Sch.') 
                                         
                                         set(handles.range_display_text, 'String',tput_distance)
                                         
                                         label = ['\rightarrow'  (num2str(link_con(link_num).link_name)) ' P. Lim. Plot'];
                                         handles.plot_label1 = text(handles.tput_plot1.XData(1),handles.tput_plot1.YData(1),label, 'HorizontalAlignment','left','Color','white','FontSize',14);


                                     case '3-Ray'
                                         tput_distance = three_ray(PL_target, ht, hr, freq);
                                         tput_distance = tput_distance*10^-3;                 

                                         colour = 'b';
                                         handles.tput_plot1 = tput_plot(x,y,tput_distance ,handles.map,colour);
                                         txt1 = [ num2str(dsc_throughput) ' bps' ' (FSK) ' num2str(round(tput_distance)) 'km']; 
                                         i_am_legend = legend(handles.map,[handles.tput_plot1],{txt1},'Location','best')
                                         title(i_am_legend,'DSC Throuput per Mod. Sch.') 
                                         
                                         set(handles.range_display_text, 'String',tput_distance)
                                         
                                         label = ['\rightarrow'  (num2str(link_con(link_num).link_name)) ' P. Lim. Plot'];
                                         handles.plot_label1 = text(handles.tput_plot1.XData(1),handles.tput_plot1.YData(1),label, 'HorizontalAlignment','left','Color','white','FontSize',14);


                                     case 'Sea Radio-Wave Propagation Loss'
                                         tput_distance = srwpl(PL_target, ht, hr, freq);
                                         tput_distance = tput_distance*10^-3;                 

                                         colour = 'b';
                                         handles.tput_plot1 = tput_plot(x,y,tput_distance ,handles.map,colour);
                                         txt1 = [ num2str(dsc_throughput) ' bps' ' (FSK) ' num2str(round(tput_distance)) 'km']; 
                                         i_am_legend = legend(handles.map,[handles.tput_plot1],{txt1},'Location','best')
                                         title(i_am_legend,'DSC Throuput per Mod. Sch.') 
                                         
                                         set(handles.range_display_text, 'String',tput_distance)
                                         
                                         label = ['\rightarrow'  (num2str(link_con(link_num).link_name)) ' P. Lim. Plot'];
                                         handles.plot_label1 = text(handles.tput_plot1.XData(1),handles.tput_plot1.YData(1),label, 'HorizontalAlignment','left','Color','white','FontSize',14);

                         end



                     case 'LTE-A'
                         
                         B_sys = link_con(link_num).system_params.system_bandwidth;
                         B_sys = num2str(B_sys);
                         switch B_sys


                             case '1.4'
                                 PDSCH_RE_frame = 4912; %Extended CP, CFI = 3, BW = 1.4 MHz

                             case '3'
                                 PDSCH_RE_frame = 14812; %Extended CP, CFI = 3

                             case '5'
                                 PDSCH_RE_frame = 25012; %Extended CP, CFI = 3

                             case '10'
                                 PDSCH_RE_frame = 50512; %Extended CP, CFI = 3

                             case '15'
                                 PDSCH_RE_frame = 76012; %Extended CP, CFI = 3

                             case '20'
                                 PDSCH_RE_frame = 101512; %Extended CP, CFI = 3
                         end
                         


                         switch link_con(link_num).node_service.ber

                             case '10^-3'
                                 Qm = [1,1,2,2,4,4,6,6,6,6];
                                 code = ["1/2","3/4","1/2","3/4","1/2","3/4","1/2","2/3","3/4","5/6"];
                                 %Rb = ((RE_frame*Qm)/(10*10^-3)); 
                                 %EbN0 = [EbN0_value(ber_target,'QPSK',channel_type),EbN0_value(ber_target,'16QAM',channel_type),EbN0_value(ber_target,'64QAM',channel_type)];

                                 %SINR = EbN0.*(Rb/B_noise);         
                                 %SINR_db = 10*log10(SINR); 
                                 code_rate = [1/2,3/4,1/2,3/4,1/2,3/4,1/2,2/3,3/4,5/6];
                                 phy_tput_frame = ((((PDSCH_RE_frame*Qm)/(10*10^-3))).*code_rate)/10^6; %Mbps
                                 phy_tput_frame  = round(phy_tput_frame,2);
                                 set(handles.throughput_display_text, 'String',phy_tput_frame(1))
                                 
                                 
                                 switch channel_type
                                     
                                     case 'AWGN'
                                         SINR_db = [0,3.3,3,6.3,9.5,13,13.7,16.9,17.7,18.5];
                                     case 'Rayleigh'
                                         SINR_db = [14.54,19.16,17.54,22.16,23.6,28.5,26.36,30.84,31.96,33.08];                                       
                                 end
                                 
                                 Pr_min = SINR_db + Interf_Noise;        
                                 PL_target = Ptx + G_ant - Cable_losses - Pr_min;                
                                 x = ht_cords(1);          
                                 y = ht_cords(2);

                                 switch link_con(link_num).channel.path_loss_model

                                     case 'FSPL'

                                         tput_distance = 10.^((PL_target-20*log10(freq)-32.44)/20);
                                         
                                         set(handles.range_display_text, 'String',tput_distance(1)) 
%                                          
                                         colour = 'y'; 
                                         %BPSK 1/2                                 
                                         handles.tput_plot1 = tput_plot(x,y,tput_distance(1) ,handles.map,colour);
                                         txt1 = [ num2str(phy_tput_frame(1)) ' Mbps' ' (BPSK 1/2) ' num2str(round(tput_distance(1))) 'km']; 
                                         
                                         label = ['\rightarrow'  (num2str(link_con(link_num).link_name)) ' P. Lim. Plot'];
                                         handles.plot_label1 = text(handles.tput_plot1.XData(1),handles.tput_plot1.YData(1),label, 'HorizontalAlignment','left','Color','white','FontSize',14);
                                         
                                         
                                         colour = [216/255 133/255 49/255]; 
                                         %BPSK 3/4 
                                         handles.tput_plot2 = tput_plot(x,y,tput_distance(2) ,handles.map,colour);
                                         txt2 = [num2str(phy_tput_frame(2)) ' Mbps' ' (BPSK 3/4) ' num2str(round(tput_distance(2))) 'km'];

                                         colour = [7/255 164/255 18/255]; 
                                         %QPSK 1/2             
                                         handles.tput_plot3= tput_plot(x,y,tput_distance(3) ,handles.map,colour);
                                         txt3 = [num2str(phy_tput_frame(3)) ' Mbps' ' (QPSK 1/2) ' num2str(round(tput_distance(3))) 'km'];

                                         colour = [116/255 11/255 128/255]; 
                                         %QPSK 3/4                                 
                                         handles.tput_plot4 = tput_plot(x,y,tput_distance(4) ,handles.map,colour);
                                         txt4 = [num2str(phy_tput_frame(4)) ' Mbps' ' (QPSK 3/4) ' num2str(round(tput_distance(4))) 'km'];

                                         colour = 'c'; 
                                         %16QAM 1/2  
                                         handles.tput_plot5 = tput_plot(x,y,tput_distance(5) ,handles.map,colour);
                                         txt5 = [num2str(phy_tput_frame(5)) ' Mbps' ' (16QAM 1/2) ' num2str(round(tput_distance(5))) 'km'];

                                         colour = 'b'; 
                                         %16QAM 3/4               
                                         handles.tput_plot6= tput_plot(x,y,tput_distance(6) ,handles.map,colour);
                                         txt6 = [num2str(phy_tput_frame(6)) ' Mbps' ' (16QAM 3/4) ' num2str(round(tput_distance(6))) 'km'];

                                         colour = 'm'; 
                                         %64QAM 1/2                                 
                                         handles.tput_plot7 = tput_plot(x,y,tput_distance(7) ,handles.map,colour); 
                                         txt7 = [num2str(phy_tput_frame(7)) ' Mbps' ' (64QAM 1/2) ' num2str(round(tput_distance(7))) 'km'];

                                         colour = 'g';
                                         %64QAM 2/3 
                                         handles.tput_plot8 = tput_plot(x,y,tput_distance(8) ,handles.map,colour);
                                         txt8 = [num2str(phy_tput_frame(8)) ' Mbps' ' (64QAM 2/3) ' num2str(round(tput_distance(8))) 'km'];

                                         colour = [243/255 197/255 91/255]; 
                                         %64QAM 3/4                 
                                         handles.tput_plot9= tput_plot(x,y,tput_distance(9) ,handles.map,colour);
                                         txt9 = [num2str(phy_tput_frame(9)) ' Mbps' ' (64QAM 3/4) ' num2str(round(tput_distance(9))) 'km'];

                                         colour = [127/255 0/255 255/255];
                                         %64QAM 5/6                 
                                         handles.tput_plot10= tput_plot(x,y,tput_distance(10) ,handles.map,colour);
                                         txt10 = [num2str(phy_tput_frame(10)) ' Mbps' ' (64QAM 5/6) '  num2str(round(tput_distance(10))) 'km'];
                                     
%                                          i_am_legend = legend(handles.map,[plotted_range,handles.tput_plot1,handles.tput_plot2,handles.tput_plot3,handles.tput_plot4,handles.tput_plot5,handles.tput_plot6,handles.tput_plot7,handles.tput_plot8,handles.tput_plot9,handles.tput_plot10],{'Power Limited Range','BPSK 1/2','BPSK 3/4','QPSK 1/2','QPSK 3/4','16QAM 1/2','16QAM 3/4','64QAM 1/2','64QAM 2/3','64QAM 3/4','64QAM 5/6'})
                                         %i_am_legend = legend(handles.map,[handles.tput_plot1,handles.tput_plot2,handles.tput_plot3,handles.tput_plot4,handles.tput_plot5,handles.tput_plot6,handles.tput_plot7,handles.tput_plot8,handles.tput_plot9,handles.tput_plot10],{'BPSK 1/2','BPSK 3/4','QPSK 1/2','QPSK 3/4','16QAM 1/2','16QAM 3/4','64QAM 1/2','64QAM 2/3','64QAM 3/4','64QAM 5/6'})
                                         i_am_legend = legend(handles.map,[handles.tput_plot1,handles.tput_plot2,handles.tput_plot3,handles.tput_plot4,handles.tput_plot5,handles.tput_plot6,handles.tput_plot7,handles.tput_plot8,handles.tput_plot9,handles.tput_plot10],{txt1,txt2,txt3,txt4,txt5,txt6,txt7,txt8,txt9,txt10},'Location','best')
                                         title(i_am_legend,'LTE Max. PHY Throuput per MCS')

                                     case '2-Ray'

                                         tput_distance = [two_ray(PL_target(1), ht, hr, freq),two_ray(PL_target(2), ht, hr, freq),two_ray(PL_target(3), ht, hr, freq),two_ray(PL_target(4), ht, hr, freq),two_ray(PL_target(5), ht, hr, freq),two_ray(PL_target(6), ht, hr, freq),two_ray(PL_target(7), ht, hr, freq),two_ray(PL_target(8), ht, hr, freq),two_ray(PL_target(9), ht, hr, freq),two_ray(PL_target(10), ht, hr, freq)];
                                         tput_distance = tput_distance*10^-3;

                                         set(handles.range_display_text, 'String',tput_distance(1)) 
                                          
                                         colour = 'y'; 
                                         %BPSK 1/2                                 
                                         handles.tput_plot1 = tput_plot(x,y,tput_distance(1) ,handles.map,colour);
                                         txt1 = [ num2str(phy_tput_frame(1)) ' Mbps' ' (BPSK 1/2)' ' ' num2str(round(tput_distance(1))) 'km']; 
                                         
                                         label = ['\rightarrow'  (num2str(link_con(link_num).link_name)) ' P. Lim. Plot'];
                                         handles.plot_label1 = text(handles.tput_plot1.XData(1),handles.tput_plot1.YData(1),label, 'HorizontalAlignment','left','Color','white','FontSize',14);
                                         
                                         colour = [216/255 133/255 49/255]; 
                                         %BPSK 3/4 
                                         handles.tput_plot2 = tput_plot(x,y,tput_distance(2) ,handles.map,colour);
                                         txt2 = [num2str(phy_tput_frame(2)) ' Mbps' ' (BPSK 3/4)' ' ' num2str(round(tput_distance(2))) 'km'];

                                         colour = [7/255 164/255 18/255]; 
                                         %QPSK 1/2             
                                         handles.tput_plot3= tput_plot(x,y,tput_distance(3) ,handles.map,colour);
                                         txt3 = [num2str(phy_tput_frame(3)) ' Mbps' ' (QPSK 1/2)' ' ' num2str(round(tput_distance(3))) 'km'];

                                         colour = [116/255 11/255 128/255]; 
                                         %QPSK 3/4                                 
                                         handles.tput_plot4 = tput_plot(x,y,tput_distance(4) ,handles.map,colour);
                                         txt4 = [num2str(phy_tput_frame(4)) ' Mbps' ' (QPSK 3/4)' ' ' num2str(round(tput_distance(4))) 'km'];

                                         colour = 'c'; 
                                         %16QAM 1/2  
                                         handles.tput_plot5 = tput_plot(x,y,tput_distance(5) ,handles.map,colour);
                                         txt5 = [num2str(phy_tput_frame(5)) ' Mbps' ' (16QAM 1/2)' ' ' num2str(round(tput_distance(5))) 'km'];

                                         colour = 'b'; 
                                         %16QAM 3/4               
                                         handles.tput_plot6= tput_plot(x,y,tput_distance(6) ,handles.map,colour);
                                         txt6 = [num2str(phy_tput_frame(6)) ' Mbps' ' (16QAM 3/4)' ' ' num2str(round(tput_distance(6))) 'km'];

                                         colour = 'm'; 
                                         %64QAM 1/2                                 
                                         handles.tput_plot7 = tput_plot(x,y,tput_distance(7) ,handles.map,colour); 
                                         txt7 = [num2str(phy_tput_frame(7)) ' Mbps' ' (64QAM 1/2)' ' ' num2str(round(tput_distance(7))) 'km'];

                                         colour = 'g';
                                         %64QAM 2/3 
                                         handles.tput_plot8 = tput_plot(x,y,tput_distance(8) ,handles.map,colour);
                                         txt8 = [num2str(phy_tput_frame(8)) ' Mbps' ' (64QAM 2/3)' ' ' num2str(round(tput_distance(8))) 'km'];

                                         colour = [243/255 197/255 91/255]; 
                                         %64QAM 3/4                 
                                         handles.tput_plot9= tput_plot(x,y,tput_distance(9) ,handles.map,colour);
                                         txt9 = [num2str(phy_tput_frame(9)) ' Mbps' ' (64QAM 3/4)' ' ' num2str(round(tput_distance(9))) 'km'];

                                         colour = [127/255 0/255 255/255];
                                         %64QAM 5/6                 
                                         handles.tput_plot10= tput_plot(x,y,tput_distance(10) ,handles.map,colour);
                                         txt10 = [num2str(phy_tput_frame(10)) ' Mbps' ' (64QAM 5/6)' ' ' num2str(round(tput_distance(10))) 'km'];
                                     
                                         i_am_legend = legend(handles.map,[handles.tput_plot1,handles.tput_plot2,handles.tput_plot3,handles.tput_plot4,handles.tput_plot5,handles.tput_plot6,handles.tput_plot7,handles.tput_plot8,handles.tput_plot9,handles.tput_plot10],{txt1,txt2,txt3,txt4,txt5,txt6,txt7,txt8,txt9,txt10},'Location','best')
                                         title(i_am_legend,'LTE Max. PHY Throuput per MCS')                                         

                                     case '3-Ray'
                                         tput_distance = [three_ray(PL_target(1), ht, hr, freq),three_ray(PL_target(2), ht, hr, freq),three_ray(PL_target(3), ht, hr, freq),three_ray(PL_target(4), ht, hr, freq),three_ray(PL_target(5), ht, hr, freq),three_ray(PL_target(6), ht, hr, freq),three_ray(PL_target(7), ht, hr, freq),three_ray(PL_target(8), ht, hr, freq),three_ray(PL_target(9), ht, hr, freq),three_ray(PL_target(10), ht, hr, freq)];
                                         tput_distance = tput_distance*10^-3;                 

                                         set(handles.range_display_text, 'String',tput_distance(1)) 
                                         
                                         colour = 'y'; 
                                         %BPSK 1/2                                 
                                         handles.tput_plot1 = tput_plot(x,y,tput_distance(1) ,handles.map,colour);
                                         txt1 = [ num2str(phy_tput_frame(1)) ' Mbps' ' (BPSK 1/2)' ' ' num2str(round(tput_distance(1))) 'km'];
                                         
                                         label = ['\rightarrow'  (num2str(link_con(link_num).link_name)) ' P. Lim. Plot'];
                                         handles.plot_label1 = text(handles.tput_plot1.XData(1),handles.tput_plot1.YData(1),label, 'HorizontalAlignment','left','Color','white','FontSize',14);
                                         
                                         colour = [216/255 133/255 49/255]; 
                                         %BPSK 3/4 
                                         handles.tput_plot2 = tput_plot(x,y,tput_distance(2) ,handles.map,colour);
                                         txt2 = [num2str(phy_tput_frame(2)) ' Mbps' ' (BPSK 3/4)' ' ' num2str(round(tput_distance(2))) 'km'];

                                         colour = [7/255 164/255 18/255]; 
                                         %QPSK 1/2             
                                         handles.tput_plot3= tput_plot(x,y,tput_distance(3) ,handles.map,colour);
                                         txt3 = [num2str(phy_tput_frame(3)) ' Mbps' ' (QPSK 1/2)' ' ' num2str(round(tput_distance(3))) 'km'];

                                         colour = [116/255 11/255 128/255]; 
                                         %QPSK 3/4                                 
                                         handles.tput_plot4 = tput_plot(x,y,tput_distance(4) ,handles.map,colour);
                                         txt4 = [num2str(phy_tput_frame(4)) ' Mbps' ' (QPSK 3/4)' ' ' num2str(round(tput_distance(4))) 'km'];

                                         colour = 'c'; 
                                         %16QAM 1/2  
                                         handles.tput_plot5 = tput_plot(x,y,tput_distance(5) ,handles.map,colour);
                                         txt5 = [num2str(phy_tput_frame(5)) ' Mbps' ' (16QAM 1/2)' ' ' num2str(round(tput_distance(5))) 'km'];

                                         colour = 'b'; 
                                         %16QAM 3/4               
                                         handles.tput_plot6= tput_plot(x,y,tput_distance(6) ,handles.map,colour);
                                         txt6 = [num2str(phy_tput_frame(6)) ' Mbps' ' (16QAM 3/4)' ' ' num2str(round(tput_distance(6))) 'km'];

                                         colour = 'm'; 
                                         %64QAM 1/2                                 
                                         handles.tput_plot7 = tput_plot(x,y,tput_distance(7) ,handles.map,colour); 
                                         txt7 = [num2str(phy_tput_frame(7)) ' Mbps' ' (64QAM 1/2)' ' ' num2str(round(tput_distance(7))) 'km'];

                                         colour = 'g';
                                         %64QAM 2/3 
                                         handles.tput_plot8 = tput_plot(x,y,tput_distance(8) ,handles.map,colour);
                                         txt8 = [num2str(phy_tput_frame(8)) ' Mbps' ' (64QAM 2/3)' ' ' num2str(round(tput_distance(8))) 'km'];

                                         colour = [243/255 197/255 91/255]; 
                                         %64QAM 3/4                 
                                         handles.tput_plot9= tput_plot(x,y,tput_distance(9) ,handles.map,colour);
                                         txt9 = [num2str(phy_tput_frame(9)) ' Mbps' ' (64QAM 3/4)' ' ' num2str(round(tput_distance(9))) 'km'];

                                         colour = [127/255 0/255 255/255];
                                         %64QAM 5/6                 
                                         handles.tput_plot10= tput_plot(x,y,tput_distance(10) ,handles.map,colour);
                                         txt10 = [num2str(phy_tput_frame(10)) ' Mbps' ' (64QAM 5/6)' ' ' num2str(round(tput_distance(10))) 'km'];
                                     
                                         i_am_legend = legend(handles.map,[handles.tput_plot1,handles.tput_plot2,handles.tput_plot3,handles.tput_plot4,handles.tput_plot5,handles.tput_plot6,handles.tput_plot7,handles.tput_plot8,handles.tput_plot9,handles.tput_plot10],{txt1,txt2,txt3,txt4,txt5,txt6,txt7,txt8,txt9,txt10},'Location','best')
                                         title(i_am_legend,'LTE Max. PHY Throuput per MCS')                                         

                                     case 'Sea Radio-Wave Propagation Loss'
                                         tput_distance = [srwpl(PL_target(1), ht, hr, freq),srwpl(PL_target(2), ht, hr, freq),srwpl(PL_target(3), ht, hr, freq),srwpl(PL_target(4), ht, hr, freq),srwpl(PL_target(5), ht, hr, freq),srwpl(PL_target(6), ht, hr, freq),srwpl(PL_target(7), ht, hr, freq),srwpl(PL_target(8), ht, hr, freq),srwpl(PL_target(9), ht, hr, freq),srwpl(PL_target(10), ht, hr, freq)];
                                         tput_distance = tput_distance*10^-3;                 

                                         set(handles.range_display_text, 'String',tput_distance(1)) 
                                         
                                         colour = 'y'; 
                                         %BPSK 1/2                                 
                                         handles.tput_plot1 = tput_plot(x,y,tput_distance(1) ,handles.map,colour);
                                         txt1 = [ num2str(phy_tput_frame(1)) ' Mbps' ' (BPSK 1/2)' ' ' num2str(round(tput_distance(1))) 'km']; 
                                         
                                         label = ['\rightarrow'  (num2str(link_con(link_num).link_name)) ' P. Lim. Plot'];
                                         handles.plot_label1 = text(handles.tput_plot1.XData(1),handles.tput_plot1.YData(1),label, 'HorizontalAlignment','left','Color','white','FontSize',14);
                                         
                                         colour = [216/255 133/255 49/255]; 
                                         %BPSK 3/4 
                                         handles.tput_plot2 = tput_plot(x,y,tput_distance(2) ,handles.map,colour);
                                         txt2 = [num2str(phy_tput_frame(2)) ' Mbps' ' (BPSK 3/4)' ' ' num2str(round(tput_distance(2))) 'km'];

                                         colour = [7/255 164/255 18/255]; 
                                         %QPSK 1/2             
                                         handles.tput_plot3= tput_plot(x,y,tput_distance(3) ,handles.map,colour);
                                         txt3 = [num2str(phy_tput_frame(3)) ' Mbps' ' (QPSK 1/2)' ' ' num2str(round(tput_distance(3))) 'km'];

                                         colour = [116/255 11/255 128/255]; 
                                         %QPSK 3/4                                 
                                         handles.tput_plot4 = tput_plot(x,y,tput_distance(4) ,handles.map,colour);
                                         txt4 = [num2str(phy_tput_frame(4)) ' Mbps' ' (QPSK 3/4)' ' ' num2str(round(tput_distance(4))) 'km'];

                                         colour = 'c'; 
                                         %16QAM 1/2  
                                         handles.tput_plot5 = tput_plot(x,y,tput_distance(5) ,handles.map,colour);
                                         txt5 = [num2str(phy_tput_frame(5)) ' Mbps' ' (16QAM 1/2)' ' ' num2str(round(tput_distance(5))) 'km'];

                                         colour = 'b'; 
                                         %16QAM 3/4               
                                         handles.tput_plot6= tput_plot(x,y,tput_distance(6) ,handles.map,colour);
                                         txt6 = [num2str(phy_tput_frame(6)) ' Mbps' ' (16QAM 3/4)' ' ' num2str(round(tput_distance(6))) 'km'];

                                         colour = 'm'; 
                                         %64QAM 1/2                                 
                                         handles.tput_plot7 = tput_plot(x,y,tput_distance(7) ,handles.map,colour); 
                                         txt7 = [num2str(phy_tput_frame(7)) ' Mbps' ' (64QAM 1/2)' ' ' num2str(round(tput_distance(7))) 'km'];

                                         colour = 'g';
                                         %64QAM 2/3 
                                         handles.tput_plot8 = tput_plot(x,y,tput_distance(8) ,handles.map,colour);
                                         txt8 = [num2str(phy_tput_frame(8)) ' Mbps' ' (64QAM 2/3)' ' ' num2str(round(tput_distance(8))) 'km'];

                                         colour = [243/255 197/255 91/255]; 
                                         %64QAM 3/4                 
                                         handles.tput_plot9= tput_plot(x,y,tput_distance(9) ,handles.map,colour);
                                         txt9 = [num2str(phy_tput_frame(9)) ' Mbps' ' (64QAM 3/4)' ' ' num2str(round(tput_distance(9))) 'km'];

                                         colour = [127/255 0/255 255/255];
                                         %64QAM 5/6                 
                                         handles.tput_plot10= tput_plot(x,y,tput_distance(10) ,handles.map,colour);
                                         txt10 = [num2str(phy_tput_frame(10)) ' Mbps' ' (64QAM 5/6)' ' ' num2str(round(tput_distance(10))) 'km'];
                                     
                                         i_am_legend = legend(handles.map,[handles.tput_plot1,handles.tput_plot2,handles.tput_plot3,handles.tput_plot4,handles.tput_plot5,handles.tput_plot6,handles.tput_plot7,handles.tput_plot8,handles.tput_plot9,handles.tput_plot10],{txt1,txt2,txt3,txt4,txt5,txt6,txt7,txt8,txt9,txt10},'Location','best')
                                         title(i_am_legend,'LTE Max. PHY Throuput per MCS')                                         
                                 end 
                                 
                             case '10^-6'
                                 Qm = [1,1,2,2,4,4,6,6,6,6];
                                 code = ["1/2","3/4","1/2","3/4","1/2","3/4","1/2","2/3","3/4","5/6"];
                                 %Rb = ((RE_frame*Qm)/(10*10^-3)); 
                                 %EbN0 = [EbN0_value(ber_target,'QPSK',channel_type),EbN0_value(ber_target,'16QAM',channel_type),EbN0_value(ber_target,'64QAM',channel_type)];

                                 %SINR = EbN0.*(Rb/B_noise);         
                                 %SINR_db = 10*log10(SINR); 
                                 code_rate = [1/2,3/4,1/2,3/4,1/2,3/4,1/2,2/3,3/4,5/6];
                                 phy_tput_frame = ((((PDSCH_RE_frame*Qm)/(10*10^-3))).*code_rate)/10^6; %Mbps
                                 phy_tput_frame  = round(phy_tput_frame,2);
                                 set(handles.throughput_display_text, 'String',phy_tput_frame(1))
                                 
                                 
                                 switch channel_type
                                     
                                     case 'AWGN'
                                         SINR_db = [1.5,5.7,4.5,8.7,12.5,15.4,16.1,19.3,20.1,20.9];
                                     case 'Rayleigh'
                                         SINR_db = [35,43.4,38,46.4,46,51.8,46.6,53,54.6,56.2];                                       
                                 end
                                 
                                 Pr_min = SINR_db + Interf_Noise;        
                                 PL_target = Ptx + G_ant - Cable_losses - Pr_min;                
                                 x = ht_cords(1);          
                                 y = ht_cords(2);

                                 switch link_con(link_num).channel.path_loss_model

                                     case 'FSPL'

                                         tput_distance = 10.^((PL_target-20*log10(freq)-32.44)/20);
                                         
                                         set(handles.range_display_text, 'String',tput_distance(1)) 
%                                          
                                         colour = 'y'; 
                                         %BPSK 1/2                                 
                                         handles.tput_plot1 = tput_plot(x,y,tput_distance(1) ,handles.map,colour);
                                         txt1 = [ num2str(phy_tput_frame(1)) ' Mbps' ' (BPSK 1/2)' ' ' num2str(round(tput_distance(1))) 'km']; 
                                         
                                         label = ['\rightarrow'  (num2str(link_con(link_num).link_name)) ' P. Lim. Plot'];
                                         handles.plot_label1 = text(handles.tput_plot1.XData(1),handles.tput_plot1.YData(1),label, 'HorizontalAlignment','left','Color','white','FontSize',14);
                                         
                                         
                                         colour = [216/255 133/255 49/255]; 
                                         %BPSK 3/4 
                                         handles.tput_plot2 = tput_plot(x,y,tput_distance(2) ,handles.map,colour);
                                         txt2 = [num2str(phy_tput_frame(2)) ' Mbps' ' (BPSK 3/4)' ' ' num2str(round(tput_distance(2))) 'km'];

                                         colour = [7/255 164/255 18/255]; 
                                         %QPSK 1/2             
                                         handles.tput_plot3= tput_plot(x,y,tput_distance(3) ,handles.map,colour);
                                         txt3 = [num2str(phy_tput_frame(3)) ' Mbps' ' (QPSK 1/2)' ' ' num2str(round(tput_distance(3))) 'km'];

                                         colour = [116/255 11/255 128/255]; 
                                         %QPSK 3/4                                 
                                         handles.tput_plot4 = tput_plot(x,y,tput_distance(4) ,handles.map,colour);
                                         txt4 = [num2str(phy_tput_frame(4)) ' Mbps' ' (QPSK 3/4)' ' ' num2str(round(tput_distance(4))) 'km'];

                                         colour = 'c'; 
                                         %16QAM 1/2  
                                         handles.tput_plot5 = tput_plot(x,y,tput_distance(5) ,handles.map,colour);
                                         txt5 = [num2str(phy_tput_frame(5)) ' Mbps' ' (16QAM 1/2)' ' ' num2str(round(tput_distance(5))) 'km'];

                                         colour = 'b'; 
                                         %16QAM 3/4               
                                         handles.tput_plot6= tput_plot(x,y,tput_distance(6) ,handles.map,colour);
                                         txt6 = [num2str(phy_tput_frame(6)) ' Mbps' ' (16QAM 3/4)' ' ' num2str(round(tput_distance(6))) 'km'];

                                         colour = 'm'; 
                                         %64QAM 1/2                                 
                                         handles.tput_plot7 = tput_plot(x,y,tput_distance(7) ,handles.map,colour); 
                                         txt7 = [num2str(phy_tput_frame(7)) ' Mbps' ' (64QAM 1/2)' ' ' num2str(round(tput_distance(7))) 'km'];

                                         colour = 'g';
                                         %64QAM 2/3 
                                         handles.tput_plot8 = tput_plot(x,y,tput_distance(8) ,handles.map,colour);
                                         txt8 = [num2str(phy_tput_frame(8)) ' Mbps' ' (64QAM 2/3)' ' ' num2str(round(tput_distance(8))) 'km'];

                                         colour = [243/255 197/255 91/255]; 
                                         %64QAM 3/4                 
                                         handles.tput_plot9= tput_plot(x,y,tput_distance(9) ,handles.map,colour);
                                         txt9 = [num2str(phy_tput_frame(9)) ' Mbps' ' (64QAM 3/4)' ' ' num2str(round(tput_distance(9))) 'km'];

                                         colour = [127/255 0/255 255/255];
                                         %64QAM 5/6                 
                                         handles.tput_plot10= tput_plot(x,y,tput_distance(10) ,handles.map,colour);
                                         txt10 = [num2str(phy_tput_frame(10)) ' Mbps' ' (64QAM 5/6)' ' ' num2str(round(tput_distance(10))) 'km'];
                                     
%                                          i_am_legend = legend(handles.map,[plotted_range,handles.tput_plot1,handles.tput_plot2,handles.tput_plot3,handles.tput_plot4,handles.tput_plot5,handles.tput_plot6,handles.tput_plot7,handles.tput_plot8,handles.tput_plot9,handles.tput_plot10],{'Power Limited Range','BPSK 1/2','BPSK 3/4','QPSK 1/2','QPSK 3/4','16QAM 1/2','16QAM 3/4','64QAM 1/2','64QAM 2/3','64QAM 3/4','64QAM 5/6'})
                                         %i_am_legend = legend(handles.map,[handles.tput_plot1,handles.tput_plot2,handles.tput_plot3,handles.tput_plot4,handles.tput_plot5,handles.tput_plot6,handles.tput_plot7,handles.tput_plot8,handles.tput_plot9,handles.tput_plot10],{'BPSK 1/2','BPSK 3/4','QPSK 1/2','QPSK 3/4','16QAM 1/2','16QAM 3/4','64QAM 1/2','64QAM 2/3','64QAM 3/4','64QAM 5/6'})
                                         i_am_legend = legend(handles.map,[handles.tput_plot1,handles.tput_plot2,handles.tput_plot3,handles.tput_plot4,handles.tput_plot5,handles.tput_plot6,handles.tput_plot7,handles.tput_plot8,handles.tput_plot9,handles.tput_plot10],{txt1,txt2,txt3,txt4,txt5,txt6,txt7,txt8,txt9,txt10},'Location','best');
                                         title(i_am_legend,'LTE Max. PHY Throuput per MCS')

                                     case '2-Ray'

                                         tput_distance = [two_ray(PL_target(1), ht, hr, freq),two_ray(PL_target(2), ht, hr, freq),two_ray(PL_target(3), ht, hr, freq),two_ray(PL_target(4), ht, hr, freq),two_ray(PL_target(5), ht, hr, freq),two_ray(PL_target(6), ht, hr, freq),two_ray(PL_target(7), ht, hr, freq),two_ray(PL_target(8), ht, hr, freq),two_ray(PL_target(9), ht, hr, freq),two_ray(PL_target(10), ht, hr, freq)];
                                         tput_distance = tput_distance*10^-3;

                                         set(handles.range_display_text, 'String',tput_distance(1)) 
                                          
                                         colour = 'y'; 
                                         %BPSK 1/2                                 
                                         handles.tput_plot1 = tput_plot(x,y,tput_distance(1) ,handles.map,colour);
                                         txt1 = [ num2str(phy_tput_frame(1)) ' Mbps' ' (BPSK 1/2)' ' ' num2str(round(tput_distance(1))) 'km']; 
                                         
                                         label = ['\rightarrow'  (num2str(link_con(link_num).link_name)) ' P. Lim. Plot'];
                                         handles.plot_label1 = text(handles.tput_plot1.XData(1),handles.tput_plot1.YData(1),label, 'HorizontalAlignment','left','Color','white','FontSize',14);
                                         
                                         colour = [216/255 133/255 49/255]; 
                                         %BPSK 3/4 
                                         handles.tput_plot2 = tput_plot(x,y,tput_distance(2) ,handles.map,colour);
                                         txt2 = [num2str(phy_tput_frame(2)) ' Mbps' ' (BPSK 3/4)' ' ' num2str(round(tput_distance(2))) 'km'];

                                         colour = [7/255 164/255 18/255]; 
                                         %QPSK 1/2             
                                         handles.tput_plot3= tput_plot(x,y,tput_distance(3) ,handles.map,colour);
                                         txt3 = [num2str(phy_tput_frame(3)) ' Mbps' ' (QPSK 1/2)' ' ' num2str(round(tput_distance(3))) 'km'];

                                         colour = [116/255 11/255 128/255]; 
                                         %QPSK 3/4                                 
                                         handles.tput_plot4 = tput_plot(x,y,tput_distance(4) ,handles.map,colour);
                                         txt4 = [num2str(phy_tput_frame(4)) ' Mbps' ' (QPSK 3/4)' ' ' num2str(round(tput_distance(4))) 'km'];

                                         colour = 'c'; 
                                         %16QAM 1/2  
                                         handles.tput_plot5 = tput_plot(x,y,tput_distance(5) ,handles.map,colour);
                                         txt5 = [num2str(phy_tput_frame(5)) ' Mbps' ' (16QAM 1/2)' ' ' num2str(round(tput_distance(5))) 'km'];

                                         colour = 'b'; 
                                         %16QAM 3/4               
                                         handles.tput_plot6= tput_plot(x,y,tput_distance(6) ,handles.map,colour);
                                         txt6 = [num2str(phy_tput_frame(6)) ' Mbps' ' (16QAM 3/4)' ' ' num2str(round(tput_distance(6))) 'km'];

                                         colour = 'm'; 
                                         %64QAM 1/2                                 
                                         handles.tput_plot7 = tput_plot(x,y,tput_distance(7) ,handles.map,colour); 
                                         txt7 = [num2str(phy_tput_frame(7)) ' Mbps' ' (64QAM 1/2)' ' ' num2str(round(tput_distance(7))) 'km'];

                                         colour = 'g';
                                         %64QAM 2/3 
                                         handles.tput_plot8 = tput_plot(x,y,tput_distance(8) ,handles.map,colour);
                                         txt8 = [num2str(phy_tput_frame(8)) ' Mbps' ' (64QAM 2/3)' ' ' num2str(round(tput_distance(8))) 'km'];

                                         colour = [243/255 197/255 91/255]; 
                                         %64QAM 3/4                 
                                         handles.tput_plot9= tput_plot(x,y,tput_distance(9) ,handles.map,colour);
                                         txt9 = [num2str(phy_tput_frame(9)) ' Mbps' ' (64QAM 3/4)' ' ' num2str(round(tput_distance(9))) 'km'];

                                         colour = [127/255 0/255 255/255];
                                         %64QAM 5/6                 
                                         handles.tput_plot10= tput_plot(x,y,tput_distance(10) ,handles.map,colour);
                                         txt10 = [num2str(phy_tput_frame(10)) ' Mbps' ' (64QAM 5/6)' ' ' num2str(round(tput_distance(10))) 'km'];
                                     
                                         i_am_legend = legend(handles.map,[handles.tput_plot1,handles.tput_plot2,handles.tput_plot3,handles.tput_plot4,handles.tput_plot5,handles.tput_plot6,handles.tput_plot7,handles.tput_plot8,handles.tput_plot9,handles.tput_plot10],{txt1,txt2,txt3,txt4,txt5,txt6,txt7,txt8,txt9,txt10},'Location','best');
                                         title(i_am_legend,'LTE Max. PHY Throuput per MCS')                                         

                                     case '3-Ray'
                                         tput_distance = [three_ray(PL_target(1), ht, hr, freq),three_ray(PL_target(2), ht, hr, freq),three_ray(PL_target(3), ht, hr, freq),three_ray(PL_target(4), ht, hr, freq),three_ray(PL_target(5), ht, hr, freq),three_ray(PL_target(6), ht, hr, freq),three_ray(PL_target(7), ht, hr, freq),three_ray(PL_target(8), ht, hr, freq),three_ray(PL_target(9), ht, hr, freq),three_ray(PL_target(10), ht, hr, freq)];
                                         tput_distance = tput_distance*10^-3;                 

                                         set(handles.range_display_text, 'String',tput_distance(1)) 
                                         
                                         colour = 'y'; 
                                         %BPSK 1/2                                 
                                         handles.tput_plot1 = tput_plot(x,y,tput_distance(1) ,handles.map,colour);
                                         txt1 = [ num2str(phy_tput_frame(1)) ' Mbps' ' (BPSK 1/2)' ' ' num2str(round(tput_distance(1))) 'km'];
                                         
                                         label = ['\rightarrow'  (num2str(link_con(link_num).link_name)) ' P. Lim. Plot'];
                                         handles.plot_label1 = text(handles.tput_plot1.XData(1),handles.tput_plot1.YData(1),label, 'HorizontalAlignment','left','Color','white','FontSize',14);
                                         
                                         colour = [216/255 133/255 49/255]; 
                                         %BPSK 3/4 
                                         handles.tput_plot2 = tput_plot(x,y,tput_distance(2) ,handles.map,colour);
                                         txt2 = [num2str(phy_tput_frame(2)) ' Mbps' ' (BPSK 3/4)' ' ' num2str(round(tput_distance(2))) 'km'];

                                         colour = [7/255 164/255 18/255]; 
                                         %QPSK 1/2             
                                         handles.tput_plot3= tput_plot(x,y,tput_distance(3) ,handles.map,colour);
                                         txt3 = [num2str(phy_tput_frame(3)) ' Mbps' ' (QPSK 1/2)' ' ' num2str(round(tput_distance(3))) 'km'];

                                         colour = [116/255 11/255 128/255]; 
                                         %QPSK 3/4                                 
                                         handles.tput_plot4 = tput_plot(x,y,tput_distance(4) ,handles.map,colour);
                                         txt4 = [num2str(phy_tput_frame(4)) ' Mbps' ' (QPSK 3/4)' ' ' num2str(round(tput_distance(4))) 'km'];

                                         colour = 'c'; 
                                         %16QAM 1/2  
                                         handles.tput_plot5 = tput_plot(x,y,tput_distance(5) ,handles.map,colour);
                                         txt5 = [num2str(phy_tput_frame(5)) ' Mbps' ' (16QAM 1/2)' ' ' num2str(round(tput_distance(5))) 'km'];

                                         colour = 'b'; 
                                         %16QAM 3/4               
                                         handles.tput_plot6= tput_plot(x,y,tput_distance(6) ,handles.map,colour);
                                         txt6 = [num2str(phy_tput_frame(6)) ' Mbps' ' (16QAM 3/4)' ' ' num2str(round(tput_distance(6))) 'km'];

                                         colour = 'm'; 
                                         %64QAM 1/2                                 
                                         handles.tput_plot7 = tput_plot(x,y,tput_distance(7) ,handles.map,colour); 
                                         txt7 = [num2str(phy_tput_frame(7)) ' Mbps' ' (64QAM 1/2)' ' ' num2str(round(tput_distance(7))) 'km'];

                                         colour = 'g';
                                         %64QAM 2/3 
                                         handles.tput_plot8 = tput_plot(x,y,tput_distance(8) ,handles.map,colour);
                                         txt8 = [num2str(phy_tput_frame(8)) ' Mbps' ' (64QAM 2/3)' ' ' num2str(round(tput_distance(8))) 'km'];

                                         colour = [243/255 197/255 91/255]; 
                                         %64QAM 3/4                 
                                         handles.tput_plot9= tput_plot(x,y,tput_distance(9) ,handles.map,colour);
                                         txt9 = [num2str(phy_tput_frame(9)) ' Mbps' ' (64QAM 3/4)' ' ' num2str(round(tput_distance(9))) 'km'];

                                         colour = [127/255 0/255 255/255];
                                         %64QAM 5/6                 
                                         handles.tput_plot10= tput_plot(x,y,tput_distance(10) ,handles.map,colour);
                                         txt10 = [num2str(phy_tput_frame(10)) ' Mbps' ' (64QAM 5/6)' ' ' num2str(round(tput_distance(10))) 'km'];
                                     
                                         i_am_legend = legend(handles.map,[handles.tput_plot1,handles.tput_plot2,handles.tput_plot3,handles.tput_plot4,handles.tput_plot5,handles.tput_plot6,handles.tput_plot7,handles.tput_plot8,handles.tput_plot9,handles.tput_plot10],{txt1,txt2,txt3,txt4,txt5,txt6,txt7,txt8,txt9,txt10},'Location','best');
                                         title(i_am_legend,'LTE Max. PHY Throuput per MCS')                                         

                                     case 'Sea Radio-Wave Propagation Loss'
                                         tput_distance = [srwpl(PL_target(1), ht, hr, freq),srwpl(PL_target(2), ht, hr, freq),srwpl(PL_target(3), ht, hr, freq),srwpl(PL_target(4), ht, hr, freq),srwpl(PL_target(5), ht, hr, freq),srwpl(PL_target(6), ht, hr, freq),srwpl(PL_target(7), ht, hr, freq),srwpl(PL_target(8), ht, hr, freq),srwpl(PL_target(9), ht, hr, freq),srwpl(PL_target(10), ht, hr, freq)];
                                         tput_distance = tput_distance*10^-3;                 

                                         set(handles.range_display_text, 'String',tput_distance(1)) 
                                         
                                         colour = 'y'; 
                                         %BPSK 1/2                                 
                                         handles.tput_plot1 = tput_plot(x,y,tput_distance(1) ,handles.map,colour);
                                         txt1 = [ num2str(phy_tput_frame(1)) ' Mbps' ' (BPSK 1/2)' ' ' num2str(round(tput_distance(1))) 'km']; 
                                         
                                         label = ['\rightarrow'  (num2str(link_con(link_num).link_name)) ' P. Lim. Plot'];
                                         handles.plot_label1 = text(handles.tput_plot1.XData(1),handles.tput_plot1.YData(1),label, 'HorizontalAlignment','left','Color','white','FontSize',14);
                                         
                                         colour = [216/255 133/255 49/255]; 
                                         %BPSK 3/4 
                                         handles.tput_plot2 = tput_plot(x,y,tput_distance(2) ,handles.map,colour);
                                         txt2 = [num2str(phy_tput_frame(2)) ' Mbps' ' (BPSK 3/4)' ' ' num2str(round(tput_distance(2))) 'km'];

                                         colour = [7/255 164/255 18/255]; 
                                         %QPSK 1/2             
                                         handles.tput_plot3= tput_plot(x,y,tput_distance(3) ,handles.map,colour);
                                         txt3 = [num2str(phy_tput_frame(3)) ' Mbps' ' (QPSK 1/2)' ' ' num2str(round(tput_distance(3))) 'km'];

                                         colour = [116/255 11/255 128/255]; 
                                         %QPSK 3/4                                 
                                         handles.tput_plot4 = tput_plot(x,y,tput_distance(4) ,handles.map,colour);
                                         txt4 = [num2str(phy_tput_frame(4)) ' Mbps' ' (QPSK 3/4)' ' ' num2str(round(tput_distance(4))) 'km'];

                                         colour = 'c'; 
                                         %16QAM 1/2  
                                         handles.tput_plot5 = tput_plot(x,y,tput_distance(5) ,handles.map,colour);
                                         txt5 = [num2str(phy_tput_frame(5)) ' Mbps' ' (16QAM 1/2)' ' ' num2str(round(tput_distance(5))) 'km'];

                                         colour = 'b'; 
                                         %16QAM 3/4               
                                         handles.tput_plot6= tput_plot(x,y,tput_distance(6) ,handles.map,colour);
                                         txt6 = [num2str(phy_tput_frame(6)) ' Mbps' ' (16QAM 3/4)' ' ' num2str(round(tput_distance(6))) 'km'];

                                         colour = 'm'; 
                                         %64QAM 1/2                                 
                                         handles.tput_plot7 = tput_plot(x,y,tput_distance(7) ,handles.map,colour); 
                                         txt7 = [num2str(phy_tput_frame(7)) ' Mbps' ' (64QAM 1/2)' ' ' num2str(round(tput_distance(7))) 'km'];

                                         colour = 'g';
                                         %64QAM 2/3 
                                         handles.tput_plot8 = tput_plot(x,y,tput_distance(8) ,handles.map,colour);
                                         txt8 = [num2str(phy_tput_frame(8)) ' Mbps' ' (64QAM 2/3)' ' ' num2str(round(tput_distance(8))) 'km'];

                                         colour = [243/255 197/255 91/255]; 
                                         %64QAM 3/4                 
                                         handles.tput_plot9= tput_plot(x,y,tput_distance(9) ,handles.map,colour);
                                         txt9 = [num2str(phy_tput_frame(9)) ' Mbps' ' (64QAM 3/4)' ' ' num2str(round(tput_distance(9))) 'km'];

                                         colour = [127/255 0/255 255/255];
                                         %64QAM 5/6                 
                                         handles.tput_plot10= tput_plot(x,y,tput_distance(10) ,handles.map,colour);
                                         txt10 = [num2str(phy_tput_frame(10)) ' Mbps' ' (64QAM 5/6)' ' ' num2str(round(tput_distance(10))) 'km'];
                                     
                                         i_am_legend = legend(handles.map,[handles.tput_plot1,handles.tput_plot2,handles.tput_plot3,handles.tput_plot4,handles.tput_plot5,handles.tput_plot6,handles.tput_plot7,handles.tput_plot8,handles.tput_plot9,handles.tput_plot10],{txt1,txt2,txt3,txt4,txt5,txt6,txt7,txt8,txt9,txt10},'Location','best');
                                         title(i_am_legend,'LTE Max. PHY Throuput per MCS')                                         
                                 end 
                                 
                                 

                             otherwise

                                 Qm = [2,4,6];
                                 Rb = ((RE_frame*Qm)/(10*10^-3)); 
                                 EbN0 = [EbN0_value(ber_target,'QPSK',channel_type),EbN0_value(ber_target,'16QAM',channel_type),EbN0_value(ber_target,'64QAM',channel_type)];

                                 SINR = EbN0.*(Rb/B_noise);         
                                 SINR_db = 10*log10(SINR);                  
                                 Pr_min = SINR_db + Interf_Noise;        
                                 PL_target = Ptx + G_ant - Cable_losses - Pr_min;                
                                 x = ht_cords(1);          
                                 y = ht_cords(2);
                                 
                                 phy_tput_frame = ((PDSCH_RE_frame*Qm)/(10*10^-3))/10^6;
                                 set(handles.throughput_display_text, 'String',phy_tput_frame(1)) 
                                 

                                 switch link_con(link_num).channel.path_loss_model

                                     case 'FSPL'

                                         tput_distance = 10.^((PL_target-20*log10(freq)-32.44)/20);
                                         
                                         set(handles.range_display_text, 'String',tput_distance(1)) 

                                         colour = 'y'; 
                                         %QPSK                                  
                                         handles.tput_plot1 = tput_plot(x,y,tput_distance(1) ,handles.map,colour);
                                         txt1 = [ num2str(phy_tput_frame(1)) ' Mbps' ' (QPSK)' ' ' num2str(round(tput_distance(1))) 'km']; 
                                         
                                         label = ['\rightarrow'  (num2str(link_con(link_num).link_name)) ' P. Lim. Plot'];
                                         handles.plot_label1 = text(handles.tput_plot1.XData(1),handles.tput_plot1.YData(1),label, 'HorizontalAlignment','left','Color','white','FontSize',14);
                                         
                                         colour = 'b'; 
                                         %16QAM
                                         handles.tput_plot2 = tput_plot(x,y,tput_distance(2) ,handles.map,colour);
                                         txt2 = [num2str(phy_tput_frame(2)) ' Mbps' ' (16QAM)' ' ' num2str(round(tput_distance(2))) 'km'];

                                         colour = 'g';
                                         %64QAM                 
                                         handles.tput_plot3= tput_plot(x,y,tput_distance(3) ,handles.map,colour);
                                         txt3 = [num2str(phy_tput_frame(3)) ' Mbps' ' (64QAM)' ' ' num2str(round(tput_distance(3))) 'km'];
                                         
                                         i_am_legend = legend(handles.map,[handles.tput_plot1,handles.tput_plot2,handles.tput_plot3],{txt1,txt2,txt3},'Location','best');
                                         title(i_am_legend,'LTE Max. Max. PHY Throuput per Mod. Sch.')
                                         
                                     case '2-Ray'

                                         tput_distance = [two_ray(PL_target(1), ht, hr, freq),two_ray(PL_target(2), ht, hr, freq),two_ray(PL_target(3), ht, hr, freq)];
                                         tput_distance = tput_distance*10^-3;
                                         
                                         set(handles.range_display_text, 'String',tput_distance(1)) 

                                         colour = 'y'; 
                                         %QPSK                                  
                                         handles.tput_plot1 = tput_plot(x,y,tput_distance(1) ,handles.map,colour);
                                         txt1 = [ num2str(phy_tput_frame(1)) ' Mbps' ' (QPSK)' ' ' num2str(round(tput_distance(1))) 'km']; 
                                         
                                         label = ['\rightarrow'  (num2str(link_con(link_num).link_name)) ' P. Lim. Plot'];
                                         handles.plot_label1 = text(handles.tput_plot1.XData(1),handles.tput_plot1.YData(1),label, 'HorizontalAlignment','left','Color','white','FontSize',14);
                                         
                                         colour = 'b'; 
                                         %16QAM
                                         handles.tput_plot2 = tput_plot(x,y,tput_distance(2) ,handles.map,colour);
                                         txt2 = [num2str(phy_tput_frame(2)) ' Mbps' ' (16QAM)' ' ' num2str(round(tput_distance(2))) 'km'];

                                         colour = 'g';
                                         %64QAM                 
                                         handles.tput_plot3= tput_plot(x,y,tput_distance(3) ,handles.map,colour);
                                         txt3 = [num2str(phy_tput_frame(3)) ' Mbps' ' (64QAM)' ' ' num2str(round(tput_distance(3))) 'km'];
                                         
                                         i_am_legend = legend(handles.map,[handles.tput_plot1,handles.tput_plot2,handles.tput_plot3],{txt1,txt2,txt3},'Location','best');
                                         title(i_am_legend,'LTE Max. Max. PHY Throuput per Mod. Sch.')
                                         
                                     case '3-Ray'
                                         tput_distance = [three_ray(PL_target(1), ht, hr, freq),three_ray(PL_target(2), ht, hr, freq),three_ray(PL_target(3), ht, hr, freq)];
                                         tput_distance = tput_distance*10^-3;   
                                         
                                         set(handles.range_display_text, 'String',tput_distance(1)) 

                                         colour = 'y'; 
                                         %QPSK                                  
                                         handles.tput_plot1 = tput_plot(x,y,tput_distance(1) ,handles.map,colour);
                                         txt1 = [ num2str(phy_tput_frame(1)) ' Mbps' ' (QPSK)' ' ' num2str(round(tput_distance(1))) 'km']; 
                                         label = ['\rightarrow'  (num2str(link_con(link_num).link_name)) ' P. Lim. Plot'];
                                         handles.plot_label1 = text(handles.tput_plot1.XData(1),handles.tput_plot1.YData(1),label, 'HorizontalAlignment','left','Color','white','FontSize',14);
                                         
                                         colour = 'b'; 
                                         %16QAM
                                         handles.tput_plot2 = tput_plot(x,y,tput_distance(2) ,handles.map,colour);
                                         txt2 = [num2str(phy_tput_frame(2)) ' Mbps' ' (16QAM)' ' ' num2str(round(tput_distance(2))) 'km'];

                                         colour = 'g';
                                         %64QAM                 
                                         handles.tput_plot3= tput_plot(x,y,tput_distance(3) ,handles.map,colour);
                                         txt3 = [num2str(phy_tput_frame(3)) ' Mbps' ' (64QAM)' ' ' num2str(round(tput_distance(3))) 'km'];
                                         
                                         i_am_legend = legend(handles.map,[handles.tput_plot1,handles.tput_plot2,handles.tput_plot3],{txt1,txt2,txt3},'Location','best')
                                         title(i_am_legend,'LTE Max. Max. PHY Throuput per Mod. Sch.')

                                     case 'Sea Radio-Wave Propagation Loss'
                                         tput_distance = [srwpl(PL_target(1), ht, hr, freq),srwpl(PL_target(2), ht, hr, freq),srwpl(PL_target(3), ht, hr, freq)];
                                         tput_distance = tput_distance*10^-3; 
                                         
                                         set(handles.range_display_text, 'String',tput_distance(1)) 

                                         colour = 'y'; 
                                         %QPSK                                  
                                         handles.tput_plot1 = tput_plot(x,y,tput_distance(1) ,handles.map,colour);
                                         txt1 = [ num2str(phy_tput_frame(1)) ' Mbps' ' (QPSK)' ' ' num2str(round(tput_distance(1))) 'km'];
                                         
                                         label = ['\rightarrow'  (num2str(link_con(link_num).link_name)) ' P. Lim. Plot'];
                                         handles.plot_label1 = text(handles.tput_plot1.XData(1),handles.tput_plot1.YData(1),label, 'HorizontalAlignment','left','Color','white','FontSize',14);
                                         
                                         colour = 'b'; 
                                         %16QAM
                                         handles.tput_plot2 = tput_plot(x,y,tput_distance(2) ,handles.map,colour);
                                         txt2 = [num2str(phy_tput_frame(2)) ' Mbps' ' (16QAM)' ' ' num2str(round(tput_distance(2))) 'km'];

                                         colour = 'g';
                                         %64QAM                 
                                         handles.tput_plot3= tput_plot(x,y,tput_distance(3) ,handles.map,colour);
                                         txt3 = [num2str(phy_tput_frame(3)) ' Mbps' ' (64QAM)' ' ' num2str(round(tput_distance(3))) 'km'];
                                         
                                         i_am_legend = legend(handles.map,[handles.tput_plot1,handles.tput_plot2,handles.tput_plot3],{txt1,txt2,txt3},'Location','best')
                                         title(i_am_legend,'LTE Max. Max. PHY Throuput per Mod. Sch.')                                
                                 end                
                         end


                     case 'NWR'

                         Qm = 2;
                         datarate = 520.83; 

                         Rb = 520.83; 

                         B_noise = link_con(link_num).receiver.rx_bandwidth*10^6;
                         mod_sch = 'FSK';
                         EbN0 = EbN0_value(ber_target,mod_sch,channel_type);
                         SINR = EbN0*(Rb/B_noise);
                         SINR_db = 10*log10(SINR);
                         Pr_min = SINR_db + Interf_Noise;
                         PL_target = Ptx + G_ant - Cable_losses - Pr_min;

                         x = ht_cords(1);  
                         y = ht_cords(2);
                         
                         nwr_throughput = 484.37;%bps
                         set(handles.throughput_display_text, 'String',(nwr_throughput*10^-6)) 

                         switch link_con(link_num).channel.path_loss_model

                                     case 'FSPL'

                                         tput_distance = 10^((PL_target-20*log10(freq)-32.44)/20);


                                         colour = 'b';
                                         handles.tput_plot1 = tput_plot(x,y,tput_distance ,handles.map,colour);
                                         txt1 = [ num2str(nwr_throughput) ' bps' ' (FSK 0.93)' ' ' num2str(round(tput_distance)) 'km']; 
                                         i_am_legend = legend(handles.map,[handles.tput_plot1],{txt1},'Location','best');
                                         title(i_am_legend,'NWR Throuput per MCS') 
                                         
                                         set(handles.range_display_text, 'String',tput_distance)
                                         
                                         label = ['\rightarrow'  (num2str(link_con(link_num).link_name)) ' P. Lim. Plot'];
                                         handles.plot_label1 = text(handles.tput_plot1.XData(1),handles.tput_plot1.YData(1),label, 'HorizontalAlignment','left','Color','white','FontSize',14);


                                     case '2-Ray'

                                         tput_distance = two_ray(PL_target, ht, hr, freq);
                                         tput_distance = tput_distance*10^-3;

                                         colour = 'b';
                                         handles.tput_plot1 = tput_plot(x,y,tput_distance ,handles.map,colour);
                                         txt1 = [ num2str(nwr_throughput) ' bps' ' (FSK 0.93)' ' ' num2str(round(tput_distance)) 'km']; 
                                         i_am_legend = legend(handles.map,[handles.tput_plot1],{txt1},'Location','best');
                                         title(i_am_legend,'NWR Throuput per MCS') 
                                         
                                         set(handles.range_display_text, 'String',tput_distance)
                                         
                                         label = ['\rightarrow'  (num2str(link_con(link_num).link_name)) ' P. Lim. Plot'];
                                         handles.plot_label1 = text(handles.tput_plot1.XData(1),handles.tput_plot1.YData(1),label, 'HorizontalAlignment','left','Color','white','FontSize',14);
                                         
                                     case '3-Ray'
                                         tput_distance = three_ray(PL_target, ht, hr, freq);
                                         tput_distance = tput_distance*10^-3;                 

                                         colour = 'b';
                                         handles.tput_plot1 = tput_plot(x,y,tput_distance ,handles.map,colour);
                                         txt1 = [ num2str(nwr_throughput) ' bps' ' (FSK 0.93) '  num2str(round(tput_distance)) 'km']; 
                                         i_am_legend = legend(handles.map,[handles.tput_plot1],{txt1},'Location','best');
                                         title(i_am_legend,'LTE Max. PHY Throuput per MCS') 
                                         
                                         set(handles.range_display_text, 'String',tput_distance)
                                         
                                         label = ['\rightarrow'  (num2str(link_con(link_num).link_name)) ' P. Lim. Plot'];
                                         handles.plot_label1 = text(handles.tput_plot1.XData(1),handles.tput_plot1.YData(1),label, 'HorizontalAlignment','left','Color','white','FontSize',14);
                                         
                                     case 'Sea Radio-Wave Propagation Loss'
                                         tput_distance = srwpl(PL_target, ht, hr, freq);
                                         tput_distance = tput_distance*10^-3;                 

                                         colour = 'b';
                                         handles.tput_plot1 = tput_plot(x,y,tput_distance ,handles.map,colour);
                                         txt1 = [ num2str(nwr_throughput) ' bps' ' (FSK 0.93) '   num2str(round(tput_distance)) 'km']; 
                                         i_am_legend = legend(handles.map,[handles.tput_plot1],{txt1},'Location','best');
                                         title(i_am_legend,'NWR Throuput per MCS') 
                                         
                                         set(handles.range_display_text, 'String',tput_distance)
                                         
                                         label = ['\rightarrow'  (num2str(link_con(link_num).link_name)) ' P. Lim. Plot'];
                                         handles.plot_label1 = text(handles.tput_plot1.XData(1),handles.tput_plot1.YData(1),label, 'HorizontalAlignment','left','Color','white','FontSize',14);
                         end




                     case 'Generic'    
                         Qm = [2,4,6];
                         Rb = ((RE_frame*Qm)/(10*10^-3)); 

                         EbN0 = [EbN0_value(ber_target,'QPSK',channel_type),EbN0_value(ber_target,'16QAM',channel_type),EbN0_value(ber_target,'64QAM',channel_type)];
                         SINR = EbN0.*(Rb/B_noise);
                         SINR_db = 10*log10(SINR);

                         Pr_min = SINR_db + Interf_Noise;
                         PL_target = Ptx + G_ant - Cable_losses - Pr_min;

                         x = ht_cords(1);  
                         y = ht_cords(2);
                         
                         B_sys = link_con(link_num).system_params.system_bandwidth;
                         B_sys = num2str(B_sys);
                         switch B_sys


                             case '1.4'
                                 PDSCH_RE_frame = 4912; %Extended CP, CFI = 3, BW = 1.4 MHz

                             case '3'
                                 PDSCH_RE_frame = 14812; %Extended CP, CFI = 3

                             case '5'
                                 PDSCH_RE_frame = 25012; %Extended CP, CFI = 3

                             case '10'
                                 PDSCH_RE_frame = 50512; %Extended CP, CFI = 3

                             case '15'
                                 PDSCH_RE_frame = 76012; %Extended CP, CFI = 3

                             case '20'
                                 PDSCH_RE_frame = 101512; %Extended CP, CFI = 3
                         end
                         
                         phy_tput_frame = ((PDSCH_RE_frame*Qm)/(10*10^-3))/10^6;
                         set(handles.throughput_display_text, 'String',phy_tput_frame) 


                         switch link_con(link_num).channel.path_loss_model

                             case 'FSPL'

                                 tput_distance = 10.^((PL_target-20*log10(freq)-32.44)/20);

                                                
                                 colour = 'y'; 
                                 %QPSK                                  
                                 handles.tput_plot1 = tput_plot(x,y,tput_distance(1) ,handles.map,colour);
                                 txt1 = [ num2str(phy_tput_frame(1)) ' Mbps' ' (QPSK)']; 

                                 colour = 'b'; 
                                 %16QAM
                                 handles.tput_plot2 = tput_plot(x,y,tput_distance(2) ,handles.map,colour);
                                 txt2 = [num2str(phy_tput_frame(2)) ' Mbps' ' (16QAM)'];

                                 colour = 'g';
                                 %64QAM                 
                                 handles.tput_plot3= tput_plot(x,y,tput_distance(3) ,handles.map,colour);
                                 txt3 = [num2str(phy_tput_frame(3)) ' Mbps' ' (64QAM)'];

                                 i_am_legend = legend(handles.map,[handles.tput_plot1,handles.tput_plot2,handles.tput_plot3],{txt1,txt2,txt3},'Location','best');
                                 title(i_am_legend,'Generic Throuput per Mod. Sch.')  

                             case '2-Ray'

                                 tput_distance = [two_ray(PL_target(1), ht, hr, freq),two_ray(PL_target(2), ht, hr, freq),two_ray(PL_target(3), ht, hr, freq)];
                                 tput_distance = tput_distance*10^-3;

                                 colour = 'y'; 
                                 %QPSK                                  
                                 handles.tput_plot1 = tput_plot(x,y,tput_distance(1) ,handles.map,colour);
                                 txt1 = [ num2str(phy_tput_frame(1)) ' Mbps' ' (QPSK)']; 

                                 colour = 'b'; 
                                 %16QAM
                                 handles.tput_plot2 = tput_plot(x,y,tput_distance(2) ,handles.map,colour);
                                 txt2 = [num2str(phy_tput_frame(2)) ' Mbps' ' (16QAM)'];

                                 colour = 'g';
                                 %64QAM                 
                                 handles.tput_plot3= tput_plot(x,y,tput_distance(3) ,handles.map,colour);
                                 txt3 = [num2str(phy_tput_frame(3)) ' Mbps' ' (64QAM)'];

                                 i_am_legend = legend(handles.map,[handles.tput_plot1,handles.tput_plot2,handles.tput_plot3],{txt1,txt2,txt3},'Location','best');
                                 title(i_am_legend,'Generic Throuput per Mod. Sch.') 
                                 
                             case '3-Ray'
                                 tput_distance = [three_ray(PL_target(1), ht, hr, freq),three_ray(PL_target(2), ht, hr, freq),three_ray(PL_target(3), ht, hr, freq)];
                                 tput_distance = tput_distance*10^-3;                 

                                 colour = 'y'; 
                                 %QPSK                                  
                                 handles.tput_plot1 = tput_plot(x,y,tput_distance(1) ,handles.map,colour);
                                 txt1 = [ num2str(phy_tput_frame(1)) ' Mbps' ' (QPSK)']; 

                                 colour = 'b'; 
                                 %16QAM
                                 handles.tput_plot2 = tput_plot(x,y,tput_distance(2) ,handles.map,colour);
                                 txt2 = [num2str(phy_tput_frame(2)) ' Mbps' ' (16QAM)'];

                                 colour = 'g';
                                 %64QAM                 
                                 handles.tput_plot3= tput_plot(x,y,tput_distance(3) ,handles.map,colour);
                                 txt3 = [num2str(phy_tput_frame(3)) ' Mbps' ' (64QAM)'];

                                 i_am_legend = legend(handles.map,[handles.tput_plot1,handles.tput_plot2,handles.tput_plot3],{txt1,txt2,txt3},'Location','best');
                                 title(i_am_legend,'Generic Throuput per Mod. Sch.') 
                                 
                             case 'Sea Radio-Wave Propagation Loss'
                                 tput_distance = [srwpl(PL_target(1), ht, hr, freq),srwpl(PL_target(2), ht, hr, freq),srwpl(PL_target(3), ht, hr, freq)];
                                 tput_distance = tput_distance*10^-3;                 

                                 colour = 'y'; 
                                 %QPSK                                  
                                 handles.tput_plot1 = tput_plot(x,y,tput_distance(1) ,handles.map,colour);
                                 txt1 = [ num2str(phy_tput_frame(1)) ' Mbps' ' (QPSK)']; 

                                 colour = 'b'; 
                                 %16QAM
                                 handles.tput_plot2 = tput_plot(x,y,tput_distance(2) ,handles.map,colour);
                                 txt2 = [num2str(phy_tput_frame(2)) ' Mbps' ' (16QAM)'];

                                 colour = 'g';
                                 %64QAM                 
                                 handles.tput_plot3= tput_plot(x,y,tput_distance(3) ,handles.map,colour);
                                 txt3 = [num2str(phy_tput_frame(3)) ' Mbps' ' (64QAM)'];

                                 i_am_legend = legend(handles.map,[handles.tput_plot1,handles.tput_plot2,handles.tput_plot3],{txt1,txt2,txt3},'Location','best');
                                 title(i_am_legend,'Generic Throuput per Mod. Sch.') 
                         end

                     otherwise


                 end

             case 2 %Prevailing Limit
                 
                 %LOSH Computation
                %Ascertain whether the transmitter is tower mounted or mobile at sea 
             switch node_con(tx_num).node_type
                 
                 case 'Mobile at Sea'
                     
                     h_ves = 2; %Vessel selected to be maximum 2m 
                     
                     %Plot Datatips for transmitter 
                     h = findobj('Tag','gmap');
                     h = h(2);
                     makedatatip(h,[node_con(tx_num).node_location.longi  node_con(tx_num).node_location.lati])
                     
                     switch node_con(rx_num).node_type
                         
                         case 'Mobile at Sea'
                             
                             h_2 = h_ves ;
                             
                             %Plot Datatips for receiver
                             h = findobj('Tag','gmap');
                             h = h(2);
                             makedatatip(h,[node_con(rx_num).node_location.longi  node_con(rx_num).node_location.lati]) 
                             
                             
                         case 'Tower Mounted'
                             
                             if exist('towers.mat')
                         
                                 load('towers.mat')
                         
                                 if exist('tower_tnt')

                                     maxi = numel(tower_tnt);

                                     tower_cords = zeros(maxi,2);

                             for elements = 1:maxi

                                 tower_cords(elements,:) = [tower_tnt(elements).Lon,tower_tnt(elements).Lat];
                             end
                             
                             user_cords = [node_con(rx_num).node_location.longi  ,node_con(rx_num).node_location.lati];

                                euclidean_distances = sqrt(sum(bsxfun(@minus, tower_cords, user_cords).^2,2));
                                closest_tower = tower_cords(find(euclidean_distances==min(euclidean_distances)),:);

                                h_2 = tower_tnt(find((ismember(tower_cords,closest_tower )),1)).AntennaHeight; %Height of Closest tower 
                                
                                %Plot Datatips for receiver
                                h = findobj('Tag','gmap');
                                h = h(2);
                                makedatatip(h,[closest_tower(:,1)  closest_tower(:,2)])
                                 end
                             end
                     end
                     
                     tx_height = h_ves ;
                     d_losh = (sqrt(2*R*h_ves)+sqrt(2*R*h_2))/(10^3); %answer in km

                     setappdata(0,'range_dist',d_losh)
                     setappdata(0,'long_cordi',node_con(tx_num).node_location.longi); 
                     setappdata(0,'lat_cordi',node_con(tx_num).node_location.lati);
                     dlosh_cords = [node_con(tx_num).node_location.longi  node_con(tx_num).node_location.lati];



                     euclidean_los = sqrt(sum(bsxfun(@minus, tx_cords, rx_cords).^2,2)); %find direct distance between tx and rx to find if rx is in range of tx by comparing the link lenght to the LOSH distance(radius)
                     if euclidean_los<d_losh
                         range_flag = 1;   %Signal if in range or out of range                      
                     end

                     
                     
                 case 'Tower Mounted'
                     
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
                                h_ves = 2; 
                                tx_height = h_bs ;

                                d_losh = (sqrt(2*R*h_bs)+sqrt(2*R*h_ves))/(10^3); %answer in km
                                setappdata(0,'range_dist',d_losh)
                                setappdata(0,'long_cordi',closest_tower(:,1)); 
                                setappdata(0,'lat_cordi',closest_tower(:,2));
                                dlosh_cords = [closest_tower(:,1)  closest_tower(:,2) ];

                         end
                     end
                     
                     %Plot Datatips for receiver
                     h = findobj('Tag','gmap');
                     h = h(2);
                     makedatatip(h,[node_con(rx_num).node_location.longi  node_con(rx_num).node_location.lati]) 
                     %Plot Datatips for transmitter 
                     h = findobj('Tag','gmap');
                     h = h(2);
                     makedatatip(h,[closest_tower(:,1)  closest_tower(:,2)])
                     
                     dlosh = round(d_losh,4);
                     
             end
             
             
             
             

             %Power Limited Computation with embedded check against LOSH 
             switch node_con(tx_num).node_type
                 
                 case 'Mobile at Sea'
                     ht = 2;
                     ht_cords = [node_con(tx_num).node_location.longi  ,node_con(tx_num).node_location.lati];
                     
                 case 'Tower Mounted'
                     
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

                                ht = tower_tnt(find((ismember(tower_cords,closest_tower )),1)).AntennaHeight; %Height of Closest tower
                                ht_cords = [closest_tower(:,1)  ,closest_tower(:,2)]; 


                         end
                     end
                     
             end
                     
                     

             
             switch node_con(rx_num).node_type
                 
                 case 'Mobile at Sea'
                     hr = 2;
                     hr_cords = [node_con(rx_num).node_location.longi  ,node_con(rx_num).node_location.lati];
                     
                     
                 case 'Tower Mounted'
                     
                     if exist('towers.mat')
                         load('towers.mat')
                         
                         if exist('tower_tnt')

                             maxi = numel(tower_tnt);

                             tower_cords = zeros(maxi,2);

                             for elements = 1:maxi

                                 tower_cords(elements,:) = [tower_tnt(elements).Lon,tower_tnt(elements).Lat];

                             end
                             
                             user_cords = [node_con(rx_num).node_location.longi  ,node_con(rx_num).node_location.lati];

                                euclidean_distances = sqrt(sum(bsxfun(@minus, tower_cords, user_cords).^2,2));
                                closest_tower = tower_cords(find(euclidean_distances==min(euclidean_distances)),:);

                                hr = tower_tnt(find((ismember(tower_cords,closest_tower )),1)).AntennaHeight; %Height of Closest tower
                                hr_cords = [closest_tower(:,1)  ,closest_tower(:,2)];


                         end
                     end
                     
             end
             
             %Plot Datatips for receiver
             h = findobj('Tag','gmap');
             h = h(2);
             makedatatip(h,[hr_cords(1), hr_cords(2)]) 

             %Plot Datatips for transmitter 
             h = findobj('Tag','gmap');
             h = h(2);
             makedatatip(h,[ht_cords(1), ht_cords(2)])
             
             
             set(handles.service_disp_text, 'String', link_con(link_num).node_service.service);
             set(handles.ber_display_text, 'String',link_con(link_num).node_service.ber)
             switch link_con(link_num).node_service.ber
                 
                 case '10^-2'
                     ber_target = 10^-2;
                     
                 case '10^-3'
                     ber_target = 10^-3;
                     
                 case '10^-5' 
                     ber_target = 10^-5;
                     
                 case '10^-6' 
                     ber_target = 10^-6;
                     
                 case '6x10^-8'
                     ber_target = 6*10^-8;
                     
             end
             
              channel_type = link_con(link_num).channel.channel_type;%channel type variable from configuration

             
             %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
             switch link_con(link_num).technology 
    
                 case 'DSC'
                     Qm = 2;
                     datarate = 100; 

                     Rb = datarate ; 

                     B_noise = link_con(link_num).receiver.rx_bandwidth*10^6;
                     mod_sch = 'FSK';
                     EbN0 = EbN0_value(ber_target,mod_sch,channel_type);
                     SINR = EbN0*(Rb/B_noise);
                     SINR_db = 10*log10(SINR);
                     Nf = node_con(rx_num).equipment_params.noise_fig;
                     k = physconst('Boltzmann');
                     T = link_con(link_num).receiver.temperature;
                     Nt = k*T*B_noise;
                     Nt_db =  10*log10(Nt)+30;   
    
                 case 'LTE-A'
                     B_sys = link_con(link_num).system_params.system_bandwidth;
                     set(handles.freq_disp_text, 'String', link_con(link_num).system_params.freq);
                     
                     B_sys = num2str(B_sys);
                     switch B_sys

                         case '1.4'
                             RE_frame = 8640; %Extended CP, CFI = 3, BW = 1.4 MHz

                         case '3'
                             RE_frame = 21600; %Extended CP, CFI = 3

                         case '5'
                             RE_frame = 36000; %Extended CP, CFI = 3

                         case '10'
                             RE_frame = 72000; %Extended CP, CFI = 3

                         case '15'
                             RE_frame = 108000; %Extended CP, CFI = 3

                         case '20'
                             RE_frame = 144000; %Extended CP, CFI = 3

                     end

                     Qm = 2;
                     phy_datarate_frame = ((RE_frame*Qm)/(10*10^-3)); %SISO

                     Rb = phy_datarate_frame ; 

                     B_noise = link_con(link_num).receiver.rx_bandwidth*10^6;
                     mod_sch = 'QPSK';
                     EbN0 = EbN0_value(ber_target,mod_sch,channel_type);
                     SINR = EbN0*(Rb/B_noise);
                     SINR_db = 10*log10(SINR);
                     Nf = node_con(rx_num).equipment_params.noise_fig;
                     k = physconst('Boltzmann');
                     T = link_con(link_num).receiver.temperature;
                     Nt = k*T*B_noise;
                     Nt_db =  10*log10(Nt)+30;      
           

                 case 'NWR'
                     B_sys = link_con(link_num).system_params.system_bandwidth;
                     set(handles.freq_disp_text, 'String', link_con(link_num).system_params.freq);
                     

                     Qm = 2;
                     datarate = 520.83; 

                     Rb = 520.83; 

                     B_noise = link_con(link_num).receiver.rx_bandwidth*10^6;
                     mod_sch = 'FSK';
                     EbN0 = EbN0_value(ber_target,mod_sch,channel_type);
                     SINR = EbN0*(Rb/B_noise);
                     SINR_db = 10*log10(SINR);
                     Nf = node_con(rx_num).equipment_params.noise_fig;
                     k = physconst('Boltzmann');
                     T = link_con(link_num).receiver.temperature;
                     Nt = k*T*B_noise;
                     Nt_db =  10*log10(Nt)+30;    
   
                 case 'Generic'    
                     B_sys = link_con(link_num).system_params.system_bandwidth;
                     set(handles.freq_disp_text, 'String', link_con(link_num).system_params.freq);
                     B_sys = num2str(B_sys);
                     switch B_sys

                         case '1.4'
                             RE_frame = 8640; %Extended CP,  BW = 1.4 MHz

                         case '3'
                             RE_frame = 21600; %Extended CP 

                         case '5'
                             RE_frame = 36000; %Extended CP
                             
                         case '10'
                             RE_frame = 72000; %Extended CP 

                         case '15'
                             RE_frame = 108000; %Extended CP 

                         case '20'
                             RE_frame = 144000; %Extended CP 

                     end

                     Qm = 2;
                     phy_datarate_frame = ((RE_frame*Qm)/(10*10^-3)); %SISO
                     Rb = phy_datarate_frame;

                     B_noise = link_con(link_num).receiver.rx_bandwidth*10^6;
                     mod_sch = 'QPSK';
                     EbN0 = EbN0_value(ber_target,mod_sch,channel_type);
                     SINR = EbN0*(Rb/B_noise);
                     SINR_db = 10*log10(SINR);
                     Nf = node_con(rx_num).equipment_params.noise_fig;
                     k = physconst('Boltzmann');
                     T = link_con(link_num).receiver.temperature;
                     Nt = k*T*B_noise;
                     Nt_db =  10*log10(Nt)+30;                                
                     
             end
             

             
             %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
             If_margin = link_con(link_num).channel.interference_margin;
             set(handles.interf_disp_text, 'String', If_margin);
             fad_margin = link_con(link_num).channel.fading_margin;
             set(handles.fade_disp_text, 'String', fad_margin);
             
             Interf_Noise = Nt_db+Nf+If_margin+fad_margin;
             
             Pr_min = SINR_db + Interf_Noise;
             
             set(handles.rx_sens_text, 'String',Pr_min)
             set(handles.ber_display_text, 'String',link_con(link_num).node_service.ber) 
             set(handles.node_display_text, 'String',link_con(link_num).link_name) 
             
                          
             Ptx = node_con(tx_num).equipment_params.tx_pwr;

             G_ant = node_con(tx_num).equipment_params.tx_ant_gain + node_con(rx_num).equipment_params.rx_ant_gain;
             Cable_losses = node_con(tx_num).equipment_params.tx_cable_loss + node_con(rx_num).equipment_params.rx_cable_loss;
             
             PL_target = Ptx + G_ant - Cable_losses - Pr_min;
             
             freq = link_con(link_num).system_params.freq;

               switch link_con(link_num).channel.path_loss_model
                   
                   case 'FSPL'
                       set(handles.path_loss_disp_text, 'String', link_con(link_num).channel.path_loss_model);
                       %Path_Loss = Ptx + G_ant - Cable_losses - Prx;
                       
                       plim_distance = 10^((PL_target-20*log10(freq)-32.44)/20);
   
                   case '2-Ray'
                       set(handles.path_loss_disp_text, 'String', link_con(link_num).channel.path_loss_model);

                       plim_distance =two_ray(PL_target, ht, hr, freq)*10^-3;

                   case '3-Ray'
                       set(handles.path_loss_disp_text, 'String', link_con(link_num).channel.path_loss_model);
                       
                       plim_distance =three_ray(PL_target, ht, hr, freq)*10^-3;
                       

                   case 'Sea Radio-Wave Propagation Loss'
                       set(handles.path_loss_disp_text, 'String', link_con(link_num).channel.path_loss_model);
                       
                       plim_distance = srwpl(PL_target, ht, hr, freq)*10^-3;
        
               end
               
               set(handles.range_display_text, 'String',plim_distance) 
               set(handles.techno_disp_text, 'String',link_con(link_num).technology ) 
               
                switch link_con(link_num).technology 

                    case 'DSC'
                         Qm = 2;
                         datarate = 100; 

                         Rb = datarate ; 

                         mod_sch = 'FSK';
                         EbN0 = EbN0_value(ber_target,mod_sch,channel_type);
                         SINR = EbN0*(Rb/B_noise);
                         SINR_db = 10*log10(SINR);
                         Pr_min = SINR_db + Interf_Noise;
                         PL_target = Ptx + G_ant - Cable_losses - Pr_min;
                         x = ht_cords(1);  
                         y = ht_cords(2);
                         
                         dsc_throughput = 100; %bps
                         set(handles.throughput_display_text, 'String',(dsc_throughput*10^-6)) 

                         switch link_con(link_num).channel.path_loss_model

                                     case 'FSPL'

                                         tput_distance = 10^((PL_target-20*log10(freq)-32.44)/20);
                                         
                                         if dlosh > tput_distance(1)

                                         colour = 'b';
                                         handles.tput_plot1 = tput_plot(x,y,tput_distance ,handles.map,colour);
                                         txt1 = [ num2str(dsc_throughput) ' bps' ' (FSK)']; 
                                         i_am_legend = legend(handles.map,[handles.tput_plot1],{txt1},'Location','best');
                                         title(i_am_legend,'DSC Throuput per Mod. Sch.') 
                                         
                                         set(handles.range_display_text, 'String',tput_distance)
                                         
                                         end


                                     case '2-Ray'
                                         
                                         

                                         tput_distance = two_ray(PL_target, ht, hr, freq);
                                         tput_distance = tput_distance*10^-3;
                                         
                                         if dlosh > tput_distance(1)

                                         colour = 'b';
                                         handles.tput_plot1 = tput_plot(x,y,tput_distance ,handles.map,colour);
                                         txt1 = [ num2str(dsc_throughput) ' bps' ' (FSK)']; 
                                         i_am_legend = legend(handles.map,[handles.tput_plot1],{txt1},'Location','best');
                                         title(i_am_legend,'DSC Throuput per Mod. Sch.') 
                                         
                                         set(handles.range_display_text, 'String',tput_distance)
                                         
                                         end


                                     case '3-Ray'
                                         tput_distance = three_ray(PL_target, ht, hr, freq);
                                         tput_distance = tput_distance*10^-3;   
                                         
                                         if dlosh > tput_distance(1)

                                         colour = 'b';
                                         handles.tput_plot1 = tput_plot(x,y,tput_distance ,handles.map,colour);
                                         txt1 = [ num2str(dsc_throughput) ' bps' ' (FSK)']; 
                                         i_am_legend = legend(handles.map,[handles.tput_plot1],{txt1},'Location','best');
                                         title(i_am_legend,'DSC Throuput per Mod. Sch.') 
                                         
                                         set(handles.range_display_text, 'String',tput_distance)
                                         
                                         end


                                     case 'Sea Radio-Wave Propagation Loss'
                                         tput_distance = srwpl(PL_target, ht, hr, freq);
                                         tput_distance = tput_distance*10^-3;  
                                         
                                         if dlosh > tput_distance(1)

                                         colour = 'b';
                                         handles.tput_plot1 = tput_plot(x,y,tput_distance ,handles.map,colour);
                                         txt1 = [ num2str(dsc_throughput) ' bps' ' (FSK)']; 
                                         i_am_legend = legend(handles.map,[handles.tput_plot1],{txt1},'Location','best');
                                         title(i_am_legend,'DSC Throuput per Mod. Sch.') 
                                         
                                         set(handles.range_display_text, 'String',tput_distance)
                                         
                                         end

                         end



                     case 'LTE-A'
                         
                         B_sys = link_con(link_num).system_params.system_bandwidth;
                         B_sys = num2str(B_sys);
                         switch B_sys


                             case '1.4'
                                 PDSCH_RE_frame = 4912; %Extended CP, CFI = 3, BW = 1.4 MHz

                             case '3'
                                 PDSCH_RE_frame = 14812; %Extended CP, CFI = 3

                             case '5'
                                 PDSCH_RE_frame = 25012; %Extended CP, CFI = 3

                             case '10'
                                 PDSCH_RE_frame = 50512; %Extended CP, CFI = 3

                             case '15'
                                 PDSCH_RE_frame = 76012; %Extended CP, CFI = 3

                             case '20'
                                 PDSCH_RE_frame = 101512; %Extended CP, CFI = 3
                         end
                         


                         switch link_con(link_num).node_service.ber

                             case '10^-3'
                                 Qm = [1,1,2,2,4,4,6,6,6,6];
                                 code = ["1/2","3/4","1/2","3/4","1/2","3/4","1/2","2/3","3/4","5/6"];

                                 code_rate = [1/2,3/4,1/2,3/4,1/2,3/4,1/2,2/3,3/4,5/6];
                                 phy_tput_frame = ((((PDSCH_RE_frame*Qm)/(10*10^-3))).*code_rate)/10^6; %Mbps
                                 phy_tput_frame  = round(phy_tput_frame,2);
                                 set(handles.throughput_display_text, 'String',phy_tput_frame(1))
                                 
                                 
                                 switch channel_type
                                     
                                     case 'AWGN'
                                         SINR_db = [0,3.3,3,6.3,9.5,13,13.7,16.9,17.7,18.5];
                                     case 'Rayleigh'
                                         SINR_db = [14.54,19.16,17.54,22.16,23.6,28.5,26.36,30.84,31.96,33.08];                                       
                                 end
                                 
                                 Pr_min = SINR_db + Interf_Noise;        
                                 PL_target = Ptx + G_ant - Cable_losses - Pr_min;                
                                 x = ht_cords(1);          
                                 y = ht_cords(2);

                                 switch link_con(link_num).channel.path_loss_model

                                     case 'FSPL'

                                         tput_distance = 10.^((PL_target-20*log10(freq)-32.44)/20);
                                         
                                         if dlosh > tput_distance(1)
                                         
                                         set(handles.range_display_text, 'String',tput_distance(1)) 
                                          
                                         colour = 'y'; 
                                         %BPSK 1/2                                 
                                         handles.tput_plot1 = tput_plot(x,y,tput_distance(1) ,handles.map,colour);
                                         txt1 = [ num2str(phy_tput_frame(1)) ' Mbps' ' (BPSK 1/2)']; 
                                         
                                         
                                         colour = [216/255 133/255 49/255]; 
                                         %BPSK 3/4 
                                         handles.tput_plot2 = tput_plot(x,y,tput_distance(2) ,handles.map,colour);
                                         txt2 = [num2str(phy_tput_frame(2)) ' Mbps' ' (BPSK 3/4)'];

                                         colour = [7/255 164/255 18/255]; 
                                         %QPSK 1/2             
                                         handles.tput_plot3= tput_plot(x,y,tput_distance(3) ,handles.map,colour);
                                         txt3 = [num2str(phy_tput_frame(3)) ' Mbps' ' (QPSK 1/2)'];

                                         colour = [116/255 11/255 128/255]; 
                                         %QPSK 3/4                                 
                                         handles.tput_plot4 = tput_plot(x,y,tput_distance(4) ,handles.map,colour);
                                         txt4 = [num2str(phy_tput_frame(4)) ' Mbps' ' (QPSK 3/4)'];

                                         colour = 'c'; 
                                         %16QAM 1/2  
                                         handles.tput_plot5 = tput_plot(x,y,tput_distance(5) ,handles.map,colour);
                                         txt5 = [num2str(phy_tput_frame(5)) ' Mbps' ' (16QAM 1/2)'];

                                         colour = 'b'; 
                                         %16QAM 3/4               
                                         handles.tput_plot6= tput_plot(x,y,tput_distance(6) ,handles.map,colour);
                                         txt6 = [num2str(phy_tput_frame(6)) ' Mbps' ' (16QAM 3/4)'];

                                         colour = 'm'; 
                                         %64QAM 1/2                                 
                                         handles.tput_plot7 = tput_plot(x,y,tput_distance(7) ,handles.map,colour); 
                                         txt7 = [num2str(phy_tput_frame(7)) ' Mbps' ' (64QAM 1/2)'];

                                         colour = 'g';
                                         %64QAM 2/3 
                                         handles.tput_plot8 = tput_plot(x,y,tput_distance(8) ,handles.map,colour);
                                         txt8 = [num2str(phy_tput_frame(8)) ' Mbps' ' (64QAM 2/3)'];

                                         colour = [243/255 197/255 91/255]; 
                                         %64QAM 3/4                 
                                         handles.tput_plot9= tput_plot(x,y,tput_distance(9) ,handles.map,colour);
                                         txt9 = [num2str(phy_tput_frame(9)) ' Mbps' ' (64QAM 3/4)'];

                                         colour = [127/255 0/255 255/255];
                                         %64QAM 5/6                 
                                         handles.tput_plot10= tput_plot(x,y,tput_distance(10) ,handles.map,colour);
                                         txt10 = [num2str(phy_tput_frame(10)) ' Mbps' ' (64QAM 5/6)'];
                                     
                                       i_am_legend = legend(handles.map,[handles.tput_plot1,handles.tput_plot2,handles.tput_plot3,handles.tput_plot4,handles.tput_plot5,handles.tput_plot6,handles.tput_plot7,handles.tput_plot8,handles.tput_plot9,handles.tput_plot10],{txt1,txt2,txt3,txt4,txt5,txt6,txt7,txt8,txt9,txt10},'Location','best');
                                         title(i_am_legend,'LTE Max. PHY Throuput per MCS')
                                         
                                         end

                                     case '2-Ray'

                                         tput_distance = [two_ray(PL_target(1), ht, hr, freq),two_ray(PL_target(2), ht, hr, freq),two_ray(PL_target(3), ht, hr, freq),two_ray(PL_target(4), ht, hr, freq),two_ray(PL_target(5), ht, hr, freq),two_ray(PL_target(6), ht, hr, freq),two_ray(PL_target(7), ht, hr, freq),two_ray(PL_target(8), ht, hr, freq),two_ray(PL_target(9), ht, hr, freq),two_ray(PL_target(10), ht, hr, freq)];
                                         tput_distance = tput_distance*10^-3;
                                         
                                         if dlosh > tput_distance(1)

                                         set(handles.range_display_text, 'String',tput_distance(1)) 
                                          
                                         colour = 'y'; 
                                         %BPSK 1/2                                 
                                         handles.tput_plot1 = tput_plot(x,y,tput_distance(1) ,handles.map,colour);
                                         txt1 = [ num2str(phy_tput_frame(1)) ' Mbps' ' (BPSK 1/2)']; 
                                         
                                         colour = [216/255 133/255 49/255]; 
                                         %BPSK 3/4 
                                         handles.tput_plot2 = tput_plot(x,y,tput_distance(2) ,handles.map,colour);
                                         txt2 = [num2str(phy_tput_frame(2)) ' Mbps' ' (BPSK 3/4)'];

                                         colour = [7/255 164/255 18/255]; 
                                         %QPSK 1/2             
                                         handles.tput_plot3= tput_plot(x,y,tput_distance(3) ,handles.map,colour);
                                         txt3 = [num2str(phy_tput_frame(3)) ' Mbps' ' (QPSK 1/2)'];

                                         colour = [116/255 11/255 128/255]; 
                                         %QPSK 3/4                                 
                                         handles.tput_plot4 = tput_plot(x,y,tput_distance(4) ,handles.map,colour);
                                         txt4 = [num2str(phy_tput_frame(4)) ' Mbps' ' (QPSK 3/4)'];

                                         colour = 'c'; 
                                         %16QAM 1/2  
                                         handles.tput_plot5 = tput_plot(x,y,tput_distance(5) ,handles.map,colour);
                                         txt5 = [num2str(phy_tput_frame(5)) ' Mbps' ' (16QAM 1/2)'];

                                         colour = 'b'; 
                                         %16QAM 3/4               
                                         handles.tput_plot6= tput_plot(x,y,tput_distance(6) ,handles.map,colour);
                                         txt6 = [num2str(phy_tput_frame(6)) ' Mbps' ' (16QAM 3/4)'];

                                         colour = 'm'; 
                                         %64QAM 1/2                                 
                                         handles.tput_plot7 = tput_plot(x,y,tput_distance(7) ,handles.map,colour); 
                                         txt7 = [num2str(phy_tput_frame(7)) ' Mbps' ' (64QAM 1/2)'];

                                         colour = 'g';
                                         %64QAM 2/3 
                                         handles.tput_plot8 = tput_plot(x,y,tput_distance(8) ,handles.map,colour);
                                         txt8 = [num2str(phy_tput_frame(8)) ' Mbps' ' (64QAM 2/3)'];

                                         colour = [243/255 197/255 91/255]; 
                                         %64QAM 3/4                 
                                         handles.tput_plot9= tput_plot(x,y,tput_distance(9) ,handles.map,colour);
                                         txt9 = [num2str(phy_tput_frame(9)) ' Mbps' ' (64QAM 3/4)'];

                                         colour = [127/255 0/255 255/255];
                                         %64QAM 5/6                 
                                         handles.tput_plot10= tput_plot(x,y,tput_distance(10) ,handles.map,colour);
                                         txt10 = [num2str(phy_tput_frame(10)) ' Mbps' ' (64QAM 5/6)'];
                                     
                                         i_am_legend = legend(handles.map,[handles.tput_plot1,handles.tput_plot2,handles.tput_plot3,handles.tput_plot4,handles.tput_plot5,handles.tput_plot6,handles.tput_plot7,handles.tput_plot8,handles.tput_plot9,handles.tput_plot10],{txt1,txt2,txt3,txt4,txt5,txt6,txt7,txt8,txt9,txt10},'Location','best');
                                         title(i_am_legend,'LTE Max. PHY Throuput per MCS') 
                                         
                                         end

                                     case '3-Ray'
                                         tput_distance = [three_ray(PL_target(1), ht, hr, freq),three_ray(PL_target(2), ht, hr, freq),three_ray(PL_target(3), ht, hr, freq),three_ray(PL_target(4), ht, hr, freq),three_ray(PL_target(5), ht, hr, freq),three_ray(PL_target(6), ht, hr, freq),three_ray(PL_target(7), ht, hr, freq),three_ray(PL_target(8), ht, hr, freq),three_ray(PL_target(9), ht, hr, freq),three_ray(PL_target(10), ht, hr, freq)];
                                         tput_distance = tput_distance*10^-3;      
                                         
                                         if dlosh > tput_distance(1)

                                         set(handles.range_display_text, 'String',tput_distance(1)) 
                                         
                                         colour = 'y'; 
                                         %BPSK 1/2                                 
                                         handles.tput_plot1 = tput_plot(x,y,tput_distance(1) ,handles.map,colour);
                                         txt1 = [ num2str(phy_tput_frame(1)) ' Mbps' ' (BPSK 1/2)']; 
                                         
                                         colour = [216/255 133/255 49/255]; 
                                         %BPSK 3/4 
                                         handles.tput_plot2 = tput_plot(x,y,tput_distance(2) ,handles.map,colour);
                                         txt2 = [num2str(phy_tput_frame(2)) ' Mbps' ' (BPSK 3/4)'];

                                         colour = [7/255 164/255 18/255]; 
                                         %QPSK 1/2             
                                         handles.tput_plot3= tput_plot(x,y,tput_distance(3) ,handles.map,colour);
                                         txt3 = [num2str(phy_tput_frame(3)) ' Mbps' ' (QPSK 1/2)'];

                                         colour = [116/255 11/255 128/255]; 
                                         %QPSK 3/4                                 
                                         handles.tput_plot4 = tput_plot(x,y,tput_distance(4) ,handles.map,colour);
                                         txt4 = [num2str(phy_tput_frame(4)) ' Mbps' ' (QPSK 3/4)'];

                                         colour = 'c'; 
                                         %16QAM 1/2  
                                         handles.tput_plot5 = tput_plot(x,y,tput_distance(5) ,handles.map,colour);
                                         txt5 = [num2str(phy_tput_frame(5)) ' Mbps' ' (16QAM 1/2)'];

                                         colour = 'b'; 
                                         %16QAM 3/4               
                                         handles.tput_plot6= tput_plot(x,y,tput_distance(6) ,handles.map,colour);
                                         txt6 = [num2str(phy_tput_frame(6)) ' Mbps' ' (16QAM 3/4)'];

                                         colour = 'm'; 
                                         %64QAM 1/2                                 
                                         handles.tput_plot7 = tput_plot(x,y,tput_distance(7) ,handles.map,colour); 
                                         txt7 = [num2str(phy_tput_frame(7)) ' Mbps' ' (64QAM 1/2)'];

                                         colour = 'g';
                                         %64QAM 2/3 
                                         handles.tput_plot8 = tput_plot(x,y,tput_distance(8) ,handles.map,colour);
                                         txt8 = [num2str(phy_tput_frame(8)) ' Mbps' ' (64QAM 2/3)'];

                                         colour = [243/255 197/255 91/255]; 
                                         %64QAM 3/4                 
                                         handles.tput_plot9= tput_plot(x,y,tput_distance(9) ,handles.map,colour);
                                         txt9 = [num2str(phy_tput_frame(9)) ' Mbps' ' (64QAM 3/4)'];

                                         colour = [127/255 0/255 255/255];
                                         %64QAM 5/6                 
                                         handles.tput_plot10= tput_plot(x,y,tput_distance(10) ,handles.map,colour);
                                         txt10 = [num2str(phy_tput_frame(10)) ' Mbps' ' (64QAM 5/6)'];
                                     
                                         i_am_legend = legend(handles.map,[handles.tput_plot1,handles.tput_plot2,handles.tput_plot3,handles.tput_plot4,handles.tput_plot5,handles.tput_plot6,handles.tput_plot7,handles.tput_plot8,handles.tput_plot9,handles.tput_plot10],{txt1,txt2,txt3,txt4,txt5,txt6,txt7,txt8,txt9,txt10},'Location','best');
                                         title(i_am_legend,'LTE Max. PHY Throuput per MCS')  
                                         
                                         end

                                     case 'Sea Radio-Wave Propagation Loss'
                                         tput_distance = [srwpl(PL_target(1), ht, hr, freq),srwpl(PL_target(2), ht, hr, freq),srwpl(PL_target(3), ht, hr, freq),srwpl(PL_target(4), ht, hr, freq),srwpl(PL_target(5), ht, hr, freq),srwpl(PL_target(6), ht, hr, freq),srwpl(PL_target(7), ht, hr, freq),srwpl(PL_target(8), ht, hr, freq),srwpl(PL_target(9), ht, hr, freq),srwpl(PL_target(10), ht, hr, freq)];
                                         tput_distance = tput_distance*10^-3;       
                                         
                                         if dlosh > tput_distance(1)

                                         set(handles.range_display_text, 'String',tput_distance(1)) 
                                         
                                         colour = 'y'; 
                                         %BPSK 1/2                                 
                                         handles.tput_plot1 = tput_plot(x,y,tput_distance(1) ,handles.map,colour);
                                         txt1 = [ num2str(phy_tput_frame(1)) ' Mbps' ' (BPSK 1/2)']; 
                                         
                                         colour = [216/255 133/255 49/255]; 
                                         %BPSK 3/4 
                                         handles.tput_plot2 = tput_plot(x,y,tput_distance(2) ,handles.map,colour);
                                         txt2 = [num2str(phy_tput_frame(2)) ' Mbps' ' (BPSK 3/4)'];

                                         colour = [7/255 164/255 18/255]; 
                                         %QPSK 1/2             
                                         handles.tput_plot3= tput_plot(x,y,tput_distance(3) ,handles.map,colour);
                                         txt3 = [num2str(phy_tput_frame(3)) ' Mbps' ' (QPSK 1/2)'];

                                         colour = [116/255 11/255 128/255]; 
                                         %QPSK 3/4                                 
                                         handles.tput_plot4 = tput_plot(x,y,tput_distance(4) ,handles.map,colour);
                                         txt4 = [num2str(phy_tput_frame(4)) ' Mbps' ' (QPSK 3/4)'];

                                         colour = 'c'; 
                                         %16QAM 1/2  
                                         handles.tput_plot5 = tput_plot(x,y,tput_distance(5) ,handles.map,colour);
                                         txt5 = [num2str(phy_tput_frame(5)) ' Mbps' ' (16QAM 1/2)'];

                                         colour = 'b'; 
                                         %16QAM 3/4               
                                         handles.tput_plot6= tput_plot(x,y,tput_distance(6) ,handles.map,colour);
                                         txt6 = [num2str(phy_tput_frame(6)) ' Mbps' ' (16QAM 3/4)'];

                                         colour = 'm'; 
                                         %64QAM 1/2                                 
                                         handles.tput_plot7 = tput_plot(x,y,tput_distance(7) ,handles.map,colour); 
                                         txt7 = [num2str(phy_tput_frame(7)) ' Mbps' ' (64QAM 1/2)'];

                                         colour = 'g';
                                         %64QAM 2/3 
                                         handles.tput_plot8 = tput_plot(x,y,tput_distance(8) ,handles.map,colour);
                                         txt8 = [num2str(phy_tput_frame(8)) ' Mbps' ' (64QAM 2/3)'];

                                         colour = [243/255 197/255 91/255]; 
                                         %64QAM 3/4                 
                                         handles.tput_plot9= tput_plot(x,y,tput_distance(9) ,handles.map,colour);
                                         txt9 = [num2str(phy_tput_frame(9)) ' Mbps' ' (64QAM 3/4)'];

                                         colour = [127/255 0/255 255/255];
                                         %64QAM 5/6                 
                                         handles.tput_plot10= tput_plot(x,y,tput_distance(10) ,handles.map,colour);
                                         txt10 = [num2str(phy_tput_frame(10)) ' Mbps' ' (64QAM 5/6)'];
                                     
                                         i_am_legend = legend(handles.map,[handles.tput_plot1,handles.tput_plot2,handles.tput_plot3,handles.tput_plot4,handles.tput_plot5,handles.tput_plot6,handles.tput_plot7,handles.tput_plot8,handles.tput_plot9,handles.tput_plot10],{txt1,txt2,txt3,txt4,txt5,txt6,txt7,txt8,txt9,txt10},'Location','best');
                                         title(i_am_legend,'LTE Max. PHY Throuput per MCS')  
                                         
                                         end
                                 end 
                                 
                             case '10^-6'
                                 Qm = [1,1,2,2,4,4,6,6,6,6];
                                 code = ["1/2","3/4","1/2","3/4","1/2","3/4","1/2","2/3","3/4","5/6"];

                                 code_rate = [1/2,3/4,1/2,3/4,1/2,3/4,1/2,2/3,3/4,5/6];
                                 phy_tput_frame = ((((PDSCH_RE_frame*Qm)/(10*10^-3))).*code_rate)/10^6; %Mbps
                                 phy_tput_frame  = round(phy_tput_frame,2);
                                 set(handles.throughput_display_text, 'String',phy_tput_frame(1))
                                 
                                 
                                 switch channel_type
                                     
                                     case 'AWGN'
                                         SINR_db = [1.5,5.7,4.5,8.7,12.5,15.4,16.1,19.3,20.1,20.9];
                                     case 'Rayleigh'
                                         SINR_db = [35,43.4,38,46.4,46,51.8,46.6,53,54.6,56.2];                                       
                                 end
                                 
                                 Pr_min = SINR_db + Interf_Noise;        
                                 PL_target = Ptx + G_ant - Cable_losses - Pr_min;                
                                 x = ht_cords(1);          
                                 y = ht_cords(2);

                                 switch link_con(link_num).channel.path_loss_model

                                     case 'FSPL'

                                         tput_distance = 10.^((PL_target-20*log10(freq)-32.44)/20);
                                         
                                         if dlosh > tput_distance(1)
                                         
                                         set(handles.range_display_text, 'String',tput_distance(1)) 
%                                          
                                         colour = 'y'; 
                                         %BPSK 1/2                                 
                                         handles.tput_plot1 = tput_plot(x,y,tput_distance(1) ,handles.map,colour);
                                         txt1 = [ num2str(phy_tput_frame(1)) ' Mbps' ' (BPSK 1/2)']; 
                                         
                                         
                                         colour = [216/255 133/255 49/255]; 
                                         %BPSK 3/4 
                                         handles.tput_plot2 = tput_plot(x,y,tput_distance(2) ,handles.map,colour);
                                         txt2 = [num2str(phy_tput_frame(2)) ' Mbps' ' (BPSK 3/4)'];

                                         colour = [7/255 164/255 18/255]; 
                                         %QPSK 1/2             
                                         handles.tput_plot3= tput_plot(x,y,tput_distance(3) ,handles.map,colour);
                                         txt3 = [num2str(phy_tput_frame(3)) ' Mbps' ' (QPSK 1/2)'];

                                         colour = [116/255 11/255 128/255]; 
                                         %QPSK 3/4                                 
                                         handles.tput_plot4 = tput_plot(x,y,tput_distance(4) ,handles.map,colour);
                                         txt4 = [num2str(phy_tput_frame(4)) ' Mbps' ' (QPSK 3/4)'];

                                         colour = 'c'; 
                                         %16QAM 1/2  
                                         handles.tput_plot5 = tput_plot(x,y,tput_distance(5) ,handles.map,colour);
                                         txt5 = [num2str(phy_tput_frame(5)) ' Mbps' ' (16QAM 1/2)'];

                                         colour = 'b'; 
                                         %16QAM 3/4               
                                         handles.tput_plot6= tput_plot(x,y,tput_distance(6) ,handles.map,colour);
                                         txt6 = [num2str(phy_tput_frame(6)) ' Mbps' ' (16QAM 3/4)'];

                                         colour = 'm'; 
                                         %64QAM 1/2                                 
                                         handles.tput_plot7 = tput_plot(x,y,tput_distance(7) ,handles.map,colour); 
                                         txt7 = [num2str(phy_tput_frame(7)) ' Mbps' ' (64QAM 1/2)'];

                                         colour = 'g';
                                         %64QAM 2/3 
                                         handles.tput_plot8 = tput_plot(x,y,tput_distance(8) ,handles.map,colour);
                                         txt8 = [num2str(phy_tput_frame(8)) ' Mbps' ' (64QAM 2/3)'];

                                         colour = [243/255 197/255 91/255]; 
                                         %64QAM 3/4                 
                                         handles.tput_plot9= tput_plot(x,y,tput_distance(9) ,handles.map,colour);
                                         txt9 = [num2str(phy_tput_frame(9)) ' Mbps' ' (64QAM 3/4)'];

                                         colour = [127/255 0/255 255/255];
                                         %64QAM 5/6                 
                                         handles.tput_plot10= tput_plot(x,y,tput_distance(10) ,handles.map,colour);
                                         txt10 = [num2str(phy_tput_frame(10)) ' Mbps' ' (64QAM 5/6)'];
                                     
                                         i_am_legend = legend(handles.map,[handles.tput_plot1,handles.tput_plot2,handles.tput_plot3,handles.tput_plot4,handles.tput_plot5,handles.tput_plot6,handles.tput_plot7,handles.tput_plot8,handles.tput_plot9,handles.tput_plot10],{txt1,txt2,txt3,txt4,txt5,txt6,txt7,txt8,txt9,txt10},'Location','best');
                                         title(i_am_legend,'LTE Max. PHY Throuput per MCS')
                                         
                                         end

                                     case '2-Ray'

                                         tput_distance = [two_ray(PL_target(1), ht, hr, freq),two_ray(PL_target(2), ht, hr, freq),two_ray(PL_target(3), ht, hr, freq),two_ray(PL_target(4), ht, hr, freq),two_ray(PL_target(5), ht, hr, freq),two_ray(PL_target(6), ht, hr, freq),two_ray(PL_target(7), ht, hr, freq),two_ray(PL_target(8), ht, hr, freq),two_ray(PL_target(9), ht, hr, freq),two_ray(PL_target(10), ht, hr, freq)];
                                         tput_distance = tput_distance*10^-3;
                                         
                                         if dlosh > tput_distance(1)

                                         set(handles.range_display_text, 'String',tput_distance(1)) 
                                          
                                         colour = 'y'; 
                                         %BPSK 1/2                                 
                                         handles.tput_plot1 = tput_plot(x,y,tput_distance(1) ,handles.map,colour);
                                         txt1 = [ num2str(phy_tput_frame(1)) ' Mbps' ' (BPSK 1/2)']; 
                                         
                                         colour = [216/255 133/255 49/255]; 
                                         %BPSK 3/4 
                                         handles.tput_plot2 = tput_plot(x,y,tput_distance(2) ,handles.map,colour);
                                         txt2 = [num2str(phy_tput_frame(2)) ' Mbps' ' (BPSK 3/4)'];

                                         colour = [7/255 164/255 18/255]; 
                                         %QPSK 1/2             
                                         handles.tput_plot3= tput_plot(x,y,tput_distance(3) ,handles.map,colour);
                                         txt3 = [num2str(phy_tput_frame(3)) ' Mbps' ' (QPSK 1/2)'];

                                         colour = [116/255 11/255 128/255]; 
                                         %QPSK 3/4                                 
                                         handles.tput_plot4 = tput_plot(x,y,tput_distance(4) ,handles.map,colour);
                                         txt4 = [num2str(phy_tput_frame(4)) ' Mbps' ' (QPSK 3/4)'];

                                         colour = 'c'; 
                                         %16QAM 1/2  
                                         handles.tput_plot5 = tput_plot(x,y,tput_distance(5) ,handles.map,colour);
                                         txt5 = [num2str(phy_tput_frame(5)) ' Mbps' ' (16QAM 1/2)'];

                                         colour = 'b'; 
                                         %16QAM 3/4               
                                         handles.tput_plot6= tput_plot(x,y,tput_distance(6) ,handles.map,colour);
                                         txt6 = [num2str(phy_tput_frame(6)) ' Mbps' ' (16QAM 3/4)'];

                                         colour = 'm'; 
                                         %64QAM 1/2                                 
                                         handles.tput_plot7 = tput_plot(x,y,tput_distance(7) ,handles.map,colour); 
                                         txt7 = [num2str(phy_tput_frame(7)) ' Mbps' ' (64QAM 1/2)'];

                                         colour = 'g';
                                         %64QAM 2/3 
                                         handles.tput_plot8 = tput_plot(x,y,tput_distance(8) ,handles.map,colour);
                                         txt8 = [num2str(phy_tput_frame(8)) ' Mbps' ' (64QAM 2/3)'];

                                         colour = [243/255 197/255 91/255]; 
                                         %64QAM 3/4                 
                                         handles.tput_plot9= tput_plot(x,y,tput_distance(9) ,handles.map,colour);
                                         txt9 = [num2str(phy_tput_frame(9)) ' Mbps' ' (64QAM 3/4)'];

                                         colour = [127/255 0/255 255/255];
                                         %64QAM 5/6                 
                                         handles.tput_plot10= tput_plot(x,y,tput_distance(10) ,handles.map,colour);
                                         txt10 = [num2str(phy_tput_frame(10)) ' Mbps' ' (64QAM 5/6)'];
                                     
                                         i_am_legend = legend(handles.map,[handles.tput_plot1,handles.tput_plot2,handles.tput_plot3,handles.tput_plot4,handles.tput_plot5,handles.tput_plot6,handles.tput_plot7,handles.tput_plot8,handles.tput_plot9,handles.tput_plot10],{txt1,txt2,txt3,txt4,txt5,txt6,txt7,txt8,txt9,txt10},'Location','best');
                                         title(i_am_legend,'LTE Max. PHY Throuput per MCS')   
                                         
                                         end

                                     case '3-Ray'
                                         tput_distance = [three_ray(PL_target(1), ht, hr, freq),three_ray(PL_target(2), ht, hr, freq),three_ray(PL_target(3), ht, hr, freq),three_ray(PL_target(4), ht, hr, freq),three_ray(PL_target(5), ht, hr, freq),three_ray(PL_target(6), ht, hr, freq),three_ray(PL_target(7), ht, hr, freq),three_ray(PL_target(8), ht, hr, freq),three_ray(PL_target(9), ht, hr, freq),three_ray(PL_target(10), ht, hr, freq)];
                                         tput_distance = tput_distance*10^-3;   
                                         
                                         if dlosh > tput_distance(1)

                                         set(handles.range_display_text, 'String',tput_distance(1)) 
                                         
                                         colour = 'y'; 
                                         %BPSK 1/2                                 
                                         handles.tput_plot1 = tput_plot(x,y,tput_distance(1) ,handles.map,colour);
                                         txt1 = [ num2str(phy_tput_frame(1)) ' Mbps' ' (BPSK 1/2)']; 
                                         
                                         colour = [216/255 133/255 49/255]; 
                                         %BPSK 3/4 
                                         handles.tput_plot2 = tput_plot(x,y,tput_distance(2) ,handles.map,colour);
                                         txt2 = [num2str(phy_tput_frame(2)) ' Mbps' ' (BPSK 3/4)'];

                                         colour = [7/255 164/255 18/255]; 
                                         %QPSK 1/2             
                                         handles.tput_plot3= tput_plot(x,y,tput_distance(3) ,handles.map,colour);
                                         txt3 = [num2str(phy_tput_frame(3)) ' Mbps' ' (QPSK 1/2)'];

                                         colour = [116/255 11/255 128/255]; 
                                         %QPSK 3/4                                 
                                         handles.tput_plot4 = tput_plot(x,y,tput_distance(4) ,handles.map,colour);
                                         txt4 = [num2str(phy_tput_frame(4)) ' Mbps' ' (QPSK 3/4)'];

                                         colour = 'c'; 
                                         %16QAM 1/2  
                                         handles.tput_plot5 = tput_plot(x,y,tput_distance(5) ,handles.map,colour);
                                         txt5 = [num2str(phy_tput_frame(5)) ' Mbps' ' (16QAM 1/2)'];

                                         colour = 'b'; 
                                         %16QAM 3/4               
                                         handles.tput_plot6= tput_plot(x,y,tput_distance(6) ,handles.map,colour);
                                         txt6 = [num2str(phy_tput_frame(6)) ' Mbps' ' (16QAM 3/4)'];

                                         colour = 'm'; 
                                         %64QAM 1/2                                 
                                         handles.tput_plot7 = tput_plot(x,y,tput_distance(7) ,handles.map,colour); 
                                         txt7 = [num2str(phy_tput_frame(7)) ' Mbps' ' (64QAM 1/2)'];

                                         colour = 'g';
                                         %64QAM 2/3 
                                         handles.tput_plot8 = tput_plot(x,y,tput_distance(8) ,handles.map,colour);
                                         txt8 = [num2str(phy_tput_frame(8)) ' Mbps' ' (64QAM 2/3)'];

                                         colour = [243/255 197/255 91/255]; 
                                         %64QAM 3/4                 
                                         handles.tput_plot9= tput_plot(x,y,tput_distance(9) ,handles.map,colour);
                                         txt9 = [num2str(phy_tput_frame(9)) ' Mbps' ' (64QAM 3/4)'];

                                         colour = [127/255 0/255 255/255];
                                         %64QAM 5/6                 
                                         handles.tput_plot10= tput_plot(x,y,tput_distance(10) ,handles.map,colour);
                                         txt10 = [num2str(phy_tput_frame(10)) ' Mbps' ' (64QAM 5/6)'];
                                     
                                         i_am_legend = legend(handles.map,[handles.tput_plot1,handles.tput_plot2,handles.tput_plot3,handles.tput_plot4,handles.tput_plot5,handles.tput_plot6,handles.tput_plot7,handles.tput_plot8,handles.tput_plot9,handles.tput_plot10],{txt1,txt2,txt3,txt4,txt5,txt6,txt7,txt8,txt9,txt10},'Location','best');
                                         title(i_am_legend,'LTE Max. PHY Throuput per MCS')     
                                         
                                         end

                                     case 'Sea Radio-Wave Propagation Loss'
                                         tput_distance = [srwpl(PL_target(1), ht, hr, freq),srwpl(PL_target(2), ht, hr, freq),srwpl(PL_target(3), ht, hr, freq),srwpl(PL_target(4), ht, hr, freq),srwpl(PL_target(5), ht, hr, freq),srwpl(PL_target(6), ht, hr, freq),srwpl(PL_target(7), ht, hr, freq),srwpl(PL_target(8), ht, hr, freq),srwpl(PL_target(9), ht, hr, freq),srwpl(PL_target(10), ht, hr, freq)];
                                         tput_distance = tput_distance*10^-3;   
                                         
                                         if dlosh > tput_distance(1)

                                         set(handles.range_display_text, 'String',tput_distance(1)) 
                                         
                                         colour = 'y'; 
                                         %BPSK 1/2                                 
                                         handles.tput_plot1 = tput_plot(x,y,tput_distance(1) ,handles.map,colour);
                                         txt1 = [ num2str(phy_tput_frame(1)) ' Mbps' ' (BPSK 1/2)']; 
                                         
                                         colour = [216/255 133/255 49/255]; 
                                         %BPSK 3/4 
                                         handles.tput_plot2 = tput_plot(x,y,tput_distance(2) ,handles.map,colour);
                                         txt2 = [num2str(phy_tput_frame(2)) ' Mbps' ' (BPSK 3/4)'];

                                         colour = [7/255 164/255 18/255]; 
                                         %QPSK 1/2             
                                         handles.tput_plot3= tput_plot(x,y,tput_distance(3) ,handles.map,colour);
                                         txt3 = [num2str(phy_tput_frame(3)) ' Mbps' ' (QPSK 1/2)'];

                                         colour = [116/255 11/255 128/255]; 
                                         %QPSK 3/4                                 
                                         handles.tput_plot4 = tput_plot(x,y,tput_distance(4) ,handles.map,colour);
                                         txt4 = [num2str(phy_tput_frame(4)) ' Mbps' ' (QPSK 3/4)'];

                                         colour = 'c'; 
                                         %16QAM 1/2  
                                         handles.tput_plot5 = tput_plot(x,y,tput_distance(5) ,handles.map,colour);
                                         txt5 = [num2str(phy_tput_frame(5)) ' Mbps' ' (16QAM 1/2)'];

                                         colour = 'b'; 
                                         %16QAM 3/4               
                                         handles.tput_plot6= tput_plot(x,y,tput_distance(6) ,handles.map,colour);
                                         txt6 = [num2str(phy_tput_frame(6)) ' Mbps' ' (16QAM 3/4)'];

                                         colour = 'm'; 
                                         %64QAM 1/2                                 
                                         handles.tput_plot7 = tput_plot(x,y,tput_distance(7) ,handles.map,colour); 
                                         txt7 = [num2str(phy_tput_frame(7)) ' Mbps' ' (64QAM 1/2)'];

                                         colour = 'g';
                                         %64QAM 2/3 
                                         handles.tput_plot8 = tput_plot(x,y,tput_distance(8) ,handles.map,colour);
                                         txt8 = [num2str(phy_tput_frame(8)) ' Mbps' ' (64QAM 2/3)'];

                                         colour = [243/255 197/255 91/255]; 
                                         %64QAM 3/4                 
                                         handles.tput_plot9= tput_plot(x,y,tput_distance(9) ,handles.map,colour);
                                         txt9 = [num2str(phy_tput_frame(9)) ' Mbps' ' (64QAM 3/4)'];

                                         colour = [127/255 0/255 255/255];
                                         %64QAM 5/6                 
                                         handles.tput_plot10= tput_plot(x,y,tput_distance(10) ,handles.map,colour);
                                         txt10 = [num2str(phy_tput_frame(10)) ' Mbps' ' (64QAM 5/6)'];
                                     
                                         i_am_legend = legend(handles.map,[handles.tput_plot1,handles.tput_plot2,handles.tput_plot3,handles.tput_plot4,handles.tput_plot5,handles.tput_plot6,handles.tput_plot7,handles.tput_plot8,handles.tput_plot9,handles.tput_plot10],{txt1,txt2,txt3,txt4,txt5,txt6,txt7,txt8,txt9,txt10},'Location','best');
                                         title(i_am_legend,'LTE Max. PHY Throuput per MCS') 
                                         
                                         end
                                 end 
                                 
                                 

                             otherwise

                                 Qm = [2,4,6];
                                 Rb = ((RE_frame*Qm)/(10*10^-3)); 
                                 EbN0 = [EbN0_value(ber_target,'QPSK',channel_type),EbN0_value(ber_target,'16QAM',channel_type),EbN0_value(ber_target,'64QAM',channel_type)];

                                 SINR = EbN0.*(Rb/B_noise);         
                                 SINR_db = 10*log10(SINR);                  
                                 Pr_min = SINR_db + Interf_Noise;        
                                 PL_target = Ptx + G_ant - Cable_losses - Pr_min;                
                                 x = ht_cords(1);          
                                 y = ht_cords(2);
                                 
                                 phy_tput_frame = ((PDSCH_RE_frame*Qm)/(10*10^-3))/10^6;
                                 set(handles.throughput_display_text, 'String',phy_tput_frame(1)) 
                                 

                                 switch link_con(link_num).channel.path_loss_model

                                     case 'FSPL'

                                         tput_distance = 10.^((PL_target-20*log10(freq)-32.44)/20);
                                         
                                         if dlosh > tput_distance(1)
                                         
                                         set(handles.range_display_text, 'String',tput_distance(1)) 

                                         colour = 'y'; 
                                         %QPSK                                  
                                         handles.tput_plot1 = tput_plot(x,y,tput_distance(1) ,handles.map,colour);
                                         txt1 = [ num2str(phy_tput_frame(1)) ' Mbps' ' (QPSK)']; 
                                         
                                         colour = 'b'; 
                                         %16QAM
                                         handles.tput_plot2 = tput_plot(x,y,tput_distance(2) ,handles.map,colour);
                                         txt2 = [num2str(phy_tput_frame(2)) ' Mbps' ' (16QAM)'];

                                         colour = 'g';
                                         %64QAM                 
                                         handles.tput_plot3= tput_plot(x,y,tput_distance(3) ,handles.map,colour);
                                         txt3 = [num2str(phy_tput_frame(3)) ' Mbps' ' (64QAM)'];
                                         
                                         i_am_legend = legend(handles.map,[handles.tput_plot1,handles.tput_plot2,handles.tput_plot3],{txt1,txt2,txt3},'Location','best');
                                         title(i_am_legend,'LTE Max. PHY Throuput per Mod. Sch.')
                                         
                                         end
                                         
                                     case '2-Ray'

                                         tput_distance = [two_ray(PL_target(1), ht, hr, freq),two_ray(PL_target(2), ht, hr, freq),two_ray(PL_target(3), ht, hr, freq)];
                                         tput_distance = tput_distance*10^-3;
                                         
                                         if dlosh > tput_distance(1)
                                         
                                         set(handles.range_display_text, 'String',tput_distance(1)) 

                                         colour = 'y'; 
                                         %QPSK                                  
                                         handles.tput_plot1 = tput_plot(x,y,tput_distance(1) ,handles.map,colour);
                                         txt1 = [ num2str(phy_tput_frame(1)) ' Mbps' ' (QPSK)']; 
                                         
                                         colour = 'b'; 
                                         %16QAM
                                         handles.tput_plot2 = tput_plot(x,y,tput_distance(2) ,handles.map,colour);
                                         txt2 = [num2str(phy_tput_frame(2)) ' Mbps' ' (16QAM)'];

                                         colour = 'g';
                                         %64QAM                 
                                         handles.tput_plot3= tput_plot(x,y,tput_distance(3) ,handles.map,colour);
                                         txt3 = [num2str(phy_tput_frame(3)) ' Mbps' ' (64QAM)'];
                                         
                                         i_am_legend = legend(handles.map,[handles.tput_plot1,handles.tput_plot2,handles.tput_plot3],{txt1,txt2,txt3},'Location','best');
                                         title(i_am_legend,'LTE Max. PHY Throuput per Mod. Sch.')
                                         
                                         end
                                         
                                     case '3-Ray'
                                         tput_distance = [three_ray(PL_target(1), ht, hr, freq),three_ray(PL_target(2), ht, hr, freq),three_ray(PL_target(3), ht, hr, freq)];
                                         tput_distance = tput_distance*10^-3;   
                                         
                                         if dlosh > tput_distance(1)
                                         
                                         set(handles.range_display_text, 'String',tput_distance(1)) 

                                         colour = 'y'; 
                                         %QPSK                                  
                                         handles.tput_plot1 = tput_plot(x,y,tput_distance(1) ,handles.map,colour);
                                         txt1 = [ num2str(phy_tput_frame(1)) ' Mbps' ' (QPSK)']; 
                                         
                                         colour = 'b'; 
                                         %16QAM
                                         handles.tput_plot2 = tput_plot(x,y,tput_distance(2) ,handles.map,colour);
                                         txt2 = [num2str(phy_tput_frame(2)) ' Mbps' ' (16QAM)'];

                                         colour = 'g';
                                         %64QAM                 
                                         handles.tput_plot3= tput_plot(x,y,tput_distance(3) ,handles.map,colour);
                                         txt3 = [num2str(phy_tput_frame(3)) ' Mbps' ' (64QAM)'];
                                         
                                         i_am_legend = legend(handles.map,[handles.tput_plot1,handles.tput_plot2,handles.tput_plot3],{txt1,txt2,txt3},'Location','best');
                                         title(i_am_legend,'LTE Max. PHY Throuput per Mod. Sch.')
                                         
                                         end

                                     case 'Sea Radio-Wave Propagation Loss'
                                         tput_distance = [srwpl(PL_target(1), ht, hr, freq),srwpl(PL_target(2), ht, hr, freq),srwpl(PL_target(3), ht, hr, freq)];
                                         tput_distance = tput_distance*10^-3; 
                                         
                                         if dlosh > tput_distance(1)
                                         
                                         set(handles.range_display_text, 'String',tput_distance(1)) 

                                         colour = 'y'; 
                                         %QPSK                                  
                                         handles.tput_plot1 = tput_plot(x,y,tput_distance(1) ,handles.map,colour);
                                         txt1 = [ num2str(phy_tput_frame(1)) ' Mbps' ' (QPSK)']; 
                                         
                                         colour = 'b'; 
                                         %16QAM
                                         handles.tput_plot2 = tput_plot(x,y,tput_distance(2) ,handles.map,colour);
                                         txt2 = [num2str(phy_tput_frame(2)) ' Mbps' ' (16QAM)'];

                                         colour = 'g';
                                         %64QAM                 
                                         handles.tput_plot3= tput_plot(x,y,tput_distance(3) ,handles.map,colour);
                                         txt3 = [num2str(phy_tput_frame(3)) ' Mbps' ' (64QAM)'];
                                         
                                         i_am_legend = legend(handles.map,[handles.tput_plot1,handles.tput_plot2,handles.tput_plot3],{txt1,txt2,txt3},'Location','best');
                                         title(i_am_legend,'LTE Max. PHY Throuput per Mod. Sch.')  
                                         
                                         end
                                 end                
                         end


                     case 'NWR'

                         Qm = 2;
                         datarate = 520.83; 

                         Rb = 520.83; 

                         B_noise = link_con(link_num).receiver.rx_bandwidth*10^6;
                         mod_sch = 'FSK';
                         EbN0 = EbN0_value(ber_target,mod_sch,channel_type);
                         SINR = EbN0*(Rb/B_noise);
                         SINR_db = 10*log10(SINR);
                         Pr_min = SINR_db + Interf_Noise;
                         PL_target = Ptx + G_ant - Cable_losses - Pr_min;

                         x = ht_cords(1);  
                         y = ht_cords(2);
                         
                         nwr_throughput = 484.37;%bps
                         set(handles.throughput_display_text, 'String',(nwr_throughput*10^-6)) 

                         switch link_con(link_num).channel.path_loss_model

                                     case 'FSPL'

                                         tput_distance = 10^((PL_target-20*log10(freq)-32.44)/20);
                                         
                                         if dlosh > tput_distance(1)


                                         colour = 'b';
                                         handles.tput_plot1 = tput_plot(x,y,tput_distance ,handles.map,colour);
                                         txt1 = [ num2str(nwr_throughput) ' bps' ' (FSK)']; 
                                         i_am_legend = legend(handles.map,[handles.tput_plot1],{txt1},'Location','best');
                                         title(i_am_legend,'NWR Throuput per Mod. Sch.') 
                                         
                                         set(handles.range_display_text, 'String',tput_distance)
                                         
                                         end


                                     case '2-Ray'

                                         tput_distance = two_ray(PL_target, ht, hr, freq);
                                         tput_distance = tput_distance*10^-3;
                                         
                                         if dlosh > tput_distance(1)

                                         colour = 'b';
                                         handles.tput_plot1 = tput_plot(x,y,tput_distance ,handles.map,colour);
                                         txt1 = [ num2str(nwr_throughput) ' bps' ' (FSK)']; 
                                         i_am_legend = legend(handles.map,[handles.tput_plot1],{txt1},'Location','best');
                                         title(i_am_legend,'NWR Throuput per Mod. Sch.') 
                                         
                                         set(handles.range_display_text, 'String',tput_distance)
                                         
                                         end
                                         
                                     case '3-Ray'
                                         tput_distance = three_ray(PL_target, ht, hr, freq);
                                         tput_distance = tput_distance*10^-3;    
                                         
                                         if dlosh > tput_distance(1)

                                         colour = 'b';
                                         handles.tput_plot1 = tput_plot(x,y,tput_distance ,handles.map,colour);
                                         txt1 = [ num2str(nwr_throughput) ' bps' ' (FSK)']; 
                                         i_am_legend = legend(handles.map,[handles.tput_plot1],{txt1},'Location','best');
                                         title(i_am_legend,'LTE Max. Max. PHY Throuput per Mod. Sch.') 
                                         
                                         set(handles.range_display_text, 'String',tput_distance)
                                         
                                         end
                                         
                                     case 'Sea Radio-Wave Propagation Loss'
                                         tput_distance = srwpl(PL_target, ht, hr, freq);
                                         tput_distance = tput_distance*10^-3;     
                                         
                                         if dlosh > tput_distance(1)

                                         colour = 'b';
                                         handles.tput_plot1 = tput_plot(x,y,tput_distance ,handles.map,colour);
                                         txt1 = [ num2str(nwr_throughput) ' bps' ' (FSK)']; 
                                         i_am_legend = legend(handles.map,[handles.tput_plot1],{txt1},'Location','best');
                                         title(i_am_legend,'NWR Throuput per Mod. Sch.') 
                                         
                                         set(handles.range_display_text, 'String',tput_distance)
                                         
                                         end
                         end




                     case 'Generic'    
                         Qm = [2,4,6];
                         Rb = ((RE_frame*Qm)/(10*10^-3)); 

                         EbN0 = [EbN0_value(ber_target,'QPSK',channel_type),EbN0_value(ber_target,'16QAM',channel_type),EbN0_value(ber_target,'64QAM',channel_type)];
                         SINR = EbN0.*(Rb/B_noise);
                         SINR_db = 10*log10(SINR);

                         Pr_min = SINR_db + Interf_Noise;
                         PL_target = Ptx + G_ant - Cable_losses - Pr_min;

                         x = ht_cords(1);  
                         y = ht_cords(2);
                         
                         B_sys = link_con(link_num).system_params.system_bandwidth;
                         B_sys = num2str(B_sys);
                         switch B_sys
                             
                             
                             case '1.4'
                                 PDSCH_RE_frame = 4912; %Extended CP, CFI = 3, BW = 1.4 MHz
                                 
                             case '3'
                                 PDSCH_RE_frame = 14812; %Extended CP, CFI = 3
                                 
                             case '5'
                                 PDSCH_RE_frame = 25012; %Extended CP, CFI = 3
                                 
                             case '10'
                                 PDSCH_RE_frame = 50512; %Extended CP, CFI = 3
                                 
                             case '15'
                                 PDSCH_RE_frame = 76012; %Extended CP, CFI = 3
                                 
                             case '20'
                                 PDSCH_RE_frame = 101512; %Extended CP, CFI = 3
                         end
                         
                         phy_tput_frame = ((PDSCH_RE_frame*Qm)/(10*10^-3))/10^6;
                         set(handles.throughput_display_text, 'String',phy_tput_frame) 


                         switch link_con(link_num).channel.path_loss_model

                             case 'FSPL'

                                 tput_distance = 10.^((PL_target-20*log10(freq)-32.44)/20);
                                 
                                 if dlosh > tput_distance(1)

                                                
                                 colour = 'y'; 
                                 %QPSK                                  
                                 handles.tput_plot1 = tput_plot(x,y,tput_distance(1) ,handles.map,colour);
                                 txt1 = [ num2str(phy_tput_frame(1)) ' Mbps' ' (QPSK)']; 

                                 colour = 'b'; 
                                 %16QAM
                                 handles.tput_plot2 = tput_plot(x,y,tput_distance(2) ,handles.map,colour);
                                 txt2 = [num2str(phy_tput_frame(2)) ' Mbps' ' (16QAM)'];

                                 colour = 'g';
                                 %64QAM                 
                                 handles.tput_plot3= tput_plot(x,y,tput_distance(3) ,handles.map,colour);
                                 txt3 = [num2str(phy_tput_frame(3)) ' Mbps' ' (64QAM)'];

                                 i_am_legend = legend(handles.map,[handles.tput_plot1,handles.tput_plot2,handles.tput_plot3],{txt1,txt2,txt3},'Location','best');
                                 title(i_am_legend,'Generic Throuput per Mod. Sch.') 
                                 
                                 end

                             case '2-Ray'

                                 tput_distance = [two_ray(PL_target(1), ht, hr, freq),two_ray(PL_target(2), ht, hr, freq),two_ray(PL_target(3), ht, hr, freq)];
                                 tput_distance = tput_distance*10^-3;
                                 
                                 if dlosh > tput_distance(1)

                                 colour = 'y'; 
                                 %QPSK                                  
                                 handles.tput_plot1 = tput_plot(x,y,tput_distance(1) ,handles.map,colour);
                                 txt1 = [ num2str(phy_tput_frame(1)) ' Mbps' ' (QPSK)']; 

                                 colour = 'b'; 
                                 %16QAM
                                 handles.tput_plot2 = tput_plot(x,y,tput_distance(2) ,handles.map,colour);
                                 txt2 = [num2str(phy_tput_frame(2)) ' Mbps' ' (16QAM)'];

                                 colour = 'g';
                                 %64QAM                 
                                 handles.tput_plot3= tput_plot(x,y,tput_distance(3) ,handles.map,colour);
                                 txt3 = [num2str(phy_tput_frame(3)) ' Mbps' ' (64QAM)'];

                                 i_am_legend = legend(handles.map,[handles.tput_plot1,handles.tput_plot2,handles.tput_plot3],{txt1,txt2,txt3},'Location','best');
                                 title(i_am_legend,'Generic Throuput per Mod. Sch.') 
                                 
                                 end
                                 
                             case '3-Ray'
                                 tput_distance = [three_ray(PL_target(1), ht, hr, freq),three_ray(PL_target(2), ht, hr, freq),three_ray(PL_target(3), ht, hr, freq)];
                                 tput_distance = tput_distance*10^-3;   
                                 
                                 if dlosh > tput_distance(1)

                                 colour = 'y'; 
                                 %QPSK                                  
                                 handles.tput_plot1 = tput_plot(x,y,tput_distance(1) ,handles.map,colour);
                                 txt1 = [ num2str(phy_tput_frame(1)) ' Mbps' ' (QPSK)']; 

                                 colour = 'b'; 
                                 %16QAM
                                 handles.tput_plot2 = tput_plot(x,y,tput_distance(2) ,handles.map,colour);
                                 txt2 = [num2str(phy_tput_frame(2)) ' Mbps' ' (16QAM)'];

                                 colour = 'g';
                                 %64QAM                 
                                 handles.tput_plot3= tput_plot(x,y,tput_distance(3) ,handles.map,colour);
                                 txt3 = [num2str(phy_tput_frame(3)) ' Mbps' ' (64QAM)'];

                                 i_am_legend = legend(handles.map,[handles.tput_plot1,handles.tput_plot2,handles.tput_plot3],{txt1,txt2,txt3},'Location','best');
                                 title(i_am_legend,'Generic Throuput per Mod. Sch.') 
                                 
                                 end
                                 
                             case 'Sea Radio-Wave Propagation Loss'
                                 tput_distance = [srwpl(PL_target(1), ht, hr, freq),srwpl(PL_target(2), ht, hr, freq),srwpl(PL_target(3), ht, hr, freq)];
                                 tput_distance = tput_distance*10^-3;   
                                 
                                 if dlosh > tput_distance(1)

                                 colour = 'y'; 
                                 %QPSK                                  
                                 handles.tput_plot1 = tput_plot(x,y,tput_distance(1) ,handles.map,colour);
                                 txt1 = [ num2str(phy_tput_frame(1)) ' Mbps' ' (QPSK)']; 

                                 colour = 'b'; 
                                 %16QAM
                                 handles.tput_plot2 = tput_plot(x,y,tput_distance(2) ,handles.map,colour);
                                 txt2 = [num2str(phy_tput_frame(2)) ' Mbps' ' (16QAM)'];

                                 colour = 'g';
                                 %64QAM                 
                                 handles.tput_plot3= tput_plot(x,y,tput_distance(3) ,handles.map,colour);
                                 txt3 = [num2str(phy_tput_frame(3)) ' Mbps' ' (64QAM)'];

                                 i_am_legend = legend(handles.map,[handles.tput_plot1,handles.tput_plot2,handles.tput_plot3],{txt1,txt2,txt3},'Location','best');
                                 title(i_am_legend,'Generic Throuput per Mod. Sch.') 
                                 
                                 end
                         end


                end
                
                if dlosh > tput_distance(1)
                 
                    set(handles.range_display_text, 'String',tput_distance(1))
                     
                     
                elseif dlosh <= tput_distance(1)
                 
                    %Plot LOSH
                    plotted_range = range_plot(dlosh_cords(1)  ,dlosh_cords(2)  ,d_losh,handles.map,tx_height);
                    
                    %create legend
                    i_am_legend = legend(handles.map,[plotted_range],{'Link LOSH'},'Location','best');
                    title(i_am_legend,'Line of Sight to Horizon Limit')
                    
                    set(handles.range_display_text, 'String',dlosh)
                    set(handles.rx_sens_text, 'String','N/A')
                    set(handles.ber_display_text, 'String','N/A')
                    set(handles.node_display_text, 'String',link_con(link_num).link_name)
                    set(handles.path_loss_disp_text, 'String', 'N/A');
                    
                    %set(handles.techno_disp_text, 'String',node_con(nod_num).equipment_params.technology )
                    set(handles.service_disp_text, 'String','N/A' )
                    set(handles.techno_disp_text, 'String','N/A' )
                    set(handles.throughput_display_text, 'String','N/A')
                    set(handles.freq_disp_text, 'String', 'N/A');
                    set(handles.interf_disp_text, 'String', 'N/A');
                    set(handles.fade_disp_text, 'String', 'N/A');
                    
                end  
                 
      end
     
%     otherwise
%      errordlg('No configuration selected', 'Run')
end

guidata(handles.output, handles);



function pl_2ray = two_ray(PL_target, ht, hr, freq)

%2-Ray Path Loss

lambda = physconst('LightSpeed')/(freq*10^6);
d_init = 0.001; %11.132; %d in meters
d = d_init;


R = 6.378*(10^6);
d_losh = (sqrt(2*(R)*(ht))+sqrt(2*(R)*(hr)));

fin_flag = 0;

while (fin_flag == 0)
    
    if d == d_init
        
        PL_res = -10*log10(((lambda/(4*pi*d))^2)*(2*sin((2*pi*hr*ht)/(lambda*d)))^2);
        
        value_check = PL_res - PL_target;
        value_sign = sign(value_check);
        
        d = 1;
       
    end
       
    %For graphing
%     PL_res(d) = -10*log10(((lambda/(4*pi*d))^2)*(2*sin((2*pi*hr*ht)/(lambda*d)))^2);
   
    PL_res = -10*log10(((lambda/(4*pi*d))^2)*(2*sin((2*pi*hr*ht)/(lambda*d)))^2);

    value_check = PL_res - PL_target;
    new_sign = sign(value_check);
    
    if new_sign == value_sign       
        d = d+1;
    else
        if d ==1
            narrow_d = d_init:(d_init/10):d;
            
            
            loop_max = numel(narrow_d);
            for ind = 1:loop_max
                d = narrow_d(ind);
                
                PL_res(ind) = -10*log10(((lambda/(4*pi*d))^2)*(2*sin((2*pi*hr*ht)/(lambda*d)))^2);
            end
            
            [~,i] = min(abs(PL_res-PL_target));
            d = narrow_d(i);
            
            fin_flag = 1;
            
            
        else
            
            narrow_d = (d-1):0.01:d;
            
            loop_max = numel(narrow_d);
            for ind = 1:loop_max
                d = narrow_d(ind);
                PL_res(ind) = -10*log10(((lambda/(4*pi*d))^2)*(2*sin((2*pi*hr*ht)/(lambda*d)))^2);
            end
            
            [~,i] = min(abs(PL_res-PL_target));
            d = narrow_d(i);
            
            fin_flag = 1;
        
        end        
    end
    
    if d == round(d_losh)
        fin_flag = 1;
    end
end

pl_2ray = d;





%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function pl_3ray = three_ray(PL_target, ht, hr, freq)

%3-Ray Path Loss

lambda = physconst('LightSpeed')/(freq*10^6);
d_init = 0.001; %11.132; %d in meters
d = d_init;
he = 30.5;
d_break = (4*hr*ht)/lambda;


R = 6.378*(10^6);
d_losh = (sqrt(2*(R)*(ht))+sqrt(2*(R)*(hr)));

fin_flag = 0;

while (fin_flag == 0)
    
    if d == d_init
        
        if (d < d_break || d == d_break)
    
            PL_res = -10*log10(((lambda/(4*pi*d))^2)*(2*sin((2*pi*hr*ht)/(lambda*d)))^2);

        elseif (d > d_break)
   
            delta = 2*sin((2*pi*hr*ht)/(lambda*d)) *2*sin((2*pi*(he-hr)*(he-ht))/(lambda*d));
            PL_res = -10*log10(((lambda/(4*pi*d))^2)*(2*(1+delta))^2);    
        end
        
        value_check = PL_res - PL_target;
        value_sign = sign(value_check);
        
        d = 1;
       
    end
    
%     %For graphing
%     if (d < d_break || d == d_break)
% 
%         PL_res(d) = -10*log10(((lambda/(4*pi*d))^2)*(2*sin((2*pi*hr*ht)/(lambda*d)))^2);
% 
%     elseif (d > d_break)
% 
%         delta = 2*sin((2*pi*hr*ht)/(lambda*d)) *2*sin((2*pi*(he-hr)*(he-ht))/(lambda*d));
%         PL_res(d) = -10*log10(((lambda/(4*pi*d))^2)*(2*(1+delta))^2);    
%     end
   

    if (d < d_break || d == d_break)

        PL_res = -10*log10(((lambda/(4*pi*d))^2)*(2*sin((2*pi*hr*ht)/(lambda*d)))^2);

    elseif (d > d_break)

        delta = 2*sin((2*pi*hr*ht)/(lambda*d)) *2*sin((2*pi*(he-hr)*(he-ht))/(lambda*d));
        PL_res = -10*log10(((lambda/(4*pi*d))^2)*(2*(1+delta))^2);    
    end

    value_check = PL_res - PL_target;
    new_sign = sign(value_check);
    
    if new_sign == value_sign       
        d = d+1;
    else
        if d ==1
            narrow_d = d_init:(d_init/10):d;
            
            
            loop_max = numel(narrow_d);
            for ind = 1:loop_max
                d = narrow_d(ind);
                
                if (d < d_break || d == d_break)

                    PL_res(ind) = -10*log10(((lambda/(4*pi*d))^2)*(2*sin((2*pi*hr*ht)/(lambda*d)))^2);

                elseif (d > d_break)

                    delta = 2*sin((2*pi*hr*ht)/(lambda*d)) *2*sin((2*pi*(he-hr)*(he-ht))/(lambda*d));
                    PL_res(ind) = -10*log10(((lambda/(4*pi*d))^2)*(2*(1+delta))^2);    
                end
            end
            
            [~,i] = min(abs(PL_res-PL_target));
            d = narrow_d(i);
            
            fin_flag = 1;
            
            
        else
            
            narrow_d = (d-1):0.01:d;
            
            loop_max = numel(narrow_d);
            for ind = 1:loop_max
                d = narrow_d(ind);
                if (d < d_break || d == d_break)

                    PL_res(ind) = -10*log10(((lambda/(4*pi*d))^2)*(2*sin((2*pi*hr*ht)/(lambda*d)))^2);

                elseif (d > d_break)

                    delta = 2*sin((2*pi*hr*ht)/(lambda*d)) *2*sin((2*pi*(he-hr)*(he-ht))/(lambda*d));
                    PL_res(ind) = -10*log10(((lambda/(4*pi*d))^2)*(2*(1+delta))^2);    
                end
            end
            
            [~,i] = min(abs(PL_res-PL_target));
            d = narrow_d(i);
            
            fin_flag = 1;
        
        end        
    end
    
    if d == round(d_losh)
        fin_flag = 1;
    end
end

pl_3ray = d;



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function pl_srwpl = srwpl(PL_target, ht, hr, freq)


lambda = physconst('LightSpeed')/(freq*10^6);
d_init = 0.001; %11.132;
d = d_init;

FSPL = 20*log10(d*10^-3)+ 20*log10(freq)+32.44; % f(MHz)  & d(km)
PL_0 = FSPL;
PL_1 = 10*log10(4*sin((2*pi*hr*ht)/(lambda*d))^2);
PL_boat = 10;
PL_earth = 0;
alpha = 5;

R = 6.378*(10^6);
d_losh = (sqrt(2*(R)*(ht))+sqrt(2*(R)*(hr)));

fin_flag = 0;

while (fin_flag == 0)
    
    if d == d_init
        PL_res = 20*log10(d*10^-3)+ 20*log10(freq)+32.44 + 10*log10(4*sin((2*pi*hr*ht)/(lambda*d))^2) + PL_boat + PL_earth + alpha;
        
        value_check = PL_res - PL_target;
        value_sign = sign(value_check);
        
        d = 1;
       
    end
    
%    PL_res(d) = 20*log10(d*10^-3)+ 20*log10(freq)+32.44 + 10*log10(4*sin((2*pi*hr*ht)/(lambda*d))^2) + PL_boat + PL_earth + alpha;
    PL_res = 20*log10(d*10^-3)+ 20*log10(freq)+32.44 + 10*log10(4*sin((2*pi*hr*ht)/(lambda*d))^2) + PL_boat + PL_earth + alpha;

    value_check = PL_res - PL_target;
    new_sign = sign(value_check);
    
    if new_sign == value_sign
        
        d = d+1;
    else
        if d ==1
            narrow_d = d_init:(d_init/10):d;
                        
            loop_max = numel(narrow_d);
            for ind = 1:loop_max
                d = narrow_d(ind);
                PL_res(ind) = 20*log10(d*10^-3)+ 20*log10(freq)+32.44 + 10*log10(4*sin((2*pi*hr*ht)/(lambda*d))^2) + PL_boat + PL_earth + alpha;
            end
            
            [~,i] = min(abs(PL_res-PL_target));
            d = narrow_d(i);
            
            fin_flag = 1;            
            
        else
            
            narrow_d = (d-1):0.01:d;
            
            loop_max = numel(narrow_d);
            for ind = 1:loop_max
                d = narrow_d(ind);
                PL_res(ind) = 20*log10(d)+ 20*log10(freq)+32.44 + 10*log10(4*sin((2*pi*hr*ht)/(lambda*d))^2) + PL_boat + PL_earth + alpha;
            end
            
            [~,i] = min(abs(PL_res-PL_target));
            d = narrow_d(i);
            
            fin_flag = 1;
        
        end        
    end
    
    if d == round(d_losh)
        fin_flag = 1;
    end
end
pl_srwpl = d;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function ebno_out = EbN0_value(ber_target,mod_sch,channel_type)

switch channel_type
    
    case 'AWGN'
        switch mod_sch
    
            case 'QPSK'
               
                EbN0_range =0:0.001:30; %EbN0 in db
                M = 4;

                ber = berawgn(EbN0_range,'psk',M,'nondiff'); %returns the BER of uncoded QAM over an AWGN channel with coherent demodulation. The alphabet size, M, must be at least 4. 

                [~,i] = min(abs(ber-ber_target));
                EbN0_dB = EbN0_range(i);
                ebno_out = 10^(EbN0_dB/10); % linear output 
        
            case '16QAM'
        
                EbN0_range =0:0.001:35;
                M = 16;

                ber = berawgn(EbN0_range,'qam',M);

                [~,i] = min(abs(ber-ber_target));
                EbN0_dB = EbN0_range(i);
                ebno_out = 10^(EbN0_dB/10);
        
            case '64QAM'
                EbN0_range =0:0.001:40;
                M = 64;

                ber = berawgn(EbN0_range,'qam',M);

                [~,i] = min(abs(ber-ber_target));
                EbN0_dB = EbN0_range(i);
                ebno_out = 10^(EbN0_dB/10);
        
        
            case 'FSK'  
        
                EbN0_range =0:0.01:31;
                M = 2;

                ber = berawgn(EbN0_range,'fsk',M,'coherent');%returns the BER of orthogonal uncoded FSK modulation over an AWGN channel. coherence is either 'coherent' for coherent demodulation or 'noncoherent' for noncoherent demodulation. M must be no greater than 64 for 'noncoherent'

                [~,i] = min(abs(ber-ber_target));
                EbN0_dB = EbN0_range(i);
                ebno_out = 10^(EbN0_dB/10);
         
        end
        
    case 'Rayleigh'
        switch mod_sch
    
            case 'QPSK'
                EbN0_range =0:1:75; %EbN0 in db
                M = 4;
                divorder = 1;

                ber = berfading(EbN0_range,'psk',M,divorder); %returns the BER of uncoded QAM over an AWGN channel with coherent demodulation. The alphabet size, M, must be at least 4. 

                [~,i] = min(abs(ber-ber_target));
                EbN0_dB = EbN0_range(i);
                ebno_out = 10^(EbN0_dB/10);

        
            case '16QAM'
                EbN0_range =0:1:80;
                M = 16;
                divorder = 1;

                ber = berfading(EbN0_range,'qam',M,divorder);

                [~,i] = min(abs(ber-ber_target));
                EbN0_dB = EbN0_range(i);
                ebno_out = 10^(EbN0_dB/10);
        
        
            case '64QAM'
                EbN0_range =0:1:85;
                M = 64;
                divorder = 1;

                ber = berfading(EbN0_range,'qam',M,divorder);

                [~,i] = min(abs(ber-ber_target));
                EbN0_dB = EbN0_range(i);
                ebno_out = 10^(EbN0_dB/10);

        
        
            case 'FSK'  
                EbN0_range =0:1:80;
                M = 2;
                divorder = 1;

                ber = berfading(EbN0_range,'fsk',M,divorder,'coherent');%returns the BER of orthogonal uncoded FSK modulation over an AWGN channel. coherence is either 'coherent' for coherent demodulation or 'noncoherent' for noncoherent demodulation. M must be no greater than 64 for 'noncoherent'

                [~,i] = min(abs(ber-ber_target));
                EbN0_dB = EbN0_range(i);
                ebno_out = 10^(EbN0_dB/10);
                
        end
        
end
        



function circ = range_plot(x,y,r,ax,tx_height)
hold (ax, 'on')
ang = 0:pi/50:2*pi;
% xunit = ((r/1.1132)*0.01) * cos(ang) + x;
% yunit = ((r/1.1132)*0.01) * sin(ang) + y;
xunit = ((r/0.011132)*0.0001) * cos(ang) + x; %decimal coordinates to four decimal places 
yunit = ((r/0.011132)*0.0001) * sin(ang) + y; %decimal coordinates to four decimal places 
circ = plot(ax,xunit, yunit, 'r', 'LineWidth',3); 

x_list = [];
y_list = [];
% cnt = 0;
for pts = 1:101
%   cnt=cnt+1;  
  x_radii = linspace(x,circ.XData(pts),50);
  y_radii = linspace(y,circ.YData(pts),50);
  x_list = [x_list; x_radii];
  y_list = [y_list; y_radii];
end





new_edge = topogr(x_list,y_list,tx_height);

canc_flag=getappdata(0,'canceling');
if canc_flag == 0
cnt = 0;
for pts = 1:101
  cnt=cnt+1;  
  circ.XData(pts)=new_edge.x(cnt);
  circ.YData(pts)=new_edge.y(cnt);
end

else 
    for pts = 1:101
        
        circ.XData(pts)=0;
        circ.YData(pts)=0;
    end
end


% legend(ax,'Range')
% hold off

function circl = tput_plot(x,y,r,ax,colour)
hold (ax, 'on')
ang = 0:pi/50:2*pi;
% xunit = ((r/1.1132)*0.01) * cos(ang) + x;
% yunit = ((r/1.1132)*0.01) * sin(ang) + y;
xunit = ((r/0.011132)*0.0001) * cos(ang) + x; %decimal coordinates to four decimal places 
yunit = ((r/0.011132)*0.0001) * sin(ang) + y; %decimal coordinates to four decimal places 
circl = plot(ax,xunit, yunit,'Color',colour, 'LineWidth',2); 


%legend(ax,label) %,label,colour
% hold off

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
hold (handles.map, 'on')
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
% towers_on = get(hObject,'Value');
% 
% if exist('filter.mat')
%    load('filter.mat') 
%    filter_on = filter_con.height_on;
% %    towers_selected = getappdata(0,'towers_selection');
% end
% 
% 
% if (0 == filter_on && 1 == towers_on) 
%     if exist('towers.mat')
%         load('towers.mat')
%         if exist('tower_tnt')
%             
%             if isfield(handles,'tower_plot_all')
%                 set(handles.tower_plot_all, 'Visible', 'on')
%                 if isfield(handles,'tower_plot_sel')
%                 set(handles.tower_plot_sel, 'Visible', 'off')
%                 end
%             else
% 
%             lon_var = [tower_tnt.Lon];
%             lat_var = [tower_tnt.Lat];
%             handles.tower_plot_all = plot(handles.map,lon_var,lat_var,'r*','DisplayName','Cellular Tower');
%             hold (handles.map, 'on')
%             end
%  
% 
%         end
% 
%     else
%         errordlg('No Tower Data Found', 'Tower Data Set Selection')
%         return;
%     end
%     
% elseif (1 == filter_on && 1 == towers_on) 
%     
%     if exist('filter.mat')
%        load('filter.mat') 
%        towers_selected = tower_sel;
% %    towers_selected = getappdata(0,'towers_selection');
%     end
%     
%     cng_flag = getappdata(0,'filter_change_flag');
%             if (isfield(handles,'tower_plot_sel') && (cng_flag==0))
%                 set(handles.tower_plot_sel, 'Visible', 'on')
%                 if isfield(handles,'tower_plot_all')
%                 set(handles.tower_plot_all, 'Visible', 'off')
%                 end
%             else
% 
%             lon_var = [towers_selected.Lon];
%             lat_var = [towers_selected.Lat];
%             handles.tower_plot_sel = plot(handles.map,lon_var,lat_var,'y*','DisplayName','Filtered Cellular Tower');
%             hold (handles.map, 'on')
%             end
% 
% 
%     setappdata(0,'filter_change_flag',0)
% else 
%     
%     
% if isfield(handles,'tower_plot_sel')
% set(handles.tower_plot_sel, 'Visible', 'off')
% end
% if isfield(handles,'tower_plot_all')
% set(handles.tower_plot_all, 'Visible', 'off')
% end
% 
% % set(handles.tower_plot,'Visible','off')
% 
% %clear(handles.tower_plot)
% end
% 
% guidata(handles.figure1, handles);

towers_on = get(hObject,'Value');
setappdata(0,'tower_on_flag',handles.towers_checkbox.Value)

if exist('filter.mat')
   load('filter.mat') 
   filter_on = filter_con.height_on;
%    towers_selected = getappdata(0,'towers_selection');
end


if (0 == filter_on && 1 == towers_on) 
    if exist('towers.mat')
        load('towers.mat')
        if exist('tower_tnt')
            

            if isfield(handles,'tower_plot_sel')               
                delete (handles.tower_plot_sel)
            end
            
            set(handles.uibuttongroup13,'Visible','on');
            set(handles.info_bar_text,'String','Displaying all towers');

            lon_var = [tower_tnt.Lon];
            lat_var = [tower_tnt.Lat];
            handles.tower_plot_all = plot(handles.map,lon_var,lat_var,'r*','DisplayName','Cellular Tower');
            hold (handles.map, 'on')
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
    
%     cng_flag = getappdata(0,'filter_change_flag');
%             if (cng_flag==0)
                
                if isfield(handles,'tower_plot_all')
                    delete (handles.tower_plot_all)         
                end
            switch getappdata(0,'operator')
                case 'greater'
                    info_disp = ['Displaying all towers above ', num2str(filter_con.val), ' m'];
                    
                case 'less'
                    info_disp = ['Displaying all towers below ', num2str(filter_con.val), ' m'];
                
            end
            set(handles.uibuttongroup13,'Visible','on');
            set(handles.info_bar_text,'String',info_disp );

            lon_var = [towers_selected.Lon];
            lat_var = [towers_selected.Lat];
            handles.tower_plot_sel = plot(handles.map,lon_var,lat_var,'y*','DisplayName','Filtered Cellular Tower');
            hold (handles.map, 'on')
%             end


%     setappdata(0,'filter_change_flag',0)
else 
set(handles.uibuttongroup13,'Visible','off');    
set(handles.info_bar_text,'String',' ');    
if isfield(handles,'tower_plot_sel')
delete (handles.tower_plot_sel) 
end
if isfield(handles,'tower_plot_all')
delete (handles.tower_plot_all) 
end

% set(handles.tower_plot,'Visible','off')

%clear(handles.tower_plot)
end

if towers_on == 1
    set(handles.tower_filter_pushbutton,'Enable', 'off')
else
    set(handles.tower_filter_pushbutton,'Enable', 'on')
end

guidata(handles.figure1, handles);

% --- Executes on button press in gmdss_checkbox.
function gmdss_checkbox_Callback(hObject, eventdata, handles)
% hObject    handle to gmdss_checkbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of gmdss_checkbox
gmdss_on = get(hObject,'Value');

if 1 == gmdss_on 
    if exist('geodata.mat')
        load('geodata.mat')
        if exist('gmdssa1')&& exist('gmdssa2')

lon_var = gmdssa1.Lon;
lat_var = gmdssa1.Lat;
handles.gmdss_plot1 = plot(handles.map,lon_var,lat_var,'--g','LineWidth',2,'DisplayName','GMDSS Zone A1');
hold (handles.map, 'on')

lon_var = gmdssa2.Lon;
lat_var = gmdssa2.Lat;
handles.gmdss_plot2 = plot(handles.map,lon_var,lat_var,'--g','LineWidth',2,'DisplayName','GMDSS Zone A2');
hold (handles.map, 'on')



        end

    else
        errordlg('No GMDSS Zone Data Found', 'Data Set Selection')
        return;
    end
    
else 
    delete (handles.gmdss_plot1)
    delete (handles.gmdss_plot2)
   
end

guidata(handles.figure1, handles);



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

lon_var = [eez.Lon(1:40)];
lat_var = [eez.Lat(1:40)];
handles.econ_plot1 = plot(handles.map,lon_var,lat_var,'--w','LineWidth',2,'DisplayName','Economic Zone(Outer)');
hold (handles.map, 'on')

lon_var = [eez.Lon(41:456)];
lat_var = [eez.Lat(41:456)];
handles.econ_plot2 = plot(handles.map,lon_var,lat_var,'--w','LineWidth',2,'DisplayName','Economic Zone(Tobago)');
hold (handles.map, 'on')

lon_var = [eez.Lon(457:1508)];
lat_var = [eez.Lat(457:1508)];
handles.econ_plot3 = plot(handles.map,lon_var,lat_var,'--w','LineWidth',2,'DisplayName','Economic Zone(Trinidad)');
hold (handles.map, 'on')
%fill(handles.map,lon_var,lat_var,'w')

        end

    else
        errordlg('No Economic Zone Data Found', 'Data Set Selection')
        return;
    end
    
else 
    delete (handles.econ_plot1)
    delete (handles.econ_plot2)
    delete (handles.econ_plot3)
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
handles.contig_plot = plot(handles.map,lon_var,lat_var,'--y','LineWidth',2,'DisplayName','Contiguous Zone');
hold (handles.map, 'on')
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
handles.terri_plot = plot(handles.map,lon_var,lat_var,'--c','LineWidth',2,'DisplayName','Territorial Waters');
hold (handles.map, 'on')
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
        set(handles.pwr_lim_radiobutton,'Enable','on')
        set(handles.prev_lim_radiobutton,'Enable','on')
        
    case 'load_node_radiobutton'
%         set(handles.node_popupmenu,'Enable','on') 
%         set(handles.link_popupmenu,'Enable','off')
        setappdata(0,'disp_flag',0)
        set(handles.pwr_lim_radiobutton,'Enable','off')
        set(handles.prev_lim_radiobutton,'Enable','off')
        setappdata(0,'range_type',0)
        set(handles.los_radiobutton,'Value',1)
        
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
%  display_flag =  getappdata(0,'disp_flag');
%  
%  switch display_flag
%     
%     case 0 %node
%         
%         node_display 
% 
% 
%         
%     case 1 %link
%         
%         link_display
%  end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
display_flag =  getappdata(0,'disp_flag');

switch display_flag
    
    case 0 %NODE
        
        %Obtain user selection
        user_n_sel = getappdata(0, 'user_node_selection');
        if isempty(user_n_sel)
            errordlg('No node selected, Please Select a Node', 'Display')
        end
        
        %Load saved node information and initialize index
        if exist('nodesave.mat')
            load('nodesave.mat')
            
            for nodein = 1:save_ind
                if strcmp(user_n_sel,node_con(nodein).node_name)
                    nod_num = nodein;
                end
            end
            
        else
            errordlg('No node information available, Please Select a Node', 'Display')
        end
        
        %set(handles.node_display_text, 'String',node_con(nod_num).node_name)
        
        
        
        
        
        
        switch node_con(nod_num).node_type
            
            case 'Mobile at Sea'
                
                %h_ves = 2; %Vessel selected to be maximum 2m
                
                %d_losh = (sqrt(2*R*h_ves))/(10^3); %answer in km
                
                
                
                %setappdata(0,'range_dist',d_losh)
                %setappdata(0,'long_cordi',node_con(nod_num).node_location.longi);
                %setappdata(0,'lat_cordi',node_con(nod_num).node_location.lati );
                %handles.losh_plot = range_plot(node_con(nod_num).node_location.longi  ,node_con(nod_num).node_location.lati  ,d_losh,handles.map);
                %label = ['\rightarrow'  (num2str(node_con(nod_num).node_name)) ' LOSH Plot'];
                %handles.plot_label1 = text(handles.losh_plot.XData(1),handles.losh_plot.YData(1),label, 'HorizontalAlignment','left','Color','white','FontSize',14);
                
                h = findobj('Tag','gmap');
                h = h(2);
                makedatatip(h,[node_con(nod_num).node_location.longi node_con(nod_num).node_location.lati])
                
            case 'Tower Mounted'
                
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
                        
                        %h_bs = tower_tnt(find((ismember(tower_cords,closest_tower )),1)).AntennaHeight; %Height of Closest tower
                        
                        %d_losh = (sqrt(2*R*h_bs))/(10^3); %answer in km
                        %setappdata(0,'range_dist',d_losh)
                        %setappdata(0,'long_cordi',closest_tower(:,1));
                        %setappdata(0,'lat_cordi',closest_tower(:,2));
                        %handles.losh_plot = range_plot(closest_tower(:,1)  ,closest_tower(:,2)  ,d_losh,handles.map);
                        %label = ['\rightarrow'  (num2str(node_con(nod_num).node_name)) ' LOSH Plot'];
                        %handles.plot_label2 = text(handles.losh_plot.XData(1),handles.losh_plot.YData(1),label, 'HorizontalAlignment','left','Color','white','FontSize',14);
                        
                        h = findobj('Tag','gmap');
                        h = h(2);
                        makedatatip(h,[closest_tower(:,1)  closest_tower(:,2)])
                        
                    end
                end
                
        end
        
    case 1 %Link
        
        if exist('nodesave.mat')
            load('nodesave.mat')
        end
        %Obtain user selection
        user_l_sel = getappdata(0, 'user_link_selection');
        if isempty(user_l_sel)
            errordlg('No link selected', 'Run')
        end
        
        %Load saved link information and initialize index
        if exist('linksave.mat')
            load('linksave.mat')
            
            for linkin = 1:save_ind_link
                if strcmp(user_l_sel,link_con(linkin).link_name)
                    link_num = linkin;
                end
            end
            
        else
            errordlg('No link information available', 'Run')
        end
        
        set(handles.node_display_text, 'String',link_con(link_num).link_name)
        
        %Determine if uplink or downlink
        
        switch link_con(link_num).system_params.link_direction
            
            case 'Downlink'
                transmitter = link_con(link_num).node_selection.node1;
                receiver = link_con(link_num).node_selection.node2;
                
            case 'Uplink'
                transmitter = link_con(link_num).node_selection.node2;
                receiver = link_con(link_num).node_selection.node1;
                
        end
        
        %Find receiver index and transmitter index
        for nodein = 1:save_ind
            if strcmp(transmitter,node_con(nodein).node_name)
                tx_num = nodein;
            end
            
            if strcmp(receiver,node_con(nodein).node_name)
                rx_num = nodein;
            end
        end
        
        %Extract transmitter and receiver coordinates
        rx_cords = [node_con(rx_num).node_location.longi  ,node_con(rx_num).node_location.lati ];
        tx_cords = [node_con(tx_num).node_location.longi  ,node_con(tx_num).node_location.lati ];
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        %Ascertain whether the transmitter is tower mounted or mobile at sea
        switch node_con(tx_num).node_type
            
            case 'Mobile at Sea'
                
                %h_ves = 2; %Vessel selected to be maximum 2m
                
                %Plot Datatips for transmitter
                h = findobj('Tag','gmap');
                h = h(2);
                makedatatip(h,[node_con(tx_num).node_location.longi  node_con(tx_num).node_location.lati])
                
                switch node_con(rx_num).node_type
                    
                    case 'Mobile at Sea'
                        
                        %h_2 = h_ves ;
                        
                        %Plot Datatips for receiver
                        h = findobj('Tag','gmap');
                        h = h(2);
                        makedatatip(h,[node_con(rx_num).node_location.longi  node_con(rx_num).node_location.lati])
                        
                        
                    case 'Tower Mounted'
                        
                        if exist('towers.mat')
                            
                            load('towers.mat')
                            
                            if exist('tower_tnt')
                                
                                maxi = numel(tower_tnt);
                                
                                tower_cords = zeros(maxi,2);
                                
                                for elements = 1:maxi
                                    
                                    tower_cords(elements,:) = [tower_tnt(elements).Lon,tower_tnt(elements).Lat];
                                end
                                
                                user_cords = [node_con(rx_num).node_location.longi  ,node_con(rx_num).node_location.lati];
                                
                                euclidean_distances = sqrt(sum(bsxfun(@minus, tower_cords, user_cords).^2,2));
                                closest_tower = tower_cords(find(euclidean_distances==min(euclidean_distances)),:);
                                
                                %h_2 = tower_tnt(find((ismember(tower_cords,closest_tower )),1)).AntennaHeight; %Height of Closest tower
                                
                                %Plot Datatips for receiver
                                h = findobj('Tag','gmap');
                                h = h(2);
                                makedatatip(h,[closest_tower(:,1)  closest_tower(:,2)])
                            end
                        end
                end
                
                %tx_height = h_ves ;
                %d_losh = (sqrt(2*R*h_ves)+sqrt(2*R*h_2))/(10^3); %answer in km
                
                %setappdata(0,'range_dist',d_losh)
                %setappdata(0,'long_cordi',node_con(tx_num).node_location.longi);
                %setappdata(0,'lat_cordi',node_con(tx_num).node_location.lati);
                %plotted_range = range_plot(node_con(tx_num).node_location.longi  ,node_con(tx_num).node_location.lati  ,d_losh,handles.map,tx_height);
                %label = ['\rightarrow '  (num2str(link_con(link_num).link_name)) ' LOSH Plot ' num2str(round(d_losh)) 'km'];
                %handles.plot_label1 = text(plotted_range.XData(1),plotted_range.YData(1),label, 'HorizontalAlignment','left','Color','white','FontSize',14);
                
                %euclidean_los = sqrt(sum(bsxfun(@minus, tx_cords, rx_cords).^2,2)); %find direct distance between tx and rx to find if rx is in range of tx by comparing the link lenght to the LOSH distance(radius)
                %if euclidean_los<d_losh
                % range_flag = 1;   %Signal if in range or out of range
                %end
                
                
                
            case 'Tower Mounted'
                
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
                        
                        %h_bs = tower_tnt(find((ismember(tower_cords,closest_tower )),1)).AntennaHeight; %Height of Closest tower
                        %h_ves = 2;
                        %tx_height = h_bs ;
                        
                        %d_losh = (sqrt(2*R*h_bs)+sqrt(2*R*h_ves))/(10^3); %answer in km
                        %setappdata(0,'range_dist',d_losh)
                        %setappdata(0,'long_cordi',closest_tower(:,1));
                        %setappdata(0,'lat_cordi',closest_tower(:,2));
                        %plotted_range = range_plot(closest_tower(:,1)  ,closest_tower(:,2)  ,d_losh,handles.map,tx_height);
                        %label = ['\rightarrow '  (num2str(link_con(link_num).link_name)) ' LOSH Plot', num2str(round(d_losh)) 'km'];
                        %handles.plot_label1 = text(plotted_range.XData(1),plotted_range.YData(1),label, 'HorizontalAlignment','left','Color','white','FontSize',14);
                    end
                end
                
                %Plot Datatips for receiver
                h = findobj('Tag','gmap');
                h = h(2);
                makedatatip(h,[node_con(rx_num).node_location.longi  node_con(rx_num).node_location.lati])
                %Plot Datatips for transmitter
                h = findobj('Tag','gmap');
                h = h(2);
                makedatatip(h,[closest_tower(:,1)  closest_tower(:,2)])
                
                %create legend
                %i_am_legend = legend(handles.map,[plotted_range],{'Link LOSH'},'Location','best');
                %title(i_am_legend,'Line of Sight to Horizon Limit')
                
                %set(handles.range_display_text, 'String',d_losh)
                %set(handles.rx_sens_text, 'String','N/A')
                %set(handles.ber_display_text, 'String','N/A')
                %set(handles.node_display_text, 'String',link_con(link_num).link_name)
                %set(handles.path_loss_disp_text, 'String', 'N/A');
                
                %set(handles.techno_disp_text, 'String',node_con(nod_num).equipment_params.technology )
                %set(handles.service_disp_text, 'String','N/A' )
                %set(handles.techno_disp_text, 'String','N/A' )
                %set(handles.throughput_display_text, 'String','N/A')
                %set(handles.freq_disp_text, 'String', 'N/A');
                %set(handles.interf_disp_text, 'String', 'N/A');
                %set(handles.fade_disp_text, 'String', 'N/A');
                
                %Compute Throughput
        end
        
        
end


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



% --- Executes on key press with focus on node_popupmenu and none of its controls.
function node_popupmenu_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to node_popupmenu (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)



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
        
    case 'prev_lim_radiobutton'

        setappdata(0,'range_type',2)
        
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

% upd = get(event_obj, 'UpdateFcn') 

%  set(event_obj,'UpdateFcn',@myupdatefcn)


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


% --------------------------------------------------------------------
function uitoggletool5_OnCallback(hObject, eventdata, handles)
% hObject    handle to uitoggletool5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in clear_pushbutton.
function clear_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to clear_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

line_plots =  findobj('type','line');
text_plots =  findobj('type','text');
legend_plots =  findobj('type','legend');

% num_lines = numel(line_plots)-1;

% for lin_num = 1:num_lines
%     
%     twr_flg = strcmp(line_plots(lin_num).DisplayName,'Cellular Tower');
%     twr_flg_f = strcmp(line_plots(lin_num).DisplayName,'Filtered Cellular Tower');
%     if twr_flg == 1 || twr_flg_f == 1
%         line_plots(lin_num) = []; 
% %         num_lines = num_lines - 1;
%     end  
% end

del_data_cursors = datacursormode;
del_data_cursors.removeAllDataCursors()
datacursormode off;

delete(line_plots) ;
delete(text_plots) ;
delete(legend_plots) ;
set(handles.info_bar_text,'String',' ');
set(handles.uibuttongroup13,'Visible','off');

set(handles.terr_waters_checkbox, 'Value', 0);
set(handles.cont_zones_checkbox, 'Value', 0);
set(handles.towers_checkbox, 'Value', 0);
set(handles.econ_zones_checkbox, 'Value', 0);
set(handles.gmdss_checkbox, 'Value', 0);
    
    


% --- Executes on button press in fresnel_checkbox.
function fresnel_checkbox_Callback(hObject, eventdata, handles)
% hObject    handle to fresnel_checkbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of fresnel_checkbox


% --------------------------------------------------------------------
function uitoggletool5_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to uitoggletool5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function save_uipushtool_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to save_uipushtool (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


%Fig1 = figure1;
% AxesH = handles.map;


% Fig2 = handles.figure1;
% copyobj(AxesH, Fig2);
% hgsave(Fig2, 'myFigure.fig');

% load('analysis_save.mat')

axis_save = handles.figure1.CurrentAxes.Children;
axis_save.Parent = handles.map;

% tput_plot1.Parent = handles.map;
% tput_plot1.Parent = [];
