freq = 1910;
range = 1000;
ht = 2;
hr = 30;
lambda = physconst('LightSpeed')/(freq*10^6);

%FSPL
FSPL = 20*log10(range*10^-3)+ 20*log10(freq)+32.44; % f(MHz)  & d(km)

%Sea Radio-Wave Propagation Loss
PL_0 = FSPL;
PL_1 = 10*log10(4*sin((2*pi*hr*ht)/(lambda*range))^2);
PL_boat = 10;
PL_earth = 0;
alpha = 5;
PL_sea_path = PL_0 + PL_1 + PL_boat + PL_earth + alpha;


%2-Ray Path Loss
L2_ray = -10*log10(((lambda/(4*pi*range))^2)*(2*sin((2*pi*hr*ht)/(lambda*range)))^2);

%3-Ray Path Loss
d_break = (4*hr*ht)/lambda;

if (range < d_break || range == d_break)
    
    L3_ray = -10*log10(((lambda/(4*pi*range))^2)*(2*sin((2*pi*hr*ht)/(lambda*range)))^2);

elseif (range > d_break)
   
    delta = 2*sin((2*pi*hr*ht)/(lambda*range)) *2*sin((2*pi*(he-hr)*(he-ht))/(lambda*range));
    L3_ray = -10*log10(((lambda/(4*pi*range))^2)*(2*(1+delta))^2);    
end

%%
freq = 1910;
PL = 90;
ht = 2;
hr = 30;
lambda = physconst('LightSpeed')/(freq*10^6);

const1 = (2*pi*sqrt(10^-(PL/10)))/lambda;
const2 = (2*pi*ht*hr)/lambda;

PL_sea_path = PL;
PL_boat = 10;
PL_earth = 0;
alpha = 5;
const5 = PL_sea_path - PL_boat - PL_earth - alpha -32.44-20*log10(freq)-20*log10(10^-3);
const3 = const2;
const4 = (10^(const5/10))/4;

%FSPL
range_fspl = 10^((PL-20*log10(freq)-32.44)/20) 

%range_2ray = sqrt(((-(((2*pi*ht*hr)/lambda)^2)+((ht*hr)/sqrt(10^-(PL/10)))*sqrt(((2*pi*ht*hr)/lambda)^2)*(((2*pi*sqrt(10^-(PL/10)))/lambda)^2)+4))/2)
range_2ray_1 = sqrt((-((const2)^2)+(const2/const1)*sqrt((((const2)^2)*((const1)^2))+4))/2)
%range_2ray_2 = sqrt((-((const2)^2)-(const2/const1)*sqrt((((const2)^2)*((const1)^2))+4))/2)

%Sea Radio-Wave Propagation Loss
 range_SRWPL = (2*const3)/acos(const4/const3);

