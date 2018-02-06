
%%
field = struct('test1',{},'test2',{},'test3',{});

field(1).test1 = {1,2,2}

%%
testcntr = 0;

for ind = 0:10
    

        testcntr = testcntr + 1;

        %Node Name
        node_con(testcntr).node_name = num2str(testcntr);

        %Node Type
        node_con(testcntr).node_type = num2str(testcntr);

        %Node Location 

        node_con(testcntr).node_location.placement_type = num2str(testcntr);

        node_con(testcntr).node_location.lati = testcntr;

        node_con(testcntr).node_location.longi = testcntr;

        %Equipment Paramters
        node_con(testcntr).equipment_params.technology = num2str(testcntr);

        node_con(testcntr).equipment_params.noise_fig = testcntr;

        node_con(testcntr).equipment_params.tx_pwr = testcntr;

        node_con(testcntr).equipment_params.rx_pwr = testcntr;

        node_con(testcntr).equipment_params.tx_ant_gain = testcntr;

        node_con(testcntr).equipment_params.rx_ant_gain = testcntr;

        node_con(testcntr).equipment_params.tx_cable_loss = testcntr;

        node_con(testcntr).equipment_params.rx_cable_loss = testcntr;

end

%%
%Node Name
setappdata(0,'node_name',string.empty);

%Node Location 
    
setappdata(0,'lat_itude',double.empty);

setappdata(0,'long_itude',double.empty);

%Equipment Paramters
setappdata(0,'node_tech',string.empty);

setappdata(0,'noise_fig',double.empty);

setappdata(0,'tx_power',double.empty);

setappdata(0,'rx_power',double.empty);

setappdata(0,'txant_gain',double.empty);

setappdata(0,'rxant_gain',double.empty);

setappdata(0,'txcab_loss',double.empty);

setappdata(0,'rxcab_loss',double.empty);

%%

%Link Name
sav_link_con.link_name = getappdata(0,'link_nam');

%Link Technology
sav_link_con.technology = getappdata(0,'link_tech');

%Link Node Selections
sav_link_con.node_selection.node1 = getappdata(0,'node_one');

sav_link_con.node_selection.node2 = getappdata(0,'node_two');

%Link System Paramters
sav_link_con.system_params.mod_sch = getappdata(0,'link_modsch');

sav_link_con.system_params.code_rate = getappdata(0,'link_coding');

sav_link_con.system_params.link_direction = getappdata(0,'link_direc');

if strcmp('Downlink',sav_link_con.system_params.link_direction)
    
    sav_link_con.system_params.freq = getappdata(0,'link_downfreq');
    
else
    
    sav_link_con.system_params.freq = getappdata(0,'link_upfreq');
    
end

%Link Channel Parameters
sav_link_con.channel.path_loss_model = getappdata(0,'link_pl');

sav_link_con.channel.fading_margin = getappdata(0,'link_fading');

sav_link_con.channel.interference_margin = getappdata(0,'link_interf');

%Link Receiver Paramters
sav_link_con.receiver.temperature = getappdata(0,'link_temp');

sav_link_con.receiver.rx_bandwidth = getappdata(0,'link_rxbw');


%%

function savelink(sav_link_con)


save_counter_link = getappdata(0, 'linksavecounter');

if exist('linksave.mat')
    load('linksave.mat')
    if exist('save_ind_link')
        save_counter_link = save_ind_link;
    end
end
save_counter_link = save_counter_link + 1;

%Saving Index
save_ind_link = save_counter_link;

%Link Name
link_con(save_counter_link).link_name = sav_link_con.link_name;

%Link Technology
link_con(save_counter_link).technology = sav_link_con.technology;

%Link Node Selections
link_con(save_counter_link).node_selection.node1 = sav_link_con.node_selection.node1;

link_con(save_counter_link).node_selection.node2 = sav_link_con.node_selection.node2;

%Link System Paramters
link_con(save_counter_link).system_params.mod_sch = sav_link_con.system_params.mod_sch;

link_con(save_counter_link).system_params.code_rate = sav_link_con.system_params.code_rate;

link_con(save_counter_link).system_params.link_direction = sav_link_con.system_params.link_direction;

    
link_con(save_counter_link).system_params.freq = sav_link_con.system_params.freq;
    


%Link Channel Parameters
link_con(save_counter_link).channel.path_loss_model = sav_link_con.channel.path_loss_model;

link_con(save_counter_link).channel.fading_margin = sav_link_con.channel.fading_margin ;

link_con(save_counter_link).channel.interference_margin = sav_link_con.channel.interference_margin;

%Link Receiver Paramters
link_con(save_counter_link).receiver.temperature = sav_link_con.receiver.temperature;

link_con(save_counter_link).receiver.rx_bandwidth = sav_link_con.receiver.rx_bandwidth;




save('linksave.mat','link_con','save_ind_link')