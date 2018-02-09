function varargout = node_config(varargin)
% NODE_CONFIG MATLAB code for node_config.fig
%      NODE_CONFIG, by itself, creates a new NODE_CONFIG or raises the existing
%      singleton*.
%
%      H = NODE_CONFIG returns the handle to a new NODE_CONFIG or the handle to
%      the existing singleton*.
%
%      NODE_CONFIG('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in NODE_CONFIG.M with the given input arguments.
%
%      NODE_CONFIG('Property','Value',...) creates a new NODE_CONFIG or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before node_config_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to node_config_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help node_config

% Last Modified by GUIDE v2.5 07-Feb-2018 14:46:15

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @node_config_OpeningFcn, ...
                   'gui_OutputFcn',  @node_config_OutputFcn, ...
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


% --- Executes just before node_config is made visible.
function node_config_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to node_config (see VARARGIN)

% Choose default command line output for node_config
handles.output = hObject;

set(handles.longitude_edit,'Enable','on')
set(handles.latitude_edit,'Enable','on') 
set(handles.longitude_text,'Enable','on')
set(handles.latitude_text,'Enable','on') 

%Node Name
setappdata(0,'node_name',string.empty);

%Node Location 
    
setappdata(0,'lat_itude',double.empty);

setappdata(0,'long_itude',double.empty);

%Equipment Paramters
setappdata(0,'node_tech',string.empty);

setappdata(0,'noise_fig',double.empty);

setappdata(0,'tx_power',double.empty);

setappdata(0,'rx_power',double.empty);

setappdata(0,'txant_gain',double.empty);

setappdata(0,'rxant_gain',double.empty);

setappdata(0,'txcab_loss',double.empty);

setappdata(0,'rxcab_loss',double.empty);


save_counter_link = 0;
setappdata(0, 'savecounter', save_counter_link);
%node_datastructures
%testscript
%global testvar;
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes node_config wait for user response (see UIRESUME)
% uiwait(handles.figure_node);


% --- Outputs from this function are returned to the command line.
function varargout = node_config_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function noise_fig_edit_Callback(hObject, eventdata, handles)
% hObject    handle to noise_fig_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of noise_fig_edit as text
%        str2double(get(hObject,'String')) returns contents of noise_fig_edit as a double
noisefig = str2double(get(handles.noise_fig_edit, 'String'));
setappdata(0, 'noise_fig', noisefig);

% --- Executes during object creation, after setting all properties.
function noise_fig_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to noise_fig_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function rx_power_edit_Callback(hObject, eventdata, handles)
% hObject    handle to rx_power_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of rx_power_edit as text
%        str2double(get(hObject,'String')) returns contents of rx_power_edit as a double
rxpower = str2double(get(handles.rx_power_edit, 'String'));
setappdata(0, 'rx_power', rxpower);

% --- Executes during object creation, after setting all properties.
function rx_power_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to rx_power_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function rx_ant_gain_edit_Callback(hObject, eventdata, handles)
% hObject    handle to rx_ant_gain_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of rx_ant_gain_edit as text
%        str2double(get(hObject,'String')) returns contents of rx_ant_gain_edit as a double
rxantgain = str2double(get(handles.rx_ant_gain_edit, 'String'));
setappdata(0, 'rxant_gain', rxantgain);

% --- Executes during object creation, after setting all properties.
function rx_ant_gain_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to rx_ant_gain_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function rx_cable_loss_edit_Callback(hObject, eventdata, handles)
% hObject    handle to rx_cable_loss_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of rx_cable_loss_edit as text
%        str2double(get(hObject,'String')) returns contents of rx_cable_loss_edit as a double
rxcabloss = str2double(get(handles.rx_cable_loss_edit, 'String'));
setappdata(0, 'rxcab_loss', rxcabloss);

% --- Executes during object creation, after setting all properties.
function rx_cable_loss_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to rx_cable_loss_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function tx_power_edit_Callback(hObject, eventdata, handles)
% hObject    handle to tx_power_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of tx_power_edit as text
%        str2double(get(hObject,'String')) returns contents of tx_power_edit as a double
txpower = str2double(get(handles.tx_power_edit, 'String'));
setappdata(0, 'tx_power', txpower);


% --- Executes during object creation, after setting all properties.
function tx_power_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to tx_power_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function tx_ant_gain_edit_Callback(hObject, eventdata, handles)
% hObject    handle to tx_ant_gain_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of tx_ant_gain_edit as text
%        str2double(get(hObject,'String')) returns contents of tx_ant_gain_edit as a double
txantgain = str2double(get(handles.tx_ant_gain_edit, 'String'));
setappdata(0, 'txant_gain', txantgain);

% --- Executes during object creation, after setting all properties.
function tx_ant_gain_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to tx_ant_gain_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function tx_cable_loss_edit_Callback(hObject, eventdata, handles)
% hObject    handle to tx_cable_loss_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of tx_cable_loss_edit as text
%        str2double(get(hObject,'String')) returns contents of tx_cable_loss_edit as a double
% testvar1 = str2double(get(handles.tx_cable_loss_edit, 'String'));
% setappdata(0, 'testvar2', testvar1);
txcabloss = str2double(get(handles.tx_cable_loss_edit, 'String'));
setappdata(0, 'txcab_loss', txcabloss);

% --- Executes during object creation, after setting all properties.
function tx_cable_loss_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to tx_cable_loss_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function longitude_edit_Callback(hObject, eventdata, handles)
% hObject    handle to longitude_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of longitude_edit as text
%        str2double(get(hObject,'String')) returns contents of longitude_edit as a double
longit = str2double(get(handles.longitude_edit, 'String'));
setappdata(0, 'long_itude', longit);

% --- Executes during object creation, after setting all properties.
function longitude_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to longitude_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function latitude_edit_Callback(hObject, eventdata, handles)
% hObject    handle to latitude_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of latitude_edit as text
%        str2double(get(hObject,'String')) returns contents of latitude_edit as a double
latit = str2double(get(handles.latitude_edit, 'String'));
setappdata(0, 'lat_itude', latit);




% --- Executes during object creation, after setting all properties.
function latitude_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to latitude_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in tower_radiobutton.
function tower_radiobutton_Callback(hObject, eventdata, handles)
% hObject    handle to tower_radiobutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of tower_radiobutton


% --- Executes on button press in mobile_radiobutton.
function mobile_radiobutton_Callback(hObject, eventdata, handles)
% hObject    handle to mobile_radiobutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of mobile_radiobutton


% --- Executes on button press in ok_node_pushbutton.
function ok_node_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to ok_node_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close(node_config)

% --- Executes on button press in cancel_node_pushbutton.
function cancel_node_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to cancel_node_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close(node_config)


% --- Executes on button press in save_node_pushbutton.
function save_node_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to save_node_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%global testvar;
% testvar1 = str2double(get(handles.tx_cable_loss_edit, 'String'));
% setappdata(0, 'testvar2', testvar1);

% testvar = getappdata(handles.tx_cable_loss_edit, 'String')
% testvar = 10

% txantgain = str2double(get(handles.tx_ant_gain_edit, 'String'));
% setappdata(0, 'txant_gain', txantgain);
% tx_antgain = getappdata(0,'txant_gain');
% sav_node_con.equipment_params.tx_ant_gain = tx_antgain;
% savenode(sav_node_con)

type_flag = get(handles.node_type_selection, 'UserData');
location_flag = get(handles.node_location_selection, 'UserData');



if exist('nodesave.mat')
    load('nodesave.mat')
end


% nodeplace_typ = 'Specify Co-ordinates';
% sav_node_con.node_type = 'Tower Mounted';

%Node Name
sav_node_con.node_name = getappdata(0,'node_name');

%Node Type
if 1 == type_flag
    sav_node_con.node_type = getappdata(0,'node_typ');
else
    sav_node_con.node_type = 'Tower Mounted';
end
%Node Location 
if 1 == location_flag
    sav_node_con.node_location.placement_type = getappdata(0,'nodeplace_typ');
    
    if strcmp(sav_node_con.node_location.placement_type,'Mouse Placement')
    sav_node_con.node_location.lati = 0;

    sav_node_con.node_location.longi = 0;
    
    else
        
    sav_node_con.node_location.lati = getappdata(0,'lat_itude');

    sav_node_con.node_location.longi = getappdata(0,'long_itude');
    end
else
    sav_node_con.node_location.placement_type = 'Specify Co-ordinates';
    
    sav_node_con.node_location.lati = getappdata(0,'lat_itude');

    sav_node_con.node_location.longi = getappdata(0,'long_itude');
end



%Equipment Paramters
sav_node_con.equipment_params.technology = getappdata(0,'node_tech');

sav_node_con.equipment_params.noise_fig = getappdata(0,'noise_fig');

sav_node_con.equipment_params.tx_pwr = getappdata(0,'tx_power');

sav_node_con.equipment_params.rx_pwr = getappdata(0,'rx_power');

sav_node_con.equipment_params.tx_ant_gain = getappdata(0,'txant_gain');

sav_node_con.equipment_params.rx_ant_gain = getappdata(0,'rxant_gain');

sav_node_con.equipment_params.tx_cable_loss = getappdata(0,'txcab_loss');

sav_node_con.equipment_params.rx_cable_loss = getappdata(0,'rxcab_loss');



set(handles.node_type_selection, 'UserData', 0);
set(handles.node_location_selection, 'UserData', 0);



save_slots_used = numel(node_con);
    
for name_ind = 1:save_slots_used
    if strcmp(getappdata(0,'node_name'), node_con(name_ind).node_name)
        name_conflict_flag = 1;
        setappdata(0,'nameflag',name_conflict_flag)
        %errordlg('A node of this name already exists please change the name of your entry', 'Name Conflict')
    end  
end

if  getappdata(0,'nameflag') == 1
   
    errordlg('A node of this name already exists please change the name of your entry', 'Name Conflict')
    setappdata(0,'nameflag',0)
    
elseif  isempty(sav_node_con.node_name)||isempty(sav_node_con.node_location.lati)||isempty(sav_node_con.node_location.longi)||isempty(sav_node_con.equipment_params.technology)||isempty(sav_node_con.equipment_params.noise_fig)||isempty(sav_node_con.equipment_params.tx_pwr)||isempty(sav_node_con.equipment_params.rx_pwr)||isempty(sav_node_con.equipment_params.tx_ant_gain)||isempty(sav_node_con.equipment_params.rx_ant_gain)||isempty(sav_node_con.equipment_params.tx_cable_loss)||isempty(sav_node_con.equipment_params.rx_cable_loss)
        
    errordlg('Please fill all fields', 'Save')
    %(isempty(sav_node_con.node_location.lati)&&(strcmp('Specify Co-ordinates',sav_node_con.node_location.placement_type)))
    
elseif  isnan(sav_node_con.node_location.lati)||isnan(sav_node_con.node_location.longi)||isnan(sav_node_con.equipment_params.noise_fig)||isnan(sav_node_con.equipment_params.tx_pwr)||isnan(sav_node_con.equipment_params.rx_pwr)||isnan(sav_node_con.equipment_params.tx_ant_gain)||isnan(sav_node_con.equipment_params.rx_ant_gain)||isnan(sav_node_con.equipment_params.tx_cable_loss)||isnan(sav_node_con.equipment_params.rx_cable_loss)
        
    errordlg('Please fill all fields with valid content', 'Save')
else
    
    savenode(sav_node_con)
    close(node_config)
    
%     if exist('nodesave.mat')
%         load('nodesave.mat')
%         node_choices= {node_con.node_name}   ;   
% 
%         setappdata(0, 'nodepop_String', node_choices);
% 
%         setappdata(0, 'nodepop_Value', 1);
%     end
    
%     if exist('nodesave.mat')
%         load('nodesave.mat')
%          node_choices= {node_con.node_name};   
%     set(handles.node_popupmenu, 'String', node_choices);
%     set(handles.node_popupmenu, 'Value', 1);
%     end


end



% function savetest(num)
% savar.test = num
% save('testsave.mat','savar')

function savenode(sav_node_con)


save_counter = getappdata(0, 'savecounter');

if exist('nodesave.mat')
    load('nodesave.mat')
    if exist('save_ind')
        save_counter = save_ind;
    end
end
save_counter = save_counter + 1;

%Saving Index
save_ind = save_counter;

%Node Name
node_con(save_counter).node_name = sav_node_con.node_name ;

%Node Type
node_con(save_counter).node_type = sav_node_con.node_type;

%Node Location 

node_con(save_counter).node_location.placement_type = sav_node_con.node_location.placement_type;

node_con(save_counter).node_location.lati = sav_node_con.node_location.lati;

node_con(save_counter).node_location.longi = sav_node_con.node_location.longi;

%Equipment Paramters
node_con(save_counter).equipment_params.technology = sav_node_con.equipment_params.technology;

node_con(save_counter).equipment_params.noise_fig = sav_node_con.equipment_params.noise_fig;

node_con(save_counter).equipment_params.tx_pwr = sav_node_con.equipment_params.tx_pwr;

node_con(save_counter).equipment_params.rx_pwr = sav_node_con.equipment_params.rx_pwr;

node_con(save_counter).equipment_params.tx_ant_gain = sav_node_con.equipment_params.tx_ant_gain;

node_con(save_counter).equipment_params.rx_ant_gain = sav_node_con.equipment_params.rx_ant_gain;

node_con(save_counter).equipment_params.tx_cable_loss = sav_node_con.equipment_params.tx_cable_loss;

node_con(save_counter).equipment_params.rx_cable_loss = sav_node_con.equipment_params.rx_cable_loss;


save('nodesave.mat','node_con','save_ind')



function node_name_edit_Callback(hObject, eventdata, handles)
% hObject    handle to node_name_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of node_name_edit as text
%        str2double(get(hObject,'String')) returns contents of node_name_edit as a double
nodename = get(handles.node_name_edit, 'String');
setappdata(0, 'node_name', nodename);

% --- Executes during object creation, after setting all properties.
function node_name_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to node_name_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in node_tech_popupmenu.
function node_tech_popupmenu_Callback(hObject, eventdata, handles)
% hObject    handle to node_tech_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns node_tech_popupmenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from node_tech_popupmenu
contents = cellstr(get(hObject,'String'));


% nodetech = str2double(get(handles.node_tech_popupmenu, 'String'));
nodetech = contents{get(hObject,'Value')};
setappdata(0, 'node_tech', nodetech);


% --- Executes during object creation, after setting all properties.
function node_tech_popupmenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to node_tech_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes when selected object is changed in node_location_selection.
function node_location_selection_SelectionChangedFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in node_location_selection 
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.node_location_selection, 'UserData', 1);
        
switch eventdata.Source.SelectedObject.Tag
    
    case 'coordinates_radiobutton'
        set(handles.longitude_edit,'Enable','on')
        set(handles.latitude_edit,'Enable','on') 
        set(handles.longitude_text,'Enable','on')
        set(handles.latitude_text,'Enable','on') 
        
        nodeplacetyp = 'Specify Co-ordinates';
        setappdata(0, 'nodeplace_typ', nodeplacetyp);
        
    case 'mouse_radiobutton'
        set(handles.longitude_edit,'Enable','off')
        set(handles.latitude_edit,'Enable','off')
        set(handles.longitude_text,'Enable','off')
        set(handles.latitude_text,'Enable','off') 
        
        nodeplacetyp = 'Mouse Placement';
        setappdata(0, 'nodeplace_typ', nodeplacetyp);
        
        datacursormode(figure_1)
        
    otherwise
        errordlg('Error Selecting Location Source', 'Location Selection')
    return;
end
        


guidata(handles.figure_node, handles);


% --- Executes when selected object is changed in node_type_selection.
function node_type_selection_SelectionChangedFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in node_type_selection 
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.node_type_selection, 'UserData', 1);

switch eventdata.Source.SelectedObject.Tag
    
    case 'tower_radiobutton'
        
        nodetyp = 'Tower Mounted';
        setappdata(0, 'node_typ', nodetyp);
        
    case 'mobile_radiobutton'
        
        nodetyp = 'Mobile at Sea';
        setappdata(0, 'node_typ', nodetyp);
        
    otherwise
        errordlg('Error Selecting Node Type', 'Node Type Selection')
    return;
end
        
