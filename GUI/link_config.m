function varargout = link_config(varargin)
% LINK_CONFIG MATLAB code for link_config.fig
%      LINK_CONFIG, by itself, creates a new LINK_CONFIG or raises the existing
%      singleton*.
%
%      H = LINK_CONFIG returns the handle to a new LINK_CONFIG or the handle to
%      the existing singleton*.
%
%      LINK_CONFIG('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in LINK_CONFIG.M with the given input arguments.
%
%      LINK_CONFIG('Property','Value',...) creates a new LINK_CONFIG or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before link_config_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to link_config_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help link_config

% Last Modified by GUIDE v2.5 12-Mar-2018 17:41:28

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @link_config_OpeningFcn, ...
                   'gui_OutputFcn',  @link_config_OutputFcn, ...
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


% --- Executes just before link_config is made visible.
function link_config_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to link_config (see VARARGIN)

% Choose default command line output for link_config
handles.output = hObject;

% set(handles.up_freq_edit,'Enable','off') 
% set(handles.uplink_text,'Enable','off')
% set(handles.down_freq_edit,'Enable','on')
% set(handles.downlink_text,'Enable','on') 

% set(handles.mod_sch_popupmenu,'Enable','off')
% set(handles.code_rate_popupmenu,'Enable','off')
% set(handles.mod_text,'Enable','off')
% set(handles.code_text,'Enable','off')

set(handles.ber_text,'Enable','off')
set(handles.ber_popupmenu,'Enable','off')

set(handles.node1_popupmenu,'Enable','off')
set(handles.node2_popupmenu,'Enable','off')
set(handles.sys_bw_popupmenu,'Enable','off')
set(handles.sys_bw_text,'Enable','off')
% setappdata(0, 'link_tech', 'Select');

%Node selection code
% if exist('nodesave.mat')
%     load('nodesave.mat')
%      node_choices= {node_con.node_name};   
% %     for nodein = 1:save_ind
% %     node_choices(nodein) = node_con(nodein).node_name;
% %     end
% set(handles.node1_popupmenu, 'String', node_choices);
% set(handles.node1_popupmenu, 'Value', 1);
% 
% set(handles.node2_popupmenu, 'String', node_choices);
% set(handles.node2_popupmenu, 'Value', 1);
% end


set(handles.node1_popupmenu, 'String', 'Select');
set(handles.node1_popupmenu, 'Value', 1);

set(handles.node2_popupmenu, 'String', 'Select');
set(handles.node2_popupmenu, 'Value', 1);


setappdata(0, 'node_one', 'Select');
setappdata(0, 'node_two', 'Select');
setappdata(0, 'link_service', 'Select');
setappdata(0, 'link_ber', 'Select');
setappdata(0, 'link_tech', 'Select');
setappdata(0, 'link_pl', 'Select');
% setappdata(0, 'link_modsch', 'Select');
% setappdata(0, 'link_coding', 'Select');
setappdata(0, 'link_direc', 'Downlink');

setappdata(0, 'link_sys_bw', 'Select');
setappdata(0, 'link_chan_typ', 'Select');

save_counter_link = 0;
setappdata(0, 'linksavecounter', save_counter_link);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes link_config wait for user response (see UIRESUME)
% uiwait(handles.figure_link);


% --- Outputs from this function are returned to the command line.
function varargout = link_config_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in ok_link_pushbutton.
function ok_link_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to ok_link_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close(link_config)

% --- Executes on button press in link_cancel_pushbutton.
function link_cancel_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to link_cancel_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close(link_config)


function rec_band_edit_Callback(hObject, eventdata, handles)
% hObject    handle to rec_band_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of rec_band_edit as text
%        str2double(get(hObject,'String')) returns contents of rec_band_edit as a double
linkrxbw = str2double(get(handles.rec_band_edit, 'String'));
setappdata(0, 'link_rxbw', linkrxbw);

% --- Executes during object creation, after setting all properties.
function rec_band_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to rec_band_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function temp_edit_Callback(hObject, eventdata, handles)
% hObject    handle to temp_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of temp_edit as text
%        str2double(get(hObject,'String')) returns contents of temp_edit as a double
linktemp = str2double(get(handles.temp_edit, 'String'));
setappdata(0, 'link_temp', linktemp);

% --- Executes during object creation, after setting all properties.
function temp_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to temp_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function down_freq_edit_Callback(hObject, eventdata, handles)
% hObject    handle to down_freq_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of down_freq_edit as text
%        str2double(get(hObject,'String')) returns contents of down_freq_edit as a double

% linkdownfreq = str2double(get(handles.down_freq_edit, 'String'));
% setappdata(0, 'link_downfreq', linkdownfreq);

% --- Executes during object creation, after setting all properties.
function down_freq_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to down_freq_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function up_freq_edit_Callback(hObject, eventdata, handles)
% hObject    handle to up_freq_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of up_freq_edit as text
%        str2double(get(hObject,'String')) returns contents of up_freq_edit as a double

% linkupfreq = str2double(get(handles.up_freq_edit, 'String'));
% setappdata(0, 'link_upfreq', linkupfreq);

% --- Executes during object creation, after setting all properties.
function up_freq_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to up_freq_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in service_popupmenu.
function service_popupmenu_Callback(hObject, eventdata, handles)
% hObject    handle to service_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns service_popupmenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from service_popupmenu
contents = cellstr(get(hObject,'String'));
linkservice = contents{get(hObject,'Value')};
setappdata(0, 'link_service', linkservice);

if strcmp('Select',linkservice)
    set(handles.ber_text,'Enable','off')
    set(handles.ber_popupmenu,'Enable','off')
else
    set(handles.ber_text,'Enable','on')
    set(handles.ber_popupmenu,'Enable','on')
end

switch linkservice
    case 'Conversational Voice'
%         ber = {10^-3,10^-2};
        ber = {'Select','10^-2','10^-3'};
        set(handles.ber_popupmenu, 'String', ber);
    case 'Emergency Messaging Data'
%         ber = {10^-5,6*10^-8};
        ber = {'Select','10^-5','6x10^-8','10^-6'};
        set(handles.ber_popupmenu, 'String', ber);
    case 'Vessel Tracking Data (IoT)'
%         ber = {10^-5};
        ber = {'Select','10^-5','10^-6'};
        set(handles.ber_popupmenu, 'String', ber);
        set(handles.ber_popupmenu, 'Value', 1);
    otherwise
        set(handles.ber_popupmenu, 'String', 'Select');
        set(handles.ber_popupmenu, 'Value', 1);
end

% --- Executes during object creation, after setting all properties.
function service_popupmenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to service_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in ber_popupmenu.
function ber_popupmenu_Callback(hObject, eventdata, handles)
% hObject    handle to ber_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns ber_popupmenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from ber_popupmenu
contents = cellstr(get(hObject,'String'));
linkber= contents{get(hObject,'Value')};
setappdata(0, 'link_ber', linkber);

% --- Executes during object creation, after setting all properties.
function ber_popupmenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ber_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in technology_popupmenu.
function technology_popupmenu_Callback(hObject, eventdata, handles)
% hObject    handle to technology_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns technology_popupmenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from technology_popupmenu
contents = cellstr(get(hObject,'String'));
linktech = contents{get(hObject,'Value')};
setappdata(0, 'link_tech', linktech);

if strcmp('Select',linktech)
%     set(handles.mod_sch_popupmenu,'Enable','off')
%     set(handles.code_rate_popupmenu,'Enable','off')
%     set(handles.mod_text,'Enable','off')
%     set(handles.code_text,'Enable','off')
    set(handles.node1_popupmenu,'Enable','off')
    set(handles.node2_popupmenu,'Enable','off')
    
    set(handles.node1_popupmenu, 'String', 'Select');
    set(handles.node1_popupmenu, 'Value', 1);

    set(handles.node2_popupmenu, 'String', 'Select');
    set(handles.node2_popupmenu, 'Value', 1);
    

    
else
%     set(handles.mod_sch_popupmenu,'Enable','on')
%     set(handles.code_rate_popupmenu,'Enable','on')
%     set(handles.mod_text,'Enable','on')
%     set(handles.code_text,'Enable','on')
    set(handles.node1_popupmenu,'Enable','on')
    set(handles.node2_popupmenu,'Enable','on')
    set(handles.sys_bw_popupmenu,'Enable','on')
    set(handles.sys_bw_text,'Enable','on')
        
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

set(handles.node1_popupmenu, 'String', node_choices);
set(handles.node1_popupmenu, 'Value', 1);

set(handles.node2_popupmenu, 'String', node_choices);
set(handles.node2_popupmenu, 'Value', 1);
end

% switch linktech
%     case 'DSC'
% 
%         mods = {'Select', 'FSK'};
%         set(handles.mod_sch_popupmenu, 'String', mods);
%         set(handles.mod_sch_popupmenu, 'Value', 1);
%         set(handles.code_rate_popupmenu, 'String', 'Select');
%         set(handles.code_rate_popupmenu, 'Value', 1);
%         
%     case 'LTE-A'
% 
%         mods = {'Select','QPSK','16QAM','64QAM','256QAM'};
%         set(handles.mod_sch_popupmenu, 'String', mods);
%         set(handles.mod_sch_popupmenu, 'Value', 1);
%         set(handles.code_rate_popupmenu, 'String', 'Select');
%         set(handles.code_rate_popupmenu, 'Value', 1);        
%         
%     case 'NWR'
% 
%         mods = {'Select','FSK'};
%         set(handles.mod_sch_popupmenu, 'String', mods);
%         set(handles.mod_sch_popupmenu, 'Value', 1);
%         set(handles.code_rate_popupmenu, 'String', 'Select');
%         set(handles.code_rate_popupmenu, 'Value', 1);        
%         
%     otherwise
%         set(handles.mod_sch_popupmenu, 'String', 'Select');
%         set(handles.mod_sch_popupmenu, 'Value', 1);
%         set(handles.code_rate_popupmenu, 'String', 'Select');
%         set(handles.code_rate_popupmenu, 'Value', 1);
% end

switch linktech
    case 'DSC'

        bws = {'Select','0.025'};
        %bws = {'Select','2', '4', '6', '8', '12', '16'};
        set(handles.sys_bw_popupmenu, 'String', bws);
        set(handles.sys_bw_popupmenu, 'Value', 1);

        
    case 'LTE-A'

        bws = {'Select', '1.4', '3', '5', '10', '15', '20'};
        set(handles.sys_bw_popupmenu, 'String', bws);
        set(handles.sys_bw_popupmenu, 'Value', 1);
       
        
    case 'NWR'
        
        bws = {'Select','0.025'};
        set(handles.sys_bw_popupmenu, 'String', bws);
        set(handles.sys_bw_popupmenu, 'Value', 1);
        
    case 'Generic'
        
        bws = {'Select', '1.4', '3', '5', '10', '15', '20'};
        set(handles.sys_bw_popupmenu, 'String', bws);
        set(handles.sys_bw_popupmenu, 'Value', 1);
        
    otherwise
        
        bws = {'Select'};
        set(handles.sys_bw_popupmenu, 'String', bws);
        set(handles.sys_bw_popupmenu, 'Value', 1);

end
% --- Executes during object creation, after setting all properties.
function technology_popupmenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to technology_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function fading_edit_Callback(hObject, eventdata, handles)
% hObject    handle to fading_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of fading_edit as text
%        str2double(get(hObject,'String')) returns contents of fading_edit as a double
linkfading = str2double(get(handles.fading_edit, 'String'));
setappdata(0, 'link_fading', linkfading);

% --- Executes during object creation, after setting all properties.
function fading_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fading_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function interf_edit_Callback(hObject, eventdata, handles)
% hObject    handle to interf_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of interf_edit as text
%        str2double(get(hObject,'String')) returns contents of interf_edit as a double
linkinterf = str2double(get(handles.interf_edit, 'String'));
setappdata(0, 'link_interf', linkinterf);

% --- Executes during object creation, after setting all properties.
function interf_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to interf_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in path_loss_popupmenu.
function path_loss_popupmenu_Callback(hObject, eventdata, handles)
% hObject    handle to path_loss_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns path_loss_popupmenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from path_loss_popupmenu
contents = cellstr(get(hObject,'String'));
linkpl = contents{get(hObject,'Value')};
setappdata(0, 'link_pl', linkpl);

% --- Executes during object creation, after setting all properties.
function path_loss_popupmenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to path_loss_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in mod_sch_popupmenu.
function mod_sch_popupmenu_Callback(hObject, eventdata, handles)
% hObject    handle to mod_sch_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns mod_sch_popupmenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from mod_sch_popupmenu
% contents = cellstr(get(hObject,'String'));
% linkmodsch= contents{get(hObject,'Value')};
% setappdata(0, 'link_modsch', linkmodsch);
% 
% switch linkmodsch
%     case 'QPSK'
% 
%         coders = {'Select','1/8','1/5','1/4','1/3','1/2','2/3','3/4','4/5'};
%         set(handles.code_rate_popupmenu, 'String', coders);
%         set(handles.code_rate_popupmenu, 'Value', 1);
%         
%     case '16QAM'
% 
%         coders = {'Select','1/3','1/2','2/3','3/4','4/5'};
%         set(handles.code_rate_popupmenu, 'String', coders);
%         set(handles.code_rate_popupmenu, 'Value', 1);
%         
%     case '64QAM'
% 
%         coders = {'Select','1/3','2/3','3/4','5/6'};
%         set(handles.code_rate_popupmenu, 'String', coders);
%         set(handles.code_rate_popupmenu, 'Value', 1);
%         
%     case '256QAM'
% 
%         coders = {'Select','1/3','3/4','5/6'};
%         set(handles.code_rate_popupmenu, 'String', coders);
%         set(handles.code_rate_popupmenu, 'Value', 1);
%         
%     otherwise
%         set(handles.code_rate_popupmenu, 'String', 'Select');
%         set(handles.code_rate_popupmenu, 'Value', 1);
% end

% --- Executes during object creation, after setting all properties.
function mod_sch_popupmenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to mod_sch_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in code_rate_popupmenu.
function code_rate_popupmenu_Callback(hObject, eventdata, handles)
% hObject    handle to code_rate_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns code_rate_popupmenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from code_rate_popupmenu
% contents = cellstr(get(hObject,'String'));
% linkcoding= contents{get(hObject,'Value')};
% setappdata(0, 'link_coding', linkcoding);

% --- Executes during object creation, after setting all properties.
function code_rate_popupmenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to code_rate_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in node2_popupmenu.
function node2_popupmenu_Callback(hObject, eventdata, handles)
% hObject    handle to node2_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns node2_popupmenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from node2_popupmenu
contents = cellstr(get(hObject,'String'));
nodetwo = contents{get(hObject,'Value')};
setappdata(0, 'node_two', nodetwo);

 node1_choice = getappdata(0, 'node_one');
if strcmp(nodetwo ,node1_choice )
    errordlg('Please select two distinct nodes', 'Node Conflict')
    set(handles.node2_popupmenu, 'Value', 1);
end
% current_list =  getappdata(0, 'node_list');
% % current_list =  handles.node1_popupmenu.String;
% list_amt  = numel(current_list);
% choice_ind = 0;
%     for nodein = 1:list_amt 
%         if strcmp(nodetwo,current_list(nodein))
% 
%          else
%             choice_ind = choice_ind + 1; 
%             node_choices(choice_ind) = current_list(nodein);
%         end
%     end
% 
% set(handles.node1_popupmenu, 'String', node_choices);
% set(handles.node1_popupmenu, 'Value', 1);

% --- Executes during object creation, after setting all properties.
function node2_popupmenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to node2_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in node1_popupmenu.
function node1_popupmenu_Callback(hObject, eventdata, handles)
% hObject    handle to node1_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns node1_popupmenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from node1_popupmenu
contents = cellstr(get(hObject,'String'));
nodeone = contents{get(hObject,'Value')};
setappdata(0, 'node_one', nodeone);

node2_choice = getappdata(0, 'node_two');

if strcmp(nodeone ,node2_choice)
    errordlg('Please select two distinct nodes', 'Node Conflict')
    set(handles.node1_popupmenu, 'Value', 1);
end
% current_list =  getappdata(0, 'node_list');
% % current_list =  handles.node2_popupmenu.String;
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
% set(handles.node2_popupmenu, 'String', node_choices);
% set(handles.node2_popupmenu, 'Value', 1);

% --- Executes during object creation, after setting all properties.
function node1_popupmenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to node1_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in save_link_pushbutton.
function save_link_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to save_link_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

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
% sav_link_con.system_params.mod_sch = getappdata(0,'link_modsch');
% 
% sav_link_con.system_params.code_rate = getappdata(0,'link_coding'); 

sav_link_con.system_params.system_bandwidth = getappdata(0,'link_sys_bw');

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


if exist('linksave.mat')    
for name_ind = 1:save_slots_used
    if strcmp(getappdata(0,'link_nam'), link_con(name_ind).link_name)
        name_conflict_flag = 1;
        setappdata(0,'linknameflag',name_conflict_flag)
        %errordlg('A node of this name already exists please change the name of your entry', 'Name Conflict')
    end  
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
    
    savelink(sav_link_con)
    close(link_config)
    
end


function savelink(sav_link_con)


save_counter_link = getappdata(0, 'linksavecounter');

if exist('linksave.mat')
    load('linksave.mat')
    if exist('save_ind_link')
        save_counter_link = save_ind_link;
    end
end
save_counter_link = save_counter_link + 1;

%Saving Index
save_ind_link = save_counter_link;

%Link Name
link_con(save_counter_link).link_name = sav_link_con.link_name;

%Link Technology
link_con(save_counter_link).technology = sav_link_con.technology;

%Link Node Selections
link_con(save_counter_link).node_selection.node1 = sav_link_con.node_selection.node1;

link_con(save_counter_link).node_selection.node2 = sav_link_con.node_selection.node2;

%Link Service
link_con(save_counter_link).node_service.service = sav_link_con.node_selection.service;

link_con(save_counter_link).node_service.ber = sav_link_con.node_selection.ber;

%Link System Paramters
% link_con(save_counter_link).system_params.mod_sch = sav_link_con.system_params.mod_sch;
% 
% link_con(save_counter_link).system_params.code_rate = sav_link_con.system_params.code_rate;

link_con(save_counter_link).system_params.system_bandwidth = sav_link_con.system_params.system_bandwidth;

link_con(save_counter_link).system_params.link_direction = sav_link_con.system_params.link_direction;
    
link_con(save_counter_link).system_params.freq = sav_link_con.system_params.freq;
    
%Link Channel Parameters
link_con(save_counter_link).channel.path_loss_model = sav_link_con.channel.path_loss_model;

link_con(save_counter_link).channel.fading_margin = sav_link_con.channel.fading_margin ;

link_con(save_counter_link).channel.interference_margin = sav_link_con.channel.interference_margin;

link_con(save_counter_link).channel.channel_type = sav_link_con.channel.channel_type;

%Link Receiver Paramters
link_con(save_counter_link).receiver.temperature = sav_link_con.receiver.temperature;

link_con(save_counter_link).receiver.rx_bandwidth = sav_link_con.receiver.rx_bandwidth;


save('linksave.mat','link_con','save_ind_link')


function link_name_edit_Callback(hObject, eventdata, handles)
% hObject    handle to link_name_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of link_name_edit as text
%        str2double(get(hObject,'String')) returns contents of link_name_edit as a double
linkname = get(handles.link_name_edit, 'String');
setappdata(0, 'link_nam', linkname);

% --- Executes during object creation, after setting all properties.
function link_name_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to link_name_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes when selected object is changed in system_paramters_selection.
function system_paramters_selection_SelectionChangedFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in system_paramters_selection 
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

switch eventdata.Source.SelectedObject.Tag
    
    case 'downlink_radiobutton'
%         set(handles.up_freq_edit,'Enable','off') 
%         set(handles.uplink_text,'Enable','off')
%         set(handles.down_freq_edit,'Enable','on')
%         set(handles.downlink_text,'Enable','on') 
        
        direc =  'Downlink';
        setappdata(0, 'link_direc', direc);
        
    case 'uplink_radiobutton'
%         set(handles.up_freq_edit,'Enable','on') 
%         set(handles.uplink_text,'Enable','on')
%         set(handles.down_freq_edit,'Enable','off')
%         set(handles.downlink_text,'Enable','off') 
        
        direc =  'Uplink';
        setappdata(0, 'link_direc', direc);
    otherwise
        errordlg('Error Selecting Link Direction', 'Direction Selection')
    return;
end
        

guidata(handles.figure_link, handles);



function link_frequency_edit_Callback(hObject, eventdata, handles)
% hObject    handle to link_frequency_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of link_frequency_edit as text
%        str2double(get(hObject,'String')) returns contents of link_frequency_edit as a double

link_freq = str2double(get(handles.link_frequency_edit, 'String'));
setappdata(0, 'link_freqy', link_freq);

% --- Executes during object creation, after setting all properties.
function link_frequency_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to link_frequency_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in sys_bw_popupmenu.
function sys_bw_popupmenu_Callback(hObject, eventdata, handles)
% hObject    handle to sys_bw_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns sys_bw_popupmenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from sys_bw_popupmenu
contents = cellstr(get(hObject,'String'));
link_sysbw= str2double(contents{get(hObject,'Value')});
setappdata(0, 'link_sys_bw', link_sysbw);

% --- Executes during object creation, after setting all properties.
function sys_bw_popupmenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sys_bw_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in chan_type_popupmenu.
function chan_type_popupmenu_Callback(hObject, eventdata, handles)
% hObject    handle to chan_type_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns chan_type_popupmenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from chan_type_popupmenu
contents = cellstr(get(hObject,'String'));
link_chantyp= contents{get(hObject,'Value')};
setappdata(0, 'link_chan_typ', link_chantyp);

% --- Executes during object creation, after setting all properties.
function chan_type_popupmenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to chan_type_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
