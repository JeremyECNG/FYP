function varargout = node_select(varargin)
% NODE_SELECT MATLAB code for node_select.fig
%      NODE_SELECT, by itself, creates a new NODE_SELECT or raises the existing
%      singleton*.
%
%      H = NODE_SELECT returns the handle to a new NODE_SELECT or the handle to
%      the existing singleton*.
%
%      NODE_SELECT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in NODE_SELECT.M with the given input arguments.
%
%      NODE_SELECT('Property','Value',...) creates a new NODE_SELECT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before node_select_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to node_select_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help node_select

% Last Modified by GUIDE v2.5 09-Feb-2018 12:16:03

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @node_select_OpeningFcn, ...
                   'gui_OutputFcn',  @node_select_OutputFcn, ...
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


% --- Executes just before node_select is made visible.
function node_select_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to node_select (see VARARGIN)

% Choose default command line output for node_select
handles.output = hObject;


if exist('nodesave.mat')
    load('nodesave.mat')
      node_choices= {node_con.node_name}; 


set(handles.node_selec_popupmenu, 'String', node_choices);
set(handles.node_selec_popupmenu, 'Value', 1);
end

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes node_select wait for user response (see UIRESUME)
% uiwait(handles.figure_node_sel);


% --- Outputs from this function are returned to the command line.
function varargout = node_select_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in ok_nodesel_pushbutton.
function ok_nodesel_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to ok_nodesel_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close(node_select)

% --- Executes on selection change in node_selec_popupmenu.
function node_selec_popupmenu_Callback(hObject, eventdata, handles)
% hObject    handle to node_selec_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns node_selec_popupmenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from node_selec_popupmenu
contents = cellstr(get(hObject,'String'));
node_selection = contents{get(hObject,'Value')};
setappdata(0, 'user_node_selection', node_selection);

% --- Executes during object creation, after setting all properties.
function node_selec_popupmenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to node_selec_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
