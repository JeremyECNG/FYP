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

% Last Modified by GUIDE v2.5 19-Jan-2018 14:39:07

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

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes node_config wait for user response (see UIRESUME)
% uiwait(handles.figure1);


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
