 
  switch link_con(link_num).technology 

     case 'DSC'


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
%             handles.tput_text = text(shift,y,txt, 'HorizontalAlignment','left','Color','red','FontSize',14);
            handles.tput_plotting = tput_plot(x,y,throughpt,handles.map);         
    end
end

%these last two ends were not here 


function circl = tput_plot(x,y,r,ax)
hold on
ang = 0:pi/50:2*pi;
% xunit = ((r/1.1132)*0.01) * cos(ang) + x;
% yunit = ((r/1.1132)*0.01) * sin(ang) + y;
xunit = ((r/0.011132)*0.0001) * cos(ang) + x; %decimal coordinates to four decimal places 
yunit = ((r/0.011132)*0.0001) * sin(ang) + y; %decimal coordinates to four decimal places 
circl = plot(ax,xunit, yunit, 'b', 'LineWidth',2); 
hold off




%%
switch link_con(link_num).technology 

     case 'DSC'


     case 'LTE-A'
         B_sys = link_con(link_num).system_params.system_bandwidth;
         set(handles.freq_disp_text, 'String', B_sys);
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

         Qm = 2;
         PDSCH_RE_frame = 4912; %Extended CP, CFI = 3, BW = 1.4 MHz
         phy_tput_frame = ((PDSCH_RE_frame*Qm)/(10*10^-3))/10^6; %SISO

         Rb = phy_tput_frame; 

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
         PDSCH_RE_frame = 4912; %Extended CP, CFI = 3, BW = 1.4 MHz
         phy_tput_frame = ((PDSCH_RE_frame*Qm)/(10*10^-3))/10^6; %SISO

         Rb = phy_tput_frame; 

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

         Qm = 2;
         PDSCH_RE_frame = 4912; %Extended CP, CFI = 3, BW = 1.4 MHz
         phy_tput_frame = ((PDSCH_RE_frame*Qm)/(10*10^-3))/10^6; %SISO

         Rb = phy_tput_frame; 

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

     otherwise


end
 
 %%
 
B_sys = link_con(link_num).system_params.system_bandwidth;
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

%%

                                         %BPSK 1/2                                 
                                         handles.tput_plot1 = tput_plot(x,y,tput_distance(1) ,handles.map);
                                         txt = ['\rightarrow'  num2str(phy_tput_frame(1)) ' Mbps'];
                                         handles.tput_text1 = text((x+tput_distance(1)),y,txt, 'HorizontalAlignment','left','Color','white','FontSize',14);

                                         %BPSK 3/4 
                                         handles.tput_plot2 = tput_plot(x,y,tput_distance(2) ,handles.map);
                                         txt = ['\rightarrow'  num2str(phy_tput_frame(2)) ' Mbps'];
                                         handles.tput_text2 = text((x+tput_distance(2)),(y),txt, 'HorizontalAlignment','left','Color','white','FontSize',14);

                                         %QPSK 1/2             
                                         handles.tput_plot3= tput_plot(x,y,tput_distance(3) ,handles.map);
                                         txt = ['\rightarrow'  num2str(phy_tput_frame(3)) ' Mbps'];
                                         handles.tput_text3 = text((x+tput_distance(3)),(y),txt, 'HorizontalAlignment','left','Color','white','FontSize',14);

                                         %QPSK 3/4                                 
                                         handles.tput_plot4 = tput_plot(x,y,tput_distance(4) ,handles.map);
                                         txt = ['\rightarrow'  num2str(phy_tput_frame(4)) ' Mbps'];
                                         handles.tput_text4 = text((x+tput_distance(4)),(y),txt, 'HorizontalAlignment','left','Color','white','FontSize',14);

                                         %16QAM 1/2  
                                         handles.tput_plot5 = tput_plot(x,y,tput_distance(5) ,handles.map);
                                         txt = ['\rightarrow'  num2str(phy_tput_frame(5)) ' Mbps'];
                                         handles.tput_text5 = text((x+tput_distance(5)),(y),txt, 'HorizontalAlignment','left','Color','white','FontSize',14);

                                         %16QAM 3/4               
                                         handles.tput_plot6= tput_plot(x,y,tput_distance(6) ,handles.map);
                                         txt = ['\rightarrow'  num2str(phy_tput_frame(6)) ' Mbps'];
                                         handles.tput_text6 = text((x+tput_distance(6)),(y),txt, 'HorizontalAlignment','left','Color','white','FontSize',14);

                                         %64QAM 1/2                                 
                                         handles.tput_plot7 = tput_plot(x,y,tput_distance(7) ,handles.map); 
                                         txt = ['\rightarrow'  num2str(phy_tput_frame(7)) ' Mbps'];
                                         handles.tput_text7 = text((x+tput_distance(7)),(y),txt, 'HorizontalAlignment','left','Color','white','FontSize',14);

                                         %64QAM 2/3 
                                         handles.tput_plot8 = tput_plot(x,y,tput_distance(8) ,handles.map);
                                         txt = ['\rightarrow'  num2str(phy_tput_frame(8)) ' Mbps'];
                                         handles.tput_text8 = text((x+tput_distance(8)),(y),txt, 'HorizontalAlignment','left','Color','white','FontSize',14);

                                         %64QAM 3/4                 
                                         handles.tput_plot9= tput_plot(x,y,tput_distance(9) ,handles.map);
                                         txt = ['\rightarrow'  num2str(phy_tput_frame(9)) ' Mbps'];
                                         handles.tput_text9 = text((x+tput_distance(9)),(y),txt, 'HorizontalAlignment','left','Color','white','FontSize',14);

                                         %64QAM 5/6                 
                                         handles.tput_plot10= tput_plot(x,y,tput_distance(10) ,handles.map);
                                         txt = ['\rightarrow'  num2str(phy_tput_frame(10)) ' Mbps'];
                                         handles.tput_text10 = text((x+tput_distance(10)),(y),txt, 'HorizontalAlignment','left','Color','white','FontSize',14);


 