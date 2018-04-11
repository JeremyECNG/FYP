display_flag =  getappdata(0,'disp_flag');

switch display_flag
    
    case 0 %NODE
        
        %Obtain user selection
        user_n_sel = getappdata(0, 'user_node_selection');
        if isempty(user_n_sel)
            errordlg('No node selected, Please Select a Node', 'Display')
        end
        
        %Load saved node information and initialize index
        if exist('nodesave.mat')
            load('nodesave.mat')
            
            for nodein = 1:save_ind
                if strcmp(user_n_sel,node_con(nodein).node_name)
                    nod_num = nodein;
                end
            end
            
        else
            errordlg('No node information available, Please Select a Node', 'Display')
        end
        
        %set(handles.node_display_text, 'String',node_con(nod_num).node_name)
        
        
        
        
        
        
        switch node_con(nod_num).node_type
            
            case 'Mobile at Sea'
                
                %h_ves = 2; %Vessel selected to be maximum 2m
                
                %d_losh = (sqrt(2*R*h_ves))/(10^3); %answer in km
                
                
                
                %setappdata(0,'range_dist',d_losh)
                %setappdata(0,'long_cordi',node_con(nod_num).node_location.longi);
                %setappdata(0,'lat_cordi',node_con(nod_num).node_location.lati );
                %handles.losh_plot = range_plot(node_con(nod_num).node_location.longi  ,node_con(nod_num).node_location.lati  ,d_losh,handles.map);
                %label = ['\rightarrow'  (num2str(node_con(nod_num).node_name)) ' LOSH Plot'];
                %handles.plot_label1 = text(handles.losh_plot.XData(1),handles.losh_plot.YData(1),label, 'HorizontalAlignment','left','Color','white','FontSize',14);
                
                h = findobj('Tag','gmap');
                h = h(2);
                makedatatip(h,[node_con(nod_num).node_location.longi node_con(nod_num).node_location.lati])
                
            case 'Tower Mounted'
                
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
                        
                        %h_bs = tower_tnt(find((ismember(tower_cords,closest_tower )),1)).AntennaHeight; %Height of Closest tower
                        
                        %d_losh = (sqrt(2*R*h_bs))/(10^3); %answer in km
                        %setappdata(0,'range_dist',d_losh)
                        %setappdata(0,'long_cordi',closest_tower(:,1));
                        %setappdata(0,'lat_cordi',closest_tower(:,2));
                        %handles.losh_plot = range_plot(closest_tower(:,1)  ,closest_tower(:,2)  ,d_losh,handles.map);
                        %label = ['\rightarrow'  (num2str(node_con(nod_num).node_name)) ' LOSH Plot'];
                        %handles.plot_label2 = text(handles.losh_plot.XData(1),handles.losh_plot.YData(1),label, 'HorizontalAlignment','left','Color','white','FontSize',14);
                        
                        h = findobj('Tag','gmap');
                        h = h(2);
                        makedatatip(h,[closest_tower(:,1)  closest_tower(:,2)])
                        
                    end
                end
                
        end
        
    case 1 %Link
        
        if exist('nodesave.mat')
            load('nodesave.mat')
        end
        %Obtain user selection
        user_l_sel = getappdata(0, 'user_link_selection');
        if isempty(user_l_sel)
            errordlg('No link selected', 'Run')
        end
        
        %Load saved link information and initialize index
        if exist('linksave.mat')
            load('linksave.mat')
            
            for linkin = 1:save_ind_link
                if strcmp(user_l_sel,link_con(linkin).link_name)
                    link_num = linkin;
                end
            end
            
        else
            errordlg('No link information available', 'Run')
        end
        
        set(handles.node_display_text, 'String',link_con(link_num).link_name)
        
        %Determine if uplink or downlink
        
        switch link_con(link_num).system_params.link_direction
            
            case 'Downlink'
                transmitter = link_con(link_num).node_selection.node1;
                receiver = link_con(link_num).node_selection.node2;
                
            case 'Uplink'
                transmitter = link_con(link_num).node_selection.node2;
                receiver = link_con(link_num).node_selection.node1;
                
        end
        
        %Find receiver index and transmitter index
        for nodein = 1:save_ind
            if strcmp(transmitter,node_con(nodein).node_name)
                tx_num = nodein;
            end
            
            if strcmp(receiver,node_con(nodein).node_name)
                rx_num = nodein;
            end
        end
        
        %Extract transmitter and receiver coordinates
        rx_cords = [node_con(rx_num).node_location.longi  ,node_con(rx_num).node_location.lati ];
        tx_cords = [node_con(tx_num).node_location.longi  ,node_con(tx_num).node_location.lati ];
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        %Ascertain whether the transmitter is tower mounted or mobile at sea
        switch node_con(tx_num).node_type
            
            case 'Mobile at Sea'
                
                %h_ves = 2; %Vessel selected to be maximum 2m
                
                %Plot Datatips for transmitter
                h = findobj('Tag','gmap');
                h = h(2);
                makedatatip(h,[node_con(tx_num).node_location.longi  node_con(tx_num).node_location.lati])
                
                switch node_con(rx_num).node_type
                    
                    case 'Mobile at Sea'
                        
                        %h_2 = h_ves ;
                        
                        %Plot Datatips for receiver
                        h = findobj('Tag','gmap');
                        h = h(2);
                        makedatatip(h,[node_con(rx_num).node_location.longi  node_con(rx_num).node_location.lati])
                        
                        
                    case 'Tower Mounted'
                        
                        if exist('towers.mat')
                            
                            load('towers.mat')
                            
                            if exist('tower_tnt')
                                
                                maxi = numel(tower_tnt);
                                
                                tower_cords = zeros(maxi,2);
                                
                                for elements = 1:maxi
                                    
                                    tower_cords(elements,:) = [tower_tnt(elements).Lon,tower_tnt(elements).Lat];
                                end
                                
                                user_cords = [node_con(rx_num).node_location.longi  ,node_con(rx_num).node_location.lati];
                                
                                euclidean_distances = sqrt(sum(bsxfun(@minus, tower_cords, user_cords).^2,2));
                                closest_tower = tower_cords(find(euclidean_distances==min(euclidean_distances)),:);
                                
                                %h_2 = tower_tnt(find((ismember(tower_cords,closest_tower )),1)).AntennaHeight; %Height of Closest tower
                                
                                %Plot Datatips for receiver
                                h = findobj('Tag','gmap');
                                h = h(2);
                                makedatatip(h,[closest_tower(:,1)  closest_tower(:,2)])
                            end
                        end
                end
                
                %tx_height = h_ves ;
                %d_losh = (sqrt(2*R*h_ves)+sqrt(2*R*h_2))/(10^3); %answer in km
                
                %setappdata(0,'range_dist',d_losh)
                %setappdata(0,'long_cordi',node_con(tx_num).node_location.longi);
                %setappdata(0,'lat_cordi',node_con(tx_num).node_location.lati);
                %plotted_range = range_plot(node_con(tx_num).node_location.longi  ,node_con(tx_num).node_location.lati  ,d_losh,handles.map,tx_height);
                %label = ['\rightarrow '  (num2str(link_con(link_num).link_name)) ' LOSH Plot ' num2str(round(d_losh)) 'km'];
                %handles.plot_label1 = text(plotted_range.XData(1),plotted_range.YData(1),label, 'HorizontalAlignment','left','Color','white','FontSize',14);
                
                %euclidean_los = sqrt(sum(bsxfun(@minus, tx_cords, rx_cords).^2,2)); %find direct distance between tx and rx to find if rx is in range of tx by comparing the link lenght to the LOSH distance(radius)
                %if euclidean_los<d_losh
                % range_flag = 1;   %Signal if in range or out of range
                %end
                
                
                
            case 'Tower Mounted'
                
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
                        
                        %h_bs = tower_tnt(find((ismember(tower_cords,closest_tower )),1)).AntennaHeight; %Height of Closest tower
                        %h_ves = 2;
                        %tx_height = h_bs ;
                        
                        %d_losh = (sqrt(2*R*h_bs)+sqrt(2*R*h_ves))/(10^3); %answer in km
                        %setappdata(0,'range_dist',d_losh)
                        %setappdata(0,'long_cordi',closest_tower(:,1));
                        %setappdata(0,'lat_cordi',closest_tower(:,2));
                        %plotted_range = range_plot(closest_tower(:,1)  ,closest_tower(:,2)  ,d_losh,handles.map,tx_height);
                        %label = ['\rightarrow '  (num2str(link_con(link_num).link_name)) ' LOSH Plot', num2str(round(d_losh)) 'km'];
                        %handles.plot_label1 = text(plotted_range.XData(1),plotted_range.YData(1),label, 'HorizontalAlignment','left','Color','white','FontSize',14);
                    end
                end
                
                %Plot Datatips for receiver
                h = findobj('Tag','gmap');
                h = h(2);
                makedatatip(h,[node_con(rx_num).node_location.longi  node_con(rx_num).node_location.lati])
                %Plot Datatips for transmitter
                h = findobj('Tag','gmap');
                h = h(2);
                makedatatip(h,[closest_tower(:,1)  closest_tower(:,2)])
                
                %create legend
                %i_am_legend = legend(handles.map,[plotted_range],{'Link LOSH'},'Location','best');
                %title(i_am_legend,'Line of Sight to Horizon Limit')
                
                %set(handles.range_display_text, 'String',d_losh)
                %set(handles.rx_sens_text, 'String','N/A')
                %set(handles.ber_display_text, 'String','N/A')
                %set(handles.node_display_text, 'String',link_con(link_num).link_name)
                %set(handles.path_loss_disp_text, 'String', 'N/A');
                
                %set(handles.techno_disp_text, 'String',node_con(nod_num).equipment_params.technology )
                %set(handles.service_disp_text, 'String','N/A' )
                %set(handles.techno_disp_text, 'String','N/A' )
                %set(handles.throughput_display_text, 'String','N/A')
                %set(handles.freq_disp_text, 'String', 'N/A');
                %set(handles.interf_disp_text, 'String', 'N/A');
                %set(handles.fade_disp_text, 'String', 'N/A');
                
                %Compute Throughput
        end
        
        
end