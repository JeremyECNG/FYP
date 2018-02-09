function varargout = link_select(varargin)
% LINK_SELECT MATLAB code for link_select.fig
%      LINK_SELECT, by itself, creates a new LINK_SELECT or raises the existing
%      singleton*.
%
%      H = LINK_SELECT returns the handle to a new LINK_SELECT or the handle to
%      the existing singleton*.
%
%      LINK_SELECT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in LINK_SELECT.M with the given input arguments.
%
%      LINK_SELECT('Property','Value',...) creates a new LINK_SELECT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before link_select_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to link_select_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help link_select

% Last Modified by GUIDE v2.5 09-Feb-2018 12:45:48

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @link_select_OpeningFcn, ...
                   'gui_OutputFcn',  @link_select_OutputFcn, ...
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


% --- Executes just before link_select is made visible.
function link_select_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to link_select (see VARARGIN)

% Choose default command line output for link_select
handles.output = hObject;


if exist('linksave.mat')
    load('linksave.mat')
      link_choices= {link_con.link_name}; 


set(handles.link_selec_popupmenu, 'String', link_choices);
set(handles.link_selec_popupmenu, 'Value', 1);
end

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes link_select wait for user response (see UIRESUME)
% uiwait(handles.figure_link_sel);


% --- Outputs from this function are returned to the command line.
function varargout = link_select_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in ok_linksel_pushbutton.
function ok_linksel_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to ok_linksel_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close(link_select)

% --- Executes on selection change in link_selec_popupmenu.
function link_selec_popupmenu_Callback(hObject, eventdata, handles)
% hObject    handle to link_selec_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns link_selec_popupmenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from link_selec_popupmenu
contents = cellstr(get(hObject,'String'));
link_selection = contents{get(hObject,'Value')};
setappdata(0, 'user_link_selection', link_selection);

% --- Executes during object creation, after setting all properties.
function link_selec_popupmenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to link_selec_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
