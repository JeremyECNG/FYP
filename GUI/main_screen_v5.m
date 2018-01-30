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

% Last Modified by GUIDE v2.5 29-Jan-2018 12:32:57

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


% --- Executes on button press in configure_pushbutton.
function configure_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to configure_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% if 
%     
%     link_config
%     
% elseif
%     
%     node_config

% --- Executes on button press in new_node_radiobutton.
function new_node_radiobutton_Callback(hObject, eventdata, handles)
% hObject    handle to new_node_radiobutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of new_node_radiobutton


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
guidata(handles.output, handles);

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
data_filter

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
