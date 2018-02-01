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

% Last Modified by GUIDE v2.5 30-Jan-2018 16:29:37

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

set(handles.up_freq_edit,'Enable','off') 
set(handles.uplink_text,'Enable','off')
set(handles.down_freq_edit,'Enable','on')
set(handles.downlink_text,'Enable','on') 

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes link_config wait for user response (see UIRESUME)
% uiwait(handles.figure1);


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


% --- Executes on selection change in popupmenu9.
function popupmenu9_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu9 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu9


% --- Executes during object creation, after setting all properties.
function popupmenu9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu8.
function popupmenu8_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu8 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu8


% --- Executes during object creation, after setting all properties.
function popupmenu8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit14_Callback(hObject, eventdata, handles)
% hObject    handle to edit14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit14 as text
%        str2double(get(hObject,'String')) returns contents of edit14 as a double


% --- Executes during object creation, after setting all properties.
function edit14_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit14 (see GCBO)
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
        set(handles.up_freq_edit,'Enable','off') 
        set(handles.uplink_text,'Enable','off')
        set(handles.down_freq_edit,'Enable','on')
        set(handles.downlink_text,'Enable','on') 
    case 'uplink_radiobutton'
        set(handles.up_freq_edit,'Enable','on') 
        set(handles.uplink_text,'Enable','on')
        set(handles.down_freq_edit,'Enable','off')
        set(handles.downlink_text,'Enable','off') 
    otherwise
        errordlg('Error Selecting Link Direction', 'Direction Selection')
    return;
end
        

guidata(handles.figure1, handles);
