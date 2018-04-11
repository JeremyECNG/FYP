function varargout = link_edit(varargin)
% LINK_EDIT MATLAB code for link_edit.fig
%      LINK_EDIT, by itself, creates a new LINK_EDIT or raises the existing
%      singleton*.
%
%      H = LINK_EDIT returns the handle to a new LINK_EDIT or the handle to
%      the existing singleton*.
%
%      LINK_EDIT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in LINK_EDIT.M with the given input arguments.
%
%      LINK_EDIT('Property','Value',...) creates a new LINK_EDIT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before link_edit_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to link_edit_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help link_edit

% Last Modified by GUIDE v2.5 12-Mar-2018 17:41:34

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @link_edit_OpeningFcn, ...
                   'gui_OutputFcn',  @link_edit_OutputFcn, ...
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


% --- Executes just before link_edit is made visible.
function link_edit_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to link_edit (see VARARGIN)

% Choose default command line output for link_edit
handles.output = hObject;


if exist('linksave.mat')
    load('linksave.mat')
      link_choices = {link_con.link_name}; 


set(handles.linksel_popupmenu, 'String', link_choices);
set(handles.linksel_popupmenu, 'Value', 1);
end

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes link_edit wait for user response (see UIRESUME)
% uiwait(handles.figure_link_edit);


% --- Outputs from this function are returned to the command line.
function varargout = link_edit_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in linkedit_cancel_pushbutton.
function linkedit_cancel_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to linkedit_cancel_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close(link_edit)

% --- Executes on button press in save_linkedit_pushbutton.
function save_linkedit_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to save_linkedit_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if exist('linksave.mat')
    load('linksave.mat')
end

%Link Name
sav_link_con.link_name = getappdata(0,'link_nam');

%Link Technology
sav_link_con.technology = getappdata(0,'link_tech');

%Link Node Selections
sav_link_con.node_selection.node1 = getappdata(0,'node_one');

sav_link_con.node_selection.node2 = getappdata(0,'node_two');

%Link Service
sav_link_con.node_selection.service = getappdata(0,'link_service');

sav_link_con.node_selection.ber = getappdata(0,'link_ber');

%Link System Paramters
sav_link_con.system_params.system_bandwidth = getappdata(0,'link_sys_bw');

% sav_link_con.system_params.mod_sch = getappdata(0,'link_modsch');
% 
% sav_link_con.system_params.code_rate = getappdata(0,'link_coding');

sav_link_con.system_params.link_direction = getappdata(0,'link_direc');

sav_link_con.system_params.freq = getappdata(0, 'link_freqy');

% if strcmp('Downlink',sav_link_con.system_params.link_direction)
%     
%     sav_link_con.system_params.freq = getappdata(0,'link_downfreq');
%     
% else
%     
%     sav_link_con.system_params.freq = getappdata(0,'link_upfreq');
%     
% end

%Link Channel Parameters
sav_link_con.channel.path_loss_model = getappdata(0,'link_pl');

sav_link_con.channel.fading_margin = getappdata(0,'link_fading');

sav_link_con.channel.interference_margin = getappdata(0,'link_interf');

sav_link_con.channel.channel_type = getappdata(0, 'link_chan_typ');

%Link Receiver Paramters
sav_link_con.receiver.temperature = getappdata(0,'link_temp');

sav_link_con.receiver.rx_bandwidth = getappdata(0,'link_rxbw');

%
if exist('linksave.mat')
    load('linksave.mat')
    
    save_slots_used = numel(link_con);
    
else
    save_slots_used = 0;
end

edited_link = getappdata(0, 'link_edited');
    
for name_ind = 1:save_slots_used
    if strcmp(getappdata(0,'link_nam'), link_con(name_ind).link_name)
        name_conflict_flag = 1;
        setappdata(0,'linknameflag',name_conflict_flag)
        %errordlg('A node of this name already exists please change the name of your entry', 'Name Conflict')
    end  
    
    if edited_link  == name_ind
        name_conflict_flag = 0;
        setappdata(0,'linknameflag',name_conflict_flag)
    end       
    
end

if  getappdata(0,'linknameflag') == 1
   
    errordlg('A link of this name already exists please change the name of your entry', 'Name Conflict')
    setappdata(0,'linknameflag',0)
    
elseif isempty(sav_link_con.link_name)||isempty(sav_link_con.system_params.freq)||isempty(sav_link_con.channel.fading_margin)||isempty(sav_link_con.channel.interference_margin)||isempty(sav_link_con.receiver.temperature)||isempty(sav_link_con.receiver.rx_bandwidth)
        
    errordlg('Please fill all fields', 'Save')

elseif isnan(sav_link_con.system_params.freq)||isnan(sav_link_con.channel.fading_margin)||isnan(sav_link_con.channel.interference_margin )||isnan(sav_link_con.receiver.temperature)||isnan(sav_link_con.receiver.rx_bandwidth)
        
    errordlg('Please fill all fields with valid content', 'Save')
    
elseif strcmp('Select',sav_link_con.channel.channel_type)||strcmp('Select',sav_link_con.system_params.system_bandwidth)||strcmp('Select',sav_link_con.technology)||strcmp('Select',sav_link_con.node_selection.node1)||strcmp('Select',sav_link_con.node_selection.node2)||strcmp('Select',sav_link_con.node_selection.service)||strcmp('Select',sav_link_con.node_selection.ber)||strcmp('Select',sav_link_con.channel.path_loss_model)
        
    errordlg('Please make all necessary selections', 'Save')
else
    
    savelinkedit(sav_link_con)
    close(link_edit)
    
end


function savelinkedit(sav_link_con)

%editing  Index
edit_ind = getappdata(0, 'link_edited');

if exist('linksave.mat')
    load('linksave.mat')
end

% save_counter_link = getappdata(0, 'linksavecounter');
% 
% if exist('linksave.mat')
%     load('linksave.mat')
%     if exist('save_ind_link')
%         save_counter_link = save_ind_link;
%     end
% end
% save_counter_link = save_counter_link + 1;
% 
% %Saving Index
% save_ind_link = save_counter_link;

%Link Name
link_con(edit_ind).link_name = sav_link_con.link_name;

%Link Technology
link_con(edit_ind).technology = sav_link_con.technology;

%Link Node Selections
link_con(edit_ind).node_selection.node1 = sav_link_con.node_selection.node1;

link_con(edit_ind).node_selection.node2 = sav_link_con.node_selection.node2;

%Link Service
link_con(edit_ind).node_service.service = sav_link_con.node_selection.service;

link_con(edit_ind).node_service.ber = sav_link_con.node_selection.ber;

%Link System Paramters
link_con(edit_ind).system_params.system_bandwidth = sav_link_con.system_params.system_bandwidth;

% link_con(edit_ind).system_params.mod_sch = sav_link_con.system_params.mod_sch;
% 
% link_con(edit_ind).system_params.code_rate = sav_link_con.system_params.code_rate;

link_con(edit_ind).system_params.link_direction = sav_link_con.system_params.link_direction;
    
link_con(edit_ind).system_params.freq = sav_link_con.system_params.freq;
    
%Link Channel Parameters
link_con(edit_ind).channel.path_loss_model = sav_link_con.channel.path_loss_model;

link_con(edit_ind).channel.fading_margin = sav_link_con.channel.fading_margin ;

link_con(edit_ind).channel.interference_margin = sav_link_con.channel.interference_margin;

link_con(edit_ind).channel.channel_type = sav_link_con.channel.channel_type;

%Link Receiver Paramters
link_con(edit_ind).receiver.temperature = sav_link_con.receiver.temperature;

link_con(edit_ind).receiver.rx_bandwidth = sav_link_con.receiver.rx_bandwidth;


save('linksave.mat','link_con','save_ind_link')

% --- Executes on selection change in linksel_popupmenu.
function linksel_popupmenu_Callback(hObject, eventdata, handles)
% hObject    handle to linksel_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns linksel_popupmenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from linksel_popupmenu

contents = cellstr(get(hObject,'String'));
link_selection = contents{get(hObject,'Value')};
setappdata(0, 'link_selec', link_selection);

if exist('linksave.mat')
    load('linksave.mat')
            
    for linkin = 1:save_ind_link
        if strcmp(link_selection,link_con(linkin).link_name)
            
            item_num = linkin;
    
        end
    
    end
end

setappdata(0, 'link_edited', item_num)

set(handles.link_name_editing, 'String',link_con(item_num).link_name );
setappdata(0, 'link_nam', link_con(item_num).link_name);

%

%set(handles.link_tech_text, 'String',link_con(item_num).technology );

link_tech_setting =link_con(item_num).technology ;
setappdata(0, 'link_tech', link_con(item_num).technology);



switch link_tech_setting
    
    case 'DSC'
        
        set (handles.technology_edit_popupmenu, 'Value', 2)
        
    case 'LTE-A'
        
        set (handles.technology_edit_popupmenu, 'Value', 3)
        
    case 'NWR'
        
        set (handles.technology_edit_popupmenu, 'Value', 4)
        
    case 'Generic'
        
        set (handles.technology_edit_popupmenu, 'Value', 5)   
        
    otherwise
        errordlg('Error Loading Link Technology', 'Link Technology Selection Loading')
    return;
end

set(handles.fading_editing, 'String',link_con(item_num).channel.fading_margin);
setappdata(0, 'link_fading', link_con(item_num).channel.fading_margin);

set(handles.interf_editing, 'String',link_con(item_num).channel.interference_margin);
setappdata(0, 'link_interf', link_con(item_num).channel.interference_margin);

link_chan_type = link_con(item_num).channel.channel_type;
setappdata(0, 'link_chan_typ',link_con(item_num).channel.channel_type);

switch link_chan_type
    
    case 'AWGN'
        
        set (handles.chan_type_edit_popupmenu, 'Value', 2)
        
    case 'Rayleigh'
        
        set (handles.chan_type_edit_popupmenu, 'Value', 3)
                
    otherwise
        errordlg('Error Loading Channel Type', 'Channel Type Selection Loading')
    return;
end


set(handles.temp_editing, 'String',link_con(item_num).receiver.temperature);
setappdata(0, 'link_temp', link_con(item_num).receiver.temperature);

set(handles.rec_band_editing, 'String',link_con(item_num).receiver.rx_bandwidth);
setappdata(0, 'link_rxbw', link_con(item_num).receiver.rx_bandwidth);

link_pl_setting =link_con(item_num).channel.path_loss_model ;
% set(handles.path_loss_mod_text, 'String',link_con(item_num).channel.path_loss_model);
setappdata(0, 'link_pl', link_con(item_num).channel.path_loss_model);

switch link_pl_setting
    
    case 'FSPL'
        
        set (handles.pl_edit_popupmenu, 'Value', 2)
        
    case '2-Ray'
        
        set (handles.pl_edit_popupmenu, 'Value', 3)
        
    case '3-Ray'
        
        set (handles.pl_edit_popupmenu, 'Value', 4)

    case 'Sea Radio-Wave Propagation Loss'
        
        set (handles.pl_edit_popupmenu, 'Value', 5)
        



    otherwise
        errordlg('Error Loading Path Loss Model', 'Path Loss Model Selection Loading')
    return;
end



link_service_setting = link_con(item_num).node_service.service;
% set(handles.service_text, 'String',link_con(item_num).node_service.service);
setappdata(0, 'link_service', link_con(item_num).node_service.service);

switch link_service_setting
    case 'Conversational Voice'
        set(handles.service_edit_popupmenu, 'Value', 2);
        ber = {'Select','10^-2','10^-3'};
        set(handles.ber_edit_popupmenu, 'String', ber);
        set(handles.ber_edit_popupmenu, 'Value', 1);

    case 'Emergency Messaging Data'
        set(handles.service_edit_popupmenu, 'Value', 3);
        ber = {'Select','10^-5','6x10^-8','10^-6'};
        set(handles.ber_edit_popupmenu, 'String', ber);
        set(handles.ber_edit_popupmenu, 'Value', 1);

    case 'Vessel Tracking Data (IoT)'
        set(handles.service_edit_popupmenu, 'Value', 4);
        ber = {'Select','10^-5','10^-6'};
        set(handles.ber_edit_popupmenu, 'String', ber);
        set(handles.ber_edit_popupmenu, 'Value', 1);

    otherwise
        set(handles.ber_edit_popupmenu, 'String', 'Select');
        set(handles.ber_edit_popupmenu, 'Value', 1);
        set(handles.service_edit_popupmenu, 'Value', 1);
end


link_ber_setting = link_con(item_num).node_service.ber;
%set(handles.ber_text, 'String',link_con(item_num).node_service.ber);
setappdata(0, 'link_ber', link_con(item_num).node_service.ber);

switch link_service_setting
    case 'Conversational Voice'

        ber = {'Select','10^-2','10^-3'};

        set(handles.ber_edit_popupmenu, 'Value', find((strcmp(link_ber_setting, ber)),1));

    case 'Emergency Messaging Data'

        ber = {'Select','10^-5','6x10^-8','10^-6'};

        set(handles.ber_edit_popupmenu, 'Value', find((strcmp(link_ber_setting, ber)),1));

    case 'Vessel Tracking Data (IoT)'

        ber = {'Select','10^-5','10^-6'};

        set(handles.ber_edit_popupmenu, 'Value', find((strcmp(link_ber_setting, ber)),1));

    otherwise

        set(handles.ber_edit_popupmenu, 'Value', 1);

end

% link_modulation_setting = link_con(item_num).system_params.mod_sch;
% %set(handles.modulation_text, 'String',link_con(item_num).system_params.mod_sch);
% setappdata(0, 'link_modsch', link_con(item_num).system_params.mod_sch);
% 
% switch link_tech_setting
%     case 'DSC'
% 
%         mods = {'Select', 'FSK'};
%         set(handles.mod_sch_edit_popupmenu, 'String', mods);
%         set(handles.mod_sch_edit_popupmenu, 'Value', find((strcmp(link_modulation_setting, mods)),1));
% 
%         
%     case 'LTE-A'
% 
%         mods = {'Select','QPSK','16QAM','64QAM','256QAM'};
%         set(handles.mod_sch_edit_popupmenu, 'String', mods);
%         set(handles.mod_sch_edit_popupmenu, 'Value', find((strcmp(link_modulation_setting, mods)),1));
%       
%         
%     case 'NWR'
% 
%         mods = {'Select','FSK'};
%         set(handles.mod_sch_edit_popupmenu, 'String', mods);
%         set(handles.mod_sch_edit_popupmenu, 'Value', find((strcmp(link_modulation_setting, mods)),1));
%       
%         
%     otherwise
%         set(handles.mod_sch_edit_popupmenu, 'String', 'Select');
%         set(handles.mod_sch_edit_popupmenu, 'Value', 1);
% 
% end
% 
% 
% 
% 
% link_coding_setting = link_con(item_num).system_params.code_rate;
% %set(handles.coding_text, 'String',link_con(item_num).system_params.code_rate  );
% setappdata(0, 'link_coding', link_con(item_num).system_params.code_rate);
% 
% switch link_modulation_setting
%     case 'QPSK'
% 
%         coders = {'Select','1/8','1/5','1/4','1/3','1/2','2/3','3/4','4/5'};
%         set(handles.coding_edit_popupmenu, 'String', coders);
%         set(handles.coding_edit_popupmenu, 'Value', find((strcmp(link_coding_setting, coders)),1));
%         
%     case '16QAM'
% 
%         coders = {'Select','1/3','1/2','2/3','3/4','4/5'};
%         set(handles.coding_edit_popupmenu, 'String', coders);
%         set(handles.coding_edit_popupmenu, 'Value', find((strcmp(link_coding_setting, coders)),1));
%         
%     case '64QAM'
% 
%         coders = {'Select','1/3','2/3','3/4','5/6'};
%         set(handles.coding_edit_popupmenu, 'String', coders);
%         set(handles.coding_edit_popupmenu, 'Value', find((strcmp(link_coding_setting, coders)),1));
%         
%     case '256QAM'
% 
%         coders = {'Select','1/3','3/4','5/6'};
%         set(handles.coding_edit_popupmenu, 'String', coders);
%         set(handles.coding_edit_popupmenu, 'Value', find((strcmp(link_coding_setting, coders)),1));
%         
%     otherwise
%         set(handles.coding_edit_popupmenu, 'String', 'Select');
%         set(handles.coding_edit_popupmenu, 'Value', 1);
% end


link_sysbw_setting = num2str(link_con(item_num).system_params.system_bandwidth);
%set(handles.modulation_text, 'String',link_con(item_num).system_params.mod_sch);
setappdata(0, 'link_sys_bw', link_con(item_num).system_params.system_bandwidth);

switch link_tech_setting
    case 'DSC'

        bws = {'Select','0.025'};
        set(handles.system_bw_edit_popupmenu, 'String', bws);
        set(handles.system_bw_edit_popupmenu, 'Value', find((strcmp(link_sysbw_setting, bws)),1));

        
    case 'LTE-A'

        bws = {'Select', '1.4', '3', '5', '10', '15', '20'};
        set(handles.system_bw_edit_popupmenu, 'String', bws);
        set(handles.system_bw_edit_popupmenu, 'Value', find((strcmp(link_sysbw_setting, bws)),1));
      
        
    case 'NWR'

        bws = {'Select','0.025'};
        set(handles.system_bw_edit_popupmenu, 'String', bws);
        set(handles.system_bw_edit_popupmenu, 'Value', find((strcmp(link_sysbw_setting, bws)),1));
  
    case 'Generic'
        bws = {'Select', '1.4', '3', '5', '10', '15', '20'};
        set(handles.system_bw_edit_popupmenu, 'String', bws);
        set(handles.system_bw_edit_popupmenu, 'Value', find((strcmp(link_sysbw_setting, bws)),1));
        
    otherwise
        set(handles.system_bw_edit_popupmenu, 'String', 'Select');
        set(handles.system_bw_edit_popupmenu, 'Value', 1);

end

link_direction_setting = link_con(item_num).system_params.link_direction;
%set(handles.link_direc_text, 'String',link_con(item_num).system_params.link_direction);
setappdata(0, 'link_direc', link_con(item_num).system_params.link_direction);


switch link_direction_setting
    
    case 'Downlink'
        set(handles.downlink_edit_radiobutton,'Value',1) ;
        set(handles.link_frequency_editing, 'String', link_con(item_num).system_params.freq);
        setappdata(0, 'link_freqy', link_con(item_num).system_params.freq);


    case 'Uplink'
        set(handles.uplink_edit_radiobutton,'Value',1) 
        set(handles.link_frequency_editing, 'String', link_con(item_num).system_params.freq);
        setappdata(0, 'link_freqy', link_con(item_num).system_params.freq);
        
        
    otherwise
        errordlg('Error Selecting Link Direction', 'Direction Selection')
    return;
end
% set(handles.link_freq_text, 'String',link_con(item_num).system_params.freq);     

if exist('nodesave.mat')
    load('nodesave.mat')

    choice_ind = 1;
    node_choices{choice_ind} = 'Select';
    for nodein = 1:save_ind
        if strcmp(link_tech_setting,node_con(nodein).equipment_params.technology)
            choice_ind = choice_ind + 1; 
            node_choices{choice_ind} = node_con(nodein).node_name;
%         else
%              if isempty(node_choices{choice_ind})
%               node_choices{choice_ind} = [];  
%              end
        end
    end
    
setappdata(0, 'node_list', node_choices);

% set(handles.node1_edit_popupmenu, 'String', node_choices);
% set(handles.node1_edit_popupmenu, 'Value', 1);

% set(handles.node2_popupmenu, 'String', node_choices);
% set(handles.node2_edit_popupmenu, 'Value', 1);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
link_node1_setting = link_con(item_num).node_selection.node1;
% set(handles.node1_edit_popupmenu, 'String',link_con(item_num).node_selection.node1);
setappdata(0, 'node_one', link_con(item_num).node_selection.node1);

link_node2_setting = link_con(item_num).node_selection.node2;
% set(handles.node2_edit_popupmenu, 'String',link_con(item_num).node_selection.node2);
setappdata(0, 'node_two', link_con(item_num).node_selection.node2);


current_list =  getappdata(0, 'node_list');
list_amt  = numel(current_list);
choice_ind = 0;
    for nodein = 1:list_amt 
        if strcmp(link_node2_setting,current_list(nodein))

         else
            choice_ind = choice_ind + 1; 
            node1_choices(choice_ind) = current_list(nodein);
        end
    end

set(handles.node1_edit_popupmenu, 'String', node1_choices);
set(handles.node1_edit_popupmenu, 'Value', find((strcmp(link_node1_setting, node1_choices)),1));


current_list =  getappdata(0, 'node_list');
list_amt  = numel(current_list);
choice_ind = 0;
    for nodein = 1:list_amt 
        if strcmp(link_node1_setting,current_list(nodein))

         else
            choice_ind = choice_ind + 1; 
            node2_choices(choice_ind) = current_list(nodein);
        end
    end

set(handles.node2_edit_popupmenu, 'String', node2_choices);
set(handles.node2_edit_popupmenu, 'Value', find((strcmp(link_node2_setting, node2_choices)),1));

% --- Executes during object creation, after setting all properties.
function linksel_popupmenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to linksel_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function link_name_editing_Callback(hObject, eventdata, handles)
% hObject    handle to link_name_editing (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of link_name_editing as text
%        str2double(get(hObject,'String')) returns contents of link_name_editing as a double
linkname = get(handles.link_name_editing, 'String');
setappdata(0, 'link_nam', linkname);

% --- Executes during object creation, after setting all properties.
function link_name_editing_CreateFcn(hObject, eventdata, handles)
% hObject    handle to link_name_editing (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in technology_edit_popupmenu.
function technology_edit_popupmenu_Callback(hObject, eventdata, handles)
% hObject    handle to technology_edit_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns technology_edit_popupmenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from technology_edit_popupmenu

contents = cellstr(get(hObject,'String'));
linktech = contents{get(hObject,'Value')};
setappdata(0, 'link_tech', linktech);

if strcmp('Select',linktech)
%     set(handles.mod_sch_edit_popupmenu,'Enable','off')
%     set(handles.coding_edit_popupmenu,'Enable','off')
%     set(handles.mod_text,'Enable','off')
%     set(handles.code_text,'Enable','off')
    set(handles.node1_edit_popupmenu,'Enable','off')
    set(handles.node2_edit_popupmenu,'Enable','off')
    
    set(handles.node1_edit_popupmenu, 'String', 'Select');
    set(handles.node1_edit_popupmenu, 'Value', 1);

    set(handles.node2_edit_popupmenu, 'String', 'Select');
    set(handles.node2_edit_popupmenu, 'Value', 1);
    
else
%     set(handles.mod_sch_edit_popupmenu,'Enable','on')
%     set(handles.coding_edit_popupmenu,'Enable','on')
%     set(handles.mod_text,'Enable','on')
%     set(handles.code_text,'Enable','on')
    set(handles.node1_edit_popupmenu,'Enable','on')
    set(handles.node2_edit_popupmenu,'Enable','on')
    %set(handles.system_bw_edit_popupmenu,'Enable','on')
end

if exist('nodesave.mat')
    load('nodesave.mat')
%     node_choices= {node_con.node_name}; 
%     node_choices = cell(1,save_ind);
    choice_ind = 1;
    node_choices{choice_ind} = 'Select';
    for nodein = 1:save_ind
        if strcmp(linktech,node_con(nodein).equipment_params.technology)
            choice_ind = choice_ind + 1; 
            node_choices{choice_ind} = node_con(nodein).node_name;
%         else
%              if isempty(node_choices{choice_ind})
%               node_choices{choice_ind} = [];  
%              end
        end
    end
    
setappdata(0, 'node_list', node_choices);

set(handles.node1_edit_popupmenu, 'String', node_choices);
set(handles.node1_edit_popupmenu, 'Value', 1);

set(handles.node2_edit_popupmenu, 'String', node_choices);
set(handles.node2_edit_popupmenu, 'Value', 1);
end

% switch linktech
%     case 'DSC'
% 
%         mods = {'Select', 'FSK'};
%         set(handles.mod_sch_edit_popupmenu, 'String', mods);
%         set(handles.mod_sch_edit_popupmenu, 'Value', 1);
%         set(handles.coding_edit_popupmenu, 'String', 'Select');
%         set(handles.coding_edit_popupmenu, 'Value', 1);
%         
%     case 'LTE-A'
% 
%         mods = {'Select','QPSK','16QAM','64QAM','256QAM'};
%         set(handles.mod_sch_edit_popupmenu, 'String', mods);
%         set(handles.mod_sch_edit_popupmenu, 'Value', 1);
%         set(handles.coding_edit_popupmenu, 'String', 'Select');
%         set(handles.coding_edit_popupmenu, 'Value', 1);        
%         
%     case 'NWR'
% 
%         mods = {'Select','FSK'};
%         set(handles.mod_sch_edit_popupmenu, 'String', mods);
%         set(handles.mod_sch_edit_popupmenu, 'Value', 1);
%         set(handles.coding_edit_popupmenu, 'String', 'Select');
%         set(handles.coding_edit_popupmenu, 'Value', 1);        
%         
%     otherwise
%         set(handles.mod_sch_edit_popupmenu, 'String', 'Select');
%         set(handles.mod_sch_edit_popupmenu, 'Value', 1);
%         set(handles.coding_edit_popupmenu, 'String', 'Select');
%         set(handles.coding_edit_popupmenu, 'Value', 1);
% end

% --- Executes during object creation, after setting all properties.
function technology_edit_popupmenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to technology_edit_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in node2_edit_popupmenu.
function node2_edit_popupmenu_Callback(hObject, eventdata, handles)
% hObject    handle to node2_edit_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns node2_edit_popupmenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from node2_edit_popupmenu
contents = cellstr(get(hObject,'String'));
nodetwo = contents{get(hObject,'Value')};
setappdata(0, 'node_two', nodetwo);

current_list =  getappdata(0, 'node_list');

list_amt  = numel(current_list);
choice_ind = 0;
    for nodein = 1:list_amt 
        if strcmp(nodetwo,current_list(nodein))

         else
            choice_ind = choice_ind + 1; 
            node_choices(choice_ind) = current_list(nodein);
        end
    end

set(handles.node1_edit_popupmenu, 'String', node_choices);

% --- Executes during object creation, after setting all properties.
function node2_edit_popupmenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to node2_edit_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in node1_edit_popupmenu.
function node1_edit_popupmenu_Callback(hObject, eventdata, handles)
% hObject    handle to node1_edit_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns node1_edit_popupmenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from node1_edit_popupmenu
contents = cellstr(get(hObject,'String'));
nodeone = contents{get(hObject,'Value')};
setappdata(0, 'node_one', nodeone);

node2_choice = getappdata(0, 'node_two');

if strcmp(nodeone ,node2_choice)
    errordlg('Please select two distinct nodes', 'Node Conflict')
    set(handles.node1_popupmenu, 'Value', 1);
end

% current_list =  getappdata(0, 'node_list');
% 
% list_amt  = numel(current_list);
% choice_ind = 0;
%     for nodein = 1:list_amt 
%         if strcmp(nodeone,current_list(nodein))
% 
%          else
%             choice_ind = choice_ind + 1; 
%             node_choices(choice_ind) = current_list(nodein);
%         end
%     end
% 
% set(handles.node2_edit_popupmenu, 'String', node_choices);


% --- Executes during object creation, after setting all properties.
function node1_edit_popupmenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to node1_edit_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function fading_editing_Callback(hObject, eventdata, handles)
% hObject    handle to fading_editing (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of fading_editing as text
%        str2double(get(hObject,'String')) returns contents of fading_editing as a double
linkfading = str2double(get(handles.fading_editing, 'String'));
setappdata(0, 'link_fading', linkfading);

% --- Executes during object creation, after setting all properties.
function fading_editing_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fading_editing (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function interf_editing_Callback(hObject, eventdata, handles)
% hObject    handle to interf_editing (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of interf_editing as text
%        str2double(get(hObject,'String')) returns contents of interf_editing as a double
linkinterf = str2double(get(handles.interf_editing, 'String'));
setappdata(0, 'link_interf', linkinterf);

% --- Executes during object creation, after setting all properties.
function interf_editing_CreateFcn(hObject, eventdata, handles)
% hObject    handle to interf_editing (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in pl_edit_popupmenu.
function pl_edit_popupmenu_Callback(hObject, eventdata, handles)
% hObject    handle to pl_edit_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns pl_edit_popupmenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from pl_edit_popupmenu
contents = cellstr(get(hObject,'String'));
linkpl = contents{get(hObject,'Value')};
setappdata(0, 'link_pl', linkpl);

% --- Executes during object creation, after setting all properties.
function pl_edit_popupmenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pl_edit_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function rec_band_editing_Callback(hObject, eventdata, handles)
% hObject    handle to rec_band_editing (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of rec_band_editing as text
%        str2double(get(hObject,'String')) returns contents of rec_band_editing as a double

linkrxbw = str2double(get(handles.rec_band_editing, 'String'));
setappdata(0, 'link_rxbw', linkrxbw);


% --- Executes during object creation, after setting all properties.
function rec_band_editing_CreateFcn(hObject, eventdata, handles)
% hObject    handle to rec_band_editing (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function temp_editing_Callback(hObject, eventdata, handles)
% hObject    handle to temp_editing (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of temp_editing as text
%        str2double(get(hObject,'String')) returns contents of temp_editing as a double
linktemp = str2double(get(handles.temp_editing, 'String'));
setappdata(0, 'link_temp', linktemp);

% --- Executes during object creation, after setting all properties.
function temp_editing_CreateFcn(hObject, eventdata, handles)
% hObject    handle to temp_editing (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function down_freq_editing_Callback(hObject, eventdata, handles)
% hObject    handle to down_freq_editing (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of down_freq_editing as text
%        str2double(get(hObject,'String')) returns contents of down_freq_editing as a double

% linkdownfreq = str2double(get(handles.down_freq_editing, 'String'));
% setappdata(0, 'link_downfreq', linkdownfreq);


% --- Executes during object creation, after setting all properties.
function down_freq_editing_CreateFcn(hObject, eventdata, handles)
% hObject    handle to down_freq_editing (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function up_freq_editing_Callback(hObject, eventdata, handles)
% hObject    handle to up_freq_editing (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of up_freq_editing as text
%        str2double(get(hObject,'String')) returns contents of up_freq_editing as a double

% linkupfreq = str2double(get(handles.up_freq_editing, 'String'));
% setappdata(0, 'link_upfreq', linkupfreq);

% --- Executes during object creation, after setting all properties.
function up_freq_editing_CreateFcn(hObject, eventdata, handles)
% hObject    handle to up_freq_editing (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in mod_sch_edit_popupmenu.
function mod_sch_edit_popupmenu_Callback(hObject, eventdata, handles)
% hObject    handle to mod_sch_edit_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns mod_sch_edit_popupmenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from mod_sch_edit_popupmenu
% contents = cellstr(get(hObject,'String'));
% linkmodsch= contents{get(hObject,'Value')};
% setappdata(0, 'link_modsch', linkmodsch);
% 
% switch linkmodsch
%     case 'QPSK'
% 
%         coders = {'Select','1/8','1/5','1/4','1/3','1/2','2/3','3/4','4/5'};
%         set(handles.coding_edit_popupmenu, 'String', coders);
%         set(handles.coding_edit_popupmenu, 'Value', 1);
%         
%     case '16QAM'
% 
%         coders = {'Select','1/3','1/2','2/3','3/4','4/5'};
%         set(handles.coding_edit_popupmenu, 'String', coders);
%         set(handles.coding_edit_popupmenu, 'Value', 1);
%         
%     case '64QAM'
% 
%         coders = {'Select','1/3','2/3','3/4','5/6'};
%         set(handles.coding_edit_popupmenu, 'String', coders);
%         set(handles.coding_edit_popupmenu, 'Value', 1);
%         
%     case '256QAM'
% 
%         coders = {'Select','1/3','3/4','5/6'};
%         set(handles.coding_edit_popupmenu, 'String', coders);
%         set(handles.coding_edit_popupmenu, 'Value', 1);
%         
%     otherwise
%         set(handles.coding_edit_popupmenu, 'String', 'Select');
%         set(handles.coding_edit_popupmenu, 'Value', 1);
% end


% --- Executes during object creation, after setting all properties.
function mod_sch_edit_popupmenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to mod_sch_edit_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in coding_edit_popupmenu.
function coding_edit_popupmenu_Callback(hObject, eventdata, handles)
% hObject    handle to coding_edit_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns coding_edit_popupmenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from coding_edit_popupmenu
% contents = cellstr(get(hObject,'String'));
% linkcoding= contents{get(hObject,'Value')};
% setappdata(0, 'link_coding', linkcoding);

% --- Executes during object creation, after setting all properties.
function coding_edit_popupmenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to coding_edit_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in service_edit_popupmenu.
function service_edit_popupmenu_Callback(hObject, eventdata, handles)
% hObject    handle to service_edit_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns service_edit_popupmenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from service_edit_popupmenu
contents = cellstr(get(hObject,'String'));
linkservice = contents{get(hObject,'Value')};
setappdata(0, 'link_service', linkservice);

if strcmp('Select',linkservice)
%     set(handles.ber_text,'Enable','off')
    set(handles.ber_edit_popupmenu,'Enable','off')
else
%     set(handles.ber_text,'Enable','on')
    set(handles.ber_edit_popupmenu,'Enable','on')
end

switch linkservice
    case 'Conversational Voice'

        ber = {'Select','10^-2','10^-3'};
        set(handles.ber_edit_popupmenu, 'String', ber);
        set(handles.ber_edit_popupmenu, 'Value', 1);
    case 'Emergency Messaging Data'

        ber = {'Select','10^-5','6x10^-8','10^-6'};
        set(handles.ber_edit_popupmenu, 'String', ber);
        set(handles.ber_edit_popupmenu, 'Value', 1);
    case 'Vessel Tracking Data (IoT)'

        ber = {'Select','10^-5','10^-6'};
        set(handles.ber_edit_popupmenu, 'String', ber);
        set(handles.ber_edit_popupmenu, 'Value', 1);
    otherwise
        set(handles.ber_edit_popupmenu, 'String', 'Select');
        set(handles.ber_edit_popupmenu, 'Value', 1);
end

% --- Executes during object creation, after setting all properties.
function service_edit_popupmenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to service_edit_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in ber_edit_popupmenu.
function ber_edit_popupmenu_Callback(hObject, eventdata, handles)
% hObject    handle to ber_edit_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns ber_edit_popupmenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from ber_edit_popupmenu
contents = cellstr(get(hObject,'String'));
linkber= contents{get(hObject,'Value')};
setappdata(0, 'link_ber', linkber);

% --- Executes during object creation, after setting all properties.
function ber_edit_popupmenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ber_edit_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes when selected object is changed in system_paramters_editsel.
function system_paramters_editsel_SelectionChangedFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in system_paramters_editsel 
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

switch eventdata.Source.SelectedObject.Tag
    
    case 'downlink_edit_radiobutton'
%         set(handles.up_freq_editing,'Enable','off') 
% %         set(handles.uplink_text,'Enable','off')
%         set(handles.down_freq_editing,'Enable','on')
% %         set(handles.downlink_text,'Enable','on') 
        
        direc =  'Downlink';
        setappdata(0, 'link_direc', direc);
        
    case 'uplink_edit_radiobutton'
%         set(handles.up_freq_editing,'Enable','on') 
% %         set(handles.uplink_text,'Enable','on')
%         set(handles.down_freq_editing,'Enable','off')
% %         set(handles.downlink_text,'Enable','off') 
        
        direc =  'Uplink';
        setappdata(0, 'link_direc', direc);
    otherwise
        errordlg('Error Selecting Link Direction', 'Direction Selection')
    return;
end
        

guidata(handles.figure_link_edit, handles);



function link_frequency_editing_Callback(hObject, eventdata, handles)
% hObject    handle to link_frequency_editing (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of link_frequency_editing as text
%        str2double(get(hObject,'String')) returns contents of link_frequency_editing as a double

link_freq = str2double(get(handles.link_frequency_editing, 'String'));
setappdata(0, 'link_freqy', link_freq);


% --- Executes during object creation, after setting all properties.
function link_frequency_editing_CreateFcn(hObject, eventdata, handles)
% hObject    handle to link_frequency_editing (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in system_bw_edit_popupmenu.
function system_bw_edit_popupmenu_Callback(hObject, eventdata, handles)
% hObject    handle to system_bw_edit_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns system_bw_edit_popupmenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from system_bw_edit_popupmenu
contents = cellstr(get(hObject,'String'));
link_sysbw= str2double(contents{get(hObject,'Value')});
setappdata(0, 'link_sys_bw', link_sysbw);

% --- Executes during object creation, after setting all properties.
function system_bw_edit_popupmenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to system_bw_edit_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in chan_type_edit_popupmenu.
function chan_type_edit_popupmenu_Callback(hObject, eventdata, handles)
% hObject    handle to chan_type_edit_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns chan_type_edit_popupmenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from chan_type_edit_popupmenu
contents = cellstr(get(hObject,'String'));
link_chantyp= contents{get(hObject,'Value')};
setappdata(0, 'link_chan_typ', link_chantyp);

% --- Executes during object creation, after setting all properties.
function chan_type_edit_popupmenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to chan_type_edit_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
