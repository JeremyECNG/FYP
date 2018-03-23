% 
%  case 1 %Link is selected
%           
%      if exist('nodesave.mat')
%          load('nodesave.mat') 
%      end
%      %Obtain user selection 
%      user_l_sel = getappdata(0, 'user_link_selection');
%      if isempty(user_l_sel) 
%          errordlg('No link selected', 'Run')
%      end    
%      
%      %Load saved link information and initialize index
%      if exist('linksave.mat')
%          load('linksave.mat') 
%          
%          for linkin = 1:save_ind_link
%              if strcmp(user_l_sel,link_con(linkin).link_name)
%                  link_num = linkin;
%              end
%          end
%          
%      else
%          errordlg('No link information available', 'Run')
%      end
%      
%      set(handles.node_display_text, 'String',link_con(link_num).link_name)
%      
%      %Determine if uplink or downlink
%      
%      switch link_con(link_num).system_params.link_direction
%          
%          case 'Downlink'
%              transmitter = link_con(link_num).node_selection.node1;
%              receiver = link_con(link_num).node_selection.node2;                       
%              
%          case 'Uplink'
%              transmitter = link_con(link_num).node_selection.node2;
%              receiver = link_con(link_num).node_selection.node1;
%              
%      end
%      
%      %Find receiver index and transmitter index
%      for nodein = 1:save_ind
%          if strcmp(transmitter,node_con(nodein).node_name)
%              tx_num = nodein;
%          end
%          
%          if strcmp(receiver,node_con(nodein).node_name)
%              rx_num = nodein;
%          end
%      end
%      
%      %Extract transmitter and receiver coordinates 
%      rx_cords = [node_con(rx_num).node_location.longi  ,node_con(rx_num).node_location.lati ];
%      tx_cords = [node_con(tx_num).node_location.longi  ,node_con(tx_num).node_location.lati ];
          
         

%       switch range_sel %Variable for determining whether a LOS or Power Limited range is to be plotted
          
          %**************************************************************************************************
          %**************************************************************************************************
           %**************************************************************************************************
            %**************************************************************************************************
            
%          case 0 %LOS
             
             %Ascertain whether the transmitter is tower mounted or mobile at sea 
             switch node_con(tx_num).node_type
                 
                 case 'Mobile at Sea'
                     
                     h_ves = 2; %Vessel selected to be maximum 2m 
                     
                     %Plot Datatips for transmitter 
                     h = findobj('Tag','gmap');
                     h = h(2);
                     makedatatip(h,[node_con(tx_num).node_location.longi  node_con(tx_num).node_location.lati])
                     
                     switch node_con(rx_num).node_type
                         
                         case 'Mobile at Sea'
                             
                             h_2 = h_ves ;
                             
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

                                h_2 = tower_tnt(find((ismember(tower_cords,closest_tower )),1)).AntennaHeight; %Height of Closest tower 
                                
                                %Plot Datatips for receiver
                                h = findobj('Tag','gmap');
                                h = h(2);
                                makedatatip(h,[closest_tower(:,1)  closest_tower(:,2)])
                                 end
                             end
                     end

                     d_losh = (sqrt(2*R*h_ves)+sqrt(2*R*h_2))/(10^3); %answer in km

                     setappdata(0,'range_dist',d_losh)
                     setappdata(0,'long_cordi',node_con(tx_num).node_location.longi); 
                     setappdata(0,'lat_cordi',node_con(tx_num).node_location.lati);
                     dlosh_cords = [node_con(tx_num).node_location.longi  node_con(tx_num).node_location.lati];
%                      plotted_range = range_plot(node_con(tx_num).node_location.longi  ,node_con(tx_num).node_location.lati  ,d_losh,handles.map);


                     euclidean_los = sqrt(sum(bsxfun(@minus, tx_cords, rx_cords).^2,2)); %find direct distance between tx and rx to find if rx is in range of tx by comparing the link lenght to the LOSH distance(radius)
                     if euclidean_los<d_losh
                         range_flag = 1;   %Signal if in range or out of range                      
                     end

                     
                     
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
                                h_ves = 2; 

                                d_losh = (sqrt(2*R*h_bs)+sqrt(2*R*h_ves))/(10^3); %answer in km
                                setappdata(0,'range_dist',d_losh)
                                setappdata(0,'long_cordi',closest_tower(:,1)); 
                                setappdata(0,'lat_cordi',closest_tower(:,2));
                                dlosh_cords = [closest_tower(:,1)  closest_tower(:,2) ];
%                                 plotted_range = range_plot(closest_tower(:,1)  ,closest_tower(:,2)  ,d_losh,handles.map);
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
                     i_am_legend = legend(handles.map,[plotted_range],{'Link LOSH'},'Location','best');
                     title(i_am_legend,'Line of Sight to Horizon Limit')
                     
                     
                     
             end
             
             
             
             
%          case 1 %Power Limited
             
             switch node_con(tx_num).node_type
                 
                 case 'Mobile at Sea'
                     ht = 2;
                     ht_cords = [node_con(tx_num).node_location.longi  ,node_con(tx_num).node_location.lati];
                     
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
                                ht_cords = [closest_tower(:,1)  ,closest_tower(:,2)]; 


                         end
                     end
                     
             end
                     
                     

             
             switch node_con(rx_num).node_type
                 
                 case 'Mobile at Sea'
                     hr = 2;
                     hr_cords = [node_con(rx_num).node_location.longi  ,node_con(rx_num).node_location.lati];
                     
                     
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
                                hr_cords = [closest_tower(:,1)  ,closest_tower(:,2)];


                         end
                     end
                     
             end
             
             %Plot Datatips for receiver
             h = findobj('Tag','gmap');
             h = h(2);
             makedatatip(h,[hr_cords(1), hr_cords(2)]) 

             %Plot Datatips for transmitter 
             h = findobj('Tag','gmap');
             h = h(2);
             makedatatip(h,[ht_cords(1), ht_cords(2)])
             
             
             set(handles.service_disp_text, 'String', link_con(link_num).node_service.service);
             set(handles.ber_display_text, 'String',link_con(link_num).node_service.ber)
             switch link_con(link_num).node_service.ber
                 
                 case '10^-2'
                     ber_target = 10^-2;
                     
                 case '10^-3'
                     ber_target = 10^-3;
                     
                 case '10^-5' 
                     ber_target = 10^-5;
                     
                 case '10^-6' 
                     ber_target = 10^-6;
                     
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

                     B_noise = link_con(link_num).receiver.rx_bandwidth*10^6;
                     mod_sch = 'FSK';
                     EbN0 = EbN0_value(ber_target,mod_sch,channel_type);
                     SINR = EbN0*(Rb/B_noise);
                     SINR_db = 10*log10(SINR);
                     Nf = node_con(rx_num).equipment_params.noise_fig;
                     k = physconst('Boltzmann');
                     T = link_con(link_num).receiver.temperature;
                     Nt = k*T*B_noise;
                     Nt_db =  10*log10(Nt)+30;   
    
                 case 'LTE-A'
                     B_sys = link_con(link_num).system_params.system_bandwidth;
                     set(handles.freq_disp_text, 'String', B_sys);
                     
                     B_sys = num2str(B_sys);
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

                     B_noise = link_con(link_num).receiver.rx_bandwidth*10^6;
                     mod_sch = 'QPSK';
                     EbN0 = EbN0_value(ber_target,mod_sch,channel_type);
                     SINR = EbN0*(Rb/B_noise);
                     SINR_db = 10*log10(SINR);
                     Nf = node_con(rx_num).equipment_params.noise_fig;
                     k = physconst('Boltzmann');
                     T = link_con(link_num).receiver.temperature;
                     Nt = k*T*B_noise;
                     Nt_db =  10*log10(Nt)+30;      
           

                 case 'NWR'
                     B_sys = link_con(link_num).system_params.system_bandwidth;
                     set(handles.freq_disp_text, 'String', B_sys);
                     

                     Qm = 2;
                     datarate = 520.83; 

                     Rb = 520.83; 

                     B_noise = link_con(link_num).receiver.rx_bandwidth*10^6;
                     mod_sch = 'FSK';
                     EbN0 = EbN0_value(ber_target,mod_sch,channel_type);
                     SINR = EbN0*(Rb/B_noise);
                     SINR_db = 10*log10(SINR);
                     Nf = node_con(rx_num).equipment_params.noise_fig;
                     k = physconst('Boltzmann');
                     T = link_con(link_num).receiver.temperature;
                     Nt = k*T*B_noise;
                     Nt_db =  10*log10(Nt)+30;    
   
                 case 'Generic'    
                     B_sys = link_con(link_num).system_params.system_bandwidth;
                     set(handles.freq_disp_text, 'String', B_sys);
                     B_sys = num2str(B_sys);
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

                     B_noise = link_con(link_num).receiver.rx_bandwidth*10^6;
                     mod_sch = 'QPSK';
                     EbN0 = EbN0_value(ber_target,mod_sch,channel_type);
                     SINR = EbN0*(Rb/B_noise);
                     SINR_db = 10*log10(SINR);
                     Nf = node_con(rx_num).equipment_params.noise_fig;
                     k = physconst('Boltzmann');
                     T = link_con(link_num).receiver.temperature;
                     Nt = k*T*B_noise;
                     Nt_db =  10*log10(Nt)+30;                                
                     
             end
             

             
             %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
             If_margin = link_con(link_num).channel.interference_margin;
             set(handles.interf_disp_text, 'String', If_margin);
             fad_margin = link_con(link_num).channel.fading_margin;
             set(handles.fade_disp_text, 'String', fad_margin);
             
             Interf_Noise = Nt_db+Nf+If_margin+fad_margin;
             
             Pr_min = SINR_db + Interf_Noise;
             
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
                       
                       plim_distance = 10^((PL_target-20*log10(freq)-32.44)/20);
                       
%                        plotted_range = range_plot(ht_cords(1), ht_cords(2)  ,plim_distance,handles.map);
                       
                   case '2-Ray'
                       set(handles.path_loss_disp_text, 'String', link_con(link_num).channel.path_loss_model);

                       plim_distance =two_ray(PL_target, ht, hr, freq)*10^-3;
                       
%                        plotted_range = range_plot(ht_cords(1), ht_cords(2)  ,plim_distance,handles.map);                       
        

        
                   case '3-Ray'
                       set(handles.path_loss_disp_text, 'String', link_con(link_num).channel.path_loss_model);
                       
                       plim_distance =three_ray(PL_target, ht, hr, freq)*10^-3;
                       
%                        plotted_range = range_plot(ht_cords(1), ht_cords(2)  ,plim_distance,handles.map);       


                   case 'Sea Radio-Wave Propagation Loss'
                       set(handles.path_loss_disp_text, 'String', link_con(link_num).channel.path_loss_model);
                       
                       plim_distance = srwpl(PL_target, ht, hr, freq)*10^-3;
        
%                        plotted_range = range_plot(ht_cords(1), ht_cords(2)  ,plim_distance,handles.map);
               end
               
               set(handles.range_display_text, 'String',plim_distance) 
               set(handles.techno_disp_text, 'String',link_con(link_num).technology ) 
               
                switch link_con(link_num).technology 

                    case 'DSC'
                         Qm = 2;
                         datarate = 1200; 

                         Rb = datarate ; 

                         mod_sch = 'FSK';
                         EbN0 = EbN0_value(ber_target,mod_sch,channel_type);
                         SINR = EbN0*(Rb/B_noise);
                         SINR_db = 10*log10(SINR);
                         Pr_min = SINR_db + Interf_Noise;
                         PL_target = Ptx + G_ant - Cable_losses - Pr_min;
                         x = ht_cords(1);  
                         y = ht_cords(2);
                         
                         dsc_throughput = 1200; %bps
                         set(handles.throughput_display_text, 'String',(dsc_throughput*10^-6)) 

                         switch link_con(link_num).channel.path_loss_model

                                     case 'FSPL'

                                         tput_distance = 10^((PL_target-20*log10(freq)-32.44)/20);
                                         
                                         if dlosh > tput_distance(1)

                                         colour = 'b';
                                         handles.tput_plot1 = tput_plot(x,y,tput_distance ,handles.map,colour);
                                         txt1 = [ num2str(dsc_throughput) ' bps' ' (FSK)']; 
                                         i_am_legend = legend(handles.map,[handles.tput_plot1],{txt1},'Location','best');
                                         title(i_am_legend,'DSC Throuput per Mod. Sch.') 
                                         
                                         set(handles.range_display_text, 'String',tput_distance)
                                         
                                         end


                                     case '2-Ray'
                                         
                                         

                                         tput_distance = two_ray(PL_target, ht, hr, freq);
                                         tput_distance = tput_distance*10^-3;
                                         
                                         if dlosh > tput_distance(1)

                                         colour = 'b';
                                         handles.tput_plot1 = tput_plot(x,y,tput_distance ,handles.map,colour);
                                         txt1 = [ num2str(dsc_throughput) ' bps' ' (FSK)']; 
                                         i_am_legend = legend(handles.map,[handles.tput_plot1],{txt1},'Location','best');
                                         title(i_am_legend,'DSC Throuput per Mod. Sch.') 
                                         
                                         set(handles.range_display_text, 'String',tput_distance)
                                         
                                         end


                                     case '3-Ray'
                                         tput_distance = three_ray(PL_target, ht, hr, freq);
                                         tput_distance = tput_distance*10^-3;   
                                         
                                         if dlosh > tput_distance(1)

                                         colour = 'b';
                                         handles.tput_plot1 = tput_plot(x,y,tput_distance ,handles.map,colour);
                                         txt1 = [ num2str(dsc_throughput) ' bps' ' (FSK)']; 
                                         i_am_legend = legend(handles.map,[handles.tput_plot1],{txt1},'Location','best');
                                         title(i_am_legend,'DSC Throuput per Mod. Sch.') 
                                         
                                         set(handles.range_display_text, 'String',tput_distance)
                                         
                                         end


                                     case 'Sea Radio-Wave Propagation Loss'
                                         tput_distance = srwpl(PL_target, ht, hr, freq);
                                         tput_distance = tput_distance*10^-3;  
                                         
                                         if dlosh > tput_distance(1)

                                         colour = 'b';
                                         handles.tput_plot1 = tput_plot(x,y,tput_distance ,handles.map,colour);
                                         txt1 = [ num2str(dsc_throughput) ' bps' ' (FSK)']; 
                                         i_am_legend = legend(handles.map,[handles.tput_plot1],{txt1},'Location','best');
                                         title(i_am_legend,'DSC Throuput per Mod. Sch.') 
                                         
                                         set(handles.range_display_text, 'String',tput_distance)
                                         
                                         end

                         end



                     case 'LTE-A'
                         
                         B_sys = link_con(link_num).system_params.system_bandwidth;
                         B_sys = num2str(B_sys);
                         switch B_sys


                             case '1.4'
                                 PDSCH_RE_frame = 4912; %Extended CP, CFI = 3, BW = 1.4 MHz

                             case '3'
                                 PDSCH_RE_frame = 14812; %Extended CP, CFI = 3

                             case '5'
                                 PDSCH_RE_frame = 25012; %Extended CP, CFI = 3

                             case '10'
                                 PDSCH_RE_frame = 50512; %Extended CP, CFI = 3

                             case '15'
                                 PDSCH_RE_frame = 76012; %Extended CP, CFI = 3

                             case '20'
                                 PDSCH_RE_frame = 101512; %Extended CP, CFI = 3
                         end
                         


                         switch link_con(link_num).node_service.ber

                             case '10^-3'
                                 Qm = [1,1,2,2,4,4,6,6,6,6];
                                 code = ["1/2","3/4","1/2","3/4","1/2","3/4","1/2","2/3","3/4","5/6"];
                                 %Rb = ((RE_frame*Qm)/(10*10^-3)); 
                                 %EbN0 = [EbN0_value(ber_target,'QPSK',channel_type),EbN0_value(ber_target,'16QAM',channel_type),EbN0_value(ber_target,'64QAM',channel_type)];

                                 %SINR = EbN0.*(Rb/B_noise);         
                                 %SINR_db = 10*log10(SINR); 
                                 code_rate = [1/2,3/4,1/2,3/4,1/2,3/4,1/2,2/3,3/4,5/6];
                                 phy_tput_frame = ((((PDSCH_RE_frame*Qm)/(10*10^-3))).*code_rate)/10^6; %Mbps
                                 phy_tput_frame  = round(phy_tput_frame,2);
                                 set(handles.throughput_display_text, 'String',phy_tput_frame(1))
                                 
                                 
                                 switch channel_type
                                     
                                     case 'AWGN'
                                         SINR_db = [0,3.3,3,6.3,9.5,13,13.7,16.9,17.7,18.5];
                                     case 'Rayleigh'
                                         SINR_db = [14.54,19.16,17.54,22.16,23.6,28.5,26.36,30.84,31.96,33.08];                                       
                                 end
                                 
                                 Pr_min = SINR_db + Interf_Noise;        
                                 PL_target = Ptx + G_ant - Cable_losses - Pr_min;                
                                 x = ht_cords(1);          
                                 y = ht_cords(2);

                                 switch link_con(link_num).channel.path_loss_model

                                     case 'FSPL'

                                         tput_distance = 10.^((PL_target-20*log10(freq)-32.44)/20);
                                         
                                         if dlosh > tput_distance(1)
                                         
                                         set(handles.range_display_text, 'String',tput_distance(1)) 
%                                          
                                         colour = 'y'; 
                                         %BPSK 1/2                                 
                                         handles.tput_plot1 = tput_plot(x,y,tput_distance(1) ,handles.map,colour);
                                         txt1 = [ num2str(phy_tput_frame(1)) ' Mbps' ' (BPSK 1/2)']; 
                                         
                                         
                                         colour = [216/255 133/255 49/255]; 
                                         %BPSK 3/4 
                                         handles.tput_plot2 = tput_plot(x,y,tput_distance(2) ,handles.map,colour);
                                         txt2 = [num2str(phy_tput_frame(2)) ' Mbps' ' (BPSK 3/4)'];

                                         colour = [7/255 164/255 18/255]; 
                                         %QPSK 1/2             
                                         handles.tput_plot3= tput_plot(x,y,tput_distance(3) ,handles.map,colour);
                                         txt3 = [num2str(phy_tput_frame(3)) ' Mbps' ' (QPSK 1/2)'];

                                         colour = [116/255 11/255 128/255]; 
                                         %QPSK 3/4                                 
                                         handles.tput_plot4 = tput_plot(x,y,tput_distance(4) ,handles.map,colour);
                                         txt4 = [num2str(phy_tput_frame(4)) ' Mbps' ' (QPSK 3/4)'];

                                         colour = 'c'; 
                                         %16QAM 1/2  
                                         handles.tput_plot5 = tput_plot(x,y,tput_distance(5) ,handles.map,colour);
                                         txt5 = [num2str(phy_tput_frame(5)) ' Mbps' ' (16QAM 1/2)'];

                                         colour = 'b'; 
                                         %16QAM 3/4               
                                         handles.tput_plot6= tput_plot(x,y,tput_distance(6) ,handles.map,colour);
                                         txt6 = [num2str(phy_tput_frame(6)) ' Mbps' ' (16QAM 3/4)'];

                                         colour = 'm'; 
                                         %64QAM 1/2                                 
                                         handles.tput_plot7 = tput_plot(x,y,tput_distance(7) ,handles.map,colour); 
                                         txt7 = [num2str(phy_tput_frame(7)) ' Mbps' ' (64QAM 1/2)'];

                                         colour = 'g';
                                         %64QAM 2/3 
                                         handles.tput_plot8 = tput_plot(x,y,tput_distance(8) ,handles.map,colour);
                                         txt8 = [num2str(phy_tput_frame(8)) ' Mbps' ' (64QAM 2/3)'];

                                         colour = [243/255 197/255 91/255]; 
                                         %64QAM 3/4                 
                                         handles.tput_plot9= tput_plot(x,y,tput_distance(9) ,handles.map,colour);
                                         txt9 = [num2str(phy_tput_frame(9)) ' Mbps' ' (64QAM 3/4)'];

                                         colour = [127/255 0/255 255/255];
                                         %64QAM 5/6                 
                                         handles.tput_plot10= tput_plot(x,y,tput_distance(10) ,handles.map,colour);
                                         txt10 = [num2str(phy_tput_frame(10)) ' Mbps' ' (64QAM 5/6)'];
                                     
%                                          i_am_legend = legend(handles.map,[plotted_range,handles.tput_plot1,handles.tput_plot2,handles.tput_plot3,handles.tput_plot4,handles.tput_plot5,handles.tput_plot6,handles.tput_plot7,handles.tput_plot8,handles.tput_plot9,handles.tput_plot10],{'Power Limited Range','BPSK 1/2','BPSK 3/4','QPSK 1/2','QPSK 3/4','16QAM 1/2','16QAM 3/4','64QAM 1/2','64QAM 2/3','64QAM 3/4','64QAM 5/6'})
                                         %i_am_legend = legend(handles.map,[handles.tput_plot1,handles.tput_plot2,handles.tput_plot3,handles.tput_plot4,handles.tput_plot5,handles.tput_plot6,handles.tput_plot7,handles.tput_plot8,handles.tput_plot9,handles.tput_plot10],{'BPSK 1/2','BPSK 3/4','QPSK 1/2','QPSK 3/4','16QAM 1/2','16QAM 3/4','64QAM 1/2','64QAM 2/3','64QAM 3/4','64QAM 5/6'})
                                         i_am_legend = legend(handles.map,[handles.tput_plot1,handles.tput_plot2,handles.tput_plot3,handles.tput_plot4,handles.tput_plot5,handles.tput_plot6,handles.tput_plot7,handles.tput_plot8,handles.tput_plot9,handles.tput_plot10],{txt1,txt2,txt3,txt4,txt5,txt6,txt7,txt8,txt9,txt10},'Location','best');
                                         title(i_am_legend,'LTE PHY Throuput per MCS')
                                         
                                         end

                                     case '2-Ray'

                                         tput_distance = [two_ray(PL_target(1), ht, hr, freq),two_ray(PL_target(2), ht, hr, freq),two_ray(PL_target(3), ht, hr, freq),two_ray(PL_target(4), ht, hr, freq),two_ray(PL_target(5), ht, hr, freq),two_ray(PL_target(6), ht, hr, freq),two_ray(PL_target(7), ht, hr, freq),two_ray(PL_target(8), ht, hr, freq),two_ray(PL_target(9), ht, hr, freq),two_ray(PL_target(10), ht, hr, freq)];
                                         tput_distance = tput_distance*10^-3;
                                         
                                         if dlosh > tput_distance(1)

                                         set(handles.range_display_text, 'String',tput_distance(1)) 
                                          
                                         colour = 'y'; 
                                         %BPSK 1/2                                 
                                         handles.tput_plot1 = tput_plot(x,y,tput_distance(1) ,handles.map,colour);
                                         txt1 = [ num2str(phy_tput_frame(1)) ' Mbps' ' (BPSK 1/2)']; 
                                         
                                         colour = [216/255 133/255 49/255]; 
                                         %BPSK 3/4 
                                         handles.tput_plot2 = tput_plot(x,y,tput_distance(2) ,handles.map,colour);
                                         txt2 = [num2str(phy_tput_frame(2)) ' Mbps' ' (BPSK 3/4)'];

                                         colour = [7/255 164/255 18/255]; 
                                         %QPSK 1/2             
                                         handles.tput_plot3= tput_plot(x,y,tput_distance(3) ,handles.map,colour);
                                         txt3 = [num2str(phy_tput_frame(3)) ' Mbps' ' (QPSK 1/2)'];

                                         colour = [116/255 11/255 128/255]; 
                                         %QPSK 3/4                                 
                                         handles.tput_plot4 = tput_plot(x,y,tput_distance(4) ,handles.map,colour);
                                         txt4 = [num2str(phy_tput_frame(4)) ' Mbps' ' (QPSK 3/4)'];

                                         colour = 'c'; 
                                         %16QAM 1/2  
                                         handles.tput_plot5 = tput_plot(x,y,tput_distance(5) ,handles.map,colour);
                                         txt5 = [num2str(phy_tput_frame(5)) ' Mbps' ' (16QAM 1/2)'];

                                         colour = 'b'; 
                                         %16QAM 3/4               
                                         handles.tput_plot6= tput_plot(x,y,tput_distance(6) ,handles.map,colour);
                                         txt6 = [num2str(phy_tput_frame(6)) ' Mbps' ' (16QAM 3/4)'];

                                         colour = 'm'; 
                                         %64QAM 1/2                                 
                                         handles.tput_plot7 = tput_plot(x,y,tput_distance(7) ,handles.map,colour); 
                                         txt7 = [num2str(phy_tput_frame(7)) ' Mbps' ' (64QAM 1/2)'];

                                         colour = 'g';
                                         %64QAM 2/3 
                                         handles.tput_plot8 = tput_plot(x,y,tput_distance(8) ,handles.map,colour);
                                         txt8 = [num2str(phy_tput_frame(8)) ' Mbps' ' (64QAM 2/3)'];

                                         colour = [243/255 197/255 91/255]; 
                                         %64QAM 3/4                 
                                         handles.tput_plot9= tput_plot(x,y,tput_distance(9) ,handles.map,colour);
                                         txt9 = [num2str(phy_tput_frame(9)) ' Mbps' ' (64QAM 3/4)'];

                                         colour = [127/255 0/255 255/255];
                                         %64QAM 5/6                 
                                         handles.tput_plot10= tput_plot(x,y,tput_distance(10) ,handles.map,colour);
                                         txt10 = [num2str(phy_tput_frame(10)) ' Mbps' ' (64QAM 5/6)'];
                                     
                                         i_am_legend = legend(handles.map,[handles.tput_plot1,handles.tput_plot2,handles.tput_plot3,handles.tput_plot4,handles.tput_plot5,handles.tput_plot6,handles.tput_plot7,handles.tput_plot8,handles.tput_plot9,handles.tput_plot10],{txt1,txt2,txt3,txt4,txt5,txt6,txt7,txt8,txt9,txt10},'Location','best');
                                         title(i_am_legend,'LTE PHY Throuput per MCS') 
                                         
                                         end

                                     case '3-Ray'
                                         tput_distance = [three_ray(PL_target(1), ht, hr, freq),three_ray(PL_target(2), ht, hr, freq),three_ray(PL_target(3), ht, hr, freq),three_ray(PL_target(4), ht, hr, freq),three_ray(PL_target(5), ht, hr, freq),three_ray(PL_target(6), ht, hr, freq),three_ray(PL_target(7), ht, hr, freq),three_ray(PL_target(8), ht, hr, freq),three_ray(PL_target(9), ht, hr, freq),three_ray(PL_target(10), ht, hr, freq)];
                                         tput_distance = tput_distance*10^-3;      
                                         
                                         if dlosh > tput_distance(1)

                                         set(handles.range_display_text, 'String',tput_distance(1)) 
                                         
                                         colour = 'y'; 
                                         %BPSK 1/2                                 
                                         handles.tput_plot1 = tput_plot(x,y,tput_distance(1) ,handles.map,colour);
                                         txt1 = [ num2str(phy_tput_frame(1)) ' Mbps' ' (BPSK 1/2)']; 
                                         
                                         colour = [216/255 133/255 49/255]; 
                                         %BPSK 3/4 
                                         handles.tput_plot2 = tput_plot(x,y,tput_distance(2) ,handles.map,colour);
                                         txt2 = [num2str(phy_tput_frame(2)) ' Mbps' ' (BPSK 3/4)'];

                                         colour = [7/255 164/255 18/255]; 
                                         %QPSK 1/2             
                                         handles.tput_plot3= tput_plot(x,y,tput_distance(3) ,handles.map,colour);
                                         txt3 = [num2str(phy_tput_frame(3)) ' Mbps' ' (QPSK 1/2)'];

                                         colour = [116/255 11/255 128/255]; 
                                         %QPSK 3/4                                 
                                         handles.tput_plot4 = tput_plot(x,y,tput_distance(4) ,handles.map,colour);
                                         txt4 = [num2str(phy_tput_frame(4)) ' Mbps' ' (QPSK 3/4)'];

                                         colour = 'c'; 
                                         %16QAM 1/2  
                                         handles.tput_plot5 = tput_plot(x,y,tput_distance(5) ,handles.map,colour);
                                         txt5 = [num2str(phy_tput_frame(5)) ' Mbps' ' (16QAM 1/2)'];

                                         colour = 'b'; 
                                         %16QAM 3/4               
                                         handles.tput_plot6= tput_plot(x,y,tput_distance(6) ,handles.map,colour);
                                         txt6 = [num2str(phy_tput_frame(6)) ' Mbps' ' (16QAM 3/4)'];

                                         colour = 'm'; 
                                         %64QAM 1/2                                 
                                         handles.tput_plot7 = tput_plot(x,y,tput_distance(7) ,handles.map,colour); 
                                         txt7 = [num2str(phy_tput_frame(7)) ' Mbps' ' (64QAM 1/2)'];

                                         colour = 'g';
                                         %64QAM 2/3 
                                         handles.tput_plot8 = tput_plot(x,y,tput_distance(8) ,handles.map,colour);
                                         txt8 = [num2str(phy_tput_frame(8)) ' Mbps' ' (64QAM 2/3)'];

                                         colour = [243/255 197/255 91/255]; 
                                         %64QAM 3/4                 
                                         handles.tput_plot9= tput_plot(x,y,tput_distance(9) ,handles.map,colour);
                                         txt9 = [num2str(phy_tput_frame(9)) ' Mbps' ' (64QAM 3/4)'];

                                         colour = [127/255 0/255 255/255];
                                         %64QAM 5/6                 
                                         handles.tput_plot10= tput_plot(x,y,tput_distance(10) ,handles.map,colour);
                                         txt10 = [num2str(phy_tput_frame(10)) ' Mbps' ' (64QAM 5/6)'];
                                     
                                         i_am_legend = legend(handles.map,[handles.tput_plot1,handles.tput_plot2,handles.tput_plot3,handles.tput_plot4,handles.tput_plot5,handles.tput_plot6,handles.tput_plot7,handles.tput_plot8,handles.tput_plot9,handles.tput_plot10],{txt1,txt2,txt3,txt4,txt5,txt6,txt7,txt8,txt9,txt10},'Location','best');
                                         title(i_am_legend,'LTE PHY Throuput per MCS')  
                                         
                                         end

                                     case 'Sea Radio-Wave Propagation Loss'
                                         tput_distance = [srwpl(PL_target(1), ht, hr, freq),srwpl(PL_target(2), ht, hr, freq),srwpl(PL_target(3), ht, hr, freq),srwpl(PL_target(4), ht, hr, freq),srwpl(PL_target(5), ht, hr, freq),srwpl(PL_target(6), ht, hr, freq),srwpl(PL_target(7), ht, hr, freq),srwpl(PL_target(8), ht, hr, freq),srwpl(PL_target(9), ht, hr, freq),srwpl(PL_target(10), ht, hr, freq)];
                                         tput_distance = tput_distance*10^-3;       
                                         
                                         if dlosh > tput_distance(1)

                                         set(handles.range_display_text, 'String',tput_distance(1)) 
                                         
                                         colour = 'y'; 
                                         %BPSK 1/2                                 
                                         handles.tput_plot1 = tput_plot(x,y,tput_distance(1) ,handles.map,colour);
                                         txt1 = [ num2str(phy_tput_frame(1)) ' Mbps' ' (BPSK 1/2)']; 
                                         
                                         colour = [216/255 133/255 49/255]; 
                                         %BPSK 3/4 
                                         handles.tput_plot2 = tput_plot(x,y,tput_distance(2) ,handles.map,colour);
                                         txt2 = [num2str(phy_tput_frame(2)) ' Mbps' ' (BPSK 3/4)'];

                                         colour = [7/255 164/255 18/255]; 
                                         %QPSK 1/2             
                                         handles.tput_plot3= tput_plot(x,y,tput_distance(3) ,handles.map,colour);
                                         txt3 = [num2str(phy_tput_frame(3)) ' Mbps' ' (QPSK 1/2)'];

                                         colour = [116/255 11/255 128/255]; 
                                         %QPSK 3/4                                 
                                         handles.tput_plot4 = tput_plot(x,y,tput_distance(4) ,handles.map,colour);
                                         txt4 = [num2str(phy_tput_frame(4)) ' Mbps' ' (QPSK 3/4)'];

                                         colour = 'c'; 
                                         %16QAM 1/2  
                                         handles.tput_plot5 = tput_plot(x,y,tput_distance(5) ,handles.map,colour);
                                         txt5 = [num2str(phy_tput_frame(5)) ' Mbps' ' (16QAM 1/2)'];

                                         colour = 'b'; 
                                         %16QAM 3/4               
                                         handles.tput_plot6= tput_plot(x,y,tput_distance(6) ,handles.map,colour);
                                         txt6 = [num2str(phy_tput_frame(6)) ' Mbps' ' (16QAM 3/4)'];

                                         colour = 'm'; 
                                         %64QAM 1/2                                 
                                         handles.tput_plot7 = tput_plot(x,y,tput_distance(7) ,handles.map,colour); 
                                         txt7 = [num2str(phy_tput_frame(7)) ' Mbps' ' (64QAM 1/2)'];

                                         colour = 'g';
                                         %64QAM 2/3 
                                         handles.tput_plot8 = tput_plot(x,y,tput_distance(8) ,handles.map,colour);
                                         txt8 = [num2str(phy_tput_frame(8)) ' Mbps' ' (64QAM 2/3)'];

                                         colour = [243/255 197/255 91/255]; 
                                         %64QAM 3/4                 
                                         handles.tput_plot9= tput_plot(x,y,tput_distance(9) ,handles.map,colour);
                                         txt9 = [num2str(phy_tput_frame(9)) ' Mbps' ' (64QAM 3/4)'];

                                         colour = [127/255 0/255 255/255];
                                         %64QAM 5/6                 
                                         handles.tput_plot10= tput_plot(x,y,tput_distance(10) ,handles.map,colour);
                                         txt10 = [num2str(phy_tput_frame(10)) ' Mbps' ' (64QAM 5/6)'];
                                     
                                         i_am_legend = legend(handles.map,[handles.tput_plot1,handles.tput_plot2,handles.tput_plot3,handles.tput_plot4,handles.tput_plot5,handles.tput_plot6,handles.tput_plot7,handles.tput_plot8,handles.tput_plot9,handles.tput_plot10],{txt1,txt2,txt3,txt4,txt5,txt6,txt7,txt8,txt9,txt10},'Location','best');
                                         title(i_am_legend,'LTE PHY Throuput per MCS')  
                                         
                                         end
                                 end 
                                 
                             case '10^-6'
                                 Qm = [1,1,2,2,4,4,6,6,6,6];
                                 code = ["1/2","3/4","1/2","3/4","1/2","3/4","1/2","2/3","3/4","5/6"];
                                 %Rb = ((RE_frame*Qm)/(10*10^-3)); 
                                 %EbN0 = [EbN0_value(ber_target,'QPSK',channel_type),EbN0_value(ber_target,'16QAM',channel_type),EbN0_value(ber_target,'64QAM',channel_type)];

                                 %SINR = EbN0.*(Rb/B_noise);         
                                 %SINR_db = 10*log10(SINR); 
                                 code_rate = [1/2,3/4,1/2,3/4,1/2,3/4,1/2,2/3,3/4,5/6];
                                 phy_tput_frame = ((((PDSCH_RE_frame*Qm)/(10*10^-3))).*code_rate)/10^6; %Mbps
                                 phy_tput_frame  = round(phy_tput_frame,2);
                                 set(handles.throughput_display_text, 'String',phy_tput_frame(1))
                                 
                                 
                                 switch channel_type
                                     
                                     case 'AWGN'
                                         SINR_db = [1.5,5.7,4.5,8.7,12.5,15.4,16.1,19.3,20.1,20.9];
                                     case 'Rayleigh'
                                         SINR_db = [35,43.4,38,46.4,46,51.8,46.6,53,54.6,56.2];                                       
                                 end
                                 
                                 Pr_min = SINR_db + Interf_Noise;        
                                 PL_target = Ptx + G_ant - Cable_losses - Pr_min;                
                                 x = ht_cords(1);          
                                 y = ht_cords(2);

                                 switch link_con(link_num).channel.path_loss_model

                                     case 'FSPL'

                                         tput_distance = 10.^((PL_target-20*log10(freq)-32.44)/20);
                                         
                                         if dlosh > tput_distance(1)
                                         
                                         set(handles.range_display_text, 'String',tput_distance(1)) 
%                                          
                                         colour = 'y'; 
                                         %BPSK 1/2                                 
                                         handles.tput_plot1 = tput_plot(x,y,tput_distance(1) ,handles.map,colour);
                                         txt1 = [ num2str(phy_tput_frame(1)) ' Mbps' ' (BPSK 1/2)']; 
                                         
                                         
                                         colour = [216/255 133/255 49/255]; 
                                         %BPSK 3/4 
                                         handles.tput_plot2 = tput_plot(x,y,tput_distance(2) ,handles.map,colour);
                                         txt2 = [num2str(phy_tput_frame(2)) ' Mbps' ' (BPSK 3/4)'];

                                         colour = [7/255 164/255 18/255]; 
                                         %QPSK 1/2             
                                         handles.tput_plot3= tput_plot(x,y,tput_distance(3) ,handles.map,colour);
                                         txt3 = [num2str(phy_tput_frame(3)) ' Mbps' ' (QPSK 1/2)'];

                                         colour = [116/255 11/255 128/255]; 
                                         %QPSK 3/4                                 
                                         handles.tput_plot4 = tput_plot(x,y,tput_distance(4) ,handles.map,colour);
                                         txt4 = [num2str(phy_tput_frame(4)) ' Mbps' ' (QPSK 3/4)'];

                                         colour = 'c'; 
                                         %16QAM 1/2  
                                         handles.tput_plot5 = tput_plot(x,y,tput_distance(5) ,handles.map,colour);
                                         txt5 = [num2str(phy_tput_frame(5)) ' Mbps' ' (16QAM 1/2)'];

                                         colour = 'b'; 
                                         %16QAM 3/4               
                                         handles.tput_plot6= tput_plot(x,y,tput_distance(6) ,handles.map,colour);
                                         txt6 = [num2str(phy_tput_frame(6)) ' Mbps' ' (16QAM 3/4)'];

                                         colour = 'm'; 
                                         %64QAM 1/2                                 
                                         handles.tput_plot7 = tput_plot(x,y,tput_distance(7) ,handles.map,colour); 
                                         txt7 = [num2str(phy_tput_frame(7)) ' Mbps' ' (64QAM 1/2)'];

                                         colour = 'g';
                                         %64QAM 2/3 
                                         handles.tput_plot8 = tput_plot(x,y,tput_distance(8) ,handles.map,colour);
                                         txt8 = [num2str(phy_tput_frame(8)) ' Mbps' ' (64QAM 2/3)'];

                                         colour = [243/255 197/255 91/255]; 
                                         %64QAM 3/4                 
                                         handles.tput_plot9= tput_plot(x,y,tput_distance(9) ,handles.map,colour);
                                         txt9 = [num2str(phy_tput_frame(9)) ' Mbps' ' (64QAM 3/4)'];

                                         colour = [127/255 0/255 255/255];
                                         %64QAM 5/6                 
                                         handles.tput_plot10= tput_plot(x,y,tput_distance(10) ,handles.map,colour);
                                         txt10 = [num2str(phy_tput_frame(10)) ' Mbps' ' (64QAM 5/6)'];
                                     
%                                          i_am_legend = legend(handles.map,[plotted_range,handles.tput_plot1,handles.tput_plot2,handles.tput_plot3,handles.tput_plot4,handles.tput_plot5,handles.tput_plot6,handles.tput_plot7,handles.tput_plot8,handles.tput_plot9,handles.tput_plot10],{'Power Limited Range','BPSK 1/2','BPSK 3/4','QPSK 1/2','QPSK 3/4','16QAM 1/2','16QAM 3/4','64QAM 1/2','64QAM 2/3','64QAM 3/4','64QAM 5/6'})
                                         %i_am_legend = legend(handles.map,[handles.tput_plot1,handles.tput_plot2,handles.tput_plot3,handles.tput_plot4,handles.tput_plot5,handles.tput_plot6,handles.tput_plot7,handles.tput_plot8,handles.tput_plot9,handles.tput_plot10],{'BPSK 1/2','BPSK 3/4','QPSK 1/2','QPSK 3/4','16QAM 1/2','16QAM 3/4','64QAM 1/2','64QAM 2/3','64QAM 3/4','64QAM 5/6'})
                                         i_am_legend = legend(handles.map,[handles.tput_plot1,handles.tput_plot2,handles.tput_plot3,handles.tput_plot4,handles.tput_plot5,handles.tput_plot6,handles.tput_plot7,handles.tput_plot8,handles.tput_plot9,handles.tput_plot10],{txt1,txt2,txt3,txt4,txt5,txt6,txt7,txt8,txt9,txt10},'Location','best');
                                         title(i_am_legend,'LTE PHY Throuput per MCS')
                                         
                                         end

                                     case '2-Ray'

                                         tput_distance = [two_ray(PL_target(1), ht, hr, freq),two_ray(PL_target(2), ht, hr, freq),two_ray(PL_target(3), ht, hr, freq),two_ray(PL_target(4), ht, hr, freq),two_ray(PL_target(5), ht, hr, freq),two_ray(PL_target(6), ht, hr, freq),two_ray(PL_target(7), ht, hr, freq),two_ray(PL_target(8), ht, hr, freq),two_ray(PL_target(9), ht, hr, freq),two_ray(PL_target(10), ht, hr, freq)];
                                         tput_distance = tput_distance*10^-3;
                                         
                                         if dlosh > tput_distance(1)

                                         set(handles.range_display_text, 'String',tput_distance(1)) 
                                          
                                         colour = 'y'; 
                                         %BPSK 1/2                                 
                                         handles.tput_plot1 = tput_plot(x,y,tput_distance(1) ,handles.map,colour);
                                         txt1 = [ num2str(phy_tput_frame(1)) ' Mbps' ' (BPSK 1/2)']; 
                                         
                                         colour = [216/255 133/255 49/255]; 
                                         %BPSK 3/4 
                                         handles.tput_plot2 = tput_plot(x,y,tput_distance(2) ,handles.map,colour);
                                         txt2 = [num2str(phy_tput_frame(2)) ' Mbps' ' (BPSK 3/4)'];

                                         colour = [7/255 164/255 18/255]; 
                                         %QPSK 1/2             
                                         handles.tput_plot3= tput_plot(x,y,tput_distance(3) ,handles.map,colour);
                                         txt3 = [num2str(phy_tput_frame(3)) ' Mbps' ' (QPSK 1/2)'];

                                         colour = [116/255 11/255 128/255]; 
                                         %QPSK 3/4                                 
                                         handles.tput_plot4 = tput_plot(x,y,tput_distance(4) ,handles.map,colour);
                                         txt4 = [num2str(phy_tput_frame(4)) ' Mbps' ' (QPSK 3/4)'];

                                         colour = 'c'; 
                                         %16QAM 1/2  
                                         handles.tput_plot5 = tput_plot(x,y,tput_distance(5) ,handles.map,colour);
                                         txt5 = [num2str(phy_tput_frame(5)) ' Mbps' ' (16QAM 1/2)'];

                                         colour = 'b'; 
                                         %16QAM 3/4               
                                         handles.tput_plot6= tput_plot(x,y,tput_distance(6) ,handles.map,colour);
                                         txt6 = [num2str(phy_tput_frame(6)) ' Mbps' ' (16QAM 3/4)'];

                                         colour = 'm'; 
                                         %64QAM 1/2                                 
                                         handles.tput_plot7 = tput_plot(x,y,tput_distance(7) ,handles.map,colour); 
                                         txt7 = [num2str(phy_tput_frame(7)) ' Mbps' ' (64QAM 1/2)'];

                                         colour = 'g';
                                         %64QAM 2/3 
                                         handles.tput_plot8 = tput_plot(x,y,tput_distance(8) ,handles.map,colour);
                                         txt8 = [num2str(phy_tput_frame(8)) ' Mbps' ' (64QAM 2/3)'];

                                         colour = [243/255 197/255 91/255]; 
                                         %64QAM 3/4                 
                                         handles.tput_plot9= tput_plot(x,y,tput_distance(9) ,handles.map,colour);
                                         txt9 = [num2str(phy_tput_frame(9)) ' Mbps' ' (64QAM 3/4)'];

                                         colour = [127/255 0/255 255/255];
                                         %64QAM 5/6                 
                                         handles.tput_plot10= tput_plot(x,y,tput_distance(10) ,handles.map,colour);
                                         txt10 = [num2str(phy_tput_frame(10)) ' Mbps' ' (64QAM 5/6)'];
                                     
                                         i_am_legend = legend(handles.map,[handles.tput_plot1,handles.tput_plot2,handles.tput_plot3,handles.tput_plot4,handles.tput_plot5,handles.tput_plot6,handles.tput_plot7,handles.tput_plot8,handles.tput_plot9,handles.tput_plot10],{txt1,txt2,txt3,txt4,txt5,txt6,txt7,txt8,txt9,txt10},'Location','best');
                                         title(i_am_legend,'LTE PHY Throuput per MCS')   
                                         
                                         end

                                     case '3-Ray'
                                         tput_distance = [three_ray(PL_target(1), ht, hr, freq),three_ray(PL_target(2), ht, hr, freq),three_ray(PL_target(3), ht, hr, freq),three_ray(PL_target(4), ht, hr, freq),three_ray(PL_target(5), ht, hr, freq),three_ray(PL_target(6), ht, hr, freq),three_ray(PL_target(7), ht, hr, freq),three_ray(PL_target(8), ht, hr, freq),three_ray(PL_target(9), ht, hr, freq),three_ray(PL_target(10), ht, hr, freq)];
                                         tput_distance = tput_distance*10^-3;   
                                         
                                         if dlosh > tput_distance(1)

                                         set(handles.range_display_text, 'String',tput_distance(1)) 
                                         
                                         colour = 'y'; 
                                         %BPSK 1/2                                 
                                         handles.tput_plot1 = tput_plot(x,y,tput_distance(1) ,handles.map,colour);
                                         txt1 = [ num2str(phy_tput_frame(1)) ' Mbps' ' (BPSK 1/2)']; 
                                         
                                         colour = [216/255 133/255 49/255]; 
                                         %BPSK 3/4 
                                         handles.tput_plot2 = tput_plot(x,y,tput_distance(2) ,handles.map,colour);
                                         txt2 = [num2str(phy_tput_frame(2)) ' Mbps' ' (BPSK 3/4)'];

                                         colour = [7/255 164/255 18/255]; 
                                         %QPSK 1/2             
                                         handles.tput_plot3= tput_plot(x,y,tput_distance(3) ,handles.map,colour);
                                         txt3 = [num2str(phy_tput_frame(3)) ' Mbps' ' (QPSK 1/2)'];

                                         colour = [116/255 11/255 128/255]; 
                                         %QPSK 3/4                                 
                                         handles.tput_plot4 = tput_plot(x,y,tput_distance(4) ,handles.map,colour);
                                         txt4 = [num2str(phy_tput_frame(4)) ' Mbps' ' (QPSK 3/4)'];

                                         colour = 'c'; 
                                         %16QAM 1/2  
                                         handles.tput_plot5 = tput_plot(x,y,tput_distance(5) ,handles.map,colour);
                                         txt5 = [num2str(phy_tput_frame(5)) ' Mbps' ' (16QAM 1/2)'];

                                         colour = 'b'; 
                                         %16QAM 3/4               
                                         handles.tput_plot6= tput_plot(x,y,tput_distance(6) ,handles.map,colour);
                                         txt6 = [num2str(phy_tput_frame(6)) ' Mbps' ' (16QAM 3/4)'];

                                         colour = 'm'; 
                                         %64QAM 1/2                                 
                                         handles.tput_plot7 = tput_plot(x,y,tput_distance(7) ,handles.map,colour); 
                                         txt7 = [num2str(phy_tput_frame(7)) ' Mbps' ' (64QAM 1/2)'];

                                         colour = 'g';
                                         %64QAM 2/3 
                                         handles.tput_plot8 = tput_plot(x,y,tput_distance(8) ,handles.map,colour);
                                         txt8 = [num2str(phy_tput_frame(8)) ' Mbps' ' (64QAM 2/3)'];

                                         colour = [243/255 197/255 91/255]; 
                                         %64QAM 3/4                 
                                         handles.tput_plot9= tput_plot(x,y,tput_distance(9) ,handles.map,colour);
                                         txt9 = [num2str(phy_tput_frame(9)) ' Mbps' ' (64QAM 3/4)'];

                                         colour = [127/255 0/255 255/255];
                                         %64QAM 5/6                 
                                         handles.tput_plot10= tput_plot(x,y,tput_distance(10) ,handles.map,colour);
                                         txt10 = [num2str(phy_tput_frame(10)) ' Mbps' ' (64QAM 5/6)'];
                                     
                                         i_am_legend = legend(handles.map,[handles.tput_plot1,handles.tput_plot2,handles.tput_plot3,handles.tput_plot4,handles.tput_plot5,handles.tput_plot6,handles.tput_plot7,handles.tput_plot8,handles.tput_plot9,handles.tput_plot10],{txt1,txt2,txt3,txt4,txt5,txt6,txt7,txt8,txt9,txt10},'Location','best');
                                         title(i_am_legend,'LTE PHY Throuput per MCS')     
                                         
                                         end

                                     case 'Sea Radio-Wave Propagation Loss'
                                         tput_distance = [srwpl(PL_target(1), ht, hr, freq),srwpl(PL_target(2), ht, hr, freq),srwpl(PL_target(3), ht, hr, freq),srwpl(PL_target(4), ht, hr, freq),srwpl(PL_target(5), ht, hr, freq),srwpl(PL_target(6), ht, hr, freq),srwpl(PL_target(7), ht, hr, freq),srwpl(PL_target(8), ht, hr, freq),srwpl(PL_target(9), ht, hr, freq),srwpl(PL_target(10), ht, hr, freq)];
                                         tput_distance = tput_distance*10^-3;   
                                         
                                         if dlosh > tput_distance(1)

                                         set(handles.range_display_text, 'String',tput_distance(1)) 
                                         
                                         colour = 'y'; 
                                         %BPSK 1/2                                 
                                         handles.tput_plot1 = tput_plot(x,y,tput_distance(1) ,handles.map,colour);
                                         txt1 = [ num2str(phy_tput_frame(1)) ' Mbps' ' (BPSK 1/2)']; 
                                         
                                         colour = [216/255 133/255 49/255]; 
                                         %BPSK 3/4 
                                         handles.tput_plot2 = tput_plot(x,y,tput_distance(2) ,handles.map,colour);
                                         txt2 = [num2str(phy_tput_frame(2)) ' Mbps' ' (BPSK 3/4)'];

                                         colour = [7/255 164/255 18/255]; 
                                         %QPSK 1/2             
                                         handles.tput_plot3= tput_plot(x,y,tput_distance(3) ,handles.map,colour);
                                         txt3 = [num2str(phy_tput_frame(3)) ' Mbps' ' (QPSK 1/2)'];

                                         colour = [116/255 11/255 128/255]; 
                                         %QPSK 3/4                                 
                                         handles.tput_plot4 = tput_plot(x,y,tput_distance(4) ,handles.map,colour);
                                         txt4 = [num2str(phy_tput_frame(4)) ' Mbps' ' (QPSK 3/4)'];

                                         colour = 'c'; 
                                         %16QAM 1/2  
                                         handles.tput_plot5 = tput_plot(x,y,tput_distance(5) ,handles.map,colour);
                                         txt5 = [num2str(phy_tput_frame(5)) ' Mbps' ' (16QAM 1/2)'];

                                         colour = 'b'; 
                                         %16QAM 3/4               
                                         handles.tput_plot6= tput_plot(x,y,tput_distance(6) ,handles.map,colour);
                                         txt6 = [num2str(phy_tput_frame(6)) ' Mbps' ' (16QAM 3/4)'];

                                         colour = 'm'; 
                                         %64QAM 1/2                                 
                                         handles.tput_plot7 = tput_plot(x,y,tput_distance(7) ,handles.map,colour); 
                                         txt7 = [num2str(phy_tput_frame(7)) ' Mbps' ' (64QAM 1/2)'];

                                         colour = 'g';
                                         %64QAM 2/3 
                                         handles.tput_plot8 = tput_plot(x,y,tput_distance(8) ,handles.map,colour);
                                         txt8 = [num2str(phy_tput_frame(8)) ' Mbps' ' (64QAM 2/3)'];

                                         colour = [243/255 197/255 91/255]; 
                                         %64QAM 3/4                 
                                         handles.tput_plot9= tput_plot(x,y,tput_distance(9) ,handles.map,colour);
                                         txt9 = [num2str(phy_tput_frame(9)) ' Mbps' ' (64QAM 3/4)'];

                                         colour = [127/255 0/255 255/255];
                                         %64QAM 5/6                 
                                         handles.tput_plot10= tput_plot(x,y,tput_distance(10) ,handles.map,colour);
                                         txt10 = [num2str(phy_tput_frame(10)) ' Mbps' ' (64QAM 5/6)'];
                                     
                                         i_am_legend = legend(handles.map,[handles.tput_plot1,handles.tput_plot2,handles.tput_plot3,handles.tput_plot4,handles.tput_plot5,handles.tput_plot6,handles.tput_plot7,handles.tput_plot8,handles.tput_plot9,handles.tput_plot10],{txt1,txt2,txt3,txt4,txt5,txt6,txt7,txt8,txt9,txt10},'Location','best');
                                         title(i_am_legend,'LTE PHY Throuput per MCS') 
                                         
                                         end
                                 end 
                                 
                                 

                             otherwise

                                 Qm = [2,4,6];
                                 Rb = ((RE_frame*Qm)/(10*10^-3)); 
                                 EbN0 = [EbN0_value(ber_target,'QPSK',channel_type),EbN0_value(ber_target,'16QAM',channel_type),EbN0_value(ber_target,'64QAM',channel_type)];

                                 SINR = EbN0.*(Rb/B_noise);         
                                 SINR_db = 10*log10(SINR);                  
                                 Pr_min = SINR_db + Interf_Noise;        
                                 PL_target = Ptx + G_ant - Cable_losses - Pr_min;                
                                 x = ht_cords(1);          
                                 y = ht_cords(2);
                                 
                                 phy_tput_frame = ((PDSCH_RE_frame*Qm)/(10*10^-3))/10^6;
                                 set(handles.throughput_display_text, 'String',phy_tput_frame(1)) 
                                 

                                 switch link_con(link_num).channel.path_loss_model

                                     case 'FSPL'

                                         tput_distance = 10.^((PL_target-20*log10(freq)-32.44)/20);
                                         
                                         if dlosh > tput_distance(1)
                                         
                                         set(handles.range_display_text, 'String',tput_distance(1)) 

                                         colour = 'y'; 
                                         %QPSK                                  
                                         handles.tput_plot1 = tput_plot(x,y,tput_distance(1) ,handles.map,colour);
                                         txt1 = [ num2str(phy_tput_frame(1)) ' Mbps' ' (QPSK)']; 
                                         
                                         colour = 'b'; 
                                         %16QAM
                                         handles.tput_plot2 = tput_plot(x,y,tput_distance(2) ,handles.map,colour);
                                         txt2 = [num2str(phy_tput_frame(2)) ' Mbps' ' (16QAM)'];

                                         colour = 'g';
                                         %64QAM                 
                                         handles.tput_plot3= tput_plot(x,y,tput_distance(3) ,handles.map,colour);
                                         txt3 = [num2str(phy_tput_frame(3)) ' Mbps' ' (64QAM)'];
                                         
                                         i_am_legend = legend(handles.map,[handles.tput_plot1,handles.tput_plot2,handles.tput_plot3],{txt1,txt2,txt3},'Location','best');
                                         title(i_am_legend,'LTE PHY Throuput per Mod. Sch.')
                                         
                                         end
                                         
                                     case '2-Ray'

                                         tput_distance = [two_ray(PL_target(1), ht, hr, freq),two_ray(PL_target(2), ht, hr, freq),two_ray(PL_target(3), ht, hr, freq)];
                                         tput_distance = tput_distance*10^-3;
                                         
                                         if dlosh > tput_distance(1)
                                         
                                         set(handles.range_display_text, 'String',tput_distance(1)) 

                                         colour = 'y'; 
                                         %QPSK                                  
                                         handles.tput_plot1 = tput_plot(x,y,tput_distance(1) ,handles.map,colour);
                                         txt1 = [ num2str(phy_tput_frame(1)) ' Mbps' ' (QPSK)']; 
                                         
                                         colour = 'b'; 
                                         %16QAM
                                         handles.tput_plot2 = tput_plot(x,y,tput_distance(2) ,handles.map,colour);
                                         txt2 = [num2str(phy_tput_frame(2)) ' Mbps' ' (16QAM)'];

                                         colour = 'g';
                                         %64QAM                 
                                         handles.tput_plot3= tput_plot(x,y,tput_distance(3) ,handles.map,colour);
                                         txt3 = [num2str(phy_tput_frame(3)) ' Mbps' ' (64QAM)'];
                                         
                                         i_am_legend = legend(handles.map,[handles.tput_plot1,handles.tput_plot2,handles.tput_plot3],{txt1,txt2,txt3},'Location','best');
                                         title(i_am_legend,'LTE PHY Throuput per Mod. Sch.')
                                         
                                         end
                                         
                                     case '3-Ray'
                                         tput_distance = [three_ray(PL_target(1), ht, hr, freq),three_ray(PL_target(2), ht, hr, freq),three_ray(PL_target(3), ht, hr, freq)];
                                         tput_distance = tput_distance*10^-3;   
                                         
                                         if dlosh > tput_distance(1)
                                         
                                         set(handles.range_display_text, 'String',tput_distance(1)) 

                                         colour = 'y'; 
                                         %QPSK                                  
                                         handles.tput_plot1 = tput_plot(x,y,tput_distance(1) ,handles.map,colour);
                                         txt1 = [ num2str(phy_tput_frame(1)) ' Mbps' ' (QPSK)']; 
                                         
                                         colour = 'b'; 
                                         %16QAM
                                         handles.tput_plot2 = tput_plot(x,y,tput_distance(2) ,handles.map,colour);
                                         txt2 = [num2str(phy_tput_frame(2)) ' Mbps' ' (16QAM)'];

                                         colour = 'g';
                                         %64QAM                 
                                         handles.tput_plot3= tput_plot(x,y,tput_distance(3) ,handles.map,colour);
                                         txt3 = [num2str(phy_tput_frame(3)) ' Mbps' ' (64QAM)'];
                                         
                                         i_am_legend = legend(handles.map,[handles.tput_plot1,handles.tput_plot2,handles.tput_plot3],{txt1,txt2,txt3},'Location','best');
                                         title(i_am_legend,'LTE PHY Throuput per Mod. Sch.')
                                         
                                         end

                                     case 'Sea Radio-Wave Propagation Loss'
                                         tput_distance = [srwpl(PL_target(1), ht, hr, freq),srwpl(PL_target(2), ht, hr, freq),srwpl(PL_target(3), ht, hr, freq)];
                                         tput_distance = tput_distance*10^-3; 
                                         
                                         if dlosh > tput_distance(1)
                                         
                                         set(handles.range_display_text, 'String',tput_distance(1)) 

                                         colour = 'y'; 
                                         %QPSK                                  
                                         handles.tput_plot1 = tput_plot(x,y,tput_distance(1) ,handles.map,colour);
                                         txt1 = [ num2str(phy_tput_frame(1)) ' Mbps' ' (QPSK)']; 
                                         
                                         colour = 'b'; 
                                         %16QAM
                                         handles.tput_plot2 = tput_plot(x,y,tput_distance(2) ,handles.map,colour);
                                         txt2 = [num2str(phy_tput_frame(2)) ' Mbps' ' (16QAM)'];

                                         colour = 'g';
                                         %64QAM                 
                                         handles.tput_plot3= tput_plot(x,y,tput_distance(3) ,handles.map,colour);
                                         txt3 = [num2str(phy_tput_frame(3)) ' Mbps' ' (64QAM)'];
                                         
                                         i_am_legend = legend(handles.map,[handles.tput_plot1,handles.tput_plot2,handles.tput_plot3],{txt1,txt2,txt3},'Location','best');
                                         title(i_am_legend,'LTE PHY Throuput per Mod. Sch.')  
                                         
                                         end
                                 end                
                         end


                     case 'NWR'

                         Qm = 2;
                         datarate = 520.83; 

                         Rb = 520.83; 

                         B_noise = link_con(link_num).receiver.rx_bandwidth*10^6;
                         mod_sch = 'FSK';
                         EbN0 = EbN0_value(ber_target,mod_sch,channel_type);
                         SINR = EbN0*(Rb/B_noise);
                         SINR_db = 10*log10(SINR);
                         Pr_min = SINR_db + Interf_Noise;
                         PL_target = Ptx + G_ant - Cable_losses - Pr_min;

                         x = ht_cords(1);  
                         y = ht_cords(2);
                         
                         nwr_throughput = 520.83;%bps
                         set(handles.throughput_display_text, 'String',(nwr_throughput*10^-6)) 

                         switch link_con(link_num).channel.path_loss_model

                                     case 'FSPL'

                                         tput_distance = 10^((PL_target-20*log10(freq)-32.44)/20);
                                         
                                         if dlosh > tput_distance(1)


                                         colour = 'b';
                                         handles.tput_plot1 = tput_plot(x,y,tput_distance ,handles.map,colour);
                                         txt1 = [ num2str(nwr_throughput) ' bps' ' (FSK)']; 
                                         i_am_legend = legend(handles.map,[handles.tput_plot1],{txt1},'Location','best');
                                         title(i_am_legend,'NWR Throuput per Mod. Sch.') 
                                         
                                         set(handles.range_display_text, 'String',tput_distance)
                                         
                                         end


                                     case '2-Ray'

                                         tput_distance = two_ray(PL_target, ht, hr, freq);
                                         tput_distance = tput_distance*10^-3;
                                         
                                         if dlosh > tput_distance(1)

                                         colour = 'b';
                                         handles.tput_plot1 = tput_plot(x,y,tput_distance ,handles.map,colour);
                                         txt1 = [ num2str(nwr_throughput) ' bps' ' (FSK)']; 
                                         i_am_legend = legend(handles.map,[handles.tput_plot1],{txt1},'Location','best');
                                         title(i_am_legend,'NWR Throuput per Mod. Sch.') 
                                         
                                         set(handles.range_display_text, 'String',tput_distance)
                                         
                                         end
                                         
                                     case '3-Ray'
                                         tput_distance = three_ray(PL_target, ht, hr, freq);
                                         tput_distance = tput_distance*10^-3;    
                                         
                                         if dlosh > tput_distance(1)

                                         colour = 'b';
                                         handles.tput_plot1 = tput_plot(x,y,tput_distance ,handles.map,colour);
                                         txt1 = [ num2str(nwr_throughput) ' bps' ' (FSK)']; 
                                         i_am_legend = legend(handles.map,[handles.tput_plot1],{txt1},'Location','best');
                                         title(i_am_legend,'LTE PHY Throuput per Mod. Sch.') 
                                         
                                         set(handles.range_display_text, 'String',tput_distance)
                                         
                                         end
                                         
                                     case 'Sea Radio-Wave Propagation Loss'
                                         tput_distance = srwpl(PL_target, ht, hr, freq);
                                         tput_distance = tput_distance*10^-3;     
                                         
                                         if dlosh > tput_distance(1)

                                         colour = 'b';
                                         handles.tput_plot1 = tput_plot(x,y,tput_distance ,handles.map,colour);
                                         txt1 = [ num2str(nwr_throughput) ' bps' ' (FSK)']; 
                                         i_am_legend = legend(handles.map,[handles.tput_plot1],{txt1},'Location','best');
                                         title(i_am_legend,'NWR Throuput per Mod. Sch.') 
                                         
                                         set(handles.range_display_text, 'String',tput_distance)
                                         
                                         end
                         end




                     case 'Generic'    
                         Qm = [2,4,6];
                         Rb = ((RE_frame*Qm)/(10*10^-3)); 

                         EbN0 = [EbN0_value(ber_target,'QPSK',channel_type),EbN0_value(ber_target,'16QAM',channel_type),EbN0_value(ber_target,'64QAM',channel_type)];
                         SINR = EbN0.*(Rb/B_noise);
                         SINR_db = 10*log10(SINR);

                         Pr_min = SINR_db + Interf_Noise;
                         PL_target = Ptx + G_ant - Cable_losses - Pr_min;

                         x = ht_cords(1);  
                         y = ht_cords(2);
                         
                         phy_tput_frame = ((PDSCH_RE_frame*Qm)/(10*10^-3))/10^6;
                         set(handles.throughput_display_text, 'String',phy_tput_frame) 


                         switch link_con(link_num).channel.path_loss_model

                             case 'FSPL'

                                 tput_distance = 10.^((PL_target-20*log10(freq)-32.44)/20);
                                 
                                 if dlosh > tput_distance(1)

                                                
                                 colour = 'y'; 
                                 %QPSK                                  
                                 handles.tput_plot1 = tput_plot(x,y,tput_distance(1) ,handles.map,colour);
                                 txt1 = [ num2str(phy_tput_frame(1)) ' Mbps' ' (QPSK)']; 

                                 colour = 'b'; 
                                 %16QAM
                                 handles.tput_plot2 = tput_plot(x,y,tput_distance(2) ,handles.map,colour);
                                 txt2 = [num2str(phy_tput_frame(2)) ' Mbps' ' (16QAM)'];

                                 colour = 'g';
                                 %64QAM                 
                                 handles.tput_plot3= tput_plot(x,y,tput_distance(3) ,handles.map,colour);
                                 txt3 = [num2str(phy_tput_frame(3)) ' Mbps' ' (64QAM)'];

                                 i_am_legend = legend(handles.map,[handles.tput_plot1,handles.tput_plot2,handles.tput_plot3],{txt1,txt2,txt3},'Location','best');
                                 title(i_am_legend,'Generic Throuput per Mod. Sch.') 
                                 
                                 end

                             case '2-Ray'

                                 tput_distance = [two_ray(PL_target(1), ht, hr, freq),two_ray(PL_target(2), ht, hr, freq),two_ray(PL_target(3), ht, hr, freq)];
                                 tput_distance = tput_distance*10^-3;
                                 
                                 if dlosh > tput_distance(1)

                                 colour = 'y'; 
                                 %QPSK                                  
                                 handles.tput_plot1 = tput_plot(x,y,tput_distance(1) ,handles.map,colour);
                                 txt1 = [ num2str(phy_tput_frame(1)) ' Mbps' ' (QPSK)']; 

                                 colour = 'b'; 
                                 %16QAM
                                 handles.tput_plot2 = tput_plot(x,y,tput_distance(2) ,handles.map,colour);
                                 txt2 = [num2str(phy_tput_frame(2)) ' Mbps' ' (16QAM)'];

                                 colour = 'g';
                                 %64QAM                 
                                 handles.tput_plot3= tput_plot(x,y,tput_distance(3) ,handles.map,colour);
                                 txt3 = [num2str(phy_tput_frame(3)) ' Mbps' ' (64QAM)'];

                                 i_am_legend = legend(handles.map,[handles.tput_plot1,handles.tput_plot2,handles.tput_plot3],{txt1,txt2,txt3},'Location','best');
                                 title(i_am_legend,'Generic Throuput per Mod. Sch.') 
                                 
                                 end
                                 
                             case '3-Ray'
                                 tput_distance = [three_ray(PL_target(1), ht, hr, freq),three_ray(PL_target(2), ht, hr, freq),three_ray(PL_target(3), ht, hr, freq)];
                                 tput_distance = tput_distance*10^-3;   
                                 
                                 if dlosh > tput_distance(1)

                                 colour = 'y'; 
                                 %QPSK                                  
                                 handles.tput_plot1 = tput_plot(x,y,tput_distance(1) ,handles.map,colour);
                                 txt1 = [ num2str(phy_tput_frame(1)) ' Mbps' ' (QPSK)']; 

                                 colour = 'b'; 
                                 %16QAM
                                 handles.tput_plot2 = tput_plot(x,y,tput_distance(2) ,handles.map,colour);
                                 txt2 = [num2str(phy_tput_frame(2)) ' Mbps' ' (16QAM)'];

                                 colour = 'g';
                                 %64QAM                 
                                 handles.tput_plot3= tput_plot(x,y,tput_distance(3) ,handles.map,colour);
                                 txt3 = [num2str(phy_tput_frame(3)) ' Mbps' ' (64QAM)'];

                                 i_am_legend = legend(handles.map,[handles.tput_plot1,handles.tput_plot2,handles.tput_plot3],{txt1,txt2,txt3},'Location','best');
                                 title(i_am_legend,'Generic Throuput per Mod. Sch.') 
                                 
                                 end
                                 
                             case 'Sea Radio-Wave Propagation Loss'
                                 tput_distance = [srwpl(PL_target(1), ht, hr, freq),srwpl(PL_target(2), ht, hr, freq),srwpl(PL_target(3), ht, hr, freq)];
                                 tput_distance = tput_distance*10^-3;   
                                 
                                 if dlosh > tput_distance(1)

                                 colour = 'y'; 
                                 %QPSK                                  
                                 handles.tput_plot1 = tput_plot(x,y,tput_distance(1) ,handles.map,colour);
                                 txt1 = [ num2str(phy_tput_frame(1)) ' Mbps' ' (QPSK)']; 

                                 colour = 'b'; 
                                 %16QAM
                                 handles.tput_plot2 = tput_plot(x,y,tput_distance(2) ,handles.map,colour);
                                 txt2 = [num2str(phy_tput_frame(2)) ' Mbps' ' (16QAM)'];

                                 colour = 'g';
                                 %64QAM                 
                                 handles.tput_plot3= tput_plot(x,y,tput_distance(3) ,handles.map,colour);
                                 txt3 = [num2str(phy_tput_frame(3)) ' Mbps' ' (64QAM)'];

                                 i_am_legend = legend(handles.map,[handles.tput_plot1,handles.tput_plot2,handles.tput_plot3],{txt1,txt2,txt3},'Location','best');
                                 title(i_am_legend,'Generic Throuput per Mod. Sch.') 
                                 
                                 end
                         end


                end
                
                if dlosh > tput_distance(1)
                 
                    set(handles.range_display_text, 'String',tput_distance(1))
                     
                     
                else
                    %Plot LOSH
                    plotted_range = range_plot(dlosh_cords(1)  ,dlosh_cords(2)  ,d_losh,handles.map);
                    
                    set(handles.range_display_text, 'String',dlosh)
                    set(handles.rx_sens_text, 'String','N/A')
                    set(handles.ber_display_text, 'String','N/A')
                    set(handles.node_display_text, 'String',link_con(link_num).link_name)
                    set(handles.path_loss_disp_text, 'String', 'N/A');
                    
                    %set(handles.techno_disp_text, 'String',node_con(nod_num).equipment_params.technology )
                    set(handles.service_disp_text, 'String','N/A' )
                    set(handles.techno_disp_text, 'String','N/A' )
                    set(handles.throughput_display_text, 'String','N/A')
                    set(handles.freq_disp_text, 'String', 'N/A');
                    set(handles.interf_disp_text, 'String', 'N/A');
                    set(handles.fade_disp_text, 'String', 'N/A');
                    
                end
                %%
                %LOSH Computation
                %Ascertain whether the transmitter is tower mounted or mobile at sea 
             switch node_con(tx_num).node_type
                 
                 case 'Mobile at Sea'
                     
                     h_ves = 2; %Vessel selected to be maximum 2m 
                     
                     %Plot Datatips for transmitter 
                     h = findobj('Tag','gmap');
                     h = h(2);
                     makedatatip(h,[node_con(tx_num).node_location.longi  node_con(tx_num).node_location.lati])
                     
                     switch node_con(rx_num).node_type
                         
                         case 'Mobile at Sea'
                             
                             h_2 = h_ves ;
                             
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

                                h_2 = tower_tnt(find((ismember(tower_cords,closest_tower )),1)).AntennaHeight; %Height of Closest tower 
                                
                                %Plot Datatips for receiver
                                h = findobj('Tag','gmap');
                                h = h(2);
                                makedatatip(h,[closest_tower(:,1)  closest_tower(:,2)])
                                 end
                             end
                     end

                     d_losh = (sqrt(2*R*h_ves)+sqrt(2*R*h_2))/(10^3); %answer in km

                     setappdata(0,'range_dist',d_losh)
                     setappdata(0,'long_cordi',node_con(tx_num).node_location.longi); 
                     setappdata(0,'lat_cordi',node_con(tx_num).node_location.lati);
                     dlosh_cords = [node_con(tx_num).node_location.longi  node_con(tx_num).node_location.lati];



                     euclidean_los = sqrt(sum(bsxfun(@minus, tx_cords, rx_cords).^2,2)); %find direct distance between tx and rx to find if rx is in range of tx by comparing the link lenght to the LOSH distance(radius)
                     if euclidean_los<d_losh
                         range_flag = 1;   %Signal if in range or out of range                      
                     end

                     
                     
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
                                h_ves = 2; 

                                d_losh = (sqrt(2*R*h_bs)+sqrt(2*R*h_ves))/(10^3); %answer in km
                                setappdata(0,'range_dist',d_losh)
                                setappdata(0,'long_cordi',closest_tower(:,1)); 
                                setappdata(0,'lat_cordi',closest_tower(:,2));
                                dlosh_cords = [closest_tower(:,1)  closest_tower(:,2) ];

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
                     i_am_legend = legend(handles.map,[plotted_range],{'Link LOSH'},'Location','best');
                     title(i_am_legend,'Line of Sight to Horizon Limit')
                     
                     
                     
             end
             
             
             
             

             %Power Limited Computation with embedded check against LOSH 
             switch node_con(tx_num).node_type
                 
                 case 'Mobile at Sea'
                     ht = 2;
                     ht_cords = [node_con(tx_num).node_location.longi  ,node_con(tx_num).node_location.lati];
                     
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
                                ht_cords = [closest_tower(:,1)  ,closest_tower(:,2)]; 


                         end
                     end
                     
             end
                     
                     

             
             switch node_con(rx_num).node_type
                 
                 case 'Mobile at Sea'
                     hr = 2;
                     hr_cords = [node_con(rx_num).node_location.longi  ,node_con(rx_num).node_location.lati];
                     
                     
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
                                hr_cords = [closest_tower(:,1)  ,closest_tower(:,2)];


                         end
                     end
                     
             end
             
             %Plot Datatips for receiver
             h = findobj('Tag','gmap');
             h = h(2);
             makedatatip(h,[hr_cords(1), hr_cords(2)]) 

             %Plot Datatips for transmitter 
             h = findobj('Tag','gmap');
             h = h(2);
             makedatatip(h,[ht_cords(1), ht_cords(2)])
             
             
             set(handles.service_disp_text, 'String', link_con(link_num).node_service.service);
             set(handles.ber_display_text, 'String',link_con(link_num).node_service.ber)
             switch link_con(link_num).node_service.ber
                 
                 case '10^-2'
                     ber_target = 10^-2;
                     
                 case '10^-3'
                     ber_target = 10^-3;
                     
                 case '10^-5' 
                     ber_target = 10^-5;
                     
                 case '10^-6' 
                     ber_target = 10^-6;
                     
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

                     B_noise = link_con(link_num).receiver.rx_bandwidth*10^6;
                     mod_sch = 'FSK';
                     EbN0 = EbN0_value(ber_target,mod_sch,channel_type);
                     SINR = EbN0*(Rb/B_noise);
                     SINR_db = 10*log10(SINR);
                     Nf = node_con(rx_num).equipment_params.noise_fig;
                     k = physconst('Boltzmann');
                     T = link_con(link_num).receiver.temperature;
                     Nt = k*T*B_noise;
                     Nt_db =  10*log10(Nt)+30;   
    
                 case 'LTE-A'
                     B_sys = link_con(link_num).system_params.system_bandwidth;
                     set(handles.freq_disp_text, 'String', B_sys);
                     
                     B_sys = num2str(B_sys);
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

                     B_noise = link_con(link_num).receiver.rx_bandwidth*10^6;
                     mod_sch = 'QPSK';
                     EbN0 = EbN0_value(ber_target,mod_sch,channel_type);
                     SINR = EbN0*(Rb/B_noise);
                     SINR_db = 10*log10(SINR);
                     Nf = node_con(rx_num).equipment_params.noise_fig;
                     k = physconst('Boltzmann');
                     T = link_con(link_num).receiver.temperature;
                     Nt = k*T*B_noise;
                     Nt_db =  10*log10(Nt)+30;      
           

                 case 'NWR'
                     B_sys = link_con(link_num).system_params.system_bandwidth;
                     set(handles.freq_disp_text, 'String', B_sys);
                     

                     Qm = 2;
                     datarate = 520.83; 

                     Rb = 520.83; 

                     B_noise = link_con(link_num).receiver.rx_bandwidth*10^6;
                     mod_sch = 'FSK';
                     EbN0 = EbN0_value(ber_target,mod_sch,channel_type);
                     SINR = EbN0*(Rb/B_noise);
                     SINR_db = 10*log10(SINR);
                     Nf = node_con(rx_num).equipment_params.noise_fig;
                     k = physconst('Boltzmann');
                     T = link_con(link_num).receiver.temperature;
                     Nt = k*T*B_noise;
                     Nt_db =  10*log10(Nt)+30;    
   
                 case 'Generic'    
                     B_sys = link_con(link_num).system_params.system_bandwidth;
                     set(handles.freq_disp_text, 'String', B_sys);
                     B_sys = num2str(B_sys);
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

                     B_noise = link_con(link_num).receiver.rx_bandwidth*10^6;
                     mod_sch = 'QPSK';
                     EbN0 = EbN0_value(ber_target,mod_sch,channel_type);
                     SINR = EbN0*(Rb/B_noise);
                     SINR_db = 10*log10(SINR);
                     Nf = node_con(rx_num).equipment_params.noise_fig;
                     k = physconst('Boltzmann');
                     T = link_con(link_num).receiver.temperature;
                     Nt = k*T*B_noise;
                     Nt_db =  10*log10(Nt)+30;                                
                     
             end
             

             
             %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
             If_margin = link_con(link_num).channel.interference_margin;
             set(handles.interf_disp_text, 'String', If_margin);
             fad_margin = link_con(link_num).channel.fading_margin;
             set(handles.fade_disp_text, 'String', fad_margin);
             
             Interf_Noise = Nt_db+Nf+If_margin+fad_margin;
             
             Pr_min = SINR_db + Interf_Noise;
             
             set(handles.rx_sens_text, 'String',Pr_min)
             set(handles.ber_display_text, 'String',link_con(link_num).node_service.ber) 
             set(handles.node_display_text, 'String',link_con(link_num).link_name) 
             
                          
             Ptx = node_con(tx_num).equipment_params.tx_pwr;

             G_ant = node_con(tx_num).equipment_params.tx_ant_gain + node_con(rx_num).equipment_params.rx_ant_gain;
             Cable_losses = node_con(tx_num).equipment_params.tx_cable_loss + node_con(rx_num).equipment_params.rx_cable_loss;
             
             PL_target = Ptx + G_ant - Cable_losses - Pr_min;
             
             freq = link_con(link_num).system_params.freq;

               switch link_con(link_num).channel.path_loss_model
                   
                   case 'FSPL'
                       set(handles.path_loss_disp_text, 'String', link_con(link_num).channel.path_loss_model);
                       %Path_Loss = Ptx + G_ant - Cable_losses - Prx;
                       
                       plim_distance = 10^((PL_target-20*log10(freq)-32.44)/20);
   
                   case '2-Ray'
                       set(handles.path_loss_disp_text, 'String', link_con(link_num).channel.path_loss_model);

                       plim_distance =two_ray(PL_target, ht, hr, freq)*10^-3;

                   case '3-Ray'
                       set(handles.path_loss_disp_text, 'String', link_con(link_num).channel.path_loss_model);
                       
                       plim_distance =three_ray(PL_target, ht, hr, freq)*10^-3;
                       

                   case 'Sea Radio-Wave Propagation Loss'
                       set(handles.path_loss_disp_text, 'String', link_con(link_num).channel.path_loss_model);
                       
                       plim_distance = srwpl(PL_target, ht, hr, freq)*10^-3;
        
               end
               
               set(handles.range_display_text, 'String',plim_distance) 
               set(handles.techno_disp_text, 'String',link_con(link_num).technology ) 
               
                switch link_con(link_num).technology 

                    case 'DSC'
                         Qm = 2;
                         datarate = 1200; 

                         Rb = datarate ; 

                         mod_sch = 'FSK';
                         EbN0 = EbN0_value(ber_target,mod_sch,channel_type);
                         SINR = EbN0*(Rb/B_noise);
                         SINR_db = 10*log10(SINR);
                         Pr_min = SINR_db + Interf_Noise;
                         PL_target = Ptx + G_ant - Cable_losses - Pr_min;
                         x = ht_cords(1);  
                         y = ht_cords(2);
                         
                         dsc_throughput = 1200; %bps
                         set(handles.throughput_display_text, 'String',(dsc_throughput*10^-6)) 

                         switch link_con(link_num).channel.path_loss_model

                                     case 'FSPL'

                                         tput_distance = 10^((PL_target-20*log10(freq)-32.44)/20);
                                         
                                         if dlosh > tput_distance(1)

                                         colour = 'b';
                                         handles.tput_plot1 = tput_plot(x,y,tput_distance ,handles.map,colour);
                                         txt1 = [ num2str(dsc_throughput) ' bps' ' (FSK)']; 
                                         i_am_legend = legend(handles.map,[handles.tput_plot1],{txt1},'Location','best');
                                         title(i_am_legend,'DSC Throuput per Mod. Sch.') 
                                         
                                         set(handles.range_display_text, 'String',tput_distance)
                                         
                                         end


                                     case '2-Ray'
                                         
                                         

                                         tput_distance = two_ray(PL_target, ht, hr, freq);
                                         tput_distance = tput_distance*10^-3;
                                         
                                         if dlosh > tput_distance(1)

                                         colour = 'b';
                                         handles.tput_plot1 = tput_plot(x,y,tput_distance ,handles.map,colour);
                                         txt1 = [ num2str(dsc_throughput) ' bps' ' (FSK)']; 
                                         i_am_legend = legend(handles.map,[handles.tput_plot1],{txt1},'Location','best');
                                         title(i_am_legend,'DSC Throuput per Mod. Sch.') 
                                         
                                         set(handles.range_display_text, 'String',tput_distance)
                                         
                                         end


                                     case '3-Ray'
                                         tput_distance = three_ray(PL_target, ht, hr, freq);
                                         tput_distance = tput_distance*10^-3;   
                                         
                                         if dlosh > tput_distance(1)

                                         colour = 'b';
                                         handles.tput_plot1 = tput_plot(x,y,tput_distance ,handles.map,colour);
                                         txt1 = [ num2str(dsc_throughput) ' bps' ' (FSK)']; 
                                         i_am_legend = legend(handles.map,[handles.tput_plot1],{txt1},'Location','best');
                                         title(i_am_legend,'DSC Throuput per Mod. Sch.') 
                                         
                                         set(handles.range_display_text, 'String',tput_distance)
                                         
                                         end


                                     case 'Sea Radio-Wave Propagation Loss'
                                         tput_distance = srwpl(PL_target, ht, hr, freq);
                                         tput_distance = tput_distance*10^-3;  
                                         
                                         if dlosh > tput_distance(1)

                                         colour = 'b';
                                         handles.tput_plot1 = tput_plot(x,y,tput_distance ,handles.map,colour);
                                         txt1 = [ num2str(dsc_throughput) ' bps' ' (FSK)']; 
                                         i_am_legend = legend(handles.map,[handles.tput_plot1],{txt1},'Location','best');
                                         title(i_am_legend,'DSC Throuput per Mod. Sch.') 
                                         
                                         set(handles.range_display_text, 'String',tput_distance)
                                         
                                         end

                         end



                     case 'LTE-A'
                         
                         B_sys = link_con(link_num).system_params.system_bandwidth;
                         B_sys = num2str(B_sys);
                         switch B_sys


                             case '1.4'
                                 PDSCH_RE_frame = 4912; %Extended CP, CFI = 3, BW = 1.4 MHz

                             case '3'
                                 PDSCH_RE_frame = 14812; %Extended CP, CFI = 3

                             case '5'
                                 PDSCH_RE_frame = 25012; %Extended CP, CFI = 3

                             case '10'
                                 PDSCH_RE_frame = 50512; %Extended CP, CFI = 3

                             case '15'
                                 PDSCH_RE_frame = 76012; %Extended CP, CFI = 3

                             case '20'
                                 PDSCH_RE_frame = 101512; %Extended CP, CFI = 3
                         end
                         


                         switch link_con(link_num).node_service.ber

                             case '10^-3'
                                 Qm = [1,1,2,2,4,4,6,6,6,6];
                                 code = ["1/2","3/4","1/2","3/4","1/2","3/4","1/2","2/3","3/4","5/6"];

                                 code_rate = [1/2,3/4,1/2,3/4,1/2,3/4,1/2,2/3,3/4,5/6];
                                 phy_tput_frame = ((((PDSCH_RE_frame*Qm)/(10*10^-3))).*code_rate)/10^6; %Mbps
                                 phy_tput_frame  = round(phy_tput_frame,2);
                                 set(handles.throughput_display_text, 'String',phy_tput_frame(1))
                                 
                                 
                                 switch channel_type
                                     
                                     case 'AWGN'
                                         SINR_db = [0,3.3,3,6.3,9.5,13,13.7,16.9,17.7,18.5];
                                     case 'Rayleigh'
                                         SINR_db = [14.54,19.16,17.54,22.16,23.6,28.5,26.36,30.84,31.96,33.08];                                       
                                 end
                                 
                                 Pr_min = SINR_db + Interf_Noise;        
                                 PL_target = Ptx + G_ant - Cable_losses - Pr_min;                
                                 x = ht_cords(1);          
                                 y = ht_cords(2);

                                 switch link_con(link_num).channel.path_loss_model

                                     case 'FSPL'

                                         tput_distance = 10.^((PL_target-20*log10(freq)-32.44)/20);
                                         
                                         if dlosh > tput_distance(1)
                                         
                                         set(handles.range_display_text, 'String',tput_distance(1)) 
%                                          
                                         colour = 'y'; 
                                         %BPSK 1/2                                 
                                         handles.tput_plot1 = tput_plot(x,y,tput_distance(1) ,handles.map,colour);
                                         txt1 = [ num2str(phy_tput_frame(1)) ' Mbps' ' (BPSK 1/2)']; 
                                         
                                         
                                         colour = [216/255 133/255 49/255]; 
                                         %BPSK 3/4 
                                         handles.tput_plot2 = tput_plot(x,y,tput_distance(2) ,handles.map,colour);
                                         txt2 = [num2str(phy_tput_frame(2)) ' Mbps' ' (BPSK 3/4)'];

                                         colour = [7/255 164/255 18/255]; 
                                         %QPSK 1/2             
                                         handles.tput_plot3= tput_plot(x,y,tput_distance(3) ,handles.map,colour);
                                         txt3 = [num2str(phy_tput_frame(3)) ' Mbps' ' (QPSK 1/2)'];

                                         colour = [116/255 11/255 128/255]; 
                                         %QPSK 3/4                                 
                                         handles.tput_plot4 = tput_plot(x,y,tput_distance(4) ,handles.map,colour);
                                         txt4 = [num2str(phy_tput_frame(4)) ' Mbps' ' (QPSK 3/4)'];

                                         colour = 'c'; 
                                         %16QAM 1/2  
                                         handles.tput_plot5 = tput_plot(x,y,tput_distance(5) ,handles.map,colour);
                                         txt5 = [num2str(phy_tput_frame(5)) ' Mbps' ' (16QAM 1/2)'];

                                         colour = 'b'; 
                                         %16QAM 3/4               
                                         handles.tput_plot6= tput_plot(x,y,tput_distance(6) ,handles.map,colour);
                                         txt6 = [num2str(phy_tput_frame(6)) ' Mbps' ' (16QAM 3/4)'];

                                         colour = 'm'; 
                                         %64QAM 1/2                                 
                                         handles.tput_plot7 = tput_plot(x,y,tput_distance(7) ,handles.map,colour); 
                                         txt7 = [num2str(phy_tput_frame(7)) ' Mbps' ' (64QAM 1/2)'];

                                         colour = 'g';
                                         %64QAM 2/3 
                                         handles.tput_plot8 = tput_plot(x,y,tput_distance(8) ,handles.map,colour);
                                         txt8 = [num2str(phy_tput_frame(8)) ' Mbps' ' (64QAM 2/3)'];

                                         colour = [243/255 197/255 91/255]; 
                                         %64QAM 3/4                 
                                         handles.tput_plot9= tput_plot(x,y,tput_distance(9) ,handles.map,colour);
                                         txt9 = [num2str(phy_tput_frame(9)) ' Mbps' ' (64QAM 3/4)'];

                                         colour = [127/255 0/255 255/255];
                                         %64QAM 5/6                 
                                         handles.tput_plot10= tput_plot(x,y,tput_distance(10) ,handles.map,colour);
                                         txt10 = [num2str(phy_tput_frame(10)) ' Mbps' ' (64QAM 5/6)'];
                                     
                                       i_am_legend = legend(handles.map,[handles.tput_plot1,handles.tput_plot2,handles.tput_plot3,handles.tput_plot4,handles.tput_plot5,handles.tput_plot6,handles.tput_plot7,handles.tput_plot8,handles.tput_plot9,handles.tput_plot10],{txt1,txt2,txt3,txt4,txt5,txt6,txt7,txt8,txt9,txt10},'Location','best');
                                         title(i_am_legend,'LTE PHY Throuput per MCS')
                                         
                                         end

                                     case '2-Ray'

                                         tput_distance = [two_ray(PL_target(1), ht, hr, freq),two_ray(PL_target(2), ht, hr, freq),two_ray(PL_target(3), ht, hr, freq),two_ray(PL_target(4), ht, hr, freq),two_ray(PL_target(5), ht, hr, freq),two_ray(PL_target(6), ht, hr, freq),two_ray(PL_target(7), ht, hr, freq),two_ray(PL_target(8), ht, hr, freq),two_ray(PL_target(9), ht, hr, freq),two_ray(PL_target(10), ht, hr, freq)];
                                         tput_distance = tput_distance*10^-3;
                                         
                                         if dlosh > tput_distance(1)

                                         set(handles.range_display_text, 'String',tput_distance(1)) 
                                          
                                         colour = 'y'; 
                                         %BPSK 1/2                                 
                                         handles.tput_plot1 = tput_plot(x,y,tput_distance(1) ,handles.map,colour);
                                         txt1 = [ num2str(phy_tput_frame(1)) ' Mbps' ' (BPSK 1/2)']; 
                                         
                                         colour = [216/255 133/255 49/255]; 
                                         %BPSK 3/4 
                                         handles.tput_plot2 = tput_plot(x,y,tput_distance(2) ,handles.map,colour);
                                         txt2 = [num2str(phy_tput_frame(2)) ' Mbps' ' (BPSK 3/4)'];

                                         colour = [7/255 164/255 18/255]; 
                                         %QPSK 1/2             
                                         handles.tput_plot3= tput_plot(x,y,tput_distance(3) ,handles.map,colour);
                                         txt3 = [num2str(phy_tput_frame(3)) ' Mbps' ' (QPSK 1/2)'];

                                         colour = [116/255 11/255 128/255]; 
                                         %QPSK 3/4                                 
                                         handles.tput_plot4 = tput_plot(x,y,tput_distance(4) ,handles.map,colour);
                                         txt4 = [num2str(phy_tput_frame(4)) ' Mbps' ' (QPSK 3/4)'];

                                         colour = 'c'; 
                                         %16QAM 1/2  
                                         handles.tput_plot5 = tput_plot(x,y,tput_distance(5) ,handles.map,colour);
                                         txt5 = [num2str(phy_tput_frame(5)) ' Mbps' ' (16QAM 1/2)'];

                                         colour = 'b'; 
                                         %16QAM 3/4               
                                         handles.tput_plot6= tput_plot(x,y,tput_distance(6) ,handles.map,colour);
                                         txt6 = [num2str(phy_tput_frame(6)) ' Mbps' ' (16QAM 3/4)'];

                                         colour = 'm'; 
                                         %64QAM 1/2                                 
                                         handles.tput_plot7 = tput_plot(x,y,tput_distance(7) ,handles.map,colour); 
                                         txt7 = [num2str(phy_tput_frame(7)) ' Mbps' ' (64QAM 1/2)'];

                                         colour = 'g';
                                         %64QAM 2/3 
                                         handles.tput_plot8 = tput_plot(x,y,tput_distance(8) ,handles.map,colour);
                                         txt8 = [num2str(phy_tput_frame(8)) ' Mbps' ' (64QAM 2/3)'];

                                         colour = [243/255 197/255 91/255]; 
                                         %64QAM 3/4                 
                                         handles.tput_plot9= tput_plot(x,y,tput_distance(9) ,handles.map,colour);
                                         txt9 = [num2str(phy_tput_frame(9)) ' Mbps' ' (64QAM 3/4)'];

                                         colour = [127/255 0/255 255/255];
                                         %64QAM 5/6                 
                                         handles.tput_plot10= tput_plot(x,y,tput_distance(10) ,handles.map,colour);
                                         txt10 = [num2str(phy_tput_frame(10)) ' Mbps' ' (64QAM 5/6)'];
                                     
                                         i_am_legend = legend(handles.map,[handles.tput_plot1,handles.tput_plot2,handles.tput_plot3,handles.tput_plot4,handles.tput_plot5,handles.tput_plot6,handles.tput_plot7,handles.tput_plot8,handles.tput_plot9,handles.tput_plot10],{txt1,txt2,txt3,txt4,txt5,txt6,txt7,txt8,txt9,txt10},'Location','best');
                                         title(i_am_legend,'LTE PHY Throuput per MCS') 
                                         
                                         end

                                     case '3-Ray'
                                         tput_distance = [three_ray(PL_target(1), ht, hr, freq),three_ray(PL_target(2), ht, hr, freq),three_ray(PL_target(3), ht, hr, freq),three_ray(PL_target(4), ht, hr, freq),three_ray(PL_target(5), ht, hr, freq),three_ray(PL_target(6), ht, hr, freq),three_ray(PL_target(7), ht, hr, freq),three_ray(PL_target(8), ht, hr, freq),three_ray(PL_target(9), ht, hr, freq),three_ray(PL_target(10), ht, hr, freq)];
                                         tput_distance = tput_distance*10^-3;      
                                         
                                         if dlosh > tput_distance(1)

                                         set(handles.range_display_text, 'String',tput_distance(1)) 
                                         
                                         colour = 'y'; 
                                         %BPSK 1/2                                 
                                         handles.tput_plot1 = tput_plot(x,y,tput_distance(1) ,handles.map,colour);
                                         txt1 = [ num2str(phy_tput_frame(1)) ' Mbps' ' (BPSK 1/2)']; 
                                         
                                         colour = [216/255 133/255 49/255]; 
                                         %BPSK 3/4 
                                         handles.tput_plot2 = tput_plot(x,y,tput_distance(2) ,handles.map,colour);
                                         txt2 = [num2str(phy_tput_frame(2)) ' Mbps' ' (BPSK 3/4)'];

                                         colour = [7/255 164/255 18/255]; 
                                         %QPSK 1/2             
                                         handles.tput_plot3= tput_plot(x,y,tput_distance(3) ,handles.map,colour);
                                         txt3 = [num2str(phy_tput_frame(3)) ' Mbps' ' (QPSK 1/2)'];

                                         colour = [116/255 11/255 128/255]; 
                                         %QPSK 3/4                                 
                                         handles.tput_plot4 = tput_plot(x,y,tput_distance(4) ,handles.map,colour);
                                         txt4 = [num2str(phy_tput_frame(4)) ' Mbps' ' (QPSK 3/4)'];

                                         colour = 'c'; 
                                         %16QAM 1/2  
                                         handles.tput_plot5 = tput_plot(x,y,tput_distance(5) ,handles.map,colour);
                                         txt5 = [num2str(phy_tput_frame(5)) ' Mbps' ' (16QAM 1/2)'];

                                         colour = 'b'; 
                                         %16QAM 3/4               
                                         handles.tput_plot6= tput_plot(x,y,tput_distance(6) ,handles.map,colour);
                                         txt6 = [num2str(phy_tput_frame(6)) ' Mbps' ' (16QAM 3/4)'];

                                         colour = 'm'; 
                                         %64QAM 1/2                                 
                                         handles.tput_plot7 = tput_plot(x,y,tput_distance(7) ,handles.map,colour); 
                                         txt7 = [num2str(phy_tput_frame(7)) ' Mbps' ' (64QAM 1/2)'];

                                         colour = 'g';
                                         %64QAM 2/3 
                                         handles.tput_plot8 = tput_plot(x,y,tput_distance(8) ,handles.map,colour);
                                         txt8 = [num2str(phy_tput_frame(8)) ' Mbps' ' (64QAM 2/3)'];

                                         colour = [243/255 197/255 91/255]; 
                                         %64QAM 3/4                 
                                         handles.tput_plot9= tput_plot(x,y,tput_distance(9) ,handles.map,colour);
                                         txt9 = [num2str(phy_tput_frame(9)) ' Mbps' ' (64QAM 3/4)'];

                                         colour = [127/255 0/255 255/255];
                                         %64QAM 5/6                 
                                         handles.tput_plot10= tput_plot(x,y,tput_distance(10) ,handles.map,colour);
                                         txt10 = [num2str(phy_tput_frame(10)) ' Mbps' ' (64QAM 5/6)'];
                                     
                                         i_am_legend = legend(handles.map,[handles.tput_plot1,handles.tput_plot2,handles.tput_plot3,handles.tput_plot4,handles.tput_plot5,handles.tput_plot6,handles.tput_plot7,handles.tput_plot8,handles.tput_plot9,handles.tput_plot10],{txt1,txt2,txt3,txt4,txt5,txt6,txt7,txt8,txt9,txt10},'Location','best');
                                         title(i_am_legend,'LTE PHY Throuput per MCS')  
                                         
                                         end

                                     case 'Sea Radio-Wave Propagation Loss'
                                         tput_distance = [srwpl(PL_target(1), ht, hr, freq),srwpl(PL_target(2), ht, hr, freq),srwpl(PL_target(3), ht, hr, freq),srwpl(PL_target(4), ht, hr, freq),srwpl(PL_target(5), ht, hr, freq),srwpl(PL_target(6), ht, hr, freq),srwpl(PL_target(7), ht, hr, freq),srwpl(PL_target(8), ht, hr, freq),srwpl(PL_target(9), ht, hr, freq),srwpl(PL_target(10), ht, hr, freq)];
                                         tput_distance = tput_distance*10^-3;       
                                         
                                         if dlosh > tput_distance(1)

                                         set(handles.range_display_text, 'String',tput_distance(1)) 
                                         
                                         colour = 'y'; 
                                         %BPSK 1/2                                 
                                         handles.tput_plot1 = tput_plot(x,y,tput_distance(1) ,handles.map,colour);
                                         txt1 = [ num2str(phy_tput_frame(1)) ' Mbps' ' (BPSK 1/2)']; 
                                         
                                         colour = [216/255 133/255 49/255]; 
                                         %BPSK 3/4 
                                         handles.tput_plot2 = tput_plot(x,y,tput_distance(2) ,handles.map,colour);
                                         txt2 = [num2str(phy_tput_frame(2)) ' Mbps' ' (BPSK 3/4)'];

                                         colour = [7/255 164/255 18/255]; 
                                         %QPSK 1/2             
                                         handles.tput_plot3= tput_plot(x,y,tput_distance(3) ,handles.map,colour);
                                         txt3 = [num2str(phy_tput_frame(3)) ' Mbps' ' (QPSK 1/2)'];

                                         colour = [116/255 11/255 128/255]; 
                                         %QPSK 3/4                                 
                                         handles.tput_plot4 = tput_plot(x,y,tput_distance(4) ,handles.map,colour);
                                         txt4 = [num2str(phy_tput_frame(4)) ' Mbps' ' (QPSK 3/4)'];

                                         colour = 'c'; 
                                         %16QAM 1/2  
                                         handles.tput_plot5 = tput_plot(x,y,tput_distance(5) ,handles.map,colour);
                                         txt5 = [num2str(phy_tput_frame(5)) ' Mbps' ' (16QAM 1/2)'];

                                         colour = 'b'; 
                                         %16QAM 3/4               
                                         handles.tput_plot6= tput_plot(x,y,tput_distance(6) ,handles.map,colour);
                                         txt6 = [num2str(phy_tput_frame(6)) ' Mbps' ' (16QAM 3/4)'];

                                         colour = 'm'; 
                                         %64QAM 1/2                                 
                                         handles.tput_plot7 = tput_plot(x,y,tput_distance(7) ,handles.map,colour); 
                                         txt7 = [num2str(phy_tput_frame(7)) ' Mbps' ' (64QAM 1/2)'];

                                         colour = 'g';
                                         %64QAM 2/3 
                                         handles.tput_plot8 = tput_plot(x,y,tput_distance(8) ,handles.map,colour);
                                         txt8 = [num2str(phy_tput_frame(8)) ' Mbps' ' (64QAM 2/3)'];

                                         colour = [243/255 197/255 91/255]; 
                                         %64QAM 3/4                 
                                         handles.tput_plot9= tput_plot(x,y,tput_distance(9) ,handles.map,colour);
                                         txt9 = [num2str(phy_tput_frame(9)) ' Mbps' ' (64QAM 3/4)'];

                                         colour = [127/255 0/255 255/255];
                                         %64QAM 5/6                 
                                         handles.tput_plot10= tput_plot(x,y,tput_distance(10) ,handles.map,colour);
                                         txt10 = [num2str(phy_tput_frame(10)) ' Mbps' ' (64QAM 5/6)'];
                                     
                                         i_am_legend = legend(handles.map,[handles.tput_plot1,handles.tput_plot2,handles.tput_plot3,handles.tput_plot4,handles.tput_plot5,handles.tput_plot6,handles.tput_plot7,handles.tput_plot8,handles.tput_plot9,handles.tput_plot10],{txt1,txt2,txt3,txt4,txt5,txt6,txt7,txt8,txt9,txt10},'Location','best');
                                         title(i_am_legend,'LTE PHY Throuput per MCS')  
                                         
                                         end
                                 end 
                                 
                             case '10^-6'
                                 Qm = [1,1,2,2,4,4,6,6,6,6];
                                 code = ["1/2","3/4","1/2","3/4","1/2","3/4","1/2","2/3","3/4","5/6"];

                                 code_rate = [1/2,3/4,1/2,3/4,1/2,3/4,1/2,2/3,3/4,5/6];
                                 phy_tput_frame = ((((PDSCH_RE_frame*Qm)/(10*10^-3))).*code_rate)/10^6; %Mbps
                                 phy_tput_frame  = round(phy_tput_frame,2);
                                 set(handles.throughput_display_text, 'String',phy_tput_frame(1))
                                 
                                 
                                 switch channel_type
                                     
                                     case 'AWGN'
                                         SINR_db = [1.5,5.7,4.5,8.7,12.5,15.4,16.1,19.3,20.1,20.9];
                                     case 'Rayleigh'
                                         SINR_db = [35,43.4,38,46.4,46,51.8,46.6,53,54.6,56.2];                                       
                                 end
                                 
                                 Pr_min = SINR_db + Interf_Noise;        
                                 PL_target = Ptx + G_ant - Cable_losses - Pr_min;                
                                 x = ht_cords(1);          
                                 y = ht_cords(2);

                                 switch link_con(link_num).channel.path_loss_model

                                     case 'FSPL'

                                         tput_distance = 10.^((PL_target-20*log10(freq)-32.44)/20);
                                         
                                         if dlosh > tput_distance(1)
                                         
                                         set(handles.range_display_text, 'String',tput_distance(1)) 
%                                          
                                         colour = 'y'; 
                                         %BPSK 1/2                                 
                                         handles.tput_plot1 = tput_plot(x,y,tput_distance(1) ,handles.map,colour);
                                         txt1 = [ num2str(phy_tput_frame(1)) ' Mbps' ' (BPSK 1/2)']; 
                                         
                                         
                                         colour = [216/255 133/255 49/255]; 
                                         %BPSK 3/4 
                                         handles.tput_plot2 = tput_plot(x,y,tput_distance(2) ,handles.map,colour);
                                         txt2 = [num2str(phy_tput_frame(2)) ' Mbps' ' (BPSK 3/4)'];

                                         colour = [7/255 164/255 18/255]; 
                                         %QPSK 1/2             
                                         handles.tput_plot3= tput_plot(x,y,tput_distance(3) ,handles.map,colour);
                                         txt3 = [num2str(phy_tput_frame(3)) ' Mbps' ' (QPSK 1/2)'];

                                         colour = [116/255 11/255 128/255]; 
                                         %QPSK 3/4                                 
                                         handles.tput_plot4 = tput_plot(x,y,tput_distance(4) ,handles.map,colour);
                                         txt4 = [num2str(phy_tput_frame(4)) ' Mbps' ' (QPSK 3/4)'];

                                         colour = 'c'; 
                                         %16QAM 1/2  
                                         handles.tput_plot5 = tput_plot(x,y,tput_distance(5) ,handles.map,colour);
                                         txt5 = [num2str(phy_tput_frame(5)) ' Mbps' ' (16QAM 1/2)'];

                                         colour = 'b'; 
                                         %16QAM 3/4               
                                         handles.tput_plot6= tput_plot(x,y,tput_distance(6) ,handles.map,colour);
                                         txt6 = [num2str(phy_tput_frame(6)) ' Mbps' ' (16QAM 3/4)'];

                                         colour = 'm'; 
                                         %64QAM 1/2                                 
                                         handles.tput_plot7 = tput_plot(x,y,tput_distance(7) ,handles.map,colour); 
                                         txt7 = [num2str(phy_tput_frame(7)) ' Mbps' ' (64QAM 1/2)'];

                                         colour = 'g';
                                         %64QAM 2/3 
                                         handles.tput_plot8 = tput_plot(x,y,tput_distance(8) ,handles.map,colour);
                                         txt8 = [num2str(phy_tput_frame(8)) ' Mbps' ' (64QAM 2/3)'];

                                         colour = [243/255 197/255 91/255]; 
                                         %64QAM 3/4                 
                                         handles.tput_plot9= tput_plot(x,y,tput_distance(9) ,handles.map,colour);
                                         txt9 = [num2str(phy_tput_frame(9)) ' Mbps' ' (64QAM 3/4)'];

                                         colour = [127/255 0/255 255/255];
                                         %64QAM 5/6                 
                                         handles.tput_plot10= tput_plot(x,y,tput_distance(10) ,handles.map,colour);
                                         txt10 = [num2str(phy_tput_frame(10)) ' Mbps' ' (64QAM 5/6)'];
                                     
                                         i_am_legend = legend(handles.map,[handles.tput_plot1,handles.tput_plot2,handles.tput_plot3,handles.tput_plot4,handles.tput_plot5,handles.tput_plot6,handles.tput_plot7,handles.tput_plot8,handles.tput_plot9,handles.tput_plot10],{txt1,txt2,txt3,txt4,txt5,txt6,txt7,txt8,txt9,txt10},'Location','best');
                                         title(i_am_legend,'LTE PHY Throuput per MCS')
                                         
                                         end

                                     case '2-Ray'

                                         tput_distance = [two_ray(PL_target(1), ht, hr, freq),two_ray(PL_target(2), ht, hr, freq),two_ray(PL_target(3), ht, hr, freq),two_ray(PL_target(4), ht, hr, freq),two_ray(PL_target(5), ht, hr, freq),two_ray(PL_target(6), ht, hr, freq),two_ray(PL_target(7), ht, hr, freq),two_ray(PL_target(8), ht, hr, freq),two_ray(PL_target(9), ht, hr, freq),two_ray(PL_target(10), ht, hr, freq)];
                                         tput_distance = tput_distance*10^-3;
                                         
                                         if dlosh > tput_distance(1)

                                         set(handles.range_display_text, 'String',tput_distance(1)) 
                                          
                                         colour = 'y'; 
                                         %BPSK 1/2                                 
                                         handles.tput_plot1 = tput_plot(x,y,tput_distance(1) ,handles.map,colour);
                                         txt1 = [ num2str(phy_tput_frame(1)) ' Mbps' ' (BPSK 1/2)']; 
                                         
                                         colour = [216/255 133/255 49/255]; 
                                         %BPSK 3/4 
                                         handles.tput_plot2 = tput_plot(x,y,tput_distance(2) ,handles.map,colour);
                                         txt2 = [num2str(phy_tput_frame(2)) ' Mbps' ' (BPSK 3/4)'];

                                         colour = [7/255 164/255 18/255]; 
                                         %QPSK 1/2             
                                         handles.tput_plot3= tput_plot(x,y,tput_distance(3) ,handles.map,colour);
                                         txt3 = [num2str(phy_tput_frame(3)) ' Mbps' ' (QPSK 1/2)'];

                                         colour = [116/255 11/255 128/255]; 
                                         %QPSK 3/4                                 
                                         handles.tput_plot4 = tput_plot(x,y,tput_distance(4) ,handles.map,colour);
                                         txt4 = [num2str(phy_tput_frame(4)) ' Mbps' ' (QPSK 3/4)'];

                                         colour = 'c'; 
                                         %16QAM 1/2  
                                         handles.tput_plot5 = tput_plot(x,y,tput_distance(5) ,handles.map,colour);
                                         txt5 = [num2str(phy_tput_frame(5)) ' Mbps' ' (16QAM 1/2)'];

                                         colour = 'b'; 
                                         %16QAM 3/4               
                                         handles.tput_plot6= tput_plot(x,y,tput_distance(6) ,handles.map,colour);
                                         txt6 = [num2str(phy_tput_frame(6)) ' Mbps' ' (16QAM 3/4)'];

                                         colour = 'm'; 
                                         %64QAM 1/2                                 
                                         handles.tput_plot7 = tput_plot(x,y,tput_distance(7) ,handles.map,colour); 
                                         txt7 = [num2str(phy_tput_frame(7)) ' Mbps' ' (64QAM 1/2)'];

                                         colour = 'g';
                                         %64QAM 2/3 
                                         handles.tput_plot8 = tput_plot(x,y,tput_distance(8) ,handles.map,colour);
                                         txt8 = [num2str(phy_tput_frame(8)) ' Mbps' ' (64QAM 2/3)'];

                                         colour = [243/255 197/255 91/255]; 
                                         %64QAM 3/4                 
                                         handles.tput_plot9= tput_plot(x,y,tput_distance(9) ,handles.map,colour);
                                         txt9 = [num2str(phy_tput_frame(9)) ' Mbps' ' (64QAM 3/4)'];

                                         colour = [127/255 0/255 255/255];
                                         %64QAM 5/6                 
                                         handles.tput_plot10= tput_plot(x,y,tput_distance(10) ,handles.map,colour);
                                         txt10 = [num2str(phy_tput_frame(10)) ' Mbps' ' (64QAM 5/6)'];
                                     
                                         i_am_legend = legend(handles.map,[handles.tput_plot1,handles.tput_plot2,handles.tput_plot3,handles.tput_plot4,handles.tput_plot5,handles.tput_plot6,handles.tput_plot7,handles.tput_plot8,handles.tput_plot9,handles.tput_plot10],{txt1,txt2,txt3,txt4,txt5,txt6,txt7,txt8,txt9,txt10},'Location','best');
                                         title(i_am_legend,'LTE PHY Throuput per MCS')   
                                         
                                         end

                                     case '3-Ray'
                                         tput_distance = [three_ray(PL_target(1), ht, hr, freq),three_ray(PL_target(2), ht, hr, freq),three_ray(PL_target(3), ht, hr, freq),three_ray(PL_target(4), ht, hr, freq),three_ray(PL_target(5), ht, hr, freq),three_ray(PL_target(6), ht, hr, freq),three_ray(PL_target(7), ht, hr, freq),three_ray(PL_target(8), ht, hr, freq),three_ray(PL_target(9), ht, hr, freq),three_ray(PL_target(10), ht, hr, freq)];
                                         tput_distance = tput_distance*10^-3;   
                                         
                                         if dlosh > tput_distance(1)

                                         set(handles.range_display_text, 'String',tput_distance(1)) 
                                         
                                         colour = 'y'; 
                                         %BPSK 1/2                                 
                                         handles.tput_plot1 = tput_plot(x,y,tput_distance(1) ,handles.map,colour);
                                         txt1 = [ num2str(phy_tput_frame(1)) ' Mbps' ' (BPSK 1/2)']; 
                                         
                                         colour = [216/255 133/255 49/255]; 
                                         %BPSK 3/4 
                                         handles.tput_plot2 = tput_plot(x,y,tput_distance(2) ,handles.map,colour);
                                         txt2 = [num2str(phy_tput_frame(2)) ' Mbps' ' (BPSK 3/4)'];

                                         colour = [7/255 164/255 18/255]; 
                                         %QPSK 1/2             
                                         handles.tput_plot3= tput_plot(x,y,tput_distance(3) ,handles.map,colour);
                                         txt3 = [num2str(phy_tput_frame(3)) ' Mbps' ' (QPSK 1/2)'];

                                         colour = [116/255 11/255 128/255]; 
                                         %QPSK 3/4                                 
                                         handles.tput_plot4 = tput_plot(x,y,tput_distance(4) ,handles.map,colour);
                                         txt4 = [num2str(phy_tput_frame(4)) ' Mbps' ' (QPSK 3/4)'];

                                         colour = 'c'; 
                                         %16QAM 1/2  
                                         handles.tput_plot5 = tput_plot(x,y,tput_distance(5) ,handles.map,colour);
                                         txt5 = [num2str(phy_tput_frame(5)) ' Mbps' ' (16QAM 1/2)'];

                                         colour = 'b'; 
                                         %16QAM 3/4               
                                         handles.tput_plot6= tput_plot(x,y,tput_distance(6) ,handles.map,colour);
                                         txt6 = [num2str(phy_tput_frame(6)) ' Mbps' ' (16QAM 3/4)'];

                                         colour = 'm'; 
                                         %64QAM 1/2                                 
                                         handles.tput_plot7 = tput_plot(x,y,tput_distance(7) ,handles.map,colour); 
                                         txt7 = [num2str(phy_tput_frame(7)) ' Mbps' ' (64QAM 1/2)'];

                                         colour = 'g';
                                         %64QAM 2/3 
                                         handles.tput_plot8 = tput_plot(x,y,tput_distance(8) ,handles.map,colour);
                                         txt8 = [num2str(phy_tput_frame(8)) ' Mbps' ' (64QAM 2/3)'];

                                         colour = [243/255 197/255 91/255]; 
                                         %64QAM 3/4                 
                                         handles.tput_plot9= tput_plot(x,y,tput_distance(9) ,handles.map,colour);
                                         txt9 = [num2str(phy_tput_frame(9)) ' Mbps' ' (64QAM 3/4)'];

                                         colour = [127/255 0/255 255/255];
                                         %64QAM 5/6                 
                                         handles.tput_plot10= tput_plot(x,y,tput_distance(10) ,handles.map,colour);
                                         txt10 = [num2str(phy_tput_frame(10)) ' Mbps' ' (64QAM 5/6)'];
                                     
                                         i_am_legend = legend(handles.map,[handles.tput_plot1,handles.tput_plot2,handles.tput_plot3,handles.tput_plot4,handles.tput_plot5,handles.tput_plot6,handles.tput_plot7,handles.tput_plot8,handles.tput_plot9,handles.tput_plot10],{txt1,txt2,txt3,txt4,txt5,txt6,txt7,txt8,txt9,txt10},'Location','best');
                                         title(i_am_legend,'LTE PHY Throuput per MCS')     
                                         
                                         end

                                     case 'Sea Radio-Wave Propagation Loss'
                                         tput_distance = [srwpl(PL_target(1), ht, hr, freq),srwpl(PL_target(2), ht, hr, freq),srwpl(PL_target(3), ht, hr, freq),srwpl(PL_target(4), ht, hr, freq),srwpl(PL_target(5), ht, hr, freq),srwpl(PL_target(6), ht, hr, freq),srwpl(PL_target(7), ht, hr, freq),srwpl(PL_target(8), ht, hr, freq),srwpl(PL_target(9), ht, hr, freq),srwpl(PL_target(10), ht, hr, freq)];
                                         tput_distance = tput_distance*10^-3;   
                                         
                                         if dlosh > tput_distance(1)

                                         set(handles.range_display_text, 'String',tput_distance(1)) 
                                         
                                         colour = 'y'; 
                                         %BPSK 1/2                                 
                                         handles.tput_plot1 = tput_plot(x,y,tput_distance(1) ,handles.map,colour);
                                         txt1 = [ num2str(phy_tput_frame(1)) ' Mbps' ' (BPSK 1/2)']; 
                                         
                                         colour = [216/255 133/255 49/255]; 
                                         %BPSK 3/4 
                                         handles.tput_plot2 = tput_plot(x,y,tput_distance(2) ,handles.map,colour);
                                         txt2 = [num2str(phy_tput_frame(2)) ' Mbps' ' (BPSK 3/4)'];

                                         colour = [7/255 164/255 18/255]; 
                                         %QPSK 1/2             
                                         handles.tput_plot3= tput_plot(x,y,tput_distance(3) ,handles.map,colour);
                                         txt3 = [num2str(phy_tput_frame(3)) ' Mbps' ' (QPSK 1/2)'];

                                         colour = [116/255 11/255 128/255]; 
                                         %QPSK 3/4                                 
                                         handles.tput_plot4 = tput_plot(x,y,tput_distance(4) ,handles.map,colour);
                                         txt4 = [num2str(phy_tput_frame(4)) ' Mbps' ' (QPSK 3/4)'];

                                         colour = 'c'; 
                                         %16QAM 1/2  
                                         handles.tput_plot5 = tput_plot(x,y,tput_distance(5) ,handles.map,colour);
                                         txt5 = [num2str(phy_tput_frame(5)) ' Mbps' ' (16QAM 1/2)'];

                                         colour = 'b'; 
                                         %16QAM 3/4               
                                         handles.tput_plot6= tput_plot(x,y,tput_distance(6) ,handles.map,colour);
                                         txt6 = [num2str(phy_tput_frame(6)) ' Mbps' ' (16QAM 3/4)'];

                                         colour = 'm'; 
                                         %64QAM 1/2                                 
                                         handles.tput_plot7 = tput_plot(x,y,tput_distance(7) ,handles.map,colour); 
                                         txt7 = [num2str(phy_tput_frame(7)) ' Mbps' ' (64QAM 1/2)'];

                                         colour = 'g';
                                         %64QAM 2/3 
                                         handles.tput_plot8 = tput_plot(x,y,tput_distance(8) ,handles.map,colour);
                                         txt8 = [num2str(phy_tput_frame(8)) ' Mbps' ' (64QAM 2/3)'];

                                         colour = [243/255 197/255 91/255]; 
                                         %64QAM 3/4                 
                                         handles.tput_plot9= tput_plot(x,y,tput_distance(9) ,handles.map,colour);
                                         txt9 = [num2str(phy_tput_frame(9)) ' Mbps' ' (64QAM 3/4)'];

                                         colour = [127/255 0/255 255/255];
                                         %64QAM 5/6                 
                                         handles.tput_plot10= tput_plot(x,y,tput_distance(10) ,handles.map,colour);
                                         txt10 = [num2str(phy_tput_frame(10)) ' Mbps' ' (64QAM 5/6)'];
                                     
                                         i_am_legend = legend(handles.map,[handles.tput_plot1,handles.tput_plot2,handles.tput_plot3,handles.tput_plot4,handles.tput_plot5,handles.tput_plot6,handles.tput_plot7,handles.tput_plot8,handles.tput_plot9,handles.tput_plot10],{txt1,txt2,txt3,txt4,txt5,txt6,txt7,txt8,txt9,txt10},'Location','best');
                                         title(i_am_legend,'LTE PHY Throuput per MCS') 
                                         
                                         end
                                 end 
                                 
                                 

                             otherwise

                                 Qm = [2,4,6];
                                 Rb = ((RE_frame*Qm)/(10*10^-3)); 
                                 EbN0 = [EbN0_value(ber_target,'QPSK',channel_type),EbN0_value(ber_target,'16QAM',channel_type),EbN0_value(ber_target,'64QAM',channel_type)];

                                 SINR = EbN0.*(Rb/B_noise);         
                                 SINR_db = 10*log10(SINR);                  
                                 Pr_min = SINR_db + Interf_Noise;        
                                 PL_target = Ptx + G_ant - Cable_losses - Pr_min;                
                                 x = ht_cords(1);          
                                 y = ht_cords(2);
                                 
                                 phy_tput_frame = ((PDSCH_RE_frame*Qm)/(10*10^-3))/10^6;
                                 set(handles.throughput_display_text, 'String',phy_tput_frame(1)) 
                                 

                                 switch link_con(link_num).channel.path_loss_model

                                     case 'FSPL'

                                         tput_distance = 10.^((PL_target-20*log10(freq)-32.44)/20);
                                         
                                         if dlosh > tput_distance(1)
                                         
                                         set(handles.range_display_text, 'String',tput_distance(1)) 

                                         colour = 'y'; 
                                         %QPSK                                  
                                         handles.tput_plot1 = tput_plot(x,y,tput_distance(1) ,handles.map,colour);
                                         txt1 = [ num2str(phy_tput_frame(1)) ' Mbps' ' (QPSK)']; 
                                         
                                         colour = 'b'; 
                                         %16QAM
                                         handles.tput_plot2 = tput_plot(x,y,tput_distance(2) ,handles.map,colour);
                                         txt2 = [num2str(phy_tput_frame(2)) ' Mbps' ' (16QAM)'];

                                         colour = 'g';
                                         %64QAM                 
                                         handles.tput_plot3= tput_plot(x,y,tput_distance(3) ,handles.map,colour);
                                         txt3 = [num2str(phy_tput_frame(3)) ' Mbps' ' (64QAM)'];
                                         
                                         i_am_legend = legend(handles.map,[handles.tput_plot1,handles.tput_plot2,handles.tput_plot3],{txt1,txt2,txt3},'Location','best');
                                         title(i_am_legend,'LTE PHY Throuput per Mod. Sch.')
                                         
                                         end
                                         
                                     case '2-Ray'

                                         tput_distance = [two_ray(PL_target(1), ht, hr, freq),two_ray(PL_target(2), ht, hr, freq),two_ray(PL_target(3), ht, hr, freq)];
                                         tput_distance = tput_distance*10^-3;
                                         
                                         if dlosh > tput_distance(1)
                                         
                                         set(handles.range_display_text, 'String',tput_distance(1)) 

                                         colour = 'y'; 
                                         %QPSK                                  
                                         handles.tput_plot1 = tput_plot(x,y,tput_distance(1) ,handles.map,colour);
                                         txt1 = [ num2str(phy_tput_frame(1)) ' Mbps' ' (QPSK)']; 
                                         
                                         colour = 'b'; 
                                         %16QAM
                                         handles.tput_plot2 = tput_plot(x,y,tput_distance(2) ,handles.map,colour);
                                         txt2 = [num2str(phy_tput_frame(2)) ' Mbps' ' (16QAM)'];

                                         colour = 'g';
                                         %64QAM                 
                                         handles.tput_plot3= tput_plot(x,y,tput_distance(3) ,handles.map,colour);
                                         txt3 = [num2str(phy_tput_frame(3)) ' Mbps' ' (64QAM)'];
                                         
                                         i_am_legend = legend(handles.map,[handles.tput_plot1,handles.tput_plot2,handles.tput_plot3],{txt1,txt2,txt3},'Location','best');
                                         title(i_am_legend,'LTE PHY Throuput per Mod. Sch.')
                                         
                                         end
                                         
                                     case '3-Ray'
                                         tput_distance = [three_ray(PL_target(1), ht, hr, freq),three_ray(PL_target(2), ht, hr, freq),three_ray(PL_target(3), ht, hr, freq)];
                                         tput_distance = tput_distance*10^-3;   
                                         
                                         if dlosh > tput_distance(1)
                                         
                                         set(handles.range_display_text, 'String',tput_distance(1)) 

                                         colour = 'y'; 
                                         %QPSK                                  
                                         handles.tput_plot1 = tput_plot(x,y,tput_distance(1) ,handles.map,colour);
                                         txt1 = [ num2str(phy_tput_frame(1)) ' Mbps' ' (QPSK)']; 
                                         
                                         colour = 'b'; 
                                         %16QAM
                                         handles.tput_plot2 = tput_plot(x,y,tput_distance(2) ,handles.map,colour);
                                         txt2 = [num2str(phy_tput_frame(2)) ' Mbps' ' (16QAM)'];

                                         colour = 'g';
                                         %64QAM                 
                                         handles.tput_plot3= tput_plot(x,y,tput_distance(3) ,handles.map,colour);
                                         txt3 = [num2str(phy_tput_frame(3)) ' Mbps' ' (64QAM)'];
                                         
                                         i_am_legend = legend(handles.map,[handles.tput_plot1,handles.tput_plot2,handles.tput_plot3],{txt1,txt2,txt3},'Location','best');
                                         title(i_am_legend,'LTE PHY Throuput per Mod. Sch.')
                                         
                                         end

                                     case 'Sea Radio-Wave Propagation Loss'
                                         tput_distance = [srwpl(PL_target(1), ht, hr, freq),srwpl(PL_target(2), ht, hr, freq),srwpl(PL_target(3), ht, hr, freq)];
                                         tput_distance = tput_distance*10^-3; 
                                         
                                         if dlosh > tput_distance(1)
                                         
                                         set(handles.range_display_text, 'String',tput_distance(1)) 

                                         colour = 'y'; 
                                         %QPSK                                  
                                         handles.tput_plot1 = tput_plot(x,y,tput_distance(1) ,handles.map,colour);
                                         txt1 = [ num2str(phy_tput_frame(1)) ' Mbps' ' (QPSK)']; 
                                         
                                         colour = 'b'; 
                                         %16QAM
                                         handles.tput_plot2 = tput_plot(x,y,tput_distance(2) ,handles.map,colour);
                                         txt2 = [num2str(phy_tput_frame(2)) ' Mbps' ' (16QAM)'];

                                         colour = 'g';
                                         %64QAM                 
                                         handles.tput_plot3= tput_plot(x,y,tput_distance(3) ,handles.map,colour);
                                         txt3 = [num2str(phy_tput_frame(3)) ' Mbps' ' (64QAM)'];
                                         
                                         i_am_legend = legend(handles.map,[handles.tput_plot1,handles.tput_plot2,handles.tput_plot3],{txt1,txt2,txt3},'Location','best');
                                         title(i_am_legend,'LTE PHY Throuput per Mod. Sch.')  
                                         
                                         end
                                 end                
                         end


                     case 'NWR'

                         Qm = 2;
                         datarate = 520.83; 

                         Rb = 520.83; 

                         B_noise = link_con(link_num).receiver.rx_bandwidth*10^6;
                         mod_sch = 'FSK';
                         EbN0 = EbN0_value(ber_target,mod_sch,channel_type);
                         SINR = EbN0*(Rb/B_noise);
                         SINR_db = 10*log10(SINR);
                         Pr_min = SINR_db + Interf_Noise;
                         PL_target = Ptx + G_ant - Cable_losses - Pr_min;

                         x = ht_cords(1);  
                         y = ht_cords(2);
                         
                         nwr_throughput = 520.83;%bps
                         set(handles.throughput_display_text, 'String',(nwr_throughput*10^-6)) 

                         switch link_con(link_num).channel.path_loss_model

                                     case 'FSPL'

                                         tput_distance = 10^((PL_target-20*log10(freq)-32.44)/20);
                                         
                                         if dlosh > tput_distance(1)


                                         colour = 'b';
                                         handles.tput_plot1 = tput_plot(x,y,tput_distance ,handles.map,colour);
                                         txt1 = [ num2str(nwr_throughput) ' bps' ' (FSK)']; 
                                         i_am_legend = legend(handles.map,[handles.tput_plot1],{txt1},'Location','best');
                                         title(i_am_legend,'NWR Throuput per Mod. Sch.') 
                                         
                                         set(handles.range_display_text, 'String',tput_distance)
                                         
                                         end


                                     case '2-Ray'

                                         tput_distance = two_ray(PL_target, ht, hr, freq);
                                         tput_distance = tput_distance*10^-3;
                                         
                                         if dlosh > tput_distance(1)

                                         colour = 'b';
                                         handles.tput_plot1 = tput_plot(x,y,tput_distance ,handles.map,colour);
                                         txt1 = [ num2str(nwr_throughput) ' bps' ' (FSK)']; 
                                         i_am_legend = legend(handles.map,[handles.tput_plot1],{txt1},'Location','best');
                                         title(i_am_legend,'NWR Throuput per Mod. Sch.') 
                                         
                                         set(handles.range_display_text, 'String',tput_distance)
                                         
                                         end
                                         
                                     case '3-Ray'
                                         tput_distance = three_ray(PL_target, ht, hr, freq);
                                         tput_distance = tput_distance*10^-3;    
                                         
                                         if dlosh > tput_distance(1)

                                         colour = 'b';
                                         handles.tput_plot1 = tput_plot(x,y,tput_distance ,handles.map,colour);
                                         txt1 = [ num2str(nwr_throughput) ' bps' ' (FSK)']; 
                                         i_am_legend = legend(handles.map,[handles.tput_plot1],{txt1},'Location','best');
                                         title(i_am_legend,'LTE PHY Throuput per Mod. Sch.') 
                                         
                                         set(handles.range_display_text, 'String',tput_distance)
                                         
                                         end
                                         
                                     case 'Sea Radio-Wave Propagation Loss'
                                         tput_distance = srwpl(PL_target, ht, hr, freq);
                                         tput_distance = tput_distance*10^-3;     
                                         
                                         if dlosh > tput_distance(1)

                                         colour = 'b';
                                         handles.tput_plot1 = tput_plot(x,y,tput_distance ,handles.map,colour);
                                         txt1 = [ num2str(nwr_throughput) ' bps' ' (FSK)']; 
                                         i_am_legend = legend(handles.map,[handles.tput_plot1],{txt1},'Location','best');
                                         title(i_am_legend,'NWR Throuput per Mod. Sch.') 
                                         
                                         set(handles.range_display_text, 'String',tput_distance)
                                         
                                         end
                         end




                     case 'Generic'    
                         Qm = [2,4,6];
                         Rb = ((RE_frame*Qm)/(10*10^-3)); 

                         EbN0 = [EbN0_value(ber_target,'QPSK',channel_type),EbN0_value(ber_target,'16QAM',channel_type),EbN0_value(ber_target,'64QAM',channel_type)];
                         SINR = EbN0.*(Rb/B_noise);
                         SINR_db = 10*log10(SINR);

                         Pr_min = SINR_db + Interf_Noise;
                         PL_target = Ptx + G_ant - Cable_losses - Pr_min;

                         x = ht_cords(1);  
                         y = ht_cords(2);
                         
                         phy_tput_frame = ((PDSCH_RE_frame*Qm)/(10*10^-3))/10^6;
                         set(handles.throughput_display_text, 'String',phy_tput_frame) 


                         switch link_con(link_num).channel.path_loss_model

                             case 'FSPL'

                                 tput_distance = 10.^((PL_target-20*log10(freq)-32.44)/20);
                                 
                                 if dlosh > tput_distance(1)

                                                
                                 colour = 'y'; 
                                 %QPSK                                  
                                 handles.tput_plot1 = tput_plot(x,y,tput_distance(1) ,handles.map,colour);
                                 txt1 = [ num2str(phy_tput_frame(1)) ' Mbps' ' (QPSK)']; 

                                 colour = 'b'; 
                                 %16QAM
                                 handles.tput_plot2 = tput_plot(x,y,tput_distance(2) ,handles.map,colour);
                                 txt2 = [num2str(phy_tput_frame(2)) ' Mbps' ' (16QAM)'];

                                 colour = 'g';
                                 %64QAM                 
                                 handles.tput_plot3= tput_plot(x,y,tput_distance(3) ,handles.map,colour);
                                 txt3 = [num2str(phy_tput_frame(3)) ' Mbps' ' (64QAM)'];

                                 i_am_legend = legend(handles.map,[handles.tput_plot1,handles.tput_plot2,handles.tput_plot3],{txt1,txt2,txt3},'Location','best');
                                 title(i_am_legend,'Generic Throuput per Mod. Sch.') 
                                 
                                 end

                             case '2-Ray'

                                 tput_distance = [two_ray(PL_target(1), ht, hr, freq),two_ray(PL_target(2), ht, hr, freq),two_ray(PL_target(3), ht, hr, freq)];
                                 tput_distance = tput_distance*10^-3;
                                 
                                 if dlosh > tput_distance(1)

                                 colour = 'y'; 
                                 %QPSK                                  
                                 handles.tput_plot1 = tput_plot(x,y,tput_distance(1) ,handles.map,colour);
                                 txt1 = [ num2str(phy_tput_frame(1)) ' Mbps' ' (QPSK)']; 

                                 colour = 'b'; 
                                 %16QAM
                                 handles.tput_plot2 = tput_plot(x,y,tput_distance(2) ,handles.map,colour);
                                 txt2 = [num2str(phy_tput_frame(2)) ' Mbps' ' (16QAM)'];

                                 colour = 'g';
                                 %64QAM                 
                                 handles.tput_plot3= tput_plot(x,y,tput_distance(3) ,handles.map,colour);
                                 txt3 = [num2str(phy_tput_frame(3)) ' Mbps' ' (64QAM)'];

                                 i_am_legend = legend(handles.map,[handles.tput_plot1,handles.tput_plot2,handles.tput_plot3],{txt1,txt2,txt3},'Location','best');
                                 title(i_am_legend,'Generic Throuput per Mod. Sch.') 
                                 
                                 end
                                 
                             case '3-Ray'
                                 tput_distance = [three_ray(PL_target(1), ht, hr, freq),three_ray(PL_target(2), ht, hr, freq),three_ray(PL_target(3), ht, hr, freq)];
                                 tput_distance = tput_distance*10^-3;   
                                 
                                 if dlosh > tput_distance(1)

                                 colour = 'y'; 
                                 %QPSK                                  
                                 handles.tput_plot1 = tput_plot(x,y,tput_distance(1) ,handles.map,colour);
                                 txt1 = [ num2str(phy_tput_frame(1)) ' Mbps' ' (QPSK)']; 

                                 colour = 'b'; 
                                 %16QAM
                                 handles.tput_plot2 = tput_plot(x,y,tput_distance(2) ,handles.map,colour);
                                 txt2 = [num2str(phy_tput_frame(2)) ' Mbps' ' (16QAM)'];

                                 colour = 'g';
                                 %64QAM                 
                                 handles.tput_plot3= tput_plot(x,y,tput_distance(3) ,handles.map,colour);
                                 txt3 = [num2str(phy_tput_frame(3)) ' Mbps' ' (64QAM)'];

                                 i_am_legend = legend(handles.map,[handles.tput_plot1,handles.tput_plot2,handles.tput_plot3],{txt1,txt2,txt3},'Location','best');
                                 title(i_am_legend,'Generic Throuput per Mod. Sch.') 
                                 
                                 end
                                 
                             case 'Sea Radio-Wave Propagation Loss'
                                 tput_distance = [srwpl(PL_target(1), ht, hr, freq),srwpl(PL_target(2), ht, hr, freq),srwpl(PL_target(3), ht, hr, freq)];
                                 tput_distance = tput_distance*10^-3;   
                                 
                                 if dlosh > tput_distance(1)

                                 colour = 'y'; 
                                 %QPSK                                  
                                 handles.tput_plot1 = tput_plot(x,y,tput_distance(1) ,handles.map,colour);
                                 txt1 = [ num2str(phy_tput_frame(1)) ' Mbps' ' (QPSK)']; 

                                 colour = 'b'; 
                                 %16QAM
                                 handles.tput_plot2 = tput_plot(x,y,tput_distance(2) ,handles.map,colour);
                                 txt2 = [num2str(phy_tput_frame(2)) ' Mbps' ' (16QAM)'];

                                 colour = 'g';
                                 %64QAM                 
                                 handles.tput_plot3= tput_plot(x,y,tput_distance(3) ,handles.map,colour);
                                 txt3 = [num2str(phy_tput_frame(3)) ' Mbps' ' (64QAM)'];

                                 i_am_legend = legend(handles.map,[handles.tput_plot1,handles.tput_plot2,handles.tput_plot3],{txt1,txt2,txt3},'Location','best');
                                 title(i_am_legend,'Generic Throuput per Mod. Sch.') 
                                 
                                 end
                         end


                end
                
                if dlosh > tput_distance(1)
                 
                    set(handles.range_display_text, 'String',tput_distance(1))
                     
                     
                else
                    %Plot LOSH
                    plotted_range = range_plot(dlosh_cords(1)  ,dlosh_cords(2)  ,d_losh,handles.map);
                    
                    set(handles.range_display_text, 'String',dlosh)
                    set(handles.rx_sens_text, 'String','N/A')
                    set(handles.ber_display_text, 'String','N/A')
                    set(handles.node_display_text, 'String',link_con(link_num).link_name)
                    set(handles.path_loss_disp_text, 'String', 'N/A');
                    
                    %set(handles.techno_disp_text, 'String',node_con(nod_num).equipment_params.technology )
                    set(handles.service_disp_text, 'String','N/A' )
                    set(handles.techno_disp_text, 'String','N/A' )
                    set(handles.throughput_display_text, 'String','N/A')
                    set(handles.freq_disp_text, 'String', 'N/A');
                    set(handles.interf_disp_text, 'String', 'N/A');
                    set(handles.fade_disp_text, 'String', 'N/A');
                    
                end