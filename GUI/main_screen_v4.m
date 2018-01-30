function varargout = main_screen_v4(varargin)
% MAIN_SCREEN_V4 MATLAB code for main_screen_v4.fig
%      MAIN_SCREEN_V4, by itself, creates a new MAIN_SCREEN_V4 or raises the existing
%      singleton*.
%
%      H = MAIN_SCREEN_V4 returns the handle to a new MAIN_SCREEN_V4 or the handle to
%      the existing singleton*.
%
%      MAIN_SCREEN_V4('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MAIN_SCREEN_V4.M with the given input arguments.
%
%      MAIN_SCREEN_V4('Property','Value',...) creates a new MAIN_SCREEN_V4 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before main_screen_v4_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to main_screen_v4_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help main_screen_v4

% Last Modified by GUIDE v2.5 29-Jan-2018 11:25:42

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @main_screen_v4_OpeningFcn, ...
                   'gui_OutputFcn',  @main_screen_v4_OutputFcn, ...
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


% --- Executes just before main_screen_v4 is made visible.
function main_screen_v4_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to main_screen_v4 (see VARARGIN)

% Choose default command line output for main_screen_v4
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes main_screen_v4 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = main_screen_v4_OutputFcn(hObject, eventdata, handles) 
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


% --- Executes on button press in configure_pushbutton.
function configure_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to configure_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in country_popupmenu.
function country_popupmenu_Callback(hObject, eventdata, handles)
% hObject    handle to country_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns country_popupmenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from country_popupmenu


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


% --- Executes on selection change in link_popupmenu.
function link_popupmenu_Callback(hObject, eventdata, handles)
% hObject    handle to link_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns link_popupmenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from link_popupmenu


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


% --- Executes on button press in load_link_radiobutton.
function load_link_radiobutton_Callback(hObject, eventdata, handles)
% hObject    handle to load_link_radiobutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of load_link_radiobutton


% --- Executes on button press in towers_checkbox.
function towers_checkbox_Callback(hObject, eventdata, handles)
% hObject    handle to towers_checkbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of towers_checkbox


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


% --- Executes on button press in power_lim_radiobutton.
function power_lim_radiobutton_Callback(hObject, eventdata, handles)
% hObject    handle to power_lim_radiobutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of power_lim_radiobutton


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
