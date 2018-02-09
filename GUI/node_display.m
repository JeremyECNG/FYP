function varargout = node_display(varargin)
% NODE_DISPLAY MATLAB code for node_display.fig
%      NODE_DISPLAY, by itself, creates a new NODE_DISPLAY or raises the existing
%      singleton*.
%
%      H = NODE_DISPLAY returns the handle to a new NODE_DISPLAY or the handle to
%      the existing singleton*.
%
%      NODE_DISPLAY('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in NODE_DISPLAY.M with the given input arguments.
%
%      NODE_DISPLAY('Property','Value',...) creates a new NODE_DISPLAY or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before node_display_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to node_display_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help node_display

% Last Modified by GUIDE v2.5 08-Feb-2018 17:58:43

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @node_display_OpeningFcn, ...
                   'gui_OutputFcn',  @node_display_OutputFcn, ...
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


% --- Executes just before node_display is made visible.
function node_display_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to node_display (see VARARGIN)

% Choose default command line output for node_display
handles.output = hObject;


% node_selection = getappdata(0, 'node_selec');
% 
% 
% if exist('nodesave.mat')
%     load('nodesave.mat')
%             
%     for nodein = 1:save_ind
%         if strcmp(node_selection,node_con(nodein).node_name)
%             
%             item_num = nodein;
%     
%         end
%     
%     end
% end
% 
% set(handles.node_name_text, 'String',node_con(item_num).node_name );
% set(handles.node_type_text, 'String',node_con(item_num).node_type );
% set(handles.node_location_sel_text, 'String', node_con(item_num).node_location.placement_type);
% set(handles.longitude_text, 'String', node_con(item_num).node_location.lati);
% set(handles.latitude_text, 'String', node_con(item_num).node_location.longi);
% set(handles.technology_text, 'String', node_con(item_num).equipment_params.technology);
% set(handles.noise_fig_text, 'String', node_con(item_num).equipment_params.noise_fig);
% set(handles.tx_pwr_text, 'String', node_con(item_num).equipment_params.tx_pwr);
% set(handles.rx_pwr_text, 'String', node_con(item_num).equipment_params.rx_pwr);
% set(handles.tx_ant_gain_text, 'String', node_con(item_num).equipment_params.tx_ant_gain);
% set(handles.rx_ant_gain_text, 'String', node_con(item_num).equipment_params.rx_ant_gain);
% set(handles.tx_cable_losses_text, 'String', node_con(item_num).equipment_params.tx_cable_loss);
% set(handles.rx_cable_losses_text, 'String', node_con(item_num).equipment_params.rx_cable_loss);

if exist('nodesave.mat')
    load('nodesave.mat')
      node_choices= {node_con.node_name}; 


set(handles.node_sel_popupmenu, 'String', node_choices);
set(handles.node_sel_popupmenu, 'Value', 1);
end


% Update handles structure
guidata(hObject, handles);

% UIWAIT makes node_display wait for user response (see UIRESUME)
% uiwait(handles.figure_node_edit);


% --- Outputs from this function are returned to the command line.
function varargout = node_display_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in close_nodeedit_pushbutton.
function close_nodeedit_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to close_nodeedit_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close(node_display)

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in node_sel_popupmenu.
function node_sel_popupmenu_Callback(hObject, eventdata, handles)
% hObject    handle to node_sel_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns node_sel_popupmenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from node_sel_popupmenu

contents = cellstr(get(hObject,'String'));
node_selection = contents{get(hObject,'Value')};
setappdata(0, 'node_selec', node_selection);




if exist('nodesave.mat')
    load('nodesave.mat')
            
    for nodein = 1:save_ind
        if strcmp(node_selection,node_con(nodein).node_name)
            
            item_num = nodein;
    
        end
    
    end
end

set(handles.node_name_text, 'String',node_con(item_num).node_name );
set(handles.node_type_text, 'String',node_con(item_num).node_type );
set(handles.node_location_sel_text, 'String', node_con(item_num).node_location.placement_type);
set(handles.longitude_text, 'String', node_con(item_num).node_location.lati);
set(handles.latitude_text, 'String', node_con(item_num).node_location.longi);
set(handles.technology_text, 'String', node_con(item_num).equipment_params.technology);
set(handles.noise_fig_text, 'String', node_con(item_num).equipment_params.noise_fig);
set(handles.tx_pwr_text, 'String', node_con(item_num).equipment_params.tx_pwr);
set(handles.rx_pwr_text, 'String', node_con(item_num).equipment_params.rx_pwr);
set(handles.tx_ant_gain_text, 'String', node_con(item_num).equipment_params.tx_ant_gain);
set(handles.rx_ant_gain_text, 'String', node_con(item_num).equipment_params.rx_ant_gain);
set(handles.tx_cable_losses_text, 'String', node_con(item_num).equipment_params.tx_cable_loss);
set(handles.rx_cable_losses_text, 'String', node_con(item_num).equipment_params.rx_cable_loss);

% --- Executes during object creation, after setting all properties.
function node_sel_popupmenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to node_sel_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
