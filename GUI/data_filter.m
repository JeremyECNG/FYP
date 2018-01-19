function varargout = data_filter(varargin)
% DATA_FILTER MATLAB code for data_filter.fig
%      DATA_FILTER, by itself, creates a new DATA_FILTER or raises the existing
%      singleton*.
%
%      H = DATA_FILTER returns the handle to a new DATA_FILTER or the handle to
%      the existing singleton*.
%
%      DATA_FILTER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DATA_FILTER.M with the given input arguments.
%
%      DATA_FILTER('Property','Value',...) creates a new DATA_FILTER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before data_filter_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to data_filter_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help data_filter

% Last Modified by GUIDE v2.5 19-Jan-2018 15:17:06

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @data_filter_OpeningFcn, ...
                   'gui_OutputFcn',  @data_filter_OutputFcn, ...
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


% --- Executes just before data_filter is made visible.
function data_filter_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to data_filter (see VARARGIN)

% Choose default command line output for data_filter
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes data_filter wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = data_filter_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in tw_popupmenu.
function tw_popupmenu_Callback(hObject, eventdata, handles)
% hObject    handle to tw_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns tw_popupmenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from tw_popupmenu


% --- Executes during object creation, after setting all properties.
function tw_popupmenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to tw_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in filter_tw_radiobutton.
function filter_tw_radiobutton_Callback(hObject, eventdata, handles)
% hObject    handle to filter_tw_radiobutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of filter_tw_radiobutton


% --- Executes on selection change in cz_popupmenu.
function cz_popupmenu_Callback(hObject, eventdata, handles)
% hObject    handle to cz_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns cz_popupmenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from cz_popupmenu


% --- Executes during object creation, after setting all properties.
function cz_popupmenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cz_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in filter_cz_radiobutton.
function filter_cz_radiobutton_Callback(hObject, eventdata, handles)
% hObject    handle to filter_cz_radiobutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of filter_cz_radiobutton


% --- Executes on selection change in ez_popupmenu.
function ez_popupmenu_Callback(hObject, eventdata, handles)
% hObject    handle to ez_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns ez_popupmenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from ez_popupmenu


% --- Executes during object creation, after setting all properties.
function ez_popupmenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ez_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in filter_ez_radiobutton.
function filter_ez_radiobutton_Callback(hObject, eventdata, handles)
% hObject    handle to filter_ez_radiobutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of filter_ez_radiobutton


% --- Executes on selection change in fz_popupmenu.
function fz_popupmenu_Callback(hObject, eventdata, handles)
% hObject    handle to fz_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns fz_popupmenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from fz_popupmenu


% --- Executes during object creation, after setting all properties.
function fz_popupmenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fz_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in filter_fz_radiobutton.
function filter_fz_radiobutton_Callback(hObject, eventdata, handles)
% hObject    handle to filter_fz_radiobutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of filter_fz_radiobutton


% --- Executes on selection change in gmdss_popupmenu.
function gmdss_popupmenu_Callback(hObject, eventdata, handles)
% hObject    handle to gmdss_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns gmdss_popupmenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from gmdss_popupmenu


% --- Executes during object creation, after setting all properties.
function gmdss_popupmenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to gmdss_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in filter_gmdss_radiobutton.
function filter_gmdss_radiobutton_Callback(hObject, eventdata, handles)
% hObject    handle to filter_gmdss_radiobutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of filter_gmdss_radiobutton


% --- Executes on selection change in towers_popupmenu.
function towers_popupmenu_Callback(hObject, eventdata, handles)
% hObject    handle to towers_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns towers_popupmenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from towers_popupmenu


% --- Executes during object creation, after setting all properties.
function towers_popupmenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to towers_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in filter_towers_radiobutton.
function filter_towers_radiobutton_Callback(hObject, eventdata, handles)
% hObject    handle to filter_towers_radiobutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of filter_towers_radiobutton


% --- Executes on button press in ok_filter_pushbutton.
function ok_filter_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to ok_filter_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close(data_filter)

% --- Executes on button press in cancel_filter_pushbutton.
function cancel_filter_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to cancel_filter_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close(data_filter)
