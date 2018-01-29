function varargout = main_screen_v3(varargin)
% MAIN_SCREEN_V3 MATLAB code for main_screen_v3.fig
%      MAIN_SCREEN_V3, by itself, creates a new MAIN_SCREEN_V3 or raises the existing
%      singleton*.
%
%      H = MAIN_SCREEN_V3 returns the handle to a new MAIN_SCREEN_V3 or the handle to
%      the existing singleton*.
%
%      MAIN_SCREEN_V3('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MAIN_SCREEN_V3.M with the given input arguments.
%
%      MAIN_SCREEN_V3('Property','Value',...) creates a new MAIN_SCREEN_V3 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before main_screen_v3_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to main_screen_v3_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help main_screen_v3

% Last Modified by GUIDE v2.5 29-Jan-2018 04:10:01

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @main_screen_v3_OpeningFcn, ...
                   'gui_OutputFcn',  @main_screen_v3_OutputFcn, ...
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


% --- Executes just before main_screen_v3 is made visible.
function main_screen_v3_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to main_screen_v3 (see VARARGIN)

% Choose default command line output for main_screen_v3
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes main_screen_v3 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = main_screen_v3_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in terr_waters_checkbox.
function terr_waters_checkbox_Callback(hObject, eventdata, handles)
% hObject    handle to terr_waters_checkbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of terr_waters_checkbox


% --- Executes on button press in cont_zones_checkbox.
function cont_zones_checkbox_Callback(hObject, eventdata, handles)
% hObject    handle to cont_zones_checkbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cont_zones_checkbox


% --- Executes on button press in econ_zones_checkbox.
function econ_zones_checkbox_Callback(hObject, eventdata, handles)
% hObject    handle to econ_zones_checkbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of econ_zones_checkbox


% --- Executes on button press in fish_zones_checkbox.
function fish_zones_checkbox_Callback(hObject, eventdata, handles)
% hObject    handle to fish_zones_checkbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of fish_zones_checkbox


% --- Executes on button press in gmdss_checkbox.
function gmdss_checkbox_Callback(hObject, eventdata, handles)
% hObject    handle to gmdss_checkbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of gmdss_checkbox


% --- Executes on button press in towers_checkbox.
function towers_checkbox_Callback(hObject, eventdata, handles)
% hObject    handle to towers_checkbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of towers_checkbox


% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


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
% if ('Grenada' == country)
%     sel = 1;
% if (grenada == country)
%     sel = 1;
% elseif (dominica == country)
%     sel = 2;
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

% cla(handles.map,'reset');
switch sel
    case 1 
%         plot(handles.map, -61.679071,12.116586,'Marker','s','MarkerSize',10)
        set(handles.map, 'XLim', [-62.2,-61.2]);
        set(handles.map, 'YLim', [11.7,12.5]);
    case 2
%         plot(handles.map, -61.371071,15.415086,'Marker','s','MarkerSize',10)
        set(handles.map, 'XLim', [-62,-60.8]);
        set(handles.map, 'YLim', [14.9,15.8]);
    case 3
%         plot(handles.map, -60.978971,13.909486,'Marker','s','MarkerSize',10)
        set(handles.map, 'XLim', [-61.6,-60.3]);
        set(handles.map, 'YLim', [13.4,14.4]);
    case 4
%         plot(handles.map, -61.287271,12.984386,'Marker','s','MarkerSize',10)
        set(handles.map, 'XLim', [-61.8,-60.6]);
        set(handles.map, 'YLim', [12.8,13.7]);
    case 5
%         plot(handles.map, -62.783071,17.357886,'Marker','s','MarkerSize',10)
        set(handles.map, 'XLim', [-63.2,-62.3]);
        set(handles.map, 'YLim', [17,17.8]);
    case 6
%         plot(handles.map, -61.399471,10.641586,'Marker','s','MarkerSize',10)
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
guidata(handles.output, handles);

% --- Executes on button press in tower_filter_pushbutton.
function tower_filter_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to tower_filter_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
data_filter

% --- Executes on button press in config_pushbutton.
function config_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to config_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in link_load_popupmenu.
function link_load_popupmenu_Callback(hObject, eventdata, handles)
% hObject    handle to link_load_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns link_load_popupmenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from link_load_popupmenu


% --- Executes during object creation, after setting all properties.
function link_load_popupmenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to link_load_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in node_load_popupmenu.
function node_load_popupmenu_Callback(hObject, eventdata, handles)
% hObject    handle to node_load_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns node_load_popupmenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from node_load_popupmenu


% --- Executes during object creation, after setting all properties.
function node_load_popupmenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to node_load_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in run_pushbutton.
function run_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to run_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in range_checkbox.
function range_checkbox_Callback(hObject, eventdata, handles)
% hObject    handle to range_checkbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of range_checkbox


% --- Executes on button press in throughput_checkbox.
function throughput_checkbox_Callback(hObject, eventdata, handles)
% hObject    handle to throughput_checkbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of throughput_checkbox


% --- Executes on button press in ber_analys_checkbox.
function ber_analys_checkbox_Callback(hObject, eventdata, handles)
% hObject    handle to ber_analys_checkbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of ber_analys_checkbox


% --- Executes on button press in full_range_radiobutton.
function full_range_radiobutton_Callback(hObject, eventdata, handles)
% hObject    handle to full_range_radiobutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of full_range_radiobutton


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


% --- Executes on selection change in power_lim_popupmenu.
function power_lim_popupmenu_Callback(hObject, eventdata, handles)
% hObject    handle to power_lim_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns power_lim_popupmenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from power_lim_popupmenu


% --- Executes during object creation, after setting all properties.
function power_lim_popupmenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to power_lim_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
