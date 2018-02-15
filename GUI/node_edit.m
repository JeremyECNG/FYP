function varargout = node_edit(varargin)
% NODE_EDIT MATLAB code for node_edit.fig
%      NODE_EDIT, by itself, creates a new NODE_EDIT or raises the existing
%      singleton*.
%
%      H = NODE_EDIT returns the handle to a new NODE_EDIT or the handle to
%      the existing singleton*.
%
%      NODE_EDIT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in NODE_EDIT.M with the given input arguments.
%
%      NODE_EDIT('Property','Value',...) creates a new NODE_EDIT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before node_edit_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to node_edit_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help node_edit

% Last Modified by GUIDE v2.5 13-Feb-2018 21:10:55

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @node_edit_OpeningFcn, ...
                   'gui_OutputFcn',  @node_edit_OutputFcn, ...
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


% --- Executes just before node_edit is made visible.
function node_edit_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to node_edit (see VARARGIN)

% Choose default command line output for node_edit
handles.output = hObject;


if exist('nodesave.mat')
    load('nodesave.mat')
      node_choices= {node_con.node_name}; 


set(handles.node_editsel_popupmenu, 'String', node_choices);
set(handles.node_editsel_popupmenu, 'Value', 1);
end


% Update handles structure
guidata(hObject, handles);

% UIWAIT makes node_edit wait for user response (see UIRESUME)
% uiwait(handles.figure_node_edit);


% --- Outputs from this function are returned to the command line.
function varargout = node_edit_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in cancel_nodeedit_pushbutton.
function cancel_nodeedit_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to cancel_nodeedit_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close(node_edit)

% --- Executes on button press in save_nodeedit_pushbutton.
function save_nodeedit_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to save_nodeedit_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% type_flag = get(handles.node_type_selection, 'UserData');
% location_flag = get(handles.node_location_selection, 'UserData');



if exist('nodesave.mat')
    load('nodesave.mat')
end




%Node Name
sav_node_con.node_name = getappdata(0,'node_name');

%Node Type
% if 1 == type_flag
    sav_node_con.node_type = getappdata(0,'node_typ');
% else
%     sav_node_con.node_type = 'Tower Mounted';
% end

%Node Location 
% if 1 == location_flag
    sav_node_con.node_location.placement_type = getappdata(0,'nodeplace_typ');
    
%     if strcmp(sav_node_con.node_location.placement_type,'Mouse Placement')
%     sav_node_con.node_location.lati = 0;
% 
%     sav_node_con.node_location.longi = 0;
%     
%     else
        
%     sav_node_con.node_location.lati = getappdata(0,'lat_itude');
% 
%     sav_node_con.node_location.longi = getappdata(0,'long_itude');
%     end
% else
%     sav_node_con.node_location.placement_type = 'Specify Co-ordinates';
    
    sav_node_con.node_location.lati = getappdata(0,'lat_itude');

    sav_node_con.node_location.longi = getappdata(0,'long_itude');
% end



%Equipment Paramters
sav_node_con.equipment_params.technology = getappdata(0,'node_tech');

sav_node_con.equipment_params.noise_fig = getappdata(0,'noise_fig');

sav_node_con.equipment_params.tx_pwr = getappdata(0,'tx_power');

sav_node_con.equipment_params.rx_pwr = getappdata(0,'rx_power');

sav_node_con.equipment_params.tx_ant_gain = getappdata(0,'txant_gain');

sav_node_con.equipment_params.rx_ant_gain = getappdata(0,'rxant_gain');

sav_node_con.equipment_params.tx_cable_loss = getappdata(0,'txcab_loss');

sav_node_con.equipment_params.rx_cable_loss = getappdata(0,'rxcab_loss');



% set(handles.node_type_selection, 'UserData', 0);
% set(handles.node_location_selection, 'UserData', 0);

edited_node = getappdata(0, 'node_edited');

save_slots_used = numel(node_con);
    
for name_ind = 1:save_slots_used
    if strcmp(getappdata(0,'node_name'), node_con(name_ind).node_name)
        name_conflict_flag = 1;
        setappdata(0,'nameflag',name_conflict_flag)
    end   
    
    if edited_node == name_ind
        name_conflict_flag = 0;
        setappdata(0,'nameflag',name_conflict_flag)
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
    
    savenodeedit(sav_node_con)
    close(node_edit)



end

%%%%
function savenodeedit(sav_node_con)




if exist('nodesave.mat')
    load('nodesave.mat')

end


%editing  Index
edit_ind = getappdata(0, 'node_edited');

%Node Name
node_con(edit_ind).node_name = sav_node_con.node_name ;

%Node Type
node_con(edit_ind).node_type = sav_node_con.node_type;

%Node Location 

node_con(edit_ind).node_location.placement_type = sav_node_con.node_location.placement_type;

node_con(edit_ind).node_location.lati = sav_node_con.node_location.lati;

node_con(edit_ind).node_location.longi = sav_node_con.node_location.longi;

%Equipment Paramters
node_con(edit_ind).equipment_params.technology = sav_node_con.equipment_params.technology;

node_con(edit_ind).equipment_params.noise_fig = sav_node_con.equipment_params.noise_fig;

node_con(edit_ind).equipment_params.tx_pwr = sav_node_con.equipment_params.tx_pwr;

node_con(edit_ind).equipment_params.rx_pwr = sav_node_con.equipment_params.rx_pwr;

node_con(edit_ind).equipment_params.tx_ant_gain = sav_node_con.equipment_params.tx_ant_gain;

node_con(edit_ind).equipment_params.rx_ant_gain = sav_node_con.equipment_params.rx_ant_gain;

node_con(edit_ind).equipment_params.tx_cable_loss = sav_node_con.equipment_params.tx_cable_loss;

node_con(edit_ind).equipment_params.rx_cable_loss = sav_node_con.equipment_params.rx_cable_loss;


save('nodesave.mat','node_con','save_ind')


function node_name_editing_Callback(hObject, eventdata, handles)
% hObject    handle to node_name_editing (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of node_name_editing as text
%        str2double(get(hObject,'String')) returns contents of node_name_editing as a double
nodename = get(handles.node_name_editing, 'String');
setappdata(0, 'node_name', nodename);

% --- Executes during object creation, after setting all properties.
function node_name_editing_CreateFcn(hObject, eventdata, handles)
% hObject    handle to node_name_editing (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function noise_fig_editing_Callback(hObject, eventdata, handles)
% hObject    handle to noise_fig_editing (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of noise_fig_editing as text
%        str2double(get(hObject,'String')) returns contents of noise_fig_editing as a double
noisefig = str2double(get(handles.noise_fig_editing, 'String'));
setappdata(0, 'noise_fig', noisefig);

% --- Executes during object creation, after setting all properties.
function noise_fig_editing_CreateFcn(hObject, eventdata, handles)
% hObject    handle to noise_fig_editing (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function rx_power_editing_Callback(hObject, eventdata, handles)
% hObject    handle to rx_power_editing (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of rx_power_editing as text
%        str2double(get(hObject,'String')) returns contents of rx_power_editing as a double
rxpower = str2double(get(handles.rx_power_editing, 'String'));
setappdata(0, 'rx_power', rxpower);

% --- Executes during object creation, after setting all properties.
function rx_power_editing_CreateFcn(hObject, eventdata, handles)
% hObject    handle to rx_power_editing (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function rx_ant_gain_editing_Callback(hObject, eventdata, handles)
% hObject    handle to rx_ant_gain_editing (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of rx_ant_gain_editing as text
%        str2double(get(hObject,'String')) returns contents of rx_ant_gain_editing as a double
rxantgain = str2double(get(handles.rx_ant_gain_editing, 'String'));
setappdata(0, 'rxant_gain', rxantgain);

% --- Executes during object creation, after setting all properties.
function rx_ant_gain_editing_CreateFcn(hObject, eventdata, handles)
% hObject    handle to rx_ant_gain_editing (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function rx_cable_loss_editing_Callback(hObject, eventdata, handles)
% hObject    handle to rx_cable_loss_editing (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of rx_cable_loss_editing as text
%        str2double(get(hObject,'String')) returns contents of rx_cable_loss_editing as a double
rxcabloss = str2double(get(handles.rx_cable_loss_editing, 'String'));
setappdata(0, 'rxcab_loss', rxcabloss);

% --- Executes during object creation, after setting all properties.
function rx_cable_loss_editing_CreateFcn(hObject, eventdata, handles)
% hObject    handle to rx_cable_loss_editing (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function tx_power_editing_Callback(hObject, eventdata, handles)
% hObject    handle to tx_power_editing (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of tx_power_editing as text
%        str2double(get(hObject,'String')) returns contents of tx_power_editing as a double
txpower = str2double(get(handles.tx_power_editing, 'String'));
setappdata(0, 'tx_power', txpower);


% --- Executes during object creation, after setting all properties.
function tx_power_editing_CreateFcn(hObject, eventdata, handles)
% hObject    handle to tx_power_editing (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function tx_ant_gain_editing_Callback(hObject, eventdata, handles)
% hObject    handle to tx_ant_gain_editing (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of tx_ant_gain_editing as text
%        str2double(get(hObject,'String')) returns contents of tx_ant_gain_editing as a double
txantgain = str2double(get(handles.tx_ant_gain_editing, 'String'));
setappdata(0, 'txant_gain', txantgain);

% --- Executes during object creation, after setting all properties.
function tx_ant_gain_editing_CreateFcn(hObject, eventdata, handles)
% hObject    handle to tx_ant_gain_editing (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function tx_cable_loss_editing_Callback(hObject, eventdata, handles)
% hObject    handle to tx_cable_loss_editing (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of tx_cable_loss_editing as text
%        str2double(get(hObject,'String')) returns contents of tx_cable_loss_editing as a double
txcabloss = str2double(get(handles.tx_cable_loss_editing, 'String'));
setappdata(0, 'txcab_loss', txcabloss);

% --- Executes during object creation, after setting all properties.
function tx_cable_loss_editing_CreateFcn(hObject, eventdata, handles)
% hObject    handle to tx_cable_loss_editing (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in node_tech_edit_popupmenu.
function node_tech_edit_popupmenu_Callback(hObject, eventdata, handles)
% hObject    handle to node_tech_edit_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns node_tech_edit_popupmenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from node_tech_edit_popupmenu
contents = cellstr(get(hObject,'String'));
nodetech = contents{get(hObject,'Value')};
setappdata(0, 'node_tech', nodetech);

% --- Executes during object creation, after setting all properties.
function node_tech_edit_popupmenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to node_tech_edit_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function longitude_editing_Callback(hObject, eventdata, handles)
% hObject    handle to longitude_editing (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of longitude_editing as text
%        str2double(get(hObject,'String')) returns contents of longitude_editing as a double
longit = str2double(get(handles.longitude_editing, 'String'));
setappdata(0, 'long_itude', longit);

% --- Executes during object creation, after setting all properties.
function longitude_editing_CreateFcn(hObject, eventdata, handles)
% hObject    handle to longitude_editing (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function latitude_editing_Callback(hObject, eventdata, handles)
% hObject    handle to latitude_editing (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of latitude_editing as text
%        str2double(get(hObject,'String')) returns contents of latitude_editing as a double
latit = str2double(get(handles.latitude_editing, 'String'));
setappdata(0, 'lat_itude', latit);

% --- Executes during object creation, after setting all properties.
function latitude_editing_CreateFcn(hObject, eventdata, handles)
% hObject    handle to latitude_editing (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in node_editsel_popupmenu.
function node_editsel_popupmenu_Callback(hObject, eventdata, handles)
% hObject    handle to node_editsel_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns node_editsel_popupmenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from node_editsel_popupmenu
contents = cellstr(get(hObject,'String'));
node_selection = contents{get(hObject,'Value')};
setappdata(0, 'node_selec', node_selection);

if exist('nodesave.mat')
    load('nodesave.mat')
            
    for nodein = 1:save_ind
        if strcmp(node_selection,node_con(nodein).node_name)
            
            item_num = nodein;
    
        end
    
    end
end

setappdata(0, 'node_edited', item_num)

set(handles.node_name_editing, 'String',node_con(item_num).node_name );
setappdata(0, 'node_name', node_con(item_num).node_name);

%
node_type_setting = node_con(item_num).node_type;

switch node_type_setting
    
    case 'Tower Mounted'
        
        set (handles.tower_edit_radiobutton, 'Value', 1)
        setappdata(0, 'node_typ', 'Tower Mounted');
        
    case 'Mobile at Sea'
        
        set (handles.mobile_edit_radiobutton, 'Value', 1)
        setappdata(0, 'node_typ', 'Mobile at Sea');
        
    otherwise
        errordlg('Error Loading Node Type', 'Node Type Selection Loading')
    return;
end



%
node_loca_setting = node_con(item_num).node_location.placement_type;

switch node_loca_setting
    
    case 'Specify Co-ordinates'
        
        set (handles.coordinates_edit_radiobutton, 'Value', 1)
        setappdata(0, 'nodeplace_typ', 'Specify Co-ordinates');
        
    case 'Mouse Placement'
        
        set (handles.mouse_edit_radiobutton, 'Value', 1)
        setappdata(0, 'nodeplace_typ', 'Mouse Placement');
        
    otherwise
        errordlg('Error Loading Node Location Type', 'Node Location Type Selection Loading')
    return;
end


set(handles.longitude_editing, 'String', node_con(item_num).node_location.lati);
setappdata(0, 'lat_itude', node_con(item_num).node_location.lati);

set(handles.latitude_editing, 'String', node_con(item_num).node_location.longi);
setappdata(0, 'long_itude', node_con(item_num).node_location.longi);

%
node_tech_setting = node_con(item_num).equipment_params.technology;
setappdata(0, 'node_tech', node_con(item_num).equipment_params.technology);

switch node_tech_setting
    
    case 'DSC'
        
        set (handles.node_tech_edit_popupmenu, 'Value', 2)
        
    case 'LTE-A'
        
        set (handles.node_tech_edit_popupmenu, 'Value', 3)
        
    case 'NWR'
        
        set (handles.node_tech_edit_popupmenu, 'Value', 4)
        
    otherwise
        errordlg('Error Loading Node Technology', 'Node Technology Selection Loading')
    return;
end

set(handles.noise_fig_editing, 'String', node_con(item_num).equipment_params.noise_fig);
setappdata(0, 'noise_fig', node_con(item_num).equipment_params.noise_fig);

set(handles.tx_power_editing, 'String', node_con(item_num).equipment_params.tx_pwr);
setappdata(0, 'tx_power', node_con(item_num).equipment_params.tx_pwr);

set(handles.rx_power_editing, 'String', node_con(item_num).equipment_params.rx_pwr);
setappdata(0, 'rx_power', node_con(item_num).equipment_params.rx_pwr);

set(handles.tx_ant_gain_editing, 'String', node_con(item_num).equipment_params.tx_ant_gain);
setappdata(0, 'txant_gain', node_con(item_num).equipment_params.tx_ant_gain);

set(handles.rx_ant_gain_editing, 'String', node_con(item_num).equipment_params.rx_ant_gain);
setappdata(0, 'rxant_gain', node_con(item_num).equipment_params.rx_ant_gain);

set(handles.tx_cable_loss_editing, 'String', node_con(item_num).equipment_params.tx_cable_loss);
setappdata(0, 'txcab_loss', node_con(item_num).equipment_params.tx_cable_loss);

set(handles.rx_cable_loss_editing, 'String', node_con(item_num).equipment_params.rx_cable_loss);
setappdata(0, 'rxcab_loss', node_con(item_num).equipment_params.rx_cable_loss);


% --- Executes during object creation, after setting all properties.
function node_editsel_popupmenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to node_editsel_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes when selected object is changed in node_type_edit.
function node_type_edit_SelectionChangedFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in node_type_edit 
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% set(handles.node_type_edit, 'UserData', 1);

switch eventdata.Source.SelectedObject.Tag
    
    case 'tower_edit_radiobutton'
            
        
        nodetyp = 'Tower Mounted';
        setappdata(0, 'node_typ', nodetyp);
        
    case 'mobile_edit_radiobutton'
        
        nodetyp = 'Mobile at Sea';
        setappdata(0, 'node_typ', nodetyp);
        
    otherwise
        errordlg('Error Selecting Node Type', 'Node Type Selection')
    return;
end
        




% --- Executes when selected object is changed in node_location_edit.
function node_location_edit_SelectionChangedFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in node_location_edit 
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% set(handles.node_location_edit, 'UserData', 1);
        
switch eventdata.Source.SelectedObject.Tag
    
    case 'coordinates_edit_radiobutton'
        set(handles.longitude_editing,'Enable','on')
        set(handles.latitude_editing,'Enable','on') 
%         set(handles.longitude_text,'Enable','on')
%         set(handles.latitude_text,'Enable','on') 
        
        nodeplacetyp = 'Specify Co-ordinates';
        setappdata(0, 'nodeplace_typ', nodeplacetyp);
        
    case 'mouse_edit_radiobutton'
        set(handles.longitude_editing,'Enable','off')
        set(handles.latitude_editing,'Enable','off')
%         set(handles.longitude_text,'Enable','off')
%         set(handles.latitude_text,'Enable','off') 
        
        nodeplacetyp = 'Mouse Placement';
        setappdata(0, 'nodeplace_typ', nodeplacetyp);
        

        
    otherwise
        errordlg('Error Selecting Location Source', 'Location Selection')
    return;
end
        


guidata(handles.figure_node_edit, handles);


% --- Executes on button press in tower_edit_radiobutton.
function tower_edit_radiobutton_Callback(hObject, eventdata, handles)
% hObject    handle to tower_edit_radiobutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of tower_edit_radiobutton


% --- Executes on button press in mobile_edit_radiobutton.
function mobile_edit_radiobutton_Callback(hObject, eventdata, handles)
% hObject    handle to mobile_edit_radiobutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of mobile_edit_radiobutton


% --- Executes on button press in coordinates_edit_radiobutton.
function coordinates_edit_radiobutton_Callback(hObject, eventdata, handles)
% hObject    handle to coordinates_edit_radiobutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of coordinates_edit_radiobutton


% --- Executes on button press in mouse_edit_radiobutton.
function mouse_edit_radiobutton_Callback(hObject, eventdata, handles)
% hObject    handle to mouse_edit_radiobutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of mouse_edit_radiobutton
