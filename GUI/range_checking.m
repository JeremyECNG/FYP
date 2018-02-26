      
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