%% Datastructure Creation 

%% Node Config
%node name
node_name = string.empty;

%node type
node_type = 0;

%node location
node_location.lati = 0;
node_location.longi = 0;

%equipment parameters 
equipment_params.noise_fig = 0;
equipment_params.tx_pwr = 0;
equipment_params.rx_pwr = 0;
equipment_params.tx_ant_gain = 0;
equipment_params.rx_ant_gain = 0;
equipment_params.tx_cable_loss = 0;
equipment_params.tx_cable_loss = 0;

%%node configuration 
node_con.node_name  = node_name ;
node_con.node_type  = node_type ;
node_con.node_location = node_location;
node_con.equipment_params = equipment_params;

%% Link Config

%node selection 
node_sel.node1 = string.empty;
node_sel.node2 = string.empty;

%techology
technology = string.empty; 

%service
service.serv = string.empty; 
service.ber = 0; 

%system paramters
sys_params.mod_sch = string.empty;
sys_params.code_rate = 0;
sys_params.down_freq = 0;
sys_params.up_freq = 0;

%channel
channel.plm = string.empty; 
channel.fading = string.empty; 
channel.interference = string.empty; 

%receiver
receiver.termp = 0;
receiver.bandwidth = 0;

%% Range

%range type 
node

%%
field = 'blah'
value = 1:50;

test = struct(field, value);

%% 
% field1 = 'Name';
% field2 = 'Lat';
% field3 = 'Lon';
% field4 = 'Height'; %change to tower height
% field5 = 'Elev';
% field6 = 'AntennaHeight';

% value1 = string.empty(0,732);
%  for v1 = 1:732
%  value1(v1) = TNT(v1).Name;
%  end
%  
% value2 = zeros(1,732);
% value2 = lati;
% 
% value3 = zeros(1,732);
% value3 = longi;
% 
% value4 = zeros(1,732); %execute assignments more efficiently 
% value4 = tower_height;
% 
% value5 = zeros(1,732);
% for v5 = 1:732
%  value5(v5) = round(elev_info(v5).results.elevation);
% end
% 
% value6 = zeros(1,732);
% for v6 = 1:732
%  value6(v6) = round(ant_height(v6));
% end
 
% %tower = struct(field1,value1,field2,value2,field3,value3,field4,value4,field5,value5,field6,value6);
% %use airport code or UN standard for naming
% for ss = 1:732
%     tower_tnt(ss).Name = value1(ss);
%     tower_tnt(ss).Lat = value2(ss);
%     tower_tnt(ss).Lon = value3(ss);
%     tower_tnt(ss).Height = value4(ss);
%     tower_tnt(ss).Elev = value5(ss);
%     tower_tnt(ss).AntennaHeight = value6(ss);
%     tower_tnt(ss).Geometry = 'Point';
%     
% end
% 
% tower_calc = struct(field1,value1,field2,value2,field3,value3,field4,value4,field5,value5,field6,value6);