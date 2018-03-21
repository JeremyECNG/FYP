range_sel =      getappdata(0,'range_type');
display_flag =  getappdata(0,'disp_flag');
R = 6.378*(10^6); %Radius of the earth in meters

switch display_flag %Variable for determining whether a node or link is to be displayed

 case 0 %Node is selected
     
     
     %Obtain user selection 
     user_n_sel = getappdata(0, 'user_node_selection');
     if isempty(user_n_sel) 
         errordlg('No node selected', 'Run')
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
         errordlg('No node information available', 'Run')
     end
     
     set(handles.node_display_text, 'String',node_con(nod_num).node_name)
     
     switch range_sel %Variable for determining whether a LOS or Power Limited range is to be plotted
         
         case 0 %LOS
             switch node_con(tx_num).node_type
                 
                 case 'Mobile at Sea' 
                     
                     h_ves = 2; %Vessel selected to be maximum 2m 
                     
                     d_losh = (sqrt(2*R*h_ves))/(10^3); %answer in km
                     
                     setappdata(0,'range_dist',d_losh)
                     setappdata(0,'long_cordi',node_con(nod_num).node_location.longi); 
                     setappdata(0,'lat_cordi',node_con(nod_num).node_location.lati );
                     handles.losh_plot = range_plot(node_con(nod_num).node_location.longi  ,node_con(nod_num).node_location.lati  ,d_losh,handles.map);
                     
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

                             h_bs = tower_tnt(find((ismember(tower_cords,closest_tower )),1)).AntennaHeight; %Height of Closest tower

                             d_losh = (sqrt(2*R*h_bs))/(10^3); %answer in km
                             setappdata(0,'range_dist',d_losh)                    
                             setappdata(0,'long_cordi',closest_tower(:,1)); 
                             setappdata(0,'lat_cordi',closest_tower(:,2));
                            handles.losh_plot = range_plot(closest_tower(:,1)  ,closest_tower(:,2)  ,d_losh,handles.map);

                         end
                     end
                     
             end
             
             
         case 1 %Power Limited
             
             errordlg('Range and Throughput cannot be computed for this configuration', 'Run')
             
             
         case 2 %Prevailing Limit
             errordlg('Range and Throughput cannot be computed for this configuration', 'Run')
                          
     end
     
     

 case 1 %Link is selected
          
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
     
         

      switch range_sel %Variable for determining whether a LOS or Power Limited range is to be plotted
         
         case 0 %LOS
             
             %Ascertain whether the transmitter is tower mounted or mobile at sea 
             switch node_con(tx_num).node_type
                 
                 case 'Mobile at Sea'
                     
                     h_ves = 2; %Vessel selected to be maximum 2m 

                     d_losh = (sqrt(2*R*h_ves))/(10^3); %answer in km

                     setappdata(0,'range_dist',d_losh)
                     setappdata(0,'long_cordi',node_con(tx_num).node_location.longi); 
                     setappdata(0,'lat_cordi',node_con(tx_num).node_location.lati);
                     plotted_range = range_plot(node_con(tx_num).node_location.longi  ,node_con(tx_num).node_location.lati  ,d_losh,handles.map);

                     euclidean_los = sqrt(sum(bsxfun(@minus, tx_cords, rx_cords).^2,2)); %find direct distance between tx and rx to find if rx is in range of tx by comparing the link lenght to the LOSH distance(radius)
                     if euclidean_los<d_losh
                         range_flag = 1;                         
                     end

                     %Compute Throughput 
                     
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

                                h_bs = tower_tnt(find((ismember(tower_cords,closest_tower )),1)).AntennaHeight; %Height of Closest tower

                                d_losh = (sqrt(2*R*h_bs))/(10^3); %answer in km
                                setappdata(0,'range_dist',d_losh)
                                setappdata(0,'long_cordi',closest_tower(:,1)); 
                                setappdata(0,'lat_cordi',closest_tower(:,2));
                                plotted_range = range_plot(closest_tower(:,1)  ,closest_tower(:,2)  ,d_losh,handles.map);
                         end
                     end
                     
                     %Compute Throughput
             end
             
             
         case 1 %Power Limited
             
             switch node_con(tx_num).node_type
                 
                 case 'Mobile at Sea'
                     ht = 2;
                     
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

                                ht = tower_tnt(find((ismember(tower_cords,closest_tower )),1)).AntennaHeight; %Height of Closest tower


                         end
                     end
                     
             end
                     
                     

             
             switch node_con(rx_num).node_type
                 
                 case 'Mobile at Sea'
                     hr = 2;
                     
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

                                hr = tower_tnt(find((ismember(tower_cords,closest_tower )),1)).AntennaHeight; %Height of Closest tower


                         end
                     end
                     
             end
             
             set(handles.service_disp_text, 'String', link_con(link_num).node_service.service);
             set(handles.ber_display_text, 'String',link_con(link_num).node_service.ber)
             switch link_con(link_num).node_service.ber
                 
                 case '10^-2'
                     ber_target = 10^-2;
                     
                 case '10^-3'
                     ber_target = 10^-3;
                     
                 case '10^-5' 
                     ber_target = 10^-5;
                     
                 case '6x10^-8'
                     ber_target = 6*10^-8;
                     
             end
             
              channel_type = link_con(link_num).channel.channel_type;%channel type variable from configuration

             
             %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
             switch link_con(link_num).technology 
    
                 case 'DSC'
                     Qm = 2;
                     datarate = 1200; 

                     Rb = datarate ; 

                     B_noise = link_con(link_num).receiver.rx_bandwidth;
                     mod_sch = 'FSK';
                     EbN0 = EbN0_value(ber_target,mod_sch,channel_type);
                     SINR = EbN0*(Rb/B_noise);
                     SINR_db = 10*log10(SINR);
                     Nf = node_con(rx_num).equipment_params.noise_fig;
                     k = physconst('Boltzmann');
                     T = link_con(link_num).receiver.temperature;
                     Nt = k*T*B_noise;
                     Nt_db =  10*log10(Nt);   
    
                 case 'LTE-A'
                     B_sys = link_con(link_num).system_params.system_bandwidth;
                     set(handles.freq_disp_text, 'String', B_sys);
                     switch B_sys

                         case '1.4'
                             RE_frame = 8640; %Extended CP, CFI = 3, BW = 1.4 MHz

                         case '3'
                             RE_frame = 21600; %Extended CP, CFI = 3

                         case '5'
                             RE_frame = 36000; %Extended CP, CFI = 3

                         case '10'
                             RE_frame = 72000; %Extended CP, CFI = 3

                         case '15'
                             RE_frame = 108000; %Extended CP, CFI = 3

                         case '20'
                             RE_frame = 144000; %Extended CP, CFI = 3

                     end

                     Qm = 2;
                     phy_datarate_frame = ((RE_frame*Qm)/(10*10^-3)); %SISO

                     Rb = phy_datarate_frame ; 

                     B_noise = link_con(link_num).receiver.rx_bandwidth;
                     mod_sch = 'QPSK';
                     EbN0 = EbN0_value(ber_target,mod_sch,channel_type);
                     SINR = EbN0*(Rb/B_noise);
                     SINR_db = 10*log10(SINR);
                     Nf = node_con(rx_num).equipment_params.noise_fig;
                     k = physconst('Boltzmann');
                     T = link_con(link_num).receiver.temperature;
                     Nt = k*T*B_noise;
                     Nt_db =  10*log10(Nt);      
           

                 case 'NWR'
                     B_sys = link_con(link_num).system_params.system_bandwidth;
                     set(handles.freq_disp_text, 'String', B_sys);
%                      switch B_sys
% 
%                          case '1.4'
%                              PDSCH_RE_frame = 4912; %Extended CP, CFI = 3, BW = 1.4 MHz
% 
%                          case '3'
%                              PDSCH_RE_frame = 14812; %Extended CP, CFI = 3
% 
%                          case '5'
%                              PDSCH_RE_frame = 25012; %Extended CP, CFI = 3
% 
%                          case '10'
%                              PDSCH_RE_frame = 50512; %Extended CP, CFI = 3
% 
%                          case '15'
%                              PDSCH_RE_frame = 76012; %Extended CP, CFI = 3
% 
%                          case '20'
%                              PDSCH_RE_frame = 101512; %Extended CP, CFI = 3
% 
%                      end

                     Qm = 2;
                     datarate = 520.83; 

                     Rb = 520.83; 

                     B_noise = link_con(link_num).receiver.rx_bandwidth;
                     mod_sch = 'FSK';
                     EbN0 = EbN0_value(ber_target,mod_sch,channel_type);
                     SINR = EbN0*(Rb/B_noise);
                     SINR_db = 10*log10(SINR);
                     Nf = node_con(rx_num).equipment_params.noise_fig;
                     k = physconst('Boltzmann');
                     T = link_con(link_num).receiver.temperature;
                     Nt = k*T*B_noise;
                     Nt_db =  10*log10(Nt);    
   
                 case 'Generic'    
                     B_sys = link_con(link_num).system_params.system_bandwidth;
                     set(handles.freq_disp_text, 'String', B_sys);
                     switch B_sys

                         case '1.4'
                             RE_frame = 8640; %Extended CP,  BW = 1.4 MHz

                         case '3'
                             RE_frame = 21600; %Extended CP 

                         case '5'
                             RE_frame = 36000; %Extended CP
                             
                         case '10'
                             RE_frame = 72000; %Extended CP 

                         case '15'
                             RE_frame = 108000; %Extended CP 

                         case '20'
                             RE_frame = 144000; %Extended CP 

                     end

                     Qm = 2;
                     phy_datarate_frame = ((RE_frame*Qm)/(10*10^-3)); %SISO
                     Rb = phy_datarate_frame;

                     B_noise = link_con(link_num).receiver.rx_bandwidth;
                     mod_sch = 'QPSK';
                     EbN0 = EbN0_value(ber_target,mod_sch,channel_type);
                     SINR = EbN0*(Rb/B_noise);
                     SINR_db = 10*log10(SINR);
                     Nf = node_con(rx_num).equipment_params.noise_fig;
                     k = physconst('Boltzmann');
                     T = link_con(link_num).receiver.temperature;
                     Nt = k*T*B_noise;
                     Nt_db =  10*log10(Nt);                                
                     
             end
             

             
             %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
             If_margin = link_con(link_num).channel.interference_margin;
             set(handles.interf_disp_text, 'String', If_margin);
             fad_margin = link_con(link_num).channel.fading_margin;
             set(handles.fade_disp_text, 'String', fad_margin);
             
             Interf_Noise = Nt_db+Nf+If_margin+fad_margin;
             
             Pr_min = SINR_db - Interf_Noise;
             
             set(handles.rx_sens_text, 'String',Pr_min)
             set(handles.ber_display_text, 'String',link_con(link_num).node_service.ber) 
             set(handles.node_display_text, 'String',link_con(link_num).link_name) 
             
%              fad_margin = link_con(link_num).channel.fading_margin;
%              set(handles.fade_disp_text, 'String', fad_margin);
                          

             Ptx = node_con(tx_num).equipment_params.tx_pwr;
%              Prx = node_con(rx_num).equipment_params.rx_pwr;
%              setappdata(0,'prx_display',Prx)
             G_ant = node_con(tx_num).equipment_params.tx_ant_gain + node_con(rx_num).equipment_params.rx_ant_gain;
             Cable_losses = node_con(tx_num).equipment_params.tx_cable_loss + node_con(rx_num).equipment_params.rx_cable_loss;
             
             PL_target = Ptx + G_ant - Cable_losses - Pr_min;
             
             freq = link_con(link_num).system_params.freq;

               switch link_con(link_num).channel.path_loss_model
                   
                   case 'FSPL'
                       set(handles.path_loss_disp_text, 'String', link_con(link_num).channel.path_loss_model);
                       %Path_Loss = Ptx + G_ant - Cable_losses - Prx;
                       
                       plim_distance = 10^((PL_target-20*log10(freq*10^6)-32.44)/20);
                       
                       plotted_range = range_plot(node_con(tx_num).node_location.longi  ,node_con(tx_num).node_location.lati  ,plim_distance,handles.map);
                       
                   case '2-Ray'
                       set(handles.path_loss_disp_text, 'String', link_con(link_num).channel.path_loss_model);

                       plim_distance =two_ray(PL_target, ht, hr, freq)*10^-3;
                       
                       plotted_range = range_plot(node_con(tx_num).node_location.longi  ,node_con(tx_num).node_location.lati  ,plim_distance,handles.map);                       
        

        
                   case '3-Ray'
                       set(handles.path_loss_disp_text, 'String', link_con(link_num).channel.path_loss_model);
                       
                       plim_distance =three_ray(PL_target, ht, hr, freq)*10^-3;
                       
                       plotted_range = range_plot(node_con(tx_num).node_location.longi  ,node_con(tx_num).node_location.lati  ,plim_distance,handles.map);       


                   case 'Sea Radio-Wave Propagation Loss'
                       set(handles.path_loss_disp_text, 'String', link_con(link_num).channel.path_loss_model);
                       
                       plim_distance = srwpl(PL_target, ht, hr, freq)*10^-3;
        
                       plotted_range = range_plot(node_con(tx_num).node_location.longi  ,node_con(tx_num).node_location.lati  ,plim_distance,handles.map);
               end
               
               set(handles.range_display_text, 'String',plim_distance) 
               
                switch link_con(link_num).technology 

                    case 'DSC'
                         Qm = 2;
                         datarate = 1200; 

                         Rb = datarate ; 

                         mod_sch = 'FSK';
                         EbN0 = EbN0_value(ber_target,mod_sch,channel_type);
                         SINR = EbN0*(Rb/B_noise);
                         SINR_db = 10*log10(SINR);
                         Pr_min = SINR_db - Interf_Noise;
                         PL_target = Ptx + G_ant - Cable_losses - Pr_min;
                         x = node_con(tx_num).node_location.longi; 
                         y = node_con(tx_num).node_location.lati;

                         switch link_con(link_num).channel.path_loss_model

                                     case 'FSPL'

                                         tput_distance = 10^((PL_target-20*log10(freq*10^6)-32.44)/20);


                                         handles.tput_plotted = tput_plot(x,y,tput_distance ,handles.map);


                                     case '2-Ray'

                                         tput_distance = two_ray(PL_target, ht, hr, freq);
                                         tput_distance = tput_distance*10^-3;

                                         handles.tput_plotted = tput_plot(x,y,tput_distance ,handles.map);               

                                     case '3-Ray'
                                         tput_distance = three_ray(PL_target, ht, hr, freq);
                                         tput_distance = tput_distance*10^-3;                 

                                         handles.tput_plotted = tput_plot(x,y,tput_distance ,handles.map); 

                                     case 'Sea Radio-Wave Propagation Loss'
                                         tput_distance = srwpl(PL_target, ht, hr, freq);
                                         tput_distance = tput_distance*10^-3;                 

                                         handles.tput_plotted = tput_plot(x,y,tput_distance ,handles.map); 
                         end



                     case 'LTE-A'

                         switch link_con(link_num).node_service.ber

                             case '10^-3'
                                 Qm = [1,1,2,2,4,4,6,6,6,6];
                                 code = ['1/2','3/4','1/2','3/4','1/2','3/4','1/2','2/3','3/4','5/6'];
                                 %Rb = ((RE_frame*Qm)/(10*10^-3)); 
                                 %EbN0 = [EbN0_value(ber_target,'QPSK',channel_type),EbN0_value(ber_target,'16QAM',channel_type),EbN0_value(ber_target,'64QAM',channel_type)];

                                 %SINR = EbN0.*(Rb/B_noise);         
                                 %SINR_db = 10*log10(SINR);   
                                 SINR_db = [14.54,19.16,17.54,22.16,23.6,28.5,26.36,30.84,31.96,33.08];
                                 Pr_min = SINR_db - Interf_Noise;        
                                 PL_target = Ptx + G_ant - Cable_losses - Pr_min;                
                                 x = node_con(tx_num).node_location.longi;          
                                 y = node_con(tx_num).node_location.lati;

                                 switch link_con(link_num).channel.path_loss_model

                                     case 'FSPL'

                                         tput_distance = 10.^((PL_target-20*log10(freq*10^6)-32.44)/20);

                                         %BPSK 1/2                                 
                                         handles.tput_plot1 = tput_plot(x,y,tput_distance(1) ,handles.map);

                                         %BPSK 3/4 
                                         handles.tput_plot2 = tput_plot(x,y,tput_distance(2) ,handles.map);

                                         %QPSK 1/2             
                                         handles.tput_plot3= tput_plot(x,y,tput_distance(3) ,handles.map);

                                         %QPSK 3/4                                 
                                         handles.tput_plot4 = tput_plot(x,y,tput_distance(4) ,handles.map);

                                         %16QAM 1/2  
                                         handles.tput_plot5 = tput_plot(x,y,tput_distance(5) ,handles.map);

                                         %16QAM 3/4               
                                         handles.tput_plot6= tput_plot(x,y,tput_distance(6) ,handles.map);

                                         %64QAM 1/2                                 
                                         handles.tput_plot7 = tput_plot(x,y,tput_distance(7) ,handles.map);                 

                                         %64QAM 2/3 
                                         handles.tput_plot8 = tput_plot(x,y,tput_distance(8) ,handles.map);

                                         %64QAM 3/4                 
                                         handles.tput_plot9= tput_plot(x,y,tput_distance(9) ,handles.map);

                                         %64QAM 5/6                 
                                         handles.tput_plot10= tput_plot(x,y,tput_distance(10) ,handles.map);

                                     case '2-Ray'

                                         tput_distance = [two_ray(PL_target(1), ht, hr, freq),two_ray(PL_target(2), ht, hr, freq),two_ray(PL_target(3), ht, hr, freq)];
                                         tput_distance = tput_distance*10^-3;

                                         %BPSK 1/2                                 
                                         handles.tput_plot1 = tput_plot(x,y,tput_distance(1) ,handles.map);

                                         %BPSK 3/4 
                                         handles.tput_plot2 = tput_plot(x,y,tput_distance(2) ,handles.map);

                                         %QPSK 1/2             
                                         handles.tput_plot3= tput_plot(x,y,tput_distance(3) ,handles.map);

                                         %QPSK 3/4                                 
                                         handles.tput_plot4 = tput_plot(x,y,tput_distance(4) ,handles.map);

                                         %16QAM 1/2  
                                         handles.tput_plot5 = tput_plot(x,y,tput_distance(5) ,handles.map);

                                         %16QAM 3/4               
                                         handles.tput_plot6= tput_plot(x,y,tput_distance(6) ,handles.map);

                                         %64QAM 1/2                                 
                                         handles.tput_plot7 = tput_plot(x,y,tput_distance(7) ,handles.map);                 

                                         %64QAM 2/3 
                                         handles.tput_plot8 = tput_plot(x,y,tput_distance(8) ,handles.map);

                                         %64QAM 3/4                 
                                         handles.tput_plot9= tput_plot(x,y,tput_distance(9) ,handles.map);

                                         %64QAM 5/6                 
                                         handles.tput_plot10= tput_plot(x,y,tput_distance(10) ,handles.map);               

                                     case '3-Ray'
                                         tput_distance = [three_ray(PL_target(1), ht, hr, freq),three_ray(PL_target(2), ht, hr, freq),three_ray(PL_target(3), ht, hr, freq)];
                                         tput_distance = tput_distance*10^-3;                 

                                         %BPSK 1/2                                 
                                         handles.tput_plot1 = tput_plot(x,y,tput_distance(1) ,handles.map);

                                         %BPSK 3/4 
                                         handles.tput_plot2 = tput_plot(x,y,tput_distance(2) ,handles.map);

                                         %QPSK 1/2             
                                         handles.tput_plot3= tput_plot(x,y,tput_distance(3) ,handles.map);

                                         %QPSK 3/4                                 
                                         handles.tput_plot4 = tput_plot(x,y,tput_distance(4) ,handles.map);

                                         %16QAM 1/2  
                                         handles.tput_plot5 = tput_plot(x,y,tput_distance(5) ,handles.map);

                                         %16QAM 3/4               
                                         handles.tput_plot6= tput_plot(x,y,tput_distance(6) ,handles.map);

                                         %64QAM 1/2                                 
                                         handles.tput_plot7 = tput_plot(x,y,tput_distance(7) ,handles.map);                 

                                         %64QAM 2/3 
                                         handles.tput_plot8 = tput_plot(x,y,tput_distance(8) ,handles.map);

                                         %64QAM 3/4                 
                                         handles.tput_plot9= tput_plot(x,y,tput_distance(9) ,handles.map);

                                         %64QAM 5/6                 
                                         handles.tput_plot10= tput_plot(x,y,tput_distance(10) ,handles.map);

                                     case 'Sea Radio-Wave Propagation Loss'
                                         tput_distance = [srwpl(PL_target(1), ht, hr, freq),srwpl(PL_target(2), ht, hr, freq),srwpl(PL_target(3), ht, hr, freq)];
                                         tput_distance = tput_distance*10^-3;                 

                                         %BPSK 1/2                                 
                                         handles.tput_plot1 = tput_plot(x,y,tput_distance(1) ,handles.map);

                                         %BPSK 3/4 
                                         handles.tput_plot2 = tput_plot(x,y,tput_distance(2) ,handles.map);

                                         %QPSK 1/2             
                                         handles.tput_plot3= tput_plot(x,y,tput_distance(3) ,handles.map);

                                         %QPSK 3/4                                 
                                         handles.tput_plot4 = tput_plot(x,y,tput_distance(4) ,handles.map);

                                         %16QAM 1/2  
                                         handles.tput_plot5 = tput_plot(x,y,tput_distance(5) ,handles.map);

                                         %16QAM 3/4               
                                         handles.tput_plot6= tput_plot(x,y,tput_distance(6) ,handles.map);

                                         %64QAM 1/2                                 
                                         handles.tput_plot7 = tput_plot(x,y,tput_distance(7) ,handles.map);                 

                                         %64QAM 2/3 
                                         handles.tput_plot8 = tput_plot(x,y,tput_distance(8) ,handles.map);

                                         %64QAM 3/4                 
                                         handles.tput_plot9= tput_plot(x,y,tput_distance(9) ,handles.map);

                                         %64QAM 5/6                 
                                         handles.tput_plot10= tput_plot(x,y,tput_distance(10) ,handles.map);
                                 end 

                             otherwise

                                 Qm = [2,4,6];
                                 Rb = ((RE_frame*Qm)/(10*10^-3)); 
                                 EbN0 = [EbN0_value(ber_target,'QPSK',channel_type),EbN0_value(ber_target,'16QAM',channel_type),EbN0_value(ber_target,'64QAM',channel_type)];

                                 SINR = EbN0.*(Rb/B_noise);         
                                 SINR_db = 10*log10(SINR);                  
                                 Pr_min = SINR_db - Interf_Noise;        
                                 PL_target = Ptx + G_ant - Cable_losses - Pr_min;                
                                 x = node_con(tx_num).node_location.longi;          
                                 y = node_con(tx_num).node_location.lati;

                                 switch link_con(link_num).channel.path_loss_model

                                     case 'FSPL'

                                         tput_distance = 10.^((PL_target-20*log10(freq*10^6)-32.44)/20);

                                         %QPSK                                  
                                         handles.tput_plot1 = tput_plot(x,y,tput_distance(1) ,handles.map);


                                         %16QAM
                                         handles.tput_plot2 = tput_plot(x,y,tput_distance(2) ,handles.map);


                                         %64QAM                 
                                         handles.tput_plot3= tput_plot(x,y,tput_distance(3) ,handles.map);

                                     case '2-Ray'

                                         tput_distance = [two_ray(PL_target(1), ht, hr, freq),two_ray(PL_target(2), ht, hr, freq),two_ray(PL_target(3), ht, hr, freq)];
                                         tput_distance = tput_distance*10^-3;

                                          %QPSK                 
                                         handles.tput_plot1 = tput_plot(x,y,tput_distance(1) ,handles.map);

                                         %16QAM
                                         handles.tput_plot2 = tput_plot(x,y,tput_distance(2) ,handles.map);

                                         %64QAM
                                         handles.tput_plot3= tput_plot(x,y,tput_distance(3) ,handles.map);                

                                     case '3-Ray'
                                         tput_distance = [three_ray(PL_target(1), ht, hr, freq),three_ray(PL_target(2), ht, hr, freq),three_ray(PL_target(3), ht, hr, freq)];
                                         tput_distance = tput_distance*10^-3;                 

                                         %QPSK                 
                                         handles.tput_plot1 = tput_plot(x,y,tput_distance(1) ,handles.map);

                                         %16QAM
                                         handles.tput_plot2 = tput_plot(x,y,tput_distance(2) ,handles.map);

                                         %64QAM
                                         handles.tput_plot3= tput_plot(x,y,tput_distance(3) ,handles.map);

                                     case 'Sea Radio-Wave Propagation Loss'
                                         tput_distance = [srwpl(PL_target(1), ht, hr, freq),srwpl(PL_target(2), ht, hr, freq),srwpl(PL_target(3), ht, hr, freq)];
                                         tput_distance = tput_distance*10^-3;                 

                                         %QPSK                 
                                         handles.tput_plot1 = tput_plot(x,y,tput_distance(1) ,handles.map);

                                         %16QAM
                                         handles.tput_plot2 = tput_plot(x,y,tput_distance(2) ,handles.map);

                                         %64QAM
                                         handles.tput_plot3= tput_plot(x,y,tput_distance(3) ,handles.map);
                                 end                
                         end


                     case 'NWR'

                         Qm = 2;
                         datarate = 520.83; 

                         Rb = 520.83; 

                         B_noise = link_con(link_num).receiver.rx_bandwidth;
                         mod_sch = 'FSK';
                         EbN0 = EbN0_value(ber_target,mod_sch,channel_type);
                         SINR = EbN0*(Rb/B_noise);
                         SINR_db = 10*log10(SINR);
                         Pr_min = SINR_db - Interf_Noise;
                         PL_target = Ptx + G_ant - Cable_losses - Pr_min;

                         x = node_con(tx_num).node_location.longi; 
                         y = node_con(tx_num).node_location.lati;

                         switch link_con(link_num).channel.path_loss_model

                                     case 'FSPL'

                                         tput_distance = 10^((PL_target-20*log10(freq*10^6)-32.44)/20);


                                         handles.tput_plotted = tput_plot(x,y,tput_distance ,handles.map);


                                     case '2-Ray'

                                         tput_distance = two_ray(PL_target, ht, hr, freq);
                                         tput_distance = tput_distance*10^-3;

                                         handles.tput_plotted = tput_plot(x,y,tput_distance ,handles.map);               

                                     case '3-Ray'
                                         tput_distance = three_ray(PL_target, ht, hr, freq);
                                         tput_distance = tput_distance*10^-3;                 

                                         handles.tput_plotted = tput_plot(x,y,tput_distance ,handles.map); 

                                     case 'Sea Radio-Wave Propagation Loss'
                                         tput_distance = srwpl(PL_target, ht, hr, freq);
                                         tput_distance = tput_distance*10^-3;                 

                                         handles.tput_plotted = tput_plot(x,y,tput_distance ,handles.map); 
                         end




                     case 'Generic'    
                         Qm = [2,4,6];
                         Rb = ((RE_frame*Qm)/(10*10^-3)); 

                         EbN0 = [EbN0_value(ber_target,'QPSK',channel_type),EbN0_value(ber_target,'16QAM',channel_type),EbN0_value(ber_target,'64QAM',channel_type)];
                         SINR = EbN0.*(Rb/B_noise);
                         SINR_db = 10*log10(SINR);

                         Pr_min = SINR_db - Interf_Noise;
                         PL_target = Ptx + G_ant - Cable_losses - Pr_min;

                         x = node_con(tx_num).node_location.longi; 
                         y = node_con(tx_num).node_location.lati;


                         switch link_con(link_num).channel.path_loss_model

                             case 'FSPL'

                                 tput_distance = 10.^((PL_target-20*log10(freq*10^6)-32.44)/20);

                                 %QPSK                 
                                 handles.tput_plot1 = tput_plot(x,y,tput_distance(1) ,handles.map);

                                 %16QAM
                                 handles.tput_plot2 = tput_plot(x,y,tput_distance(2) ,handles.map);

                                 %64QAM
                                 handles.tput_plot3= tput_plot(x,y,tput_distance(3) ,handles.map);

                             case '2-Ray'

                                 tput_distance = [two_ray(PL_target(1), ht, hr, freq),two_ray(PL_target(2), ht, hr, freq),two_ray(PL_target(3), ht, hr, freq)];
                                 tput_distance = tput_distance*10^-3;

                                  %QPSK                 
                                 handles.tput_plot1 = tput_plot(x,y,tput_distance(1) ,handles.map);

                                 %16QAM
                                 handles.tput_plot2 = tput_plot(x,y,tput_distance(2) ,handles.map);

                                 %64QAM
                                 handles.tput_plot3= tput_plot(x,y,tput_distance(3) ,handles.map);                

                             case '3-Ray'
                                 tput_distance = [three_ray(PL_target(1), ht, hr, freq),three_ray(PL_target(2), ht, hr, freq),three_ray(PL_target(3), ht, hr, freq)];
                                 tput_distance = tput_distance*10^-3;                 

                                 %QPSK                 
                                 handles.tput_plot1 = tput_plot(x,y,tput_distance(1) ,handles.map);

                                 %16QAM
                                 handles.tput_plot2 = tput_plot(x,y,tput_distance(2) ,handles.map);

                                 %64QAM
                                 handles.tput_plot3= tput_plot(x,y,tput_distance(3) ,handles.map);

                             case 'Sea Radio-Wave Propagation Loss'
                                 tput_distance = [srwpl(PL_target(1), ht, hr, freq),srwpl(PL_target(2), ht, hr, freq),srwpl(PL_target(3), ht, hr, freq)];
                                 tput_distance = tput_distance*10^-3;                 

                                 %QPSK                 
                                 handles.tput_plot1 = tput_plot(x,y,tput_distance(1) ,handles.map);

                                 %16QAM
                                 handles.tput_plot2 = tput_plot(x,y,tput_distance(2) ,handles.map);

                                 %64QAM
                                 handles.tput_plot3= tput_plot(x,y,tput_distance(3) ,handles.map);
                         end

                     otherwise


                 end

             case 2 %Prevailing Limit
                 
                 
%                  switch link_con(link_num).technology 
%     
%                      case 'DSC'
% 
%     
%                      case 'LTE-A'
%       
%            
%                      case 'NWR'
% 
%    
%                      case 'Generic'    
%         
%     
%                      otherwise
%                          
%                          
%                  end
                 
                 
      end
     
%     otherwise
%      errordlg('No configuration selected', 'Run')
end


function pl_2ray = two_ray(PL_target, ht, hr, freq)

%2-Ray Path Loss

lambda = physconst('LightSpeed')/(freq*10^6);
d_init = 0.001; %11.132; %d in meters
d = d_init;




d_losh = (sqrt(2*(6.378*(10^6))*(ht)));

fin_flag = 0;

while (fin_flag == 0)
    
    if d == d_init
        
        PL_res = -10*log10(((lambda/(4*pi*d))^2)*(2*sin((2*pi*hr*ht)/(lambda*d)))^2);
        
        value_check = PL_res - PL_target;
        value_sign = sign(value_check);
        
        d = 1;
       
    end
       
    %For graphing
%     PL_res(d) = -10*log10(((lambda/(4*pi*d))^2)*(2*sin((2*pi*hr*ht)/(lambda*d)))^2);
   
    PL_res = -10*log10(((lambda/(4*pi*d))^2)*(2*sin((2*pi*hr*ht)/(lambda*d)))^2);

    value_check = PL_res - PL_target;
    new_sign = sign(value_check);
    
    if new_sign == value_sign       
        d = d+1;
    else
        if d ==1
            narrow_d = d_init:(d_init/10):d;
            
            
            loop_max = numel(narrow_d);
            for ind = 1:loop_max
                d = narrow_d(ind);
                
                PL_res(ind) = -10*log10(((lambda/(4*pi*d))^2)*(2*sin((2*pi*hr*ht)/(lambda*d)))^2);
            end
            
            [~,i] = min(abs(PL_res-PL_target));
            d = narrow_d(i);
            
            fin_flag = 1;
            
            
        else
            
            narrow_d = (d-1):0.01:d;
            
            loop_max = numel(narrow_d);
            for ind = 1:loop_max
                d = narrow_d(ind);
                PL_res(ind) = -10*log10(((lambda/(4*pi*d))^2)*(2*sin((2*pi*hr*ht)/(lambda*d)))^2);
            end
            
            [~,i] = min(abs(PL_res-PL_target));
            d = narrow_d(i);
            
            fin_flag = 1;
        
        end        
    end
    
    if d == round(d_losh)
        fin_flag = 1;
    end
end

pl_2ray = d;





%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function pl_3ray = three_ray(PL_target, ht, hr, freq)

%3-Ray Path Loss

lambda = physconst('LightSpeed')/(freq*10^6);
d_init = 0.001; %11.132; %d in meters
d = d_init;
he = 30.5;
d_break = (4*hr*ht)/lambda;



d_losh = (sqrt(2*(6.378*(10^6))*(ht)));

fin_flag = 0;

while (fin_flag == 0)
    
    if d == d_init
        
        if (d < d_break || d == d_break)
    
            PL_res = -10*log10(((lambda/(4*pi*d))^2)*(2*sin((2*pi*hr*ht)/(lambda*d)))^2);

        elseif (d > d_break)
   
            delta = 2*sin((2*pi*hr*ht)/(lambda*d)) *2*sin((2*pi*(he-hr)*(he-ht))/(lambda*d));
            PL_res = -10*log10(((lambda/(4*pi*d))^2)*(2*(1+delta))^2);    
        end
        
        value_check = PL_res - PL_target;
        value_sign = sign(value_check);
        
        d = 1;
       
    end
    
%     %For graphing
%     if (d < d_break || d == d_break)
% 
%         PL_res(d) = -10*log10(((lambda/(4*pi*d))^2)*(2*sin((2*pi*hr*ht)/(lambda*d)))^2);
% 
%     elseif (d > d_break)
% 
%         delta = 2*sin((2*pi*hr*ht)/(lambda*d)) *2*sin((2*pi*(he-hr)*(he-ht))/(lambda*d));
%         PL_res(d) = -10*log10(((lambda/(4*pi*d))^2)*(2*(1+delta))^2);    
%     end
   

    if (d < d_break || d == d_break)

        PL_res = -10*log10(((lambda/(4*pi*d))^2)*(2*sin((2*pi*hr*ht)/(lambda*d)))^2);

    elseif (d > d_break)

        delta = 2*sin((2*pi*hr*ht)/(lambda*d)) *2*sin((2*pi*(he-hr)*(he-ht))/(lambda*d));
        PL_res = -10*log10(((lambda/(4*pi*d))^2)*(2*(1+delta))^2);    
    end

    value_check = PL_res - PL_target;
    new_sign = sign(value_check);
    
    if new_sign == value_sign       
        d = d+1;
    else
        if d ==1
            narrow_d = d_init:(d_init/10):d;
            
            
            loop_max = numel(narrow_d);
            for ind = 1:loop_max
                d = narrow_d(ind);
                
                if (d < d_break || d == d_break)

                    PL_res(ind) = -10*log10(((lambda/(4*pi*d))^2)*(2*sin((2*pi*hr*ht)/(lambda*d)))^2);

                elseif (d > d_break)

                    delta = 2*sin((2*pi*hr*ht)/(lambda*d)) *2*sin((2*pi*(he-hr)*(he-ht))/(lambda*d));
                    PL_res(ind) = -10*log10(((lambda/(4*pi*d))^2)*(2*(1+delta))^2);    
                end
            end
            
            [~,i] = min(abs(PL_res-PL_target));
            d = narrow_d(i);
            
            fin_flag = 1;
            
            
        else
            
            narrow_d = (d-1):0.01:d;
            
            loop_max = numel(narrow_d);
            for ind = 1:loop_max
                d = narrow_d(ind);
                if (d < d_break || d == d_break)

                    PL_res(ind) = -10*log10(((lambda/(4*pi*d))^2)*(2*sin((2*pi*hr*ht)/(lambda*d)))^2);

                elseif (d > d_break)

                    delta = 2*sin((2*pi*hr*ht)/(lambda*d)) *2*sin((2*pi*(he-hr)*(he-ht))/(lambda*d));
                    PL_res(ind) = -10*log10(((lambda/(4*pi*d))^2)*(2*(1+delta))^2);    
                end
            end
            
            [~,i] = min(abs(PL_res-PL_target));
            d = narrow_d(i);
            
            fin_flag = 1;
        
        end        
    end
    
    if d == round(d_losh)
        fin_flag = 1;
    end
end

pl_3ray = d;



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function pl_srwpl = srwpl(PL_target, ht, hr, freq)


lambda = physconst('LightSpeed')/(freq*10^6);
d_init = 0.001; %11.132;
d = d_init;

FSPL = 20*log10(d*10^-3)+ 20*log10(freq)+32.44; % f(MHz)  & d(km)
PL_0 = FSPL;
PL_1 = 10*log10(4*sin((2*pi*hr*ht)/(lambda*d))^2);
PL_boat = 10;
PL_earth = 0;
alpha = 5;


d_losh = (sqrt(2*(6.378*(10^6))*(ht)));

fin_flag = 0;

while (fin_flag == 0)
    
    if d == d_init
        PL_res = 20*log10(d*10^-3)+ 20*log10(freq)+32.44 + 10*log10(4*sin((2*pi*hr*ht)/(lambda*d))^2) + PL_boat + PL_earth + alpha;
        
        value_check = PL_res - PL_target;
        value_sign = sign(value_check);
        
        d = 1;
       
    end
    
%    PL_res(d) = 20*log10(d*10^-3)+ 20*log10(freq)+32.44 + 10*log10(4*sin((2*pi*hr*ht)/(lambda*d))^2) + PL_boat + PL_earth + alpha;
    PL_res = 20*log10(d*10^-3)+ 20*log10(freq)+32.44 + 10*log10(4*sin((2*pi*hr*ht)/(lambda*d))^2) + PL_boat + PL_earth + alpha;

    value_check = PL_res - PL_target;
    new_sign = sign(value_check);
    
    if new_sign == value_sign
        
        d = d+1;
    else
        if d ==1
            narrow_d = d_init:(d_init/10):d;
                        
            loop_max = numel(narrow_d);
            for ind = 1:loop_max
                d = narrow_d(ind);
                PL_res(ind) = 20*log10(d*10^-3)+ 20*log10(freq)+32.44 + 10*log10(4*sin((2*pi*hr*ht)/(lambda*d))^2) + PL_boat + PL_earth + alpha;
            end
            
            [~,i] = min(abs(PL_res-PL_target));
            d = narrow_d(i);
            
            fin_flag = 1;            
            
        else
            
            narrow_d = (d-1):0.01:d;
            
            loop_max = numel(narrow_d);
            for ind = 1:loop_max
                d = narrow_d(ind);
                PL_res(ind) = 20*log10(d)+ 20*log10(freq)+32.44 + 10*log10(4*sin((2*pi*hr*ht)/(lambda*d))^2) + PL_boat + PL_earth + alpha;
            end
            
            [~,i] = min(abs(PL_res-PL_target));
            d = narrow_d(i);
            
            fin_flag = 1;
        
        end        
    end
    
    if d == round(d_losh)
        fin_flag = 1;
    end
end
pl_srwpl = d;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function ebno_out = EbN0_value(ber_target,mod_sch,channel_type)

switch channel_type
    
    case 'AWGN'
        switch mod_sch
    
            case 'QPSK'
               
                EbN0_range =0:0.001:30; %EbN0 in db
                M = 4;

                ber = berawgn(EbN0_range,'psk',M,'nondiff'); %returns the BER of uncoded QAM over an AWGN channel with coherent demodulation. The alphabet size, M, must be at least 4. 

                [~,i] = min(abs(ber-ber_target));
                EbN0_dB = EbN0_range(i);
                ebno_out = 10^(EbN0_dB/10); % linear output 
        
            case '16QAM'
        
                EbN0_range =0:0.001:35;
                M = 16;

                ber = berawgn(EbN0_range,'qam',M);

                [~,i] = min(abs(ber-ber_target));
                EbN0_dB = EbN0_range(i);
                ebno_out = 10^(EbN0_dB/10);
        
            case '64QAM'
                EbN0_range =0:0.001:40;
                M = 64;

                ber = berawgn(EbN0_range,'qam',M);

                [~,i] = min(abs(ber-ber_target));
                EbN0_dB = EbN0_range(i);
                ebno_out = 10^(EbN0_dB/10);
        
        
            case 'FSK'  
        
                EbN0_range =0:0.01:31;
                M = 2;

                ber = berawgn(EbN0_range,'fsk',M,'coherent');%returns the BER of orthogonal uncoded FSK modulation over an AWGN channel. coherence is either 'coherent' for coherent demodulation or 'noncoherent' for noncoherent demodulation. M must be no greater than 64 for 'noncoherent'

                [~,i] = min(abs(ber-ber_target));
                EbN0_dB = EbN0_range(i);
                ebno_out = 10^(EbN0_dB/10);
         
        end
        
    case 'Rayleigh'
        switch mod_sch
    
            case 'QPSK'
                EbN0_range =0:1:75; %EbN0 in db
                M = 4;
                divorder = 1;

                ber = berfading(EbN0_range,'psk',M,divorder); %returns the BER of uncoded QAM over an AWGN channel with coherent demodulation. The alphabet size, M, must be at least 4. 

                [~,i] = min(abs(ber-ber_target));
                EbN0_dB = EbN0_range(i);
                ebno_out = 10^(EbN0_dB/10);

        
            case '16QAM'
                EbN0_range =0:1:80;
                M = 16;
                divorder = 1;

                ber = berfading(EbN0_range,'qam',M,divorder);

                [~,i] = min(abs(ber-ber_target));
                EbN0_dB = EbN0_range(i);
                ebno_out = 10^(EbN0_dB/10);
        
        
            case '64QAM'
                EbN0_range =0:1:85;
                M = 64;
                divorder = 1;

                ber = berfading(EbN0_range,'qam',M,divorder);

                [~,i] = min(abs(ber-ber_target));
                EbN0_dB = EbN0_range(i);
                ebno_out = 10^(EbN0_dB/10);

        
        
            case 'FSK'  
                EbN0_range =0:1:80;
                M = 2;
                divorder = 1;

                ber = berfading(EbN0_range,'fsk',M,divorder,'coherent');%returns the BER of orthogonal uncoded FSK modulation over an AWGN channel. coherence is either 'coherent' for coherent demodulation or 'noncoherent' for noncoherent demodulation. M must be no greater than 64 for 'noncoherent'

                [~,i] = min(abs(ber-ber_target));
                EbN0_dB = EbN0_range(i);
                ebno_out = 10^(EbN0_dB/10);
                
        end
        
end
        









