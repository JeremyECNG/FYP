

switch range_sel
    
    case 0 %LOS
        
         switch display_flag
    
             case 0 %node

             case 1 %link
           
               switch link_con(link_num).system_params.link_direction
                   
                   case 'Downlink'

                   case 'Uplink'
                       
               end

    case 1 %Power Limited 
        
         switch display_flag
    
             case 0 %node   
                 
             case 1 %link

               switch link_con(link_num).system_params.link_direction

                    case 'Downlink'

                    case 'Uplink'
                        
               end
               
               switch link_con(link_num).channel.path_loss_model
                   
                   case 'FSPL'
                       
                       Path_Loss = Ptx + Gant - Cable_losses - Prx;
                       
                       plim_distance = 10^((Path_Loss-20*log10(f)-32.44)/20);
                       
                       range_plot(node_con(tx_num).node_location.longi  ,node_con(tx_num).node_location.lati  ,plim_distance,handles.map);
                       
                   case '2-Ray'
                       %%%%%%%%%%%%%%%%%

                   case '3-Ray'
                       %%%%%%%%%%%%%%%%%

                   case 'Sea Radio-Wave Propagation Loss'
                       %%%%%%%%%%%%%%%%%
        

               end  
         end  
end








%%

                       transmitter = link_con(link_num).node_selection.node1;
                       receiver = link_con(link_num).node_selection.node2;
                       
                       %load node stuff get location plot LOSH range from
                       %TX and possibly use area inside circle to determine
                       %if rx is in range and display text
                       
                           for nodein = 1:save_ind
                               if strcmp(transmitter,node_con(nodein).node_name)
                                   tx_num = nodein;
                               end

                               if strcmp(receiver,node_con(nodein).node_name)
                                   rx_num = nodein;
                               end
                           end

                           
 
                           
if strcmp(node_con(tx_num).node_type,'Mobile at Sea')
                     
                     h_ves = 2; %Vessel selected to be maximum 2m 
                     
                     d_losh = (sqrt(2*R*h_ves))/(10^3); %answer in km
                     
                     range_plot(node_con(tx_num).node_location.longi  ,node_con(tx_num).node_location.lati  ,d_losh,handles.map);

                     
                 elseif strcmp(node_con(tx_num).node_type,'Tower Mounted')
                     

                     
                         if exist('towers.mat')
                            load('towers.mat')
                            if exist('tower_tnt')
                                
                                maxi = numel(tower_tnt);
                                
                                tower_cords = zeros(maxi,2);
                                
                                for elements = 1:maxi
                                    
                                    tower_cords(elements,:) = [tower_tnt(elements).Lon,tower_tnt(elements).Lat];
                                    
                                end

                                user_cords = [node_con(tx_num).node_location.longi  ,node_con(tx_num).node_location.lati];

                                 euclidean_distances = sqrt(sum(bsxfun(@minus, tower_cords, user_cords).^2,2));
                                 closest_tower = tower_cords(find(euclidean_distances==min(euclidean_distances)),:);
                                 
                                 h_bs = tower_tnt(find((ismember(tower_cords,closest_tower )),1)).AntennaHeight; %Height of Closest tower
                                 
                                 d_losh = (sqrt(2*R*h_bs))/(10^3); %answer in km
                                 
                                 range_plot(closest_tower(:,1)  ,closest_tower(:,2)  ,d_losh,handles.map);
                                 
                            end
                         end
                         
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%

switch link_con(link_num).system_params.link_direction

case 'Downlink'

transmitter = link_con(link_num).node_selection.node1;
receiver = link_con(link_num).node_selection.node2;

%load node stuff get location plot LOSH range from
%TX and  use area inside circle to determine
%if rx is in range and display text

%insert circle checking to decide if point is within
%range circle 
for nodein = 1:save_ind
   if strcmp(transmitter,node_con(nodein).node_name)
       tx_num = nodein;
   end

   if strcmp(receiver,node_con(nodein).node_name)
       rx_num = nodein;
   end
end

rx_cords = [node_con(rx_num).node_location.longi  ,node_con(rx_num).node_location.lati ];
tx_cords = [node_con(tx_num).node_location.longi  ,node_con(tx_num).node_location.lati ];

%%%%%%%%%

if strcmp(node_con(tx_num).node_type,'Mobile at Sea')

     h_ves = 2; %Vessel selected to be maximum 2m 

     d_losh = (sqrt(2*R*h_ves))/(10^3); %answer in km

     setappdata(0,'range_dist',d_losh)
     setappdata(0,'long_cordi',node_con(tx_num).node_location.longi); 
     setappdata(0,'lat_cordi',node_con(tx_num).node_location.lati);
     range_plot(node_con(tx_num).node_location.longi  ,node_con(tx_num).node_location.lati  ,d_losh,handles.map);

     euclidean_los = sqrt(sum(bsxfun(@minus, tx_cords, rx_cords).^2,2)); %find direct distance between tx and rx

elseif strcmp(node_con(tx_num).node_type,'Tower Mounted')


   if exist('towers.mat')

       load('towers.mat')

       if exist('tower_tnt')

                maxi = numel(tower_tnt);

                tower_cords = zeros(maxi,2);

                for elements = 1:maxi

                    tower_cords(elements,:) = [tower_tnt(elements).Lon,tower_tnt(elements).Lat];

                end

                user_cords = [node_con(tx_num).node_location.longi  ,node_con(tx_num).node_location.lati];

                 euclidean_distances = sqrt(sum(bsxfun(@minus, tower_cords, user_cords).^2,2));
                 closest_tower = tower_cords(find(euclidean_distances==min(euclidean_distances)),:);

                 h_bs = tower_tnt(find((ismember(tower_cords,closest_tower )),1)).AntennaHeight; %Height of Closest tower

                 d_losh = (sqrt(2*R*h_bs))/(10^3); %answer in km
                 setappdata(0,'range_dist',d_losh)
                 setappdata(0,'long_cordi',closest_tower(:,1)); 
                 setappdata(0,'lat_cordi',closest_tower(:,2));
                 range_plot(closest_tower(:,1)  ,closest_tower(:,2)  ,d_losh,handles.map);

       end
   end
end

%% old range run code

range_sel =      getappdata(0,'range_type');
display_flag =  getappdata(0,'disp_flag');
R = 6.378*(10^6); %R is in meters 

if exist('nodesave.mat') %#ok
    load('nodesave.mat')
end

switch range_sel
    
    case 0 %LOS
        
         switch display_flag
    
             case 0 %node

%Resume coding here

                user_n_sel = getappdata(0, 'user_node_selection');
                
                if exist('nodesave.mat')
                    load('nodesave.mat')

                    for nodein = 1:save_ind
                        if strcmp(user_n_sel,node_con(nodein).node_name)

                            nod_num = nodein;

                        end

                    end
                end
                
                 if strcmp(node_con(nod_num).node_type,'Mobile at Sea')
                     
                     h_ves = 2; %Vessel selected to be maximum 2m 
                     
                     d_losh = (sqrt(2*R*h_ves))/(10^3); %answer in km
                     
                     setappdata(0,'range_dist',d_losh)
                     setappdata(0,'long_cordi',node_con(nod_num).node_location.longi); 
                     setappdata(0,'lat_cordi',node_con(nod_num).node_location.lati );
                     handles.losh_plot = range_plot(node_con(nod_num).node_location.longi  ,node_con(nod_num).node_location.lati  ,d_losh,handles.map);
                     
                 elseif strcmp(node_con(nod_num).node_type,'Tower Mounted')
                     

                     
                         if exist('towers.mat')
                            load('towers.mat')
                            if exist('tower_tnt')
                                
                                maxi = numel(tower_tnt);
                                
                                tower_cords = zeros(maxi,2);
                                
                                for elements = 1:maxi
                                    
                                    tower_cords(elements,:) = [tower_tnt(elements).Lon,tower_tnt(elements).Lat];
                                    
                                end

                                user_cords = [node_con(nod_num).node_location.longi  ,node_con(nod_num).node_location.lati];

                                 euclidean_distances = sqrt(sum(bsxfun(@minus, tower_cords, user_cords).^2,2));
                                 closest_tower = tower_cords(find(euclidean_distances==min(euclidean_distances)),:);
                                 
                                 h_bs = tower_tnt(find((ismember(tower_cords,closest_tower )),1)).AntennaHeight; %Height of Closest tower
                                 
                                 d_losh = (sqrt(2*R*h_bs))/(10^3); %answer in km
                                 setappdata(0,'range_dist',d_losh)                    
                                 setappdata(0,'long_cordi',closest_tower(:,1)); 
                                 setappdata(0,'lat_cordi',closest_tower(:,2));
                                 range_plot(closest_tower(:,1)  ,closest_tower(:,2)  ,d_losh,handles.map);
                                 
                            end
                        end
                 end
        
             case 1 %link
        
                user_l_sel = getappdata(0, 'user_link_selection');
                
               if exist('linksave.mat')
                    load('linksave.mat')

                    for linkin = 1:save_ind_link
                        if strcmp(user_l_sel,link_con(linkin).link_name)

                            link_num = linkin;

                        end
                    end
               end
                
               %%%%Code here bruv
               
               switch link_con(link_num).system_params.link_direction
                   
                   case 'Downlink'
                       
                       transmitter = link_con(link_num).node_selection.node1;
                       receiver = link_con(link_num).node_selection.node2;
                       
                       %load node stuff get location plot LOSH range from
                       %TX and  use area inside circle to determine
                       %if rx is in range and display text
                       
                       %insert circle checking to decide if point is within
                       %range circle 
                           for nodein = 1:save_ind
                               if strcmp(transmitter,node_con(nodein).node_name)
                                   tx_num = nodein;
                               end

                               if strcmp(receiver,node_con(nodein).node_name)
                                   rx_num = nodein;
                               end
                           end
                           
                           rx_cords = [node_con(rx_num).node_location.longi  ,node_con(rx_num).node_location.lati ];
                           tx_cords = [node_con(tx_num).node_location.longi  ,node_con(tx_num).node_location.lati ];

                           %%%%%%%%%
                           
                           if strcmp(node_con(tx_num).node_type,'Mobile at Sea')
                     
                                 h_ves = 2; %Vessel selected to be maximum 2m 

                                 d_losh = (sqrt(2*R*h_ves))/(10^3); %answer in km
                                 
                                 setappdata(0,'range_dist',d_losh)
                                 setappdata(0,'long_cordi',node_con(tx_num).node_location.longi); 
                                 setappdata(0,'lat_cordi',node_con(tx_num).node_location.lati);
                                 range_plot(node_con(tx_num).node_location.longi  ,node_con(tx_num).node_location.lati  ,d_losh,handles.map);
                                 
                                 euclidean_los = sqrt(sum(bsxfun(@minus, tx_cords, rx_cords).^2,2)); %find direct distance between tx and rx to find if rx is in range of tx by comparing the link lenght to the LOSH distance(radius) 

                           elseif strcmp(node_con(tx_num).node_type,'Tower Mounted')

     
                               if exist('towers.mat')
                                       
                                   load('towers.mat')
                                        
                                   if exist('tower_tnt')

                                            maxi = numel(tower_tnt);

                                            tower_cords = zeros(maxi,2);

                                            for elements = 1:maxi

                                                tower_cords(elements,:) = [tower_tnt(elements).Lon,tower_tnt(elements).Lat];

                                            end

                                            user_cords = [node_con(tx_num).node_location.longi  ,node_con(tx_num).node_location.lati];

                                             euclidean_distances = sqrt(sum(bsxfun(@minus, tower_cords, user_cords).^2,2));
                                             closest_tower = tower_cords(find(euclidean_distances==min(euclidean_distances)),:);

                                             h_bs = tower_tnt(find((ismember(tower_cords,closest_tower )),1)).AntennaHeight; %Height of Closest tower

                                             d_losh = (sqrt(2*R*h_bs))/(10^3); %answer in km
                                             setappdata(0,'range_dist',d_losh)
                                             setappdata(0,'long_cordi',closest_tower(:,1)); 
                                             setappdata(0,'lat_cordi',closest_tower(:,2));
                                             range_plot(closest_tower(:,1)  ,closest_tower(:,2)  ,d_losh,handles.map);

                                   end
                               end
                           end
 %%%%%
 %if (x-x0)^2 + (y-y0)^2 < r^2, %the point (x,y) is inside the circle
    
                   case 'Uplink'
                       
                       transmitter = link_con(link_num).node_selection.node2;
                       receiver = link_con(link_num).node_selection.node1;
                                   
                       for nodein = 1:save_ind
                              
                           if strcmp(transmitter,node_con(nodein).node_name)
                                   tx_num = nodein;
                           end
                           
                           if strcmp(receiver,node_con(nodein).node_name)
                                   rx_num = nodein;                              
                           end
                       end
                       
                       %%% Code here for if Mobile or Tower 
               end
         end

        

    case 1 %Power Limited 
        
         switch display_flag
    
             case 0 %node   
                 
             case 1 %link
                 
               user_l_sel = getappdata(0, 'user_link_selection');
                
               if exist('linksave.mat')
                    load('linksave.mat')

                    for linkin = 1:save_ind_link
                        if strcmp(user_l_sel,link_con(linkin).link_name)

                            link_num = linkin;

                        end
                    end
               end
               
               switch link_con(link_num).system_params.link_direction

                    case 'Downlink'

                    transmitter = link_con(link_num).node_selection.node1;
                    receiver = link_con(link_num).node_selection.node2;

                    %load node stuff get location plot LOSH range from
                    %TX and  use area inside circle to determine
                    %if rx is in range and display text

                    %insert circle checking to decide if point is within
                    %range circle 
                    for nodein = 1:save_ind
                       if strcmp(transmitter,node_con(nodein).node_name)
                           tx_num = nodein;
                       end

                       if strcmp(receiver,node_con(nodein).node_name)
                           rx_num = nodein;
                       end
                    end

                    rx_cords = [node_con(rx_num).node_location.longi  ,node_con(rx_num).node_location.lati ];
                    tx_cords = [node_con(tx_num).node_location.longi  ,node_con(tx_num).node_location.lati ];
                    
                   case 'Uplink'
                       
                    transmitter = link_con(link_num).node_selection.node2;
                    receiver = link_con(link_num).node_selection.node1;

                    %load node stuff get location plot LOSH range from
                    %TX and  use area inside circle to determine
                    %if rx is in range and display text

                    %insert circle checking to decide if point is within
                    %range circle 
                    for nodein = 1:save_ind
                       if strcmp(transmitter,node_con(nodein).node_name)
                           tx_num = nodein;
                       end

                       if strcmp(receiver,node_con(nodein).node_name)
                           rx_num = nodein;
                       end
                    end

                    rx_cords = [node_con(rx_num).node_location.longi  ,node_con(rx_num).node_location.lati ];
                    tx_cords = [node_con(tx_num).node_location.longi  ,node_con(tx_num).node_location.lati ];
                    
               end
               
               % Place condition for whether mobile or tower to then get
               % heights to be use in PL models
               Ptx = node_con(tx_num).equipment_params.tx_pwr;
               Prx = node_con(rx_num).equipment_params.rx_pwr;
               setappdata(0,'prx_display',Prx)
               Gant = node_con(tx_num).equipment_params.tx_ant_gain + node_con(rx_num).equipment_params.rx_ant_gain;
               Cable_losses = node_con(tx_num).equipment_params.tx_cable_loss + node_con(rx_num).equipment_params.rx_cable_loss;
               f = link_con(link_num).system_params.freq*10^6;
               switch link_con(link_num).channel.path_loss_model
                   
                   case 'FSPL'
                       
                       Path_Loss = Ptx + Gant - Cable_losses - Prx;
                       
                       plim_distance = 10^((Path_Loss-20*log10(f)-32.44)/20);
                       
                       range_plot(node_con(tx_num).node_location.longi  ,node_con(tx_num).node_location.lati  ,plim_distance,handles.map);
                       
                   case '2-Ray'
                       %%%%%%%%%%%%%%%%%
        

        
                   case '3-Ray'
                       %%%%%%%%%%%%%%%%%
        


                   case 'Sea Radio-Wave Propagation Loss'
                       %%%%%%%%%%%%%%%%%
        

               end
               
             
               
         end
        
end


% user_n_sel = getappdata(0, 'user_node_selection');
% 
% if exist('nodesave.mat')
%     load('nodesave.mat')
% 
%     for nodein = 1:save_ind
%         if strcmp(user_n_sel,node_con(nodein).node_name)
% 
%             nod_num = nodein;
% 
%         end
% 
%     end
% end

user_l_sel = getappdata(0, 'user_link_selection');

if exist('linksave.mat')
    load('linksave.mat')

    for linkin = 1:save_ind_link
        if strcmp(user_l_sel,link_con(linkin).link_name)

            link_num = linkin;

        end
    end
end

tput_modulation = link_con(link_num).system_params.mod_sch;
if strcmp(link_con(link_num).system_params.code_rate,'6x10^-8')
    tput_code_rate = 6*10^-8;
else
    tput_code_rate = str2double(link_con(link_num).system_params.code_rate);
end

switch tput_modulation
    
    case 'QPSK'
        Qm = 2;
        
    case '16QAM'
        Qm = 4;
        
    case '64QAM'
        Qm = 6;
        
    case '256QAM'
        Qm = 8;
                
end

PDSCH_RE_frame = 6352; %Extended CP, CFI = 3, BW = 1.4 MHz
phy_tput_frame = ((PDSCH_RE_frame*Qm)/(10*10^-3))/10^6; %SISO
set(handles.throughput_display_text, 'String',phy_tput_frame) 

set(handles.ber_display_text, 'String',link_con(link_num).node_service.ber) 
set(handles.node_display_text, 'String',link_con(link_num).link_name) 

rxs = getappdata(0,'prx_display');
set(handles.rx_sens_text, 'String',rxs) 

%Resume coding here dude

tput_range = getappdata(0,'tput_on');
tput_value =  getappdata(0,'throughput_flag');
if 1 == tput_range 
    
    switch tput_value
        
        case 1 %Full Range
            throughpt = getappdata(0,'range_dist');
            x = getappdata(0,'long_cordi'); 
            y = getappdata(0,'lat_cordi');
            phy_tput_frame = ((PDSCH_RE_frame*Qm)/(10*10^-3))/10^6; %SISO
            set(handles.throughput_display_text, 'String',phy_tput_frame) 
%             txt = '\rightarrow 50% Range ' ;
%             shift = (x+(throughpt/0.011132)*0.0001);                                                                                                     
%             handles.tput_text = text(shift,y,txt, 'HorizontalAlignment','left');
            handles.tput_plotting = tput_plot(x,y,throughpt,handles.map);
            
        case 2 %75% Range
            throughpt = 0.75*(getappdata(0,'range_dist'));
            
            x = getappdata(0,'long_cordi'); 
            y = getappdata(0,'lat_cordi');
%             txt = '\rightarrow 75% Range ' ;
%             shift = (x+(throughpt/0.011132)*0.0001);
% 
%             handles.tput_text = text(shift,y,txt, 'HorizontalAlignment','left');
            handles.tput_plotting = tput_plot(x,y,throughpt,handles.map);
            
        case 3 %50 Range
            throughpt = 0.5*(getappdata(0,'range_dist'));
            
            x = getappdata(0,'long_cordi'); 
            y = getappdata(0,'lat_cordi');
%             txt = '\rightarrow 50% Range ' ;
%             shift = (x+(throughpt/0.011132)*0.0001);                                                                                                     
%             handles.tput_text = text(shift,y,txt, 'HorizontalAlignment','left');
            handles.tput_plotting = tput_plot(x,y,throughpt,handles.map);
            
        case 4 %25 Range
           
            throughpt = 0.25*(getappdata(0,'range_dist'));
            x = getappdata(0,'long_cordi'); 
            y = getappdata(0,'lat_cordi');
%             txt = '\rightarrow 50% Range ' ;
%             shift = (x+(throughpt/0.011132)*0.0001);                                                                                                     
%             handles.tput_text = text(shift,y,txt, 'HorizontalAlignment','left');
            handles.tput_plotting = tput_plot(x,y,throughpt,handles.map);         
    end
end

%these last two ends were not here 
end
end