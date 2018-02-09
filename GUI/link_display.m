function varargout = link_display(varargin)
% LINK_DISPLAY MATLAB code for link_display.fig
%      LINK_DISPLAY, by itself, creates a new LINK_DISPLAY or raises the existing
%      singleton*.
%
%      H = LINK_DISPLAY returns the handle to a new LINK_DISPLAY or the handle to
%      the existing singleton*.
%
%      LINK_DISPLAY('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in LINK_DISPLAY.M with the given input arguments.
%
%      LINK_DISPLAY('Property','Value',...) creates a new LINK_DISPLAY or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before link_display_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to link_display_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help link_display

% Last Modified by GUIDE v2.5 08-Feb-2018 19:14:14

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @link_display_OpeningFcn, ...
                   'gui_OutputFcn',  @link_display_OutputFcn, ...
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


% --- Executes just before link_display is made visible.
function link_display_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to link_display (see VARARGIN)

% Choose default command line output for link_display
handles.output = hObject;


% link_selection = getappdata(0, 'link_selec');
% 
% 
% if exist('linksave.mat')
%     load('linksave.mat')
%             
%     for linkin = 1:save_ind_link
%         if strcmp(link_selection,link_con(linkin).link_name)
%             
%             item_num = linkin;
%     
%         end
%     
%     end
% end
% 
% set(handles.link_name_text, 'String',link_con(item_num).link_name );
% set(handles.link_tech_text, 'String',link_con(item_num).technology );
% set(handles.node1_text, 'String',link_con(item_num).node_selection.node1);
% set(handles.node2_text, 'String',link_con(item_num).node_selection.node2);
% set(handles.service_text, 'String',link_con(item_num).node_service.service);
% set(handles.ber_text, 'String',link_con(item_num).node_service.ber);
% set(handles.modulation_text, 'String',link_con(item_num).system_params.mod_sch);
% set(handles.coding_text, 'String',link_con(item_num).system_params.code_rate  );
% set(handles.link_direc_text, 'String',link_con(item_num).system_params.link_direction);
% set(handles.link_freq_text, 'String',link_con(item_num).system_params.freq);
% set(handles.path_loss_mod_text, 'String',link_con(item_num).channel.path_loss_model);
% set(handles.fading_margin_text, 'String',link_con(item_num).channel.fading_margin);
% set(handles.interf_margin_text, 'String',link_con(item_num).channel.interference_margin);
% set(handles.temp_text, 'String',link_con(item_num).receiver.temperature);
% set(handles.rx_bw_text, 'String',link_con(item_num).receiver.rx_bandwidth);

if exist('linksave.mat')
    load('linksave.mat')
      link_choices= {link_con.link_name}; 


set(handles.link_sel_popupmenu, 'String', link_choices);
set(handles.link_sel_popupmenu, 'Value', 1);
end


% Update handles structure
guidata(hObject, handles);

% UIWAIT makes link_display wait for user response (see UIRESUME)
% uiwait(handles.figure_link_display);


% --- Outputs from this function are returned to the command line.
function varargout = link_display_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in close_disp_pushbutton.
function close_disp_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to close_disp_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close(link_display)

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in link_sel_popupmenu.
function link_sel_popupmenu_Callback(hObject, eventdata, handles)
% hObject    handle to link_sel_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns link_sel_popupmenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from link_sel_popupmenu
contents = cellstr(get(hObject,'String'));
link_selection = contents{get(hObject,'Value')};
setappdata(0, 'link_selec', link_selection);

if exist('linksave.mat')
    load('linksave.mat')
            
    for linkin = 1:save_ind_link
        if strcmp(link_selection,link_con(linkin).link_name)
            
            item_num = linkin;
    
        end
    
    end
end

set(handles.link_name_text, 'String',link_con(item_num).link_name );
set(handles.link_tech_text, 'String',link_con(item_num).technology );
set(handles.node1_text, 'String',link_con(item_num).node_selection.node1);
set(handles.node2_text, 'String',link_con(item_num).node_selection.node2);
set(handles.service_text, 'String',link_con(item_num).node_service.service);
set(handles.ber_text, 'String',link_con(item_num).node_service.ber);
set(handles.modulation_text, 'String',link_con(item_num).system_params.mod_sch);
set(handles.coding_text, 'String',link_con(item_num).system_params.code_rate  );
set(handles.link_direc_text, 'String',link_con(item_num).system_params.link_direction);
set(handles.link_freq_text, 'String',link_con(item_num).system_params.freq);
set(handles.path_loss_mod_text, 'String',link_con(item_num).channel.path_loss_model);
set(handles.fading_margin_text, 'String',link_con(item_num).channel.fading_margin);
set(handles.interf_margin_text, 'String',link_con(item_num).channel.interference_margin);
set(handles.temp_text, 'String',link_con(item_num).receiver.temperature);
set(handles.rx_bw_text, 'String',link_con(item_num).receiver.rx_bandwidth);

% --- Executes during object creation, after setting all properties.
function link_sel_popupmenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to link_sel_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
