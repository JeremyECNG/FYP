function varargout = link_analysis(varargin)
% LINK_ANALYSIS MATLAB code for link_analysis.fig
%      LINK_ANALYSIS, by itself, creates a new LINK_ANALYSIS or raises the existing
%      singleton*.
%
%      H = LINK_ANALYSIS returns the handle to a new LINK_ANALYSIS or the handle to
%      the existing singleton*.
%
%      LINK_ANALYSIS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in LINK_ANALYSIS.M with the given input arguments.
%
%      LINK_ANALYSIS('Property','Value',...) creates a new LINK_ANALYSIS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before link_analysis_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to link_analysis_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help link_analysis

% Last Modified by GUIDE v2.5 19-Jan-2018 14:57:40

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @link_analysis_OpeningFcn, ...
                   'gui_OutputFcn',  @link_analysis_OutputFcn, ...
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


% --- Executes just before link_analysis is made visible.
function link_analysis_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to link_analysis (see VARARGIN)

% Choose default command line output for link_analysis
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes link_analysis wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = link_analysis_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in ok_linkan_pushbutton.
function ok_linkan_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to ok_linkan_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close(link_analysis)

% --- Executes on button press in cancel_linkan_pushbutton.
function cancel_linkan_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to cancel_linkan_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close(link_analysis)


function los_edit_Callback(hObject, eventdata, handles)
% hObject    handle to los_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of los_edit as text
%        str2double(get(hObject,'String')) returns contents of los_edit as a double


% --- Executes during object creation, after setting all properties.
function los_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to los_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
