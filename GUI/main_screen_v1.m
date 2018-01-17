function varargout = main_screen_v1(varargin)
% MAIN_SCREEN_V1 MATLAB code for main_screen_v1.fig
%      MAIN_SCREEN_V1, by itself, creates a new MAIN_SCREEN_V1 or raises the existing
%      singleton*.
%
%      H = MAIN_SCREEN_V1 returns the handle to a new MAIN_SCREEN_V1 or the handle to
%      the existing singleton*.
%
%      MAIN_SCREEN_V1('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MAIN_SCREEN_V1.M with the given input arguments.
%
%      MAIN_SCREEN_V1('Property','Value',...) creates a new MAIN_SCREEN_V1 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before main_screen_v1_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to main_screen_v1_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help main_screen_v1

% Last Modified by GUIDE v2.5 16-Jan-2018 15:39:53

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @main_screen_v1_OpeningFcn, ...
                   'gui_OutputFcn',  @main_screen_v1_OutputFcn, ...
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


% --- Executes just before main_screen_v1 is made visible.
function main_screen_v1_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to main_screen_v1 (see VARARGIN)

% Choose default command line output for main_screen_v1
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes main_screen_v1 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = main_screen_v1_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in terr_water_checkbox.
function terr_water_checkbox_Callback(hObject, eventdata, handles)
% hObject    handle to terr_water_checkbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of terr_water_checkbox


% --- Executes on button press in cont_zone_checkbox.
function cont_zone_checkbox_Callback(hObject, eventdata, handles)
% hObject    handle to cont_zone_checkbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of cont_zone_checkbox


% --- Executes on button press in econ_zone_checkbox.
function econ_zone_checkbox_Callback(hObject, eventdata, handles)
% hObject    handle to econ_zone_checkbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of econ_zone_checkbox


% --- Executes on button press in fish_zone_checkbox.
function fish_zone_checkbox_Callback(hObject, eventdata, handles)
% hObject    handle to fish_zone_checkbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of fish_zone_checkbox


% --- Executes on button press in sea_areas_checkbox.
function sea_areas_checkbox_Callback(hObject, eventdata, handles)
% hObject    handle to sea_areas_checkbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of sea_areas_checkbox


% --- Executes on button press in coast_towers_checkbox.
function coast_towers_checkbox_Callback(hObject, eventdata, handles)
% hObject    handle to coast_towers_checkbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of coast_towers_checkbox


% --- Executes on button press in data_filter_pushbutton.
function data_filter_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to data_filter_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in data_plot_pushbutton.
function data_plot_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to data_plot_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in link_analy_pushbutton.
function link_analy_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to link_analy_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in plot_pushbutton.
function plot_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to plot_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in node_pushbutton.
function node_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to node_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in node_place_pushbutton.
function node_place_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to node_place_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in link_pushbutton.
function link_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to link_pushbutton (see GCBO)
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
grenada = 'Grenada';
dominica = 'Dominica';
stlucia = 'St. Lucia';
stvincent = 'St. Vincent';
stkitts = 'St. Kitts';
trinidad = 'Trinidad & Tobago'; 

% if (strcmp('Grenada',country))
%     sel = 1;
% if ('Grenada' == country)
%     sel = 1;
if (grenada == country)
    sel = 1;
elseif (dominica == country)
    sel = 2;
elseif (stlucia == country)
    sel = 3;
elseif (stvincent == country)
    sel = 4;
elseif (stkitts== country)
    sel = 5;
elseif (trinidad == country)
    sel = 6;
else 
    sel = 7;
end

handles.datacursor = datacursormode;
datacursormode off

switch sel
    case 1 
        plot(handles.map, -61.679071,12.116586,'Marker','s','MarkerSize',10)
    case 2
        plot(handles.map, -61.371071,15.415086,'Marker','s','MarkerSize',10)
    case 3
        plot(handles.map, -60.978971,13.909486,'Marker','s','MarkerSize',10)
    case 4
        plot(handles.map, -61.287271,12.984386,'Marker','s','MarkerSize',10)
    case 5
        plot(handles.map, -62.783071,17.357886,'Marker','s','MarkerSize',10)
    case 6
        plot(handles.map, -61.399471,10.641586,'Marker','s','MarkerSize',10)
    otherwise
        errordlg('Country not Found')
        return;
end

xlabel(handles.map,'Longitude')
ylabel(handles.map,'Latitude')
grid(handles.map,'on')
plot_google_map('Axis',handles.map,'maptype','satellite');
guidata(handles.output, handles);
