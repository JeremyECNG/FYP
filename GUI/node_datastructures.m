%% Node Config
%node name
node_name = string.empty;

%node type
node_type = 0;

%node location
node_location.lati = 0;
node_location.longi = 0;

%equipment parameters 
equipment_params.technology = string.empty;
equipment_params.noise_fig = 0;
equipment_params.tx_pwr = 0;
equipment_params.rx_pwr = 0;
equipment_params.tx_ant_gain = 0;
equipment_params.rx_ant_gain = 0;
equipment_params.tx_cable_loss = 0;
equipment_params.rx_cable_loss = 0;


%%node configuration 
node_con.node_name  = node_name ;
node_con.node_type  = node_type ;
node_con.node_location = node_location;
node_con.equipment_params = equipment_params;